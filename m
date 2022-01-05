Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84E9C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 03:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbiAED6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 22:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiAED6f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 22:58:35 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F351AC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 19:58:34 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id r139so36113989qke.9
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 19:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kiL9pSCUCjJSNCMWFe9U6vI5VPnxXiz5ztriNj5DI2c=;
        b=RS634C5mLs7Vp5Cqy8a0IXVrMFzEJ+F5uizVsiOnejv6eMzgv7X4A4YBLTXIi1uOQx
         AE8i+MUn3bsPGzjnzMZc4DfFK2gNwJQDATEH2IeRULVUMPUn5vhp3xHuitlJaJjDQuG5
         cuUzZRgHRRDiptGrYP8dpeiIjmnqqq9uXdzTd1OZIGgwygwkgeNcwXVOdt+uu7T+Bjmz
         uMwitboIvPRGwP3tPJNQQ79zId8CahebQwhszPRs+WOaO/ipIx9ZI7pgUUcff5mrCygs
         EM1ECqSTc1h6EvbWD1ZVX3n5zawLjyLNL9upx7RKKb1EOHhRIqE5q/GoxBmbuC6eyL/E
         jlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kiL9pSCUCjJSNCMWFe9U6vI5VPnxXiz5ztriNj5DI2c=;
        b=ZUEt390iVnaMFXDNScpURcmSmCmI/sDDSKNhX2EF2dpHv2nbhb/jw18HzV/jtao0bN
         zMB3rF48C2QrJRlON7Bzxmt3ImI8tHaV59U/MGscP0sWTy2SqN+CudY62voLBEizFYzO
         s/eD67gzF8bhkC+8NbR6LV4rWb5Mg3zj0v7F3yBO9a3k8If5+Cq6NeTwMrZDpjDT2X3V
         MSyc+Q7GIg7vdxKrbsrYGn3VhesZw9cPtwI8oUnipf0q2PizvWPkaP50pYpjsJlMeEBt
         J8j2fAYXYh/MWNtybUEDKSw9fWoI2CU0btauzTvpAW31gJFtyxzIDQe/At35wFd51WQ6
         gV1g==
X-Gm-Message-State: AOAM531objHsCjU/I8up/zrh+BVLNodkOtM/OtW8NfwMOr+0W5edeK8B
        H6Fj8GZuuGppF2bsRGox1sG9ud81mio=
X-Google-Smtp-Source: ABdhPJxLcBbAnWGoS+VkL+Og0geI3DQLRiQBnS9ycB8BBK4FOweRUtNKXYZVdKrYVopkH413UNEh3A==
X-Received: by 2002:a37:6586:: with SMTP id z128mr37496662qkb.73.1641355114127;
        Tue, 04 Jan 2022 19:58:34 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id u28sm25894096qke.12.2022.01.04.19.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 19:58:33 -0800 (PST)
Subject: Re: [PATCH 1/1] builtin/pull.c: use config value of autostash
To:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>
Cc:     git@vger.kernel.org, Tilman Vogel <tilman.vogel@web.de>
References: <20220104214522.10692-1-johncai86@gmail.com>
 <20220104214522.10692-2-johncai86@gmail.com> <xmqqbl0r9l0l.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <4fe0e850-1c30-da70-5535-e2a4105ba734@gmail.com>
Date:   Tue, 4 Jan 2022 22:58:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqbl0r9l0l.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-01-04 à 17:46, Junio C Hamano a écrit :
> 
> I wonder if the following two-liner patch is a simpler fix that is
> easier to understand.  run_merge() decides if we should pass the
> "--[no-]autostash" option based on the value of opt_autostash, and
> we know the value of rebase.autostash in config_autostash variable.
> 
> It appears to pass all four tests your patch adds.
> 
>   builtin/pull.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git c/builtin/pull.c w/builtin/pull.c
> index 100cbf9fb8..d459a91a64 100644
> --- c/builtin/pull.c
> +++ w/builtin/pull.c
> @@ -1133,7 +1133,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>   			die(_("cannot rebase with locally recorded submodule modifications"));
>   
>   		if (can_ff) {
> -			/* we can fast-forward this without invoking rebase */
> +			/*
> +			 * We can fast-forward without invoking
> +			 * rebase, by calling run_merge().  But we
> +			 * have to allow rebase.autostash=true to kick
> +			 * in.
> +			 */
> +			if (opt_autostash < 0)
> +				opt_autostash = config_autostash;
>   			opt_ff = "--ff-only";
>   			ret = run_merge();
>   		} else {
> 

We already have a quite useless 'int autostash' local variable in cmd_pull
a few lines up, so an equivalent fix, I think, would be the following:

diff --git a/builtin/pull.c b/builtin/pull.c
index 1cfaf9f343..9f8a8dd716 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1036,14 +1036,13 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
  		oidclr(&orig_head);
  
  	if (opt_rebase) {
-		int autostash = config_autostash;
-		if (opt_autostash != -1)
-			autostash = opt_autostash;
+		if (opt_autostash == -1)
+			opt_autostash = config_autostash;
  
  		if (is_null_oid(&orig_head) && !is_cache_unborn())
  			die(_("Updating an unborn branch with changes added to the index."));
  
-		if (!autostash)
+		if (!opt_autostash)
  			require_clean_work_tree(the_repository,
  				N_("pull with rebase"),
  				_("please commit or stash them."), 1, 0);

Thanks,
Philippe.
