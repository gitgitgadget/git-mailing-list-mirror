Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D713D9DD2
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168467; cv=none; b=MAO+QpzbE1KXH5Qbc+IaMxfkUA847zk+IiKvpLrAeUn1GLXm0wIhVwFFHB8y7oT+0TrOzQBocXo7dnpgi3nhzrkN9v1orFlirfuok/QQe3qTMUrIDFLn9Cyq2viD9FNvmTJyCA7/Y0Xci3YK2Pq7JnBrSx9o9pVSyvsh+xOFBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168467; c=relaxed/simple;
	bh=hQ3pZOUQSlEAeVWT+n2+G5ow9ShoaAX+C+31KPINQsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnNz0lV3eijyOfwimWiIalpRrhxoyQw7gsSlnPDKOQWG6OZqes1FwzEehP4Q1EXojm2MtlriQd2mtd9vfqrNlwbe4lZMVAtc1Jb4X/HVK0Dii/d0HAXvvCUBCgH9ZxIY994rwBDVYM/c786n3bLE4c0nRnOONvttTdcTVPW/nNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Eg8ywXiW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YE+2k3ih; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Eg8ywXiW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YE+2k3ih"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 236AA7A0178;
	Mon, 31 Aug 2026 05:27:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 31 Aug 2026 05:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788168463; x=1788254863; bh=SS4Qz78X6D
	V4/x2CQ2NMQ9WDVAXiGmU7VUvSh03UguE=; b=Eg8ywXiWGY9PNprNpyz69jIScb
	7ibVBfuUl9P5d/FsKo9iYUx2Omh7WWjKX20YoGy+Z1Op41RGFZoSjvY/sBUHmugZ
	Bhk2m+gYQMYubRzmf8bAE+CbkqVRowmOfIgeKI08WXx2JeoyGRAzUcGPIFhamiKm
	txg4g+L7L+1fDr4eGnkoriVcezZsjg37upkAAfU7Y8gUuCgQ5H3ApSRBG49kjFl0
	aviNCZRWbuOaGcpjgGnMHmzAOQXmlqE/4a7qV6r8kf/4a42KW6giqzQQB4Sf3wUu
	WMeO99/Lvavc7rQbDRWNmQaIBsAvRJcNCxycgQjGse/HtEFP+p2kdTK6MZ9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788168463; x=1788254863; bh=SS4Qz78X6DV4/x2CQ2NMQ9WDVAXiGmU7VUv
	Sh03UguE=; b=YE+2k3ihF7RTZqDhNLz6/N95RdWQc25xtwbS2WGt++d+PrebC3c
	U0pWzSZJpY8qo8fBViW8J76CnZEnT/19dMj6h0+TxMPwWwWLSn6FCq+m0RAE8j7/
	VlAS27VtzXwZ+T4Rt/0wBF/vkfZj5udOdaH8e3yVrDugVKnoyc5w1iz3tAs4VIvv
	kJz8LE8G5MgNpnxn7FDwJxX/GdIhoZv9uQpgzwAoqXWxLIPtLJLt+sivd5OJ+tCK
	k0FnuONBpT597tsFpLEfd/wyRuuq2ncMaBDGh3A5VSycGaAZtQN+5myQomy2NtVi
	wOUM9wWqYXoeBz1SrlnzUc4V5/CWfrNBNgg==
X-ME-Sender: <xms:D0mVapT2mO-rj3yhwDhaLRLdtaHrxi8c0fQpE5neBOz4SzqmDEsXRw>
    <xme:D0mVamc2ixHbe08ETCchtoCZFA1r_nRSBgDJmryP3dpn6wUYSbFfiHnmtrSzRX60m
    3I3V_yjwQIH9Ikz7HLL8AhcuiE0j5_V3MQWRijuJAYzZ72Tg9VR_BA>
