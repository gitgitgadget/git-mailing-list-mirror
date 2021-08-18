Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836ACC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 09:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CDA560C3E
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 09:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhHRJwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhHRJwS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 05:52:18 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A45C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 02:51:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f13-20020a1c6a0d000000b002e6fd0b0b3fso2325227wmc.3
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 02:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6LElHg6vvnF7hnpzsQsvbBPaofUj1QBw5zGsrYcgusg=;
        b=Z9PPVqGz+cfU9y4vouG+jFIL8nFEE9UNvS7SIzNQkmonR0iHbr0sTQhakUAtgRLK5B
         /qM+DPh/SZJ81b7H7d2ib5xkoA2D9KPRMkFmWb1kl/ADkyuolTA2ZfPuCIQzOMJUL2II
         50pqrO5AWso/Aae0j5OOc4lpwmGVC89XfEhjIX32pqqvxJ4IJXFM23fVeOqOkuND2oWX
         9z0SX+Bbr5SOmNSAT6V0twI3F2DFi9ZfJf6fiFxh5OwEYaRVpePNnMRJz2OTxmLh4ohy
         avkJMnGntPEUS2hm7ykztqmIvj80l6zbgsdANQZpUP/1qK2+JbN7WldJetTUlzS6cwdm
         i4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6LElHg6vvnF7hnpzsQsvbBPaofUj1QBw5zGsrYcgusg=;
        b=WS58FURwMEGeIfV+c007uxIeF+QTD6jLdC7H6KBVWqnPmZHqnDcNP5nn5+GiAn51+3
         eBVqtPX7/hiuYb/btV/zJj4p1iKAkddToGCVI+Ts56RC3WUBzhI9D1fPRSUyavOXql7u
         fnZpOjFyyHpbmfnLKIX6bMF84ZfwqqmuX8AWckI4jmSmMRqaQpnswjfHyTrVS08sEucS
         yFQ/BZeuqNHawfEONrlJkhbvgUjKQSuTfp7408duWSXEKukBc/ueJ9IKLx5qtHVgpdNQ
         ALG/jkW8gha/P+heMemcvMS3k5DtJxxAmw2qDvTI0FzRMv8isC1qA9zL157NI3ZqcOh7
         FFAA==
X-Gm-Message-State: AOAM533zMSjvzqMWrqihR59/xcZKUGl+4QWpIrcD8Mei27jvXlijzWJe
        O91ookimogMDVk5sijQ3Sms=
X-Google-Smtp-Source: ABdhPJwMX9EgSJl0c2JNMKic2vWGUQWMZKD5Yj3g7HwMTNnwDT3WuKuQDmbEJkJ9hhoq9tbfO4ydyQ==
X-Received: by 2002:a05:600c:4f47:: with SMTP id m7mr7532640wmq.142.1629280302304;
        Wed, 18 Aug 2021 02:51:42 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id h11sm5495745wmc.23.2021.08.18.02.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 02:51:41 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5] [GSOC] cherry-pick: use better advice message
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1010.v4.git.1628936863733.gitgitgadget@gmail.com>
 <pull.1010.v5.git.1629075306706.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <dcccd4af-e8b1-31e2-f271-4161ec4853d0@gmail.com>
