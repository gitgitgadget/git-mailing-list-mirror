Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8B205AD9
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731391008; cv=none; b=Z9TUBGd0pW7bJiO79iID0yIHx2sl/m8QZFjpKjAhHJpkab0Pepii+z8BYm8VAVmPY2IGNgQuKU08fNyXVkzMnTqmHLJInQdykPVNNtmiTda4rsFJx4tLiAJxiFc0K1zSJ0F78JBRhaoPMJBOV3qlrDt4QLDoi4oZoMD636PRcj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731391008; c=relaxed/simple;
	bh=F6BxVGZDxOKuWUYMTmRBFRgHL6bkAKT/2JKkV+bA4YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3ImUeuHOvFdnGVZBoH35aU50xH8+SN0z1PkPvh1YS3DL/rojgGYn2THv3hm8m8H3qgaIgGn7oIbpUEcu6+xlCjPHXRPp9imzBqsigWWmo1/V19hNRrYbZ71tS5gVi3fQoZYLwBSWhwOPRVR6I64DYfIHwv9GZvvZNUbXUu6aqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VGManc9K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kuvOnrvw; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VGManc9K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kuvOnrvw"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 99128114017B;
	Tue, 12 Nov 2024 00:56:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 12 Nov 2024 00:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731391004; x=1731477404; bh=jNk6ZNpmu7
	8tY8KmtbHvboNM0cCHJkb+XqDUtgd9G0g=; b=VGManc9KW6Wo1JNdBQQaT+CH+W
	fSDqIa0D5JlCmmf7mgZ4atHPYdO/En/xv3SnRNaAdJ6pH9PUTkR+IBJzhG/G7Evi
	HLp81zEB7ZU5/4CLnJVa74JITs1LjKJaMW3jSgD4N6rHAtrktt/6vPqditdvJppD
	yYWnujZQQ7DS2+HC7lQjc9bOEswnqGPZbXLWNxFtjB8zJSEtqYMJ0iSL/es1iO+p
	G2tF27JMfiH5iAPKqARbowYbA5b8fWORvsrcGv10Gaf/TvEZ1BMSFBexMjRSQGCG
	g0QZtif/0/yzXtZna0NAVPflApD8aw+EfiZ0yA1A8hnUkUViS8eYZcEOjy6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731391004; x=1731477404; bh=jNk6ZNpmu78tY8KmtbHvboNM0cCHJkb+XqD
	Utgd9G0g=; b=kuvOnrvwUqWySgs6IQF5b3LLiK0nEvjfvHjeJX4q7Vm9yQxM9hv
	XSfrA8fkqoxDv7NizCc6L8MrlVlhsBUBsbkX7JlmQR1Y0Au9efo2ZgRyfJNFIh55
	ym3UBqOgVIi5Cqg5WAOJhtqeOrMsX0wx3UTRxboYw5nKvYD1DDOQzb5DHfRCifoP
	x0Ikw6o2bSgUhj578MnpbzNW/a4csjQxO6kCwNYNk6KXcCHUTzOJCCTCZX4UL9RY
	dDO19nYP7n+Aegm9hYYblkEZR2nX1iqM1cRXMcUld7qPRSP6GEeUo1Dc+Zf2psDu
	IjkB2bBxXl78jDj7bw9inviNqogj0lxeSpw==
X-ME-Sender: <xms:HO4yZ2Mg1GHRgADd7RXK7t3ZygWHIecm2CT-IbMTXK_r2bZGAEOZ6A>
    <xme:HO4yZ0_YpDnr03HzA8TBcs2BZajYF5bb6lyHEeEqr6DbLyr-2ir8dgVJfVHlSmhn8
    gn1urJWqO0g6QrXnA>
X-ME-Received: <xmr:HO4yZ9Rru4dEPKYkwxIF0X8qqsD9DMmh9qfB9oLrbp7lr-JE_y1-X0AtzruDAjue4Uy8hemO1imOlh3pjD_23U1RHDeHCwkzAtvcM2Kk74wchf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:HO4yZ2vNALJNqbtJK4lvFWxqHPklGfKNzsK7uJuYttzXFkjEcZorVw>
    <xmx:HO4yZ-dczefGpfCK2M66zAcv2NOSnWC9rya5eDjly3LzvFh0jjYFPg>
    <xmx:HO4yZ620wqvXUKyQWE0_xHdVVVul3AC2_i83x00y2RVaGwFZoZ4u_w>
    <xmx:HO4yZy_tUxgihnDsDxzEZTsgS8Z-v_Rs21ndadasrDq0H3-lEM1Gag>
    <xmx:HO4yZ95S3hAJsdmoEOCUcGB15Goqtt0u9D1sPP1SjN6M6UA336NBL-0O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 00:56:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7926612d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 05:56:04 +0000 (UTC)
Date: Tue, 12 Nov 2024 06:56:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/4] t/unit-tests: convert "clar-generate.awk" into a
 shell script
Message-ID: <ZzLuD4p_O7yU8MT1@pks.im>
References: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>
 <20241111-pks-clar-build-improvements-v2-1-d4794d8d1b30@pks.im>
 <xmqqr07h9y35.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr07h9y35.fsf@gitster.g>

On Tue, Nov 12, 2024 at 07:58:54AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > While at it, wrap the overly lines in the CMake build instructions.
> 
> overly "long" lines?

Oops, yes. Queued locally, will send it out when receiving more feedback
on this series.

Patrick
