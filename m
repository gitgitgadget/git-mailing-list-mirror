Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F662C11F0
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766619843; cv=none; b=oUkO5MrGeE1mOnF8DU4MqXDoumAqCHhWyM3GdDMn4648em7dQ0eYhltW7MpH2WBS2SwKrofLVFDLZncMn5pTnFvhSECot/QpFTqDH/dDs0ROSvHtyPuod3HWVt5UsZfPxaViEOT8CQelt3r5uDw1icbpM4X8WW0PCwrJlIm7WPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766619843; c=relaxed/simple;
	bh=SKf+hDTMqMbfsKfNARtbSajkwKPqAUCdfqd5yXgY5aU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UsO+OZNlKt1JQGNab+3WKAlvjfm55X3T1gWTABHgHAe7Og3azRM2fjYlwgutpKSay6Nwb3j/eo4RO/yIlJhZY+MBSrCThdgJEnk/4Qq2sbFjUmmIQCkyhtaFC0IDkgJFa35PViFGI36BiI6/0VWnZAOpls3k2nlQyt/KjlLVNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TNmC2ck6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YZVTUAwO; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TNmC2ck6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YZVTUAwO"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D57817A0079;
	Wed, 24 Dec 2025 18:44:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 24 Dec 2025 18:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766619840; x=1766706240; bh=cdqeJQjRlL
	L3+HwvA6gSuK1LRhTEx2hE+lf+qqke9EE=; b=TNmC2ck6zroY12xailM4COlb4h
	BMoUg5oSM9vFAePEB3Wn8hfeZFI7i6hlHAA2EGaBFasB5dwZGx4r1JbW4vPGiaIL
	kgA6txRsWV1JMFTRj343kl4Z2AO5S1mb/GFAavL4ZKLWcEfYBKKEVLZghX0ePqy1
	pFzxoAqTM9DsF4is0etSdTK7yY1ED/H7l88BhSLOlZ8tFTyAkUZw3avs4eG2wzhI
	fXlOEHTB9Ql3sdX0xg3ponfFIegNKebVL4ZsN5PthCskIKwQte8PHVLfyK2Hko1l
	aj0NvaOEgPswX8+lE6DEcKzI3ssALA/nhqQEEJ7cbkhmItNtxmeuBS90XxxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766619840; x=1766706240; bh=cdqeJQjRlLL3+HwvA6gSuK1LRhTEx2hE+lf
	+qqke9EE=; b=YZVTUAwOApiWMfw75ObmFcYW6yFVnlpa2kD7FQfn6hpOX6EMBUG
	XI3hU1AQOmtscpqLRfbNftZQXkxsQqSCss2Q2huINnJxUqJKaSUGf3aj3LgUD1b8
	iCPnsObfH8DtopYyKl+vkFhngi9NJzKEC5tqJ7b8SpzZVu7GYc0hvVFfsozDICa8
	skf+J123eIS0piab7ePphCWUPJlESszUn736ZcfJyORyBRis1fkc60MFXacT21sw
	YuwyLRXRQNVF13jx9TcuxJC8jSepRvFxPogmKq6Iws2YfSECIwGtFjtLc/SUsaKd
	TO/y+JutbDpzB/h+61tYiZwVi9boUlwWO0g==
X-ME-Sender: <xms:wHpMaS1XyQ7fveL44upWJATn4z07VLki87fekyUsXNXKm83PSv7C2w>
    <xme:wHpMacFMt_bKD2pnZLQhx3XPf0YI19srR-uIOqwMQ0ZkxX0KbYFfag6Hl-72UEh3I
    10CrkLZQIhpQDX3H-ef62Gja6CKmt_sDva36Y1Hqi_VpdRceRIsgw>
X-ME-Received: <xmr:wHpMaf4h10jKA9tv1vM1W_Yr_gluqreTU7QjzOfbUVsls_NsIaG0UKDyj-rRDDvMoQaspVudICgVY-XCSXeOIrttDuT8s9Gmtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeigedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepiihhvghlhihosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wHpMaSu7a79Gegn3eGcZsKT_1vPui-nElTwrbCbRwzK4OPNYtSZsaA>
    <xmx:wHpMaQ6J7M26280uKh47OyRA_iC9j97qXe0GoXAV-RC_6AEUGX30HA>
    <xmx:wHpMadU8V_wCA5NTScNCfDd3pFLHeX0bV_R1sVR9stVnI7tDN-o7Hw>
    <xmx:wHpMaS9YEyRjuvVpyCS5IycKvd3i3SE2pcnhxOe5HRjBCTFzUxx6lw>
    <xmx:wHpMacq_g9apC-mT74Jd_EB_1ARXAXkRlOS91ITFdmClLtcemZxmw9Jr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Dec 2025 18:44:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Zhelyo Zhelev <zhelyo@gmail.com>
Subject: Re: [PATCH] checkout: quote invalid treeish in error message
In-Reply-To: <20251224203253.881129-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 24 Dec 2025 20:32:53 +0000")
References: <xmqqbjjqslgq.fsf@gitster.g>
	<20251224203253.881129-1-sandals@crustytoothpaste.net>
Date: Thu, 25 Dec 2025 08:43:58 +0900
Message-ID: <xmqqecojo37l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We received a report that invoking "git restore -source my_base_branch"
> resulted in the confusing error message "fatal: could not resolve
> ource".  This looked like a typo in our error message, but it is
> actually because "-source" is missing its second dash and is being
> resolved as "-s ource".  However, due to the lack of the quoting
> recommended in CodingGuidelines, this is confusing to the reader and
> we can do better.
>
> Add the necessary quoting to this message.  With this change, we now get
> this less confusing message:
>
>     fatal: could not resolve 'ource'
>
> Reported-by: Zhelyo Zhelev <zhelyo@gmail.com>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/checkout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Obviously the right thing to do.  Thanks.

>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 66b69df6e6..261699e2f5 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1899,7 +1899,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  		struct object_id rev;
>  
>  		if (repo_get_oid_mb(the_repository, opts->from_treeish, &rev))
> -			die(_("could not resolve %s"), opts->from_treeish);
> +			die(_("could not resolve '%s'"), opts->from_treeish);
>  
>  		setup_new_branch_info_and_source_tree(&new_branch_info,
>  						      opts, &rev,
