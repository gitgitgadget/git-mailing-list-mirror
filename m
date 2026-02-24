Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345DC36C0D7
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925723; cv=none; b=e2VCLl0SVGlwiPTU0aCKHnAAoFbytGHEKcYxPstkjFokwpRaHH7tTgLG05/o3umXF0Affyf+rlXO1f2fXuxTy1pxaw5p8+t8UlOk+2iGCJ6UmGl7TlFrbaVqRt3fSX8CTpb26ys54Poy8YVe9WhNTNLgBGyueL6fxyTM32qyGow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925723; c=relaxed/simple;
	bh=XLdnDwtpLFDoJBaeKEEkB+CQjMAPCesjFsYRIZTg7DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzPN9eKerHWFuZ9zl5jDcWoMRil1ROTN/eVJBv2GOz+lAwajiQKWeBOVZf4loCRImReIxItclwurWyLiqlj/rr6uIBOAAGzJSctF+YWo8GXdtz5aQNBNyvL3lLiELIEsNRX5TJpUkNuWU4208qIFYc7bEu84n95SPgU8qSLab+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nsD0VUof; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IyP/+GWd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nsD0VUof";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IyP/+GWd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6162714001B3;
	Tue, 24 Feb 2026 04:35:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 04:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771925721; x=1772012121; bh=XLdnDwtpLF
	DoJBaeKEEkB+CQjMAPCesjFsYRIZTg7DE=; b=nsD0VUofOZPHTtajxLeA0Q9fOq
	nCkTZ8Zc3Z12eBJ9Lxo78cZx3sqat+/v1kFRHTsejzp7DVaerN7Sbsy0b3tUInRG
	Git28Zt5wdl5GK6ps2+c/hm9z/TpZ+LoRthE2uLB/01x2eeM5/coDhLFMBzroEv/
	z38dqWJGSLPgRE9o+OGNptRvgwf3ycf2BGo6Strqop85yfxaz8+a8kVM8thf190a
	M3wP3DGVWCheJBO9r2eMxdnBL+nVUo1riH6ka/q27MKwwu6De/2woj0q1v1gB7V5
	tyEEO8VVuThlEguNRDb725VcmVPQplW0qVMkzsjeisCxZPMqmd7zMjSOFbSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771925721; x=1772012121; bh=XLdnDwtpLFDoJBaeKEEkB+CQjMAPCesjFsY
	RIZTg7DE=; b=IyP/+GWdstQPZ9eLTtZqkuDtm8+My4UGBgi5cH9b+OmfkxiGbgq
	TLFv3K1FM8xbmRTjrKc9hO6n+SbqmtcMpU7i0aQl0XnS2q7G3y0CbpvLiplpecE4
	eWjO86IkdVH3vYUAHQy9e17X0KVkDzTZQ86UBmy4LGA4Rppp5AHukgPmtWzuDHze
	tYgd3RofhvNuPigNLtHOCa/hc0QTiTAW1iw8EKw5imQ5xvzfyvkih/6T/qKOUYVf
	nLss6H0A9g0rUFR1DjqhqN0xNjtq+Xi8sG+446QDw0vcREj91Qqh3Yl8o+2X2b8I
	NOw0HzT2/NR35iHc2GHpDl0+azQeZLXdq2g==
X-ME-Sender: <xms:2XCdaTQzFspSFZvnqZGYbfXi4QwpdWKgJFqkr4r8D6_89cJfDbLIOw>
    <xme:2XCdabxFk6zKdSxpwjK90ArOEtZpxRfdA7xutJTsb5PVp4thi8hCi2Qh7y84yDq5W
    D7bkO2PYpEjdVFOQToATwbvv3zqocvkLo7UGRMtf8gDAkp_vJtr7Q>
X-ME-Received: <xmr:2XCdad2mlYpqxUyanuVO2oU_xvpygH7624wJbX2RkEqj6BQVms_H7l6aolWtX5S2Jm4Qxia8G7Nw1V8dYJaOXpnqH_fU1MIepUUVK0Dcnfpirg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuug
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:2XCdaR6ofsii4jQhD8H-7gNNWYx_o4BUOJm-Qu02EiSLoKIQtDMGHw>
    <xmx:2XCdaYW-4dUzWYc_i5MdzHfI3SUCs47rMmdw8GtypZsfAet_QVR5Sw>
    <xmx:2XCdaYDqeylb9PKgIQ0HwEZfN0HPa36MU-SCCM8okzz1p3dMW8HSWQ>
    <xmx:2XCdaf7rXLQOZGgytLu8aYpPjd88IHIXDn0CTRjY1BatiW6brfj-Ig>
    <xmx:2XCdaexVuOE4Bnij9oePN7UwWT4DoRYwrvjvpQwr94eOAt-Jo6OrKoB8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 04:35:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 82fdcc2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 09:35:20 +0000 (UTC)
Date: Tue, 24 Feb 2026 10:35:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net,
	christian.couder@gmail.com
Subject: Re: [PATCH 1/2] commit: remove unused forward declaration
Message-ID: <aZ1w1cOehTZ11hUI@pks.im>
References: <20260223194146.3476768-1-jltobler@gmail.com>
 <20260223194146.3476768-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223194146.3476768-2-jltobler@gmail.com>

On Mon, Feb 23, 2026 at 01:41:45PM -0600, Justin Tobler wrote:
> In 6206089cbd (commit: write commits for both hashes, 2023-10-01),
> `sign_with_header()` was removed, but its forward declaration in
> "commit.h" was left. Remove the unused declaration.

Indeed, the definition of that function doesn't exist anymore.

Patrick
