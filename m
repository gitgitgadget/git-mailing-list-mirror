Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A39228C99
	for <git@vger.kernel.org>; Fri,  9 May 2025 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789915; cv=none; b=GBpQAO1LkQcEBPufImQ9VFQGOtZDExV2FoaAF6OuMvrYkqMz3QqkBc6ZbQI10L0rU1OW3P7G8KsqiaSH0lT4OBnn+yJ3hK9Fbd6nr+3YnNn+zBhSiHQSbwnzk+nXIECLLviqf1T26HWbvXrKMchg4cd8d+t4tipR/gyxXGhf6NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789915; c=relaxed/simple;
	bh=BYbbMeqRLhCOlz5ioOX75RyChjgk/8M3H5GonZZpkFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbWnyp9eZ0udVTuXRPjmdGdctVZcj1nwxFv8TJyobdjJ7/ySQbahff16JWfkdbxlSquNbojhqG5gvrRP9fVruzlrZaaJMsk/cIQggtjEE7uXg3a/+KGRZvHN+FepNgr9Q17mCeFo2afD9T/tQwPO9hpFpD+6dA0UDQbwXG+fgM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RmEAD3ea; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ifzi8ZkO; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RmEAD3ea";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ifzi8ZkO"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 57DE31140123;
	Fri,  9 May 2025 07:25:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 May 2025 07:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746789911;
	 x=1746876311; bh=eC9hp/rqkuRE6qHqwoRaCoszv5tcSG5QdyzFBjIkQw8=; b=
	RmEAD3eaAxsq7MQ96Hz6fcRpCcxHKXb88GMWA1UAXxXwVcFurCXf3cvwX7LaXKgT
	ih+UmeAbnSIEWA0zOhPYBj7QBF1kXG8JyPI/Io2fKsd8NV0jhqq52SOdpcKIosRI
	62OisVAXkdfXM1T5/HOZRNcwbVjqijXgkbp/4UTUX9aaif42elsU5YstWL30cEia
	Rlquczb6xCFFrBHx21yTCHV34MVq7/7zSv2/0MdQ3uFwDMgYf9tj6ztrq+g06lkz
	3V44BP52jsBOIYiDJGnhKvRHMnN0ZjaXQ++XzXvL9SrL7/qtEwHfw6yjktWLXzC/
	YKz70ILAdNqYOFgWB7gRtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746789911; x=
	1746876311; bh=eC9hp/rqkuRE6qHqwoRaCoszv5tcSG5QdyzFBjIkQw8=; b=i
	fzi8ZkO3EkOH8CBNtkFifprcLIIJPY0ahSiJqHMZHuCjAdmrBPDnZ06Jo5gRXh6g
	ohzouF3CrD2DgflBmGnRNPIdXHt9sjv00TpF8dIAP7AYJz+76cJrmvGvqodddC0q
	+TYACO/K0DOtzLsPltkrba7RLZ3Ui4A27pAaqHuF1hBmlyCdCtvZWVYh6lOCGNbG
	l1M70np31093pAVpLO7ZMChUKckC6IK6wprx5brLeNr8YG5SlKK1Wc6tVOafP2Rg
	6nDjf0h9McV95ioM+drhh/Ek35FnAEWWCFUNGsEuemYnpnX/Gfnd6VjPj2vwH26A
	QHIE+53DSkLcZlfxgNo6w==
X-ME-Sender: <xms:F-YdaBoyskIcRJhl6B5JQPg3fJUPUAK5vBFQ-lvMISANOrvCDLgBOg>
    <xme:F-YdaDrN0ILsCC-S_Yyy6o9IJm_dO4FS-xVKXu74AJEGAMmA71MIwhH1sA8nNonga
    WjpNq3E6qZZN0FSNg>
