Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DA54654
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095357; cv=none; b=abD8VDbZ4yIjHtCRafpSsMv/lYTXlTtltJNfny6XzrOSFvuG7YpqJV30CaZ/VqmvomiL92QKooV3Fj2aRwjDz+cTP5pGt9mjBhIIaKPEWqiir4rhkjkJG0yDjBYaUlS88BcxdI/HZaZ/UX9XBJAqpNKpj4bZdyKDtx9VWlhA6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095357; c=relaxed/simple;
	bh=f7FN6dlwPDPuK20NNsQNxrotHwhAD0sszOPKWkiwxQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb8IlQ0i/tXGdKFbs+j54G20k4uy4zpLLTa3OhmuMWVq0ttVkcm5UXnWWqgGZQaM3t4ch4uMy0z4N6SE4KjpTmlxEFUNy3FvbgETofyGwjS+z5gr43Q44o0ptoeoyT6YQ9v/fJlr/p0X1ZMDw+j6RJF52BpeC3RkI1g4fswzzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=apdi+TUv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nks+IVie; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="apdi+TUv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nks+IVie"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C7137EC0128;
	Fri, 10 Oct 2025 07:22:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 10 Oct 2025 07:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760095354; x=1760181754; bh=cjECXKD3qP
	/cCNXOy051YBqTL7TlRQvDqr2eOja4O0M=; b=apdi+TUvACK2993xeQqybUl0Uw
	jfOJQB/T+QZRj3lfNdGgypE75QKc6FLbylUeALTfkCU5FEid1lr5K+IkxoThApTk
	o2VcSwIgHu8iUfkShQDgHqoyGp80Otd+MCYq9/b2HH4qB8LN8/wDFSHqYcQagQDp
	TTo6m78UiDUXvogbLnLSW2jvgdQ42kIax2t7PMgst5NoeWC7x6kXX6JyXKpYruUJ
	l2H9XtM1Fzedjz+PpHmM6cQypQQfCEKnOHri9bV4q2zfR+ofh0dTV/DItOaKPdYq
	8RyU6WFiVGXqkHY3/SEnsQxDZxlUTe+F0/v7gvzI/Gfs7dX9e+utvxuNPjUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760095354; x=1760181754; bh=cjECXKD3qP/cCNXOy051YBqTL7TlRQvDqr2
	eOja4O0M=; b=Nks+IVie50loAwuFSjc3KCb9hQPBDvjpYn1W7K3VxzWo/pNG59Q
	3dYKIH5uvZjvgX/HpN/HW+DrShUTz6+xX7QfU45baR/hZMEcl3GVoA48WHMe3PAP
	WQlM2YPr35GRCD1IFTSpDlWRPkZdP1Aj+yWOWMneY4JQWMi88GQDpYQPLiqkGiS/
	E2pXuqOMzEx8gUuzRzHKK55yOwgSYPG+9s3U2ZSNzAYU9BuOr0gmaxcPWjcF/tei
	4p2y5Xs9g08wnC0MUPgD271h+SZIiDK8wbE8R++M3C4SMVOXXztYVZId6Ywq+QFa
	pKBts+k5PJTiCySu00WGOL5xx5XqDmsc1xg==
X-ME-Sender: <xms:euzoaKiIA68lelqVbg-qc-gGb_PDu5hGi5vDZdb3Fxf4PXfrs7axzQ>
    <xme:euzoaBC_uzRggEgaozWCjTcY8tGTOqarFssZ2gYlF6MEbT2ntoTtQ2wPNzaheoZ_P
    ELJaCtTtIgg4XR69Eh6IEIPR4bJZLdTdLyuSh_wSaucNR2sxHC60A>
X-ME-Received: <xmr:euzoaPuvoVgnsXqpcWMAnY-mHU-C4IY9EGwDx9lKCFSOJbTma8kWP24WGKSaPRBk57EOByfTKTvNRBebHC43Fw5NIIqDo0Hq-4_wDQTrzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:euzoaOa4MQ6jJveDE-T4IJzLz1TWoeEngD-xKpqD-LwOgjGcAOKn4A>
    <xmx:euzoaKXbGIlNhANZcIcKHRUfp6hcoaPChtRY-UzoCaUG6DXjpZnNuw>
    <xmx:euzoaK6un-RdUj5J3riRIEL2ERflbZ731EKdUpt0inIDcaKTc-3rEw>
    <xmx:euzoaNhm6pbH90sZXLGMFSbPw3ocnz5NCitOHUJVV_VrZ3tiaGSKrQ>
    <xmx:euzoaCTOjHo_lOdO2CZD9nV4wbfkEzotN1gk7baLQykEzv7mhOe7DKhs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 07:22:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id adda7006 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 11:22:33 +0000 (UTC)
Date: Fri, 10 Oct 2025 13:22:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/9] t/pack-refs-tests: move the 'test_done' to callees
Message-ID: <aOjsdtXFgVb8QcJF@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-4-c7962be584fa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-4-c7962be584fa@gmail.com>

On Fri, Oct 10, 2025 at 12:27:08PM +0200, Karthik Nayak wrote:
> diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
> index 095823d915..6a71838ffa 100644
> --- a/t/pack-refs-tests.sh
> +++ b/t/pack-refs-tests.sh
> @@ -460,4 +460,3 @@ test_expect_success 'pack-refs does not store invalid peeled tag value' '
>  	)
>  '
>  
> -test_done

There's an empty trailing line now.

Patrick
