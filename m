Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFF618C7B2
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363699; cv=none; b=IDlEwtd1OdJR/OG2k/3NYgJMiqMLtD5ZvHfldq31G0Rg54lo4ymuVKkxau2ZEAGpiD+tX54qxAgy1Qo8I/iWMILo34hYRhsnj5UWOD6fbWQ1A0MJqJ3mnua31V4+WIwTgpd33JzJUlVxI93B7jD3I5dZBj684jUm8g0dfWJquS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363699; c=relaxed/simple;
	bh=lkfrIlplNqqB7v/k+L8Wpt+yZL3o2RsVCBFYK458uFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Et2on40gqa8ERkFTBJqXaPpZdlGLAkO1ryt7WIMHUUWQC03LrpgiJxJu0Cbn1fYjNLVZa1ozsjFEsltI8xHQS4UKs1SLmdAnTGgEcjxDMKR8riRcB5jm6VfbndVHdcIxo59rBZfMt816WkDOgFHaQ05LcpHZijkeHHy75tLR8bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRYufMhu; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRYufMhu"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d52e65d4a8so56193031fa.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 03:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711363694; x=1711968494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G/ZEycnrAWB+rhiLSG/D+x4CAWnfUL7uwxKsvwd6F0U=;
        b=gRYufMhuZahTqKTuZ/3LKXK2RgEJe/9uQsQ/h1elppvo4CowKzPBodZSr6RKTTg0np
         BkYxWep7M6sZ9xC/Q/HZYZnu8QBzdw71NB6gvwUNZ7LBsh+QMZCIjdVU3iOPLElMHcVK
         1iKnCeIpyCCmCXY7VBVQI3B6WOGf0sv79DUw553ak73Rx1TkYMw6fD2x7LAvpgDjArlZ
         wehU/C/FzhdvXxZ6PDZFPViArovwNVAZUITfH27lGO0SLOR6AcjBh+9C8OS/sZEG/0z/
         R4B0qsPwVUakxsaRT3Rhvh+IgLIP6v5mPVDFSZekiO/QBYTJgsyUZG/qGxLLtxVTf6d9
         ix/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711363694; x=1711968494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/ZEycnrAWB+rhiLSG/D+x4CAWnfUL7uwxKsvwd6F0U=;
        b=MflVxbTEsv1PocXU8BO46mnTdiAG6tlEQVADuF5gKddfgeDpJS5qzi1OEyZQukpnpc
         jBTIjD0ccyI5fs0L3+2fwg2RY3T1KxiAi9NeMMffrEaQAflN0DFmd6rh4R7fywAgLIpy
         MjhV2wthqUvpjXwsULwBR2uqtp4pa5qNy5NhSCBFhk/8cBZ7OCk6QjUtIkoBOJQUQ05S
         jdD4PnHH23iYMkstu/U8Qz/kQ4+eB4Jn30oGhgG6DHDqclSb2igZcj1KrhBcB1IiqqxA
         Y9jlwAq2eCU29SGPEBH62C1j/YcH7JAKXQKPSH8e2m05+7w7mML5Y2OjjRVAk4Pzy0vq
         pr2A==
X-Forwarded-Encrypted: i=1; AJvYcCXP0MHfHiTLSCigLkLI3X+a+5Vi/Yxi4ZB+uNyKwMkS7esNl1GRLKkGnBPXjVx/J3/hNMSgqa/bwim9JWx67vbfsjg7
X-Gm-Message-State: AOJu0Ywv86nSZVg8N+alDw+aExGcs+j5KBfIhIvXgQqCQ7iQ+OCn0DtK
	OObrr35zdFI85yoULB92VRiR7wzjGgtSvYmgxfKHE9w/lpkfI0fxDvsPAir2
