Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D722CBF4
	for <git@vger.kernel.org>; Thu,  8 May 2025 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714875; cv=none; b=iTdCcHmIJFHQCQ0W80FTy0w/9mWBk+ExFEfu8r2OVKRPF8irmEpEYZTr0vxRZv0pDcPpaS7Lnh7bTLii9j1nhfjeiCjGe0JnjldpeVE+Vr3l81Q5qY+iZKeVkpvYVirGTIJFzC8BepWKqy+9gRYUmNBm86gvog4tUVPVUIqhqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714875; c=relaxed/simple;
	bh=Hr/ko8zdmzDK2lFkfCa6JG57Pn6FIp5FCxnNlrIxOio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=smEhWBxSxxSbkX3b4usBahyCVe3p9egWrtQIbvAc5XwKt3n/gTubOnQhBMsBlwNYWGZe/m3DrMiJeLEqeO7m3tTwpropdyh+n9miM5Nos2QUPyJs8F+RPUydKq8mYYhr4kDu7fz7BhUklSrPC9wR/0Z5Y6xadmOlHN3x+/vrGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D3wB+CxX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fOk6vSrm; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D3wB+CxX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fOk6vSrm"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D1EE52540096;
	Thu,  8 May 2025 10:34:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 08 May 2025 10:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746714871;
	 x=1746801271; bh=3F40+7CUVDp1SQzDzw8nzdkTBn+d/P5gsH8lzGdUNzU=; b=
	D3wB+CxX2JXLPP28uNhtU2N7I0goD1Ile0qYeCrpZOvaI14KEkktmIJs3YYUAGaN
	AUqmn4x5O/iuQhV3b1z4VUyINGS4b/Bx0k7HBoocm0jlwrmgHjA4aIY9QWHOdwsx
	n9pwc3zclOeqJ7YodAGXo7ibKar3uZsjLABpc6C5Kz0OrPWFMJBOjktVOlW8d2dk
	OZCMkx/nFWuMOFKnAY8Z/4Ko78urlf0BnMyz1OyBFOs71BaFZcTHLIo17dPdyG/i
	qHsD+My0yZwL5kO9MXz8pDMZBFGL9LW4cXT4UV5q3d/ZlmwzKTDVy8SuzCJ0bs1m
	mtPMn2vc+1I0IdPqD/Ke0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746714871; x=
	1746801271; bh=3F40+7CUVDp1SQzDzw8nzdkTBn+d/P5gsH8lzGdUNzU=; b=f
	Ok6vSrmyekWSvBasNEyVYAzOEBfT8HziAb8Aw6SeBe6Gj5dUIkhYAPcqzdaaKiJF
	XWriccCjqWgOXBtehhiPOpDKWD+1GJSF1F1uuiukAFC6qUlK81HR8aLSyrRmpnHT
	xCskqEHD6qPOiCc7w0fcOcX0lsZyQh9rUN2UD+IZHQR576ZblmlAhMpIJk221kFH
	wVu+l6kNJ5b5BxGmJ69kdU7mO+B0OQDgpXff3RCQ06XOfUWZDgpcytkAjZTKsZ6z
	aYCawC7LATsAYLRaZ0udRPei32O2yLNZphTKxxqeCpUjQ7KSS1b3eiOF04OlnPc2
	u453bpD2N2BVjAi2fz7ew==
X-ME-Sender: <xms:98AcaK0xESeuMhU5o6Wd2XVsDIU1RJt3JtvfR0apEcwQZ5I23C8oGA>
    <xme:98AcaNGwZS7XmphABJyq-6-cSVR6wAdQCqZOQD2KY_KWuRnGe-ze59DA26eNxAT_w
    Gz0VwPvkvtP3pCJpA>
X-ME-Received: <xmr:98AcaC5nNFQzq7QXykbHoQrEuFmk9b5LKvlZ9UHDvZf297CIOupOfaOBi262fQa526TKyhMkQxMEQl2WoFgwhFJ58VHiFUxZkL2u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeelleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtohhnghgurg
    hnhhhqgiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:98AcaL2uTjbBruatg7m2zFx75c3eMckTJCSemFucwADRYf56w_LOnQ>
    <xmx:98AcaNH4_QjB5t_A5wVrzNNDpn0OtZZM5cD05eyMIeFWCn0XLkg3VA>
    <xmx:98AcaE9TQSFfFKAuO9wnFpmSdu92gEhPwluFEHzlz2xtAYRgK2M6bA>
    <xmx:98AcaCkEG5vkZsphbxIx-n1LyOUgMusaiEScVeJnbyv1itNyf62X4Q>
    <xmx:98AcaGxN-RNKz7Dh-z_YVfU6Gw3aX4ESfPYYg3EfsfjTfuTq0mK_dFS6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 10:34:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] meson: allow customize perl installation path
In-Reply-To: <a9d431944b6d94e0eb25535c061fc226a7fefa9e.1746692662.git.congdanhqx@gmail.com>
	(=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Thu, 8 May
 2025 15:24:40 +0700")
References: <80a2a6ce7c6b05323cf931cdc20d4decb6270002.1745507677.git.congdanhqx@gmail.com>
	<a9d431944b6d94e0eb25535c061fc226a7fefa9e.1746692662.git.congdanhqx@gmail.com>
Date: Thu, 08 May 2025 07:34:29 -0700
Message-ID: <xmqqh61v893e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Đoàn Trần Công Danh <congdanhqx@gmail.com> writes:

> Some distros, notably Fedora, want to install non-core Perl libraries
> into specific directory, namely /usr/share/perl5/vendor_perl.
>
> The Makefile build system allows this by overriding perllibdir variable,
> let's make meson works on par with our Makefile.
>
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---

Will queue.  The incremental since the previous iteration looks
exactly as Patrick suggested, which looks good to me, too.

Thanks.

> Range-diff against v1:
> 1:  14e38695adbd6 ! 1:  a9d431944b6d9 meson: allow customize perl installation path
>     @@ meson.build: if perl_features_enabled
>       ## meson_options.txt ##
>      @@
>      +# Configuration for Git installation
>     -+
>      +option('perllibdir', type: 'string', value: '',
>     -+  description: 'Directory to install perl lib to. Default to <datadir>/perl5')
>     ++  description: 'Directory to install perl lib to. Defaults to <datadir>/perl5')
>      +
>       # Configuration for how Git behaves at runtime.
>       option('default_pager', type: 'string', value: 'less',
