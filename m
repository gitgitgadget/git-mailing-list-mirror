Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4513F42A
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 05:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734501271; cv=none; b=hho1ZCNzyJYjprCfkwdEFld3S2T8doBcVNud0I3slN8ocalW/Oe4nx97KwKLCBj/o6sY5tKEBAqJ2MI2vkwP+D9AoFBL86UdgHygIF1k6UcPi5hFI+w90BX0R/6sREArrmZMJUfH0aIj2eDD19nwXM2mVP+HW0dYRSgI3GjKULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734501271; c=relaxed/simple;
	bh=YbNIU9708wR5OGPfkVJroziEbIkmaFsn5hysg569NhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+XjE/G6OIdkkDUmHWHd8Ai23nJxxcm0jLYJ0PXaugSctedUuLJZLcl35SfkbA1P7YPf5fMVLLsmaLDsfnDZrGEhopoP9ZGCwkYeUV1yLwkdFmdwk06UUHpLv/BQ/Jps/5+6oZEf7jqajVIudWN+O6j9EuMrCbffv2drDWvgyFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=08M9NvXh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0SVvIdDT; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="08M9NvXh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0SVvIdDT"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B21B5114019B;
	Wed, 18 Dec 2024 00:54:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 18 Dec 2024 00:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734501267; x=1734587667; bh=lEPPdichB6
	lOdR4InPxE0ZhhdmQQEoUneSg8bGCER/8=; b=08M9NvXhpi5lCG+hF6C19j65Bi
	yWSgh1p8d6W/PB2IBXFmyNHDYO8I5Pp3tfDaNi1RU/r9kIYGOH/KbiyaXSqoCyDj
	EffwaH8U831aASOTZKD4K2EDW5Zg+eTaaA9UP+SrdRVgiqc1Hycx62CBndejO6+6
	8Wtog1oWLlWVHwUfLPMNR7SDj+KW/gzdGmtiiGgPBDWvBju5wbrGOoAlq0bduMWU
	32I6A5lOt1BmBzrJTgGiL5DCI6thtbU/kx9xJtsKosM6Rej8hh+8uNo39vBdUkit
	vla/27VcroY7Qaq+lCib501Gf8/FK5xVNYos38nR/eidciaxlJbJbSz4MB3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734501267; x=1734587667; bh=lEPPdichB6lOdR4InPxE0ZhhdmQQEoUneSg
	8bGCER/8=; b=0SVvIdDTq5OmBJwFjbX9IRp57YHmXz5yvDVezMebTo1jJ2LEc3K
	T1D22fx322FSHVSEyEUDeEe0JPaW+aa3t2DXRJ+OSIsboy03WNyzGaSleYXEVN+7
	10EwV8SeLpZg+Tr7b1gNMxoH1vILlT3UALd0l1np5x4p/WORfpE8yrJosNnLjIJV
	OgJ34OSZez1xPm8AUty5yiFuUIR5zYabcdUza/6HIZEgKlHnzZiI0oyaUp0Nglnn
	jjkwVT0eXYZR5TrQ+FXYcf/xXYyMmjbXzfXdufgYTjawKxbQyDRM/jpM41WfFKxu
	9MX9q9cjngSYKtIiQNN+S5ThoW/9kPVX0QA==
X-ME-Sender: <xms:k2NiZ1afQFdTMZJ9EXGloYNCQt6xhJ70plUQMZgGIx6pRPiKcn26dQ>
    <xme:k2NiZ8Y36fRSweFFsYtAJtVRiHYD1ntImnyqyS-Pnh-ba_RdXa2SEPIBEFIvtg1eD
    CwBXoMkZzdsoYQvSg>
X-ME-Received: <xmr:k2NiZ3_7UOVfDET0sYUkiadbRvtzifugz8RXt59HX44RY74T5ub30Wm36i3QIPZpaciIahEnGMh2z6ZbUVTFgioohLaFhbMV2jG03bctNUoG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleejgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhho
    hhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:k2NiZzqbZqXV5UriMz8z2IlSo0JJUBjISxA1GxbEb1oLDt8pxa-UVQ>
    <xmx:k2NiZwr44T0tck5aejf_5wMYueCCidZZkJYyISMcwtJCcESqF29kbQ>
    <xmx:k2NiZ5Q0LjR1f3ySMwJFmSPy9mSfegd0dIHM2Stp6YmLA0d-JiUf2A>
    <xmx:k2NiZ4rs9v2bsPmFhc_yFvhQzSnx9iSHry9u9hBiNSJjNzUZXPuRWw>
    <xmx:k2NiZ5nCoVRQw0_lidDKFXk9aumPxriIILWkHOeTInpqxsjDLdCWbye9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 00:54:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 844b846b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Dec 2024 05:52:38 +0000 (UTC)
Date: Wed, 18 Dec 2024 06:54:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/5] ps/build follow-ups
Message-ID: <Z2JjgJX28n9jRSFW@pks.im>
References: <pull.1840.git.1734456721.gitgitgadget@gmail.com>
 <xmqqzfkuxcf7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfkuxcf7.fsf@gitster.g>

On Tue, Dec 17, 2024 at 12:49:32PM -0800, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > These patches were required in the course of getting Git for Windows rebased
> > onto Git v2.48.0-rc0. They are based on ps/build.
> 
> Thanks.  Let me mark it to be fast-tracked to 'master'.
> Queued.

Thanks for these fixups, Dscho. All of them look good to me.

Patrick
