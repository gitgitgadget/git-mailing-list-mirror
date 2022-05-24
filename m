Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9D7C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 08:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiEXIGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 04:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiEXIGA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 04:06:00 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B2C9346F
        for <git@vger.kernel.org>; Tue, 24 May 2022 01:05:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i40so22023469eda.7
        for <git@vger.kernel.org>; Tue, 24 May 2022 01:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=a/y2nXXvJfrfm4e/JWxR/qRlLsUpL61JGSmpT6ZPttM=;
        b=Mjfae0QZasZD5N91T2uJDvdjErBuNxv60IWOMlpr9LG1cvh+y78SrwvNc73pZYKZBm
         q0zFzeHRo8nndxTAfu/cyelll4xVCrm497XezZDAkqYGIaO6ZSxI2hFTHDMz17o353AL
         NqNVKN48GjJC3POPnkQkecsFc1j+NNyPd8NRy+JdiXDNAF230zZES1wJmsy4rYLOOdd+
         CGyy3GFFTVt5jDF7b0qI0ftlYXs72WDWOPS35AzUQxaRIi6cwUu+/CprDeD18p8b/qNj
         Gs91LKZzQiIxcS327H+Q/3QiR5/XUlUYApE8+pdf73MtBsMflSvnJ1eg/XyyI+hg0Zu6
         Mp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=a/y2nXXvJfrfm4e/JWxR/qRlLsUpL61JGSmpT6ZPttM=;
        b=C/KopNh6yBmmGKYXdBTB/EwcNp4f38uiyEHCST6cv81WgsXQ7Tj1jN9uzdXergZTaC
         g6v7Ch2PS8dl02SZNj3iNOHGNGWbMs+MqLyWHkmfsdKhjEh27hw1CkZAglAHwyqq4GGg
         WZEkm2AJINflEsBp6HhA7xRaNVfsyzF2MxBg68wjdLjRnSjobOMfO1itEZ+d5gKWn6AD
         sPb2W0Tp/bBWVSIAkgEqmZOw6HoqTkNALyYvuZ/i+0PGColOTDlU9mfyOybm1Xf6fnO4
         1+UVuL5ObJPlN/VT6GuFuPFTmhGrJSgZbC9um4SoOouk3oSkHy0Y1U5yS/x1kA/TjOpB
         2WHg==
X-Gm-Message-State: AOAM532rUTStJSKI3aXoX5c866z+iZdqRdpgWrXHw7M9ENJywh966eH9
        f6hp6HaOejhQWxC4vYhnTmU=
X-Google-Smtp-Source: ABdhPJxstDIqYOiThrPsU5cT93W8L17Hyc4MrHKSGk/dFFKu90VjaTZfhtOWBDPbQtFZKWl/FsANMg==
X-Received: by 2002:a05:6402:3812:b0:42a:a0dc:562c with SMTP id es18-20020a056402381200b0042aa0dc562cmr27398509edb.205.1653379555625;
        Tue, 24 May 2022 01:05:55 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id jp10-20020a170906f74a00b006feec47dae9sm1648812ejb.157.2022.05.24.01.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 01:05:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntPYA-00390C-IM;
        Tue, 24 May 2022 10:05:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] nedmalloc: avoid new compile error
Date:   Tue, 24 May 2022 10:00:45 +0200
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
 <8963c6fa625bbaf5153990939ea06742304ddcd2.1653351786.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <8963c6fa625bbaf5153990939ea06742304ddcd2.1653351786.git.gitgitgadget@gmail.com>
Message-ID: <220524.86bkvnxsm5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> GCC v12.x complains thusly:
>
> compat/nedmalloc/nedmalloc.c: In function 'DestroyCaches':
> compat/nedmalloc/nedmalloc.c:326:12: error: the comparison will always
>                               evaluate as 'true' for the address of 'caches'
>                               will never be NULL [-Werror=address]
>   326 |         if(p->caches)
>       |            ^
> compat/nedmalloc/nedmalloc.c:196:22: note: 'caches' declared here
>   196 |         threadcache *caches[THREADCACHEMAXCACHES];
>       |                      ^~~~~~
>
> ... and it is correct, of course.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/nedmalloc/nedmalloc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
> index edb438a7776..2c0ace7075a 100644
> --- a/compat/nedmalloc/nedmalloc.c
> +++ b/compat/nedmalloc/nedmalloc.c
> @@ -323,7 +323,6 @@ static NOINLINE void RemoveCacheEntries(nedpool *p, threadcache *tc, unsigned in
>  }
>  static void DestroyCaches(nedpool *p) THROWSPEC
>  {
> -	if(p->caches)
>  	{
>  		threadcache *tc;
>  		int n;

This seems sensible, I thought "why not submit it to upstream",
i.e. see:
https://github.com/ned14/nedmalloc/blob/master/nedmalloc.c#L1298

But that repository was last updated in 2014, I wonder if it's just
because nobody's submitted a patch since then, or if it's inactive. Have
you tried making Njall Douglas (the nedmalloc author) aware of this
issue?

