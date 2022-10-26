Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCA0C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 19:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiJZT7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 15:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiJZT7s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 15:59:48 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6B8422D8
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:59:45 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id p141so1601714iod.6
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGIqhOhzNJW5l+usH8hsGAi+2exdim4R7O8Nv0e+ftw=;
        b=UenLxpfxuBHoskrwOPSqIXp7+epUDLWEUlD2+sXBywJ4Wn7HxqS1sUn4cveljdhrUr
         BJngJ/Z4+32GJr9tX5SNlkuUlDUdQZ4/pBzU0XO+Fq4HW2uOoXdCCRf03NOgKGXfaVEO
         suw2DbeCxCHZiv7pzTWt4aGCxT5IevRY0WM8niFQm69MsaxKxwXlFQ0nNAFx8bZIIQu2
         L8vsVoMqHw2HjSOv3Flrm/iTcinHrSswQhgDz7KOYtrW/OybhB6FXVOBFbrETHNS4ear
         lPotWajsFZql/1bVkG/tFhvNr5aME2fZzmQ+6x+pNxL74A4HD79xQVgnesxYZd0Pw+Bv
         z2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGIqhOhzNJW5l+usH8hsGAi+2exdim4R7O8Nv0e+ftw=;
        b=JBnxVg79WX+rewmXNiGI2XmT6s9k28z0XR0SYsf2+2dK9/Er+3kdNaM/mWxb32Hzgr
         VN+01qXEG4OB9JeyElUnvlDmxMtfOSGVD8CNypLL5Xbjdef8Lg6GO6xtqwGVtrci0grN
         PKx+Fc5dFsq8pVYYGuiOtyVjiXfNj/dEMdvEWTX9EaJm5I6DjzrI1Kly522iTTnSL5ju
         dEBLJSUpWPbiJgXL2TN2uPZBVbOtvGdVITYIqkK64K+rANs20NYy7G63TLYlBN3zt1A4
         B1GsQQWKBvS6J7o0q3InMllz62tNKeZCmaGctB3a24vYeM9EVoHlP4fR4/eL0HgOno9e
         OHIQ==
X-Gm-Message-State: ACrzQf3KSeQHH6oCdOm50P2cnE+Y9PHb4X1o1NZx+unFWkrmfPSKEJSf
        Vnqisgfn0j/W7i+URhXCOf4HfQ==
X-Google-Smtp-Source: AMsMyM7bxQ6Ss0LCa7oT5Y0/zSJu8461OTeB4Wzj5TvAJ5Hu2RdeuxpT9wiP1P/rpDW7HoJ3qE0TwA==
X-Received: by 2002:a05:6638:408a:b0:363:e307:8433 with SMTP id m10-20020a056638408a00b00363e3078433mr28441118jam.221.1666814385142;
        Wed, 26 Oct 2022 12:59:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p8-20020a056e0206c800b002fa7b6e9cf5sm2352594ils.31.2022.10.26.12.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:59:44 -0700 (PDT)
Date:   Wed, 26 Oct 2022 15:59:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] midx.c: clear auxiliary MIDX files first
Message-ID: <Y1mRr04M9+5wUs3q@nand.local>
References: <bf36093cd6d7ac83b16241b0199b3a8c904e6774.1666722316.git.me@ttaylorr.com>
 <Y1jIo1dPl0M2TSHo@coredump.intra.peff.net>
 <143a588a-c98b-733b-2b23-34a87ca89431@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <143a588a-c98b-733b-2b23-34a87ca89431@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 09:31:28AM -0400, Derrick Stolee wrote:
> On 10/26/22 1:41 AM, Jeff King wrote:
> > On Tue, Oct 25, 2022 at 02:25:20PM -0400, Taylor Blau wrote:
> >
> >> Since they were added in c528e17966 (pack-bitmap: write multi-pack
> >> bitmaps, 2021-08-31), the routine to remove MIDXs removed the
> >> multi-pack-index file itself before removing its associated .bitmap and
> >> .rev file(s), if any.
> >>
> >> This creates a window where a MIDX's .bitmap file exists without its
> >> corresponding MIDX. If a reader tries to load a MIDX bitmap during that
> >> time, they will get a warning, and the MIDX bitmap code will gracefully
> >> degrade.
> >>
> >> Remove this window entirely by removing the MIDX last, and removing its
> >> auxiliary files first.
> >
> > We remove that window, but don't we create a new one where a reader may
> > see the midx but not the bitmap? That won't generate a warning (it just
> > looks like a midx that never had a bitmap generated), but it will cause
> > the reader to follow the slow, non-bitmap path.
>
> Yes, this is the worrisome direction. The midx is read first, then that
> points to the .bitmap file (based on its trailing hash). If the midx isn't
> there, then the .bitmap will not be read.

Yes, thinking on it more I agree with this and (the elided) analysis
below.

Let's drop this one. Thanks, both!


Thanks,
Taylor
