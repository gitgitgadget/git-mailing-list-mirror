Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790F310636
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765955026; cv=none; b=pY8/4TP7OLLdmEML+CBGdp/W6qymA64aZQIIcCHj2PPzr/lyUDite5XOcUzNqLrfiPZazwoINgKkfBloJCBgm2h9XAtnG0Yirqs7pAsWlOjainhcEaU5gZHxQR8L0OzY5G0dESD2LjKDnQ+aWTw8siBRb4RjJst7kv3NVgVFBPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765955026; c=relaxed/simple;
	bh=SM2ap1Pcuslzp4+fvKiywwxzH7NnTktf3P92/B+tBmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFeXDhMfgqOV/Wnv0l6qMk9PfULlEjwWSL68tK0UvQpV0C3EcZZkpyA6wnKI6cAWn8kRJRGxciUiKisowlVcNfbciZDREPXeUVVLRAeu1gblKJvKGQWzo3FJnNHhtGgKQogBKVzl0osNuatV/Kk7PdyPQP39VLIHxrjEghnF77g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=srEB+J9P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w2ggf8fF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="srEB+J9P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w2ggf8fF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B49EEC0068;
	Wed, 17 Dec 2025 02:03:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 17 Dec 2025 02:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765955022; x=1766041422; bh=QpP0Pkj8qh
	ffHI/r0h///JW7S3k0naIdFLiU7lVVubs=; b=srEB+J9PT9EygQ7PMA/YtlDDl+
	0gh78pTGMdLced5Qgk4MaGfDou6/WGFpUGYgbqDpc2Hn/y6QVaEKLYEat61VGgmp
	rPwYCUhlFC6dIpPZ7ETITrFX2+9IMU+LcqohVDJ8Ba9FWpdINVF11Qt2KzDRK4Fe
	ngKGeY16nFPDHxYP/Q8PMtebm+Y7Hyf3SBhpZjjMemooImwsjm88Poa/yc/QB8w7
	fpj28Y67ZoWg1w5MkBb/mDHuD3G/d1LsOjju/GitjkWVg3MQPL25TgGaCqLPFtCF
	5VP/2QJ9qNMXPFB3thY9O2aJCOnlpYmNiCCo6g9x675e8RGR+eyjKLZbkVlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765955022; x=1766041422; bh=QpP0Pkj8qhffHI/r0h///JW7S3k0naIdFLi
	U7lVVubs=; b=w2ggf8fF9CI/vwgEOnm+PX/LH1bCCIxWK6Oy7I3dauuO0wbs2PU
	g387OoUdrqSOWWJMhM844Zy0vrrsz94rkIM3RsWfdnaeCLroijz54vpH6LobxGQA
	0hJ4Xo1QGSIxw2ENLWlijYlDJDOx6U8BA09SdofVm+vQYzhLyoJF9NBweisZ3Y3q
	Vl20FYtHwOAHSsxA5T5EoEQQz1DaaA2fw6T/B9GB9/Cs3SomqjTKQrTHxMc2Ly3v
	RqFmQ8un/am2zmWm9Wl/6R75kUAXdiVwYrQhC1md2lKud6gTZZGB+quL/peGsh+Y
	X89MGrmS1kzMnGjUjOyWeBt+upAbaRr++rg==
X-ME-Sender: <xms:zlVCaT5Qthq6KX4_r_6wAdaQjRSoXf9iu0iElcQdlxrW8Zc0pNBXnw>
    <xme:zlVCaf6eDkyEoYKSJSeuHfJEdPkgFfBAWufoDEg7Rx9ejUWAzk_j5l6OIegeTWrhg
    G1tW7WPqu22ZhGFck6AltTqHlNhP7tv8UE-Aw2xiRTZV6O2qeH-Ew>
X-ME-Received: <xmr:zlVCaffzI8npXGfWReFKW8LDhviFKtA7OCOD6VwWQnP40W7IaOYmd0_87MgTsVHsilRO6Bn6glHK1IUX_9bpluTply9JgKG5ceizO-ZcGAU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegudeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peifohhrlhguhhgvlhhlohdrnhgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zlVCaTDYUuTdPVcYnomjbgH16t8vjrrucv7S6sS-UDI_GEruaIeT1A>
    <xmx:zlVCaS9iAj_twn-TlXMlr3izddKkCLY-hPwxGJJsoEixd6jRTn2rNw>
    <xmx:zlVCaeJVJIyexEOLY4AkzoWaZm14bkinClD840-KNeCKeCH4ZUyAVA>
    <xmx:zlVCabiw5ABxiQxmO_FUdcF4MrUwRdFsa27z0L_vGyWfBaSH8_6kyw>
    <xmx:zlVCafohYJP1hX8p1PibfJWV8__MjZ32JLAQambHFWdFwzuBHgp-uYe6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 02:03:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44ab100d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Dec 2025 07:03:39 +0000 (UTC)
Date: Wed, 17 Dec 2025 08:03:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, worldhello.net@gmail.com
Subject: Re: [PATCH v4 4/7] builtin/repo: add inflated object info to
 keyvalue structure output
Message-ID: <aUJVyHOCsCjjazB-@pks.im>
References: <20251215205639.2700270-1-jltobler@gmail.com>
 <20251216173842.3357832-1-jltobler@gmail.com>
 <20251216173842.3357832-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216173842.3357832-5-jltobler@gmail.com>

On Tue, Dec 16, 2025 at 11:38:39AM -0600, Justin Tobler wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 9c61bc3e17..e207108346 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -495,20 +508,39 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
>  {
>  	struct count_objects_data *data = cb_data;
>  	struct object_stats *stats = data->stats;
> +	size_t inflated_total = 0;
>  	size_t object_count;
>  
> +	for (size_t i = 0; i < oids->nr; i++) {
> +		struct object_info oi = OBJECT_INFO_INIT;
> +		unsigned long inflated;
> +
> +		oi.sizep = &inflated;
> +
> +		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
> +						  OBJECT_INFO_SKIP_FETCH_OBJECT |
> +							  OBJECT_INFO_QUICK) < 0)

Tiny nit: there seems to be an extra tab here. This really is only worth
fixing if you intend to reroll anyway.

Patrick
