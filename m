Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F70C1863E
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 05:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738561370; cv=none; b=YJq3Mvg2KDNp97IWK27dnDgM5Z4i1GxXqqU2RSm0yMX8RG4k9Zuc14CITM6Ewp7Q7YY5P3uzxDmpRKQGQ3OTPz7/uCnhnU+zoVMnJGvIHNiGTWOERGX1trvcqB3bvlbJDtSBfbLPbZ1o8Vxf8f5TFBnl6ejxsP8ddLj6UBe3tOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738561370; c=relaxed/simple;
	bh=/eagMlpBiP+C81Xa/SiIkWJEqjrL7vJ4cZgVdGd7xHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHh1qP0skqUfLROic8n36oTET9EDbg5Gw6fubPRq7OJLCfSYG79T3L+yZ4hyETz8U6TlHz+AHX0ZauRQ51kiFPBYrt5wWqCSmMr5Gvhp3Jf80XiQQoOabIQ/5jhLVVdfPAc1/x+KLybAMfs+JVsrrgNFzNf80VEABw/gF+/g3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YkwwdVsV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tqh13P6o; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YkwwdVsV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tqh13P6o"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4FFCA11400B4;
	Mon,  3 Feb 2025 00:42:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 03 Feb 2025 00:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738561367; x=1738647767; bh=AuZyxVKFdK
	ITfhpsntsbQIpP2dWA8jvs8d/VpTdKj0c=; b=YkwwdVsVtj4rRIz4i81TysdFlu
	M83DWfxYMx+Bpl4MQjqg5OWOwRilt6cVd817VvmLxsyQtjkC9Km7o+3OtMMB8U6u
	QQ/5r7NuDozXBrMXQB2emMao30p0Y6Q/ClHj4v52Ub1B/DeoXWreXAtjLzdaYNsY
	sBiyG4His/4JSJOnFf7rfb+/ia9KXqJMke6eiaBb3cKTEUKpB3GZYf/LMK2vETNd
	NrlTVl+BGy093tWe4gb/SJflOz4etFL13xd5s9nYq4bI96MmJ5ubXgo3q/S67Kf0
	HGK00lRtdfRQ7zB0EtFWOUSP/g25WCUTWTciHWkRLbmJev0NOQYuEQF1sGow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738561367; x=1738647767; bh=AuZyxVKFdKITfhpsntsbQIpP2dWA8jvs8d/
	VpTdKj0c=; b=tqh13P6osZQgPFjLHSFUGvDvSLh0g67uWoTfXlWLDPeol9teg2o
	JFikaMZGDisDNBk6IErS0sknJBaHmc4KLNE7vsg1uX6A2rnundwz+5IYkgA+yUQF
	T95IfchTnYxjrtYnqcsSkwfzMS9xBk3PRyNT/PwcyIIIXgtlYtsb1KBsgPPZBWYs
	lDBeUR72G0lwPpfnB3rwmT8jpfeefvHMfxQuTTUZMzXleVw9hnMJ035apmEbMNP+
	FysOhHGETJsLsWyppunjunowDfgZSmbo57T2zMWp4Iym/OLHYzrk4ujVzvH1khxd
	VxUqR3Zv0azHmv/YnDV1Uuvqu9ri5dgl+2w==
X-ME-Sender: <xms:VlegZ0KLdTEoak8dOfM8iBGxZdClRRS_gl0R-st5TU8hiSGz5gVhfQ>
    <xme:VlegZ0Kz945mEB70aqkIZPGuSqHI7_awVyUq_M4-lA9rwi-pgR_vCNMDpuCOZLu6T
    t5ZDqxuOZaaAYQqpA>
X-ME-Received: <xmr:VlegZ0v3vN5krpwaoVhgEEn3KThH1EA8_k1AykhM4j18PLVN8JNJ1Xukk69zNVa_6sf6PuLxtpHnTYr-bYyRQME2zuqr6Ac6o4pVTYP7X6TTvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:V1egZxYZquRovG7jwfnkoRWnf0pgPGCdi2Cw83rtLMrIYzbJcGU_3g>
    <xmx:V1egZ7Y2gp_D8WOtPyHcyQmFUnhJZoFVF2acRQt3uEy-dmM19AfasA>
    <xmx:V1egZ9BrR6z3TlZ6nMjH_fA029LUMfSf2P1Pf1dliRhrvvMumURrKA>
    <xmx:V1egZxZZo7sHOUEj_gPnhPV3lgLJev0llGro0To7zuLWwiMRdMmepg>
    <xmx:V1egZ3F74zv8TSqAq1_Vz5uIEoc-MKAposIDjfSLG792T8bkso6LWHsg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 00:42:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0e913e2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 05:42:45 +0000 (UTC)
Date: Mon, 3 Feb 2025 06:42:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/4] hash: introduce generic wrappers to update hash
 contexts
Message-ID: <Z6BXVJraWurdMehX@pks.im>
References: <20250131-b4-pks-hash-context-direct-v1-0-67a6d3f49d6e@pks.im>
 <xmqqh65e97d8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh65e97d8.fsf@gitster.g>

On Fri, Jan 31, 2025 at 10:16:19AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > this patch series introduces a couple of generic wrappers to update hash
> > contexts. Instead of updating contexts via function pointers provided by
> > the hash algorithm, we now remember the hash algorithm in the context
> > itself. As a result, subsequent calls that update the hash don't need to
> > remember which algorithm they used:
> >
> >     ```
> >     struct git_hash_ctx ctx;
> >     struct object_id oid;
> >
> >     git_hash_sha1_init(&ctx);
> >     git_hash_update(&ctx, data);
> >     git_hash_final_oid(&oid, &ctx);
> >     ```
> >
> > This was discussed in [1] and [2].
> >
> > The series is built on top of master at 3b0d05c4a7 (The fifth batch,
> > 2025-01-29) with tb/unsafe-hashtcleanup at 04292c3796 (hash.h: drop
> > unsafe_ function variants, 2025-01-23) merged into it.
> >
> > Thanks!
> >
> > Patrick
> >
> > [1]: <Z3fhK1ACzJfVehM2@pks.im>
> > [2]: <Z4jyZCAwqOjZ-u2U@pks.im>
> 
> Sounds sensible.  
> 
> It seems to textually interact with Karthik's attempt to pass down a
> hash_algo instance through the callchain in pack-write.c but I
> should be able to resolve the conflicts.

Ah, sorry, I didn't do a test merge with 'seen'. In any case, the
conflict resolution looks good to me, thanks!

Patrick
