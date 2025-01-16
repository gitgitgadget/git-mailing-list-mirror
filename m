Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91C1862
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035874; cv=none; b=m9NjOyGAFv4G3U1Jb6x98y55Tok5RGpHtL8+pQhmccNtDgkToZ8/X72ErUODiwTnZTSLk56CWaOQVyeNnRShVElF5HRXGtNCEVXdQk/Ea7UghFlnkbA2H6ExGBaqgu+9Ns60fDqvb44QK0r9qKLM8hbEMPA27Zus0l3BnEgPzFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035874; c=relaxed/simple;
	bh=IKz6MDH/oljCfAmpZ2AY91lP1BNFBiqBWiSx/sd3xDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puuBsSRH6n7+yuT0z0aU2BllVxew5rRJyzaVF+N4myt/zscYdD+NlpLNhoVDjAKOpPbTiyjdtJcwjV1Acgp+vwqwMSdcdW8UAPOn9AiV1PLLPyYslrlLazWrP0+GOe+FGgBxRuMqrIAMypk8ATTJvwJISuUA2/GolNBDLqbIy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qvr8sj5H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nKifPYY+; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qvr8sj5H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nKifPYY+"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C68E114018E;
	Thu, 16 Jan 2025 08:57:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 16 Jan 2025 08:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737035872; x=1737122272; bh=MpErh78c3h
	m2mOgXf53ocL69wLmU+DHvclReIuDf+E4=; b=qvr8sj5HB0OJe/PXHsHawwTT6Q
	iXWpHhUeTEnpLBEOC1HNHoascmBt+oZk0QEmdCp3RkF42AANq8s7VuJwT88aMS0f
	4QYS3r3tQJSVShj3TVNdOtnmBDDzxz9GhrJbidBOgOKxir7wbYy3WkcukdaDuR8Y
	ZhkTGu3OFwvh/Fs+CKrnccy2GB8fw5kp/bzwzQm9Nota4fyCdHvN8dHCb3MBjWcN
	BW8fNrf+DHX6WQ9N/nw3mQcnQwvFBn5FKBg3h7IHgXHhqCkBGkefM3X5LGnfVIWl
	PletsJPkYmHNQk2DoajjsT8sgcx8h/bZ2l8xOqDEfvm5Fdyfzc/tWasHAg6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737035872; x=1737122272; bh=MpErh78c3hm2mOgXf53ocL69wLmU+DHvclR
	eIuDf+E4=; b=nKifPYY+V56/YJkJXWkLSUsUJVq2sDALOWPTAqZFf8DKrXuE1wQ
	GwntT4ugyw4UDtbv45r5yEcUk8oVM9PpLrwlEoQddUQDW3RcfuK//yQaCPZEJju0
	GWFWZ7yWdzx92zC0yV+djG7opv+MAL8DdAiYEffNibWOL7ePG8+VTaSsa8sZnnR4
	WF6zHZavqUPCC9HEY7N12rn5VNKkkJQNw8RV9T9d2ACHJn1Y4ZJhjxHEvEUnBgFA
	D6sXzlIwBGwIOyM77VH8sU9fmSiY6WWOZ3pyn4QBBShQ9w9i1YHAUxF5aCqO4OWg
	P+RLUnfUzIKNL/QQ3j6rTG4W9jGZ2Cncqwg==
X-ME-Sender: <xms:YBCJZ3rCRhf_7N7PuEDkanQFVteHiZ8bqKS8G7OUWeCan3SPy5nbVw>
    <xme:YBCJZxqGSNh9dvD777b7XXoJ68gCKUfzLEUwIRNzePg-ZeXBfcvTH28gTHDLD_P8u
    FLEAk9VRZL8WIuOUA>
X-ME-Received: <xmr:YBCJZ0PNtGIEaMz4w8qxgNuuxtkhOW87JLonTJ40IPfh7RKvssBQuOV1Yfs-d228FWXi-kcs-jEFUaeRCy97IOyDCfG1kDN3uSzqBSGDfce9xSP_7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhhhrghg
    ghgvrhesrghluhhmrdhmihhtrdgvughupdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:YBCJZ64DDRAp4eR0lXeFlTNr_KENdFoe2cpDTw1C4MSMoSa_Hm9hbA>
    <xmx:YBCJZ26phAv1Hja6x3vBfuKS8CG_al74sFT9KlX31HYaPyrpx3zkpA>
    <xmx:YBCJZyiUAy7RrdwzQ-LpYNdyIuIHnOrR321PkzsLn91mlofjiDrArg>
    <xmx:YBCJZ46WH4bVbEHNILgFbIsKkyX3mfxPlqy2f-QcyDSFguHUb-ijEg>
    <xmx:YBCJZ4SFIn3IUhzxSIjkWFH3qIQLlSycIXfX2LWh2XXmPdbXSJtLKvfH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 08:57:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 322a5724 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 13:57:50 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:57:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 08/10] packed-backend: add check for object consistency
Message-ID: <Z4kQXeLBfpNP7HX_@pks.im>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qOGzfncHlnZOGY@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qOGzfncHlnZOGY@ArchLinux>

On Sun, Jan 05, 2025 at 09:50:19PM +0800, shejialuo wrote:
> If there is nothing wrong when parsing the raw file "packed-refs", we
> could then iterate the "entries" to check the object consistency. There
> are two kinds of ref entry: one is the normal and another is peeled. For
> both situations, we need to use "parse_object" function to parse the
> object id to get the object. If the object does not exist, we will
> report an error to the user.
> 
> Create a new function "packed_fsck_ref_oid" to do above then update the
> unit test to exercise the code.

This one, as well.

Patrick
