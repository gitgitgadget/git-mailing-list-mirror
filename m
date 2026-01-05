Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3987314D08
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613116; cv=none; b=XXYNxBXJhRkKjtzaGLpDlFyffYgCUDe1PoTGP0v6J9UshMTMT66aJEv71WNgT0AQnCgcUh2I0zlpPPjHCEIyA0c8JLhw0RmOrd/8hWKGv5OzPruz0VhQIX0g9I/FXUwwTlA4wnQ4NB3MTTjhSt63KepJlZIk2ClgBkj32EJLPEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613116; c=relaxed/simple;
	bh=w8u7ISe/0opPNhZu/G36dVjXt99eeHIy4xo/uE7p2Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ2/Tad+319suUK+M2k3ao4mtQFVFJY/EEJsNH/9eEMg01Jyd51NkPuetvwfxu0RK/huA3eCieh0fzMuoRhDu856rSIzpaq/FBF9KXKLr6ZIU73nGxeasg5B5eDVVdIfKm3A5QBaZyvhAUgPYOqpQnpRkf0tb26yClHAzQTQbFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KDFKVFi/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L3l1NU0v; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KDFKVFi/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L3l1NU0v"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C97F1400078;
	Mon,  5 Jan 2026 06:38:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 05 Jan 2026 06:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767613111; x=1767699511; bh=SjwOsD06vw
	iQ9v5Flad9OBGrkIMDJkTphVZSxDJ2Ze4=; b=KDFKVFi/7rmI2mB7fj976JZyaP
	sn94hiE5s4Ughpn+fz5WZC46ioN5SwcgB/FdfpyTpY7jV1gBBGKV0cL/T7ILTUFj
	8tZScusQYf9F6UAU6qXe2mpUcWvEkW3+dW+sVy3q1XmR1DTGRBM83y9oT7Ct5CSN
	wr2/4wiU9d0ZNcT9+IHu9aZJJ5ZnyjPlEVtTemNDwoMOtF//Ee4mTMB4Vh1Sb+Tv
	K++QasPfvfcvZnJVyLkrH3pcDqzxYuSejJLhNRagYfdoRxlw1A3Pdk1Jf3qTWbL2
	LMc9C47fHnpKuVSgwA1NJsnPpTZR++YEfkmKSaZKswCxgE20YvNon3VeLcFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767613111; x=1767699511; bh=SjwOsD06vwiQ9v5Flad9OBGrkIMDJkTphVZ
	SxDJ2Ze4=; b=L3l1NU0vfIisG8DdI9qQrQUbJw/Issv//0rLrLsSO8Yz+l26YtS
	uLVQrxm194/tzTChCwvXoRMbB77h+zOmor3dMwwUz3JFxBpqJ8hzIb9rWGdxPbkz
	2ok6yXr1GX1UWxGpqhvZvU4c0NK4EK/rSoogE59APggQ/1pFy273ICUbFBj5+cFO
	0QvfvhOa/cw3X/H4xUd3jIyAOet1S1dmVwpKeEAfGVdKu4D5PSS28yuODVeBpA6/
	PLW4m+wqYboD/XcWm4Qfv2vo8AEMHdO1g6lp9XwGF52wBUC+izN8VjmWrzOX3i0F
	Qnb4mR8x3M7dQOXO93tJ/vrVla4SB/qrK3g==
X-ME-Sender: <xms:t6JbaZIggG_-OOXFHnmjA2EQUHmeiCUYnn0aNZzmPRzCu_k1FP1E2g>
    <xme:t6JbacLKl5z3t3BdIHrYXWkwUv2aGchZay5Ki-dxl6r8KP6XQRzepm0OITqH3Wplq
    ZfCHZ2K7NenHZF6tzGxdAVAemf-uy8LYWECXshYgr8c8Sk7PCwlMA>
X-ME-Received: <xmr:t6JbaWuujaFjkpIGV8q2uzutLKVE5T8ALuSaT-nteZ7t0yUfFDaSrNvBbN0W2sXkXfhpmAcFF1AyivTiWK1-4jCKcdVkbAZLV_7Zf8iY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghplhgrthhtnh
    gvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:t6JbaZRzy4ED4qyaWns5lRt97oGpfYjSAyVqJb4s1AW1mzGwiK7rxg>
    <xmx:t6JbacNjKJ8yfOc1piT3_BrxeJlUxNY8z_zFYqnTwasFRYbwMMTAfA>
    <xmx:t6Jbaeb5LW7U5ySQM1vYUb2SzVoLJxaKLZgfIUN7gqA3csezD0JUVw>
    <xmx:t6JbaWweC5QeDn09Ciaug4LLNGAGbexFajEQyajQ1If6aIlGdMr7_w>
    <xmx:t6JbaRz0yNrQgjuYHS3GGhcqN7jXZ0lSGbHrLGSQ-tCZqZEiPWkkJsNG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 06:38:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5f5be7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 11:38:28 +0000 (UTC)
Date: Mon, 5 Jan 2026 12:38:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Aaron Plattner <aplattner@nvidia.com>
Subject: Re: [PATCH v2 4/7] packfile: always populate pack-specific info when
 reading object info
Message-ID: <aVuirWnh5Yjj24XM@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
 <20251218-b4-pks-odb-read-object-info-improvements-v2-4-62e3e49072bc@pks.im>
 <62dfd1ff-cc19-43bb-a622-af480fd72d2b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62dfd1ff-cc19-43bb-a622-af480fd72d2b@app.fastmail.com>

On Tue, Dec 30, 2025 at 06:03:24PM +0100, Kristoffer Haugsbakk wrote:
> On Thu, Dec 18, 2025, at 11:54, Patrick Steinhardt wrote:
> > When reading object information via `packed_object_info()` we may not
> > populate the object info's packfile-specific fields. This leads to
> > inconsistent object info depending on whether the info was populated via
> > `packfile_store_read_object_info()` or `packed_object_info()`.
> >
> > Fix this inconsistecny so that we can always assume the pack info to be
> 
> s/inconsistecny/inconsistency/

Thanks, I've queued this change locally now. I'll hold off sending a new
iteration for now though.

Patrick
