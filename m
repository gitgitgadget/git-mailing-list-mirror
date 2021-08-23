Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0086C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E7260EE0
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhHWRKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhHWRKH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 13:10:07 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BC5C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 10:09:24 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b7so22720758iob.4
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 10:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gkDRLvDHXv/bsxIhcN/rXLP32h0DYZSvDISzgChCQ6Y=;
        b=ITZlQFX0tk83rspefl2v00wky1INLk7LgarXRDCG56v8Yk5FuILGAZzY/07QNUtUuv
         KSqxhxZX8IFFOjNm07bXy+EpMdHje52LZszFQtD3UY7wEyYnxgnV/MaNjqI9VwLN8kr2
         CQQTCV3ls8DIjwN1R8lpTnukkkZ9HbRKzyaA0G7sFeNJLywvfaRnlUqv/36jej+61/s3
         Mj5cUShWcj+Me6D0+Pwe6Kp/Id1bSIlfvK79UcB/ILNzoh1SeIr8BS9KeMKGRW+bT2hM
         PEHtwjfRRlk313ZmkgeAbm+hSOEExdJfPi05PHY3xuwa4x25QAhheSUD1+ndQXwp0mff
         Pjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gkDRLvDHXv/bsxIhcN/rXLP32h0DYZSvDISzgChCQ6Y=;
        b=uksEFspP2N+Cb+gWES3pWd/Kcmht8SXni2p9I7TR4UuTZK1tI+OmlKH51Az7byXpHm
         XtGEZIXK2nYw3vPXnRjh0LdRKDiabmCb0I2gID3KkLVpCMrYodVV6T6DopjZQUP+xIGm
         tlYV3YdGgicYAHrc5dfmb0twb0iIk/X27YVi6L0clH2ndlA1u4CQ8ee5EEbLUdUSSi9O
         l6T8eocMpjIxjniIIC7lPUQr0mQJvkjvQukgHzpUtU4Ofdoc0TYH29nfN4K201dSKrIy
         I0lD1noGGnWIHn2O8Ku8C+AgeQbTAlSUcfxJkQ7vgvU4lRfjSLat14aDngESIJI23Gs/
         Pvvw==
X-Gm-Message-State: AOAM532L7sA8hdnrDR4W4CVHXPHgcK0EVPij87ROM8L9DzqpFIz3m7ue
        SA9DqlP0VO/TpRIjrVJnOgyTBg==
X-Google-Smtp-Source: ABdhPJxOOZZ6tW6IS+pXJo3oP9klwZDb/KyQF78JLOl5MHB/dxBoI0BRjnv7AVtJ925ylFwfbR4/LQ==
X-Received: by 2002:a5d:8a05:: with SMTP id w5mr18866901iod.155.1629738563742;
        Mon, 23 Aug 2021 10:09:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z8sm4905342ilm.29.2021.08.23.10.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 10:09:23 -0700 (PDT)
Date:   Mon, 23 Aug 2021 13:09:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] multi-pack-index: fix *.rev cleanups with --object-dir
Message-ID: <YSPWQtOjKVgIKqsd@nand.local>
References: <20210823094049.44136-1-johannes@sipsolutions.net>
 <YSPHdofrDOQk3xmy@coredump.intra.peff.net>
 <be882704d7cf2a96a78c5c745c0bca2c53150a28.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be882704d7cf2a96a78c5c745c0bca2c53150a28.camel@sipsolutions.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 07:05:31PM +0200, Johannes Berg wrote:
> On Mon, 2021-08-23 at 12:06 -0400, Jeff King wrote:
> > I'm not entirely convinced that writing a midx when not "inside" a repo
> > is something that we want to support. But if we do, then...
>
> Seemed like that was the point of --object-dir?

Stolee (cc'd) would know more as the original author, but as I recall
the point of `--object-dir` was to be able to write a midx in
directories which were acting as Git repositories, but didn't contain a
`.git` directory.

It's kind of a strange use-case, but I recall that it was important at
the time. Maybe he could shed more light on why. (Either way, we're
stuck with it ;)).

Thanks,
Taylor
