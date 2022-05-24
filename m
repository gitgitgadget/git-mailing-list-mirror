Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFC8C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 19:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbiEXTUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 15:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiEXTU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 15:20:29 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3277364D25
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:20:28 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f2bb84f9edso322589fac.10
        for <git@vger.kernel.org>; Tue, 24 May 2022 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vEsYdGd75o21tFCiD7gcnCr8dQHcxDpj9mfcF4vw8vs=;
        b=KnnS64wDsrWQbwqiQNn6+Mcratij4iUK3T7E1u+7DBp3uuaE6cND+SkRvQ08zcAa0M
         tFXxs24zuip0DbAKM7DB5dmuhYaC2G7VXPpipvnvS7RpAU7UV+hS4Ii+SSgeRee1a0Jj
         K8zTwURl1qcL5i8HAbtOpijjNmqE7PzrH5WnTdsuQuenNWFc1XHWlUCE0sayyUGqbL4y
         ZFnQXrj1AsGIVwNmETaA2YgOoOLZrnhvE2GM18sHQlfbzHmhdd+9ywI5smVqFqO8I5ow
         j36KNevUQnIO1JZYKX/Y2ogaZwXHaf9Ru3YHXx44yR8ScfIh4Y64zxXPxeuuD6oz29J7
         9rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vEsYdGd75o21tFCiD7gcnCr8dQHcxDpj9mfcF4vw8vs=;
        b=TyYSbi9gHOO/GAvKasEtMSS2psROnPH2ZZ0VAB/7ORc6vV4w3o8T4GhSVikFrB0x9A
         zujpWmLgE46Su7S0XxVSIgI4gAN3Lq7PxH2aHhBC/5VBhhATO9BFE13cqK7xaXQuCIx8
         TrPdnzS4oO70xmB9HDq52voV/TcICeNjnP5DLnpm2r8h0gq6fUmgxJzgxHz1yrxNisV1
         FZb2emkrEE/Ubxg6KoEGfmmhBTjAt023fnac7noD7E8X4vb29W6fGLwfdxfBU7wkGA0n
         8V36jp/jYdgaYkxfWdgXHB0nkHhl0YU08LthMcPSXgEPN8T83mf5QIfeTcQoYHiZYvfT
         XeOw==
X-Gm-Message-State: AOAM531O9bEmXWFhPSYtno4dWqjqodPmALBHWlrWXhugMnkI9rChq/LN
        BY6M0TlO7bZqYXv7frmIRyY=
X-Google-Smtp-Source: ABdhPJwei9PsVfe5aGNL0ppeqO2Wrc8FAULGXB76H16XDOSQj1QThN4xr+mFV5D8ubAGzexzy5XQcQ==
X-Received: by 2002:a05:6870:e316:b0:f2:b38f:1fe7 with SMTP id z22-20020a056870e31600b000f2b38f1fe7mr1199415oad.181.1653420027470;
        Tue, 24 May 2022 12:20:27 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id k17-20020a9d1991000000b0060b0b638583sm3255067otk.13.2022.05.24.12.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:20:27 -0700 (PDT)
Date:   Tue, 24 May 2022 12:20:26 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, Ed Maste <emaste@freebsd.org>
Subject: Re: [PATCH] ci: update Cirrus-CI image to FreeBSD 13.0
Message-ID: <20220524192026.2373nfcrs6bsa4ce@carlos-mbp.lan>
References: <20220524165823.18804-1-levraiphilippeblain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524165823.18804-1-levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 12:58:23PM -0400, Philippe Blain wrote:
> The FreeBSD CI build (on Cirrus-CI) has been failing in
> 't9001-send-email.sh' for quite some time, with an error from the
> runtime linker relating to the Perl installation:
> 
>     ld-elf.so.1: /usr/local/lib/perl5/5.32/mach/CORE/libperl.so.5.32: Undefined symbol "strerror_l@FBSD_1.6"
> 
> The first instance is in t9001.6 but it fails similarly in several tests
> in this file.

I have to admit I never tried to use cirrus, but I verified locally that a
12.3 version wouldn't fail as well (or so I think).

did you try to use 12.3 which should be supported for a little longer?
 
> The FreeBSD image we use is FreeBSD 12.2, which is unsupported since
> March 31st, 2022 [1]. Switching to a supported version, 13.0,
> makes this error disappear [2].

I think 13.1 might be better, since with this change we are also implicitly
making a move to say that we don't really care about the old (but still
supported) maintenance branch, but will only look at the "latest" version
instead.

still (and Ed might have a stronger opinion about it than me) either version
would be an improvement and feel free to add my Reviewed-by for what it is
worth.

>     [1] https://lore.kernel.org/git/CAPUEspgdAos4KC-3AwYDd5p+u0hGk73nGocBTFFSR7VB9+M5jw@mail.gmail.com/T/#t

this might had been mangled by your mailer, but will presume is the thread
where I replied before, and that obviously didn't stick for these round ;)

Carlo
