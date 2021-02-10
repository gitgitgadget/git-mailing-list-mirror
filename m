Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF7CC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384B764EBB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhBJXST (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbhBJXQE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 18:16:04 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8CAC061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:15:20 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id w19so3090249qki.13
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JeuGxqsMxmW5p4GLRO6kKtYqSgWiOCVznbpNRl3wu8U=;
        b=rv85K1wT1dptA9OWD7mly5P7ZubZj7YPVC8k5l47Bi0wwsag1/YlogVMQJy0SXhusR
         KCupNWMixeppyjM/HwZxDouJgd33UBPuAX0kelzDNQCwAradeMwrH0Yi3wVhRjZFBsKy
         XsaBbxziQuh5746l1F7P+/g1rgbp0vdeJV4lSoeoG7gWRzu5CpP6QvyNDRGOyVi1hRg4
         HbAcHfkcO4Mz3FMdN+ztAZnCP0WJbC3mKeX3k2ZAUn7Nl6Pzq4F1q/Z2aZds5PDG/c1k
         7DprVVURqCNvRs5r8bruDApkmI/DcQhhUt5/C+4ekg1voffybmQraH8dUDPGANwSwyYe
         ygxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JeuGxqsMxmW5p4GLRO6kKtYqSgWiOCVznbpNRl3wu8U=;
        b=AtDpXZ9IgyylhCEjVGDVar29TBWtWMfs9So2GFZxaC/0GVi+ueWNGmCvtdT4cvGS5M
         YjkbMc8TnK7RbfocP2jCHtB86WIM5aO/55TnB4XIwJe33qzKCrnxxANJLIKSE85B8yIQ
         i3fmDtWupsA7tJ6udYuEJwc4t59sj85ixgxQabOmw6cEE6BcZkSh3L0zXbjvZuBdU07q
         MlhXnsPc+Wh4PUCxuX9KyIEqu/qnCXFr2ZgzsCw6hykb40YFV93PCzhD7Pu0xlPILGeq
         LMhgdWUBHgnRnQoMGeFb9VsbtLCzUdSjh91/MxZMaHs44OS9Qt5PLUePLfHsdR68TCVD
         GIFQ==
X-Gm-Message-State: AOAM530YxeEn+MaFXdLaQSzGpvdS2UAlXtpUdsPVuPfPkRx8rdOj4vQE
        DZyT6mHcGsVzZj6jN7smD/kQHUMts+tydCRY
X-Google-Smtp-Source: ABdhPJxFidjfeqEhuAMUwuUhWNo2qY9B+qaoJTK0pHmZCapyDlNwicQLGezCM6HqNzwWe25tdIV5Kg==
X-Received: by 2002:a37:4483:: with SMTP id r125mr3339120qka.387.1612998920182;
        Wed, 10 Feb 2021 15:15:20 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2c3d:3179:bfad:c65])
        by smtp.gmail.com with ESMTPSA id x7sm2207831qtv.58.2021.02.10.15.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:15:19 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:15:16 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] rev-list --disk-usage
Message-ID: <YCRpBCNJ2yNTbc2i@nand.local>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
 <xmqqh7mkycno.fsf@gitster.c.googlers.com>
 <YCOu70m5SKU7L4CS@coredump.intra.peff.net>
 <xmqq1rdn51gz.fsf@gitster.c.googlers.com>
 <YCREYmBsnv2wgvXZ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCREYmBsnv2wgvXZ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 03:38:58PM -0500, Jeff King wrote:
> On Wed, Feb 10, 2021 at 08:31:08AM -0800, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > But in practice, we've found this kind of naive --disk-usage useful for
> > > answering questions like:
> > [...]
> >
> > I kind of feel sad to have a nice write-up like this only in the
> > list archive.  Is there a section in our documentation set to keep
> > collection of such a real-life use cases?  Perhaps the examples
> > section of manpages is the closest thing, but it looks a bit too
> > narrowly scoped for the example section of "rev-list" manpage.
>
> Agreed on both counts. If this gets put into a release, I suspect Taylor
> would cover it in a release blog post. That is not quite the same thing
> as having it in the documentation, but it may provide more search engine
> boost than the list archive. I dunno.

Yeah, this is the perfect sort of thing for those blog posts.

But it makes sense to include some of these examples in our own
documentation here, too. git-rev-list(1) doesn't have an EXAMPLES
section, but maybe it should.

> -Peff

Thanks,
Taylor
