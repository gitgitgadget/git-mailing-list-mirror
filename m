Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F6204C36
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761259082; cv=none; b=bWNvtIq8lFhcC4Dtj3GWfucQIEVWzZk43fjcsBfsw5alMqu7JSwlR8vycPUmBTAQp2JycDpTgNwkfq9lvJQUxx7tfCL/5nzwYcOQ0RjzWu+78nfBszkboPwySAgg5dEkjGjcowJ8toAoefq8rZAO3lSiJBEDS4It/DL/U/35hO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761259082; c=relaxed/simple;
	bh=7952QxeQDNuRlzJOzzD/vWE8V6nPpIZa00vf6ZXdaoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q+4YEp5uNSTRQ2LDrlfngE3b9ezcKDGjBuqTny/VhKKcNUf20yAVVkcaNRbYAbbQA61H5F8QN1iflpe+J15kMP+7KJH1NFQD3SwOm6XUZDT05HA5MFc3TdL9Du2zLg7SUH7z8dFdsTb0rK0NDkqhfNVdTiI8vh8COHuAYgqH+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fVN19UaW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p/EcScjr; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fVN19UaW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p/EcScjr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 327F41D0017B;
	Thu, 23 Oct 2025 18:38:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 23 Oct 2025 18:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761259080; x=1761345480; bh=fntKnxDoyE
	wY3X9JrG0iVsMb5YbyDFM/mHkvkuD72Ho=; b=fVN19UaWScPicXBIo8NKcRl2k6
	lqkopiMaKboa5zW7ygICmAeUTAYm0+0yYBISE33B2cxwAxhxGfHBCOUUeFSQBjMi
	SmXVaYH3fHy6jwkrD7zEfX0zTVMh0/LBQ9MisrXvP6fhJpsntnNV4G9Z2qAeIrh7
	V/QLlKzfGWMQ0Km6cBsTzcMmOXGMdx4RRZsZDtyuFV7wqA2wiraSx1SbnlDdZWp0
	af6HKuqVUTB19eHRDepd11BrktIV8DJQ8LO9GUlJtAXkF7ykQb32EMCzP6neVujT
	A6CGMSX8fZmyEjsZrqSZmlpTt8UmH1EcxrMRUITs7iLG7TZU4+ZeAaub2eNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761259080; x=1761345480; bh=fntKnxDoyEwY3X9JrG0iVsMb5YbyDFM/mHk
	vkuD72Ho=; b=p/EcScjrd4zSTKw60RBqSluvyDVlg1fbaPf1q+Czmr8981w8YSu
	nRMx3SICYQJeLGWN2CmoxpugmSA3wVxtsAoBDhN+imFcT7jheutK0lmujQcwqYTx
	zn+DCy306fhNhrAjiX7og52BAjz4VzYCU5dY9v+qIRKaiBzEdcBCJuJkZReUlmBH
	IzZQ5jhXbuOvpck6m3Z4hf7va4Ubm15Xll9J0BTS9Dpr4GyC8fME1Poc7iYQBmtk
	QJjglhuEendZ6ncPksWdnirRWgxZkiKNGpLFpWyTXf0b0OPEeC4p0PmTbhwXkygI
	XfAAbWiN5X5vb3bCWFgGfmGlW2r1O3kAT+A==
X-ME-Sender: <xms:R676aLsaJchTOkIKm9cjFVl-n7yHflKn3Mylr1b7e7HeospSusYr3Q>
    <xme:R676aDVKYXf1hNbomUGwx7rByTfFdajo7nIbh6UxupFP4gP74rKIUTGXwLgJcAXAZ
    iffWhWIop4Z9GWwDLYq7Kcuj9q7kPvFVTzx043cJIvhNoGWGom5x_I>
X-ME-Received: <xmr:R676aHHJBj-OXD5cfIHuuDslYbdL75KB7OxL1Goyy2CiF7SMwI9rwxzjV5gIEokXaRadxUSQ5glyjrxsX3t-XWegycmKqiICDSpk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhs
    thihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:R676aF11rCZEFLFZM9vCUCYQnp3vJjAUnFYmsjXPv3kF8kwiqnqN9w>
    <xmx:R676aJNDsXXjtpwpzZ9WiYSgv2vhawg7UnTM5XmYf1Jns6kIPns3ag>
    <xmx:R676aE4xsCiZrNn-rW0ikSQpkAVolTRf_XltUMoNXVroJKuvN927PQ>
    <xmx:R676aD1acg1LduARDUYcUoTfulX0PlUzRrYQoUswAfbPFKV8DeUtqA>
    <xmx:SK76aEk-gEWtyhOaSWaTgjtOASNStdo2jc6A1zhQnd25aLAJuCeAEXa3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 18:37:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
In-Reply-To: <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im> (Patrick
	Steinhardt's message of "Thu, 23 Oct 2025 09:17:40 +0200")
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
	<20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
Date: Thu, 23 Oct 2025 15:37:58 -0700
Message-ID: <xmqq7bwls0qh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index b7b3cf35edf..3bce6f47f87 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -37,7 +37,7 @@ fedora-*|almalinux-*)
>  		MESON_DEPS="meson ninja";;
>  	esac
>  	dnf -yq update >/dev/null &&
> -	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo >/dev/null
> +	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo cbindgen >/dev/null
>  	;;

A single ~120 columns wide should be line-wrapped.  This seems to
fail with almalinux-8 CI job due to lack of the package.

