Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D4D376A16
	for <git@vger.kernel.org>; Thu, 21 May 2026 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355886; cv=none; b=rvZ0yN7s21qxavaOwFLg4CgE+h8KUQ07gJIjLU2Bc1YOgzzLNsIPCFfUYxuRI4GL46IIq76X0VXjmys1/uH9iwv8im7vtskQ/VhhW1fQGiU8vbEODZtWSZaykDdRiE8WvSZyBlYu+fO+DNunxLwjpaYO4kR8dh16qQ1xZYewd1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355886; c=relaxed/simple;
	bh=RZjOyH5ZcQVCPd+VcTN3i+1tGHHwKM4kqsCaKGyoVUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTF9oOWOKXryNMnfI2RyS01n+7XyHx2E7WslQ3jJyytyDjcvmDTxRdpp/WzXAYtwpngEgM+itO4Y/YAHtFQo16lqb+D2NhpIDM0k2pUpV+qgjehCjsTIKemBTkZybAdohHm3424YFtjnMzCGSZ3J6l9m0khWPQWnPY2XWIlSHoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h0zWH8xB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fWaJ7+JW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h0zWH8xB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fWaJ7+JW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 706FA140007C;
	Thu, 21 May 2026 05:31:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 21 May 2026 05:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779355884; x=1779442284; bh=9pD7NfWh1i
	f05p+ROnzxErOZZvT7KC3sh/LFOquLmC0=; b=h0zWH8xBSkSK9WYjOUczcOC3Ck
	WHKDGhE8B9Ap0MELMZrKpbTfs6jJpw8A74L5db8qAL0czItBRrKuJMkiY3wn3m+h
	kYLYZ7KUVxWjJKtyeViFV8mpuj+oXHTTYXhx9HdjqEfhe7xDlVJCUbqQh1jSpjnz
	LUPFLdNGuxAquLHJof9YouTrqrmRVgG2roEp3FTR6H6ocYZLrS/QSGFfdOfyczeH
	/5DI9hnmGxr2I8VYhaGD5WD6BSyR9HyRMiNjxMgN8Vyk4SnLWJOaLjIbGjZ7ahJ6
	IQpTkD5An87kQ5keOgRua+J0ZeCYWZgFmfnbFCDy8Zl1v8X0b2udcBRoOM5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779355884; x=1779442284; bh=9pD7NfWh1if05p+ROnzxErOZZvT7KC3sh/L
	FOquLmC0=; b=fWaJ7+JWiHfMfDR43OPyb86Vd5vJIL+G4k5Ud+FSfTVxCbrBiAo
	J0kk9RAXAIkEmj9SZy1OIs2tkX5o07AdAKuY2LmwIpXs4PYX5DIEy84FRqNxW19I
	9S+rS94cbDMsvw7XSA/QlA+UXNWqw42OZCLDZe8vcegZcSXrMoWgtbAIU8SkZNr4
	C7lFtoHjyrlF0pek/4C6wHzlH14RRbNLpngiBxpc+koK8g3t57iZJGrRSqFXnGW8
	I0/gfAP+GxMxtsKzxY7xTm5wdLCid3KKRj54X1hwHhtgj9L12vWi6SSCQUGGEjiI
	rCfR/kkS0f73YQoiVzBfAaaf1c8joeP8+DQ==
X-ME-Sender: <xms:7NAOagLQmtAYqyyE2qiWlDA3SeMnoFR0FhYOy2OBNjg0nEKXP9aMJw>
    <xme:7NAOanlUdhixxYXjxW6BF7KVWdqft_2osSm_9hI3chVixJYV9I2xsTk5rP5Tbvw9U
    sMqep9i9xtAAGWokjWYi1IJEK2AmTbSq4L_JrLfEBaEEVPPmxzCZQ>
X-ME-Received: <xmr:7NAOauG1ULzq5f0I-foCGbE2upLpLXz7c3Ub2J_s_HMI8JZI_gSYISY7SIzZA_NiFMzjrDOxqfh_M151UVGPAxdHSTg1qicuIc2FPIKepb4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknh
    hosghlvgdoghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhm
X-ME-Proxy: <xmx:7NAOanEa_GPPMnqHuUMgXiD7pHt0aHpPkYXyUwQEIvTXDGt2c2k4oQ>
    <xmx:7NAOarNDptpaiid2IhBqn6_E-RhEPjiFpyPMitqLCDlkyCmk3Ylbxw>
    <xmx:7NAOamEmMyevV8vm7YAWHSNgH4HS6fuescd_uMTc0LgemZSAsb-Y_A>
    <xmx:7NAOaiOHgZJYujLXK3NnmucQ1K26Ns5tL3BGu5-YqsY9g0TmdCLhng>
    <xmx:7NAOavnvE0w9EVAMe1apdef1HzjkQnxbI_GRzgv3rNdwmNFw5WsTjBoi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 05:31:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a8e04675 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 May 2026 09:31:21 +0000 (UTC)
Date: Thu, 21 May 2026 11:31:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: Re: [PATCH v3] generate-configlist: collapse depfile for older Ninja
Message-ID: <ag7Q5_qz2MCAcdFp@pks.im>
References: <20260422-toon-fix-almalinux8-v2-1-45d8471ed0e9@iotcl.com>
 <20260515-toon-fix-almalinux8-v3-1-b545a0647f0f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-toon-fix-almalinux8-v3-1-b545a0647f0f@iotcl.com>

On Fri, May 15, 2026 at 10:42:26AM +0200, Toon Claes wrote:
> diff --git a/tools/generate-configlist.sh b/tools/generate-configlist.sh
> index e28054f9e0..d1d2ba4bb7 100755
> --- a/tools/generate-configlist.sh
> +++ b/tools/generate-configlist.sh
> @@ -42,9 +42,12 @@ if test -n "$DEPFILE"
>  then
>  	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')"
>  	{
> +		printf '%s' "$QUOTED_OUTPUT: "
>  		printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
>  			"$SOURCE_DIR"/Documentation/config/*.adoc |
> -			sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /"
> +			sed -e 's/[# ]/\\&/g' |

The `-e` switch is now arguably not necessary anymore, but that's not a
huge concern.

> +			tr '\n' ' '
> +		printf '\n'
>  		printf '%s:\n' "$SOURCE_DIR"/Documentation/*config.adoc \
>  			"$SOURCE_DIR"/Documentation/config/*.adoc |
>  			sed -e 's/[# ]/\\&/g'

The extra printf could've been rolled into the second printf call via
`printf '\n%s:\n'`, but that's not a huge concern, either.

Other than that this looks good to me, thanks!

Patrick