X-Google-Smtp-Source: AGHT+IEr3jPdgUFP3v9GZVxr33srmXIK7YzE0/i5yU9YKzJRvxK5Mf6b9HkZ2f8kMOtoq8lMm6xm+Q==
X-Received: by 2002:a2e:b00a:0:b0:2d6:b11a:3a49 with SMTP id y10-20020a2eb00a000000b002d6b11a3a49mr4289912ljk.9.1711363693532;
        Mon, 25 Mar 2024 03:48:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:d2c6:37ff:fef6:7b1? ([2a0a:ef40:6a5:fd01:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id v6-20020a05600c470600b00414896bb1e0sm3181618wmo.36.2024.03.25.03.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 03:48:13 -0700 (PDT)
Message-ID: <e040c631-42d9-4501-a7b8-046f8dac6309@gmail.com>
Date: Mon, 25 Mar 2024 10:48:12 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/2] Allow disabling advice shown after merge conflicts
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 ZheNing Hu <adlternative@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
 <pull.1682.v3.git.1710623790.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1682.v3.git.1710623790.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Philippe

On 16/03/2024 21:16, Philippe Blain via GitGitGadget wrote:
> Changes since v2:
> 
>   * expanded the commit messages to explain why the tests for 'git rebase' do
>     not need to be adjusted
>   * adjusted the wording of the new 'advice.mergeConflict' in the doc, as
>     suggested by Kristoffer for uniformity with his series which is already
>     merged to 'master' (b09a8839a4 (Merge branch
>     'kh/branch-ref-syntax-advice', 2024-03-15)).
>   * checked all new output manually and consequently adjusted the code in 1/2
>     to avoid a lonely 'hint: ' line.
>   * adjusted the addition in advice.h in 1/2 to put the new enum
>     alphabetically, as noticed by Rubén.
>   * added misssing newlines in 2/2 as noticed by Phillip and tweaked by
>     Junio.
>   * rebased on master (2953d95d40 (The eighth batch, 2024-03-15)), to avoid
>     conflicts in 'Documentation/config/advice.txt' due to Kristoffer's merged >     series
> [...] 
> Note that the code path where 'git rebase --apply' stops because of
> conflicts is not covered by the tests but I tested it manually using this
> diff:
> 
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 47534f1062..34eac2e6f4 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -374,7 +374,7 @@ test_pull_autostash_fail ()
>       echo conflicting >>seq.txt &&
>       test_tick &&
>       git commit -m "Create conflict" seq.txt &&
> -	test_must_fail git pull --rebase . seq 2>err >out &&
> +	test_must_fail git -c rebase.backend=apply pull --rebase . seq 2>err >out &&
>       test_grep "Resolve all conflicts manually" err
>   '

Thanks for being so thorough, this version looks good to me

Best Wishes

Phillip

> 
> Philippe Blain (2):
>    sequencer: allow disabling conflict advice
>    builtin/am: allow disabling conflict advice
> 
>   Documentation/config/advice.txt |  2 ++
>   advice.c                        |  1 +
>   advice.h                        |  1 +
>   builtin/am.c                    | 14 +++++++++-----
>   sequencer.c                     | 33 ++++++++++++++++++---------------
>   t/t3501-revert-cherry-pick.sh   |  1 +
>   t/t3507-cherry-pick-conflict.sh |  2 ++
>   t/t4150-am.sh                   |  8 ++++----
>   t/t4254-am-corrupt.sh           |  2 +-
>   9 files changed, 39 insertions(+), 25 deletions(-)
> 
> 
> base-commit: 2953d95d402b6bff1a59c4712f4d46f1b9ea137f
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1682%2Fphil-blain%2Fsequencer-conflict-advice-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1682/phil-blain/sequencer-conflict-advice-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1682
> 
> Range-diff vs v2:
> 
>   1:  a2ce6fd24c2 ! 1:  6005c1e9890 sequencer: allow disabling conflict advice
>       @@ Commit message
>            merge conflict through a new config 'advice.mergeConflict', which is
>            named generically such that it can be used by other commands eventually.
>        
>       +    Remove that final '\n' in the first hunk in sequencer.c to avoid an
>       +    otherwise empty 'hint: ' line before the line 'hint: Disable this
>       +    message with "git config advice.mergeConflict false"' which is
>       +    automatically added by 'advise_if_enabled'.
>       +
>            Note that we use 'advise_if_enabled' for each message in the second hunk
>            in sequencer.c, instead of using 'if (show_hints &&
>            advice_enabled(...)', because the former instructs the user how to
>       @@ Commit message
>        
>            Update the tests accordingly. Note that the body of the second test in
>            t3507-cherry-pick-conflict.sh is enclosed in double quotes, so we must
>       -    escape them in the added line.
>       +    escape them in the added line. Note that t5520-pull.sh, which checks
>       +    that we display the advice for 'git rebase' (via 'git pull --rebase')
>       +    does not have to be updated because it only greps for a specific line in
>       +    the advice message.
>        
>            Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>        
>         ## Documentation/config/advice.txt ##
>        @@ Documentation/config/advice.txt: advice.*::
>       - 		Advice on how to set your identity configuration when
>       - 		your information is guessed from the system username and
>       - 		domain name.
>       + 		Shown when the user's information is guessed from the
>       + 		system username and domain name, to tell the user how to
>       + 		set their identity configuration.
>        +	mergeConflict::
>       -+		Advice shown when various commands stop because of conflicts.
>       ++		Shown when various commands stop because of conflicts.
>         	nestedTag::
>       - 		Advice shown if a user attempts to recursively tag a tag object.
>       + 		Shown when a user attempts to recursively tag a tag object.
>         	pushAlreadyExists::
>        
>         ## advice.c ##
>       @@ advice.c: static struct {
>        
>         ## advice.h ##
>        @@ advice.h: enum advice_type {
>       + 	ADVICE_GRAFT_FILE_DEPRECATED,
>         	ADVICE_IGNORED_HOOK,
>         	ADVICE_IMPLICIT_IDENTITY,
>       - 	ADVICE_NESTED_TAG,
>        +	ADVICE_MERGE_CONFLICT,
>       + 	ADVICE_NESTED_TAG,
>         	ADVICE_OBJECT_NAME_WARNING,
>         	ADVICE_PUSH_ALREADY_EXISTS,
>       - 	ADVICE_PUSH_FETCH_FIRST,
>        
>         ## sequencer.c ##
>        @@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
>       @@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
>         
>         	if (msg) {
>        -		advise("%s\n", msg);
>       -+		advise_if_enabled(ADVICE_MERGE_CONFLICT, "%s\n", msg);
>       ++		advise_if_enabled(ADVICE_MERGE_CONFLICT, "%s", msg);
>         		/*
>         		 * A conflict has occurred but the porcelain
>         		 * (typically rebase --interactive) wants to take care
>   2:  3235542cc6f ! 2:  73d07c8b6a7 builtin/am: allow disabling conflict advice
>       @@ Commit message
>            on stderr instead of stdout. In t4150, redirect stdout to 'out' and
>            stderr to 'err', since this is less confusing. In t4254, as we are
>            testing a specific failure mode of 'git am', simply disable the advice.
>       +    Note that we are not testing that this advice is shown in 'git rebase'
>       +    for the apply backend since 2ac0d6273f (rebase: change the default
>       +    backend from "am" to "merge", 2020-02-15).
>        
>       +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>       +    Helped-by: Junio C Hamano <gitster@pobox.com>
>            Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>        
>         ## builtin/am.c ##
>       @@ builtin/am.c: static const char *msgnum(const struct am_state *state)
>         
>        -		printf_ln(_("When you have resolved this problem, run \"%s --continue\"."), cmdline);
>        -		printf_ln(_("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
>       -+		strbuf_addf(&sb, _("When you have resolved this problem, run \"%s --continue\"."), cmdline);
>       -+		strbuf_addf(&sb, _("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
>       ++		strbuf_addf(&sb, _("When you have resolved this problem, run \"%s --continue\".\n"), cmdline);
>       ++		strbuf_addf(&sb, _("If you prefer to skip this patch, run \"%s --skip\" instead.\n"), cmdline);
>         
>         		if (advice_enabled(ADVICE_AM_WORK_DIR) &&
>         		    is_empty_or_missing_file(am_path(state, "patch")) &&
>         		    !repo_index_has_changes(the_repository, NULL, NULL))
>        -			printf_ln(_("To record the empty patch as an empty commit, run \"%s --allow-empty\"."), cmdline);
>       -+			strbuf_addf(&sb, _("To record the empty patch as an empty commit, run \"%s --allow-empty\"."), cmdline);
>       ++			strbuf_addf(&sb, _("To record the empty patch as an empty commit, run \"%s --allow-empty\".\n"), cmdline);
>         
>        -		printf_ln(_("To restore the original branch and stop patching, run \"%s --abort\"."), cmdline);
>        +		strbuf_addf(&sb, _("To restore the original branch and stop patching, run \"%s --abort\"."), cmdline);
> 

