Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB903597E
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 22:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750718996; cv=none; b=TnlHtvL/+eFm3pMu8xcCW1ewI4GEOyYsSSn9M3rMlqu//a0RoV8XIWtMvGi2dJRXmcfVXb8WWQ/tV3jW08aIbqjUOAfVsLzANS08YrP79qcj8cED5vv+Q4e8hR5mDFEZ84NttZhtVRP6J+Pwc2rB2rqGE8v7cs+ctE2Iyx889q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750718996; c=relaxed/simple;
	bh=Ky+np3madkbghcySSa7kzjMmRmdWFDKq87uDUjvd7Ys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EKuK9ENKB7ss4zaVg07mOls7/Uc9PMj23XzoeABFhmJsQhiFcoHmYkq9Zw9D6FKdXs6Sk3hSBtGv3dxt281d80YKFTJm5kKGWynVSXAh4gEl56Ag6Km17fd9wfPzkqbpqtHzzk7Hx8xu+Pn1yPTnnf0i4gGlIEu4OcfLbDdi1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zXzpos1J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U2DqZw1T; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zXzpos1J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U2DqZw1T"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0AC4213809EC;
	Mon, 23 Jun 2025 18:49:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 23 Jun 2025 18:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750718993; x=1750805393; bh=YjVfvO7AqW
	MrMKjW1qvFCz8E8zFtZ+dzFrXBM9u5frQ=; b=zXzpos1JlW9IVO5HC+PrYAZUhb
	VmvOmMiUuBFBkDr0cVbEjMRyZiE2qtsZ/VhkD1hOUv+tdtuiOK//QUkPX2iEWQ1G
	a4rObsIK4Lqn3w4OE2+eBxC8brOvwYBfO0DhDv2/oFWxbmXKsoIf6gtZ+uoAx8Hd
	F3uwacnFXaKP/X8CKBwH9DURPa4vzMiqo7z4Z+g/ao+eQTo1NvydqHjp0dBqZdxc
	v/M4QehfwnvcKkdof/J7TUO+6OZjiCxy7Uf1n7An1ZAQMn7sYK8myLQlmQbojGpy
	LZbxaolTs7C6ZYgz+sWZprfONFBw1RlJR2KJ1136FOF+DbiiyjWIE3s/sVQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750718993; x=1750805393; bh=YjVfvO7AqWMrMKjW1qvFCz8E8zFtZ+dzFrX
	BM9u5frQ=; b=U2DqZw1TRomRu3nZo+njKCrhs9ATkwHTDt0Fe0vny+WVWTScu4D
	Uc5gA0zFhXUNJk3bBDNqKz9qZXjyBrtYW5Hx6XRr+t3NUzZD69ltjqrlezN/UMg8
	g/jaSC2lhxdN6QudQ+uLGbgnrWz4FvQmQyGTWzIAWqPKp458k327UH4QClYY9n/h
	7FKVlidNQSXmkmNj2cDfcZaCJlh5cTQ2gbKVXFItncAY1ztd9jQ5l06wBnN3J96A
	tPZIKcc1dqE6XiqCETuwGPpzSVCNEXY4PNlrDbBbkS1jZfZ1t4GNBA+2EjsnGUqd
	HoEUEEO4kUTyGD2BpONTBCAm1o1F/Jagm7Q==
X-ME-Sender: <xms:ENpZaHiwFhQsbfq0koSu8q2tT1TULmEoiRoz7T4VQQ00ML05uT8khA>
    <xme:ENpZaEAPy_btoYreRjUjNdhsSupobMyfI-S-RyA-Qt8GQ8SydEzz5cSiGYwGUw6XK
    9at7OZPyTkKdyeI8w>
X-ME-Received: <xmr:ENpZaHFWiQoezJP2EOS3DrThcW78_zvjSr8Uo-jl_om6ApxdpvvBm6fAB4W5iqaMpuse15dzbxiTk7ZP6R4zy6qtQT6loDAwdJyTSPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddukedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ENpZaETAMtOcEU2EqcZJ3_glVyYkwdGWQCdvwSCZjtrDovBo_vSKTw>
    <xmx:ENpZaEy5TPhhZ8LkJWVEMLcfTZJrrzTVv9-lT7Fm4tdEF19zHJa9Ww>
    <xmx:ENpZaK7JG-ISQlkpFvt5oYeFfvgROybCJMppnq-sKdc0KYd7ow6tdQ>
    <xmx:ENpZaJzEDIARN11GoCFBohH5_tewpsQrAJjD-nHKcZPlzYPbr6lFmA>
    <xmx:EdpZaKkZRGU2LTzTv7XzpO29BuZVu7MAwKfKjTK6KsgD9ZRowMf4maSa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 18:49:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v6 2/9] pack-objects: limit scope in
 'add_object_entry_from_pack()'
In-Reply-To: <86fb36d3176198fa350dfaed261e8ae64b49b355.1750717921.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 23 Jun 2025 18:32:13 -0400")
References: <cover.1744413969.git.me@ttaylorr.com>
	<cover.1750717921.git.me@ttaylorr.com>
	<86fb36d3176198fa350dfaed261e8ae64b49b355.1750717921.git.me@ttaylorr.com>
Date: Mon, 23 Jun 2025 15:49:50 -0700
Message-ID: <xmqqtt463wfl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> In add_object_entry_from_pack() we declare 'revs' (given to us through
> the miscellaneous context argument) earlier in the "if (p)" conditional
> than is necessary.  Move it down as far as it can go to reduce its
> scope.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index e7274e0e00..d04a36a6bf 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3725,7 +3725,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
>  		return 0;
>  
>  	if (p) {
> -		struct rev_info *revs = _data;
>  		struct object_info oi = OBJECT_INFO_INIT;
>  
>  		oi.typep = &type;
> @@ -3733,6 +3732,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
>  			die(_("could not get type of object %s in pack %s"),
>  			    oid_to_hex(oid), p->pack_name);
>  		} else if (type == OBJ_COMMIT) {
> +			struct rev_info *revs = _data;

Nice.  This block is the only one that needs this variable.  Makes sense.

>  			/*
>  			 * commits in included packs are used as starting points for the
>  			 * subsequent revision walk
