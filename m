Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CACFC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA1A61209
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhIKQhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 12:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhIKQhC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 12:37:02 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A43C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 09:35:50 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id y18so6457782ioc.1
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 09:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TSB2MUwI6WvvqAT/3FCJ5wtptFodB/R7b1yzyVXZfVA=;
        b=WlSc34snWEyeLZoWifEBwCMMkHM3r8dRpP42uH4nimPD03Z3TYdxTc8kWMgzVqdoEc
         ghDgvilnqHz98VT9ihfwVb79BidvA6rluy6UDxODb3y3sD6/cAHm0bXS/rQ+Ic/7Fz4U
         38LWhKXmWZ6NHwHmnZAGCAjBW7GEy8Uu43ZwfTJiXJ1eQIRfYa2A74cFuszXgIbZKcs9
         lZO28D/rKKAesSI73svXySflXlpjL7fcXUrhoROJdJMUpodjUhFn8el/m4ugkXuVjn+i
         M9LANcspdT5NDnLevx4dKjU+qndzKbJ50+6jYLTj86DOiDln8dmhFg1Fi6DJp3+YzHWZ
         3xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TSB2MUwI6WvvqAT/3FCJ5wtptFodB/R7b1yzyVXZfVA=;
        b=gD/pHphl2M7udQxTQgyDsk6mCsumlRXuQnM8065cUaacq05hsg881LHld9NKnmAish
         3EskMgnRrLhEwR3bNRmExOwitx58XDaYQMLARIwfKFtPD8iTjAm43F75LQn84kvTCgzG
         Q2FLq+vQjBkY0F5K29OUZRVnodgctLt8D1zHlSXkN8rd/72CHxQQn7TuP74NJQEbIsg8
         b/Tlf9wo1yVt9NMB7Hx386WCw1pFkmmaUNWSXnrXnlMKsBUErRImb7E/yFW9TwbSEdzg
         ceohh9eXIEu6J7Melg7uO1GAR5E6EbVPxaoEabkz4j5egC8k5VmeNcoBcrTz/8Gv5i+w
         Bkqw==
X-Gm-Message-State: AOAM532e03ioqC+fXI+ZC/hfqst2BhbXdsJF/r9karxDVqgeDIPPATJ8
        lSYIMVRITKMQ/0mkQddkacncuVgjrouse8BJ
X-Google-Smtp-Source: ABdhPJxN/VxW+fJ5/Qlz42UPLu0iajuHxlhbetXDtHD4q9ggawHiuEVcKiRjSlAHoZJAMYV2PwgHrg==
X-Received: by 2002:a5d:8a0e:: with SMTP id w14mr2489065iod.94.1631378149591;
        Sat, 11 Sep 2021 09:35:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m13sm1112204ilh.43.2021.09.11.09.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 09:35:49 -0700 (PDT)
Date:   Sat, 11 Sep 2021 12:35:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 7/8] builtin/repack.c: make largest pack preferred
Message-ID: <YTza5MVTcBgOFXRS@nand.local>
References: <cover.1631331139.git.me@ttaylorr.com>
 <a790ee5ac6c03d6832599e77f84c352f577d6287.1631331139.git.me@ttaylorr.com>
 <875yv79zot.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yv79zot.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 12:17:37PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Fri, Sep 10 2021, Taylor Blau wrote:
>
> > +	if (geometry) {
> > +		struct packed_git *largest = get_largest_active_pack(geometry);
> > +		if (largest)
> > +			strvec_pushf(&cmd.args, "--preferred-pack=%s",
> > +				     pack_basename(largest));
> > +		else
> > +			/*
> > +			 * The largest pack was repacked, meaning only one pack
> > +			 * exists (and tautologically, it is the largest).
> > +			 */
> > +			;
> > +	}
>
> Probably one of those cases where an assignment within an "if" is the
> better of two evils, despite the CodingGuidelines warning against it
> (but not forbidding it). The added get_largest_active_pack() could also
> learn to punt on a NULL argument, in which case we wouldn't need an
> assignment):
>
> 	struct packed_git *largest;
> 	[...]
>         /* If ...[...] */
> 	if (geometry && (largest = get_largest_active_pack(geometry)))
> 		strvec_push(...);
>
> I punted on re-phrasing the comment, because the current code invites
> the reader to start reading this block, then we see that we may do
> stuff, and then the comment applies to what we *didn't* do.

Of the two, I vastly prefer the form that doesn't require assignment
inside the conditional expression.

That comment could use an extra bit about how we don't handle
incremental repacks (since we don't bother looking at the size after
words in the case of `git repack -d` (which is neither all-into-one nor
geometric). Fixed both, thanks.

> > -		usage("read-midx [--show-objects|--checksum] <object-dir>");
> > +		usage("read-midx [--show-objects|--checksum|--preferred-pack] <object-dir>");
>
> Just an aside, but I'm surprised to see this use the older
> non-parse_options() usage API, which we're generally moving away
> from. usage_msg_opt() is generally better.

Opportunity for future cleanup. I didn't see any point to change it in
the middle of an otherwise unrelated series.

> > +		git config core.multiPackIndex true &&
>
> I remember a similar pattern from another series, does this test pass
> without the config being set? I didn't check...

It does! This test was written long before 18e449f86b (midx: enable
core.multiPackIndex by default, 2020-09-25), but since 18e449f86b that
line is no longer necessary. Thanks for noticing!

Thanks,
Taylor