X-ME-Received: <xmr:D0mVaooO3kxS-A5WgxoCcFGzw5Ytw4p2oesT4zh1XlfhJwiuTDjI9Yw8oZpYEGIakln7Cw>
X-ME-Proxy-Cause: dmFkZTGv/EhjgWLAV8uqD73ZuYSgNZiTkhzj2DgZNErAc3+/GcE7MflCDvZjvFAZRLl0Ic
    XcdynaAyhQDv6RiYvIkt68k8roQVA5YPy0ja5oto8iksRli0l0wrKQHoKZLMxzujfZOuzA
    7q+On8nOiD37voNrqZtoD+3uf5XhVl25e9YiBU011aVjRTwEnbesw8bKSCM7Lqcy+kSdhf
    qdVS5OkU5uSoz1S9JajY2ol2oPLzk2C/BjKImnchf/WFlRHTZHhGD5Vop/ho3tf5CgDfOG
    YLhR64cz1Y1A4vr3ibohf/mALbD37/vX3nSFf23T91dMU0LCH2cPgOMJAuCmjwT+aVf6js
    THo0apoVMN6/uiE28Vo1NgFeCjQ6in/huYSbOXuH/K5VGN9AFrr05MalIjoORrzFskWKYO
    8UdjDiqbAqirnSMeYRB1HgzHtt/FCL6KFICiWvsaJKlCQ0NYaxF4/CiKdyXshhc/Murz3T
    ZiehubT0ldR99cOEs7DWW+baIk0+rp0rd8Wbygn51pTqPCJK44Joltv9zju3Om2ox1KI7f
    9tGXh0pbzA4Yt16896rGHerI2GOxnHikegTZIlwJ4YBg0gH9SJsDXJAevhLwqyn2p4o9h/
    ritcl3UXUpyfhPPHy2v9U0mZoSx1gXF0Xu0APro+GO7WjS19HhkdhP/mfO7g
X-ME-Proxy: <xmx:D0mVan-cwTKESs-Rg_3tjrMd1DvPReca1JEqQWa9DM26QjlYUNFi0Q>
    <xmx:D0mVakeLk1xFzzxQT6bKiufhNnXTXS8R1QO40hazX5W5cSK7bhKhLw>
    <xmx:D0mVahI2mIBlok7zRZWZWhfTDMwI2QqRsJ-cDe33xmwnreKSUaEbOA>
    <xmx:D0mVakioAwRr8XEpdiYoGNymMYrAb46B90aH9b2EQ3iqqZvBlsRxew>
    <xmx:D0mVaocYSKUbAQ3zEj0WASXcmvdFE3toXVAUULVC2NgxUzoCgB___x7y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 05:27:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 53afed22 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 09:27:49 +0000 (UTC)
Date: Mon, 31 Aug 2026 11:27:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Olamide Caleb Bello <belkid98@gmail.com>,
	Todd Zullinger <tmz@pobox.com>, Tian Yuchen <cat@malon.dev>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
Message-ID: <apVJCt4prIi2GgXp@pks.im>
References: <cover.1787231825.git.ben.knoble@gmail.com>
 <cover.1788010335.git.ben.knoble@gmail.com>
 <01cd487cd23f23b1d18359b86fbcf18e25039e6d.1788010335.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01cd487cd23f23b1d18359b86fbcf18e25039e6d.1788010335.git.ben.knoble@gmail.com>

On Sat, Aug 29, 2026 at 09:38:20AM -0400, D. Ben Knoble wrote:
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 241abd4332..8e0c25655f 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -130,7 +130,7 @@ static void xrmdir(const char *path)
>  static void avoid_racy(void)
>  {
>  	/*
> -	 * not use if we could usleep(10) if USE_NSEC is defined. The
> +	 * not use if we could usleep(10) if core.useNanosec is defined. The

Micronit: s/defined/enabled/

Otherwise I'm happy with this patch. It looks a lot better now that we
use less preprocessor directives. Thanks!

Patrick
