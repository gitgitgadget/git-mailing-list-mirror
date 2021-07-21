Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F41CC6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 20:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 114B661241
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 20:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhGUTfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhGUTfe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 15:35:34 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5512FC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 13:16:09 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id z1so3460375ils.0
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MuY67mxz9SC4xAiGopeSmtGdA9agc/a3Nf7zJiYvFhg=;
        b=L06Uhwl+7CKiUJ4WGup68cG1EuLid6wl3Rf/sbW1frXDyBSxY2LoR9yw+zu3AQC46A
         ntU6NhwtpbeUgFHpMkhlFUxWwfIlr8qx4S08Ees99mWfQ0V6yv2X9JVfeXZni+cUYSr8
         sPAFlxY0/UjPbF5JJ5XJodMyixZzIp2MlOY8lmF48oXPTTXB3I9fK9hsWFDA+cWDhtE5
         zmFdUGWC9IYAkZc3M3Qv/fXIoKbjuS0FFx+Qnfjq/ekZQ9B2J6tbJSnSufl/JRDNybQv
         ZaROs0AkSEPtldwcIrOcJ7Ow0a8wDCvUaV4bRYAUnjtlqHkhWR5z7y0tDR/zZeVOQZOO
         QWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MuY67mxz9SC4xAiGopeSmtGdA9agc/a3Nf7zJiYvFhg=;
        b=RBx8mSo4bz2RmZI3IvzSLdyQeNQJT4gRXiz3CW9XFpnum1K+x7CzZIONX3lmHqbQLa
         FcbVurhYR0yWIz/Q7IphhmKAjt+GP51i3Bz5QxeoEdlCOjTRUhXw3qtaKSN7S2lpuCSA
         o3Nk3jEVNEB6fXHOxe2y9c2swVC5Dwl5k+bYAI6vxfzj98VhJKb7xoD7jk0p4n/a6Uqw
         jUVPIqX/TwMpak+Eg59wL0xg8dQLIafD08U5CCwYwDw+PVDTZZtqRUXq5lrV3MjxKS1Y
         SLqGkfWXMJUOEotAVOEc+1BqEmCoTmcT+dVQLHyde7qA0D3UETCbXE75MItO+yT3bBsf
         AmoA==
X-Gm-Message-State: AOAM532qynsPl9e04vZ+FBNsBaK9yNP/7pQMasUxCjpczOvZXwLoW/jl
        qZSukvZDW6cG2m0eRj3CTx5DIw==
X-Google-Smtp-Source: ABdhPJwZ08DIDX8g7OaH/8OOqv7zIdZ7ByUgXZCFV+69wb2jmD7sMHl2pIWKV4aNJHIsg1E1amY1Dw==
X-Received: by 2002:a92:507:: with SMTP id q7mr21136837ile.81.1626898568767;
        Wed, 21 Jul 2021 13:16:08 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:2c46:d8ae:a4c3:9466])
        by smtp.gmail.com with ESMTPSA id h10sm15281194ioe.43.2021.07.21.13.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 13:16:08 -0700 (PDT)
Date:   Wed, 21 Jul 2021 16:16:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 09/24] midx: infer preferred pack when not given one
Message-ID: <YPiAhw2eP2MOksUF@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <9495f6869d792264c4366c9914fcf93d544caa6a.1624314293.git.me@ttaylorr.com>
 <YPf4MTDpbvinoIia@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPf4MTDpbvinoIia@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 06:34:25AM -0400, Jeff King wrote:
> On Mon, Jun 21, 2021 at 06:25:21PM -0400, Taylor Blau wrote:
>
> > In 9218c6a40c (midx: allow marking a pack as preferred, 2021-03-30), the
> > multi-pack index code learned how to select a pack which all duplicate
> > objects are selected from. That is, if an object appears in multiple
> > packs, select the copy in the preferred pack before breaking ties
> > according to the other rules like pack mtime and readdir() order.
> >
> > Not specifying a preferred pack can cause serious problems with
> > multi-pack reachability bitmaps, because these bitmaps rely on having at
> > least one pack from which all duplicates are selected. Not having such a
> > pack causes problems with the pack reuse code (e.g., like assuming that
> > a base object was sent from that pack via reuse when in fact the base
> > was selected from a different pack).
>
> It might be helpful to use a more descriptive name for "pack reuse code"
> here, since it's kind of vague for people who have not been actively
> working on bitmaps.
>
> I don't have a short name for that chunk of code, but maybe:
>
>   ...causes problems with the code in pack-objects to reuse packs
>   verbatim (e.g., that code assumes that a delta object in a chunk of
>   pack sent verbatim will have its base object sent from the same pack).

Thanks; I like what you wrote here.

> >   - The psuedo pack-order (described in
> >     Documentation/technical/bitmap-format.txt) is computed by
> >     midx_pack_order(), and sorts by pack ID and pack offset, with
> >     preferred packs sorting first.
>
> I think the .rev description in pack-format.txt may be a better
> reference here.

Ditto, I changed that, too.

> >   - But! Pack IDs come from incrementing the pack count in
> >     add_pack_to_midx(), which is a callback to
> >     for_each_file_in_pack_dir(), meaning that pack IDs are assigned in
> >     readdir() order.
> >
> > [ ... ]
>
> This explanation is rather confusing, but I'm not sure if we can do much
> better. I followed all of it, because I was there when we found the bug
> that this is fixing. And of course that happened _after_ we implemented
> midx bitmaps and in particular adapted the verbatim reuse stuff in
> pack-objects to make use of it.
>
> I see why you'd want to float the fix up before then, so we don't ever
> have the broken state. But it's hard to understand what bug this is
> fixing, because the bug does not even exist yet at this point in
> the series!
>
> I dunno. Like I said, I was able to follow it, so maybe it is
> sufficient. I'm just not sure others would be able to.

I think that others will follow it, too. But I agree that it is
confusing, since we're fixing a bug that doesn't yet exist. In reality,
I wrote this patch after sending v1, and then reordered its position to
come before the implementation of MIDX bitmaps for that reason.

So in one sense, I prefer it this way because we don't ever introduce
the bug.  But in another sense, it is very jarring to read about an
interaction that has no basis in the code (yet).

I think that the best thing we could do without adding any significant
reordering would be to just call out the situation we're in. I added
this onto the end of the commit message which I think makes things a
little clearer:

    (Note that multi-pack reachability bitmaps have yet to be
    implemented; so in that sense this patch is fixing a bug which does
    not yet exist.  But by having this patch beforehand, we can prevent
    the bug from ever materializing.)

Thanks,
Taylor
