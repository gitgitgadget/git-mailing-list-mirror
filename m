Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7772C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2A964E27
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhBWBHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 20:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhBWBHA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 20:07:00 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B692C061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 17:06:20 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id h8so14713094qkk.6
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 17:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tazvG7d7tOhAxgRY3BO5Gkzn/XwWOFJPKYE7DPRlDio=;
        b=OC5HdqjRP8Vig2u5+/U/lA25IwUhRgwaVLuNswP1s5TCrJZxPPZicr7wufyDVdR0cv
         Bj5galdcJQzOfdc6ir6cHkKkPU893Pn4QuHVZcuPxQgD4OkjP+p4DR06E+2myGD+jxRZ
         ZTihj2Uw4Crn46rRkO1H5s8P6adlwv1GXYUyYGx8vmitjy/x7IGEOrgsBIRYqNESI+y/
         mAGT5VZ/BkhKdF5ksbNrLqWkynHnHHsl1QdJBbhrIG4H5k+ZAE7ETbjZgA2xwF93kKe8
         x03mbrI/+4Vtsbm1rZHGfmZiMP/MEtWxMXPXKGNFJh3yiUS1rh0Mio9p2Qr1FVvbossJ
         EoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tazvG7d7tOhAxgRY3BO5Gkzn/XwWOFJPKYE7DPRlDio=;
        b=IXAVncMGXqMK/AYIjARJeLslM/b0CZ/9UgWlHyWFLAHxLKwPIjkvq69BO6ztSo+RNr
         qLjSwGIgymrbCIi7vmHnDKARR6gUjQdsVgNm9EoBcI2GSib0xyYU5ufx46sw4ekz7PaS
         aMA3uF4gCKOp/q2dG5iAad6jHAuOEiPpOir3dqXveTilFC3ec0O2c97YzHZdMz5PIANP
         bDINUuxB5RZEJjcRWA60eJJkwBUki//k/GgKLbkE96RlbsG5g94fBIw4hqBTM2MNdFXq
         gjcaIrpeOFwqA4hHOmf2dbqE2DtMzracZAlCtZgPOimse5bVx2sEKjsUrez52v62kjOe
         PTYQ==
X-Gm-Message-State: AOAM5334h0lzOQhMsoxUfqagVXBsz3Ld8ttC6xdw6t/2tBTW3lB8p6af
        rB6imEtsJoEbd5HSPqeIkJYFhA==
X-Google-Smtp-Source: ABdhPJys6BO1unZs7rD0QstX5sngTdD/ovvfi9nrGGdFyF13QVdmykqYKjqZeA3vtkshhxmHGGSG0Q==
X-Received: by 2002:a37:a889:: with SMTP id r131mr23989530qke.410.1614042379464;
        Mon, 22 Feb 2021 17:06:19 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:29df:918f:599f:2c96])
        by smtp.gmail.com with ESMTPSA id r3sm9149294qkm.129.2021.02.22.17.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 17:06:19 -0800 (PST)
Date:   Mon, 22 Feb 2021 20:06:16 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v3 0/8] repack: support repacking into a geometric
 sequence
Message-ID: <YDRVCIdwRTw4PoMR@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1613618042.git.me@ttaylorr.com>
 <YDRM0E+GjLlXoSwC@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDRM0E+GjLlXoSwC@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 07:31:12PM -0500, Jeff King wrote:
> On Wed, Feb 17, 2021 at 10:14:11PM -0500, Taylor Blau wrote:
>
> > Here is another updated version of mine and Peff's series to add a new 'git
> > repack --geometric' mode which supports repacking a repository into a geometric
> > progression of packs by object count.
>
> Thanks. This version looks pretty good to me. I have a few inline
> comments below. Mostly just observations, but there a couple tiny nits
> that I think may justify one more re-roll.

Thanks for taking a look; I agree that your comments do justify a
re-roll. But I think that one can be done without touching any of the
code (or maybe one line of code), depending on my question below.

