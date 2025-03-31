Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B11D1AA786
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743404435; cv=none; b=RpTc0crV4Xmc4kcgfatT28FfhznjsQcFdBJRDujxpgSp6SKaOA0qz3MeVOKOyxmnek/kqSOztEEOW0DQ5OfNKfU2Vve79QSGXGmIX1r4ym+Wv2rEW+vFoGJG4qxkfksbuHZZLs3RA7OgnnnwA851eXHb8yjpf7fzHrJoCfujwAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743404435; c=relaxed/simple;
	bh=TvNlBx4x68GnCoAml3XfuKp0snKTjLty894f/pAmA5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBNy3YsTsI58daO92Gf7hOReSUbAW8fjuqbO5UbimfqSQaYwr/eubxcIGM9+uvltFda54X515BAuZpMCCozgrYxa0BNmqAvnuqwTW1cvnp8VK+cJYEGCmfH0h8F2045g748W7TUYRb4eFCuptZTy7Wy72lvUYsBw7BVKD3RmBWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YW1HsCyW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BPmtFLBi; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YW1HsCyW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BPmtFLBi"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F6C313842A5;
	Mon, 31 Mar 2025 03:00:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 31 Mar 2025 03:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743404433; x=1743490833; bh=p6d90Q6KEO
	X1rx4CACmfRVuzciuMw8awz14reIpNltQ=; b=YW1HsCyWEHUzkKIkUnIqh1vwj6
	DKrO6MmqiZtRuXkvZW//X5wpPX0jcxAy2ItCuGiWh4uxR49nMEPnyEZkhw83NxcC
	U7Y2egyjrDQcJWxaF5ShztVSQHXJSppnex0GTnXkRbx2AxouSZFETgKiEeiN6Lz6
	zjvWJ4aQ8kO09pXaqKUKAcH+8m6jTR5PN3cKjpRkPAlYLFj96H4A29Ln/YYHvmlq
	tsvAWgByQABLoRq7tzgEkiDFAF3s7NJCMW3lc1cOgV6yBFJFZDDNt3MZ1DTmejoj
	X9SSZkVwY2SUcMlfXwnmnUpbDp3hqwRmS5eAEsq9ZsQGoskHFdZl3Fvi4Epg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743404433; x=1743490833; bh=p6d90Q6KEOX1rx4CACmfRVuzciuMw8awz14
	reIpNltQ=; b=BPmtFLBiEXWLbLLj56ydvvz0cZ9JhEAYk64MAnB0u53o3/5HMmv
	WUsfHLd/Ks6uuMqS6gDOVRUCyJjGpWohJ20zNoPKYvl89CckqzMDJsTJqmDHrw4n
	U88nCMnRPdN1vI62r+h9LKBf862mIMu/U8FCWvxwX9cuWAdQM1zLc9AD9e9BvUSe
	b3XyMC8HGjfif8utZCG3QEcilKwc+RLXI5BLDM3F7vU8aYTPppF3wNMKsvGiR6u7
	c/3oGjhtxUYaF1vfUh82H9wIfuIydFJ2BQFH6lu+rZCnyHfgu27PwGtB6h/nfbyV
	P78vCFSbJrKO4K//WkXsw0ZKz9J771XYJZA==
X-ME-Sender: <xms:jj3qZ_iJMEyv1-LD79hQDxIwFnEQU2j2hDRILaqiMbN0XirmmUCZQw>
    <xme:jj3qZ8CqNZUEPoU1txuTs_BSvrI9wTIFc2xf2IfdX7CWmn-eYBJdEmxLhxLcLngRn
    nyZxdnrBGooiegUzQ>
X-ME-Received: <xmr:jj3qZ_GLop903X-LXSZBcP9c0ak2UCJ50erwQuGKxffyybjBnhXh8-iKOLW1RORSczBllFxQhHGE_De9rvlhchuzG2WKvpcsYhgYZMjVTeQ7nNwL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkh
    cuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhep
    gedtleelgfeluddugffhvdejfeevveegfeeiudeljeduhfelieduhfelleeukeeinecuff
    homhgrihhnpehgihhthhhusgdrtghomhdpghhithhhuhgsrdhiohdpvgguihhtihhonhdq
    uddvuddrmhgunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvdekpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlrghrshigshgthhhnvghiuggvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepthhfnhhitghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepshht
    vghpnhgvmhesghhmrghilhdrtghomhdprhgtphhtthhopegsrhhunhhosehgihhtqdhtoh
    ifvghrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdr
    tghomhdprhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:jj3qZ8SH_0Z4kD0G5-7TasnOhA4ZXTehRQdvBPRQU72JbCGWUCihuw>
    <xmx:jj3qZ8yquiuvqUN-ZE03WIaemSa9Qz9JHQD7Ecn-w9hRHHNmHoA-0g>
    <xmx:jj3qZy6d5DCJTnwKHK1vRXOTg240Ct69GcqaQTBVffXQsOL6_zXHtQ>
    <xmx:jj3qZxzSk3OnlUvver8okYCbHsd_OWIcBA3WmRm_u917u5mO3m1NkQ>
    <xmx:kT3qZ0d54ALdk7u6iwem2FvxMjnlE38Idy46_AGZK7l--0Y1JMT7anpD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 03:00:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 055ab583 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 07:00:24 +0000 (UTC)
Date: Mon, 31 Mar 2025 09:00:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Markus Jansen <mja@jansen-preisler.de>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	=?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>, Bruno Brito <bruno@git-tower.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	David Pursehouse <dpursehouse@collab.net>,	Jeff King <peff@peff.net>,
 Matthieu Moy <git@matthieu-moy.fr>,
	Lars Schneider <larsxschneider@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
	Nicola Paolucci <durden@gmail.com>,	David Aguilar <davvid@gmail.com>,
	Mirth Hickford <mirth.hickford@gmail.com>,
	Seyi Chamber <kuforiji98@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Draft of Git Rev News edition 121
Message-ID: <Z-o9hrPQfWxIWjAn@pks.im>
References: <CAP8UFD2KXVB3w+YSK04oPZ3rkoCgzW_V1suTO=ipxx9w6HDn1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD2KXVB3w+YSK04oPZ3rkoCgzW_V1suTO=ipxx9w6HDn1g@mail.gmail.com>

On Sun, Mar 30, 2025 at 11:03:19PM +0200, Christian Couder wrote:
> Hi everyone,
> 
> A draft of a new Git Rev News edition is available here:
> 
>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-121.md
> 
> We are still working on some stats that we will add to the first
> article about the 10 years of Git Rev News!

Congratulations on your 10th anniversary and thanks to everyone involved
for making these happen!

Patrick
