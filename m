Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB61E1023
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435488; cv=none; b=PG0PiGgWeojaqXFQLt9LBXXIxK0vz/u8OyrpRqFq0V3gFiaojaEqL7KiZF7xEn0bGNmvJUSrNlDtYGrYiAE5rTc6fIWaI97vuUsVNMwD5BqyBtVCl+uewc1IPIfH1Jbi/pwmujxEEIUk1R+rwu7W+fJPvEz/0nwgSsql6scujas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435488; c=relaxed/simple;
	bh=HjxNuJG9VM0Huag0ZPl4SosN1d2t+atVGN7B8F9lUdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9yYoEFdRdKTTbtk/tXfgD309Rf/3XG4v5e2DYICC83xLU91WoY53j/HqlI5OmrbzwW7dabgHasv2sqkKHCJUMVM0GBsRjJksweAZLYARau15s2GMs1u2TJWNTRsO6dcZeeXuVRjQIDMe8wzodamMCZuunwBOm9vpTEUkQ/q3mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFhhJwE0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFhhJwE0"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso4433243f8f.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743435485; x=1744040285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PLnXzrHYlovYo4ciVMrFnVNXKwhW8gJTnTd4flU3q3c=;
        b=hFhhJwE0oWo7nIIRsUQbjYzV0R4dllGxKlR/QarR2bJTmcgJPZrIdZN/CCidXCkz4y
         kspafn515rihD+0Qoh7VREfTn7lKtFqZ3ZReVB4eTmi3d+C/2FBo2/4MBB8Gkv2Mmq2r
         kwNRQDbrAaOEQj4ArmkGdyyhqbc9skRlWSHKun5htraH9nnybxcXNxFJlGUra5tDrzgC
         axAeIn/pO/bxYTpB7Mjtfh1oJvzF/Ml/s2DqZZZuA18SLqgKajHFx0CzX7pX7vn5/Et2
         Pg8jIA5I0QiioX76UqjUGYlbl3JlCVgu/ykIJ0miLXkrgQct+Xp6vxOgvMNjsO8HWxYt
         gkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743435485; x=1744040285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLnXzrHYlovYo4ciVMrFnVNXKwhW8gJTnTd4flU3q3c=;
        b=V58NleZLwRaBxwqAZ6e5/D/uNyOhr6RYppw/OFdI3PZ1sHpYBTfPnvJRtKxAQdNhv2
         LVFmzJ/SdyXxuln4NOeSkc2PrpN+0qPsQ7FUeiR3GAfqDjlaKKkO2OyV4XPedRoqhFUq
         OyfzGL6XS1DzqCTHclqSs91L+s1tfq7evj4vGTPlBOs+qH4DXoVAwRtEQPj+wKhwMGW1
         t3gh4L3higGSApF+QgLEyziIJM4ZIEbOQclgUqzWaYYWRbGW0+o1E3X2OlM4iDZCjOrk
         1oLlPQJeGRTQFXHSbEeG1wYBZpa7MssngIMcqbMmhy/6wfJyVytRuuU3UesFqeZW0TBy
         hGEA==
X-Forwarded-Encrypted: i=1; AJvYcCVDV0TxqAm41qxW9asSKV/980hma5jj4zbO2itIFtFL9WzQ3kTaw8bjbY0jVf4xQn3AvLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDfVCfSpAsSM3AT/VTyJ7xyxC0bmlfZZpBF7gGqetpW3pqfFnr
	LMUuHnm8jugKmawih1D9aJQj0RdYUkxPtjc5yhfpag4N/s3XR2+R
X-Gm-Gg: ASbGncu9lph81HqHgYAPsIjud8/0iDt41mL3uc/uXXbnjbYHu14ucDRh2sAv4JeiA7n
	CHCPgg5Kv/6pyFijNiOwZDEgvraj6BmnYWRV+xxSxYyGPaq3gmc3zKs/njT+zJZUaFrwZdXDfr8
	WUMPlumIQ847QcjxylMGS5K/sLClZTo5blmsdz6tu3s0zOeZo/QFFnRxDWoOp/2NJ3ARUPKxMMi
	AOFoSpQaVCdkesk11G1CTperqjUFX8uEgb7TxejXCn9q3PKRnZlQqi1JOw/FUIQ/u4XOnKH8INz
	fAmuSyucdmHuE8GsXLBbNkg9fsN3uQiqImARO7ya1/17JK1j0W+ZeDXvBsnVe78oZSvM+XbXXZT
	dsvcIb0AbMY3VR17LcYt55LAVBJxeoUE=
X-Google-Smtp-Source: AGHT+IGrZLbJbHLtCLQSmuxufJ783jVMvmn/nHUyyFYSym5+QHvPtI0OkCgOWHyT59773kADLwmO4g==
X-Received: by 2002:a05:6000:2805:b0:391:4c0c:c807 with SMTP id ffacd0b85a97d-39c1211d8f8mr6259357f8f.53.1743435484781;
        Mon, 31 Mar 2025 08:38:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b658ac5sm11349634f8f.1.2025.03.31.08.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 08:38:04 -0700 (PDT)
Message-ID: <f0d1f0ba-84ab-4914-9dd1-81a5d2e0dbc3@gmail.com>
Date: Mon, 31 Mar 2025 16:38:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] wt-status: suggest 'git rebase --continue' to
 conclude 'merge' instruction
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
 <db01acdd062a17b1cca62428eba8c3ed62ca7c6a.1743181401.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <db01acdd062a17b1cca62428eba8c3ed62ca7c6a.1743181401.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Philippe

