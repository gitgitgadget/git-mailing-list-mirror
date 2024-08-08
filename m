Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06607464
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723100438; cv=none; b=D6IlB/F8hqB6VpFpccm+73oGlAgRtCXUMcBFXnGrpDcqt/UIVSZHtK/ql5yOJLfRmuUKTd1M+gu2ApGW64YGOffnwBAAwauHG1fnU2XtCInfIXL2i692uwodpxe27C3R7aaaC801+PtXmyY7mpVYLtQvC1AMdvyvTZ9T/F4ONmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723100438; c=relaxed/simple;
	bh=MBLRsfkEOMpd7XfKGRN+6jFM2oQvEuObQlz8gKQv3U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhqN9SmFlgNpphiDTZscHbV0QNJndwe00S4FpLo5kwDhg3ZS/0ZW4f8kajJ48o4PGa3nKBS5NTe3qJx0Sh1D+k8Y9/8TXq4BwQ9EisRVM0bp7RPBot1MiLIaiyjyMurxQIGvimKqpRFcXKMwbv9VAnUC9RjZ1BKmxtimX6t/sGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ogUhITlm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kWOwKy6G; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ogUhITlm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kWOwKy6G"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 266931151C71;
	Thu,  8 Aug 2024 03:00:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 08 Aug 2024 03:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723100436; x=1723186836; bh=r7HUMR6zoK
	ZTI6KlTGZqxdzZqrtIhiRmQzsMRGw9tA8=; b=ogUhITlmuNax028Nd42CpHGloj
	tMaGnG8oMeb4JkyaiKhKqtkwbgWMcAqyN0XnNah5gSxadId2MN4TAenb5OV0vJTZ
	FZGIfhCF1r2V+uqg7aGBrl0sO4DSmTBWepMi6Vkj3g9PLrTa2086BTgLnb9U0w8+
	Z/Qd0CXqx70Y6X+livPDzTcXNZ1EnGDHImLaFlpvOpFlkcjy7Lo1jppVOU754CUb
	j6QiHXvStLH4JvOrk8+X1e7v5I69CbcMMhkmD0CcvlpQpIRzxqSCCeOGn/t3tc9Y
	lWSFCVSgySUeoZF/cS2tucWwhlllqFvKeKCrF/WUqlxe7FDXb11AS6qryOCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723100436; x=1723186836; bh=r7HUMR6zoKZTI6KlTGZqxdzZqrtI
	hiRmQzsMRGw9tA8=; b=kWOwKy6G9LkTD2Dv8zmvKeNvclrR4Lqbn5cdHLGi/W2H
	HFg+4LcNHl7pzOI68wX+OYiBRyg7tkVP6J0mMA7hsmPTfqstMsNoUBNbj747eGmI
	mdZn7TszFOei/I69GLo+RzbGuxxr3W0SilHMyFhyV33OxLw4hoBiJOpTd0okRR5t
	bKJHLRQOLOMGTU2lzVlr/RzodNoG/qHs3zsk/tyE9EkGpJ1U306DvkpZJwGc7FkY
	zA9EixAwyMp42pVK1ort3Q9iuGgW1PpQKZaz93T6l4byqn3WH5Ke7+bgO0JDJ1U1
	Qkz8vBD0GUEabjwkJi1H2EDZsyRSvBeveJjGIWqrQw==
X-ME-Sender: <xms:FG20Zk8peBDlDXOmsNfZqx9_oogfSkRsIkhPEhRbPHF62TtYFrmyxg>
    <xme:FG20ZsusENekvlWIuNeAs7Q8ZB3A99Gn3G-0-U_j9MSnY4YqKQOZ1wE5qhnqgBfjP
    dA3VHar8bvJrTMbBg>
