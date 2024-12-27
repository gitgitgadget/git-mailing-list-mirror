Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC1191
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735278416; cv=none; b=GwqghFVsTxrcFgWadoAr8rGn2VOFQb/ucnyyRYxX6v0eecKjJJIRGLsVRMikCPxVg2mWuYxX8wCqbRrM0sSFyWKhzH9O8o3Ib1MXwSF1jBaxBVCm5EJQkiHRF38ANb4QJiuPa7fnrw9Ly+A+xiboeUTRAJBIWvEiALiUzXFw6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735278416; c=relaxed/simple;
	bh=lN78pBIPKfD/lWYWRRKxA/poE6oWqBizbsbKke9TpSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FlDew5c5BvoVg189fsVR1Gnu0zs0Ac3baTFR0e8tqO7r5PfPo1uCO8N0yZhFIs+DZUDe26gNpVkf6wR0usrAUvXZzDb4EZ4Ru7GalBStNoHQ3xC28YXfNqyDCviynmEFPW+HBLrGAD1xvF/Ykce6U5zImRouxQTN+sknES2rC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hbNzeQlL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dap+Z4W3; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hbNzeQlL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dap+Z4W3"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE00B25400E8;
	Fri, 27 Dec 2024 00:46:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 27 Dec 2024 00:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1735278413;
	 x=1735364813; bh=z0ceLg0FnuFyNpeqUeh8znjpZ8nfhKK+ke8eQ0SV7TM=; b=
	hbNzeQlLRlby7Rda9OrJv8zR+mj0JjlzgPSleFGOv7zdgTWSO+7k6v1PS2Cy3ViA
	LFGFjpN/TgF/7aQ+yDJemkzJXxOMchklq0XwVluGSGv9MF0vv5uXrh531qba7HU1
	WGM8drIhSArOeuLbl7GIascuL+m7w8EriZ2Z+0dXiQ3yrv4oaGxg69MIzexZ5qA8
	eVbjdMmzaFj0rNeL/J+ukF+AO5iP45ht35PMn8hh5lQDMs2Mm2OWTCfLzhZxnq+E
	/0hb06Nj3tkJ+ipR4qbgldcEYCftyy/hIu+jBgegCADvpWdumSqgn+4wSRBUHhbF
	fi3P65OZtBBYAKxiNLI7zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735278413; x=
	1735364813; bh=z0ceLg0FnuFyNpeqUeh8znjpZ8nfhKK+ke8eQ0SV7TM=; b=d
	ap+Z4W3qfqI0zas40ZkH6XPiAL5rJNF1KLLccnIcLzg7t0w8mfYcTt1dzFlq9MmW
	agqZ4gghe/aVUVXuejOKBuXW/EJIzdq8/VO+rC9CVAjnUdctgGy1qYPXs5KTX8un
	HgfGkaRBTLfB+CEXruaBJFrO1hE9U82LoRrTi7qm5+VDpLUj/qTH9LWQZif11sFy
	HsD8zvkTTEkDjEQLXdOrs8bOLO1NHYWVTJ2uTFwdEW+gZWmHjmfhgYuMP1ll/kkd
	SnxRmKPufEFFcVVlJUCQrQFxUG3tTW9hoKVkRvPFt4Uahz4vLBEQtdY0jVuAzsdu
	4PRdt603YwDtRimquRq0w==
X-ME-Sender: <xms:TT9uZ6Ka-MXMOtoJtlQJxBgB9A-bT57ofHm62ER8sLI_INF19HqHqw>
    <xme:TT9uZyJ_Fffa8AtdquxeEW1v0ot-pgg4TOk9GtI0nELSCGmfGmgtyStcUDoUhBJum
    l9oDPpVRm9kStRceA>
X-ME-Received: <xmr:TT9uZ6sFGCt9btOvK98ZEXIc9b243BI67kTu8svs8fZryXWoGa73Ao80iYCjKutLP_E9Zfa6rrnR0v1SufJtYGASFq_970x3WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudduledgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkefotddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefh
    gfekhffhteeiffetheelhedtgfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvg
    gsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:TT9uZ_Z32bZp0XLAYX_2NHNkbIILwgzgRsia8Otu7Ox8SgXGsAQpfw>
    <xmx:TT9uZxbcamMqi77vtXRhTl5j6HgL3sNYlVRO_rB57ZXLr1f1IjHkaA>
    <xmx:TT9uZ7AVas-9yRx7jYxrLUILm6gaRpWe2tl2FT70zpgx8-yMV_A5Kw>
    <xmx:TT9uZ3bthLAm-G44hbiP5SVFXtoC_4bKTnHeslHyPRoEqTVUo4fOPw>
    <xmx:TT9uZwV1nkEU__MBhmx-wUVKsreA4C5pZZwIEgcn79yxjUTOdNYUsaZu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 00:46:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/4] t-reftable-merged: check realloc errors
In-Reply-To: <6084c017-9557-478b-b485-a1c1a21842e7@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 25 Dec 2024 19:38:49 +0100")
References: <2b9fba8d-be63-4145-9d25-a2151e422cfa@web.de>
	<6084c017-9557-478b-b485-a1c1a21842e7@web.de>
Date: Thu, 26 Dec 2024 21:46:51 -0800
Message-ID: <xmqqplldvfsk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Report reallocation errors in unit tests, like everywhere else.

OK.  That's good for consistency if anything else.

We have a test framework for doing unit test at such low level, yet
we cannot really write tests that validates that the right thing
happens when a particular realloc() call returns NULL, which feels
somewhat disappointing, but that is not a fault of this series.

Thanks.


>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  t/unit-tests/t-reftable-merged.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
> index a12bd0e1a3..60836f80d6 100644
> --- a/t/unit-tests/t-reftable-merged.c
> +++ b/t/unit-tests/t-reftable-merged.c
> @@ -178,7 +178,7 @@ static void t_merged_refs(void)
>  		if (err > 0)
>  			break;
>
> -		REFTABLE_ALLOC_GROW(out, len + 1, cap);
> +		check(!REFTABLE_ALLOC_GROW(out, len + 1, cap));
>  		out[len++] = ref;
>  	}
>  	reftable_iterator_destroy(&it);
> @@ -459,7 +459,7 @@ static void t_merged_logs(void)
>  		if (err > 0)
>  			break;
>
> -		REFTABLE_ALLOC_GROW(out, len + 1, cap);
> +		check(!REFTABLE_ALLOC_GROW(out, len + 1, cap));
>  		out[len++] = log;
>  	}
>  	reftable_iterator_destroy(&it);
> --
> 2.47.1
