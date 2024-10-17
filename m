Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B51DD865
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172042; cv=none; b=cuTaK0r1bokhvXyb2PMR819/CYIrEZNVkQv5O4O5Q4RM5gBC+kQnLN3R744JbCqPin3E+xpGKmkG2iynlmwzX2Coz6YgFUdMYnORh3e9Ff6ShfP8d85jc3ydYdSbW7l9NkQglGkYQPqZaWgyRGdmVIXYJGGBE3Iie86zvv+1KAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172042; c=relaxed/simple;
	bh=USSW0d5pK64af2JNf9EG5nd8mm4VAHlAEUPQqkK92JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srM543FSHR5es8GrPkVmAc88kd3gr21t5Pmm8H70XAFXpjFC2P2L2/gNvItUfG3LEuQ2gD3Dv3lXNqSc0Ge74UlfAZdvnRdrlnlLe+SWoRG3zNUD44YO2UmEXozmzr2ybSV8n1f0B4hjyNma1CcsRtINlAeBMKfBgP9Rrl483js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=etZUYJr8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LeGVHd0D; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="etZUYJr8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LeGVHd0D"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id E74D811400A2;
	Thu, 17 Oct 2024 09:33:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 17 Oct 2024 09:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729172038; x=1729258438; bh=/LjqfBtGCv
	wfrtdSzkdkw3qIQgSVQKj4htdDaNPNe6c=; b=etZUYJr84AahkdOr6JPMYGwVwO
	xs35Y2EMQED/NfDIeGftEf3CgfxkDk8twoahAFwLnKTfOKRyFQt47BAxz4S4i1lZ
	TXMWuEuJzul3aCIbDq37H3/C8Mc1GOjIeq2r4pIE3QuE2utyi3ThDaYtAUYaoiUu
	M+Hkg3qQcC502ah/NbYKmuycEGh4skIeaYjzQyAgFQwP0mP6ArXSZ3tLWomPUnEb
	3pGa39dtVmFYYvopCe8MfZRRAU1HtZCTkf+1QcvwxM/hcSGq0BUgW8db6OMp+bz0
	QvCa/awifykVJ0SbpvJGyZI4WjV0DHJVV+n+/aTeGNcEY6kFfZkjCS1idJ6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729172038; x=1729258438; bh=/LjqfBtGCvwfrtdSzkdkw3qIQgSV
	QKj4htdDaNPNe6c=; b=LeGVHd0DwrmVz8ZfIJFIS9gh4fyuj2k5OQ00SOs0tLH+
	atM7tvLJtIRZnF1fV4ChXes2ZroqHOJBZz4NWTHpnxRrLlmlGcy0uEvHQ5DmQQAo
	tUEy6I/u3s7LNWdY9XWuYhw3vBpJApH8Tlt5Zx5mjwThwDe6qgWiMLy86TkfF3Ow
	ktLS0rRvQEiKX8Xn6CXq13gkmhZ7EcX4j7eK6okypx9Vv2cHHSBAFWKQ0UwlukzD
	xnh3vCRY2I3el/3U/DgUEWLJDN0BHtBB1uy6M9GfLE0XEuWbF1mz1esEoen/5gP2
	OEDv/OlyNVowljeaT1wkinC1GGZA8FSglxSzrV7bvQ==
X-ME-Sender: <xms:RhIRZ1u-0GA4JSfLEMpauWk0yHSXNCwnS-gX4J79FKIX1PQRDlffAg>
    <xme:RhIRZ-fqwHEZls7K7HiC8bezKePoqnaRD_4SGl652uXh1YZ4o0ac6MyL76T7A_n4G
    ca8NMduSBG0UMtO0w>
X-ME-Received: <xmr:RhIRZ4zmg5jY0adizJGtBNBavMl69a2zflmd0g3zx4aumn35WUPQXKoPaJYoaLG7pysVbhDn9jTQ0ycMunkZA5OSABM_-PoEpUvE02kPYaHHKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopegsrghgrghsughothhmvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:RhIRZ8NdPqfMMeKqdFzI7cU0tw7Gh9Py9lqT2l2t9hCgS8m96aC2Qw>
    <xmx:RhIRZ1_i0gOEOlPUO1MEtZF4wPUrI-qCByj61vg-C9K6Xw8Z7OnJBw>
    <xmx:RhIRZ8VYpqqWv1y250dyfNg8E77orHLYcAyNTWd-D4mVDplo5IGaHQ>
    <xmx:RhIRZ2dbzjpftQTX5kfGPX2VXXWsUcz-ivOJu2DbPIvsRvb9nGCoow>
    <xmx:RhIRZxZQM0NJQiitTobKw-OWGvf18TbQdb0R37_nO5az_Ik-2o6kRSIL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 09:33:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 198543e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 13:32:34 +0000 (UTC)
Date: Thu, 17 Oct 2024 15:33:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <ZxESP0xHV4cK64i0@pks.im>
References: <ZxCJqe4-rsRo1yHg@archie.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxCJqe4-rsRo1yHg@archie.me>

On Thu, Oct 17, 2024 at 10:51:05AM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> Since clar unit testing framework was imported by commit 9b7caa2809cb (t:
> import the clar unit testing framework, 2024-09-04), Git FTBFS on uclibc
> systems built by Buildroot:

Wait a second, that doesn't sound right to me. `wchar_t` is part of ISO
C90, so any system not supporting it would basically be unsupported by
us from my point of view. And indeed, uclibc _does_ support that type
alright. I guess the issue is rather that we're relying on some kind of
platform-specific behaviour and thus don't include the correct header.

I'll have a look, thanks for the report!

Patrick
