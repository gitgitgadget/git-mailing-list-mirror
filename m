Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BFC13C
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442392; cv=none; b=KEqd5x+UQ09eCQ1Bi49UOqcNmBA5FdaU5+SYU5uhKZdbbVY1GA9/m4ixoZjb3aSrORCQTGnYaEFvjg8qLW9kw40Oj7I3Ho1JJLwusBXZv0FFNvGQP6xshjXMYDNGN0k3glSjjGYeKNSONDbYKXhFqrU2n4LED8e1tb/lPXrrpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442392; c=relaxed/simple;
	bh=YEMt7otJsrL9LqR6zhJ87QycHFAFqAFwKQNg/EW4WMY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=oNSm9Sqj+y54NX8yDoI3k4NJFQ4775x4JaK8tiQBpl5jo5DypebB2UUnfMsFuVZ2DwQPQFRLdHATlnJwOgHFV8Yv4gj8+mdmSCo9QCdRFksaXm7J1Ev7CQoYiiHIuk8/9O8ZfyaHAMfcdnS1U33L23jt2OPafgzjGQ+oRJc8iS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=Bgt4g6jM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PD3vZ9wG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="Bgt4g6jM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PD3vZ9wG"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id BDE82138025D;
	Mon, 29 Apr 2024 21:59:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Apr 2024 21:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1714442389;
	 x=1714528789; bh=zZ3DYIVMioyYe5gMBu02EA8D7RhqVY3zK3KyrEukMfk=; b=
	Bgt4g6jMeAKQfBJ/5ja55lZKwvVgwzjQWpPYPfsWAQ1IxO9hJnlCp7+cSoSijfBQ
	EI3wHbFj91h8e9blF8seUsRZE8DJdUd6vyHNqQa3O6Jtpm2bOgpcTMbtXwXfW/8w
	FnYSavIMBKAzBA5HGzwLLR8pH7X6n+XkGNe3c9ulgk3i0W7LO2P8Xu1cvHrYXh0I
	Vh+7esXq3obyDnql3ar5a9G2YU34AuaxTruQqMEbR2Pa91vKEBtinmsi/wZeTLoR
	wDe9jahSduG/bg6MzIGczmO+DsXYwE079/6NjZfZvnyQ6oG1qxGYzNnXPMb/XTBa
	iwXgkgC7NYBuVyrxnkdO5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714442389; x=
	1714528789; bh=zZ3DYIVMioyYe5gMBu02EA8D7RhqVY3zK3KyrEukMfk=; b=P
	D3vZ9wG3RTrwKHDZHKSvD7odj/bd/fuk6YBx8KaZ1cpCkSC/ntpMcmlnW/vRHaBw
	98VVY27oDLMTAhZLQtznaD3UqZDOPjghGSueZlShaTM3yLpujh++sWoIfFRI/m7u
	PRRXXrRpClgAIz9NGICo2jf/1/yvi6DZcJ6+LJ2IdizlER5BM0CLVz4P5tBR7ERR
	skcN45wnqRvdOBw8MniXWCTAzLxB9NuY1+Gl8eYfEaoKwf4hj4+kphZw3sGlG0aj
	I96PpNB//Vw7c3g4CChHTla0PgejaZkLbLfWQThM43jFv6ocklFfSxTB3cm7llP8
	03Bx/EaXNlNjp3HbT65vQ==
X-ME-Sender: <xms:lVAwZre5Jr4q0f2M_C2nTcWvfUiruPjqq7SPwCaHW6iyAKuRMhQQiA>
    <xme:lVAwZhOZAfDGRp7CmXFs43u0-HxAP6DchLE-2Z8m_2hHzIwb9aeiszsE46fD3_S96
    Vf5GzMnmVl9ZDXaLA>
X-ME-Received: <xmr:lVAwZkiXGS_4a9Bfq53Tc3-wcPu7yBjQCUK6DJm4s4rZ42XkGlCVr35u8zdjfOXkg_PmPfGa1J7RyTENGkTsxyUG2HU3FNpbNJ6wUb43>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdflrghm
    vghsucfnihhufdcuoehjrghmvghssehjrghmvghslhhiuhdrihhoqeenucggtffrrghtth
    gvrhhnpefhteeuheduleettdejkeduleeuiefhveehuefgheehvdeikeettddvveegieel
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrg
    hmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:lVAwZs-FEzdQJT11yN7pSL-NMTir2vbblaicueVLZs1vrBQP5MAkcw>
    <xmx:lVAwZnu3nxb6VpS7l66j1jgAoQTahpHO-IN5EvNSdxXsZ1luOfeKeA>
    <xmx:lVAwZrE9JHGW4gdZzWukegnnSi9G3Fs3p2wGQSJ0Q4IwQuomMtE5WA>
    <xmx:lVAwZuPbpIsIQKGodVMnuWpCEEhYW6yqWx0qhdi1gRIoIOhYZs_khQ>
    <xmx:lVAwZg4ZHsTSNe57Q2sKCSlhZ26LB9qQ4aAOfp9g0UAEtZpSNgYkNSYy>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 21:59:48 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Apr 2024 11:59:45 +1000
Message-Id: <D0X33QRECNTC.33V5ZK9NYIE1F@jamesliu.io>
Subject: Re: [PATCH 2/2] gitlab-ci: add whitespace error check
From: "James Liu" <james@jamesliu.io>
To: "Justin Tobler" <jltobler@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240430003323.6210-3-jltobler@gmail.com>
In-Reply-To: <20240430003323.6210-3-jltobler@gmail.com>

Thanks for putting this together, Justin!

> +check-whitespace:
> +  image: ubuntu:latest

I wonder if we should pin to `ubuntu:22.04` and only update this for
each LTS release. It seems like we've done this for the
`static-analysis` job above.

> +  before_script:
> +    - ./ci/install-docker-dependencies.sh
> +  script:
> +    - ./ci/check-whitespace.sh $CI_MERGE_REQUEST_TARGET_BRANCH_SHA
> +  rules:
> +    - if: $CI_PIPELINE_SOURCE =3D=3D 'merge_request_event'
> diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
> new file mode 100755
> index 0000000000..1cad2d7374
> --- /dev/null
> +++ b/ci/check-whitespace.sh
> @@ -0,0 +1,16 @@
> +#! /bin/sh

nit: there seems to be extra whitespace after the shebang :D