On 28/03/2025 17:03, Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> Since 982288e9bd (status: rebase and merge can be in progress at the
> same time, 2018-11-12), when a merge is in progress as part of a 'git
> rebase -r' operation, 'wt_longstatus_print_state' shows information
> about the in-progress rebase (via show_rebase_information), and then
> calls 'show_merge_in_progress' to help the user conclude the merge. This
> function suggests using 'git commit' to do so, but this throws away the
> authorship information from the original merge, which is not ideal.
> Using 'git rebase --continue' instead preserves the authorship
> information, since we enter 'sequencer.c:run_git_commit' which calls
> read_env_script to read the author-script file.

Good catch

> Note however that this only works when a merge was scheduled using a
> 'merge' instruction in the rebase todo list. Indeed, when using 'exec
> git merge', the state files necessary for 'git rebase --continue' are
> not present, and one must use 'git commit' (or 'git merge --continue')
> in that case.
> 
> Be more helpful to the user by suggesting either 'git rebase
> --continue', when the merge was scheduled using a 'merge' instruction,
> and 'git commit' otherwise. As such, add a
> 'merge_during_rebase_in_progress' field to 'struct wt_status_state', and
> detect this situation in wt_status_check_rebase by looking at the last
> command done. Adjust wt_longstatus_print_state to check this field and
> suggest 'git rebase --continue' if a merge came from a 'merge'
> instruction, by calling show_rebase_in_progress directly.
> 
> Add two tests for the new behaviour, using 'merge' and 'exec git merge'
> instructions.

Nice, thanks for adding the tests

>   
> +test_expect_success 'status during rebase -ir after conflicted merge (exec git merge)' '
> +	git reset --hard main &&
> +	git checkout -b rebase_i_merge &&
> +	test_commit unrelated &&
> +	git checkout -b rebase_i_merge_side &&
> +	test_commit side2 main.txt &&
> +	git checkout rebase_i_merge &&
> +	test_commit side1 main.txt &&
> +	PICK=$(git rev-parse --short rebase_i_merge) &&
> +	test_must_fail git merge rebase_i_merge_side &&
> +	echo side1 >main.txt &&
> +	git add main.txt &&
> +	test_tick &&
> +	git commit --no-edit &&
> +	MERGE=$(git rev-parse --short rebase_i_merge) &&
> +	ONTO=$(git rev-parse --short main) &&
> +	test_when_finished "git rebase --abort" &&
> +	FAKE_LINES="1 2 3 5 6 7 8 9 10 exec_git_merge_refs/rewritten/rebase-i-merge-side" &&
> +	export FAKE_LINES &&
> +	test_must_fail git rebase -ir main &&

As with the other patch this should be

	test_must_fail env FAKE_LINES=... git rebase ...

and the same for the test below. These tests show just how opaque the 
FAKE_LINES mechanism is - I've got no idea what it's doing. If it is not 
too much work it might be worth writing out the desired todo list to a 
file and using set_replace_editor. If you do that note that you can use 
tag names in the todo list you don't need to get the oid for each commit 
and you probably don't need to rebase the side branch, just the merge.
> @@ -1760,8 +1761,12 @@ int wt_status_check_rebase(const struct worktree *wt,
>   			state->rebase_interactive_in_progress = 1;
>   		else
>   			state->rebase_in_progress = 1;
> +		read_rebase_todolist("rebase-merge/done", &have_done);
> +		if (have_done.nr > 0 && starts_with(have_done.items[have_done.nr - 1].string, "merge"))
> +				state->merge_during_rebase_in_progress = 1;
We already read and parse the done list in show_rebase_information() - 
is it possible to avoid doing that twice by setting this flag there?

>   		state->branch = get_branch(wt, "rebase-merge/head-name");
>   		state->onto = get_branch(wt, "rebase-merge/onto");
> +		string_list_clear(&have_done, 0);
>   	} else
>   		return 0;
>   	return 1;
> @@ -1855,10 +1860,15 @@ static void wt_longstatus_print_state(struct wt_status *s)
>   
>   	if (state->merge_in_progress) {
>   		if (state->rebase_interactive_in_progress) {
> -			show_rebase_information(s, state_color);
> -			fputs("\n", s->fp);
> -		}
> -		show_merge_in_progress(s, state_color);
> +			if (state->merge_during_rebase_in_progress)
> +				show_rebase_in_progress(s, state_color);
> +			else {
> +				show_rebase_information(s, state_color);
> +				fputs("\n", s->fp);
> +				show_merge_in_progress(s, state_color);
> +			}

The indentation here looks strange

Thanks

Phillip

> +		} else
> +			show_merge_in_progress(s, state_color);
>   	} else if (state->am_in_progress)
>   		show_am_in_progress(s, state_color);
>   	else if (state->rebase_in_progress || state->rebase_interactive_in_progress)
> diff --git a/wt-status.h b/wt-status.h
> index 4e377ce62b8..84bedfcd48f 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -87,6 +87,7 @@ struct wt_status_state {
>   	int am_empty_patch;
>   	int rebase_in_progress;
>   	int rebase_interactive_in_progress;
> +	int merge_during_rebase_in_progress;
>   	int cherry_pick_in_progress;
>   	int bisect_in_progress;
>   	int revert_in_progress;

