Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9D14B1E76
	for <git@vger.kernel.org>; Mon, 19 May 2025 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639961; cv=none; b=IgYA1JQ9D2jGCKm19GctmkKlQJxN1IkgvJ4w2MU6e6ku86KvuX7ijLVDvQQ5kWvx0uHUtwxHgMGs0hRmrRcZDtxEd/18XidBfzeDvIoAckGW4z3f/B2DZKtwqPwOi6hd69iLjE/KC3BQmbaMytP8j6ULUGuKmRFQiZIRMm3oNGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639961; c=relaxed/simple;
	bh=Mv3UwfTCdUY7dgf7Z5U2UV9OwfevYnaSrd7nP1YQpxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THPJ1tzBZEtENw/IoaUCp5HiWGZ+Ob8u0Jc1l2yx6d4nd+iCybMOnT5zEdlBLeWWtBjW3atpDGCJyIUczLuMgEQ/QaFJW8BBQGAfL021TwQae8YmDNWg+VS7bKqIFlIVWbSBcWkzVT8Wl55/E1bg3n8aOEzt7dene6FLqevn3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gou9/aZh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kvZfIjlO; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gou9/aZh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kvZfIjlO"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BD8B111400C1;
	Mon, 19 May 2025 03:32:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 19 May 2025 03:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747639958; x=1747726358; bh=xaF3a8wVeq
	21jo3oJ79n35gTV1e63fUUuMuojxMjWf8=; b=Gou9/aZh0O49vXBefjNdDvNZjA
	zCGk5q0xSUZnQusChPh7EbVyvisDTLvVSBMqUcwyx6GsA9xnPP/4pqAklAI2AW9x
	oug0fleq1KAUh89CQlXF0WQiPVUOoFO40SIxdpjiPqrb73QLUje7sg8nsDaREXaJ
	JOj6R7OIhGc0gYJwDwrhzFRdonjHkFAcYoU1k3G1GjbK4dRntrx3AOOzwFJ5eCmT
	C4fAZzulu3ITqqXkF/ovS6SC4ZZM5A/mPm+IsmAVdZVXLMbKjPCJgul08ymuTR0/
	kfJDwzpvHdHWfON7PMUiBZ450lAzLDWFCGb8MEUm5Gm9OA9Qupb6t0OvOhMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747639958; x=1747726358; bh=xaF3a8wVeq21jo3oJ79n35gTV1e63fUUuMu
	ojxMjWf8=; b=kvZfIjlOsVB1DK2SNXhqyC5D3W7pcXAfTbxwnKiXGOFQwgQrapj
	ZjVTFx2yP/8+EKbOjX7Hkx1T7L3/V53QBAbSlrNboDcFDTGnD+Dzhcbzv5W/nCXK
	pTFZKwcl1gzQE9fdXUpOp/7234njxOcbAJVeZpAUClBUmp52bYkf6eN0qjfRBBT1
	BKD6J0hyJes4DVeMFKZwyrfkxFCmGBMJ64EXYj/X2dUSxEOqTIXFrLWiTjF0L/4X
	jSN1zhh6P6reh3SbdqyWvy126jNkXnu4kxRYuc+Aoyx3zBR7j7PT5ES/c8Rxt2Ra
	P4NMmOGbIw8gDk1mIEPA4sI1/PuBzAeZjRQ==
X-ME-Sender: <xms:ld4qaLjD0t8BJn8OpYTrjGipIrmIy2PtK6aJlow-oQH6zrcmURXu4w>
    <xme:ld4qaIDBKu4ksT9z1eqlMxxBRir_xIirWCRuTokwKuq2Q_zIMZYqEIrmpFwecdR2q
    BaR8lG-FlcIgC9c9w>
X-ME-Received: <xmr:ld4qaLG7bSuwEGYGTpp7y4rA4DDlnfJffunH31QN-bkyXmqvg5sKmkHJHA7c-84uA7CR3cY3ZZ4TeL4pGgk43PRezqag5H1Oq6tpWK5Ve30w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorh
    hgpdhrtghpthhtoheptghonhhguggrnhhhqhigsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhn
    vghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:ld4qaIRcad7g7GYkGTmyhjdLXNDMcG3gD8YObAXcHIC8QUNZiGvg8w>
    <xmx:ld4qaIzA7lleFyIFAj5ORCFs426og9AxRUllovIdzDFodGFvoI8EKw>
    <xmx:ld4qaO5fnDXjNlS4OVHaGOw8Sy4Ri8ahmMSm2cXMCiknBIrXMHDcpA>
    <xmx:ld4qaNw9ypfFYLqAKLoFtRJxZsO8eGAm4KK9ct21PKX7QILXku2QLg>
    <xmx:lt4qaMgiZIsASi88tBsmuXJX2IAnxQZikKqvPJPKSh4x52scLNNY8I2b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 03:32:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a53d1b60 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 19 May 2025 07:32:34 +0000 (UTC)
Date: Mon, 19 May 2025 09:32:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
Subject: Re: [PATCH v3 3/5] meson: correct path to system config/attribute
 files
Message-ID: <aCrekcz6onTFgEWw@pks.im>
References: <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
 <20250516184843.1524925-1-ramsay@ramsayjones.plus.com>
 <20250516184843.1524925-4-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516184843.1524925-4-ramsay@ramsayjones.plus.com>

On Fri, May 16, 2025 at 07:48:41PM +0100, Ramsay Jones wrote:
> diff --git a/meson_options.txt b/meson_options.txt
> index 8547c0eb47..7a4b896f7e 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -3,10 +3,10 @@ option('default_pager', type: 'string', value: 'less',
>    description: 'Fall-back pager.')
>  option('default_editor', type: 'string', value: 'vi',
>    description: 'Fall-back editor.')
> -option('gitconfig', type: 'string', value: '/etc/gitconfig',
> -  description: 'Path to the global git configuration file.')
> -option('gitattributes', type: 'string', value: '/etc/gitattributes',
> -  description: 'Path to the global git attributes file.')
> +option('gitconfig', type: 'string', # default 'etc/gitconfig'
> +  description: 'Path to the global git configuration file. (default: etc/gitconfig)')
> +option('gitattributes', type: 'string', # default 'etc/gitattributes'
> +  description: 'Path to the global git attributes file. (default: etc/gitattributes)')

Sorry to be nitpicky, but the default information is duplicated. We now
have it once as comment and once as description. Other than that this
version looks great to me, thanks!

Patrick
