Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D014C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 01:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E84A20739
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 01:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWQsKHFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgCTBfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:35:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38749 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCTBf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 21:35:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id x7so2251078pgh.5
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 18:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=98k10VVx6pwtE4NdCgDG5UDarNGMhcxRZn1dApq8CvM=;
        b=WWQsKHFi55ssRs6V4b6hAEzmiCBFj7tpIraZS8kStLaZU51rOhCoQSL/jQwOXjFEdJ
         SCahDKVCiacalWqDslYr9Fs+1L++ms/Z98aF1PtsM9/rOddVyhn3V32ulZjcaGL8MkGl
         J0fCQrNL82u4vF4I53/LLSIe+N7rpbKohSK9jl6SZIz9AHIUa+lft2xZxBZSfS44qgBF
         qZdjzDD7icSuCsuOJjLXoFbGHy691DK/uR/Ff2uNVEkmIP47KGi2TnvTsL1QFF0rUe3u
         ZNRzMTN1s/bBmVM4he+yrIw4IJVYNC40fBgeK3wlvSm2XzCm+uQStM9HpNgHQqSbkZAt
         WuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=98k10VVx6pwtE4NdCgDG5UDarNGMhcxRZn1dApq8CvM=;
        b=EYX7zyd4o1ndjxvbz41JbU1y3rwxhAZfjBBVw4wpUbXENOYrYIvi31Ozl4HH2yg2E3
         Rk3c0/Z/RlR4Fk7Lo/bAmtpL1DaYSuHTKkSzu4f/Zy81ywkzwZ8etuxRDJr1j99fLew/
         x1TDlATdO1KJOjlUgRSTFXuhR0wAiOQndzZXtrrs5lulqqUGQ+MPtIMJZdxD6GHDjWDW
         xCRCq17lIQ2/JIoF5rKVKZM5wo/SiSmxz+SLDNJy2IykAZXrsYmr/QGUFkSkVJzoYf8q
         QkenH/+H0LPj3DlspV11YhDN0y1Ek2bxIOGRbo8h6UlASJZ+OdtFzYfufEWPJgGw6OlY
         wMsg==
X-Gm-Message-State: ANhLgQ2OKjrGIwFTjYNdyLgvm8Ziyr6A9FUdNMVAnc9Zn1FSWEAbC/2P
        4XC3/OAo6t+x7Fy/8vLtmUo=
X-Google-Smtp-Source: ADFU+vtLUtKVLlGaHqEUT6Qu1UPjN/2ackMtdpPrNtIh2zVu/+KblCExw+EB+leho6F94ob51oQygw==
X-Received: by 2002:a63:30c4:: with SMTP id w187mr6442012pgw.239.1584668128998;
        Thu, 19 Mar 2020 18:35:28 -0700 (PDT)
Received: from localhost ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id d7sm3703776pfr.17.2020.03.19.18.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:35:28 -0700 (PDT)
Date:   Fri, 20 Mar 2020 08:35:26 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] t4061: use POSIX compliance regex(7)
Message-ID: <20200320013526.GE1858@danh.dev>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <c45d6383173d8d3e73cdcdd6e993d3259d519a68.1584625896.git.congdanhqx@gmail.com>
 <20200319155307.GB3513282@coredump.intra.peff.net>
 <CAPig+cRzHtGu2KfjoO4DaPWzDrJOhEQGkgo2Fm7egUPM9m7Vyw@mail.gmail.com>
 <xmqqwo7gc8aq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwo7gc8aq.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-19 15:02:37-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Thu, Mar 19, 2020 at 11:53 AM Jeff King <peff@peff.net> wrote:
> >> On Thu, Mar 19, 2020 at 09:00:02PM +0700, Đoàn Trần Công Danh wrote:
> >> > Fix it by using literal `+` instead.
> >>
> >> This makes sense, I think. It could hurt a sed which is expected ERE and
> >> needs the "+" escaped, but I think such a sed would be wrong (and I
> >> imagine would break things elsewhere).
> >
> > I had the same thought and considered suggesting a character class:
> >
> >     sed -n -e "1,4d" -e "s/^[+]//p" <"$1" >.tmp-1
> >
> > to make it painfully obvious that "+" is not special in the
> > expression. But then I thought better of it -- for the same reason as
> > you (to wit: such a 'sed' would be wrong) -- and decided against
> > saying anything.
> 
> I have only one thing that needs fixing, which is s/compliance/compliant/;
> on the title.  Other than that, it looks good.
> 
> Having said that, I would have done the [+] thing if I were doing
> this patch myself.  As long as we see no "wrong" sed that is broken
> by this change, I am OK with it, though.

Well, `[+]` thing was my first version for this change,
but I change in to this version afterward.

However, your comment in a later patch:

> IOW, I do not have trouble changing the test so that it works with
> noncompliant "diff".  But then in the same series, I would prefer to
> see the existing test keeps working with a possibly noncompliant
> "sed" implementation that has been working well with the tests.

changed my mind.

I will use `[+]` here in the reroll.

-- 
Danh
