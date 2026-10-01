Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A8F47987C
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853588; cv=none; b=ZZvLBNdp+XROzDN+gz5NLWzq0wW1Vz5YyvaSoQA2t5PTJg0sk1c7uX6GtSRu5tI8wRJ+XpwcjjVgw9UNhRBCPGsCdmDEmTs4ilYke/ndOSLeV2kXYSW4HYBxa73GLjzBJlvvDCXmN4XOlk7hyAttRgAoqtwZuBI733OVQakWpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853588; c=relaxed/simple;
	bh=88viNpXFNijGAxqfUttM36mcR1caaRU15phECrvDLHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4HPgmnVJ5CT1z2CYToZwBN+EwTs9z+ZalFf6T4/SYIdS+9Y3pXkiAYVyTFWT8gDFOt2sH2+8s25wjmkwWoYEpj+zYJQOJIJrsPPBy8DvBwkiuWmWdHYUjJxy4Hrt05covUK1BHpnRPXJB1alhzAZALFIGRsD99X1U2iAEFmHhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ruK0Vkiz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SiKxpH1i; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ruK0Vkiz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SiKxpH1i"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4EE4E7A0102;
	Thu,  1 Oct 2026 07:19:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 01 Oct 2026 07:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790853586; x=1790939986; bh=UnTtv8RIHx
	6itVCXSET+hvbummPGMDAxYPg7nE/EZn0=; b=ruK0VkizKYh5Gz05Jk5+CGFbaY
	osQ4vwOecrHS5OI8/z+FgHNUTYJQ3+RtmQPKOASrE7evRjks0ANBOPRJ0fwpH04n
	PppKgvsRKXDs0FaH+A/K9dlJdj0LMoaEAwm6H1xpm2r51PFJDyxANu+4FI/9qJ3N
	6s+0E+kQuwzNp/yf/rsC3UDf1MP+4kZl3UZbHLrepDnFq31wgdi2gWa52iytTPuN
	T3ZWQb8xp96BP1D1BgZlexHbZ0r+Zw9IWEz9al+e40dr1m7wI1Q+yqjN5KnAx7Ac
	7AeHtV6T4fQ/yW12NtWdbuAyQc9cfRXIrMunOz5hocCTx3cTNhsn/EDlXZWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790853586; x=1790939986; bh=UnTtv8RIHx6itVCXSET+hvbummPGMDAxYPg
	7nE/EZn0=; b=SiKxpH1iOgxzpTyaDYqMGehx2Pzp5896Gdn/rDK0/wFV3XyQrx+
	ReSV/Jd3R5WRCAsb5axkvKHjzoN2deEAWOHa0OJ1kXPwZRWyEV3aV5K/mLbMZviC
	SbE/5a/Xhs58jQgVbAGqkZi7mLcr1PzYRkoHscka2srmn7gn9Ka7/V8XO9BIVtX0
	UqWwrRSd6u9DaEIiDqXgkinjgBlb3HSFUTuFog6ARef7gDx3Y5656dQ11tmA2cT5
	zbTTr6lEQvs0EGJKOBXB48l5F8kjbVQB0jsQ4A0CkZ7FSglDYOEEsc7YhmNr2mQg
	Me4MKA74LI/ST3hs5LFv1BawVVXlcRdD5pA==
X-ME-Sender: <xms:0UG-alve4Cy8r47G-8FHRtq-H0Xak9eq_ENhQZHbSDm0VU2X9K3KYg>
    <xme:0UG-anzeVe1Z-u7YYU2tPudU9IYcPvSPe0qEglfHEL083bmSHVZULGP22BhZndabS
    LWxKLerKPmCVF92XFOcw7s2YuNeIlMXKMsGnILEnOKhUgy3bHoAbOc>
