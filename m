Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A17C6D4
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723014083; cv=none; b=ZaqomWxnYMAq8sbK3T/l/2N0QntBO6GW5NeKjrfGpOIppJGDAUGbd/9C3ycKYtm0qLtDb6kla1crzgKJNWvhyv1r9qmWZJC0Ip6tHmTKtjxjl6smg1GhqYVdWaV6c+aA+p1dDfi3GZ38aXEnab44XKpIWXqn2dTKozweOGzBS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723014083; c=relaxed/simple;
	bh=zkJ2ObIsWm9TTcVo6Z4xIvxtLFCzrGGnC46IOdV97e4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=E5U/JJnU06lXB2GctFN91EwEoSSJun8lf5LsVIKlCUdjYv4PHUhvkzTyclaE7cX53UOsxHbBTT4W0vM7Vs9DXt2Oj6Sl98c2cEcqsVt1E55s+6F+a5Gso8rE/P/nV0p7Oylae7MtXWEb6VdK6W60b2KGH7dOFUWvcLS73PwjERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=LdcljthC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FVBI8Txj; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="LdcljthC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FVBI8Txj"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 312251151AEF;
	Wed,  7 Aug 2024 03:01:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 07 Aug 2024 03:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723014080;
	 x=1723100480; bh=WewvhbZRiu98mzmbpBvr2/DAaLcPOR3FXNBZUdmuN6s=; b=
	LdcljthC2c5tksJgb+NjmEwunGOO8Cm1ietHL9sCiLR8bSO/X87qOMlxieItrb3h
	SmyP54Vu0nHafXZ9EAbdAeygavArTsNSu3pnN3w1UOIPTwvUD56jHCiMtHB+hgcP
	3kpaDM+qjN3nPWiM/mZj2DT4Bx7ReWy5qBNJz7lECu7VBOZB9DMQ1AQXqpJqcbUL
	3PBWw5pHFBgLBqXKRTaRQs1Ylm9jddVVC0ueVHJD2TivOhnXR75BDYjH/suI8rgz
	MifYw6NJYnUFPHy+i8jZ62iekY11K3qS0FcyIGvahIuxcRx96CeQF+14NGsuf93O
	sTfU3Bo+fZtM0leEukHZAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723014080; x=
	1723100480; bh=WewvhbZRiu98mzmbpBvr2/DAaLcPOR3FXNBZUdmuN6s=; b=F
	VBI8TxjmX3eK/pX3BDfuQIZXvj4HiX2Zxhe6j1efV19936hQNMvhN0N33DaZdds5
	wWkXYphVeq40RVengbHt4Ta3W1Dl4NAA5oZ40HEgOv78VYwD6E+8anEFdujU8ruz
	7C0dKfOMKpFMgy3y1ql78ps01od2UabtjPMpTATK0wSHbPM5YeeO/AMDHeOF0H3S
	ePl1RlRI66pxDXn1Pg33mqzAIj0EwfxF+f1rMDyz8ErFKWai0dWtmf5stuhGWQXH
	rzsfbW1z+BVBOUFe68SQsmcaJ4lBqPMuwaGYlOMjzo4AgoCD+d/fvf3aYKHNxif6
	Zla0Wd3R+HTy77KMQ/U0g==
X-ME-Sender: <xms:wBuzZg2CO0JUuctGXa40wU_5_DRcxcHZPtFhZUXXJ8Y0PlVlSm4iEQ>
    <xme:wBuzZrEpIBzXSSQy17LnPxEmeCYz99nGEQsLsKWN44wJFqZvAW9F9qqv8GSMCZf6K
    hYg3k8QqufJIZ3h4g>
X-ME-Received: <xmr:wBuzZo4es8MhURTXXMMTZ7RnXwRCXjKeNKyTeDPM2jxO52tR9hZ9x71GqpK9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdflrghm
    vghsucfnihhufdcuoehjrghmvghssehjrghmvghslhhiuhdrihhoqeenucggtffrrghtth
    gvrhhnpefhteeuheduleettdejkeduleeuiefhveehuefgheehvdeikeettddvveegieel
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrg
    hmvghssehjrghmvghslhhiuhdrihhopdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:wBuzZp0Cg9SvZuwhBN-07S1jKe4COspx66Ya3exHBUeWU5lf8btXMw>
    <xmx:wBuzZjHvIPthnmqmcko8xDA4nJmuBk9rmexBFemKUZiQCIJUpmK0gQ>
    <xmx:wBuzZi96_gM5VXjGL-P4u8SyRgWxmPFRR5ZZ4QYcNnGbGAv6nf6OVA>
    <xmx:wBuzZonRES0o1s_PssJ9Ds5H2qwId7i8b8XbPwgKbfKnt9o0OTwWyg>
    <xmx:wBuzZoRRrpH1sU0R20mO3BkLsCwzefQlbzbqK2MWozS6oezqPruZG3WM>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 03:01:18 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Aug 2024 17:01:17 +1000
Message-Id: <D39HIJOL7UTK.29BEN5ZXSH4KF@jamesliu.io>
Subject: Re: [PATCH 06/22] read-cache: fix leaking hashfile when writing
 index fails
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <cover.1722933642.git.ps@pks.im>
 <2810cada0af14c3331674a807b20d18e6c9af022.1722933642.git.ps@pks.im>
In-Reply-To: <2810cada0af14c3331674a807b20d18e6c9af022.1722933642.git.ps@pks.im>

On Tue Aug 6, 2024 at 7:00 PM AEST, Patrick Steinhardt wrote:
> Refactor the code to have a common exit path where we can free this and
> other allocated memory. While at it, refactor our use of `strbuf`s such
> that we reuse the same buffer to avoid some unneeded allocations.
>
> @@ -3105,7 +3117,14 @@ static int do_write_index(struct index_state *ista=
te, struct tempfile *tempfile,
>  	trace2_data_intmax("index", the_repository, "write/cache_nr",
>  			   istate->cache_nr);
> =20
> -	return 0;
> +	ret =3D 0;
> +
> +out:
> +	if (f)
> +		free_hashfile(f);
> +	strbuf_release(&sb);
> +	free(ieot);
> +	return ret;
>  }

Is it generally a pattern in Git to use `goto <label>` instead of
returns when there are multiple return points in a function? We're also
performing cleanup duties here and in most of those scenarios but there
are some cases like `reftable_be_pack_refs()` where the goto simply
collapses multiple return points into a single path.

