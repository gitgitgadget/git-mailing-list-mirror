Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B618C32E
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 06:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060539; cv=none; b=n4ytVoAg1f+zYw+zZlexAvDHeDaC0rHIcYv6ocTIDgAatvUBoPJLWOzSIwvOYSfx5UWD5uuXDrlfATaSCAKpsayEc3y2C63SN1mgy86G8oD7lyPMf7lDXe3QRSkmQoAxja9rlrVF3W55yDeRdgb+KZ8gd4CudJBjiWyrGIfevBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060539; c=relaxed/simple;
	bh=Vjo1z9Dg/+i5fB/QywOTxVKdqC9cVTxMiT/foglcY2c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CKnke+hbDBoq03bIqvvlc/1kx/LLvAicMQ3nzOMxvK67RwPejlUlX70MHbs6q+2y4c++Eqe36rV178nWZulukj0AqlxJ2ene+gdgbUudWObzaAuHNzkMowNJHT/2gMUcuD0LlDyBqIbgB27/3qZQH95MvtmBD9aUoUavvdQ77Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=EF+IsEJC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GLqLDcZp; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="EF+IsEJC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GLqLDcZp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3897511400FE;
	Wed, 16 Oct 2024 02:35:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 16 Oct 2024 02:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729060536;
	 x=1729146936; bh=Vjo1z9Dg/+i5fB/QywOTxVKdqC9cVTxMiT/foglcY2c=; b=
	EF+IsEJCn6aw99NwqUF8+AjFwo7oi9Au/B2liMGTuiIon4+QNwDLqENPnkNa7hzZ
	cm/pJQnsxEYLEvrXrUuAQJ4kB1yDg6hIfROlSGtB3oO7QyAfS880o7a41IbL/Xbp
	sJlvGYQppzLv/DGnpfXuuteClsGqHqXemc9e7ccmP2vjdofjLdkRqtFIpxd+/90H
	nYd+l8nmgrlVTtf2dUrw/r+KD6OF6JpLZpV03DDhOk0L+pAnBTL6FchhTSpY/3n2
	9IWzjMUlgXCXtt/5cIPggFBRL+THooRuf2lka50Msx6stTdbSGOSuIdsZjd51Hkb
	eRljGRUEfBr1BNpf5jkWag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729060536; x=
	1729146936; bh=Vjo1z9Dg/+i5fB/QywOTxVKdqC9cVTxMiT/foglcY2c=; b=G
	LqLDcZpL2OEsulQumlBWyQtfCWDXRdNjLQWUZA2axMAn5eYaMk6d2qUzMCAm0gEX
	uO4NB01S/u1+AihPA/mNyrYF89DUnwbN7DdYWdejqhj033U43x1mjc5GOdluc9jt
	ixPekIQVEQPOX04V1CzGLp94fV/y3aTsuo7QhBF4uk8jsTbz+6yW+2CP/LhGzlcJ
	pSQjV1NLY1YJ0X5FYfvxCPp4LpZjVKZnMUgIdRg0wH7yfI6m/5rqpvvSYygnD8CW
	/4GBxUyQPHkz4d+2n8uOTLzuMZJUchdktcvLzamO0FeyMXmQiW+kZylvn9wfAbE9
	GLYr3Ocdrrv6k/XChRI+g==
X-ME-Sender: <xms:uF4PZ1oF9m6NkIMWq-Wk17WHHQARElv3hah8wgvUJuBEPwxD4EASNw>
    <xme:uF4PZ3o_fYrjZxSW4sADn7fWwbflimj-RvB0JDfvkUx_BA005KFGzcU5Rr9Ev2WbO
    DscMvpgTjQKH_kcwg>
X-ME-Received: <xmr:uF4PZyP7M8azs3evXKL14DK_PH7JwzAP4AnqYFW8vc4G0aFxEp0SGmrWP47Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
    jeenucfhrhhomhepfdflrghmvghsucfnihhufdcuoehjrghmvghssehjrghmvghslhhiuh
    drihhoqeenucggtffrrghtthgvrhhnpeffueektdeigfejhfehhfegleeigeduvdevueej
    jefhgedtvdeihfejtedukeejheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjrghmvghssehjrghmvghslhhiuhdrihhopdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnsh
    hhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:uF4PZw7M6jpsgWBYO4nMXbOEZ31vphUQyU5PV7OC4DFK1NU_eCfrYg>
    <xmx:uF4PZ046eYaFBKBBrzomfFkRKa7PSja-IVAGcXjTJmTtOF7p8_v_Og>
    <xmx:uF4PZ4iDzhCCfP6EpuJsm0gaHDx5XYDbhOzvmi5ERVXiQkl6yKQn7A>
    <xmx:uF4PZ27CF1YTBnsI3Fc8mJ0Cd2nAg8tFOKjfLyb7j998hgf0CBozlQ>
    <xmx:uF4PZ_3wqZu1jkcRN-GaHcrYhYZF8QLYeYgyT7mQVNNxLkyYKUfhRz_M>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 02:35:34 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Oct 2024 17:35:32 +1100
Message-Id: <D4X0SYYSUPWO.CFCUEN5B3MOQ@jamesliu.io>
Cc: "Taylor Blau" <me@ttaylorr.com>, "Eric Sunshine"
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 08/10] t7300: work around platform-specific behaviour
 with long paths on MinGW
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
 <13c06a8129b13a672d3b8329db83db103607787b.1728992306.git.ps@pks.im>
In-Reply-To: <13c06a8129b13a672d3b8329db83db103607787b.1728992306.git.ps@pks.im>

On Tue Oct 15, 2024 at 10:45 PM AEDT, Patrick Steinhardt wrote:
> Windows by default has a restriction in place to only allow paths up to
> 260 characters. This restriction can nowadays be lifted by setting a
> registry key, but is still active by default.
>
> In t7300 we have one test that exercises the behaviour of git-clean(1)
> with such long paths. Interestingly enough, this test fails on my system
> that uses Windows 10 with mingw-w64 installed via MSYS2: instead of
> observing ENAMETOOLONG, we observe ENOENT. This behaviour is consistent
> across multiple different environments I have tried.
>
> I cannot say why exactly we observe a different error here, but I would
> not be surprised if this was either dependent on the Windows version,
> the version of MinGW, the current working directory of Git or any kind
> of combination of these.

That's very strange. I'll try it on my Windows 11 23H2 system to see if
I can observe the same behaviour.

I think it's fine to just catch both cases in the test anyway.

