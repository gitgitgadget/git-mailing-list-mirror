Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6622E7BD2
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043131; cv=none; b=PXg6Y9GQzQReN1PIKCRYtH/149Q8UQ/T7vLhJI7+ZeRbPjEMU428hsuvyrVVbcxGQEsbmExn3NYOL6liTb+MkThENpX8eIoJNW85bzvO6LodSPKvYfYa3ZH5lU5VaRoqhe3uec4Khwvq0W+irFMkY+CcHb7M1n4v2ycXYHPPYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043131; c=relaxed/simple;
	bh=wepG5riJVif5Df8+XEC82aBjuoMAPXK+Vcic6WpdMFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IAr3FwVdnMURiqP3raU1ZR8/BiB4zZgZY1EEd2q93BQvBcnKd0m2VJzjaFUC4JGd5s3ZGO6eEISdAgIpmAlVYrq82maQcx5TChNrET+fo9kzhViSvbttcOoadMP8FaLYQlD149jjWHKXvcCuumJ5mJBtxCU8RgIZnME7U+shb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JhGGgBb9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IlXEl6T7; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JhGGgBb9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IlXEl6T7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F557EC0032;
	Thu, 18 Dec 2025 02:32:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 18 Dec 2025 02:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766043124; x=1766129524; bh=Zmu6OMC3kS
	5prYFotUhSHvVj53ipmfwRJcsUDGccMTA=; b=JhGGgBb9JcbLyXTxs6+vx1ENJV
	eEZFJqlzYlNJTtIosNiMxPQWbIJNLHQgYxdNB0kTJbGYGTBbJP7meyt2lYW438xm
	ukOBdCafCCqTqrtvUS7RfJNZyvVIFryg0PMpy3YCqj6p5vMo1uDJv/PaKvbCvhvd
	SnOdUppNEeZLZpT09UJ8P6cClz8B4o+7XMdGXSp7rguI571ywXHghbGr33LTtJp8
	IMgUBQ/WAR+iGTRF+vs3tnt9rLfNCHKHnZGHmYS+S8KJxne8M4bzniCyzeyGLRUj
	+lV+9jTK858TjnLtNzKsyX0BuNjm5rTQ+gGrps9raHFvLXMvHMu5doAZMjQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766043124; x=1766129524; bh=Zmu6OMC3kS5prYFotUhSHvVj53ipmfwRJcs
	UDGccMTA=; b=IlXEl6T7TIjXzDM+EkwcvG4vux7t/VehqdWH9uPhW1Nid7YvzSJ
	P2+a2fK9ESUfFaf2eixvpQ76/RRMnCLsyH/xpxL/tT03lV5QpNqN6wwcT1k0pI72
	SjemuTlGMG2UKuh6Vs9OY87FKJxITLt8wS5jWYseEvQSdaAia1RmMTTTXG/N7roT
	FGyjs3Sbi5V9Ft0obROIQOe4XxX8BsUpWlVLIJn7zlHeug2wCGsDUP2NSH/6abD6
	GiESAEk/1yVmSmGHpIO+ypSABTd3gpf02bYzilJsSTqw4ZwuGmBAFVa/qNbMu94V
	WSnRIAIrFih/t7TOymX8XMl3MD26mBsosKQ==
X-ME-Sender: <xms:9K1DaR7x2R9LOGg70pv8dHdy6XqEDapmpb3lBo1zcHD0Y3vcNOL6oA>
    <xme:9K1DaV5eQw33-s8z-uW1eXijinUyp4fdmwxCAIXZU-KmhaZgQftNWpy9NVE1obU4p
    IiSUVxxZzUB0Lp3pyBH3P2x-CHYwVANnlj93UqLqvK9qWjO1AniXA>
X-ME-Received: <xmr:9K1DadevCR0p8yjevQAF_Poc0VzeRrEjih_cxNyHUvBSe0zaOvXtOEt4AOWXJ7l1J60pHcNML2qGPu5ngsP2d8P95piuREmiOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeekvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:9K1DaZAWb3Z-I1WNcshItWhfOmuU37SQmiIOSVtOc6YCXFkTeMET4A>
    <xmx:9K1DaQ8xk5UiyAyFdKzSLnEroIlWsNcc1kmc2eO5Aw85zmjpACHY1A>
    <xmx:9K1DaUKrKXg2hDXak5Jt9aTnvbS9vyCE-lqO1PeIrmP8ChgDu4iwTQ>
    <xmx:9K1DaZhKXj6xWpayOmYP6fdmCQ8q-jwHWv4Xly6HCYhIqs583E7yMg>
    <xmx:9K1Daej0lMHYLR8HuxJB0f9_CZIgiGmOwJoIazWj4LJmQSN2RTHh5oZc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 02:32:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Aaron Plattner <aplattner@nvidia.com>
Subject: Re: [PATCH 4/8] packfile: always populate pack-specific info when
 reading object info
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v1-4-81c8368492be@pks.im>
	(Patrick Steinhardt's message of "Thu, 18 Dec 2025 07:28:14 +0100")
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
	<20251218-b4-pks-odb-read-object-info-improvements-v1-4-81c8368492be@pks.im>
Date: Thu, 18 Dec 2025 16:32:02 +0900
Message-ID: <xmqqcy4cxn2l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> @@ -2148,8 +2162,13 @@ int packfile_store_read_object_info(struct packfile_store *store,
>  	 * We know that the caller doesn't actually need the
>  	 * information below, so return early.
>  	 */
> -	if (oi == &blank_oi)
> +	if (oi == &blank_oi) {
> +		oi->whence = OI_PACKED;
> +		oi->u.packed.offset = e.offset;
> +		oi->u.packed.pack = e.p;
> +		oi->u.packed.type = PACKED_OBJECT_TYPE_UNKNOWN;

It cannot be seen as it is before the precontext, but if blank_oi is
still a function scope static that is initialized only once by
assigning OBJECT_INFO_INIT, this will leave a timg bomb waiting to
go off, as it violates the "blank"-ness promise for the next caller
of this function who calls NULL in oi.

I'd prefer we fix this nonsense "we only declared a function scope
static, but without actually using it for anything, other than to
compare its address with the caller supplied parameter" well before
this step.