X-ME-Received: <xmr:FG20ZqBM3NkrnJw5j1ZeqDg8fuOc8Hdzvv3VAsDtiM8WgXmpL2XEN5Z-QfEx-rW9S2_xysRWH_0H9swaDYwTBQBpK3R5cQtx1yXCuoDbrhSRiUme>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepheefhfeutdevtdefieetueeggfefleegleevheffueek
    leefhfeikeetveduhfffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    jhholhgrnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FG20ZkfMB1iL5Sh-XP6_TkOiswZHo3q8HI6wfzjCMFv8jetX0S1CVg>
    <xmx:FG20ZpOIkZzF1KXovzXwixArRTyAt-dWEbRe5aoHQI1_96HAKhkofQ>
    <xmx:FG20ZunUFU37CzfwGdhYvtLe5utFUzj8mb8C-eLp0smHxcJ47EVDCw>
    <xmx:FG20ZruO_jbsi1KMgnjlUTvv6CUP3m9LrY2lpsrcgcWe4DZJ6D9Zpw>
    <xmx:FG20ZuoZb0wZPJFXCmLH1P0FUHZaV-qx6f_6pqUAY3WYg3FN_y36ydJE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 03:00:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 50b50ff2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 07:00:28 +0000 (UTC)
Date: Thu, 8 Aug 2024 09:00:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>
Subject: Re: [PATCH 0/6] Improvements for ref storage formats with submodules
Message-ID: <ZrRtEGIqEGgwyvhk@tanuki>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723032100.git.ps@pks.im>
 <xmqqa5hnn7m7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9PW3fM1G+CS43nNI"
Content-Disposition: inline
In-Reply-To: <xmqqa5hnn7m7.fsf@gitster.g>


--9PW3fM1G+CS43nNI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2024 at 06:09:04PM -0700, Junio C Hamano wrote:
> As to propagating the choice of ref backend down from the
> superproject to the submodule, I am not sure if it matters all that
> much, so I view it as a relative low priority.  If somebody wants to
> use a specific ref backend for their repositories, then they want
> all their "git init" (or init_db()) to use that ref backend, and
> would arrange configuration to make it so.  When "git submodule
> init" internally calls "git init" (or init_db()), as long as we make
> sure such a choice would propagate to the new repository that
> happens to the one used for that submodule, we do not necessarily
> need to have a custom logic that says "ah, the user did not say
> anything about the ref backend, so let me peek the one used in the
> superproject and propagate it down".

You know, I'll just skip this for now. It feels somewhat orthogonal to
the changes in this series, and we're not closing the door on anything.

Patrick

--9PW3fM1G+CS43nNI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0bQ8ACgkQVbJhu7ck
PpQiQxAAg27c9zLQz2mQplCj45ENTLy+t6jXIjnv7Kwm6A6gRWwh1roLPdr+BQYK
lSlDAmbLs8ffslcDS/zJnIbweNqAetH9SubRJyfI7Ddk9ydcgNtzEFmFGyNRr4yH
hUaXnQCDYntO0xi60peM7BORxB8LTOudF4mMWSKBz8uNXdbyzTaOtK6xQacgYjUL
JI6ilhTlHoDf7T+zllTocyEmMgvB8AUYivRrHtRlqq0yPU5ZThfsMz8Es5IJaYLe
aVk5HEPn0HqwBoeZdBbrwRmD9Q3+bfRy6DEIUNTPD0jD1PtgeT1W6VcwSnImtkdY
M9vfyu5+CIFlFsHMdRrpy2UGQMorbGgejMlQnbccJ4kCwyA5HiN61q/+kPPUueKH
ylXNEAG5KVMPcCKMS6gro5AoMthfQf4o1duFh9pVPy8T9tO4VKIckJnGkgEgGq9C
SlOlI9kD7SOu6SglzCr3apix+dyyciZlV+xjmcHGcqKQhNWxGXbhZCCWFBvWNEji
KGzySj75t/aSTx+m5FXX/kF7IFS1l4G88lDEhlPfPtsw69PGGMSpib/yXeMuoIkv
x9YK4lZkP62q3irgxM4JDRxtxHjHSYFx4T068jyvmRUVduGcFsKvGKZt9/8ixNTv
50KJ5W+mv5h6+xL3fGRLPlWH2aNqUdiDFYIprVSW/90FfwnEmQM=
=d3oc
-----END PGP SIGNATURE-----

--9PW3fM1G+CS43nNI--
