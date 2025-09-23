Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E8D1EFF80
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641034; cv=none; b=eMEmi0Nn+xm2+CxUNPVdUBZ8zDUoDZo+vY0cvZiu8yEwk6e/N5PDGmd53S4ChNJFO6oL4eoBazhxdBoFTTUzAVFszPxR9vv1nbaYkC7oGVn7fOw0CH2ehohblfTTJw7V8F5D0NsqAkXxfrEMSrus3+mI8nESSSgK0ZHXpOf8wCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641034; c=relaxed/simple;
	bh=CSesH3d290vFcdz0pc0YSQt0piMTpwIW5SG8whtnDZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LoNEC98Hfl7IxVztoiasndWqlwSi41ThApEAwdW2Mz+drLvsLyl73c35qt1an2Z7LnZlHZIydvtx/N7BUIyJrT5JA6UZoSnLjzfVbXufM3h8ZbCbTwY+MiKKOSwCHlIuyKxFdk5Z3MVaoUAuB3ZojFLMqp/DYPyhSDfkDtJnZ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZ79fehY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ79fehY"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so4275860f8f.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 08:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758641031; x=1759245831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lQ97CHVxFviCPqqCCuMEAAjsGsGAh++7zDVNDPlYTRw=;
        b=PZ79fehYxSlokB5WT/VKQfMbNa2nuOg4VbSxFuw6b3AmGfd88V4D/V6MHrwthVgNry
         B4vTTU9LhI7TqZcVle5LdrDmDn2DALMMlJmowcbXdImCYh1rWAY6S0+MNU9jxzmUIjW9
         OaEzcxhyELPxD9SM2sENV3pRGrwbI6n11UrRmv9poehJt5iiOoUHAetyh25Bu7+Vw1dC
         rTQmRio4srXfheAjGRzb0SwLsQEQQdDu6kFLl+5KsumvaHdWUMH2nh6ITujvscYNW0bC
         kG77EMooD6oZ6lC/8g8ydZT9nBPaMsJ724QtMK7j7WOBkmN92kvJA+X2XtXDuTwp4RrP
         YKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641031; x=1759245831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQ97CHVxFviCPqqCCuMEAAjsGsGAh++7zDVNDPlYTRw=;
        b=IPqcHoo5Rfigu4MDE24jo5J2E3+SGi+mONNnXAXREShb2asxmNXq1bo203uOrXurKg
         wQQ+dvQOG8v5YkWtaIXJp/gi278vJhy6YEFrd60woNHjhtd7wvlXxvyTZTOtrU5N/vfr
         pVVDAuU+2oXZ1/cYvjJhE/MimFXVUWFQaCfpy58Q08kbJQL3UL7uSQhu6/CHUzGp/PMG
         VLAqnyg2DravTWBInehSDNKaj6zZ/rQ84+UK8UR1C09txKGECndCAtq0Dz4K+sVs+Slb
         8tN58aOPvi6KGEqkdvpJVez7Yuf/dceLPH0gt7zhLAk1EwxiEJLM/mLJbmKBdshZV2VT
         pziA==
X-Forwarded-Encrypted: i=1; AJvYcCWY1K6f4RYY3MJCAerbYA7/SYbZitfvLLlXzTlFs9mPlL3Gk6aLeaRTFFCZVIH/+O68xgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb61WmOCPNm+BfHoHX4CyhOWocJoFwILLy2kYqDwyLeDUdrHQs
	80FbHycPuu0BiBWckOBmg6Opf4FWQ22YQjFDfV5JS6rkZLrrHlcpGxQc
