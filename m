Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EE8221FB8
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 07:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042589; cv=none; b=mmZVHiBPXRNl8aXrH+kyGbHw8Ksmpd15k1upx3Y2J0CkHBEK+aa0N/GnMZlE57eORMAhIS1F8ZU4zyJ5zfmYeRBR4P91gDs6ZE/5fbEaEuSPzcoHbvZCSNAJ32qvedS3BiA3hnS3zqv19BDS1yQufjejBtmsLBoBboBj9TADyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042589; c=relaxed/simple;
	bh=6uxlxrIji3zZHPZc34Q8w9u8KRPQdDAb09YVpZb7zf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ITTZZ5X7KEJQ1B7J2JHx/4Zakw1p6D+laiqs/d6A4u0VMK8zgPp+KEhVbBtBy4ooHkYnaLekfIlx8/G4f3gbFoRuwid4LQk6znsNjcC3NSrf55hUD99ykkWHPcA/7bB/Wzo0JfMjaIRSuzCVstSK4Gr0qy5vR7cSLjDVyiEwDx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fDBp7hpJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZIOEbzkP; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fDBp7hpJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZIOEbzkP"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 497FCEC0099;
	Thu, 18 Dec 2025 02:23:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 18 Dec 2025 02:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766042585; x=1766128985; bh=dErzqYu3qv
	ATG4YlTLzyOZkC9C70k7QJEkk2OdN9NzE=; b=fDBp7hpJ7ICayYktCCc4h7MOr/
	7PPzwq2A23kFeRxroX4DVQyFtPQWeXHeBNcwo503xGnDDAQhdqH6/6Bb8S2YI7KK
	0f4thyvWs3k0fmGjy4j1aH59KBd4x9LQ0wxMgO2fEgaP5dNUDM0KfmLDiSip4aZt
	GilhHMyaIgBRcNWLVIUFQzNO/0U/dGpKnqrn4uLAWg9Jhls9ThI/RUkuTG9V9GJL
	Um+cAqomNwvPjiQ24Jm4jNK2FQPIklqKzW65ierx/QTxD5kjr+DrTEsn0Z2sM9fB
	rb9odepB7pla7W1sM77+y6EyaCXPfS9HrjDN7fHwvrH4WxLJUvB+EGZlIcDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766042585; x=1766128985; bh=dErzqYu3qvATG4YlTLzyOZkC9C70k7QJEkk
	2OdN9NzE=; b=ZIOEbzkPsPji95pzknlBDFdI47my+FR0FfsOWWRjRvEZKRk3bh4
	5JwKwkG/G/FSXglapVmr903eHJQyC/Vt5kkc92zXswYsnr/Hyp27OyptdhHZY6ky
	6SOzXv4ZIJq44kye9SaNO49rOORQF2REVPdd1xv4h7/mSPXG90RfKheszoZd2cKI
	4uSWnV850HaaY+QLi6knJtZ7ob2Wd+KVvo2i7F6yBVz7Vw3LVvpL7HXdrcUnCe8U
	KVWBhbPs3PQsFTrS7BH+9HI/YO2Gn9ChwiikuGF+7zjKUj48Ihs4P2AjkTpKxDKe
	XWp4Pcm6+rY80IyUVxfkCAQIhwvOJx6sIUQ==
X-ME-Sender: <xms:2atDaT1kg6rkeh_wDkyeRoBLNrbuNyIGuyjoy34OMQukLcazSZNIsw>
    <xme:2atDaZE8a1d5MSwg3iW-YI0-ITauSfX_CHSRBBpDOfLeov0_XbN1s6-bmnS1O9UhE
    loZ5xwvQ2tDi-zbwe_8fZsQH2S_biynVY9e9t0-LtUxLQDeRwyg>
X-ME-Received: <xmr:2atDaY4dqZKxk6v4sxNsUq45hpRIsHjpRjEjvyVWzCKsTP30DoPDyojE6-CJ-SXFIs9T49cDFWuytCDv8VukBbJg4aQiRaQpsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrphhlrghtthhnvghrsehnvhhi
    ughirgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2atDaXs3l54loV762mrRIsEOJZoHKhnOBS_TtArOSQ15y6RNrkmCvQ>
    <xmx:2atDaR5X4N5dUQRcy2zBo0YI4Gns4m7WzDbW9AbvM09hDiRBzSjGVg>
    <xmx:2atDaaVZCBbCrj3iS30SKEtiDHhGWdFISPzco3MS06UTicMdD6f_Dg>
    <xmx:2atDab98HySMltdVaMIeqmNfgW7zPjLg6WmLvNy_F7Io886d2Ulj2w>
    <xmx:2atDaVdRJ6BqZ6Fng8qnj6kvVX5NGEqnIWWdSXYvm7OI13seXQK2ouEa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 02:23:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Aaron Plattner <aplattner@nvidia.com>
Subject: Re: [PATCH 2/8] packfile: always declare object info to be OI_PACKED
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v1-2-81c8368492be@pks.im>
	(Patrick Steinhardt's message of "Thu, 18 Dec 2025 07:28:12 +0100")
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
	<20251218-b4-pks-odb-read-object-info-improvements-v1-2-81c8368492be@pks.im>
Date: Thu, 18 Dec 2025 16:23:03 +0900
Message-ID: <xmqqh5toxnhk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When reading object info via a packfile we yield one of two types:
>
>   - The object can either be OI_PACKED, which is what a caller would
>     typically expect.
>
>   - Or it can be OI_DBCACHED if it is stored in the delta base cache.
>
> The latter really is an implementation detail though, and callers
> typically don't care at all about the difference. Furthermore, the
> information whether or not it is part of the delta base cache can
> already be derived via the `is_delta` field, so the fact that we discern
> between OI_PACKED and OI_DBCACHED only further complicates the
> interface.

If this were "and no existing callers check at all", it would be
trivial to decide for this change.  In fact you do say that but in a
weaker form just below.

> Drop the OI_DBCACHED enum completely. There don't seem to be any callers
> that care about the distinction.

"git grep OI_DBCACHED" shows only a single hit, which is what you
are getting rid of in this patch, but I cannot claim that we did a
sufficient audit, as this change will break code paths that check if
they got OI_PACKED and do something differently (or if what they got
is different from OI_PACKED, for that matter).

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.h      | 1 -
>  packfile.c | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/odb.h b/odb.h
> index 014cd9585a..73b0b87ad5 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -330,7 +330,6 @@ struct object_info {
>  		OI_CACHED,
>  		OI_LOOSE,
>  		OI_PACKED,
> -		OI_DBCACHED
>  	} whence;
>  	union {
>  		/*
> diff --git a/packfile.c b/packfile.c
> index c88bd92619..79ad9d7179 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1656,8 +1656,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
>  			oidclr(oi->delta_base_oid, p->repo->hash_algo);
>  	}
>  
> -	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
> -							  OI_PACKED;
> +	oi->whence = OI_PACKED;
>  
>  out:
>  	unuse_pack(&w_curs);
