Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7337CC4338F
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 10:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3CF610A1
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 10:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhHAKOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Aug 2021 06:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhHAKOo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Aug 2021 06:14:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5093C0613CF
        for <git@vger.kernel.org>; Sun,  1 Aug 2021 03:14:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso807705wms.5
        for <git@vger.kernel.org>; Sun, 01 Aug 2021 03:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dgfI50RcWG807HyVRiT4OpXwQE+QJBcRL3kqqGk19Ds=;
        b=hEfUvS5TuqCqFaFYaXRsAUWX7ngRjyil93o/aHrk1JYyPbN+WpPzIw3HnllARD6G8g
         eQAH+RKly7AOuP0BQcrbtfW44ISdeA6IAbDeN6q0o4M8AjxxrQm7+heK5XHficOUQjWW
         yASeng//DM8wflEsfRuGYZO4i5TPukvAuDLsjKO0RssUzR+eQGgx8vkRCMd+JWe0wzzo
         gHxeMSOfcXtQTrHE7iFGEwEj3m5aIc3qDddnV8Sjx1C2UrSnfCYX8n06auH9jZ8otbZf
         o7rfL4VsXZ2w6drM1cq0PnieXjE5SEXWkID7lyP4QjRzsR+uzS2Hjfqi2TXRbrbLVyvi
         cV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dgfI50RcWG807HyVRiT4OpXwQE+QJBcRL3kqqGk19Ds=;
        b=HKiAwQYipe8x4jc4KbOvl/D/rKXcRNXLpoerEVgf1DtDpXJz3G3RCLFINOgGZMMHdu
         iq5h6azD5ETRp0TDAhk1sg/ZHzZvwgKOX0x3acDkMtT1SpXPvoStYAgO1EB/Rf8H7wGP
         clJKdkrJ5S1STdDEIoJ8tGvfVnr/dggWMxAm0U63S9Rm8quQAoZaANqv2hYEtHXt69iO
         RqAoVKZOzCVPdhlQ9jdGyxoxqMdg5p/sP4+AeHm/npMu1NG6rFQUyQ7TFWn7ZNSJ5Dz+
         u0+TGm4EyKHzc5I1/awyjcRytaUTYGjIz+0/2ityMsU8TuaJDQi4QUw5kxKSDof/pFyi
         Dqeg==
X-Gm-Message-State: AOAM533TbCr8iFmLnkz6l55YMHOPzByY8wRv95EY8ut/wtcsNswVjQVx
        84aULsbw1TMsxBsOq0fSDq8=
X-Google-Smtp-Source: ABdhPJzs0qOPET0wo9BLUssbQxpdoPeumNDFu8Vzgtnpm/gJhVQv283WY14gRaTPiCnzOO89J8wlFA==
X-Received: by 2002:a05:600c:4e94:: with SMTP id f20mr11397430wmq.135.1627812874234;
        Sun, 01 Aug 2021 03:14:34 -0700 (PDT)
Received: from [192.168.1.14] (host-2-98-21-22.as13285.net. [2.98.21.22])
        by smtp.gmail.com with ESMTPSA id d15sm441413wri.96.2021.08.01.03.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Aug 2021 03:14:33 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] [GSOC] cherry-pick: use better advice message
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
References: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
 <7e1ed49728df8dab771d77f1a076f0fa30975718.1627714878.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0a2ab793-de4d-d8d1-4d1d-a018fa0f252c@gmail.com>
Date:   Sun, 1 Aug 2021 11:14:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <7e1ed49728df8dab771d77f1a076f0fa30975718.1627714878.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/07/2021 08:01, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
> In the past, git cherry-pick would print such advice when
> there was a conflict:
> 
> hint: after resolving the conflicts, mark the corrected paths
> hint: with 'git add <paths>' or 'git rm <paths>'
> hint: and commit the result with 'git commit'
> 
> But in fact, when we want to cherry-pick multiple commits,
> we should not use "git commit" after resolving conflicts, which
> will make Git generate some errors. We should recommend users to
> use `git cherry-pick --continue`, `git cherry-pick --abort`, just
> like git rebase does.
> 
> This is the improved advice:
> 
> hint: Resolve all conflicts manually, mark them as resolved with
> hint: "git add/rm <conflicted_files>", then run "git cherry-pick \
> --continue".
> hint: You can instead skip this commit: run "git cherry-pick --skip".
> hint: To abort and get back to the state before "git cherry-pick",
> hint: run "git cherry-pick --abort".

This new wording matches what we have for rebase which is good, I am 
slightly worried that the lines end up being quite long though they are 
just under 80 characters. It might be worth splitting the line that 
mentions running "git cherry-pick --continue" so it is a bit shorter.

Best Wishes

Phillip

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by Hariom Verma <hariom18599@gmail.com>:
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Hepled-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>   sequencer.c                     |  9 ++++++++-
>   t/t3507-cherry-pick-conflict.sh | 15 ++++++++++-----
>   2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 83cf6a5da3c..f6e9d1fddd8 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -404,7 +404,14 @@ static void print_advice(struct replay_opts *opts, int show_hint)
>   	if (msg) {
>   		advise("%s\n", msg);
>   	} else if (show_hint) {
> -		if (opts->no_commit)
> +		if (opts->action == REPLAY_PICK) {
> +			advise(_("Resolve all conflicts manually, mark them as resolved with\n"
> +				 "\"git add/rm <conflicted_files>\", then run \"git cherry-pick --continue\".\n"
> +				 "You can instead skip this commit: run \"git cherry-pick --skip\".\n"
> +				 "To abort and get back to the state before \"git cherry-pick\",\n"
> +				 "run \"git cherry-pick --abort\"."));
> +
> +		} else if (opts->no_commit)
>   			advise(_("after resolving the conflicts, mark the corrected paths\n"
>   				 "with 'git add <paths>' or 'git rm <paths>'"));
>   		else
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index f17621d1915..2cc3977f5a6 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -53,9 +53,11 @@ test_expect_success 'advice from failed cherry-pick' "
>   	picked=\$(git rev-parse --short picked) &&
>   	cat <<-EOF >expected &&
>   	error: could not apply \$picked... picked
> -	hint: after resolving the conflicts, mark the corrected paths
> -	hint: with 'git add <paths>' or 'git rm <paths>'
> -	hint: and commit the result with 'git commit'
> +	hint: Resolve all conflicts manually, mark them as resolved with
> +	hint: \"git add/rm <conflicted_files>\", then run \"git cherry-pick --continue\".
> +	hint: You can instead skip this commit: run \"git cherry-pick --skip\".
> +	hint: To abort and get back to the state before \"git cherry-pick\",
> +	hint: run \"git cherry-pick --abort\".
>   	EOF
>   	test_must_fail git cherry-pick picked 2>actual &&
>   
> @@ -68,8 +70,11 @@ test_expect_success 'advice from failed cherry-pick --no-commit' "
>   	picked=\$(git rev-parse --short picked) &&
>   	cat <<-EOF >expected &&
>   	error: could not apply \$picked... picked
> -	hint: after resolving the conflicts, mark the corrected paths
> -	hint: with 'git add <paths>' or 'git rm <paths>'
> +	hint: Resolve all conflicts manually, mark them as resolved with
> +	hint: \"git add/rm <conflicted_files>\", then run \"git cherry-pick --continue\".
> +	hint: You can instead skip this commit: run \"git cherry-pick --skip\".
> +	hint: To abort and get back to the state before \"git cherry-pick\",
> +	hint: run \"git cherry-pick --abort\".
>   	EOF
>   	test_must_fail git cherry-pick --no-commit picked 2>actual &&
>   
> 
