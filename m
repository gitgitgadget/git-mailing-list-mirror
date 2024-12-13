Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBDA1DF759
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092686; cv=none; b=rvkIKNRfg2gIiQYCrltGQu/D9LNe5Eib2864QTpnqXh0vIahys3qI/7zKRBv3BMkHBiVJUCctK4E+3eBtravnCKmbKDeFnvAEtF2Tqa1e0kRXch0t3j6vuJdHd6Jjnu0fz3+VyfRPpB2MReuHH6W+IUidLWsa+QgEmmKXsYnw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092686; c=relaxed/simple;
	bh=hRTBcI3BW93HSYsVNoG9niBUwbdlTZzoCPN3s5Nqdww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LX+qkDhh9xlrufpNOqJXN3zLan8aHMj7RKgfjM2TqxQesXz9VWIFNLUkZQ2ooc47ol0bslOSJyzHGik9gzMH4K6TdiJy5ymLlfk8oeHGM0/Sla4zmYpHPBGr7yXvrLxwy25X2btey1oDA3H0LZfMOhaB7F4WTNtUDu/Nw6Djya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y/pEDpYD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B6LhUWUz; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y/pEDpYD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B6LhUWUz"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 91EC01384060;
	Fri, 13 Dec 2024 07:24:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 13 Dec 2024 07:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734092683; x=1734179083; bh=08nOdo6Quv
	Q/1NtKGjTsvXv2bb1E0wjrPQ6eS+rI7iI=; b=Y/pEDpYD1GoFIGk6jppM/3z7Yu
	Djl+l6tq58tsX1bbqLxEv3s27MtfUgyqXn9SKUbTqLbLLDtAxm9VXvhX9u7Kovnd
	aug0fay9yNAgzPSrfc2KK3xPx7Y/XoeQNjLxNc8ZRoZjdnx9RX1AJktorz1zDRdg
	NnWD9QBNLSX0ervcRykXQdapXEiJBG/RJtp/QdDeG2JRDxaG3r4hxR7ycIzB3Xa6
	5DBr7NNF0OsEn2/dKrY3MyDW/+ndZYsQZwCBXGt5StUaQnZnAmcxWhMPtQTSFOvS
	hXWKNuRc+ko+LKX0tVFb6fK2M6mvcAdpwUJJM82cZ5EgsW1V2/poNMc8yJZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734092683; x=1734179083; bh=08nOdo6QuvQ/1NtKGjTsvXv2bb1E0wjrPQ6
	eS+rI7iI=; b=B6LhUWUzae3Bvne+rnXVuj500BKpOH/dSDgNzhkiXWDSmIW2Epg
	9i+dsY05qdpaw6OLsKYAF3u8W5Lziu2LKnr0oRYOf9yynHhlSkwo6m2xlSXG0xfx
	Jq/j/lejHhK+DOY3TJS9vwKztZ/KBDWdw+lML5rxO05NF92Mdjy0CJTuKRerOArd
	QLI23B16hivsREYYlr7fMmykxK1iNuoAbi5LOCd6rDEJ27dfB6Z8AwJoF1wD1COL
	YpXeuIUmkYw8VfyXY8aHkvXiOHs+Bh3C6/GMpFt37I1Qzncj0x6fGEaQ3F6bjtS+
	qmgC3i1HJz+KuKxQXUdCOwKlS80v9zEwf+Q==
X-ME-Sender: <xms:iydcZ1K4pwZwBo-IedfdqoGQ0mMxpUv5gy1Az2XaiR-L3ht-Yv2Z5w>
    <xme:iydcZxJDkdS2UXrblDaTSBZsQQosx3mSA1ZCBmCW9IfMpfSGThFyIdGHIJ-AR8Njq
    wDpSg6t7vfQ3LZTEg>
X-ME-Received: <xmr:iydcZ9sSFGykS2dKUQYxM_IoLFBjCI5qtuYGXoD_LU3U1o97btIiiP5hpd53CB1eMWqhGUDrmkzFe5fRABdc3-3NEELosdwa0dKzI5jcJIhSoKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegt
    hhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:iydcZ2Y1RJ7P4FBfyyt3Mrmh03Exvfwjf8hoAwtbq4t2RsHzsKUvVA>
    <xmx:iydcZ8YkUJXkwh310RSb5wcj6xHoALBAm9F5JF7ZF_bqYDncUGqZ-A>
    <xmx:iydcZ6AomK-iIXrhcgnIO7dcUlOnZ1sqtx7L-_yRJmTqH8krVHvOnQ>
    <xmx:iydcZ6adZh6xhiLQnvduYfN22JsIUyBJGNZefHvs_LSt0hSJjlc1kA>
    <xmx:iydcZ0ECoUiTFhl_tW8X6kWKpFSrxSBOelmfebIGlKcjncI_tHZkG6qh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 07:24:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 922a196a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 12:23:03 +0000 (UTC)
Date: Fri, 13 Dec 2024 13:24:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 6/8] refs: introduce the
 `ref_transaction_update_reflog` function
Message-ID: <Z1wne2iJAQGk-sG4@pks.im>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
 <20241213-320-git-refs-migrate-reflogs-v2-6-f28312cdb6c0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-320-git-refs-migrate-reflogs-v2-6-f28312cdb6c0@gmail.com>

On Fri, Dec 13, 2024 at 11:36:51AM +0100, Karthik Nayak wrote:
> diff --git a/refs.h b/refs.h
> index a5bedf48cf6de91005a7e8d0bf58ca98350397a6..67f8b3eef3f2101409e5cc6eb2241d99e9f7d95c 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -727,6 +727,18 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  			   unsigned int flags, const char *msg,
>  			   struct strbuf *err);
>  
> +/*
> + * Similar to`ref_transaction_update`, but this function is only for adding
> + * a reflog update. Supports providing custom committer information.
> + */
> +int ref_transaction_update_reflog(struct ref_transaction *transaction,
> +				  const char *refname,
> +				  const struct object_id *new_oid,
> +				  const struct object_id *old_oid,
> +				  const char *committer_info, unsigned int flags,
> +				  const char *msg, unsigned int index,
> +				  struct strbuf *err);
> +

Nit: it would be great to explain what the index does in the doc, as it
is completely non-obvious.

Patrick
