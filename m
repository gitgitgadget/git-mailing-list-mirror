Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4F4224B0E
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 04:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755665906; cv=none; b=BK2d9F2BAn/R7NPH0PWj/F/Heymd7adiZRh/mxbOWh/aU01ZzBXg2LY2/TFyGUX1Dk88WX0H7VCph3SfBXjzlsgA5L0aGwkpqec/Iwcj3mZji/1vaILtj80/thb1E+G7PtBBHrcVshVXCzEBV4zFmJ5b0fIfQGwGn6O9h+p5zMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755665906; c=relaxed/simple;
	bh=o+Ny7o20qXxTu7p7UosnRlg3OtrgHDDg39QpEwyW5DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwlsrzYk15h1KNQmrr8dxfjYx6HFz8WnAP5cU0KtHYWZuaM4If/qPSjATD36vIQTAC1XmVYlIgEpEtRFLJ4C+a3Bd0cHv0c+dIByQbmzAK7yvOdBZMm4Gtdx6lRzyhmEzTPjDwIGNxfpJ9TlBccQxFi/9W4GUdl+NpEz9nhm3oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FfOcNcAg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ND7Bv7yj; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FfOcNcAg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ND7Bv7yj"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5ECFD1400396;
	Wed, 20 Aug 2025 00:58:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 20 Aug 2025 00:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755665903; x=1755752303; bh=CY3TdUf/9M
	l9kxPW0lY5Hh+8fQFBtefdciJZInH0i/s=; b=FfOcNcAghVbcvpd/vqYZaWVTvF
	o5sYTDALopOAJPlea1PYBkjPH9xq4u44+I5XcScBvRqM5hjZ30k1b0oIWS8kMb2c
	fZVbMnYWOCZOs0Lvc3GU71Y81O9At3PvQdyRrqq5qqGposR9nS+VWC/IsD5FLJr8
	s8sUKIjRsSI3hcbB9C8o34NKruaeMPEpNugg3vcLunc00fRUb/4qOXi/RrbpdJoV
	ivPeg/wJ37nkPobE82oUq3EoFb9HS+ZOG5K+hhAvuwvw48okxy9zT1w58uPGULri
	hT4hTf4NdRAnfRa1+BGG/F/V80obKl7Aii9yViVU1LPxKvpmRu2ZVTjVjJnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755665903; x=1755752303; bh=CY3TdUf/9Ml9kxPW0lY5Hh+8fQFBtefdciJ
	ZInH0i/s=; b=ND7Bv7yjh2c8vlrpl4/RW/S8L62SbmPv7Rfyh3l2+cTXC6NYdqi
	AFQhIF6RYPjvCpFOYKKwgKtTBOSWQbfImFAhsGPPh10adWdkEe+uK7UXsQm9TJT0
	YaVVULROh9z5zf4aHsH/Rjy0uyoEEyrdVPinN44ehexvWBVh1vFVo5T77VvvzYyr
	tYDO6vM0A5EzoAzYoMOiCE2w/a9FVan86d6xb0wU7++rjIBay2GlC+9DjdPwHIdQ
	Z+Bo3WTN+tXQHb1/mo50ZFty2hQWkOzCfdH1bPlsL0HFjSHHFAsbA2uLLjApMmWO
	Fi+VTj3UdocLmyxYEfvtkOulZA7PTpuEtZg==
X-ME-Sender: <xms:71WlaNuhI4NdRJTIDjFXed6MJMD_NcFL3sMrSlUC9oG7rjTZfuT98w>
    <xme:71WlaGqiwy2ZUJEkrhtNjCZSMN1J7fAR5Pic2SnybhxQymSfEHfAZkoQXqEfw2FZo
    oA9yx0pC45fw-Ysww>
X-ME-Received: <xmr:71WlaCmsyQ0v_1HN_2Af46oeQL_Zmg6KIDfKgq1fXl4XGU0vVZQNiyoPWPbO2-uOnGMZEYt5GLfrQLfRufYy_136ThQcWIQfEdlq6zhsfNk6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheejgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:71WlaCyhHT28sePBfuUbn8Ov40agPQSiSnrSTnwWtMez3cHdADdILg>
    <xmx:71WlaCkTk_7fCFlibCnOfP7d6i7HYEbkAO1LxnmKm4ZQJK1pYuiqog>
    <xmx:71WlaDexNpvgq_SoIxf_t55vYiNADFpmOxQX95_DTBX7LO892TjNZQ>
    <xmx:71WlaArWBvzC47_aawFP_Xnj-ZtGCpcqfwRMCC-L_QhA079kzHU5Cw>
    <xmx:71WlaF-Uefzq5HMjA_MvqgSLR-63E6i2AHBlUlJO6AyomA0WCbG9gtvd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 00:58:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 13bf0077 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 20 Aug 2025 04:58:20 +0000 (UTC)
Date: Wed, 20 Aug 2025 06:58:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/16] packfile: introduce a new `struct packfile_store`
Message-ID: <aKVV6fuLuQnOoUoc@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250819-b4-pks-packfiles-store-v1-1-1660842e125a@pks.im>
 <CAOLa=ZTd3JTfkkxuuD51CbvJH1B+ag56LWKCgD55AzmWvi4XhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTd3JTfkkxuuD51CbvJH1B+ag56LWKCgD55AzmWvi4XhA@mail.gmail.com>

On Tue, Aug 19, 2025 at 02:47:32AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb.h b/odb.h
> > index 3dfc66d75a..026ba9386d 100644
> > --- a/odb.h
> > +++ b/odb.h
> > @@ -128,6 +129,7 @@ struct object_database {
> >  	 *
> >  	 * should only be accessed directly by packfile.c
> >  	 */
> > +	struct packfile_store *packfiles;
> >
> 
> Nit: The newline spacing makes it seem like the comment above only
> applies to `struct packfile_store` while actually it also applies to
> `struct packed_git`.

Fair. The remaining structs will go away over subsequent commits anyway,
but we can still make this more obvious in this first step.

Patrick