X-Gm-Gg: ASbGncti14rkfVE/WoJFWIQ3dnNxyXtnH6I+U8sXPk+0lQo3XHIPwLVFHwfcI7bktcl
	lHv7TZWL8D3G6v/i+E2ZrHnikexGOwjl3DKR3JJkdoISbNg534u8ijE5BfxxQ4xC9i+zk1Sbfs0
	4tcozgiy7U9uqGrKNFJqOn7wz+gUQyWQqmR2iXPzOocBev0vEMRgOHW4mkkqYNXlSoZ78FxBf10
	q+JC/AXLBIzrxzwmV6IIokExxIrK2yIpF+o+DFFFKLyNBfEOEWXhdRCYgXSdWeQ3lj0WA4XNAj+
	pbWdsuzght3+MCrFpAvclOw5IzY9fjNh26nfzOV1wjFsXt2Lyqy/aXmLwzyUVu+BaugP+Cvhq89
	jMjG3/Q6DhtcaPz4M9d1i3JL+nq9m+SNFiBLtGiXX/q3hvMasAxezdD1/pr6TR5QYPefXuTL4Gg
	c=
X-Google-Smtp-Source: AGHT+IFmX3JBRQYtg2U70t1a7jQMSgmh7bUIwgACjKalp4CWP6DJXXnMwiO+9IKgpJqs6HqPH2KS2g==
X-Received: by 2002:a05:6000:1aca:b0:3ec:dd16:fc16 with SMTP id ffacd0b85a97d-405ca39d48bmr2643477f8f.43.1758641030835;
        Tue, 23 Sep 2025 08:23:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407ccasm24381131f8f.15.2025.09.23.08.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:23:50 -0700 (PDT)
Message-ID: <1635b82d-a3aa-4b83-8d7b-e415945dbd2e@gmail.com>
Date: Tue, 23 Sep 2025 16:23:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: use same commit's message and date with f -C
To: Mathias Rav <m@git.strova.dk>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Karthik Nayak <karthik.188@gmail.com>
References: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mathias

On 23/09/2025 09:55, Mathias Rav wrote:
> In `git rebase -i` with the fixup command, the -C flag controls whether
> the commit message is taken from the previous or current commit,
> but currently the author name, email and date are always taken from the
> previous commit. The fixup command is used to squash two commits where
> one commit has a good message and the other's message does not matter,
> and it is usually also the case that the commit with the good message
> is the one that has the good authorship information; the other is a
> fixup commit that was presumably made by the user moments ago, whereas
> the commit with the good message is the one whose date should be kept.
> > Most of the time, a fixup commit is made on top of the commit to be
> fixed up, in which case the rebase -i fixup command is used without -C.
> The fixup -C case arises when an earlier commit in the branch is split,
> leaving part of the commit to be squashed into a later commit, in which
> case fixup -C would be expected to keep the date on the later commit,
> and discard the author date of the ephemeral newly split commit.

In that case I'd manually squash the later commit into the split commit 
as I don't think you cannot use "rebase --autosquash" to automatically 
squash a fixup commit into one of its descendants. I use "fixup -C" to 
amend and reword existing commits in the same way that I use an ordinary 
"fixup" to amend an existing commit. The only difference is that I'm 
rewording the commit message at the same time as I'm possibly changing 
the commit content. I use "fixup -C" to expanding the commit message, or 
fix typos and want to keep the original commit's authorship as I would 
do if I was not changing the commit message.

I think the difference here is that the design of the "fixup" and 
"squash" commands assumes that they are fixing up an ancestor, not a 
descendant.

Thanks