Let's see...

> > [snip documentation]
>
> We don't have a real procedure for marking something as "off limits" for
> users. IMHO omitting it from the documentation and putting an explicit
> note in the commit message is probably enough. It would be perhaps
> stronger to mark it explicitly as "do not touch" in the documentation,
> but then we are polluting the documentation. :)

I agree; and the second paragraph in the quoted snippet is the "do not
touch" one. So I think this one is good as-is.

> I also wondered if we could piggy-back on the sorting of packed_git,
> which is already in reverse chronological order. But here our primary
> structure is the string-list, so we lose that order.
>
> I'm not sure if your sort function is going the right way, though. It
> does:
>
> >     ++static int pack_mtime_cmp(const void *_a, const void *_b)
> >     ++{
> >     ++        struct packed_git *a = ((const struct string_list_item*)_a)->util;
> >     ++        struct packed_git *b = ((const struct string_list_item*)_b)->util;
> >     ++
> >     ++        if (a->mtime < b->mtime)
> >     ++                return -1;
> >     ++        else if (b->mtime < a->mtime)
> >     ++                return 1;
> >     ++        else
> >     ++                return 0;
> >     ++}
> >     ++
>
> Does that give us the packs in increasing chronological order, but then
> decreasing chronological order within the packs themselves?

I agree we should be sorting and not blindly accepting the order that
the caller gave us, but...

"chronological order within the packs themselves" confuses me. I think
that you mean ordering objects within a pack by their offsets. If so,
then yes: this gives you the oldest pack first (and all of its objects
in their original order), then the second oldest (and all of its
objects) and so on.

Could you clarify a bit how you'd expect to sort the objects in two
packs?

> > 17:  b5081c01b5 !  5:  181c104a03 p5303: measure time to repack with keep
> >     @@ Metadata
> >       ## Commit message ##
> >          p5303: measure time to repack with keep
> >
> >     -    This is the same as the regular repack test, except that we mark the
> >     -    single base pack as "kept" and use --assume-kept-packs-closed. The
> >     -    theory is that this should be faster than the normal repack, because
> >     -    we'll have fewer objects to traverse and process.
> >     +    Add two new tests to measure repack performance. Both test split the
>
> s/test split/tests split/, I think.

Good eyes, thanks.

> >     +    Likewise, the scaling is pretty extreme on --stdin-packs:
> >     +
> >     +      5303.7: repack with --stdin-packs (1)       0.01(0.01+0.00)
> >     +      5303.13: repack with --stdin-packs (50)     3.53(12.07+0.24)
> >     +      5303.19: repack with --stdin-packs (1000)   195.83(371.82+8.10)
> >
> >          That's because the code paths around handling .keep files are known to
> >          scale badly; they look in every single pack file to find each object.
>
> Your "that's because" is a little confusing to me. It certainly applies
> to the repack vs repack-with-kept comparisons for a given number of
> packs. But the scaling on the three --stdin-packs tests is high because
> each subsequent test is being asked to do a lot more work. But they're
> still cheaper than the matching "repack" case with a given number of
> packs. Just not _as_ cheap as they would be if the kept code weren't so
> slow.
>
> Would it make sense to reorder those two paragraphs?

I think so. I did add a tiny parenthetical after my "Likewise, the
scaling is pretty extreme [...]" to say "(but each subsequent test is
also being asked to do more work)".

> >     ++Loose objects are implicitly included in this "roll-up", without respect
> >     ++to their reachability. This is subject to change in the future. This
> >     ++option (implying a drastically different repack mode) is not guarenteed
> >     ++to work with all other combinations of option to `git repack`).
>
> Likewise, this is a big improvement. But should it make it clear that
> touching loose objects requires --unpacked? I.e., something like:
>
>   When `--unpacked` is specified, loose objects are included in this
>   "roll-up" without respect to their reachability...
>
> Also, s/guarenteed/guaranteed/.

Agreed on both, thanks.

Thanks,
Taylor
