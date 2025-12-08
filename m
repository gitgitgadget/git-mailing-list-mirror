Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14C122A7E4
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765178019; cv=none; b=EMA3I3HoBU+mXtiTI/1nYtg2JoRyfPI4W25qayvXiNgt5CKBP+VNp7gIyFj+juW+7c5YeAGDeiyOFqcBN8LdveVx9MIprBgdAlgAD6a2V16HaI3CKcttGsOmtgDs0kPrgFPf2AHhdgAfcfD9GrKDebh1n90uKYcFQIfMT04bxZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765178019; c=relaxed/simple;
	bh=dgKYLf8Nx5R1br/JRmaPIzYjPQ4Jw/gYW51vIeG+cRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4K8xODBBzKn/1WOgYXrGs2xw+iOLhug8jUUdNsRLX618CHkT6NfcnMPvGkRrIjm9ZwICwsPuuP0p/9jHDDPAzTzpZPVxJSZm2tjK5ua4qA5vpVLktmRQC6a2/o+SxjSGr4h3Qpv1vW4Fzeydoa/WuTUCRu9RFGIG4bVAIuNFso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HordrxPs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cuxH2aYz; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HordrxPs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cuxH2aYz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D59191D00214;
	Mon,  8 Dec 2025 02:13:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 08 Dec 2025 02:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765178016; x=1765264416; bh=dgKYLf8Nx5
	R1br/JRmaPIzYjPQ4Jw/gYW51vIeG+cRg=; b=HordrxPsCCzAMNichsaPSnbXfi
	hVilSb4qzMzGvtbq5H1nQ1MV/CsMeGjAwtP/crkuHqZyNw+lDKQOYG8qdNiGHSP3
	kcZebyXJswKR+/IAM5fcHzlSDGjgcoVfYqz9MKSyoRpa/CM4M3iryCWV4lxg8Qsk
	n1ZQvB1yv2aDHNC/7CmIjsTFHm0hN1s4Z/SzdvIALQaPklCuJpEnEcGg0Xt6Fg2o
	e1CwI/kq89P2/+czoF+i2srhgKyMKLXRlkZlFpO+/RD1jV+2ieLTbm1066t5o0oy
	PsgzI13HTuJuVDtrARqkICuMmdnHH3yuouC8GjVwmSfAUWUQTjustkPftVkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765178016; x=1765264416; bh=dgKYLf8Nx5R1br/JRmaPIzYjPQ4Jw/gYW51
	vIeG+cRg=; b=cuxH2aYzfK7sKcQxEKwnGWBGx2jFwFhU9DWfzWxgKjBsf400dr8
	Zm7Y/mupFr7sfxCZowTSxZEIiZil8vByqEM9tYkqH/SL8zxkzoajORlUMPusI3Bi
	D23WAhZfSp2dhevrYXJzG8IGt+g++u0d/tYcFt0CHeAY/Eyd0VaLeUSAF9Hlslw2
	JGktCDBC6I68Z4V/pzseDxZOYHntH2k3lhEVmSFEMe2RlWQkOTYXiRRPfK1OUQ8j
	lmKSE5O/j9ADfWeRLQIXB5bYm8V9MCRh3qN1R8l2ORkxw/NeVMob5XPmLjaEQDB6
	vFnWFCvbHGFn6gAg35dAyYcshWxVbdIhpag==
X-ME-Sender: <xms:oHo2aVcWHro4m4qc1wFdF9GwwZZ3xql41UPPDmKGEeZ8aeIarrT6dg>
    <xme:oHo2aZNMqSmSUAPEQS47vd9de7ZHi9EiodtTfoCtWFK6KscaEmQir4nIcBIYoyx23
    z4wKhBc60FV_NjkLknbf9OXyWlcRwPRznhbzxMFOeb0oQg385_m>
X-ME-Received: <xmr:oHo2acKirh1T_PRkcfSsCjztfA6U6d84UVMiJY4bZc1gmgUNYQJMOMCrvxHsrjHv5UTfjT4ilDx8yymy7_lEFQcNcZ_4qwhK2jLMVOCsljA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oHo2aaHhR_hqkxyCBRCJjoW-cjgIcZUHXxGWQEsKqjtD2wg6eFndbg>
    <xmx:oHo2aUQ1hNPl0Kij8tZvZQL2MIzmV6VFm-OEViQ_w14gbkNk1z2lZg>
    <xmx:oHo2aWGxbYfJQRrHYv9MYLMDH5j0rSZYWmkUJBinfatqv0USNvCI6Q>
    <xmx:oHo2aQ9fErZNc4FTA_nqMDirYKk_0-NHbC22ysF3an-_VdUhAIU8cw>
    <xmx:oHo2acNe_Nz7gJE9X86NBCfb8Pc4QssajOGhoKqsYvoO63Itx7KbNPsW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 02:13:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9ede9ae6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 07:13:34 +0000 (UTC)
Date: Mon, 8 Dec 2025 08:13:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] repo: add new flag --keys to git-repo-info
Message-ID: <aTZ6mmukjUld5V9M@pks.im>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207190532.67107-1-lucasseikioshiro@gmail.com>

On Sun, Dec 07, 2025 at 04:02:10PM -0300, Lucas Seiki Oshiro wrote:
> Currently, if the user wants to find what are the available keys,
> they need to either check the documentation or to ask to all the

This sentence doesn't quite parse. I think you wanted to say "ask for
all" instead of "ask to all" here.

All the other points were already covered by Junio, so I won't comment
on these parts.

Thanks!

Patrick
