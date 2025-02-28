Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6DD2561DE
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736908; cv=none; b=MBK3fxhuiUAQ0INLZJLchTZFf+8Vr/Ro4Vy+LqQt2hh9wRtHulFlhTuVW4MYuU6TFARMZtK3Ny2+cJzhRwfU51jZZKeaQD5FJ/zfNsB7Tkv1Vqb45yAAB1ztYfdScRB15FeTOLyDVuFW/RsVoPw/mi8XfrX+Y+2hgr87DfBXWWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736908; c=relaxed/simple;
	bh=XCOfDr+4I1KJZzsilmVlmywpfczhza8LrEENPzTzXdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeIgRe6zfl9qtb7T+MeM5BIAaLucypM8dtiFnsFFk51JqFQ/QiibxTtEjEgnLeR21sL1FrjDLIbzW2Ng/F8fSnphx4CEDOhGtyM6LafaY4UBVcXXWvy2mlXmSVkwiZM0a0Mbnk9mKsFvgpihwxl4vKVdsSJQXfRBqak9rv7+49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E2OXoPwn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6ROyfS1I; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E2OXoPwn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6ROyfS1I"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BE3771382764;
	Fri, 28 Feb 2025 05:01:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 28 Feb 2025 05:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740736905; x=1740823305; bh=1WHMjAtMmF
	y0u+xGDIQnibkw1PKFHecUoJRa5HU/b4Q=; b=E2OXoPwnzTMLs4DrG4YsN/iEYb
	c8ZpunZptwxxzUidXDxah3jjUryhoGJt8HJDKteic+yN3Jc92NY1g8qX+bHOhZoF
	q4PqbaMi1ilYXGGQjfUHHXOld4a9pFVAfgzidMeQb9K1DxCQZgtYvhjpezjuTd6b
	/atqGWx7DyM726TXahesIO3OxIy6BZQ6g96KQfaNlVzoz6ZnZTE4CQZ5dLUwpdRk
	0HtiIWkPRwtrFNZ45ZAgbbL6ToeVNtu1cS3jFAE2xYeP4onYQ387Q1+/SSfw8w3E
	S4vOwKPEDsOYQ6sCemFuukt8stgIJ2V6haoXxryLSKe3RQapfIDAELiU5JJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740736905; x=1740823305; bh=1WHMjAtMmFy0u+xGDIQnibkw1PKFHecUoJR
	a5HU/b4Q=; b=6ROyfS1IDNqai6s+PGxJFloTGmw41VqbpDUSARMP8+0m2zus4o+
	9KK/W4VrYkUuIcXKOFfbwbFhxFViPinTFbDU53fu5FNryiuZ7Jzq2P5aKp0Oa6sa
	4oQKMp5WxFsieZmcDrRNQPZEOUv4bqZ40nF2tKlTdYClTIFB2l3LzMt6iLy5A75q
	arVjlH2z7L0uAk7ruy0aORUMmky0TwNR+VLSsXnUGwxVwix4GdN/Cv2BpBxr7mfY
	UJZ9tf4uGE9CRiSuVDj3zEfxAbs0PrJALSSYx/HZVk3dnMyzbwBwoA/bSgYisCY3
	OphZbOYrOjfnIVFW1zgBaAuUNuJpUN5RvZg==
X-ME-Sender: <xms:iYnBZ0U9VPpGcEBMNTlRTUw9UxkAoXn4AgoYhjkcBCRojjA7NPEMaA>
    <xme:iYnBZ4kwfN68ETyVwqrYApuDz1ouqVpZnCaoiG1mWSyNqdUyBrSUpAal699Ctfb3d
    ErRDOk2a9bYJqCNhw>
X-ME-Received: <xmr:iYnBZ4YYKNI_PNWI7cHUtf9ljwPM0ogVSyE5ZVWYLaNfxoliPX_bg6RwAvjj0CABvR0XH6BH5srzu5NC_0ee_pvRNSMsThkYKWyQVZgZ850ZbRM8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iYnBZzVBhpUH1KXtpR4tXxtCHRYAq5qYrhREJIH-y0Syq54f2JlDgw>
    <xmx:iYnBZ-kl35dqa5Jw6dJFS_u118UVpIA5QiCywDVt_tyh77-9jG51ug>
    <xmx:iYnBZ4cWxadfbNp_dvZQ-yK2nrLelWoFqhqAHVaLYewLDJdk1sX-ow>
    <xmx:iYnBZwFzOcpyo8Ux9_bT7iQYfZvFPcZ3LlWwi2mbQhgmhNNtyvhFyQ>
    <xmx:iYnBZ1v83Ii6ZsYxvEc2AW6OE2j1AaJYlpX2Ptj82p4Rq4TcMJMQO6ii>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 05:01:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3eb6f558 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 10:01:44 +0000 (UTC)
Date: Fri, 28 Feb 2025 11:01:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 12/13] pack-bitmap.c: use `ewah_or_iterator` for type
 bitmap iterators
Message-ID: <Z8GJhzdUtH5IB1Pr@pks.im>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <87cb011e7fc283ef34f4554122fb901c1cd87294.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cb011e7fc283ef34f4554122fb901c1cd87294.1732054032.git.me@ttaylorr.com>

On Tue, Nov 19, 2024 at 05:07:53PM -0500, Taylor Blau wrote:
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 348488e2d9e..83696d834f6 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1622,25 +1622,29 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
>  	}
>  }
>  
> -static void init_type_iterator(struct ewah_iterator *it,
> +static void init_type_iterator(struct ewah_or_iterator *it,
>  			       struct bitmap_index *bitmap_git,
>  			       enum object_type type)
>  {
>  	switch (type) {
>  	case OBJ_COMMIT:
> -		ewah_iterator_init(it, bitmap_git->commits);
> +		ewah_or_iterator_init(it, bitmap_git->commits_all,
> +				      bitmap_git->base_nr);
>  		break;
>  
>  	case OBJ_TREE:
> -		ewah_iterator_init(it, bitmap_git->trees);
> +		ewah_or_iterator_init(it, bitmap_git->trees_all,
> +				      bitmap_git->base_nr);
>  		break;
>  
>  	case OBJ_BLOB:
> -		ewah_iterator_init(it, bitmap_git->blobs);
> +		ewah_or_iterator_init(it, bitmap_git->blobs_all,
> +				      bitmap_git->base_nr);
>  		break;
>  
>  	case OBJ_TAG:
> -		ewah_iterator_init(it, bitmap_git->tags);
> +		ewah_or_iterator_init(it, bitmap_git->tags_all,
> +				      bitmap_git->base_nr);
>  		break;
>  
>  	default:

One thing I wonder here is whether we want to continue using the
non-layered iterator in case we don't have an MIDX. But I guess it makes
it easier to not do it like that because we have less conditionals, and
overall the or'd logic shouldn't perform significantly workse anyway. So
as long as we always initialize `base_nr` and the relevant `*_all`
fields even in the non-MIDX case we're fine.

Patrick
