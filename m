Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333623DCD8B
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843981; cv=none; b=Jq4KNPHi3HKFc7lSMj0pjBXvHwlZnO4AzDbX/U8X7xCSyPDEYEK/PE3RTT8WHKQRpej+kz5sIJYXE1LAIq26kyI1aiOfsaEdm1witb/rkx8NEPZuTq7sqMEVJurWrO9MQ45ymYr6f2TqxVLcOpwd4Bf4BRXEDyStYOmbIqv4kDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843981; c=relaxed/simple;
	bh=JR6JVNXjiEx+CK3tkEXmZ/vyrdcqvMxxAzlMpC9X308=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YWBhE/rf5fVGytgdr9prueZIS4zV5pyV9LodV7ZU5xYG5dXFTh/HGWOo6d5sDqeCsCag3AtATM0wfwoF2GZ/ZkVeEaZ3rzuMwTEqPm0XvswKptdG5zwHZ2mwYx1si8h8BdbOa9LTC18P5K2uiVr4LtCyAtHgiOMMhRrUf9aH6/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AerEXy4+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PLgB5Z0Y; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AerEXy4+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PLgB5Z0Y"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A0AACEC0123;
	Tue, 30 Jun 2026 14:26:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 14:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782843978; x=1782930378; bh=uQwHb4XwIa
	HMHaZxEDfszzxRBdnRwSTDaBRJ/DmAXRM=; b=AerEXy4+/oPHMiIAGcfq8VLtSD
	k6QCSzSuRJf0B1osvJ0AxfNXHfvMvkGEjpQF26TIxfVz+l0SNXz5RN6UZ1R66Jb4
	vRB9J+5WxZODfOUw0ynl0uL9Z8QSExOcd1zmnQplF1oBj9tXgXXs+0+7F2vo5jwF
	JnzSe4+JACm+mYCmA9pcvcyRhv3jy5npv2R11RXVXbIheK5eqmErbuIqgPuz1xPT
	qF+MLjiR5/S343+zZ51+6OJKKbTV9fYVW0Z/sKPNpJ+RXOPG/NGbn7R0/TfpSwgB
	aRrMzmLNzbVxccN0FTzMHoRMqdMFs2NWPQmIvahTp2JT5k0f3AydQ2VRQ8Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782843978; x=1782930378; bh=uQwHb4XwIaHMHaZxEDfszzxRBdnRwSTDaBR
	J/DmAXRM=; b=PLgB5Z0YPfYyWXzYcOyYrjo8/SlpdtYn9esC66SwmeAXE/jB/2M
	47JoOKJRPhr+flgx96bv1qWWXgio0sNm2E/xf7aSauvc9nMW/kgsoot/PzF24dxv
	OlnZ9bAmJIitwBAKox2+2OnLKiqT+JSgEKg3bSMnKLGH+j/iLkaLOXgmlCFXw+1N
	zwh41S7GlzlUaOsrUxQ3VpZ9sxkNdkRKvG5iChRx1NhrnfP1l+SyiMmx4t0AdlBv
	KN1uKa5dyH9zQGahjhG0O6OrNhFoNNR/LhQ6TFfqcXko8GFUWI6+6HyrFI3NXe92
	wo4Zx6YTrqIfdvUsb8xuE4rgGsocF04xxng==
X-ME-Sender: <xms:SgpEahFd1JkppnAc5T2NF_5RPeiVj156pAXI_hqjo_SjBJGaN2L4ww>
    <xme:SgpEatzdhoZNvSKvwpal-tcZv32vSn35J9NXq_n-cS3Ibo69eqbFQed56nmfTWb4G
    spfa-7f5pS2nEut1raL2rI0kphfuTbqnXdibXDUIY2pdKgb_Zuf>
X-ME-Received: <xmr:SgpEaggnDvbzhuJigd6rLiOMaMg9jApdJcNTI7pOdgdvOMjrvAVb7U36zTx1FWWff2NU3zKC6Ftn3Pv1s3_-krM5clif4kE7yZKqaQ8>
X-ME-Proxy-Cause: dmFkZTFs6LmZIi6LqIFbgboc2bv8lKlA3AiEzgZ6gzIqbFLgZFSZnceHBZVvsY5DdoAjh1
    Bu8/gvTUj/Rzi/RhZGy72HI/mgVpzfV/IvyzYcm7eoI7iyzFQYQpaiRxVxUN+NrLF/ewhl
    mwCUzhv8sEVtKpIzkFODV8e7plx0DK08X2aJbsjhVjEM5hmMWiYCAp1Od3ongN5mdynfjp
    qZB/XOk089/8YTROGXKujoRphpVLGcqJHM+bYC8xXe2587cjLAqkGBeRzYt78KsC1nWGvw
    /OWuiIuRn2FVE1QsXKnBt38kAh6rHcas1syzUyvdHq5hDifDaOgVHRD9xrZ28kuA/LPrj6
    YrRr6Y41mstzViUiU+RcmGPHpY2DH19nzDTJv5TIPVOi7PywRa0UGdfiCesnOGQHwhZW13
    b2sv0nAkPjXNsLifsgt/WKGG/JY3O+VXz4m8cR3D6OX9yjyGRWSDJaA4MoyKN+5r289+2k
    hWvf6iiT86V2cqV4Y80sEPPlt2h4Ah6epldxJPSpT65HQkn2eb0czeZ9Lnyt/DgzEylEz9
    DuMGUyKnc1UVsR81rJUvMvehUNJ59bO/+f6hNABbDuHNQw6x6JuFF0TGuQmqRp6p4eztmy
    9qCb1aut3JsQ+s9dOwCYedqj01qsTh1kG3EgXRmXENYZ8wj+kJfXFit0NHBA
X-ME-Proxy: <xmx:SgpEagxSQk_m_bxJpjKgVh5hvFayFGzqfVFDV7UmVDQNtkajTO3T0A>
    <xmx:SgpEarIyZcoKj0nCYTgCw5U9OzpBTdZP-MaftjV3SZ2oyXv1PS8yKw>
    <xmx:SgpEavQCTDtyt4ZHeRTatMI3Zbo8j0IW3wn28XODzF5tKGLFtVdMVA>
    <xmx:SgpEarqDx0hWcjJrteUumDqkVwq0FLyTL136FMZasxQGCXljPmcRbg>
    <xmx:SgpEat5pMvRhULSXCtSnkerMANFVJJWsLYsiG6ELVGE-R5rYSshI0bjj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 14:26:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/13] setup: mark bogus worktree in
 `apply_repository_format()`
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-2-13864eb5a032@pks.im>
	(Patrick Steinhardt's message of "Tue, 30 Jun 2026 13:47:41 +0200")
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
	<20260630-pks-setup-split-discovery-and-setup-v1-2-13864eb5a032@pks.im>
Date: Tue, 30 Jun 2026 11:26:15 -0700
Message-ID: <xmqqh5mjsx4o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +		 * we have to exlicitly unset the configuration.

explicitly (will amend while queuing).

> +		 */