X-ME-Received: <xmr:F-YdaOPVIcCFpwU3lmVM262E085hj-D96XOcbNh4gMftOQzqX3CpVbdSFNHBhCLjG-yLDm_5duImgWPS7_ZNpMj9QfXSAOy0ahY8sNYpYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:F-YdaM5vuYCPgG_SlId3Lp4-2pag3q4RM-wjmYThg7sVtrBXf8AbPg>
    <xmx:F-YdaA5zk1u1HiM54SN3soT1-CBx47SKd-fUaGH4buTEh-IGdyP2lw>
    <xmx:F-YdaEgt9SzGwV0pqnCk2RH4pnm5vxmuOL-dUe-0rMAIN97n71tBGw>
    <xmx:F-YdaC6JEAy2DSgec9b07J5C8pE4hRQD5ThwcZgLBAvBkM22ZLVazg>
    <xmx:F-YdaIUZAIyzdbc8UKQ_tmj3xRTzmr3CDa1pMSX2rJ_-BtWbD__Uu5Qf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 07:25:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ed296b6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 11:25:08 +0000 (UTC)
Date: Fri, 9 May 2025 13:25:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/17] object-store: rename `object_directory` to
 `odb_backend`
Message-ID: <aB3mE2DW0bcmc_WK@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-2-c05b82e7b126@pks.im>
 <e23e7e63-1d66-4a5c-8c4e-19b5078a75ad@gmail.com>
 <41f4a9f0-e758-49e5-8e88-4659966547c1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41f4a9f0-e758-49e5-8e88-4659966547c1@gmail.com>

On Tue, May 06, 2025 at 09:00:04PM -0400, Derrick Stolee wrote:
> On 5/6/25 8:51 PM, Derrick Stolee wrote:
> > On 5/6/25 7:09 AM, Patrick Steinhardt wrote:
> 
> > > Let's preempt this by renaming the structure to `odb_backend` now
> > > already. This name is agnostic of how exactly objects are stored and
> > > allows us to easily introduce e.g. a `files_odb_backend` and other
> > > specific implementations over time.
> > 
> > But here's where I'll get a little nitpicky and say that these are
> > "odb"s not "odb_backend"s.
> > 
> > * odb: a single object database. A repo can have multiple, currently
> >    only one that is read/write and multiple read-only alternates.
> > 
> > * odb backend: an _implementation_ of an object database. This would
> >    be the structure that containts a vtable of implementation methods.
> >    Each individual 'odb' would point to a single backend describing
> >    how to access the data in it.
> > 
> > Does that make sense? If we are going through the effort of renaming
> > things, I think it's worth being a little more future-proof here.

Yeah, I agree with you that this can be somewhat confusing indeed. The
problem is that we basically have a database of databases, and that
makes it somewhat awkward to name things.

> And immediately upon sending this message, I went and looked at
> another patch and realized that the rename in Patch 1 would be
> confusing with 'struct object_database' containing a list of
> 'struct odb's.
> 
> Perhaps in my head I was thinking that each repository has an
> "object store" which is an abstraction over possibly multiple
> "odb"s which each are interacted with via one "odb backend"
> (and there may be multiple potential odb backends in the future,
> but only one right now).

I don't think that "store" buys us much over "database" -- it's
ultimately the same thing, from my perspective. The only reason why I
decided to drop "store" in favor of "database" is that it allows us to
use the `odb_` prefix in many places, which is nice.

> If we want to keep the 'object_database' name from patch 1 (or
> replace it with 'odb' for brevity) then we might want a different
> name for each sub-odb. Perhaps 'odb_shard'? 'odb_slice'? Do any
> of these sound better?

I don't quite like either of them. "shard" is a bit too close to the
shards we have in ".git/objects/[0-9a-f]{2}" and may thus easily cause
confusion. And "slice" feels a bit weird because... I dunno. I have to
think too much about slices in Golang.

How about `odb_alternate`? That's exactly what this is -- an alternate
part of the object database. We already use this term, and it does make
sense even in the future once we have pluggable ODBs. Honestly, now that
I think about it's kind of the obvious choice. Lots of the parts of the
codebase were already called accordingly.

Patrick
