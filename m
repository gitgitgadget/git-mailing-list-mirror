Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F82238D52
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989609; cv=none; b=GXQnT6qdfRVmDF25zeucPXoARF5998J9ZR7BODzEsoWf4evAZjn+xTOTDNQL94QCh+XQQeYj2MSYFgntdQIstyUknZo4YTY3ov1QvtUi1QUPyp0UZ9xBfqcFsHwBr6MlDIQATN0IeUfweYsCzySVNGqK7g6N4aqMUMePM3ZtBfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989609; c=relaxed/simple;
	bh=2wnU+YOAH6ZP+TY1mH1xJG/ETRedHZSUuCQwlp/LT0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DN5BdlbsSiNLH1o31xMWrQG9zt2yL9V+BY1sv77/iNUZ7FutG0iIuCK3yDFSc4uonaeBee/sTdV5BBbYYSHuLsTo7xaHzPvmNw1MBV4PXb6iAKksYuftSYD31pGpVJ5MAXliuQe6lPWQXRMdkCvUGm7u/xJXxjCj5yvC7yXmFos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NhfO7wi/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YhYPGQHR; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NhfO7wi/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YhYPGQHR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 89DA71D00109;
	Thu,  9 Oct 2025 02:00:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 09 Oct 2025 02:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759989605; x=1760076005; bh=fPZnEH37Gm
	PDPrvbhU8AD/0mOjdxsbA5EtByoCRiA2I=; b=NhfO7wi/O4mJvryPv8PpEUlI2k
	6MxnGBVocSY2QlOMNaNrUPDy9mYcw3qPUH9ETSagElNbqJSGTVo5mxrx5U+ZN/Wu
	S5TSEQqXSoe9HgzOMlRIxJuTwCbSw7YUoWMi4wG90cUvRjGRFQ301ZCHmF8o5xQ0
	pCjGpqHzvS7rx45N5Et5H8uGds2Ho+asg8Z4gHTSSUJfroWALSthKCZkr9k9OunL
	QmS9xIT2b03SGtRLSxjWKRbGp+CqspaBwGaaZHSorGDHdod1Zh51NlwNpCLzRFu6
	o+Y6tsWD/jEQMXjGb0SNQgTaj9oHC6zwI83RGNbCzwiUnSjGnQlhPuSR7oLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759989605; x=1760076005; bh=fPZnEH37GmPDPrvbhU8AD/0mOjdxsbA5EtB
	yoCRiA2I=; b=YhYPGQHRzufl85ahZ/vg1qa5EGxhGT/ftLfAeWf3scn70Bh7A/9
	xHylthpskaeC7WDUvJczGKTia5WFRXXDpl2gs3/ngJ1d0yOFwnhKl05Lkwq04EAh
	ZGz01yhkxXzkYqGYj1zVo8plTxpZi3eC+0en/iW7Ypb2EaFWZmy0Y5ujlHKa99rj
	StUp/FL2nR1N2kZBegvZt33s4fZQzZco8wghMeXrzv4wF4AeUBHuMAEkxdRpOPbu
	SVAHr5arF3bCY/WjDcCR9AL88k8wp2vbzqFFNeZRzOYzyK19EUFHDk58lWMtWdjk
	zYiIgrUQwBrNaASp5NgB8ebkbZUPSeo7ZNQ==
X-ME-Sender: <xms:ZU_naPMBr_GivnaXwJgaXPKb6fsfWZ4JAb95n2CHsVMHNMalr5IfTw>
    <xme:ZU_naA_ndgyS8XK7-qDCIuE1BUFdDLFYGBwCRsLzG5skDev7ObY0iVxSXV_JvJOZH
    fKmDLjz27Igk8SxM1nQ_M5In5XypzZcB2TY5ipO5ra0J_W1_g_mgYI>
X-ME-Received: <xmr:ZU_naDTp9ZPBhMsrG6N54zARFzguAclh0hhGJiGNt54FAJWOvG8FLmm5rPQEOI_wfVOmzRJ-3ra627GEKHkoyH7jsXzwAQayYPHM_vEa3Eo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehluhgtrgdrmhhilhgrnhgvshhiohesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZU_naCkRSdy4oKQ65sgmtkx32Fspobf6lCG1TvcmblAKd5eL8by-cQ>
    <xmx:ZU_naDRalH1wk5xOco2-ZMnOtg2NtaTrK_mL6T1IIbhsKdAxSDrB1w>
    <xmx:ZU_naANuu099vFX2IQgOx4roo-5re3l7nRuHaxsENg0-Wu2pCC7Kpw>
    <xmx:ZU_naMWcU-TyxQzNSCmLTNx7MGPsgSC8Hve8ZIPPBKrFRAATaN9IQw>
    <xmx:ZU_naJNiQQnhkXAM-ZnuHjp8Qlp97nGnFxdVGfB3yR-jh8yR0Rt7t1mP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 02:00:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c88cb77b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 06:00:01 +0000 (UTC)
Date: Thu, 9 Oct 2025 07:59:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,
	Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aOdPXrELgKkxVLSp@pks.im>
References: <aN5-n_ArhQqaQZgt@pks.im>
 <D59D0576-63C9-4144-B49E-54D43A80E0B0@gmail.com>
 <aOTrBAXhKF4iYzQB@pks.im>
 <aObgEGjcou06nP68@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aObgEGjcou06nP68@nand.local>

On Wed, Oct 08, 2025 at 06:05:04PM -0400, Taylor Blau wrote:
> On Tue, Oct 07, 2025 at 12:27:16PM +0200, Patrick Steinhardt wrote:
> > Yeah, it's definitely my goal here to do exactly that: reach out to
> > folks and take everyone's input into account. Once we've got it, propose
> > a timeline.
> >
> > I guess as part of that initial communication with the stakeholders we
> > can also mention that the current plan is to release roughly towards the
> > end of next year, which may help to put things into perspective.
> 
> I am not sure what our proposal would be other than max(proposed_dates),
> clamped to some reasonable range that we are comfortable with so as not
> to delay the transition to use SHA-256 by default too far into the
> future.
> 
> I think a more interesting question is:
> 
>  - What do we do for implementations that do not have a roadmap, or
>    whose roadmap is too far into the future?
> 
>  - What do we do for implementations that have a roadmap, have a date
>    that is palatable to the project, but end up slipping and are unable
>    to meet that date?
> 
> I generally agree that we have to draw a line in the sand *somewhere*,
> but I don't think we should be so inflexible as to say "if you don't
> have SHA-256 done by X date, you are out of luck". Of course, if the
> amended timeline is too far beyond the initial deadline that's one case.
> But if someone is a release cycle or so behind, I think it's reasonable
> that the project should be flexible enough to accommodate that.

Yeah, if it's about a small number of releases I definitely think we
should accommodate for that. But if it's "We'll never have it" or "We'll
have it in five years" it's probably a different story.

In any case though, I'd propose to punt on those questions for now and
wait for feedback from the impacted communities first. Once we have such
feedback we can discuss in more detail.

Patrick
