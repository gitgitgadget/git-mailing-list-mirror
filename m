Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA622DFA31
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843599; cv=none; b=SVpqgGlVKB+42GGJVvvdNCsyHUphNQtzcM/hL42lIYxKzwFSUBJoZ6O7QbasToNasnSkniP4kzXFsl3HuGN3gmP14BwaYQvrWH6rymqsFXV0nQTLk8PKoLCLm7rLDDactNRaaCKnShjM0lSiNW/NlSJoDRRWXfIF9PY5uju9FMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843599; c=relaxed/simple;
	bh=tqK1H3TlAhdGk/q0iCZZPWKrZP/xocI9v4lUJl1yYj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItcyK1wTFvNE0/W7DDXVe0hsCWTV+O6gJcRatNiSnR88g4oQT/U6rPrfaLK6rebY3wwu5l1QruA/x6HyzCL981+Ix96568+ci4OeVKm4zEX+qMTQu0Kfzmz3KUT9SDP/gk7SFolTW7658S+A0AyiqVl4QtkJ1stkiAOiIElrXqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DXAQ4A4Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wUyK5Iib; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DXAQ4A4Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wUyK5Iib"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E806EC0300;
	Tue,  7 Oct 2025 09:26:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 07 Oct 2025 09:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759843597; x=1759929997; bh=ScV/OD1gu9
	/3XXG+b5EROKonmONLdk6i09kn54DCW3k=; b=DXAQ4A4ZIn48T0KEE/etHr0OS8
	IowrnbQw/IbCOxteNRmarCehoDqPXHYnM2oPEhbvuCBgwxOxb9DuFZbB6uU+GgOn
	youOPx34IjGi/e6nd3zyZ+1gBrSV+9Xn0acV8l2FzmpbpBKy8+u+1UCb4bdXFBCj
	iMxkIW0l0OWmOVVVzXohE6tZoUhF12+2nxSxR3VMwDYFbgcKTQvfCKE6Cv3p7Z75
	CHNAFoMY0xqOpM7CgQx2UC4GRn3QjHBk75vY1ok6R1K64R1gsqIzD3VMP1QFdk5V
	jn0Fv0ppg28raLDapjx0EuUtMUdPHmXfnYQH6NyatuSXx25AMm/AJSEL5sPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759843597; x=1759929997; bh=ScV/OD1gu9/3XXG+b5EROKonmONLdk6i09k
	n54DCW3k=; b=wUyK5IibHMYAOJcmTCg8KRcdXQUR8wkd91WUpbGH2jAXd8ps/4X
	VZTpaus82EvvVcBWyAiVAKjzZ6jmTKiVE9BeFLi/SA+6YhO4xuq830d2DS3wxhn9
	9wjz49UI81YXHluTq7yybevMIHt/A0FEYkypLi2Er0B1JULu4yyyiIZ674f/Oi/H
	A0r/FHbmeVbRWOXGii3j6IKbAjsyb9CR8eksCheixqPF1X8zyDv7S+w+iJ0uNyKl
	xsU68cpxS1pQDFDXvYBd0q9swwZcia8qA4D1vZYPqd5SFx0ucjy2mAeprxuikWxT
	o3eI0utVHo+4E3Mj1P/Tq2o7ZaaaRe0va5g==
X-ME-Sender: <xms:DRXlaF-j0Ia-HhC4NnF45Cd1lYlMSIyEjjWdHf84qOoYqCgW9JxG1g>
    <xme:DRXlaAuqXzpbYfpR7uu3Q-XCvA5BUXk6z9clRictd25nibhT_X8Qlk9qu3-f1HcN-
    6TU6SvC2PvHiPTNQfRVxg1nsDZ2nndNW_cOvxihkEp99Q3tRoVv>
X-ME-Received: <xmr:DRXlaIBWj4dG8yjRxQf1GRUNu6UosAaY800Gd5tNrbVRuoerxSONMRvzvJ7wQfl55y00NoJuLB3ogTfnGqp9YB_k8vUcJYP2hMtXyZ68_-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:DRXlaIXi3habRjusqf01SZnbdGrENwPzWsEZbGxYJeTvuRIyJ5caCg>
    <xmx:DRXlaGAmR9IYrn97XPGIgPgfyvP_BUwDBdw-lag9CgeDSYLxLJ09yA>
    <xmx:DRXlaL_k22NreUkNGtaQQ7icKdcA5h4yHbsDoHDHEhQGickGb8n_NA>
    <xmx:DRXlaNESIx6D1uQEcqJThgdW_SB9IANva6LNvQN-FUNLa9595t4FBA>
    <xmx:DRXlaL_tD2iPQ3DTQhcXzxiqtgT3eiXmWWVBzIAlmhGCs4vKhMpW6An5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 09:26:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 59c08b8c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 13:26:34 +0000 (UTC)
Date: Tue, 7 Oct 2025 15:26:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v6 0/7] refs/reftable: add consistency checks
Message-ID: <aOUVB8hfnYiBm1V2@pks.im>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
 <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>

On Tue, Oct 07, 2025 at 02:11:24PM +0200, Karthik Nayak wrote:
> Changes in v6:
> - In t/t0614-reftable-fsck.sh, create branches instead of root refs.
>   This worked becuase we don't have reference level checks still
>   implemented for reftables. Let's avoid confusion of a breaking test
>   when we add reference level checks. 
> - Link to v5: https://lore.kernel.org/r/20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com

Thanks, this version looks good to me!

Patrick
