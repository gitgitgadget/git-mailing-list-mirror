Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05491194C95
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389163; cv=none; b=bJg+G/qFEWCHbvLG5boOFHGBh7f8eSrWp9UezsexBBf4RGKF2WvIpi/ID1xCgbq1Al0DByF+D36M7cj5Mw7XYyRFl5AuTXSEVHvdsZmFbU6EZwxIMY2OfA07Ba+N+gjgX9rZcitr6wU5S4D9Ugh2XfDMhblvsy2MnYGSqmRegY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389163; c=relaxed/simple;
	bh=B5bHB5fLxKBU8XrMJ4lcoqkjx0o6vxXyS8lj/Kkjw+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poiJdRY9+1HDqfdnwD/pV+SS7uYSkq6AzkZWhRcx/neVYJ4eLcwx4BwyTEVBgOvC6SSif1Om2Us7r0zrZgLHAXptZamuGiWPIRCJP7CRpYhLH6DBCIGnVDkCqIXZfTu9A6lYvDJEVAtbAAwlzEM+KLu699f2pqT9wwFLdOnRkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F2mVNxu6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mR7wSq2m; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F2mVNxu6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mR7wSq2m"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 01E291400184;
	Tue, 17 Feb 2026 23:32:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 17 Feb 2026 23:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771389160; x=1771475560; bh=M4coQUiilk
	9pDUR+LO5CC9tdDc+B8tu6LvofyL7lRKI=; b=F2mVNxu6cUc4MYzQ2Uv8bA11Cu
	APNdI8bxdWpz0dUBU2eUolsk+o8eyILs8GqYIKU4cDKwlFxCyIViXrOGHg02woSi
	L/I0w31fa+ejs9CSzK24TLmeVg2jlGwRlMEprV0aiJInOgnYl96HGQZ3798low4m
	fu1JIn0jMTZQOliYlky6sTQXzduzT/vgWzyCmtWBj1QYc1PGFqSneobgJr+ef2hp
	OqqRf6kmqBCDEpU0Do2M2xkPY17GwxUVHODhNT6CY4hCQCKWS/A6rxjerpSVjvEM
	o1AZK5G3Nk1Sg26SVn1DtdhdDZg2rClo477yaau8B6+EYR0QXtq+Wo4bLr9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771389160; x=1771475560; bh=M4coQUiilk9pDUR+LO5CC9tdDc+B8tu6Lvo
	fyL7lRKI=; b=mR7wSq2mfoae+rLugwAnFBJ4gsdzawqeo2aOki0sdFOIETgbqDT
	bJh8wJmaKBKhX3psPJ2D7QNfSI8M4WiuPU/Fe6X3jhrw/cgxIoUphlWlrsTdB4e2
	MG9D/J/tn8m94iv+Szfa+e9Bt+jM+hRO5UAwmEbV39f58i5gm7BoZggSKEOhRZq/
	z+HRveNuuCBtq6rYf7iY9j5P3C3v3T52x4ZML/dXNHbaeaiBWu4Irq1M+KTsr3d3
	2ztgsxaRIwH37mJEJV/jeiN67+qagfHPi0Nr4TbYx3l09ONdGTtsoFn5BwqbOpay
	WOoIRrCP4sH+WkGv9FyH3nx7xpmoTboYzaQ==
X-ME-Sender: <xms:6ECVaZa4MWv3_7Ia_VnUYQ2TjOjV0NZRRegIBjt5IwbhIs7mO6XH-A>
    <xme:6ECVaWb73Wb78O1EFdA1JV7MxvoKB553eUy3G7NpNr-_S6m5EUo_HgMkig7Brpriy
    C1OdWMLT35pILR9MlonvZmi_7jfYLOLsDwOx5DNCTFFHDlHWtVfRQ>
X-ME-Received: <xmr:6ECVaZmksqZ73YDn3pcs4Lqhy7HAkBywJKw8g-3aQWZ_Ds2pPPVASO2VMAStIAiohdrwHwvC3DetMrfWXB5TXfle9DlhBkp7Q1EfOz4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdduieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6ECVaSzU1wyNyD4O0n6eMYTlSWw6P9mYGkb9haCXXT09V0oRfSj_mw>
    <xmx:6ECVaXNc2wriFd4h-isu0_G0UoGmL-79y_kgQiHCUwTqYLDM0Iil0Q>
    <xmx:6ECVaWSaEUZrWRJB-xMGr7bjG42CdJSiJpDMAScHAdsqnqLZyzPoJQ>
    <xmx:6ECVaVZH-Y1Midx0I97rP-NeXHyxgpPElEwbEY8yogbMKzG0G0cryA>
    <xmx:6ECVaczJrMtM_Hj2lwh1rpm8nz7WEY1srTBb3pHkPOoMrGrRNTnhwXDI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 23:32:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa5ec161 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Feb 2026 04:32:37 +0000 (UTC)
Date: Wed, 18 Feb 2026 05:32:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: ps/tests-wo-iconv-fixes (was: What's cooking in git.git (Feb
 2026, #06))
Message-ID: <aZVA4i8DeFRYf4a-@pks.im>
References: <xmqqseay98oj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseay98oj.fsf@gitster.g>

On Tue, Feb 17, 2026 at 04:50:20PM -0800, Junio C Hamano wrote:
> * ps/tests-wo-iconv-fixes (2026-02-17) 4 commits
>  - t6006: don't use iconv(1) without ICONV prereq
>  - t5550: add ICONV prereq to tests that use "$HTTPD_URL/error"
>  - t4205: improve handling of ICONV prerequisite
>  - t4xxx: don't use iconv(1) without ICONV prereq
> 
>  Some tests assumed "iconv" is available without honoring ICONV
>  prerequisite, which has been corrected.
> 
>  Will merge to 'next'?
>  source: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im>

I'll send one more version today that splits up the first commit into
two after Chris' feedback.

Thanks!

Patrick
