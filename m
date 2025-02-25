Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60493189F36
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469872; cv=none; b=kXd+yXSE3FF6/cvlX1kWkc2S1mjXX3RaWo25yfm0jns8SF8jWj2O7tmnN6FiPZmB3X68aN0MzVshEptsWGuiia1ghcyw7Rz+g4ojI2vBoOu0O67hPHGdLA8lVs58QzVsV/I+vLkUmCCeS77ceSYn2vwj46tgl5skwWRUwd2g3ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469872; c=relaxed/simple;
	bh=MPyy578T8i12iOtGrJrD4oCKyqZsY9cGTAhEtS0eCkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awijSPAuZTo/miusj27MFDSLXEDv7sMpcb6VQhiqOgHnU8TuQFlwlKgyQxKMd4R8kSaovW6VcT5YvGHsHO33p8bPlrlURn1ymOgmuxLrRioy06k2ZEAubT4XiuUUV2YAIT2KFVDdgMcr2egOKUlOqjHtxFSpfHecZ3C4TzIHCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XLFGgStl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ERbXmRoa; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XLFGgStl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ERbXmRoa"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 2AAD41140187;
	Tue, 25 Feb 2025 02:51:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 25 Feb 2025 02:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740469869;
	 x=1740556269; bh=5is2G2f+UW1sExBQTTGNMA25Do+1JrR2TvI2nJP/55o=; b=
	XLFGgStlYz+y/mUBBGgeV/hhCwTYCpzCSjBc52anmMX3EM5IUOCCBzr5ttxCz0sR
	Plwk9qR2lQG2QQliwj7oiblS2EQSt9TAj3TbZoEnC3fbBdWr5osZEBjkf7KgYQUr
	k/a/Xh2jeve4cqni2kJS4KYAYmEwMWtkcSuRzCGG0jB05thzdYTIT745lZnze+hI
	/tc+4KmdHXYeposUTne/Vwoau+qGgl7/cAxl4txidY/+XznxtNW+WlyBV9j5V+NX
	CeoSowxxTj/aS335HS/xVm2+MSJcx8tiEMXtd9w1QpiHLTQ+/S8kzMJv52W1uP6h
	KBKAOBK0FjkA7FBXHXo1yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740469869; x=
	1740556269; bh=5is2G2f+UW1sExBQTTGNMA25Do+1JrR2TvI2nJP/55o=; b=E
	RbXmRoaLKcZ267Xru0tE9qaI0ZGS2vJfcHLy8cF4P2U+1h42xfIHUTG7Vbj0VM5O
	B8R1KBG3pfYROkQkeMJwDt5CEizGnyL3w/lcqaentuKRvNtaPVrE/dj2Cczc9OKi
	OUoBtzrL2SxmcmhbF3vnkevuyvsHNDKkrEO+YRiHUy5jYBpg+OPyCjcf+xAbeb8r
	ggpbCR5DuQHbXNGdDfEHVmF6Cq7cw1DfZPM+cUwg6HrHT273WfVK1la9ku+vDKry
	Zz8DGuVQuSPDyz0mWsi50b32w5W9UYGJtGTo4dBRPWot/ymhh7aSqnvB+ysIvwCr
	2w2XQZ4zyK7NkV5AEh42w==
X-ME-Sender: <xms:bHa9Z8npHwhryP8Yhnoz9FopRWU8WSaLoHDMmzbHbwLFVYHBq8RVBA>
    <xme:bHa9Z7084zyNne7ZCq8uuOy4oAlY7_uNf-1Mcdk4YB6HPOl-vok2o7i_f1ktf7tG_
    gH5ypLcBfxXOnsp4Q>
X-ME-Received: <xmr:bHa9Z6oC7_CH5JmgIKWs9xnKwg9lYOFlQzYIXKO4jLllZDPtdoV1NMH1caPvmIlFOXWRoI2l56F-HLK5tCZDyaQnaHwZkhjc6HPg0Ohm-BaNAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheptghhrhhishht
    ihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhukhgvshhhuheslhhukhgvshhhuhdrtghomhdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:bHa9Z4lKxHcI8PhQtcMiRTEMhHwMpvB0rDQr-_F2TJnYStUVE8Sbiw>
    <xmx:bHa9Z62WGhog89CKFwkh_mOzCgjxJrROw9mdD0WsvyXYQHOT5rgIuw>
    <xmx:bHa9Z_sxFG9cgRK0-WSobv1eWPFKbRas7lHCqXhI58Nai6Gz2G7SQw>
    <xmx:bHa9Z2VbgqD8Y67UP-PGmC280umpSO86c0AD65fvGG4DcuUB9KLwjw>
    <xmx:bXa9ZzsuuIwzNFCFwIamygQztFpLmWdWfNq-0bwB_-fWEVaMx4hVT6Sq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 02:51:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bae57270 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 07:51:04 +0000 (UTC)
Date: Tue, 25 Feb 2025 08:51:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Luke Shumaker <lukeshu@lukeshu.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/6] fast-export, fast-import: add support for
 signed-commits
Message-ID: <Z712Z0zGQD1zkdkZ@pks.im>
References: <20210430232537.1131641-1-lukeshu@lukeshu.com>
 <20250224142744.279643-1-christian.couder@gmail.com>
 <xmqq1pvn6zvg.fsf@gitster.g>
 <CABPp-BHOvCWd6mMg0WdR4O5TfZS7TWtRCQCYPLnGpo5+jNHy5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHOvCWd6mMg0WdR4O5TfZS7TWtRCQCYPLnGpo5+jNHy5w@mail.gmail.com>

On Mon, Feb 24, 2025 at 11:35:00PM -0800, Elijah Newren wrote:
> On Mon, Feb 24, 2025 at 9:01 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> > > Luke Shumaker sent the first 4 versions of this series in April 2021,
> > > but it looks like he stopped before it got merged. Let's finish
> > > polishing it.
> >
> > Nice to see an old topic resurrected.
> >
> > > fast-export has an existing --signed-tags= option that controls how to
> > > handle tag signatures.  However, there is no equivalent for commit
> > > signatures; it just silently strips the signature out of the commit
> > > (analogously to --signed-tags=strip).
> > >
> > > So implement a --signed-commits= flag in fast-export, and implement
> > > the receiving side of it in fast-import.
> >
> > Nice.
> >
> > I haven't thought about this topic obviously for a looooong time,
> > but I wonder we may want to have an option, which is independent
> > from these --signed-tags/--signed-commits options addressed here,
> > that allows the person who performed the import to attest to the
> > result by adding their own signature on tags and commits, whether
> > these tags and commits were originally signed or not.
> 
> For what it's worth, this has been requested multiple times of
> git-filter-repo, so there is some desire for this feature.

This is also exactly the usecase we have been reviving this effort for
:) We recently hit such a case where a customer was basically unable to
use git-filter-repo(1) due to commit signatures, so we wanted to help
out and get this patch series landed so that the issue can ultimately be
addressed in git-filter-repo(1).

Patrick
