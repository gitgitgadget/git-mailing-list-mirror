Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0E43F0AA
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615286; cv=none; b=AxrOVGotvlMibuLoZ/GrMgJTK3g5EWhI1oOpWTJmdBXV3m7h+yI+wi3SrHfXDUFn7DQyk4uIvPzVoF8NF3chWo9CbNVH5SqgQea+3Wc/UTXAg69s+e3s2ES6K7KYNGNLGfOjtMg83fShRK+bJlTKm1irdpf4jT1Yl8Pzbpf+Vgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615286; c=relaxed/simple;
	bh=/NPMxBrAXUGlFf5CEkT7tTDhjF1Zwo2P1j5Y7DWUkZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHOhaseTT+03/0QkEzIpSi0SjJbZZ/7+QfGQpkM/5wYcTcDaMH9TNlYDnLTmEB0k6XLc0FEMl7F/dZXNgKqrHuCfl3+oUU9p3lwfdFfxfeCRKTtweKHYHwpm9np7/oaXKdVNMEtLSY89OEnYC0sDIYbSfBT2vDPWSpqNTwVtZCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WZzErnRs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QV/rpE8c; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WZzErnRs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QV/rpE8c"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9DDB17A00D7;
	Thu, 13 Aug 2026 06:01:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 13 Aug 2026 06:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786615284; x=1786701684; bh=jvnyAd6IMS
	JL6GtAIobCtQzsnM5e4Dcdyy7Xf8eg/Bg=; b=WZzErnRsRSoBnFHspII9KMJ8sc
	7XxFh5eMkSaIH04Tberoinna27SjIO1HFTSZv7FFIKOKSbeeSqr6KDbggvVvRRLg
	ciXNI7L1iU6BPEqfwJn1rDN2aZ9zrhmiAnJ7y0a16g64k3S+Ckaf5eMO2Txesh9p
	VCgfxudWd1MbwUYloGfCc1/TH4QhwvAGcZ6DhpZA5+MsdAhzstfC4fCn8MB7rRbB
	0bsCEykoDkVjKVjuIcyOAxCK49GcpGWJl8DyBQJ2TZBqk+/Nz8HHNRlO6b1mWwcc
	nuU3OIFZdm4kzEsCHaqFbKtunzUpnl5C8nwPiszy1H9LzrVG8Adjb61fSOLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786615284; x=1786701684; bh=jvnyAd6IMSJL6GtAIobCtQzsnM5e4Dcdyy7
	Xf8eg/Bg=; b=QV/rpE8culASerdH2JRFoCC3ZOJ3RbeYdpPFoyLaHnrSL44lj5V
	ZrbA9LCHMCGDwS5DBJF3h3Hrc/gmbrcxc/l9s9VbQjv5F1TBuxygPomn6HyYGgYs
	6LVLfE0IbnboJbv7ezA1C81HBXsXYb+yE3GldpfTBvoStE5+W4q/JCqp+G5Yy5MS
	h+0PmCBtKRMq/tQkX3Q04U1tuxgou9hbrJ1kZsKf+y2Vb1bFUJ15v+k9Fay2LlfQ
	dT56E3FjtQQ5WBXpZ3tEwFSRAubfqW7TM1+BO6Nxoz2xP9cBfbCfICO6NNNCxJkf
	5Aijcwh4ZvXUCk0EKIwIeGF7zOYm1nXDgYQ==
X-ME-Sender: <xms:9JV9aiWl-pAml6Q2CXZhDYbpr7Jnwt4Fn3kRq1U2syg0o1kzpEsnvg>
    <xme:9JV9amCGBfFCQo72sRe69TATdsUFrXK46XdyvoX9t6GYOxIZ0yrxOAQiaNVAZKON6
    9FJ6BAz-ZJnMnCjP_ynKkJFCDwM0tsJ2ohhSeEePEbB1bplN0zEJeA>
