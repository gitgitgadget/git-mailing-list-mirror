Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AECE17E0
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415685; cv=none; b=HE7Z1uegGWNuIGYft+AdbhpC0m2x+I0odEbWg4QlW0ddKoALlBrBosGd5OXkSaw3qpTIxpx4tlXqM2GdPx2cPYPZZ+iURsAdXvIEeT+MhrVCbBxcf2CRdsiJseqTMoiCRLeIevPnKcQGBx+Io0VeLhTLVxdFDfkfIgaNSyT/ZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415685; c=relaxed/simple;
	bh=7q8XCiM5Rz446PgxTpt96X63EfGSIDdX3pIJw1fGpno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIS84tnSHt5uGz6EnpV+OZPoZsZx53q7G/v3yAYQjt6NLp+0Kk1fVO+zrKFQbjZRrYYM3oB/M3PvTRU8YXRDsYihJgqyITOukkVpdr3wHdfr+3TxMPAlXukfzP/KgcFcpQAarDYBtUeidhToYabLOKnmHDZdL+XiPli3QDc4Wqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PKC2NxfN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WyeQJItq; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PKC2NxfN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WyeQJItq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1AEF1EC08E5;
	Tue,  9 Sep 2025 07:01:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 09 Sep 2025 07:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757415682; x=1757502082; bh=dHujSVQxoy
	QVBrwqUbqE83jHjl0VE4QV1/PaX0t+89s=; b=PKC2NxfNIjUYxo6UiEcIyKxQZj
	+DzzGamF76a3IuE7MPJfO177dz0NUhTVx9wpDo1G2q8dv71bvCoA8PEgMJ5MHr1r
	1sSsj8BIK0UtlaIzJ7I90Y/T4n6eampVbCG1Y2mcUdaF+ohSA57FtW2dyNlyUGo2
	Xeq+kQyX6e7BQKwRnMwuCEvCzIeagulObrGQ94DNAODgojuj7oXiydghuUDwSbOj
	ufzdTAJh89L8VSSxtGO39/sT1TbAXkbby/rVmSzKC5s/5lAYY8B/pFR5VkY4v+il
	/71Ct0fz+QMD8uH7DhUti32k+C85Kzo4uefgxMxrSCamnpIw1UMS7GYvKoyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757415682; x=1757502082; bh=dHujSVQxoyQVBrwqUbqE83jHjl0VE4QV1/P
	aX0t+89s=; b=WyeQJItq2lpLNpo6oe6erHzJK+0od1tqUTS/FkXKkLarfoPKfRd
	C0wiEY/gQggFHMCgP7oK0m/QKM36O3tF9JsACDvlYUVccRBwp9JwH3uE9I6/YgpA
	cHgr5Jo+xeo7Cc7Apa8JikzbmjbvYL5RO3I115OLMLdT+bi4DPJmxDYmbR36Vudw
	UtEVjM+qjvlm/Z2r2St4mD46pIuQLE8/+ObvBi+OBMYBUZYsKCFxBUY8Cw1Pr+jl
	1A4zugaue6IWG0mmBTbHdtmynOf38m8kfKWhMObUI5NEuNWcEtWXu0PrITEECbPk
	7nrnwb6YILF59jl8xzthboqjRfye7bjiNtQ==
X-ME-Sender: <xms:AQnAaCAzpXGAeTLUaLQ2CvgF9gR2YLl5pYi7BqwvrxzwihNpKBJ80Q>
    <xme:AQnAaIAX2FMrURZoOw3YCGeyciGz6rZY4nC-Mz9xzTqvt_SGW7EhZkNLy6eNl2XGJ
    vv67xdxJX5Hsi0fag>
X-ME-Received: <xmr:AQnAaMArwAfE8PoOw5FkkmG89Z9grHJRxXZuU0Vnma-M_5fmgiDjpJsFi2p8sYXfO6-ExMgHA2IlCWhCNthDjqEsaMLYM2FW8GMN1RA5R9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:AQnAaLrdNv6-zNUIWMpExBLNZHjsM0zAziE4yroBrZbG6tBIsFQ48A>
    <xmx:AQnAaOndBUCFN5j789LeK959l1Pr13RD19aw0R10mUE77YU9XkuJqw>
    <xmx:AQnAaDwa5H6oadMMojwNEbvxOMf9E8FNOS4-IVnsbqupJfBsUY1zQg>
    <xmx:AQnAaO9UciW3ix4JYgLx38Lgl8phGvZe07AzcouuJzeG2efrYxn28w>
    <xmx:AgnAaA-JID01dvusCl3COQ0DSgTvsbsirKU4GmSqcBrw7I5xZe27sMpM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:01:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 81456923 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 11:01:19 +0000 (UTC)
Date: Tue, 9 Sep 2025 13:01:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 04/15] odb: move packfile map into `struct
 packfile_store`
Message-ID: <aMAI-Gv2zjb1OOaP@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
 <20250902-b4-pks-packfiles-store-v3-4-6925278efeda@pks.im>
 <CAOLa=ZQgC5LgVCtjVyfd8xeTajwWon2YQDkwVYbK_FRaBP2o+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQgC5LgVCtjVyfd8xeTajwWon2YQDkwVYbK_FRaBP2o+A@mail.gmail.com>

On Tue, Sep 09, 2025 at 01:22:33AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The object database tracks a map of packfiles by their respective paths,
> > which is used to figure out whether a given packfile has already been
> > loaded.With the introduction of the `struct packfile_store` we have a
> > better place to host this list though.
> >
> 
> Nit: missing space after 'loaded.'
> 
> > Move the map accordingly. `pack_map_entry_cmp()` isn't used anywhere but
> > in "packfile.c" anymore after this change, so we convert it to a static
> > function, as well.
> >
> 
> Nit: Okay so we move it from the header to the '.c' file, since it is
> only used there. But we do loose the 'inline' hint, we don't talk about
> that. Any reason for that?

Good catch. The `inline` hint didn't really make any sense in the first
place: it's used as a callback function, so by definition it cannot be
inlined anyway.

Will amend the commit message.

Patrick
