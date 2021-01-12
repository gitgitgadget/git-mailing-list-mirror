Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473A0C433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1182311A
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 17:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392316AbhALRIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392160AbhALRIp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 12:08:45 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF8DC061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 09:08:04 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id f26so2510173qka.0
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 09:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8y3mzdMu30EGy1VWq3BVIyEy4ALdRL8fti5hb4Kcei4=;
        b=qEMkInzw81UThMNkyd1/JdyXXXisNjkdKZCu8PoAUuSsIh+vzJPhf4yurwVD1yu40C
         /qFdil/70HKjw1k4+V/IsJYa/5ngZUgu3CLkZz48SgW7IV1sofg4ajhInBFPUALRP15O
         q3nP2Zd4CFU+mHFljR2XAdUZC2oB4Xey/15mXlwjYpNhH1q+DHR65BWFzFY0wtfF4Mlf
         jmEWPRezCVkVnDakTzNQLXwCQzuDN4rpsQw7b3/Rt1xjLgX09ymRgnvE8fVoLhdX2iZH
         Bkrd3ng1FbcU13PxLJcTuh0VEB1amYWnLtMfYnVy7VMz0xud5F3C/SovFWUxkOdvL+5+
         FP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8y3mzdMu30EGy1VWq3BVIyEy4ALdRL8fti5hb4Kcei4=;
        b=OiNvVojzTjvEYVLZh6EHhJyFddpi9E4nua2Ubp7wHX/IRrPhdqGOZL+S1G+UnSCKVN
         rVnI9/lx24T+rK/jWWVnXXLTOxrm7efRFXMjg0aXhvYjv9TlPOoGAU/tZWYxJPqpIdwC
         oblmJU0/zDgIuvVoAB9ysJUG/aE8XcwAu+UqKsYKbsRQ+fRi/XwOuFZRyyhGJEQYG98X
         ZKFjWKFG+vn7qdCx0FlyIehiJJ74sULmM6ijsXNJjHQwpDmLchHj9riF+gFhxgyGlc07
         oGC01+xWjc7mTn8QmlDe8BePCqMYcZ0wtPDveyZPJMbrstJ+Qb54SaR7c90kM4Xh5n08
         CZDA==
X-Gm-Message-State: AOAM531m4mXsRmy2eLngFzYnscQukdV1pNuGXwMTK06sDB19PzMHcUbR
        J2Kj8p32fLYZvgeqinQSU0XtUQ==
X-Google-Smtp-Source: ABdhPJympbdhiI/Ej/sNpiLVfWKhoUhVKtY/553/6V/5aLIwD3yqk2Xte1p5nIA57MwDyMRw6b+Jow==
X-Received: by 2002:a05:620a:2051:: with SMTP id d17mr226578qka.403.1610471283910;
        Tue, 12 Jan 2021 09:08:03 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:42e2:d139:3745:d47])
        by smtp.gmail.com with ESMTPSA id l11sm1394492qtn.83.2021.01.12.09.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 09:08:03 -0800 (PST)
Date:   Tue, 12 Jan 2021 12:07:59 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
Message-ID: <X/3Xbxf5P8303di5@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <X/1vy3D10wDEZNva@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/1vy3D10wDEZNva@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 04:45:47AM -0500, Jeff King wrote:
> > The goal of this series is to remove direct access of the `struct
> > revindex_entry` type, as well as `struct packed_git`'s `revindex` field. The
> > on-disk format will be mmap'd and accessed directly, but the format is
> > sufficiently different that the whole `revindex` array can't be written as-is.
>
> It looks good overall to me. I left a few nits around documentation and
> integer types that I think are worth a re-roll, but I think after
> addressing those it should be good.

Thanks so much for your review. I think I addressed all of your
feedback, but I'll sit on the revised patches for another day or so in
case other reviewers would like to chime in before v2.

Hopefully the this re-roll is the only one we'll need, since the next
series is much more interesting!

Thanks,
Taylor
