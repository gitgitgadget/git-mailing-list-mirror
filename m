Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FEB1D517D
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167083; cv=none; b=LfEtLuVCZsa5lV7mXFf1nc1ZwhLrdzLO8eTPa0XXNon+nX0V1W2+TvPUXdY5p4FA0gkJfrCZhFJng98crzSdXV1quD7H82gLxrCDVaVEnvcXkHiYE2bddYOJt8dajL/nOTNX/R13r4DXrz+IRAEeYcFKmVkwWfAL8HbHbGWlHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167083; c=relaxed/simple;
	bh=wZtmv7dvIziGmaBeHizgkbF8U/ihIjy+WAhRsRXQcl8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prJT/DG1I7YoYC98H+tkpsU+B8N3bZKV6wQbEHvDzPHgA6NQedCQs7ygnKT3mWFSItGYkzFIWbH4r0fp4fnpO21m+PkpCeukLTwfYx9FeyZY9mDrVYep4Gufe7Dcn4wbPFX6qKryMMamQ6z2m0RE0pAjHzvNXJhYikjFobfpuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RZrm68Ph; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=maqjnh1B; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RZrm68Ph";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="maqjnh1B"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 4CC9E11400D9;
	Thu, 17 Oct 2024 08:11:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 17 Oct 2024 08:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729167081;
	 x=1729253481; bh=rRW6w4v+uzMbWZ9CWvlP3nzmPXQaPY8yfuWJlKy0enc=; b=
	RZrm68Phu7/ZGe7e1MjKcjelnSBfaUyW+KtWw6BpyUkNp3mmL1Ob2zhjXvDAHPf3
	7ohESbqsXhvcoifWGsO69NYw/CA4bfosh3tZPu4O9D2J1lKqP9x25UnIp6sj6k4M
	YIuCXjaZkd0jr0IFz5fm2JEGWm5wPAkA/LosWgxWsQVB83WkSba064hzzpE3DUet
	E8LrGbf7lrgga58FHqki9dcCa+LvL4BNgDID6YZDKSOjuE0PM2nTLFyhft5yP4xr
	C74NJ+Dy84FNAAfP8fihc9oSiz/SFA/H/rmV2Py7aNN6N2NuG43giQPCuZJqgTv7
	esBRDQ7glaygoY5r/e1vxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729167081; x=
	1729253481; bh=rRW6w4v+uzMbWZ9CWvlP3nzmPXQaPY8yfuWJlKy0enc=; b=m
	aqjnh1BUAb+Ez4bvUUdRnrCPm09L7tOS7SI5weASUqjnN9Q9sMEh5fktMGuxQSjs
	1vqwZgRZw7Ia15x5Iqxagudaq/ffPU3vu5A0ITQbqZH00qyO1168y2nQY5wJwO69
	Bi7pj6AariqWKflMWy0QFT9oaoykFH97jq+FRx548vpmrprMwF/PXtbT97pYUKdk
	VZ4PryMPLxpRjwH76LGv+aOwWNxN8HslLFI7Kic5MuDvfVmnEE4wWOwUFpcz/oxR
	5S4qHOKB0kw/E5M/wGpOCma7XlOhI4UfnLCjzRJQyILkCHNldn2SlRnX0FKhOa/6
	7JU4+/y0dC/TgrsbCPa6g==
X-ME-Sender: <xms:6P4QZ-TDrE9KpgakT6tzrGQLHHiQFoKev51IrQvP2r0E0i6D4qpoeQ>
    <xme:6P4QZzxctLohoNV9ye6FFx2H2VwsixylJvQyBEsaC_4R9PPlw_r1XLTOO9mKoiPAJ
    pD-WEBkigjfM1wsZA>
X-ME-Received: <xmr:6P4QZ72FWZC13LsWEZet8FL_1N-WJA4cTXFqRR6Egct-R9FlzX25a1LKCn3kxC8VGxUaNctsxbqSThObpueW1AsbpObamBwhHs5t5XrGcktTBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeelheffgfegie
    eufeehieethfegveejvddvjedtueduvedvvddtkedtgfegjeffkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:6f4QZ6ArZVkCu3-7HjoRhudr8JDtwrAH2GBQ9OErKdlGBAy4s1xA4A>
    <xmx:6f4QZ3gXCSn5ooxMz9ETThY8duindbRs1jqgJ2d2BasgcmJrA8yE_g>
    <xmx:6f4QZ2pqe9fPDILllWzRyFUH3jrpR1IhNLy6H03vh10E-JsX5xk0Yg>
    <xmx:6f4QZ6gcfRkHclXaNFzV0-x85ZWwRLy1HWNtVeM9C8plqUAxQOS__g>
    <xmx:6f4QZ6ub4pi3iVFxV0GqVU8mRmG2Kjfd4WThEXy1oiFawWqYiec-rWCv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 08:11:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2621152b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 12:10:00 +0000 (UTC)
Date: Thu, 17 Oct 2024 14:11:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <ZxD-5alMaQinK4G2@pks.im>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241016182124.48148-1-wolf@oriole.systems>
 <20241016182124.48148-2-wolf@oriole.systems>
 <ZxASXLz4lA+E9MuQ@nand.local>
 <ZxD7j-ciyAGHrGwM@pks.im>
 <bjk4i7bnlc3bajzjy7izt56mm2ynh6jofbdmqegsmfrzkwqnud@t7qiaonbktuw>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bjk4i7bnlc3bajzjy7izt56mm2ynh6jofbdmqegsmfrzkwqnud@t7qiaonbktuw>

On Thu, Oct 17, 2024 at 02:09:12PM +0200, Wolfgang Müller wrote:
> On 2024-10-17 13:58, Patrick Steinhardt wrote:
> > I think it's also more common to use "Helped-by" instead of "Thanks-to".
> > I see you have the same trailer in v4, but don't necessarily think that
> > it is a good-enough reason to reroll.
> 
> That is good to know, thanks. Is there by chance any document that
> outlines usage guidelines for when to use which trailer or is it more of
> an undocumented custom?

We have Documentation/SubmittingPatches, which has a section named
"commit-trailers".

Patrick
