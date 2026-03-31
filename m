Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCD3B1BD
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991387; cv=none; b=deYHu9twBhU7gwEO8l/KtlHQNQIZVDnwSauFdEA6WMH3mFYqaCdB9md46thufFFZxrhPU4EKTt9mjrqSlKfuQxk6euE5clTK14Y7F+XqBsdnJ0aloIyrCgsdEA0Gm+pIGzLvPmulrlulDv6tALfH5I4OLKORoZsGAWKO2OYEikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991387; c=relaxed/simple;
	bh=HBVoVt6nLd7l8QuPsQtOjqTRqSx2SfPC/FCBzm2heNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V93oEH/XE4sjM+YxW7HUiOngGw3rgI7sEUVEY9taaOyi1Vo5cg89MT09LK1+kJWxl5Gqwk8zVM0n1OOTBjZ8tCLgwljaPkU5prC5gF3LLf/73GZtupWJ8/9CGqFmHN0+67eOZTq06pGLh4Zx5/RRkDVAfwLZKgvAS7UipV/H9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PyJQRMi8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l1nLyFVN; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PyJQRMi8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l1nLyFVN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6275E1D00197;
	Tue, 31 Mar 2026 17:09:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 31 Mar 2026 17:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774991384; x=1775077784; bh=2HyY11CbGC
	fOtIpTIQ50wSEWQTLMW2yNWaXjEJFZ5Zw=; b=PyJQRMi8PhIWzMEC86wk32O1YP
	ET+GuIdC2VCjG+tP1Qug90YTZfOFmoh/RcMDV8PaGqRLBbWgMssYlbfPwRdRUWrm
	e6CTTbT/v9NTcdrLqqNSpp+x0u/INKPhhOvmsR3CFXF5VH9c9+e7tIHXrLv3BvWw
	+d6mC7ht93AJApfHjfXfRdzDhedECjCXliuNXYj0r9oWe9FNzUjQJTEx+DxLySip
	6vK98xS2gmIEBHC3wzUIz27E12sAamD+w2QqSXFoRZF1e/djRLjVNQZB8cXX3Ruc
	AKmrs3stMdtWPLumh/aph6YHKe/qx56j3bsW/uI8IRwqYEUUN89MDtc7DtDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774991384; x=1775077784; bh=2HyY11CbGCfOtIpTIQ50wSEWQTLMW2yNWaX
	jEJFZ5Zw=; b=l1nLyFVNhvuRZtNlly1sQZPghI5SJakr5nBZvDDXXnSPs1TW//i
	61QUtTRK7NwPxIdi/+DR8ZShzQexxZ1c9j0owe9nEjwAYo3bDyZu0c85D52w2I1M
	FJWvMTEyGiCojh8+Se0mQZvJI9tjc9uH7+nWsXQgMoXS+xEu0idbbH3QqxmoYX6H
	8abv2eLEbXtP4Q4ZZIWmfRr1iFfBS1EgjlkDEXvG9mmye7JyM6+/CN1xy0SJ7GeB
	Wy+6v2pqri7Tmg4vltSP0NbPp6HyFM1EaX+NwQp57xx5ClZeP+SXa6gmEpw7/iFv
	z30UiN7koxkP0pDRKWNigqBHPo2rjjgdIbw==
X-ME-Sender: <xms:FzjMacHhb5rKIVaiNfthN1vq9MwmNe8IZER7RM1r2-tcyTWGrLnwMg>
    <xme:FzjMacNrj91_zZQAMVTetVdCdsAkMiuIAt_E4auHrXugF9DW1IQWhPd4YY9PrVDdm
    W0TrQ4LTLdxytFp_SYWFADYJoF2b6wtvws2FKjGFWE-wt49MHMERQ>
X-ME-Received: <xmr:FzjMaeemuEV1INngHVCEgCzDvU_tpduEm3NJuX913r6ddUPDw2HgxbNNNzD12T1-FnNc6N7U_De-UrqIfc251vSvsVMVaH8few>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffue
    efjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhg
    shgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FzjMaZvEJ0o-Ot_rPwjTDFadafCJXt2sTAaT5C0JDFi9rOgLFPvaAQ>
    <xmx:FzjMafm0iyvabS58pGukODbLsg-K42MDdR7Mpolf2g9TcChk62REPg>
    <xmx:FzjMabwdnNYeo1nsuVeFC2OeXrOheJ3muykfzyGgM449S3VImTqL1Q>
    <xmx:FzjMaRPZuGoHDJmBX5LDCTsDdZ8BzIw94PYZOnII83dVOGEue5uRPw>
    <xmx:GDjMaSX4G9FdQompvPjOGhmMYf5IROw9QJ6XB2W7DmzIViItg_VXnsyP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 17:09:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  ps@pks.im
Subject: Re: [PATCH 2/3] doc: gitcvs-migration: replace config -l and rephrase
In-Reply-To: <gitcvs_doc_link.54c@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 31 Mar 2026
	22:48:09 +0200")
References: <CV_doc_deprecation_config_--list.54a@msgid.xyz>
	<gitcvs_doc_link.54c@msgid.xyz>
Date: Tue, 31 Mar 2026 14:09:42 -0700
Message-ID: <xmqq5x6bzox5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> diff --git a/Documentation/gitcvs-migration.adoc b/Documentation/gitcvs-migration.adoc
> index 1cd1283d0f8..905d08cd5f9 100644
> --- a/Documentation/gitcvs-migration.adoc
> +++ b/Documentation/gitcvs-migration.adoc
> @@ -49,8 +49,7 @@ them first before running git pull.
>  ================================
>  The 'pull' command knows where to get updates from because of certain
>  configuration variables that were set by the first 'git clone'
> -command; see `git config -l` and the linkgit:git-config[1] man
> -page for details.
> +command; see the subcommand `list` in linkgit:git-config[1] for details.
>  ================================

OK.  In this step, "while at it" change is also sensible, unlike the
one in [1/3].  It wouldn't have been time-wasting if you sifted the
patches into "genuinely, move away from -l and to 'list'" changes
and everything else, as the former we do not have to think, while
the latter we do.

