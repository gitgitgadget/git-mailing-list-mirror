Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847FF1EEA37
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501541; cv=none; b=AGUk9BEllwlUJJUyH+dGpdlrBGa+1ITCWKAENRbs1TYZKa8uisDY2wnmdsPwh89b0IcCQdUWg7VNxANxW8YUJ+ERTK8yUqM3DHqv+ISTQXNZ3NtwcFIOJ/6e3Y6V1mkriWnqK4ZOb38RDXnedx4NADb0bvq4KFz92qdBiojoFN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501541; c=relaxed/simple;
	bh=VStrt8oNZ//bVrwwwGkoiJoks3cRMQNk6K//As60+NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExkbUL9g5Fsf97xflxEy8Fkjs7svPsTk6AyVGLd+MIRMX1iWXqcrw8HrrDyze6TgfPcF4EmkDo5LPSxQvogxF/r/hiVivcUhG+j3AGmKMYKJo6AzBUXoPhvrWEPKQJoU0QCZf3dIv/rufEvmI/rsLbw7XJH4Ac7/b+wtkgEhR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hq6cVJgZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xWWJuEuD; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hq6cVJgZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xWWJuEuD"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 69B071384584;
	Tue,  1 Apr 2025 05:58:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 01 Apr 2025 05:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743501538; x=1743587938; bh=qL9XDjv3oi
	R3xb0lqzJz4BvxkqL82PonVL3hGnUBLWo=; b=Hq6cVJgZe89lHLc2/JTjQrOJv1
	WfJzoZuSItzBzCW8zNZCKCwfj6jO8EbWQrraZGg4Uutqlxq7Z2yqA/lan8B/b9YV
	7cKDGB4Z+77gIRrUbZsz9Zixq9vLr5oiytbtwDkUHgDBpnpFTMH+vfI4r4/9tL7k
	ZrxU/ibVlVdor31Ced3kvoAjD9jFBexqG+2oedL+DhS9xYgPZLHK+bI5ehaBqw+T
	I6WA2jF+oJJ/PAkl09BrVeWjN4NbZ5k75ZGUw5NEDYiIoq8jsQGlaAN8P1HEaxCE
	ScUgMZDgplneUUeov/NBXl8rI6Iy+FahXYDpJxNQrSMWIlzQktARjbLH++iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743501538; x=1743587938; bh=qL9XDjv3oiR3xb0lqzJz4BvxkqL82PonVL3
	hGnUBLWo=; b=xWWJuEuDlh9gxlxnSWzcyv5/KVhVIZVbIls0aGssq16nTG3qx1N
	yvEJI+KyP9rf4ByAo30AT4IST39BnEoH6j+ob6flFELQefzOLI4VgzHMmrWorRCY
	Rf+7aocR4N7gaL6/h20D0WD3RgexMdcX6gatOP0iriGOT8eP2/HcDepR/BdqtEf+
	d3E42snUgWLM5N3EL/aWXX27eJopKyoxpCTRdAkOP8UXgOrptQp3Tob6KmntZcjN
	V5GLMFMKr3BdYwtxJYou5mNgWm1nM/o+hfmQEmwz0GeARSt20jUy093/E9LtFD2W
	F/2a/STAu04FPI/lumdIDDrHwjjWqI6FUqg==
X-ME-Sender: <xms:4bjrZ9HsAsZk3NZ0FAlF1PdVd4jh8C45SHovnXIZTc7NiXjw_szhgA>
    <xme:4bjrZyW3pMarzIyqQu_q-zasK63owVP9g3glVw7mKGiiNlLUJThJ4sZYfHLgSn5Ve
    -cSvATJ2bvtdwknfQ>
X-ME-Received: <xmr:4bjrZ_KQKXQMU8-KiOjwNkKZRX5RnSJR-tLGHPjr5La5JH1qnxOsnsHtEc3_H17m6L7GOO8h-AjWWGTvzTQBU0ITV29as_rlz_pXbo260FWhy98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhishhtshdoghhithesrg
    hkshhhrgihrdhish
X-ME-Proxy: <xmx:4bjrZzGP543XfUo51zrm0NlNi4-7td0t1B_j9ezsVa5ScttJQgyr8g>
    <xmx:4bjrZzXCrTFA20qu0gho18ss7qTqlz-vzs3GPMzWglqgTbI9gcMoIw>
    <xmx:4bjrZ-PqOcOJu-NoqyicGVUYTH_fT3HVo-wZ0dIsOMcBgrRfUYGu2A>
    <xmx:4bjrZy2Gkv6qFy8aKNdoYAd4AhkZA12li5nfFxVgYH7Wwh6PkowQqw>
    <xmx:4rjrZwgBeQwNtXSMWwv0K3toDTW0H_S_QKoP6TEoVSWJMWwFC5rNhi-p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 05:58:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b17e7d2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Apr 2025 09:58:54 +0000 (UTC)
Date: Tue, 1 Apr 2025 11:58:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Akshay Hegde <lists+git@akshay.is>
Subject: Re: meson: Installing completions
Message-ID: <Z-u42Sm613hMj1Ft@pks.im>
References: <Z-uLqQd7QHZq-tB7@akshay.is>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-uLqQd7QHZq-tB7@akshay.is>

Hi,

On Mon, Mar 31, 2025 at 11:46:01PM -0700, Akshay Hegde wrote:
> Hi there,
> 
> I found some extra time today so I thought I'd try moving my git
> install over to using the new meson build system. Everything went
> surprisingly smoothly, which I really appreciated, so thank you!

great, thanks for testing!

> However, one thing that confused me was that the completions were never
> installed automatically as part of `meson install`, even though
> I specified them under the '-Dcontrib' option.
> 
> I just wanted to double check if I'm supposed to install them manually,
> or if I missed enabling some options (I looked through the top-level
> meson_options.txt and meson.build files and I don't think I did.)

For now the status quo is that you have to install them manually, which
indeed isn't optimal. It matches our Makefile, which never installed
those completions, either. But that by itself isn't a good enough
argument from my perspective that it needs to be the same with Meson.

The biggest question though is whether distros are aligned enough for us
to provide standard installation paths. That is, do all distros end up
installing bash completion into "/usr/share/bash-completion"? What are
the desired directories for tcsh and zsh completion?

If there is enough standardization then yes, I totally think we should
start installing completion scripts automatically.

Patrick