Phillip
> Change the behavior so that fixup with -C takes both message and author
> from the current commit, instead of taking the author from the previous.
> 
> Tweak try_to_commit to allow specifying author in addition to AMEND_MSG,
> and pass author from the current commit in do_pick_commit in `f -C`.
> 
> Tweak the help text in `git rebase -i` to reflect the changed behavior.
> 
> Add a test that ensures that the author metadata for the second current
> commit is kept, and remove some author metadata checks from other tests
> that now fail since the author metadata is different (as intended).
> 
> Signed-off-by: Mathias Rav <m@git.strova.dk>
> ---
> 
> I described my own workflow for fixup -C above,
> and it's the only use of fixup -C I'm aware of.
> 
> If the current behavior of keeping message from one
> and author from another is useful in someone else's
> workflow, then I'm happy to be enlightened.
> 
> Correct author dates are certainly more nice-to-have
> than need-to-have in most git workflows, but I think
> it's worthwhile to have git go the extra mile here.
> 
>   rebase-interactive.c            |  4 ++--
>   sequencer.c                     |  5 +++--
>   t/t3437-rebase-fixup-options.sh | 15 ++++++++++-----
>   3 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index 809f76a87b..dd303168c2 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -53,8 +53,8 @@ void append_todo_help(int command_count,
>   "s, squash <commit> = use commit, but meld into previous commit\n"
>   "f, fixup [-C | -c] <commit> = like \"squash\" but keep only the previous\n"
>   "                   commit's log message, unless -C is used, in which case\n"
> -"                   keep only this commit's message; -c is same as -C but\n"
> -"                   opens the editor\n"
> +"                   keep this commit's message and date; -c is same as -C\n"
> +"                   but opens the editor\n"
>   "x, exec <command> = run command (the rest of the line) using shell\n"
>   "b, break = stop here (continue rebase later with 'git rebase --continue')\n"
>   "d, drop <commit> = remove commit\n"
> diff --git a/sequencer.c b/sequencer.c
> index aaf2e4df64..80209b6b07 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1560,7 +1560,8 @@ static int try_to_commit(struct repository *r,
>   			strbuf_addstr(msg, orig_message);
>   			hook_commit = "HEAD";
>   		}
> -		author = amend_author = get_author(message);
> +		if (!author)
> +			author = amend_author = get_author(message);
>   		repo_unuse_commit_buffer(r, current_head,
>   					 message);
>   		if (!author) {
> @@ -2419,7 +2420,7 @@ static int do_pick_commit(struct repository *r,
>   			strbuf_addstr(&ctx->message, oid_to_hex(&commit->object.oid));
>   			strbuf_addstr(&ctx->message, ")\n");
>   		}
> -		if (!is_fixup(command))
> +		if (is_fixup_flag(command, item->flags) || !is_fixup(command))
>   			author = get_author(msg.message);
>   	}
>   	ctx->have_message = 1;
> diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
> index 5d306a4769..2361d3fb78 100755
> --- a/t/t3437-rebase-fixup-options.sh
> +++ b/t/t3437-rebase-fixup-options.sh
> @@ -85,6 +85,15 @@ test_expect_success 'simple fixup -C works' '
>   	test_commit_message HEAD -m "A2"
>   '
>   
> +test_expect_success 'fixup -C keeps second commit date' '
> +	test_when_finished "test_might_fail git rebase --abort" &&
> +	git checkout --detach A2 &&
> +	get_author HEAD >expect &&
> +	FAKE_LINES="1 fixup_-C 2" git rebase -i B &&
> +	get_author HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'simple fixup -c works' '
>   	test_when_finished "test_might_fail git rebase --abort" &&
>   	git checkout --detach A2 &&
> @@ -105,9 +114,7 @@ test_expect_success 'fixup -C removes amend! from message' '
>   	FAKE_LINES="1 fixup_-C 2" git rebase -i A &&
>   	test_cmp_rev HEAD^ A &&
>   	test_cmp_rev HEAD^{tree} A1^{tree} &&
> -	test_commit_message HEAD expected-message &&
> -	get_author HEAD >actual-author &&
> -	test_cmp expected-author actual-author
> +	test_commit_message HEAD expected-message
>   '
>   
>   test_expect_success 'fixup -C with conflicts gives correct message' '
> @@ -181,8 +188,6 @@ test_expect_success 'multiple fixup -c opens editor once' '
>   		EXPECT_HEADER_COUNT=4 \
>   		git rebase -i A &&
>   	test_cmp_rev HEAD^ A &&
> -	get_author HEAD >actual-author &&
> -	test_cmp expected-author actual-author &&
>   	test_commit_message HEAD expected-message
>   '
>   

