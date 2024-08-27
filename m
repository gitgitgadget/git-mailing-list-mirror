Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B21A2547
	for <git@vger.kernel.org>; Tue, 27 Aug 2024 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760557; cv=none; b=QxRFC2FKdff1a7OjD2OOc0TBhjXd7gxckR64CKZtfYuFzKvZwmzC0AyVv1uqOjvpPXDgHiEJJpsXDitJPiWbl+0XulkOG/SSMRG8aW2ogznbQ20l47bvv2HPdm2ZsXhjCcSFIKcc7uAzsnhyuxxVAXo1+bgATnZWDJ/vR39wC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760557; c=relaxed/simple;
	bh=vWSLZtZaVI60QNZ6DrBmos1zpGjA8htpf0f+2bvKQFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAp33biTRwRGIEB+T6Difqcl4GW5LgKWCh0aLXoxVkgwdIFNmksXk/a2NUQfYbuhEAF5ZL8/KH+oVhH7UaIFGiEbYR0mIONWGbzg+H7joNx0B0foHNafjrURzM4vlIbMUTpaOoXGw5wVDCoGZn41jBIJwOT/Z2S1ZpGmUhmp9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kha89ObP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ILJzXMuh; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kha89ObP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ILJzXMuh"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C58881151C7E;
	Tue, 27 Aug 2024 08:09:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 27 Aug 2024 08:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724760552; x=1724846952; bh=o4vKQAkcNQ
	em3NE/kjxP95C67MC67OsuoigGuy/EVw0=; b=Kha89ObP8ZqtQahZe1jbpxF02a
	LBzUGGWTPMh3T9tciUvgSQNbiPRpN4cwCFylAA0am6IpQKxlu83s/p0bDqH15G4z
	q9VB5zNYEV5lWTNmJgMZVlyO5r/0qOoUCnHKcy//fmUD4rv8Oo4mAR1T4d0xZUOw
	wVdnHTI2zLEWzjTUpM2A9k7PM9W3kJWpDgqKKU8R5Q2eChulh4/vQ1TJblogEybe
	zX+ltwXttbk1D/ytZDyRYQR0MSQBKtCcLzzBepT5nU6MbFMbWE01I5+N4V0S6RXH
	08P1Wuv2MNauaGLPrzVylDY5Uppj0qjwHywrFOlMS7dfP2Cx0/pM8fGT4RSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724760552; x=1724846952; bh=o4vKQAkcNQem3NE/kjxP95C67MC6
	7OsuoigGuy/EVw0=; b=ILJzXMuh+dYFlc2NSc1vit9CPj06DTDyN1ju7UnkCqMj
	cPOoJ9vxp/w7Sm2i73nke5+Y57VVrHzDnWdeXExwoJ32muraZmwKc/28Km4giFZ4
	P6uCGo/5AY1gYuSiz0WfHWjLLby3lG1MrWaQC0+pqsh+g3GkdV9tAh4e9y5Ny09H
	QmbuhRIUj+dAvVxuVBBgtZ9YBA8ovNj2u3SrOVNzypBw7DDKdubqR5u4M2fjbRS1
	QzFz5pc27l6HDiXqTN+V4tAif04w2hrpW5BBdoTzZAVD8fUTtpZLusS9QRCdyyBv
	v2qspuqjA8RQWtN/lUDPfXLDY3LbK+Y1je35fUz2FA==
X-ME-Sender: <xms:6MHNZmSVfOWQsqcdD-iRvAM-oaFObu-wxbR6uQbKZBuS4P2vpun7Tg>
    <xme:6MHNZryPaVzgo9ZX9TbjpYBGM-e3iHnkU2q-kls6PXeTASlPW6c9ipUmXRnt_VZGT
    QhBTZI-_1ww1cETqQ>
X-ME-Received: <xmr:6MHNZj1zxbDbhuYbuxMyfGZhDIkrMIPVicRSyLnfwlK3G32WHsu75rycwFmlgeGjvjsrO-WID2qYnmh1KHdFXkqA5p2ryNqmWlsMreHVwqENAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeftddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:6MHNZiBLuhAT8gfL-bBTjqTch857f1Ft1O9anckrP9_pIUVFOxPuPQ>
    <xmx:6MHNZviAlLxOtarVbqlX2Im7IuYjPmPZrhJnKA1YlXHvGNxrGWJi_A>
    <xmx:6MHNZupVoCwrZRsmaJEhQkLXlGVlzB3i_W9FvjqlF-OTtosStYGMWQ>
    <xmx:6MHNZihiyp-2uKc7ihQZ1XsZEjTDtJeHn3UP7UUhjFFOHDYKcb8mcA>
    <xmx:6MHNZiu14fNdrqch-JThD7HyCvAB0WRAjzNU_6nk_5piis4f1HIyfcjn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Aug 2024 08:09:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4bb512be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 12:09:05 +0000 (UTC)
Date: Tue, 27 Aug 2024 14:09:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] git-config.1: fix description of --regexp in synopsis
Message-ID: <Zs3B5NwyXfbo5z5h@tanuki>
References: <xmqq4j77jf1i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4j77jf1i.fsf@gitster.g>

On Mon, Aug 26, 2024 at 11:48:57AM -0700, Junio C Hamano wrote:
> The synopsis says --regexp=<regexp> but the --regexp option is a
> Boolean that says "the name given is not literal, but a pattern to
> match the name".
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * t0450 strikes again X-<.  This should pass that test.

Thanks, this version looks good to me!

Patrick