X-ME-Received: <xmr:0UG-agDyODz5v-LzAlgl2kBKP6Gyn653c56YGISFd0gkzWHFymJFu1IEbkMvZjfpSf3xzw>
X-ME-Proxy-Cause: dmFkZTFQY7bWEff8xlzuCCzp+694xHb997hRIVgNk+9TmxxxNqaBUxliD2Pm7lfmMsSEKg
    7yP4tG9hDLbGF1Gzb4ThyPHTV18IDPwk755Y7p/RecHJbna1PryAX4kDMn2hQKWqLQKMmk
    1IxAqsMHCgwgM7VpF1HXi72bSfFZK9vXupbGs1bgdqScGSgUmYPYhDCrTsPjoVxBJPT6Qm
    7u3tEYxSHnrErIlf6WWyRw3OG7LbJaNlHvnkiaLKTG93tzxgLYfh/WjurC9MmshdFJRF13
    32HAqO5PyPfP5OGxRtA9G607YmTitPMy8qiLCUCaf38ZN/l70+vFWE9udgTwX3y+aZeYmD
    8Rl8oNkpqavB6OhDX5ACpcOmf54yFWHWLKVj9LFk/B1jAQ+0tXURvu5pxYbsKZQ+Dh6VAl
    eWOO85AH/tsB8L1ES7nqv5VLUgoze2kVv/NnPTmgm3ZWoi0O3BXTWFi3rTCDlzf1swEdIR
    CHK5Nh6Dpm38hfHuQbmW/hm6URBEjypvTYLdiC9eSC10CFrEHVlDOdLCW4vJsLaHCkSndM
    mk3bpzfKYlq4YaDfDu0mlgDtPCX8C2GDXI4sxlnYCJIYT74qrW/CrLLrjsGmq2jagmL6qz
    VNUTxRrB077tAo1u9Xq6BX7EkShmEB5pULxIT+jyDIVPI9gHTPD7Yq7JzywA
X-ME-Proxy: <xmx:0UG-atco23SeU8bQp2UdqtuZH_jHH_liX1L0CPciRtxBzwpHyyqGXA>
    <xmx:0UG-aikEPs4RMPeC8tkKdBMZ4DHUqhWM1qNyHSfdlQui8Xk8ZVdhHg>
    <xmx:0UG-asGfvuoMZrZtMexNfT75DQ9Xi-UGY1eP2p9sDklFqH1NrxV8QA>
    <xmx:0UG-ai5H4cW6mHp0pVpeBD9syKYO6pWoz_L16S3rqpxI6yAAfPmoqw>
    <xmx:0kG-apLzm7EiqJI9A_s9s7ulEgpZ_hVbQJJSwT2rQ5JLOh5ZBvy49Suo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 07:19:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b6b540f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 11:19:42 +0000 (UTC)
Date: Thu, 1 Oct 2026 13:19:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem <mail@thomasbachem.com>
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, phillip.wood@dunelm.org.uk,
	gitster@pobox.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v5 2/3] rerere: add "gc --auto" that skips a held lock
Message-ID: <ar5Bx5btU1AiONqA@pks.im>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v5.git.1790596702.gitgitgadget@gmail.com>
 <27673137aae961105a3d3b6ea615879e0686cc65.1790596702.git.gitgitgadget@gmail.com>
 <ar0kJPdY1WSsWvP8@pks.im>
 <CAA0xjtoj_uf-f+kzjRpmOkq1RsbGnkXdodeSS2ND0R-FsP4qRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA0xjtoj_uf-f+kzjRpmOkq1RsbGnkXdodeSS2ND0R-FsP4qRg@mail.gmail.com>

On Thu, Oct 01, 2026 at 10:08:16AM +0200, Thomas Bachem wrote:
> Hi Patrick,
> 
> On 30/09/2026 17:00, Patrick Steinhardt wrote:
> > It's a bit weird to have git-rerere(1) document who calls it. We may
> > want to document why specifically this is useful though.
> 
> I'll take that out of git-rerere(1) again. I'd keep the last sentence
> of the rerere.lockTimeout entry, since that is where I say what each
> command does when the time is up, but name the two commands there
> instead of the option:
> 
> "A `git rerere gc` run by `git maintenance run --auto` or
> `git gc --auto` does not wait and does nothing while the lock is held."
> 
> > How about we instead call this "--skip-locked"? We could even mark it as
> > a hidden option and not even document it, as it feels very specific to
> > how git-maintenance(1) wants to invoke it. If so, we could maybe remove
> > it again at a later point.
> 
> I'll take both, the name and hiding it.
> 
> Patch 3 has a RERERE_SKIP_LOCKED flag for the conflict-time callers.
> I'll rename that one to RERERE_WARN_LOCKED so it doesn't look like the
> option's flag, which stays RERERE_NOWAIT.
> 
> > An alternative could be to instead call `rerere_gc()` directly, and if
> > so we wouldn't have to add this flag at all. But that may result in some
> > bigger changes, so I'll leave it up to you to decide.
> 
> I tried it. It is six lines in builtin/gc.c, but rerere_gc() dies when
> it can't take the lock. A manual or scheduled "git maintenance run"
> then dies with the lockfile's message and exit code 128, where it now
> reports "task 'rerere-gc' failed" and exits with 1. The rerere-gc
> tests in t7900 fail too, since their helper looks for the
> "git rerere gc" child. So I'd keep the option for this series. Say if
> you'd rather have the direct call.

Ah, right, that makes sense. Let's keep the hidden option in that case.
Thanks!

Patrick