X-ME-Received: <xmr:9JV9ajx_Euv1RQjQ5JfAFWdI6ORrChbb0IbkgLCeWYkWGJv9QBOWL0-YdW_l1frWmKKclKs07qIAPUfBXyhJX89knS0NZi4v2sFnXTjNDOM->
X-ME-Proxy-Cause: dmFkZTFd3RYCIxibgTDhNEnFfJzskPSOT4T+URPDR5M/cyBEWQPEqnmH9YnGa4S5nw8oA0
    n8yqFMOCd5lVYAtUF7CAYulN6KqqcS6D0s1m0YYLqCW9DxceK/GrfvsRP5m34S+Enkg8Zu
    utJir4+/BKBlMcZxVbI2U4ALBcYgcT3x51YLIHh/Y6Dtvkw+N0YuAwhfixt57echVz439b
    epiKJksmz0kFfv2HAEZwwGUGTUYJEnVO1FHXjuYp87Em2Y1zygGjleWy97sPwMHl8OX68i
    IDloX8fHdDwbausYThvUIuKMrnGDo9D7OSXWQfBFYI/B25h+3wGo3ZNfgdQDrb3YRWqkLO
    gYfeHQ/GJ892x71Vl1dishxgZJg3drES89EozBEQYP8O+myaFGlIH/KIkri6naqpipvxfh
    r4qKCd61wbrsCEA0fKqU/qs1vJs80n0XBCOihZz30j9O9DifAjrf19DDsNeFIPAYoiFZhV
    uxNnjwuNYuDtYNeSUYsY9i+ACerUcboQ0rKz37l2fgGRiNsqLrJSMeyAnZc5TMLGe6yp+r
    Wd3iFkL8deLs/k7QgI/wux4q2oiQbDX5Dg/tITc1ApQlF8PWfkyWwuyQOHHJ9ohbn3K4WO
    updre2jhWNt8EebHlCY6Pzwmun+5An89UAbOA+0HQ/BEXG4lqqGRc4mbeRjg
X-ME-Proxy: <xmx:9JV9ajCYSvFB4pT9HV1Y1fxtmBGOhJYRPoxx-G5jXXMok3HYuv4_hg>
    <xmx:9JV9agZoHxjAOYxo2cY4DpHOIwcZA2KcnxfQ2GVLZk9IyJmLg4DnVg>
    <xmx:9JV9argv7qBupbVA8HU9wEvzsGbLpa_oIUun474v51uk9detvoxZFA>
    <xmx:9JV9ai6rvH-v6YbogZ0KuhgbJe68d1Hjqou05zq9soSbhcnTSluByQ>
    <xmx:9JV9aniAiLfIrUu8Oh9iKHAc1Ko4XhLTOlg_KwOyuOAqubIWngk_LTpd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 06:01:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b466028 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 10:01:20 +0000 (UTC)
Date: Thu, 13 Aug 2026 12:01:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] packfile: fix perf regression with many packs
Message-ID: <an2V7S-DkdypsGIE@pks.im>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com>
 <an1zz02GNqDu-0Oz@pks.im>
 <b4860540-6114-2a7b-e266-d1fc2f0041b9@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4860540-6114-2a7b-e266-d1fc2f0041b9@gmx.de>

On Thu, Aug 13, 2026 at 11:20:11AM +0200, Johannes Schindelin wrote:
> On Thu, 13 Aug 2026, Patrick Steinhardt wrote:
> > I wonder whether we should slightly reformulate this and rename `is_new`
> > to `accept_duplicates`. Because ultimately, that is what we're doing
> > now: instead of ensuring that the packfile is unique in the list, we
> > just don't care and just append the entry to the list.
> 
> Hmm. I don't quite agree, we're _not_ accepting duplicates. We know that
> those packfiles _cannot_ be duplicates.

I know that we're not, but this is only because the caller knows that
the packs are new. Seen outside that context though the new parameter
really just tells us whether or not we want to deduplicate packs or not.

Anyway, I'm splitting hairs and I won't insist on a change here.

> > An alternative would be to use a hashmap here that tracks the packs that
> > have already been added. It has the advantage that it also covers the
> > `prepend()` operation and that callers don't have to be aware of this
> > mechanism at all. Furthermore, moving preexisting entries to the back or
> > front could become O(logn) if the list was doubly-linked. We do this
> > operation quite often to re-sort entries in the list when looking up
> > objects.
> 
> Indeed, that was my initial reaction, too. I was well on my way to start
> writing a hashmap-based fix when the AI assistant pointed out that no
> duplicates could possibly exist yet.
> 
> > Overall though I'm not quite sure whether the added complexity would be
> > worth it, see below patch.
> 
> Wow, you got a lot further than I did! And yes, I agree that we do not
> (yet?) need to deal with the added complexity.

I may want to pursue this patch anyway, as I think that the reordering
would be sped up by that change quite signifcantly. And that would make
a difference indeed when you have 38k packfiles, at least when you
assume that objects are evenly distributed across all of those and that
we perform reads of random objects.

I could do that tomorrow, and in that case it'd supersede your patch.
But I'm also happy to have this improvement here land first and then
I'll pursue this change eventually.

Thanks!

Patrick
