Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0D3C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 10:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393BC60E9B
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 10:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbhHKKA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 06:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbhHKKA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 06:00:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A801AC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 03:00:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m36-20020a05600c3b24b02902e67543e17aso3470039wms.0
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 03:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=41b7OD5ybERa+ZrrCzQw2HCA3nSzqPLoRq7a3t84swU=;
        b=JcheJTRspLwxppL5KfKQOHGbrwx73Hp7XCfG9eI6K3naqxtPdfc00u/xHWePNUr2S4
         MvUST4kuphmfa66CSnZC/71mXrR7nNa9BYdMWxSlm2bVAg9yShv7ZRbap9jCr+ycNZzp
         bj+V4KppZmFIN5mWLOK8MX7hdqANjdhgZLKvGUpvhvUINs5CdAiN9GuVrV1Csc2f7REh
         KNUVu/azqMeOmhe0IXEf2gi8D9whLqywc/g2st4ZMgJ4de01gI9OettAcC59FThCTo7K
         Ve/JbkCmpq/EKaN5Pl23N/HbPfT9JUrDbEjLAvhJ2+7uTsTYqUTp8XBYEpcgFAlEN8nY
         FieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=41b7OD5ybERa+ZrrCzQw2HCA3nSzqPLoRq7a3t84swU=;
        b=dBSsgMgrp6ko6H2Fq/2/vzvKAm+jo8eKGPcMIpDKzFtx1gm+d/a3QoCzyBpgQHAO7y
         13M/ZDKa3LHC3uRcEh1loTAuhmlQndHBTBipecmJpcQxXmtJR1V7i6LzJsIyYYJ+5bUg
         Hm1O2iPnA370Zc0IuE7lP80aGYXY7gK5b0PlSvLp722VO1+tg6q+Kosn16BPe2QiznYB
         +MGHFTCpf8o3cinPRK3SvqpJUbyZLYVToCL0DcA0jf52h3HR7MwXCmnf1Fj/iLXxr3Eg
         eEZVFKFHPjFy3wWSkki7vI7x5gLObq4csDrMU4XedVWdhcGR8tKj42Me8u/LSEUQK9CZ
         WSDA==
X-Gm-Message-State: AOAM530FPYqTiXTJqmCmJy9i/CkSRTpZDi4gnrFcjjAFceOEpMGRKrCQ
        LTvDwDqSGiULxkX1KWCiFqBvXN5vLnc=
X-Google-Smtp-Source: ABdhPJzzrNLAOnzdm1/boNssSQMczhGnN5OROpA4XFlmHZxKXb32/YQIOYH8QsNrLJIZA2sf6ClmhA==
X-Received: by 2002:a05:600c:1986:: with SMTP id t6mr21872443wmq.49.1628676033580;
        Wed, 11 Aug 2021 03:00:33 -0700 (PDT)
Received: from [192.168.1.201] (188.96.189.80.dyn.plus.net. [80.189.96.188])
        by smtp.googlemail.com with ESMTPSA id z19sm125962wma.0.2021.08.11.03.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 03:00:33 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] [GSOC] cherry-pick: use better advice message
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
References: <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com>
 <pull.1010.v3.git.1628142482640.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a510722c-d5a2-f00c-dd20-dd7f76da2408@gmail.com>
Date:   Wed, 11 Aug 2021 11:00:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.1010.v3.git.1628142482640.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/08/2021 06:48, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> [...]
>   sequencer.c                     | 11 +++++++++--
>   t/t3507-cherry-pick-conflict.sh | 17 ++++++++++++-----
>   2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 0bec01cf38e..7fa91b99870 100644
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
> @@ -415,7 +415,14 @@ static void print_advice(struct repository *r, int show_hint,
>   	}
>   
>   	if (show_hint) {
> -		if (opts->no_commit)
> +		if (opts->action == REPLAY_PICK) {

This changes means we give the wrong advice for 'git cherry-pick 
--no-commit'. I think you want to keep the existing clause as the first 
one and insert this before the else. The advice itself looks good. It 
would be nice to improve the advice for 'git revert' in the same way.

> +			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
> +				 "\"git add/rm <conflicted_files>\", then run\n"
> +				 "\"git cherry-pick --continue\".\n"
> +				 "You can instead skip this commit: run \"git cherry-pick --skip\".\n"
> +				 "To abort and get back to the state before \"git cherry-pick\",\n"
> +				 "run \"git cherry-pick --abort\"."));
> +		} else if (opts->no_commit)
>   			advise(_("after resolving the conflicts, mark the corrected paths\n"
>   				 "with 'git add <paths>' or 'git rm <paths>'"));
>   		else
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 014001b8f32..d3ed9d7ce0d 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -53,9 +53,12 @@ test_expect_success 'advice from failed cherry-pick' "
>   	picked=\$(git rev-parse --short picked) &&
>   	cat <<-EOF >expected &&

If you quote the here doc end marker then there is no substitution in 
the here doc so writing

	cat <<-\EOF >expected &&

>   	error: could not apply \$picked... picked
> -	hint: after resolving the conflicts, mark the corrected paths
> -	hint: with 'git add <paths>' or 'git rm <paths>'
> -	hint: and commit the result with 'git commit'
> +	hint: Resolve all conflicts manually, mark them as resolved with
> +	hint: \"git add/rm <conflicted_files>\", then run

means you can replace \" with " here

Best Wishes

Phillip

> +	hint: \"git cherry-pick --continue\".
> +	hint: You can instead skip this commit: run \"git cherry-pick --skip\".
> +	hint: To abort and get back to the state before \"git cherry-pick\",
> +	hint: run \"git cherry-pick --abort\".
>   	EOF
>   	test_must_fail git cherry-pick picked 2>actual &&
>   
> @@ -68,8 +71,12 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
>   	picked=\$(git rev-parse --short picked) &&
>   	cat <<-EOF >expected &&
>   	error: could not apply \$picked... picked
> -	hint: after resolving the conflicts, mark the corrected paths
> -	hint: with 'git add <paths>' or 'git rm <paths>'
> +	hint: Resolve all conflicts manually, mark them as resolved with
> +	hint: \"git add/rm <conflicted_files>\", then run
> +	hint: \"git cherry-pick --continue\".
> +	hint: You can instead skip this commit: run \"git cherry-pick --skip\".
> +	hint: To abort and get back to the state before \"git cherry-pick\",
> +	hint: run \"git cherry-pick --abort\".
>   	EOF
>   	test_must_fail git cherry-pick --no-commit picked 2>actual &&
>   
> 
> base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
> 

