Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829C81DA636
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737705713; cv=none; b=GzHyCLHbDXqntGqGfAaVMwFXGDQo4KRfyMyq8ZLXG0tzuCLXLBOMmwfHpbkwYXYv7OhSgdrPbhAoBdNiSF7ZkXvP3LmL4H7giZ+UujsJ+my232nMDQv1l88HgpQqZv78iELwiliFbzHzAlISOiaoszf3+thV9GltI95Sly+4JNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737705713; c=relaxed/simple;
	bh=5hoS0J+Tf0Xt5A/nTFE3FYHzJ8TpbX2H4DlpA+lLtWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeQY66e1ygsyvRRhqmDFkJl+2inf2SPA9PGOb2b+tnrLLoFVdhuOK1pxEWS5akRZfGONS7WrxBAx4uZTR7F4KnOKxRlvAFwfw4plLDPr02fKtYxcyBcih7hJ6cHjLJX8g8aFhdPRf4ijs6CTJOB3WxKMqdCUEUefHWP5JVVRRUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QdK1ACRK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frShagXY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QdK1ACRK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frShagXY"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F4CE25400A4;
	Fri, 24 Jan 2025 03:01:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 24 Jan 2025 03:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737705710; x=1737792110; bh=5HzKi421Ny
	40PDdXxac6R2/HFtzE06Jl07Th4XTha6k=; b=QdK1ACRKrCnHyUY+amXpCLECqT
	v4GgpeQaGxGqbA8yGUwSHKWOFtcLr7jDhhbV6gNV4105+kdPfRGADxS4aSi3fLob
	ptP7jVxKiIxuiOOewPYenS7FHNnkJvIZ3TdUrPE3WuyynTWgcKuBmsadnJZXDrqC
	J4bzh7mTDr536NUkCtFvDdYxpRa1F3nnXfTYLYh4rg/e684vSKw1U6MiJAxBXHUl
	bec5Km+QXQxZR5RIxMJ/Ju/zVpxKBqhOdjcRjkVdv5CQLUKz2xwR2FdsJ9AT5l6h
	VVsGIobexuEQabtd7DNnufcsT9Fg+yV22M5m7lzsSO/d8j+dWIg8FscFHEvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737705710; x=1737792110; bh=5HzKi421Ny40PDdXxac6R2/HFtzE06Jl07T
	h4XTha6k=; b=frShagXYY7fZE3IW32z/HcFoK/TDLDxJLIX5n+/T/srxqzfvLoN
	8n0YpS5E3Qxpi7hCW2oW0LChhyKogdOqWeodCeB9IPGdscri4HiuzSKeZYqA2YEk
	MRBBRY/m7HqfpDrW10XW+igqNP/tdayH6MndstCDNzIGzSJLkfNn5nhfBVboR6G+
	vamOSbmHsAFzCvNwIxJoRZKDyJQFUkDQJdi9rYZA0nNrhFUzuhpBFcA/6pCeE1wd
	Hc1QcgNj2SRKTNwrv/nXeJvM+YsGOvP6pCQhWaUEoXyYJHADcIJJ5bBKCH/u1DTo
	GH5wDZhiUWcAcrZ/TJhieIX4nxOawOGh/lw==
X-ME-Sender: <xms:7kiTZ38Q1LZuYir4oIdyV1aI8qGWON-drtFmOo5aeA11Fca034OpfQ>
    <xme:7kiTZzs8J_6GVBTrVCStZLs-59xGbDfq6d8V9WmrWSq4F_RvvsScDASsjYdAomRHX
    F5sjfp0Hb2T91fLDw>
X-ME-Received: <xmr:7kiTZ1D_lR6CApU-qcQo2m4vhW9HKIojJv8kj2dOkJ4BMa6BsPzd2eFHHaat0fWFh0c5zSUHXobDW5a7nAbDGduDCquT8FanFUTfVHIO0xD5MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedggedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepnhhiphhunhhnsegurhhophgsohigrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtghomhdprhgtphhtth
    hopehshhhusghhrghmrdhkrghnohguihgruddtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:7kiTZzcB48uXMgHFPNgzOMjeafDEd4ZLLU75HwM_Ah8jqIlDiagebA>
    <xmx:7kiTZ8Oyts8Xigs9Hs-0aXyFsvr1OIw7opyAku912qEXthUdTem8pw>
    <xmx:7kiTZ1nrD_wsn1yMSSc_FRQNjUYfcDC6OcBc66eAqv37DsNBzCQdMw>
    <xmx:7kiTZ2u84jbDUqQfPavpsumT7Q67FNsy0B9b3OVCia5Gv3eM1SuJRQ>
    <xmx:7kiTZzdLlDMFQk6JPW7wJ5OlXxMBNJGyYu85f6k9DynX-PQYx86a0k0E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 03:01:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 29e64359 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Jan 2025 08:01:47 +0000 (UTC)
Date: Fri, 24 Jan 2025 09:01:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shubham.kanodia10@gmail.com,
	Elijah Newren <newren@gmail.com>,
	Nipunn Koorapati <nipunn@dropbox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/3] refspec: relocate query related functions
Message-ID: <Z5NI60sD8QnQ89W3@pks.im>
References: <20250122075154.5697-1-meetsoni3017@gmail.com>
 <20250122075154.5697-3-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122075154.5697-3-meetsoni3017@gmail.com>

On Wed, Jan 22, 2025 at 01:21:53PM +0530, Meet Soni wrote:
> diff --git a/refspec.h b/refspec.h
> index 9556d08bd5..d3c97bfdc5 100644
> --- a/refspec.h
> +++ b/refspec.h
> @@ -1,6 +1,8 @@
>  #ifndef REFSPEC_H
>  #define REFSPEC_H
>  
> +#include "string-list.h"
> +

We can avoid including this header by adding a forward-declaration of
`struct string_list` instead.

> @@ -79,4 +81,9 @@ int omit_name_by_refspec(const char *name, struct refspec *rs);
>  int match_name_with_pattern(const char *key, const char *name,
>  				   const char *value, char **result);
>  
> +int query_refspecs(struct refspec *rs, struct refspec_item *query);
> +void query_refspecs_multiple(struct refspec *rs,
> +				    struct refspec_item *query,
> +				    struct string_list *results);
> +
>  #endif /* REFSPEC_H */

It would be nice to add some docs here, too.

Patrick
