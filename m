Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C74E229B1D
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742611; cv=none; b=kiSHFaSN9Ge84BuG2FZrOe5ULntUS7BND4laC/UZow17CTctrYr1CpVzIfu2uptq2sUjAUD0mVkAym8g/7zZ5MUrYFNymAJXXD54vA8cmcVdv0MqkOSss2MQiL/KD7RpxAfZcU/Qls+6p2InyepiISxRcKE4F/qGBZPbeGDI2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742611; c=relaxed/simple;
	bh=6ysG1X4YC0YFczEWf+IdtLq78DMVGSdisxSJpw54U3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiiS6U6I1pRiCnsKJFT+6kGbq0XP/aaB+UXHqYazumSym6QIDgrIbPh0WjrXQY1+Da5pq5glf4fyCW8geMrASip5YOqJ2yraSNik6kEOAAlpGOYJyPIa6gVWDNzUrXItGdO2vQeFjP1/grGuv0arCHSUZ9PjeyBNGD+EpjIBCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jrYspTq9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YxyYNnMr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jrYspTq9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YxyYNnMr"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 729FC1140122;
	Wed,  5 Feb 2025 03:03:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 05 Feb 2025 03:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738742608; x=1738829008; bh=1FYNTNRY6Q
	1wRrO13ZDoEi1lpDduFAGcoiOhpWgZg7A=; b=jrYspTq9cbgS2ILYMsfJohXfKb
	xnsKq6ZOdVaFSdYSDBXu2sMyJrGkudLpe7Kx7EA1mUxmYKrMdKWu0NZO4mBjnoY+
	FYPSu8BxQ7mNF6xrQzftpCKRN5BJ0xJ94Qj8MJ+OUV8EpR7izPCc5CsMvD0UVg0Y
	Gj38PPy/NqoY2UFWW0WPuBmAWg9M/IP2/DWvlgts1J0hhWhUZqVxEfhHqk9e2MOh
	MNngSedcUon5d8gwBFOrpLYF2kl2B0lZq14Lo/9hqYqvXZrbV8QDmqB9b3QS6B3t
	k781ppoHYHfGJXFAKpi/KCVRMJJE1xv4wVblX53seqg3x4qNop22U4ZK5fIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738742608; x=1738829008; bh=1FYNTNRY6Q1wRrO13ZDoEi1lpDduFAGcoiO
	hpWgZg7A=; b=YxyYNnMrwCcAV4Kf8ep63qUZLhrM32cKQ8/FId76oHmX85pTh/g
	mWTB7nX0LdtIQHaDELNfqIkF5F1zGwQURwYV9gNur5Zbf5X+jM3bW99uFgbz5mBk
	+74JuagfX449ptujv6fm1WQ45fZvp1OOqo3/htgJan/vLtBfh/ybn1hj8AFUtmz3
	ACflM5HTe4dXAD6LOa/TR/GFsFErllbYQwgn+X68yMNfDFtJCtIcI7KuAwCyJsEt
	VIca57Hg8uiKT8EGYJqU5TwyQKUIgQG/fGCbJ9MuDA8JwGS5uW5GXb13Q28rnnzN
	FPeeb0nR2AoIvn8rdgp4/EaKS4kCzTrP7ZA==
X-ME-Sender: <xms:UBujZzFctevvZge-CiYXX63G_l6F0xKyE2jjzAjVOYy346yrrx_36g>
    <xme:UBujZwVjLhDM-72ncRwbDIEscOCZoNq-sHzsp_WaBQ43yIphKNPy7oVq6OyAX5DBM
    oGZIQ-VL7GAsq5HSQ>
X-ME-Received: <xmr:UBujZ1L_siY_kJsFZ1UxNqO6X9Okl8qljTIKfWL8XCXUWP_VmAin2QOjdYKsWDMXFQDLMnZKSV6xg4o-foWZn0vaRx97IXHkz91S485Zl1QviA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtg
    hpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhhsuhgthhgrnhgvkhesshhushgvrdguvg
X-ME-Proxy: <xmx:UBujZxHOFQzDZ_s1DvPmXuLnhmCUBrBM54m50vAZ8sX5gHKr1m5ZBg>
    <xmx:UBujZ5XHW67n-x4dmbY8prYR2dNNaEOZkf4bJRY7DVTOJ84JUCbCqw>
    <xmx:UBujZ8N0pmaO9Hb8-HD9KYFJmeYdgOJ1RkWLVVN5caNkAtsSipTTZg>
    <xmx:UBujZ416KHIoB-rOOuCfiBeEPy2vuG-Lqqkx-9jo7HTQER86HrSLNA>
    <xmx:UBujZ7IvZhVBbCnR3YzkjLU7TbecajTrH0ISF0bWqGVJg9llNhD7OW45>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 03:03:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 09c742b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Feb 2025 08:03:26 +0000 (UTC)
Date: Wed, 5 Feb 2025 09:03:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/7] clone: add tags refspec earlier to fetch refspec
Message-ID: <Z6MbTVopPjqVi5Al@pks.im>
References: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
 <20250204-toon-clone-refs-v5-4-37e34af283c8@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-toon-clone-refs-v5-4-37e34af283c8@iotcl.com>

On Tue, Feb 04, 2025 at 10:34:03PM +0100, Toon Claes wrote:
> +	if (option_tags || option_branch)
> +		/*
> +		 * Add tags refspec when user asked for tags (implicitly) or
> +		 * specified --branch, which argument might be a tag.

s/which/whose/

Patrick
