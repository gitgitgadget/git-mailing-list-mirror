Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA93D9DDB
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343270; cv=none; b=BdoH7T0+CLHRQhg75gcXy0KoVa1noWj2c4d/YNR2nkuFbxVxUmFKfkRjOyA52A5aKwGaePu/JOGn0ZuRjf6Czw26RC3A2xKV7Bxj55ER//imffeL5vcUzpcVvyhP3+3MpxYjPrNHuSE+5KDYLOpWmp3FS8ZW6g4H4nUYiM7EDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343270; c=relaxed/simple;
	bh=f56LJWC5BtbiTVVyXIhTfQRNCdcliwf+NMFKBZesB94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RI8CarGopsqGJNquAUYggzNx9bPsY3AcpNm17ZuvVSGmlO7L0s/3GSXbBXkUNTK9pB81L6c6Pc22+fDiBGx6QcJaF/7aTRSjqvcTNKwVjVs6z/zVnM0QT/ArQUL2X4dRgks4VBQA6XVKiDR+9zDl710Hv8BWEHkbTIRijtRcvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QmGtEwen; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1th3Fw4H; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QmGtEwen";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1th3Fw4H"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 773E8EC01D1;
	Tue, 24 Mar 2026 05:07:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 24 Mar 2026 05:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774343267; x=1774429667; bh=TZtw9wRqQm
	FjMTNxLJTJTT8g2La4GDqLwfgnDiu2N4s=; b=QmGtEwenyhQir6f7IDo2tlfv7d
	VSsU4Ensbwh+6332js5tuXiuusx5H2XBmFm8czhaDMBkK0y9Z1rwphsWctAwZlIT
	ZDOHHuYdMhk1E6IkB7o1m1D3gFfCcj6FKNBpkLZqpDFrNnbjZNV7HC8j1+VSzUvS
	GZpeG7JbEwBexoi+AbNsM/fjJfEdc/5fwVBFDf7Tyj8FBEydUDGicNtyN7ubtLDQ
	RKmpc4tqnqp6y7kdxyKc3rJFWIwUHnQQlRJnm+ESQ5o9dHfelF4Wc88OWWn4E3Z6
	yNzfC/Kl29BPrvTgdX7j4bNIPOdJnhoxjGHF56laQElYA0L8vKIuVtxeZH2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774343267; x=1774429667; bh=TZtw9wRqQmFjMTNxLJTJTT8g2La4GDqLwfg
	nDiu2N4s=; b=1th3Fw4HnG7i2ReeZw3Wm0E94ZCe9btkDoXz8IUaC8oGpnOo9oi
	7E96nGnfLLF1e/6cIKecKsj1TPzNbe7smM/pIcAUIhuwP9aEUmEdcipb9DEIZ+r2
	8+PL9ZfacOVYQDJywLAMYPGXZuP88fvlXz0/GYYhQOLAPrO2smypxNhBKW9DHErW
	W457FPau6NcnXyBLALeAtWUH7RFYg/Yb3RABWgr8sQytvAhhScCYkGPuJJpd6qex
	5UXRtIJo539MFGp2i8kMrdulpqNHYWJuaqXbfhHaC9Xg1jjxtdbQYG+p5DC40rdQ
	tEtddEp/mIsS8pCVwo/2XyvbNbIGASXomrw==
X-ME-Sender: <xms:Y1TCab9jNYnEfdFvod-2FRmdmxYlgNlubBtJuesH60V6SKlu45auVg>
    <xme:Y1TCaWwN1odnZxCJQI04uaKnomCzWw_g3olpsILlJT-fgdb1r54HAiZsTVxcvla5i
    4jb0W_8NVQuqJeMYzcbPOhXYxrWTVLWJiod3FH1ai7Bkd4i7AxBnw>
X-ME-Received: <xmr:Y1TCafN8T8F_bVADA-k3FZMEwfQNzb9UnuEhxU729RMaz4fPUh-NteNP152dMYE-FzHAEt1kEUY7o5PJCcg0vEwqTL8w-TRVIZssIsvHoVxOhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegrughrihgrnhdrrh
    grthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvggrughmohhnsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:Y1TCaT-jBxhSiYDfZ-9wwtWj5hoqAZ3F0lNvc0K7k6FtY_AVqHjNvQ>
    <xmx:Y1TCaU6qPWCP9q-dRHGX5OZh34dx289R6djyQxWn2_w-q8ahjefEPQ>
    <xmx:Y1TCaR6V4-UeLmEbHXs5lb7fVRpZcMeWygcByUPRsr9dAMOX1qunYg>
    <xmx:Y1TCaVrCSljlgXa-T0SVWDR2UpJZYH25lX6fmCgYB0Ws-k5XlgGc0g>
    <xmx:Y1TCaSQSdx8Io2gzQrMoueMsQhZRziBsZ7m07na57NcLNgssU2YZDkmo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 05:07:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 89b3d787 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 09:07:45 +0000 (UTC)
Date: Tue, 24 Mar 2026 10:07:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 2/9] hook: parse the hook.jobs config
Message-ID: <acJUXq7cMKG6KExe@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-3-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320135311.331463-3-adrian.ratiu@collabora.com>

On Fri, Mar 20, 2026 at 03:53:04PM +0200, Adrian Ratiu wrote:
> diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
> index 9e78f26439..b7847f9338 100644
> --- a/Documentation/config/hook.adoc
> +++ b/Documentation/config/hook.adoc
> @@ -22,3 +22,7 @@ hook.<friendly-name>.enabled::
>  	configuration. This is particularly useful when a hook is defined
>  	in a system or global config file and needs to be disabled for a
>  	specific repository. See linkgit:git-hook[1].
> +
> +hook.jobs::
> +	Specifies how many hooks can be run simultaneously during parallelized
> +	hook execution. If unspecified, defaults to 1 (serial execution).

I was wondering whether we also want to allow -1 as a way to say "use as
many jobs as I have CPU cores". We also do this in some other places.

Totally fine to ignore this for now though, we can still add it at a
later point in time once somebody complains.

Patrick
