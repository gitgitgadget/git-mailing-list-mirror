Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53F9364A0
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685927; cv=none; b=T4a4hilGDfkcMrq4dxzGXja8pyrprE7ksIbrWlyrNcAK+7e9HbLB1tr9tVgZmse5ZjUTmZf3tArrJOP0USuNk1IkZ3YFRkVnjlH0lKMVCRCouh9QMNuz+2is2SejO//Nlbr3xDs5KfnvI1MtqRg0wOP7Td5pwQWGMnEoGu86Cx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685927; c=relaxed/simple;
	bh=bYNegHLz2vNYf1vcK4v3u4Eyul2yd+aMR1dTJHjLE8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEuO0sVNfCRyeZ4CgO0kPxyFQI6NlDyGYYau3FaUoqF/Ng5z4RTMsnIF+58J9jL7q/atAn91aUY5eCTI8Dj8FFZi04w8hfznaTzfboPP5pGAiCTQjE/7jvLW7RJKBwTe6o+xR7O6U8r1GF9YH+/ONvIbZ2/KPwE7uJfbB75X1rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RSuucZl0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W0mlH3t5; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RSuucZl0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W0mlH3t5"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id EBBF513805E5;
	Mon, 30 Sep 2024 04:45:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 30 Sep 2024 04:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727685924; x=1727772324; bh=t+pAMGFozi
	jNE94cH3TrsKff3NSGnUIkXm8m1RmM4MU=; b=RSuucZl0fORZ1+WHwzGXWdyiik
	Hh8REGM/EWIZU7LpS+5j+h+6SjJv3hSap05cuoOz2BNI2DUyMk1TWliXYY21RSJ9
	vPbPLNpbVs70Yw5ZekjH/Pf2znJ/CXgh1k2XCVBR9L/95up+UAJIW/sY2inQgz6O
	UWbrh4ZA0VXmtRE+DJsczsMlU2EW6qEeoPYv06GdvY15NOLWgzHY5CZ9QuRfP3hb
	LFErAn33wUjBndT1EFBOema7zsLsfeMEGxHyI95zuiLIaB/iUNCiYuO50oeq4Xaq
	c3V6TvM2tw+qHqBCR8c1Y5rVL7CZxFdn4EvCfF4NR58DSqK24bbvsLejb9Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727685924; x=1727772324; bh=t+pAMGFozijNE94cH3TrsKff3NSG
	nUIkXm8m1RmM4MU=; b=W0mlH3t5zlyp8PzFW9InWUmU6G7CbWdj+QYdKxFeH5WD
	T4/Lstn8uWHD1aBEzxENU5J0kfYDUwUw7UUYKW37trIon8oR3KUQ3DHnhPLY2fSc
	W2rIKDQgQGyYvZJ38bgCjyMEBJFIq/dM+J7vDutsEskMubUEHZ54CRV0pQzC5RIc
	tw2uF+RoGoREb65Zre7Vjf9XbjQ2s9uMbm6adSwZIw3DjlSfFrzPnIk9nL9YsrE/
	cnq5OmR2yFSdH7353y/KexSWCz8rJ7Bm3q9tW/dxM80OmecsmKI9vTU8CBXJjLxE
	V7HRj0MJod0eAzivpPAD03+4D4O4LvdCuMPkrYWs4Q==
X-ME-Sender: <xms:JGX6ZsH_WXkghEeiXCp5t0VsXLGL5DZSvCDKAnMZc5-wwM0i9cS7VA>
    <xme:JGX6ZlVn-_JZRtzhieTcOUdWTqLc4ONW23LDexBgZcsYHFgvTnGeBklwNRnL0gnm2
    _UfY3kP7uz8lq_hgw>
X-ME-Received: <xmr:JGX6ZmK1nUPgZXbFN0rjD5xQLtLez_oHHflVQUBHHKyA76zGkkAL2Hq_k69dLwGx8zhRiTgf2qhInS42_8JPKROzCaILHrq22k9lp3b-Cn77xyY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:JGX6ZuGyV_JQJDQlpDZNLL4MwH5EmieweOg25QTQorlF5wuQGHGLNg>
    <xmx:JGX6ZiUUvTtgcCibwFIsf3t72PNyVKCzw3p8PF3EBsCg57GFJKPnzg>
    <xmx:JGX6ZhNunXjyprH2s4cwwfx9i9BdB-jDZdWOQWzGNuesxO3Yw3oE-Q>
    <xmx:JGX6Zp2BDjLOUKXBDE6COckZJs3INIuCk1OI9RZfGdFBwo3lhV0C9Q>
    <xmx:JGX6ZvigBsTm8FYNaNBB-J5xAc3376LvTNDUjd4_JGRiuwpkYp4BvFU->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:45:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 09474264 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:44:37 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:45:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] refs: deprecate core.preferSymlinkRefs
Message-ID: <ZvplHGpWxwRGWo_4@pks.im>
References: <20240918232825.2627999-1-gitster@pobox.com>
 <20240918232825.2627999-2-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918232825.2627999-2-gitster@pobox.com>

On Wed, Sep 18, 2024 at 04:28:22PM -0700, Junio C Hamano wrote:
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index c7f3f4e591..c40a248b9f 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2025,6 +2025,8 @@ static int create_ref_symlink(struct ref_lock *lock, const char *target)
>  
>  	if (ret)
>  		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
> +	else
> +		warning("core.preferSymlinkRefs will be removed in Git 3.0");
>  	return ret;
>  }
>  #endif

This string should probably be marked for translation, right?

Patrick