Date:   Wed, 18 Aug 2021 10:51:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.1010.v5.git.1629075306706.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/08/2021 01:55, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> [...]
>   sequencer.c                     | 16 +++++++++++++++-
>   t/t3501-revert-cherry-pick.sh   | 20 ++++++++++++++++++++
>   t/t3507-cherry-pick-conflict.sh | 17 ++++++++++-------
>   3 files changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 0bec01cf38e..2dd73d24a87 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -403,7 +403,7 @@ static void print_advice(struct repository *r, int show_hint,
>   	char *msg = getenv("GIT_CHERRY_PICK_HELP");
>   
>   	if (msg) {
> -		fprintf(stderr, "%s\n", msg);
> +		advise("%s\n", msg);
>   		/*
>   		 * A conflict has occurred but the porcelain
>   		 * (typically rebase --interactive) wants to take care
> @@ -418,6 +418,20 @@ static void print_advice(struct repository *r, int show_hint,
>   		if (opts->no_commit)
>   			advise(_("after resolving the conflicts, mark the corrected paths\n"
>   				 "with 'git add <paths>' or 'git rm <paths>'"));
> +		else if (opts->action == REPLAY_PICK)
> +			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
> +				 "\"git add/rm <conflicted_files>\", then run\n"
> +				 "\"git cherry-pick --continue\".\n"
> +				 "You can instead skip this commit: run \"git cherry-pick --skip\".\n"
> +				 "To abort and get back to the state before \"git cherry-pick\",\n"
> +				 "run \"git cherry-pick --abort\"."));
> +		else if (opts->action == REPLAY_REVERT)
> +			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
> +				 "\"git add/rm <conflicted_files>\", then run\n"
> +				 "\"git revert --continue\".\n"
> +				 "You can instead skip this commit: run \"git revert --skip\".\n"
> +				 "To abort and get back to the state before \"git revert\",\n"
> +				 "run \"git revert --abort\"."));

Thanks for making the revert advice better as well

>   		else
>   			advise(_("after resolving the conflicts, mark the corrected paths\n"
>   				 "with 'git add <paths>' or 'git rm <paths>'\n"

I think this last else arm should probably be a bug now as anything 
other than cherry-pick or revert should be setting GIT_CHERRY_PICK_HELP

	else
		BUG("unexpected pick action in print_advice()");

> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index 9d100cd1884..6766aed7282 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -158,4 +158,24 @@ test_expect_success 'cherry-pick works with dirty renamed file' '
>   	grep -q "^modified$" renamed
>   '
>   
> +test_expect_success 'advice from failed revert' '
> +	echo dream >dream &&
> +	git add dream &&
> +	git commit -m "add dream" &&

A minor comment: you can condense these three lines by using test_commit 
(see test-lib-functions.sh for the documentation)

	test_commit "add dream" dream dream

> +	dream_oid=$(git rev-parse --short HEAD) &&
> +	cat <<-EOF >expected &&
> +	error: could not revert $dream_oid... add dream
> +	hint: Resolve all conflicts manually, mark them as resolved with
> +	hint: "git add/rm <conflicted_files>", then run
> +	hint: "git revert --continue".
> +	hint: You can instead skip this commit: run "git revert --skip".
> +	hint: To abort and get back to the state before "git revert",
> +	hint: run "git revert --abort".
> +	EOF
> +	echo dream >>dream &&
> +	git add dream &&
> +	git commit -m "double-add dream" &&

test_commit can also append to a file

	test_commit --append "double-add dream" dream dream

This is looking very close to being ready now I think

Thanks

Phillip

> +	test_must_fail git revert HEAD^ 2>actual &&
> +	test_cmp expected actual
> +'
>   test_done
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 014001b8f32..cb2ebea9ad3 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -47,20 +47,23 @@ test_expect_success 'failed cherry-pick does not advance HEAD' '
>   	test "$head" = "$newhead"
>   '
>   
> -test_expect_success 'advice from failed cherry-pick' "
> +test_expect_success 'advice from failed cherry-pick' '
>   	pristine_detach initial &&
>   
> -	picked=\$(git rev-parse --short picked) &&
> +	picked=$(git rev-parse --short picked) &&
>   	cat <<-EOF >expected &&
> -	error: could not apply \$picked... picked
> -	hint: after resolving the conflicts, mark the corrected paths
> -	hint: with 'git add <paths>' or 'git rm <paths>'
> -	hint: and commit the result with 'git commit'
> +	error: could not apply $picked... picked
> +	hint: Resolve all conflicts manually, mark them as resolved with
> +	hint: "git add/rm <conflicted_files>", then run
> +	hint: "git cherry-pick --continue".
> +	hint: You can instead skip this commit: run "git cherry-pick --skip".
> +	hint: To abort and get back to the state before "git cherry-pick",
> +	hint: run "git cherry-pick --abort".
>   	EOF
>   	test_must_fail git cherry-pick picked 2>actual &&
>   
>   	test_cmp expected actual
> -"
> +'
>   
>   test_expect_success 'advice from failed cherry-pick --no-commit' "
>   	pristine_detach initial &&
> 
> base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
> 

