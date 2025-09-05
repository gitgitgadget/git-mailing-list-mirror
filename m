Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD242FF66E
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108404; cv=none; b=vF7NFfmgrrYqhdjHR17lw4kU/XtyIVsAoxZKODQMrVAaHI4xIM0BaYOibJwpksBYDm0Q3sOxg4OD8Pl+u2oTOfMTzOW67iDN3XEW9GeR1VV2ok6Ede2uXhBqr0vKKJS8Cg1e0G8omhXoaa2tWE16kT5MzZAJUla2+zqZsqX7iJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108404; c=relaxed/simple;
	bh=PgyA3msPM0w8Em2PWRBfvxmNDBsCdZQukvChCDvvbDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BiFZsBPCiEub6nqxYscXxaYcMCibyYJ1j7DYw4peWMmkTnaY1S1P2oLMLfHPxcnRncJ+XwivjWLMcg4YTJjBq0H0aAWUYNbsKaJU5JylIExmdx3I89VuuTSFbRZ7GFqrM7qCle+QqmU+/we2Vjz/0SZ9K15dEhFdyT/k0i4kNFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VwA5uOV6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SNPKOIjP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VwA5uOV6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SNPKOIjP"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A6211400310;
	Fri,  5 Sep 2025 17:40:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 05 Sep 2025 17:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757108400; x=1757194800; bh=8KtO+fURFG
	dvzKI7N7q4pGLs12KaCBMd4NT5YqdsS6U=; b=VwA5uOV68K7wd/YRi05oJfMVKa
	b76Mak1d6J2xYISR3n3DB+gLc4a5UqmoAZRvSP7iSMFB6fY8YCOoKrkQbWOmubLa
	YbwjJT2vH2nZQHqHm9FxKuVAzl8ZQr+GEWTwnDs5sEFuMd+xfwTBB7GAwbBMIPQI
	+afP+iZPgS7uEwkKCDKI8d+fgp5l6iMlmB3dBOadmG0e7V/l58CQLrcQ/YtsK5cp
	osAnlXizQh3zsuo9pD6JomMC513du4abtrkR26u/39hqwJskD62IMjoZIyvHoQHl
	UrxweeqV/GFthVyl9vp8RMLf//EHfDCnKh4Nz4lPjxZ78R90XBD3z7Ux6J2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757108400; x=1757194800; bh=8KtO+fURFGdvzKI7N7q4pGLs12KaCBMd4NT
	5YqdsS6U=; b=SNPKOIjPCu7KyZ3nWol+w3zLpPKsg6qzvVxoroBzZWx9Cp9YXnZ
	/dzjN5oMI9fZVNYdCP8ZZvf45Fs4kEJmW9icJ3zDshEE5XY0P7i0gXtTiElifn/5
	paHrEL6aY7F+zccPpFJBYyG7VWvwf2duHEsAFDTEEpgmAeFTYzLpiKhU26zvhG/d
	FlKSJhMm+52XLPOy5cRfpqVCXdkfOpaofpd1TQ4ic4+1XAGaEguCq0/YL+68E8Ex
	4ffVRuec+H9hQAfQ3ZBFCf0Jz2c3iD6pBwLjT8GaMocd+2Ful+ZAt0N0E/7Zi+FP
	n7iQUiDEfo5R5qXkjvsMbSrNaoPSVgrkNtQ==
X-ME-Sender: <xms:r1i7aCSQHxsxPe9YMRJI8B0zn1oHgZSHCGspIF72Xi0brbLr-4Dt1g>
    <xme:r1i7aDRKM6TjFFvtHiPUOjxupiTpG6ERNjEzJxWZZb40nv83Kw3ZGvBijy7LbM2e9
    jJMb89H0XXgWoSeTw>
X-ME-Received: <xmr:r1i7aGR6EgT3lWhKUV6OyyWdV4IIn_7B_HasvIa0VT9Can0j6jsqmnx7HjHyYd9ySnOT0DF3lnGB7dlUotWM7XmNfDA1DYWFd-HPDZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:r1i7aI6xGReDdGmgWxbFH4bBDwqNNPrnT90NTFEDZap4ptMj_UZOEQ>
    <xmx:r1i7aC2HWsKM1BxreYxOFGXGSmU8oiDOkoIv0VSz6l8aOO8pPe4dsw>
    <xmx:r1i7aDBEsw-hXJmYv2NRJPbvx-9KSGf9LknY5BemW2BjeKll8PvNow>
    <xmx:r1i7aNNpSDJBAiDewOnyD4LYcA6cluy4RzoPLbMCb1nWpi84LOxUwg>
    <xmx:sFi7aIQwkj7uWsx6hHQ-kLmdZngKkuxhWe3Uq3tw--N5TOB8RH_tTGNf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 17:39:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/2] upload-pack: don't ACK non-commits repeatedly
In-Reply-To: <20250905-b4-pks-upload-pack-repeated-non-commit-acks-v2-0-d2e67f3cb94c@pks.im>
	(Patrick Steinhardt's message of "Fri, 05 Sep 2025 08:18:00 +0200")
References: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-0-4e019af4dddc@pks.im>
	<20250905-b4-pks-upload-pack-repeated-non-commit-acks-v2-0-d2e67f3cb94c@pks.im>
Date: Fri, 05 Sep 2025 14:39:57 -0700
Message-ID: <xmqq4itg37f6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series addresses an issue with storing duplicate object IDs
> sent by the client in git-upload-pack(1). If the client sends repeated
> "have" lines for an object ID that doesn't refer to a commit, then we
> end up storing that object ID repeatedly in the `have_obj` array. This
> leads to sending out repeated "ACK"s for the same object.
>
> The series applies on top of "maint" at c44beea485 (Git 2.51,
> 2025-08-17).
>
> Changes in v2:
>   - Change ordering so that we always mark parents of already-seen
>     commits as `THEY_HAVE`. The first version was _probably_ fine, but
>     I don't feel too comfortable with a "probably".
> ...
> 2:  1544160961 ! 2:  11e32bf5e6 upload-pack: don't ACK non-commits repeatedly in protocol v2
>     @@ upload-pack.c: static void create_pack_file(struct upload_pack_data *pack_data,
>       
>       	if (!o)
>       		die("oops (%s)", oid_to_hex(oid));
>     -+
>     -+	if (o->flags & THEY_HAVE)
>     -+		return 0;
>     -+	o->flags |= THEY_HAVE;
>      +
>       	if (o->type == OBJ_COMMIT) {
>       		struct commit_list *parents;
>     @@ upload-pack.c: static int do_got_oid(struct upload_pack_data *data, const struct
>      -	}
>      -	return 0;
>      +
>     ++	if (o->flags & THEY_HAVE)
>     ++		return 0;
>     ++	o->flags |= THEY_HAVE;
>     ++
>      +	add_object_array(o, NULL, &data->have_obj);
>      +	return 1;
>       }

OK.  So we used to do the "if the object were marked already, do not
bother adding it to the have_obj array again" only for commits, but
now we do not special case commits for that part of the logic.
Everybody is protected against getting added twice.

We still do special case commits by marking their direct parents
(but we do not add them to the have_obj array) as before, because we
want to play conservatively.

Which makes sense.

Thanks, will queue.
