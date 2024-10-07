Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C955165EE6
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 06:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284325; cv=none; b=NUcO3ypMFCpSL4l39Lfm1tWRGkxPhTm9Xen1+Ivo8l/MVhr9cz2w5TPEfLz0MwJNFASLuELa1vG5GDapGRaBSludDRbEqkisXDfx+w9RJCg0YuM4xdV9nbIu1h8iZ/hNTOdbTJDtZwEFIj1Jx1kOWesp4E09xEyKQTWdNm2Nwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284325; c=relaxed/simple;
	bh=g47ol1y/DCA/jlOnzMoJSWO34Gu1qfsWM61gHJg9ekk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm+eL+jFuMSVIkxTBAR2Gl1TYh+QKl49JFvWxdIEkjwALpccSD/zdYx4GAo5Y0OizxWo9aFEZ8pqV7HQGoyYyntDvxSIyb3X0FigRGZyLOr5O/2yPCgCT0xPkstwuRCqKyabqss7is/MTCXpg+httfR5rY0hVuayvgxJeyvh6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ECiiSkd+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nh+JoBPW; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ECiiSkd+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nh+JoBPW"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 627F725400CD;
	Mon,  7 Oct 2024 02:58:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 07 Oct 2024 02:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728284323; x=1728370723; bh=z7zkEUoj6x
	e512f/x4QuQ//kEvgqLtiVl+K26rji4wA=; b=ECiiSkd+FQgGgzWLaMuQcWzj/p
	dQedT4Tl65hcPTEKAHIRacwgCRbsxo/qDFwn9SaXeuJVsFm8aATXItl0FVPBeL9b
	CseBkuPhJslgbvMweUSZoYgo+cfRZGus6k1IlFfvD2ueLWrE+wK2YC4/62/143iU
	X1jmHrGHBmd1ZvHeVnb67GvvJ80p+okiy9+7UQX/sfaJyMX+AZxM83vulz3HCrLH
	3Et5pPZmOQuG9enxTU/blDsRHyBwfbeeJ9G1jZJsEv2YpPS9KwB4lf/m0Gpds7Mi
	XyoY0l5GVONdzcxiTR/d1zAPAZjkviy98BExTdfDuS3Fas9eYdoOmN2kvWnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728284323; x=1728370723; bh=z7zkEUoj6xe512f/x4QuQ//kEvgq
	LtiVl+K26rji4wA=; b=nh+JoBPWqVrqpb2Vby1pU11xQru2TIZKz1K1r5hLJTwm
	THQJs7DINrsjQGUhey4BaHRc8SLZfo0RgLzy8PKye3wH5pG9brvDTTXkvh14TFE0
	XpzHu771Z4V49PAErLogtCCmQwTjBmMtD7hXF3EUcSn/f6nWr7ZHJB3mN03ybQtN
	sKjsvTtTO0+nNA2Mf1qL76kdFTMQIA+DJzTHccg0y0zYLWBKiRnU0QGkAEFXmFwS
	c4b+AtE6nIQxCfcujOI3DvUq5lJFD627ikHwIAEJrk1Pdonie2g+LLd94/E5P8/d
	DrBZIB1n9g/L0Q8Ktt7EIbZBw3V4D4ee3jWO+gPznQ==
X-ME-Sender: <xms:o4YDZ_TYZD3Z8MMY8AfBEb0Y5aRDmilX1xBAaC7_laeg3lsnq-F0rw>
    <xme:o4YDZwy0wZ_ktWv-DV2vdTuFuVY20tuMl4oFNWDsn6QvW60E39Wea0CTd4Geu2kMN
    ZlTLbgifibcJJfDcg>
X-ME-Received: <xmr:o4YDZ03JrGeWoM4Q2fLEe69W08VyasCcHrUCsG5uz6_5377Id-qnjzva2vj4Zwsl91w-YJroqd1up8eq1PJQVQFf1tiQLCy5VmnSK4QHQ64I_OSK8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:o4YDZ_BPTP8N_6b_WBdsxaC3Zow96Tr3K-25SrVlayPfIAi1tS0R5w>
    <xmx:o4YDZ4ht01CezVwcDQt7H32Th1LzJu4NZhigji_1yqotNt4pMUz4pw>
    <xmx:o4YDZzpvtMjXWGWDegEm2o7pUse_QVIaat3epFFuWrL9uKf5ARQn7Q>
    <xmx:o4YDZzgJ19gKI7mcGwFCjPwB0Oa6yvTRwmdk-9UN1E_Q8IavvGfUbQ>
    <xmx:o4YDZweHe_QZV6mP8I9QBuj48a0n4kb2kIKiY7cwHuNm1dfglEUPB8Vb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 02:58:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0cce2d30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 06:57:44 +0000 (UTC)
Date: Mon, 7 Oct 2024 08:58:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 7/9] ref: enhance escape situation for worktrees
Message-ID: <ZwOGoOyW6HGuneMG@pks.im>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-7Rx8ZT_27UpE@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj-7Rx8ZT_27UpE@ArchLinux>

On Sun, Sep 29, 2024 at 03:17:01PM +0800, shejialuo wrote:
> We do allow users to use "git symbolic-ref" to create symrefs which
> point to one of the linked worktrees from the primary worktree or one of
> the linked worktrees.
> 
> We should not info the user about the escape for above situation. So,
> enhance "files_fsck_symref_target" function to check whether the "referent"
> starts with the "worktrees/" to make sure that we won't warn the user
> when symrefs point to "referent" in the linked worktrees.

Shouldn't this commit be squashed into the former one, as it immediately
fixes an edge case that was introduced with the parent commit?

Patrick
