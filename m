Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB493815F1
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770654880; cv=none; b=eVJCRVIDNSUVWZLAxuAbhLsmyi6Jjvl3PC5tuNbNxoLyjFUZiV2u/DPdJfGkWvsEhpgGp8xTm347C3MH9Gg/1l1uBDBEzDKPdO2DO+9EVyIiiKWUfz4s8S62Qd+XqvxK/BFFHUmmPOnlkWwujcz4sQCnC01TgeMhI45BLEHcODc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770654880; c=relaxed/simple;
	bh=Gz1uPdvWqRdzZ1OToPXQrXYr2doLBHzsqarzNNT/2Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyoHm5Su/bQGe+Oz0ZWHmi5TDcRm1FQ/UqbaC/bu1GrWEIzCuqqbjM1fpNxbFBeTiL+TX/66AWWHby8Oze0Dvtgw5Wls7tHRtVv+vlApKZs+fcIT5jkMZdfQE7WbxaO91JqKhRiQ8N945bi9agTuIERu4+DYohEgsuyJ4dyvs1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TjEtM+eh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jPXbbqaO; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TjEtM+eh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jPXbbqaO"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 91D231D00231;
	Mon,  9 Feb 2026 11:34:39 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 09 Feb 2026 11:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770654879; x=1770741279; bh=Lc4HThGw0u
	SVF9OsCKY2eaDzJRltKYTvr9sEzYjh1RQ=; b=TjEtM+ehQXnCIoyGuovfeZLk8R
	qgAnzQkdgNp95AeFg+JO6FtUY28OdTisWV7R4LZJUxxc4Xcvt/wOJlfa/fi7M66T
	RZmC5aaJlKc8pN3qGXbBy130wo1G3FPKsjn0NFnZh18cUUX/V8Vrd73cEK/qWNIJ
	JW5whvKbncp/7MuHNnbM7v27XuKH8i+TYRo6ARypRwy6mtfudXX9+tObkIng/Tw3
	AU+8beMaAJl5w0xitCY0roYYcnK/O1gdl4HQoDIB1DZivDTogFqfObFfGIrDJCPp
	eATk/QOxhu4xnyOzRNLrlvLeO/2+ByPmDMfVnaroPIjRnee3yF2ezjwYpPYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770654879; x=1770741279; bh=Lc4HThGw0uSVF9OsCKY2eaDzJRltKYTvr9s
	EzYjh1RQ=; b=jPXbbqaO2ejj4zYmYRi/dFV9j7FezWeavFER9MA+OXKq2Jhl55L
	YML33rDlXifgTfhKzIbSHT+hO1pxcE/bQ5UcMaWbOGHJ7iI1X0dPRrn/6G8e6kFW
	Fa92KWFyOPooqUAk2SgbknznMLelAoZ+fv+1qrLwGQOHofFHrEtE6MyTXzM20KRw
	s4yN5mtH+5ykU/5y4r/kVuaoUlaDjLwxuADPBKMC+7m7Xza0ton/zLuD8QIweFLX
	nzB02aPnFgKSvbnkXuLFuBn3uoM+4wBIxqDDaKzWTsZsob6PKmoU3o4j0ahqJXYY
	tIlCBBvGuIUmNp+ykE8vD153bl7zgFfGKzA==
X-ME-Sender: <xms:nwyKaUQWouTtl1YVkxuTs16s-LpwdzanYxkh_2f8Y9g3ii9_aFrggA>
    <xme:nwyKaYxT49p9jwORBgwQTJAXdi3je4qrEIhpff7QW4aoQvYj-srJOBDt7-urLF5xJ
    810ZMT24FjDtCJPpYA9tXqN_2aW9wDEHkOpJssImHSWZJKQcGiBqw>
X-ME-Received: <xmr:nwyKaW1o1Eo4oMnBIaLyLVnpzyvvpJbgr4W6xjK7KgEkcbGxyfy8Ug3XtoyxndH4NPQLhp5zQ6uEdMdp34dajtHuR2clGf_eRR26KcoBxso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevgfduudehiefhfeekkefgteejkedthfejhfetleffleehgeduieejtedvteehnecu
    ffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nwyKaW5y3lWEnggHXCRjQD7xm0LaknxbdtgNta-lcy-g8to0e5QbAQ>
    <xmx:nwyKaZXCLvluo9qr1JVoV8dGTyS7lpnp0SdG5fY5fKqultJjE-ta8Q>
    <xmx:nwyKaVAFrQE5k2xsblHAOjiv_P-By92gv6-2gVB-lL9XdY_LlZ7sAw>
    <xmx:nwyKaY42HPfHbiTgjVml1w0eDolgMktVzmpTxAtKxHcJ8p-Dlg6tSw>
    <xmx:nwyKad0JkaJbpT7ZLk0P6MbqtqQsuUJS9BQ0WQ1i-C2ehbbph9YHpi8w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 11:34:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8f22a03e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 16:34:37 +0000 (UTC)
Date: Mon, 9 Feb 2026 17:34:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	gitster@pobox.com
Subject: Re: [PATCH v5 0/4] refs: allow setting the reference directory
Message-ID: <aYoMmhClPzdmLjII@pks.im>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>

On Mon, Feb 09, 2026 at 04:58:17PM +0100, Karthik Nayak wrote:
> Changes in v5:
> - Moved around the commits, to ensure that the code to handle the config
>   in the backend is first. Previously, we added the config first, which
>   meant the commit allowed users to provide a URI but it was simply
>   ignore.
> - Fix typos and grammar and rename variables.
> - Clean up the description and documentation to actually specify
>   protocol over location.
> - Avoid an extra memory allocation by detaching the strbuf value.
> - Link to v4: https://patch.msgid.link/20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com

I've got some more smallish nits, but this version looks mostly good to
me. The one thing that I think still needs to be extended quite a bit is
the tests we have. The new feature has quite a broad impact, and we
should at least verify that classes of commands work as expected:

  - Commands that create a repository should create the ref backend as
    expected.

  - Commands that access refs (read/write) should know to use the
    correct location.

  - Commands that create worktrees should know where to initialize the
    refs.

  - Reference migration should correctly migrate to/from an out-of-tree
    directory.

Thanks!

Patrick
