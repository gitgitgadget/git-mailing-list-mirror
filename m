Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34DBC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 21:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9426760F00
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 21:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbhHLVdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 17:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbhHLVdU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 17:33:20 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07485C061756
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 14:32:55 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id x10so10371458iop.13
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 14:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Z+z68YdyNsrsIN5E5IQ3NP91E262Moy/kBf3a6rz4c=;
        b=JLU71OwU537Wkb3Fm4P3kD9VjcnSJDwQflRNOdauc96PieRXB9HX1JJOsVBJ8dH6cC
         F79cw8Dj+Zw/o1cYOPbKFTxMkL8Z2mSCdk7F+w3oBE/7iziYDhWMV7JGbG6PrASSLYuu
         DcRC13ii4K1a7ivPJCPAfgH8oHnf8z/WQVo67Rjs99NMgI1pbr7EBKrJ46iWmHwOzR21
         4Jg07dpsaSsokp09wSRqJbYm2SrjTdIvU48dIhJgLDvj/bQJ2OfTWObujOXdB7yFB+i5
         gjvsDqDmwiVY1PPc0gGSDJjVTEMeGVYsOnlfNmdCCVFW4k1Pn7SO7h8eHYx0OmpKtAsU
         qd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Z+z68YdyNsrsIN5E5IQ3NP91E262Moy/kBf3a6rz4c=;
        b=n/lWyUtq5mdb+86e/q2xZeSt6p8GDgvDREBBeD47MzwbAumpjSxKoPW15Al42HAM61
         CP0JJr66sUo7TqvTdjoREJE0C1uXxutdTpqO2wdh9uEG+Sw6OX2oWdK+VYPN6Me/qNOr
         E2JOgEhOnmbLTw/SFGMloaIANdkLOpW99W3cXHaAzs7xZtKpFuZInjiBVpw/2eNA8j62
         A4X8n6FBgS8S2dD7Lz44pD+S96K5xehHB+VOeQYVh4mmi2EE1EZQh9HRt8n33Gvwakw5
         CUrdHzQZKBvmYn1zETDPoNaI72h5vNL5gWkIUS0mTNkE0w8Ym2FMhVMgls8mdM131wGT
         uvYQ==
X-Gm-Message-State: AOAM533o9SQBaC2ngc75aJjoImcPSa+tfTzDhWvHPQUBa3F+Z64qJJuO
        LXY7AK/Q4s9SsuolzhXYJ1PIBg==
X-Google-Smtp-Source: ABdhPJwLfWsaYy0OLBm04EJcEZJ2pxaxm+0rHRL+iL0iYQuBevHK1B4sOCuo03rSwFxdaSI8tbNiIw==
X-Received: by 2002:a6b:8f08:: with SMTP id r8mr4561621iod.42.1628803974514;
        Thu, 12 Aug 2021 14:32:54 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:e51e:bbd8:bead:b6a6])
        by smtp.gmail.com with ESMTPSA id d18sm2283349ile.32.2021.08.12.14.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 14:32:36 -0700 (PDT)
Date:   Thu, 12 Aug 2021 17:31:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 17/25] t/helper/test-read-midx.c: add --checksum mode
Message-ID: <YRWTGzdS1Ab80JnH@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
 <60ec8b3466e7f94610a45bdd1c79feb06e439429.1627420428.git.me@ttaylorr.com>
 <YRWFFgfXnyiRKdC1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRWFFgfXnyiRKdC1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 04:31:18PM -0400, Jeff King wrote:
> On Tue, Jul 27, 2021 at 05:20:07PM -0400, Taylor Blau wrote:
>
> > Subsequent tests will want to check for the existence of a multi-pack
> > bitmap which matches the multi-pack-index stored in the pack directory.
> >
> > The multi-pack bitmap includes the hex checksum of the MIDX it
> > corresponds to in its filename (for example,
> > '$packdir/multi-pack-index-<checksum>.bitmap'). As a result, some tests
> > want a way to learn what '<checksum>' is.
> >
> > This helper addresses that need by printing the checksum of the
> > repository's multi-pack-index.
>
> Makes sense. It might be nice to have a generic tool for pulling hashes
> out of checksum files. Perhaps even a tool that is shipped with Git for
> operating on such files (for in-the-field debugging and diagnosis). But
> that can definitely be separate from this series (if ever).

Yeah. That would definitely be in the spirit of "we should have more
test-tool-like helpers exposed via user-facing plumbing". And I agree
that it would be nice, but I definitely agree that it's a topic for a
later date ;).

> >  t/helper/test-read-midx.c | 16 +++++++++++++++-
> >  t/lib-bitmap.sh           |  4 ++++
> >  2 files changed, 19 insertions(+), 1 deletion(-)
>
> The patch itself looks fine to me. One curiosity:
>
> > diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
> > index ecb5d0e05d..09cd036f4d 100644
> > --- a/t/lib-bitmap.sh
> > +++ b/t/lib-bitmap.sh
> > @@ -260,3 +260,7 @@ have_delta () {
> >  	echo $1 | git cat-file --batch-check="%(deltabase)" >actual &&
> >  	test_cmp expect actual
> >  }
> > +
> > +midx_checksum () {
> > +	test-tool read-midx --checksum "${1:-.git/objects}"
> > +}
>
> This default ".git/objects" will only _usually_ be the right thing. :)
> If the actual C code accepted a missing object-dir, it could use the
> correct object directory discovered by setup_git_directory().
>
> Probably not a big deal either way, though.

Yeah. We could just sidestep the whole thing by not having the
`.git/objects` default, since all callers of midx_checksum pass an
argument, so that fallback is dead code anyway. Thanks for noting, I'll
remove it for the next round.

Thanks,
Taylor
