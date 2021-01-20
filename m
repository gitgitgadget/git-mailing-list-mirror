Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E71C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 14:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8081A2245C
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 14:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbhATOvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390512AbhATOjB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 09:39:01 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A86C0613D3
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 06:38:21 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id h22so856550qkk.4
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 06:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S0s32AhLaPh1NKRkfZZzRoMwCIYjjY39b7fmiVRCHmE=;
        b=1Ks6vNzDw5Enrc3L8e6h6lmDWPG7XHukUJGTIpfvYypqe/vCxZesssgUDg7pNQbP2w
         X0MY3i6VFCaplzczi7tz0cPx6wU0aqQKsAXpvnq3VBsmarn9S+fDxppmy8lAyd+5U0lG
         1dod8LeuF+aQzueR9RY6J9fVntJ4wJBRus3jy1kTrfx0puV3ulL/BQMTknyCQBOqkHxp
         /NcDthJTbkq2ZVrt0RiiDZ5rMoPMMslFIKYmjsqoLgAY0PpPKBofDadiSd42/sM6Goqo
         Qi0Xy8dEsIdeWvlJjGPfx8msiozx72vRGsioLEGu12pjPpHARSjat5MV4bF6fY9mV1Ps
         5x8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S0s32AhLaPh1NKRkfZZzRoMwCIYjjY39b7fmiVRCHmE=;
        b=bXral4KcN9eYHJG901doEiVPG2mK+Xyezkl6MFt4MplMGR+plgf4ZAZlv1vi5gbBXr
         8HtdLKV7LHCUSXYUlPqeIfHXDslPw/aUT5VCRinuL6AVjoCmrKVwPWAzhZPI1fDcDzHT
         fU85vJmp1zrfxDRo3ycRVNtk71cYL21d5E7D+l37proY1n99nQFLJ4XchTEUzDz4lcoF
         JvMFp5V9yhCgRRbUXgq9vHdHAoRtcD+YWvbMVi7VeoPhHIlf824D8vRpuemC/O6XFTtw
         1SX0rQlEHOwW7gMjbv1Iel9dfcqPVhbmwbI4JjxZwBotoVyfya3trGP4agRLHdf5E8OB
         n5gQ==
X-Gm-Message-State: AOAM530taozDsIJIk1KBvCBFQDxCxKl8fjK4mpcoOy2G5NcisayV278e
        b94pYgl4ivWvgM8Xsi+QGA7/QCj1QkyaGA==
X-Google-Smtp-Source: ABdhPJzXoxeTJfNipDCb//zt1hlwhPTL6nRKHb+K3rUleAy5ignYTIFsCw0GBw8yINIJvXpfF5+GAA==
X-Received: by 2002:a37:c92:: with SMTP id 140mr9608690qkm.152.1611153500742;
        Wed, 20 Jan 2021 06:38:20 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id j66sm1441694qkf.78.2021.01.20.06.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 06:38:20 -0800 (PST)
Date:   Wed, 20 Jan 2021 09:38:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH 01/10] packfile: introduce 'find_kept_pack_entry()'
Message-ID: <YAhAWUw6Hzs9nG8Z@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <dc7fa4c7a61f657e779e10385d3e8076d6dac36c.1611098616.git.me@ttaylorr.com>
 <607e7ebd-240d-f2dc-42ef-1d5a5a0b7f51@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <607e7ebd-240d-f2dc-42ef-1d5a5a0b7f51@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 08:40:22AM -0500, Derrick Stolee wrote:
> On 1/19/2021 6:24 PM, Taylor Blau wrote:
> >  	for (m = r->objects->multi_pack_index; m; m = m->next) {
> > -		if (fill_midx_entry(r, oid, e, m))
> > +		if (!(fill_midx_entry(r, oid, e, m)))
>
> nit: we don't need extra parens around fill_midx_entry().

Yep. I checked whether we should have written this as "if
(fill_midx_entry(...) < 0)", but fill_midx_entry returns a positive
number on error, so checking "!fill_midx_entry" is certainly what we
should be doing.

> > -		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
> > -			list_move(&p->mru, &r->objects->packed_git_mru);
> > -			return 1;
> > +		if (p->multi_pack_index && !kept_only) {
> > +			/*
> > +			 * If this pack is covered by the MIDX, we'd have found
> > +			 * the object already in the loop above if it was here,
> > +			 * so don't bother looking.
> > +			 *
> > +			 * The exception is if we are looking only at kept
> > +			 * packs. An object can be present in two packs covered
> > +			 * by the MIDX, one kept and one not-kept. And as the
> > +			 * MIDX points to only one copy of each object, it might
> > +			 * have returned only the non-kept version above. We
> > +			 * have to check again to be thorough.
> > +			 */
> > +			continue;
> > +		}
> > +		if (!kept_only ||
> > +		    (((kept_only & ON_DISK_KEEP_PACKS) && p->pack_keep) ||
> > +		     ((kept_only & IN_CORE_KEEP_PACKS) && p->pack_keep_in_core))) {
> > +			if (fill_pack_entry(oid, e, p)) {
> > +				list_move(&p->mru, &r->objects->packed_git_mru);
> > +				return 1;
> > +			}
>
> Here is the meat of your patch. The comment helps a lot.
>
> This might have been easier if the MIDX had preferred kept packs
> over non-kept packs (before sorting by modified time). Perhaps
> the MIDX could get an extra field to say "I preferred kept packs"
> which would let us trust the MIDX return here without the pack
> loop.
>
> (Note: we can't just change the MIDX selection and then start
> trusting all MIDXs to have the right tie-breakers because of
> existing files in the wild.)

Yeah, that is what makes it tricky. Changing the code isn't so hard: a
new field that we check and do one of two things when we're breaking
ties.

But I think the cognitive load is high, and I'm not sure that the
benefit (skipping another linear pass through non-MIDX'd packs when
looking up an object in kept packs only _and_ that object is duplicated)
is worth the extra hassle with the MIDX code.

All of that said, I do think that it's worth revisiting this and giving
it some more thought after multi-pack bitmaps to see whether we feel the
same or not.

Thanks,
Taylor
