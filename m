Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740A8C71155
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F4EC221FF
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgLAXFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 18:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgLAXFC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 18:05:02 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1316AC0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 15:04:17 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id x24so2179275pfn.6
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 15:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uod9tNoGOIqhDiWiTU6MgfBo/mgZ5eKmAU4pe0Tu/pk=;
        b=Xms5H6cdnOGBpaHF10nbJY3t5VfWwKAclnAI9saX78ANEZGReD6nP8Wqfov7/pxhec
         bvmSHtJNxcZyQcII9gVCG135q3Rd+/Oh8j1aMZoOGwyQEVJ7FOkp4MJJGcdTZWpqYLwE
         0/6KlNJykamBkaUOAwgDmKLE19uo8ZoQi/xSDJc8/uGRxEo54AKcOMPCbeyHlvbLhVCd
         3muRCmJJXjDI8WWxFD8X/doF2oYq469TCUkIZleoJGcHfq7htyXDKsgZQc8WMKN4C3nf
         Kkg8CotAnaYH3UHBOsF5jc4EWAQxGVFemx2EO+e+N8B1UaFsIT1SY6FlXh1NhfCgVWss
         duOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uod9tNoGOIqhDiWiTU6MgfBo/mgZ5eKmAU4pe0Tu/pk=;
        b=X+EPCMLUn+PTwlDrdQj84qkCi6AQmdP5kK4Fr6NmxiOTiugTkehEa8bFuMmD0XBRwd
         riA85qZeybLJrO1yYlvLa9QBCLcQlvv7jT9SOGCR9hUDA3OLJeoEiKqxf8KkTqTkf0r0
         7M9F2CU4Knf4wtbf9f9EdJ0lUiOXq2QilI2DyYf8PkwrIR341Ujnr96cm2rtZJGFtWNY
         GmlRsT35dQ32TCY9/uslK7G+QE46uDZhmm20nai/iFSNJBaH2zdGoHTwDtqKqs/K3EAG
         cnZmxQgSUHBtfF/OhI7tWqpAaMdSoKLxa4CSRiym3fVYwZCXgzj14QPRT9SVsTFnmrfo
         uFYg==
X-Gm-Message-State: AOAM533i/PbQnlkZeITt6NY1q/t/1be5+fc8ZpCTjHmUKZsqBgtp8j3h
        fi2ID/2aGB3kcDRqdErN0c65tQ==
X-Google-Smtp-Source: ABdhPJxuDYJ/MroHiYyQFwvwNxKmHC81PsK2XV8fHvfvRbkBuH7XmTeDhGh0837Oe0gHMrul6qp2Gw==
X-Received: by 2002:a63:5f01:: with SMTP id t1mr3022999pgb.136.1606863856616;
        Tue, 01 Dec 2020 15:04:16 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id w131sm760012pfd.14.2020.12.01.15.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 15:04:15 -0800 (PST)
Date:   Tue, 1 Dec 2020 18:04:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 00/24] pack-bitmap: bitmap generation improvements
Message-ID: <X8bL7baFdXufk2jj@nand.local>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1605649533.git.me@ttaylorr.com>
 <CAN0heSq59uX=4pqkhc904oLfeiwF5ctiEb_9cQXYY7T1t=Mt1g@mail.gmail.com>
 <xmqqy2iusdpy.fsf@gitster.c.googlers.com>
 <CAN0heSpVnzyE5S5ReKQ0Q_UU48jQ77NVF1x1NTGx29+5KZsyRA@mail.gmail.com>
 <X7nNlu8wBZw3xFjX@xnor.local>
 <X7xzWClGr3bM3wcg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X7xzWClGr3bM3wcg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 09:43:36PM -0500, Jeff King wrote:
> On Sat, Nov 21, 2020 at 09:31:50PM -0500, Taylor Blau wrote:
>
> > > There was SZEDER's comment on that last patch in v2, where future
> > > readers of that patch will have to wonder why it does s/256/270/ in a
> > > test. I agree with SZEDER that the change should be mentioned in the
> > > commit message, even if it's just "unfortunately, we have some magicness
> > > here, plus we want to pass both with SHA-1 and SHA-256; turns out 270
> > > hits the problem we want to test for".
> >
> > Thanks for reviewing it, and noticing a couple of problems in the
> > earlier patches, too. If folks are happy with the replacement that I
> > sent [1], then I am too :-).
> >
> > I don't think that the "big" patch generated a ton of review on the
> > list, but maybe that's OK. Peff, Stolee, and I all reviewed that patch
> > extensively when deploying it at GitHub (where it has been running since
> > late Summer).
>
> Hrm. I thought you were going to integrate the extra checks I suggested
> for load_bitmap_entries_v1(). Which is looks like you did in patch 17.
> After that, the s/256/270/ hack should not be necessary anymore (if it
> is, then we should keep fixing more spots).

Oops. I even wrote down a big "S/256/270" in my notebook after you and I
talked last about it, and then promptly forgot about it before sending
v2.

In any case, I have all of that fixed up, as well as other comments and
suggestions from review, all of which were very helpful. (Thanks
everybody who took a look at this monstrously large series, and
apologies in advance for more to come ;-)).

I think I would like a little more clarification on the discussion in
[1]. From my reading, Jonathan Tan wants comments about the algorithm in
the code, but Stolee would rather rely on the commits, especially since
the algorithm changes later on in the series relative to the patch that
this is downthread from.

Once we can reach a good decision there, I'll send a v3 (which currently
lives in my fork[2]).

> -Peff

Thanks,
Taylor

[1]: https://lore.kernel.org/git/ea0c8c5d-6bc3-0dca-4fa1-fb461ed7ccb9@gmail.com/
[2]: https://github.com/ttaylorr/git/compare/tb/bitmap-build-fast-for-upstream
