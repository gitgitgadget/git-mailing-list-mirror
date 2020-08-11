Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52571C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA4420771
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="KQnmUPxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgHKS2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKS2f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 14:28:35 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35854C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 11:28:35 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j10so6441834qvo.13
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jUxL5qpLha5agrE5mOUB82wS7C7PAjcXFfD3YRbPxwU=;
        b=KQnmUPxFGG+mEc6SJdc6HwJ33t+3uOEvPdDGRkWILRNX0rlD49e9k/P5/yar03nI3+
         2fdKwWJFaVxThI1BdBfV19PFxyOxy2PZNuaa2OyWan5NY2k3US4rRFjnvo4zieKo5zN3
         PfDh0GgCl8K+7GqGZ4iTAGpzMQofwrny2WpKE0eBmLHpxCwsHxloFL9fqQhYCJZ/+Muc
         C/LEqJWpArEQbLgWOWI+2otaH4O4AQiX1XMtEU9tK9/6yhAvyPNVInWc/CLYCo2BfbHb
         hfwu6iStR0WYMm7PClIisqIXmlLBl5Gl+fPYRUxet6Ai/en2ZZVRnQyQrW/hWTHkXiqQ
         DndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jUxL5qpLha5agrE5mOUB82wS7C7PAjcXFfD3YRbPxwU=;
        b=pOwdXUhJfRR3Q9STYMH+YBUC0mWsiqisJmDXC1mN4GT+f1rEr4FWvmCNUHScuyLwXe
         lnXv6LSOyAV5H14zoRvY4Tap+51qx7/wbTHTXIvGVWT9JJ77Pd2wSiO0uAkmXHHNtMz4
         vU5Whx66aeoJPvynSDqjw6x5AIGgA/1P8/p7XfS+bZchnG5vQEIN1UFqUlnRnUMLCN2t
         2dsPo4Nch0SCmSy2aLMGcPM4NebLkBxHPpc67y64hRDtiXz1Hx6zI/gYeCqEuNxPuPx2
         gEa7t0pd93ShqwJvuXhvLvR495H8BO//sQunmDwf+0BmVTaXAK72DPCXNOSUfcpYVftp
         EiKQ==
X-Gm-Message-State: AOAM53168PtlIXoLSFA1ZJoqCUgdcVZcc8K+jgIPUE2GNljL4u+Q/r8U
        LszPNdGRAAdBXrFUP3qnoebXGQ==
X-Google-Smtp-Source: ABdhPJxdNcH1KpTSBDGpVvhe9yo0P9FaXv/HzAJvg6P8sQQUAyLzeBYKbsbKk34QUcLct8bYOScWFQ==
X-Received: by 2002:a0c:ec01:: with SMTP id y1mr2636255qvo.167.1597170514371;
        Tue, 11 Aug 2020 11:28:34 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id k48sm22491543qtk.44.2020.08.11.11.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 11:28:33 -0700 (PDT)
Date:   Tue, 11 Aug 2020 14:28:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/11] renaming argv_array
Message-ID: <20200811182832.GA33865@syl.lan>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <82991f30-fe37-d6d2-ffd5-8b0878f46c83@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82991f30-fe37-d6d2-ffd5-8b0878f46c83@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 06:08:22PM +0200, René Scharfe wrote:
> Am 28.07.20 um 22:21 schrieb Jeff King:
> > The argv_array data type has turned out to be useful in our code base,
> > but the name isn't very good. From patch 2 of this series:
> >
> >   The name "argv-array" isn't very good, because it describes what the
> >   data type can be used for (program argument arrays), not what it
> >   actually is (a dynamically-growing string array that maintains a
> >   NULL-terminator invariant). This leads to people being hesitant to use
> >   it for other cases where it would actually be a good fit. The existing
> >   name is also clunky to use. It's overly long, and the name often leads
> >   to saying things like "argv.argv" (i.e., the field names overlap with
> >   variable names, since they're describing the use, not the type). Let's
> >   give it a more neutral name.
> >
> > This has bugged me for a while, so I decided to finally fix it. It
> > wasn't _too_ painful, though I'm sure there will be a little fallout
> > with topics in flight.
>
> Just as this landed in master now, https://lobste.rs/ decided to link to
> http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2493.pdf, which is a
> paper about reserved identifiers in C.  It contains a nice overview.
>
> Anyway, 7.31 of C11 says: "All external names described below are
> reserved no matter what headers are included by the program."  And
> 7.31.13 goes on: "Function names that begin with str, mem, or wcs and a
> lowercase letter may be added to the declarations in the <string.h>
> header."  So the names of the strvec functions are reserved.
>
> Also how about using Coccinelle and patience to reduce the impact of
> such a change next time?  I.e. adding the new thing, providing a
> semantic patch for converting old code, waiting a reasonable amount of
> time after the last conversion was necessary and then removing the
> old thing.

I don't think that this is a bad idea at all, but I'm also totally fine
with the approach that Peff took here. (Bear in mind that I'm saying
this as someone who didn't have any topics that used argv_array, and so
didn't have to do any conversion effort ;-)).

I worry a little bit about providing too long a grace period where we
have to worry about not introducing new uses of argv_array, and still
having to deal with some (perhaps less) fall-out later down the line.

For this change, I think it was perfectly fine to just rip the bandaid
off.

> René

Thanks,
Taylor
