Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051F121420F
	for <git@vger.kernel.org>; Tue, 13 May 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129730; cv=none; b=Br/Hxe6xWNQQwlOpevFwTL52G2QZuMracejXb7K0gJAOAxsUmVdooEtVr9uW3haeQx1pl9UG4KPlE9ldoWP4Ww7iioZ+BRTs3Qa9+5ZxPdmY2buReyQUtkFx1+p7sVKPMt/1KkPjVKyu9x+qIL41JDrykd88Y8zhgeMmGQDAIFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129730; c=relaxed/simple;
	bh=rqznfG2uNrcRMMHFpHdsyUQq+VtDfStA/aUsW4G/wpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dq/cTQeCIllCTZbeDxcDZqUohMGPJw8475FVfENImtYO27cd3+4UJTKmSjaWHbh+wkMBOkjAL7vWWvXas4tdqh0NSuqDCvYaQai2fHI0u78Hz8T1PANNU80rPMc+OBfuUm5rdSKNHqTTwSZr6xSoroOlGFS0Xs0KPGRnZ3roij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hWTeaj0y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RCRG4WAk; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hWTeaj0y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RCRG4WAk"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E0150254017A;
	Tue, 13 May 2025 05:48:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 May 2025 05:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747129726; x=1747216126; bh=sEeTj/qEKk
	eglnZvLrlJEhSdaUzXBjbM/yaia3JSqSs=; b=hWTeaj0yjvGOA/G+VRhwtg8qYo
	QL/dGFnvDrSbehBqUy3xDbyYXrINQCbdHCdktnWISSLSnQeB6/ZiTFCABMw4MGk9
	kSFIUS2rRhr00mSJ/hOtYMf6ooW0H4mw/0DUQcxRtDoO+UL6F6/fL1AThuGr8jaL
	zGWfKoCTxRtUJBeKhtBuMg4L7JLxBAzRTvYhBdhgD0B1w42KJ+UqJuk3klVASmXt
	uY8pisiMwPFV3fHhhzuYuVQ753paZ/dWA73JNpM813j6sLXsYx2aLl1msSKulkqv
	hTlJmLPUp6sQqRhXYXBoDyXJsgK4qEmhMa0IIzUScNC49LnQYdwjnH0LV0Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747129726; x=1747216126; bh=sEeTj/qEKkeglnZvLrlJEhSdaUzXBjbM/ya
	ia3JSqSs=; b=RCRG4WAkmMb7BtnVu+tz13dtA6EtyDVbijiX8KArflso9mq5RxW
	bfx+9VpZc1RhpM8Jm4ooTrLTeOT0qazDYL5Lc0cZV8qtERZbg2626ngf5TYjwpkW
	3Gmxbr8Mh/CVfflmAkdLRdt0G0izlabvppsscfkgXvzmCcerkmm+vUvEXrckiR1h
	Wjgux09GShcQVOrray774PmrvNYuObClkTTvBvQtlCKpxj/wVHczpZLKdDspXHDz
	eAvLn7uGoXNol75EZxtsSc6yZ65Du8sZxPPPzcZ93zQyNGGHFmHcswGU5cLvMhgl
	hAQk4tnti+uBb/ztxXYx4lAjf/UV/6BxrqA==
X-ME-Sender: <xms:fhUjaNwzLPWXNar0ACux9EvgBCbxd3zdZ_v-LwBYEORhNqL8Iu7Esg>
    <xme:fhUjaNTYL_lO_XoXuH4yJG3bK170KIAW1LIRbazvQtWuEwPTfeJrcEmEJVV7hzxiG
    jwMvNGjpMLMopGsUQ>
X-ME-Received: <xmr:fhUjaHUi_siGlOrMPbiamcxgVYqNmQFUF9ijw4nRlhLemoD8sqz5JsMYwyaQbcKQsddAjl5UEZiUFq_HHQ86BB5MtbPbikuR6S-LX48jKhPzGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvth
X-ME-Proxy: <xmx:fhUjaPg16WWwHnv9OEkHcRgh1ZRImhE4sFMWyrtSkmddDLhyJw2HOA>
    <xmx:fhUjaPCOrPcHS-CwEkeN9Pi8V9bxSWuH1v1H1oeeQXmStjjz7-U-5A>
    <xmx:fhUjaIIYC-MVo2zvBPaBo0iidYQIypUDeHnekqefoxEP2zPOt2BJaw>
    <xmx:fhUjaODMM2omEvvGiH-1i2cf82bkM_eURHGXCMkQqdQJge9vwxK5iQ>
    <xmx:fhUjaH7Y8NEhfd-Tm7_kVeIuilogYSMXXzjkW9KrsgA-jadF-Y3r67kC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 05:48:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ae899b8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 13 May 2025 09:48:45 +0000 (UTC)
Date: Tue, 13 May 2025 11:48:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] raw_object_store: drop extra pointer to replace_map
Message-ID: <aCMVfHbB7pJ6Mo4j@pks.im>
References: <20250512185006.GA1275914@coredump.intra.peff.net>
 <20250512185233.GC1276214@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512185233.GC1276214@coredump.intra.peff.net>

On Mon, May 12, 2025 at 02:52:33PM -0400, Jeff King wrote:
> We store the replacement data in an oidmap, which is itself a pointer in
> the raw_object_store struct. But there's no need for an extra pointer
> indirection here. It is always allocated and initialized along with the
> containing struct, and we never check it for NULL-ness.
> 
> Let's embed the map directly in the struct, which is simpler and avoids
> extra pointer chasing.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This one may be more subjective, but IMHO it's good to avoid extra
> pointers when we can.

Yup, I agree it is a sensible step. There is no good reason why the map
should be allocated, so let's just not.

All of these cleanups in this series look good to me. Thanks!

Patrick
