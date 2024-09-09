Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593331B5EAA
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882132; cv=none; b=QBWHMTMJo2lz4NGjhdQgG0kRW+sXJFbFZnhRlvmZOPTze9QIxFfl+ZNPelB1KoFAviRT/OAzSTHL6EE3k2vmmYqw9IzDhlMhnDOxlnF/2hvrjUOlNNDGyinj1JF7HlhWQDk10XcPvDUkSexbe8umDZkb8vNH5LTLww5nb0Oz+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882132; c=relaxed/simple;
	bh=Jqk4hEqylr4LHTuic7UG+pAWDcV18vHR6nAFog2kQkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0dnlF9dBR0jD7b8JY0xcas1xe8gtOlikvUDc1x1VYTNn3BU5pu0SIftYyqTAtnCjC+Rdr8OjT77Na3CxM/Biyyqk8t/HriDt/LwoaPU+TquWpnuPsAepKVeoMVFal/uRflMJNQ+W4AESaa28w6LQXD5NrJEZeDPKjIPmXR3tjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tyC1tw6v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QRYTV9/w; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tyC1tw6v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QRYTV9/w"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6FBE61140244;
	Mon,  9 Sep 2024 07:42:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 09 Sep 2024 07:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725882130; x=1725968530; bh=g82FhZ9RSr
	OotNMHt+mOdSZA01XMiJLkGpmWT/LavxI=; b=tyC1tw6vrvMawVOOMi2ThldwsI
	yv7zmdUs0bKcPWBZvrprT4OROnm9D2ihqWFVKTJ/R0jeuOWO9WeFmv093AojyKGq
	wnWhB72V8MJmYL1uipvGJGch0a4uz4KyBz/oCc/FYVGOep3QEbz+Xxtn7qdsfqWZ
	eaJiqSPsBVVD6yfdBG4/J5cvN8co/zmD9ijDXHPX+Tmopu0EJNZvzfLYXV1um9AU
	ctNr90YKIPBbKVaw4Jo/2l8UFLd34yPSEEd/d24KYdBvAh7HIKkQYixYk/1Y5Xsk
	2cmSsDDZIP1VtjeoCziRIWoCWjQEZLolfVBAlQfY2UhWshWfRoCQ6UkJR7Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725882130; x=1725968530; bh=g82FhZ9RSrOotNMHt+mOdSZA01XM
	iJLkGpmWT/LavxI=; b=QRYTV9/weqcJv1v75DxTUupQpIVjJ7aZ5xMMbzdHQRfD
	PxQwbzDTV1Do2FeDhlhhw7UNZccqnRF4b0HzQWPQf//ONICnNcuZcuQ0l/bCRaib
	xTp+9QevU/FHTVLjJV/WeM3P0Un3QI+QyKwFH9hOLYCnwkANfeZyXLavQmrjhtV2
	fSSueJulkc5SYL/LRp7c5g57PZoVOlEIszjjN25VjFyzU30fMM2H7JbYyntMyrpY
	Yko13mm6CISDYL0tpSwSJH6edW7zLiS+/J0apiLtsxUz7yKJPnHCu4si71m6DzwJ
	dVlVO8dPoOmCeet9kvbyv1tcDlKuV/3niD1sKYZmHQ==
X-ME-Sender: <xms:Et_eZlxBVR5KaUCbbg52FzaBq84Dt4hHHN8fohmpnvbUH7oTbMTwjA>
    <xme:Et_eZlSYy9N3-Mthu7OOapxdWsLfqmnOs3DC-U5KajSd9NxUS_rnansxOCvR1RWgh
    4u5zPOAM0TnREhIPg>
X-ME-Received: <xmr:Et_eZvWrW1VTaBd46PmKdDWt-yIlW2dLbVX3SnrGqihX7-TR4Lyy9436kSnOUODpMXgQTC5Kwc0nuNZsJh3aTBPOZoWKinisGvosImqHiU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthht
    oheptghhrghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Et_eZnjBRfUzhlW6n9f-FpiuRucYySLv1aqIDNdkoeoDH3OI-ysgVA>
    <xmx:Et_eZnD0aMEDt2m_vNG4GP9n-8L73UIgH6KV9cGP2AXrFpjwcPuY1w>
    <xmx:Et_eZgJQc52rIzjQNxui6ToYZthmlGbSf2L1HRcV-SOj1HoJVO41LQ>
    <xmx:Et_eZmBucJT_wq-3tje-p8q-Bz2TVt4aZP-DPJsOBG6iiEAg8GP7IA>
    <xmx:Et_eZuPzgJ68pZm_T4LXFWfEEKeGRnwcAYb30qcReX-MFhWDmCzd2bIj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 07:42:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9d8ca5a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 11:42:07 +0000 (UTC)
Date: Mon, 9 Sep 2024 13:42:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v6 0/6] t: port reftable/stack_test.c to the unit
 testing framework
Message-ID: <Zt7fEKfqQdN-Mj_T@pks.im>
References: <20240906113746.8903-1-chandrapratap3519@gmail.com>
 <20240908041632.4948-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908041632.4948-1-chandrapratap3519@gmail.com>

On Sun, Sep 08, 2024 at 09:35:55AM +0530, Chandra Pratap wrote:
> The reftable library comes with self tests, which are exercised
> as part of the usual end-to-end tests and are designed to
> observe the end-user visible effects of Git commands. What it
> exercises, however, is a better match for the unit-testing
> framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
> 2023-12-09), which is designed to observe how low level
> implementation details, at the level of sequences of individual
> function calls, behave.
> 
> Hence, port reftable/stack_test.c to the unit testing framework and
> improve upon the ported test. The first patch in the series moves
> the test to the unit testing framework, and the rest of the patches
> improve upon the ported test.
> 
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

Thanks, this version looks good to me.

Patrick
