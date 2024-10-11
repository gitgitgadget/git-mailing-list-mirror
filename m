Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043D310A1F
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728681534; cv=none; b=VzlxEmrMGCk/KGUlqf3212xLzns5qXqDUUDP2W2T7+aV7WAYA72NmGHH5CBiR9TyS8eKxhj82qWk4mi8jfP/Db6YCfCMcZz+wJAVLYqYK9PknC6pqOZZWfgvhnJ0D0QC9eGhHFuMqd9zU7X/5ej/6oL5+cBumV1HXjfQKlr1sxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728681534; c=relaxed/simple;
	bh=/DhOdU7zagLZWI0A+WJ5VsqfB21jCdcTmikavrTLVkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=daPp+42Lk51c48oD5OWsAvVehEkYL4Xk475bcx9xU+tQJKuR3NKsLdBaHTE5IppIHS2n206bymG8GYc6GQUe0/ddlIdnvk2PSpd/EK/N3H8v4Ka6kyEPq0oAFGKF8zP/nkM3hexm+kLE0XIPpImKrKP/k3UEtnIkhK6mbYEwv/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i3AlQ3Ce; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rm7NWMax; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i3AlQ3Ce";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rm7NWMax"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04E7611401A2;
	Fri, 11 Oct 2024 17:18:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 11 Oct 2024 17:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728681531; x=1728767931; bh=fteN1no4M0
	6IkCW6CZ0Molixwx07tGU43Ld2Yo33krc=; b=i3AlQ3Cec1fnDhdrj60xL6RJc2
	4A54+U+6f2H6rq8LqsmmA55XaaPj2yNtGn0jXCHPnXK7Ow9dYLFTIAh5Ktf5kFwB
	Ge5H2ks+y5oJvbULoswg82Ch/U83ISJ0Yv+ikEQ1UlCZLKmcBYW84AtMn07Adb21
	N390FV58XbMN4j/idf4NhHkv4zNzkf2BOp8V5JeetqvLvDfnz9su3WpUnX8ZzT5e
	CG6eWG1u51NOQmFLlKyklmwSaWlOYd6nlUsHjBuJLZSgLTjJq/AINzB2euc4qbGO
	Kfqn3KWJNZ5PshvVgyqy61RUgCOoaGNsCdy9rWF/S8aspIM+7DvhQknpPgvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728681531; x=1728767931; bh=fteN1no4M06IkCW6CZ0Molixwx07
	tGU43Ld2Yo33krc=; b=Rm7NWMax0/VS4FtLgT/rQdD8YHvNXRtnGuOXFDuRko+p
	bKfPGpdbOMoelhbGDaygqVoeMSmOnmuasgbaUsuu3WMpRUxUDXn1bT5cqLJsRtRh
	hKnL7ckWMhDz1wQ1wP57cOhTkZ/yspnfs4WIk6grjvrgX2gKDVars0/7gmsd+gC3
	6l1T1Qn2kVGHzNV2X81sP6yKNqvz/rRuVMT/WWqQ3fa5Of/yrOWinSh3F5W/hQRj
	5wCT0LRhlwF59E1XQFZxwMGopoCJE5cUgu4UkfDj3aYIwLTIUoEln2aOL2V1C2q/
	W3WyMScfejCKTkOx/vXZOZ5q32Kz4PXkx0oi27rbhg==
X-ME-Sender: <xms:OpYJZ_p5O_-HPrjHt2UT85EGz1njE7RU43FU8vinSGOe31jhsi_img>
    <xme:OpYJZ5qnV6IpOaw491MIprC9YjxSZ0fijf4hXBZXjnwzjSbwQ9M97v93TxtIVQxOz
    9QjEyoKDsVXHS69yg>
X-ME-Received: <xmr:OpYJZ8MQP-Vn97Byn_wpmd_8cx2cJ7lwmV0MOC-_DAd7Dclr36es3d5zu-W4B2Ikvn74-1UGsQFtijSMUTE1H67UdHGf-j2sKGEITT4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvg
    hrughinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OpYJZy7BkBfJcmmcbyloWGfkNz-8_wMGVAif_Z3VBv5BFP-5AXN3kg>
    <xmx:OpYJZ-5Y3UzgB6OdqVrLxYDCPeSB_Tc1yTMxPV5RpZKOeaOEfjKZWg>
    <xmx:OpYJZ6hNc3g-KtdBRGMmL8HgJ9uqcqEaiE_QCr8J0plT5_IyNevFvg>
    <xmx:OpYJZw6SWpqFWJaNJ9IfQdNT6jgMT74vqGCDZUrYh-i-iINjH1YQ8g>
    <xmx:OpYJZ50UW0m9dKuZi1KhS0Sjhol1cEEhFSlK6qbcNJd4wVwR74N7_ptr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 17:18:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] t/README: add missing value for
 GIT_TEST_DEFAULT_REF_FORMAT
In-Reply-To: <20241011191150.825255-1-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Fri, 11 Oct 2024 21:11:33 +0200")
References: <20241011191150.825255-1-bence@ferdinandy.com>
Date: Fri, 11 Oct 2024 14:18:49 -0700
Message-ID: <xmqqjzeecp8m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> The documentation only lists "files" as a possible value, but
> "reftable" is also valid.

Makes sense.  Will queue.  Thanks.

>
> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
> ---
>  t/README | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/t/README b/t/README
> index 8dcb778e26..8c0319b58e 100644
> --- a/t/README
> +++ b/t/README
> @@ -465,8 +465,9 @@ GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm to
>  use in the test scripts. Recognized values for <hash-algo> are "sha1"
>  and "sha256".
>  
> -GIT_TEST_DEFAULT_REF_FORMAT=<format> specifies which ref storage format
> -to use in the test scripts. Recognized values for <format> are "files".
> +GIT_TEST_DEFAULT_REF_FORMAT=<format> specifies which ref storage format to use
> +in the test scripts. Recognized values for <format> are "files" and
> +"reftable".
>  
>  GIT_TEST_NO_WRITE_REV_INDEX=<boolean>, when true disables the
>  'pack.writeReverseIndex' setting.
