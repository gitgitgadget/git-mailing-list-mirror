Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68CAC433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 09:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A4061206
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 09:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhDCJ7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 05:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhDCJ7W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 05:59:22 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979E7C0613E6
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 02:59:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id a6so196805pls.1
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F1VAyL48gPMK65NXcuyl243gqPwiv4LbmZg8zLTee1M=;
        b=rkk7YEcT4ipPQC5jpyZgBjeogxjkk+QWz9Bpv3kxf1pKiYx+94zrgmPcBj845ruW1y
         X0k4kvUlhYI4kDWlWjfBJGR+4lpByumh/pLd7Va3ZM1UcEgo0+FYcfUQXcqlngB0aOrB
         HRJRlz5xaQ825BKjxxcMqDDKzi0JQmrc24UOjrBoNRCIsnI5H5JS8gUMu7DhlHZv5lJI
         bPViY5m4Kz/bwYA7FhOMJEi35WfhQqZm+A8AMq34Kp62tkaux6ayJhay3ieYC6CgvMmi
         5jRRLSlQwJyYzwnCQvuzWnrmYAfnjstG6Siq43iy+QOT5KQzqiDLqQmJ1qRdpB2v6SID
         ZM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F1VAyL48gPMK65NXcuyl243gqPwiv4LbmZg8zLTee1M=;
        b=k13Z+3XO59WuODGibSBpxBKycnsk+4FPQAyYZkf7Xalkqy1fbfCAxbT8hMKglFy4Uk
         cwh4faJM9rDEUtf1uE9atw32ZCKUIR0GoaczEJSUGRDIDaamxti/EdKBlTEmW0qxSxl+
         KYjXNnsfT+pvjqIxGOjtKfM7QYf32EcmDKJekma4jDIYSJIM6RA/hU9OD/mwW4LlMM4T
         aLAtVhGDTF94f8ulvkJH+qPX1Mnr8MOBjiaD6WizytBHcTC2SKAmeZFVjubHV5TyQorE
         ASRuf4eZLu7bPjLoqHIOXzS1HZRoTCCav4IA8uv7RqbpGh3Z8Lbhn/RkYNAJvDMSUEEF
         R2EA==
X-Gm-Message-State: AOAM5302p/O9e3TPiTulg4tXmudrXCkrUvJFEKN0saSeVm+g6SFtlInL
        J60kvmYzOSntZS69g6IZBUI=
X-Google-Smtp-Source: ABdhPJxfeCybS5XWZJg5v3JKMI10Ts8XPtEp5cjk9+L68tW4O/2jzTu+Vu4BbT0rZppCuefVUdvvDw==
X-Received: by 2002:a17:902:8f8d:b029:e7:4a2f:1950 with SMTP id z13-20020a1709028f8db02900e74a2f1950mr15968135plo.77.1617443957939;
        Sat, 03 Apr 2021 02:59:17 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-32.three.co.id. [116.206.12.32])
        by smtp.gmail.com with ESMTPSA id w17sm10393110pgg.41.2021.04.03.02.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Apr 2021 02:59:17 -0700 (PDT)
Subject: Re: [PATCH] gitk: fix selection color not persistent
To:     gh acct via GitGitGadget <gitgitgadget@gmail.com>
Cc:     gh acct <tony@viulogix.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <pull.926.git.1617391375445.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <1c869676-d818-c789-5df4-b6d6075ebafb@gmail.com>
Date:   Sat, 3 Apr 2021 16:59:14 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <pull.926.git.1617391375445.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/04/21 02.22, gh acct via GitGitGadget wrote:
> From: ghacct <tony@viulogix.com>
Is it anonymous contribution?

> Dear git community,
> Is it possible please for the gitk selection color setting to be persistent?  Since 2015 this has been working for me.
> Thank you for considering!
The patch/commit message seems like question asking for something,
but you should instead describe why you made this patch, as our
convention here.
  
> Signed-off-by: tgomez <tgomez@usa.wtbts.net>
> Signed-off-by: ghacct <tony@viulogix.com>
I asked to you: Is tgomez co-authored this patch or just helping?

> ---
>      gitk: fix selection color not persistent
>      
>      Dear git community, Is it possible please for the gitk selection color
>      setting to be persistent? Since 2015 this has been working for me. Thank
>      you for considering!
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-926%2Fghacct%2Fpatch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-926/ghacct/patch-1-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/926
> 
>   gitk-git/gitk | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 23d9dd1fe0d0..d255654b02fd 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2412,6 +2412,7 @@ proc makewindow {} {
>       text $ctext -background $bgcolor -foreground $fgcolor \
>           -state disabled -undo 0 -font textfont \
>           -yscrollcommand scrolltext -wrap none \
> +        -selectbackground $selectbgcolor -selectforeground $fgcolor \
>           -xscrollcommand ".bleft.bottom.sbhorizontal set"
>       if {$have_tk85} {
>           $ctext conf -tabstyle wordprocessor
> 
> base-commit: a65ce7f831aa5fcc596c6d23fcde543d98b39bd7
> 
[CC] Junio, what do you think about this patch?

-- 
An old man doll... just what I always wanted! - Clara
