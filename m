Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA269266576
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931108; cv=none; b=EuoBt/hGeBn3VmXZcNY0laT8l1mZ4lDFFnvt2B0QeTkSVn4wv2ZEpWOJlxBDoM0QWDiOIBptbOb6rfXfrpahzOSUxdWYwn6YbjKRjIQ9Jqc5eFvLXpJOIwa6uqeLPZy3yteVJFokDnqFDd9xoqB/3tbazDpyRIHSD7dy+G9VJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931108; c=relaxed/simple;
	bh=2HDWF4MFq05HEeglCJDPM2Z4Q/cEQiF+ocf7Qu9yfEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pj1O++FUphIV8vJB+/qneOtehiwz0A84EKM/cNs5uohgRDQwiG7pvfGK9FZm5oPifbRA/CUCphjfARKP/wQThOoWkuYlooszI76GZdeyo8+VhtHRYfhmKIOowDNd/FCEt53AugJ7JrIlOREcIXcOllJ79GV86VoZml8r27Fnp1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=muCutAmh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lL/iHK5+; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="muCutAmh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lL/iHK5+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D1D701D0008D;
	Wed,  8 Oct 2025 09:45:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Oct 2025 09:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759931105; x=1760017505; bh=W85OPXGEyR
	3C3d3/kZIVlwu6U8vH6odzWajAw9/P+iY=; b=muCutAmhoXeBGlkPgHBz+wMvX1
	fQcuLDqu3lvjp29VBGnCm/KPwOEshKynBGCTREivhv8dOtR1MhxjZlLv5ucJMS2C
	I6A8wsxELDPPc4no5RXyQGiKvcCsC7mnFl0LMOuHJxyH0RClpQCBAk0kXT1raxzS
	f5dk+yAC+FyzrSGWgOQBI6bSEOholgckHN49qUsGA/Uxh3+DgDeSTDKnfCuY+7fx
	OEatikq9hivNvQuYa39jsHF31+zSPMRh7htEgrUdVEGxcijYeqObac3POo8ERCOf
	OdWhdsDA5jSXoHkap51p5p/Vw1NA8to/EfYIIZdzYwIIrqGN4NyjJsFc9iWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759931105; x=1760017505; bh=W85OPXGEyR3C3d3/kZIVlwu6U8vH6odzWaj
	Aw9/P+iY=; b=lL/iHK5+yVmVOg59plv8aB/NarrrF52QQhl0czS+t+FOHFWVbEc
	54caFD+w7ex8dHHNVNbgvyKBlNfpFB7MbRrLN177T3m4ZNqiV9Dj61UciAQsGRq3
	GOIqFDiwIqp3vEuBSgOA20Y1iY4PtB7pxlXAuMU1wr61oCrar5qWPew0Qh7JQwQY
	rvEzZa6tvliYggE+X2NhqCetUp6rjrH2LYFjbRzJO4Z+Ck//f2gUWFT0yQMsPuRm
	PJr1pRlKwuWUMcbVDY4w0c51S0UhgzoLUNWRJedfx55mRbQUo5mc3NdDzil7bxev
	CEPr+6zTxWljrjiNqI/wuK3xwwmP2EwLcaQ==
X-ME-Sender: <xms:4WrmaGtXcdmBGYQ-SY3DGsSw_xO6VjFsg11O9BljS8bVFYjhsx9aMw>
    <xme:4WrmaBf6A6POAksZRg8smr-ywLGYbIpWEeFzCVPZhjcL_FjE_bvVapSFJLz_tkMhk
    jSfnOt_VRg43eCm6iC1XW4H_LkG26sVxM2ZHegWv-XFcjosIhUklw>
X-ME-Received: <xmr:4WrmaPYb367_FJ-h_SUa_6b2x_bQ3Ti9_GmtdSHnkznHNBVv8zqARMUqdKPeY-9DS5QcdEQtHk4U_LADPr9U_U69a8Czw8z8uCLSuxkc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4WrmaMU0wCpEH5vpD5ySU9iUFh36ZMfMwwUim1Zk5Oxj2o_KQGt7hg>
    <xmx:4WrmaJjzoUgLICEC8ysvlspLyWkdQ3VJjoPoLt-e7QY5ZHWEsr2mkw>
    <xmx:4WrmaCUzh2uN0Rng9jm0vWIa8SX4LHQWhzf8cKaqcsZpAxmND4RRFw>
    <xmx:4WrmaIO3NFifJB5GCFR5imLR20TuVQUPi7yu8bsqMd7xNcPVQygSDA>
    <xmx:4WrmaBeRgiJgBLmATyXgGgjpI9kouj5-_hqPhTWI76X2lqtmFf-vK6oc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 09:45:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 85309e97 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 13:45:03 +0000 (UTC)
Date: Wed, 8 Oct 2025 15:45:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/13] refs: expose peeled object ID via the iterator
Message-ID: <aOZq3HlVV7tF4VSJ@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-4-916cc7c6886b@pks.im>
 <CAOLa=ZRQuLa_xD8GzynHNmNZuyoJeK9dCBOKbUfkCES4ejG0OA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRQuLa_xD8GzynHNmNZuyoJeK9dCBOKbUfkCES4ejG0OA@mail.gmail.com>

On Tue, Oct 07, 2025 at 07:52:43AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Both the "files" and "reftable" backend are able to store peeled values
> > for tags in the respective formats. This allows for a more efficient
> > lookup of the target object of such a tag without having to manually
> > peel via the object database.
> >
> 
> In the 'files' backend, I thought only packed-refs store peeled values?

Yup, peeled values may or may not be available with the "files" backend,
depending on whether or not a reference is packed. But the paragraph
doesn't really contradict this, does it?

Patrick
