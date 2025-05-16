Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655B2451F0
	for <git@vger.kernel.org>; Fri, 16 May 2025 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414598; cv=none; b=JAltNFz64VpScR5NGUcW+NSn9CtscKWapf0tzlrnwoFxekLHsZABkB0fXNmeid808Z8jUmjq1qEg2LN/Ii2atyIgCfvKOlHig9+fTeQo/V+VkE5qJtLrj24E3dXQeGgF3RWyut9EJGSmw3kt/NCT2eew3e0j7C0u+ie1UZ9h380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414598; c=relaxed/simple;
	bh=gryD+bV6jHSt9ZULAk5szuA26q4yojJPKdtSyc/hwF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S57h60y7vnkAqL1vVd/AgroBN04KSh7Z508WLJkc0VDI4dnceez4tY27ojYY9rB0L8y3pOHN7jYkADTHG8G7FXtKQLHrb4cm4mwIkNA4owWxsMMf5PjTXPvQ9NDpg9m1TTHf3Ngbd2yPIhUsZSrb7qhRms0pertKTLCO9Harhq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QyFr2GNP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=unP/J40u; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QyFr2GNP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="unP/J40u"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5980413803E8;
	Fri, 16 May 2025 12:56:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 16 May 2025 12:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747414595; x=1747500995; bh=qGlgSXP3fR
	dgWMRv/YKCFXpsqlGPcdzUo/peenJgiyQ=; b=QyFr2GNPcAcaYAUWt+FvoSXNX1
	cbOyZ8WtUmLYWxjV8di6nDrWklk4oBIIBfRaDvPhmS7h7DAb0tN7SQ0yri82il9d
	z/ge7E5RPdbC6JoKIFQWW9DayHBKSq3WjskPQ2ZZwDbL6hNc3TVsNngEHGbchzFn
	rLqAaTWYlVE5md/5+X1k6p6HKVVu0AT3CKvBA0ReyZRAkorZWxa96Kzfc+F8boaS
	o8b37LduFnkfX2F4vmuEA3FPCED4hWqxqUvjOktjgomWMhOwX5RvSYfWpu8XxOv8
	Sdb3HyU4l+B59IETMOw9OQU7C74RFELIhXalo4TfkUSEt24PYzDstCuwllqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747414595; x=1747500995; bh=qGlgSXP3fRdgWMRv/YKCFXpsqlGPcdzUo/p
	eenJgiyQ=; b=unP/J40uyYTsF/Dmn+BnUP0/vCyzJuPyitp3ZxkbWqTX5BgX6Pt
	XBPaDLUp9XvrwJY1KiRp4Y33APRSCVUopHRNOKBIgFQDcjW88xzxDZud97dveuRg
	1Pdt9K0WNHpaADfXk5/rfd6kew5ypXT/zWFUEjDoSYslPIZmLqrf6Qp8ncjb3jTB
	QuvBZrty2V07MR6jbMJ3IPxucbyJssBrQLyTpZDtW4b1SBnjeTdmNEW0GOSTWw3L
	uwkPnEaJi9116Bldk2pWaMpD9Ab27MlUz/plABACWci80/Oq4ni2NdyW6abue1Ut
	dspL2uyEgNorgNITM8Pu8sH4Evf27yEpSBQ==
X-ME-Sender: <xms:Q24naKxdzqHlmvRf-TiG0brOeM2HpdBwognDu3c_G_PVXl_dvWUcKg>
    <xme:Q24naGSGjBcRNvBks-Q54Q6ahTh-TKk4-loUfn9oACWVZqcq0K6IizZJLqDg0Mhq6
    m2AWyj0Oe2wp4iGVw>
X-ME-Received: <xmr:Q24naMVoI9t63Uk399S3qEhbTubjUtmpvjdpzDV8frywnUFNg86kamS1gRRKIdeGrp4WWsTYuV2GfGoEOePyB7g6zEd7ILmboat1MZo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:Q24naAgGtM4BQ2w0E4C9C3shBBsPoGgJzIEk21LLiSZcFH0PHyWflg>
    <xmx:Q24naMCFtXt-COo5jBt1_GHmeH_S40M1C-oj41dzHRLCnMvxqF-4qw>
    <xmx:Q24naBIPWxDxLyYMtfc7N9X2FfHaIqXZNa-f3KUsfG3ISE9clZbCmg>
    <xmx:Q24naDAohbk0UonX6hMyfXErBVxDzOX4PIOUC6WsY9FjOpm0Gory8Q>
    <xmx:Q24naMthfWG4Rryr6ffDDFwBaxxmeoD6jG8fTtq0PsZFQBUO_EznB9XE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 12:56:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/13] cat-file: use type enum instead of buffer for -t
 option
In-Reply-To: <20250516044947.GD22242@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 16 May 2025 00:49:47 -0400")
References: <20250516044916.GA21985@coredump.intra.peff.net>
	<20250516044947.GD22242@coredump.intra.peff.net>
Date: Fri, 16 May 2025 09:56:33 -0700
Message-ID: <xmqqy0uwv6im.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Now that we no longer support OBJECT_INFO_ALLOW_UNKNOWN_TYPE, there is
> no need to pass a strbuf into oid_object_info_extended() to record the
> type. The regular object_type enum is sufficient to capture all of the
> types we will allow.
>
> This simplifies the code a bit, and will eventually let us drop
> object_info's type_name strbuf support.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/cat-file.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Nice.  It is sad that it takes more to lose .type_name but we'll see
that happen in a later step.

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 4adc19aa29..67a5ff2b9e 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -109,7 +109,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  	unsigned long size;
>  	struct object_context obj_context = {0};
>  	struct object_info oi = OBJECT_INFO_INIT;
> -	struct strbuf sb = STRBUF_INIT;
>  	unsigned flags = OBJECT_INFO_LOOKUP_REPLACE;
>  	unsigned get_oid_flags =
>  		GET_OID_RECORD_PATH |
> @@ -132,16 +131,12 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  	buf = NULL;
>  	switch (opt) {
>  	case 't':
> -		oi.type_name = &sb;
> +		oi.typep = &type;
>  		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
>  			die("git cat-file: could not get object info");
> -		if (sb.len) {
> -			printf("%s\n", sb.buf);
> -			strbuf_release(&sb);
> -			ret = 0;
> -			goto cleanup;
> -		}
> -		break;
> +		printf("%s\n", type_name(type));
> +		ret = 0;
> +		goto cleanup;
>  
>  	case 's':
>  		oi.sizep = &size;
