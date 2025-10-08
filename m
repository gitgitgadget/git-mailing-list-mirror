Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B0829BD9B
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898776; cv=none; b=n3kNeHD/cK5/cQu6qjzStqsW6XHv4Zdj98a2TAgu3frLeQdnzNbJubTQilt5SZJO5mpoqMt23OTCgPD5bfiBShwfeksRZvVqA+s3j8TnhgBkZ6ZQuo4Wd/d0DAdrMe5IqIMgfTVa/mgBEAjUk41ufQPxkdl/KAzdNMzco5ZDkXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898776; c=relaxed/simple;
	bh=djCA838lECLtQRF7X+bW7fooB5fJ3Vymc+Yse87UGT8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVu/S1X9vu8dCD0iifViIZvhc4fWCfjksMwP60uJJ5u9+LpQygpw/QHiRcWXyS1zbtqx1BI7yARSxCEyWauM97qJqIN+Hr45A8lNPjCvsSG9XskbSHf0AvoImo5j+h7RfEf9duadXaIvkkX9uC1O0qAryHhRkc8zcKb4q8WhBGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=My7SLgD6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZPIA1mDs; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="My7SLgD6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZPIA1mDs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 394537A00A1;
	Wed,  8 Oct 2025 00:46:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 08 Oct 2025 00:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759898772;
	 x=1759985172; bh=w9nZiVDL3Oa8hXvT7pJhCIsU17ir9Jy8fQpHJM/SplE=; b=
	My7SLgD6IdoB1xf5XXsvLkQEsoZIC0Yq1RKfAcHtKC5wN1kG55+crgIcznftsdYB
	riAm6n6YLusOr/H0eZI4CeSjzvifY8NxNAvNdsPavb4EJQwTQu+waRl8RqijXPfH
	1BCedblFk252jhbus3wxXAd5FydA3xQaHWDX+nWtrGiVZmNteLv2237l43BJ5uzA
	BPz+4oKH4WdCgd5S8Wmv7ebVtfBUdhndYKH5yBly0liqKWaAa5QuOuQutc88QgRh
	m+BZkmgWRibu1ogBL5Zg7de6zUyMoETiwYvEzk34pwplJHJ2Mhk8NWShexKUamdC
	oxHF/1IBuFCo4AgCiUQqvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759898772; x=1759985172; bh=w
	9nZiVDL3Oa8hXvT7pJhCIsU17ir9Jy8fQpHJM/SplE=; b=ZPIA1mDsMZaKU5/L2
	9MUmclpZ6qwY3B/FsGZTip/Cd8Vkk18NRzbd+FTPL94XXKE9LY0IXob2OsVnxHed
	Fl/p2wfFJfmPwSxMuQqbTpfWRJqETvZIpOdG5uKGakS/pAWF3e8ia5eNMYwkpHPq
	f0/S1e/FR3YZilbT5QfcOvMfjoIwHdUOnpTY7X3YlXR5R64SryhrQ6HfeTFMZ0JE
	qo7RN0oPJwoUESTV1zU+aZ9NK3doOh+Xs+heV4NEtkDkWqu6ZhJjnevuHTvcj7bX
	ibdOv5vvuDOEQZQKO+Mtdjw0HIBb+BXA1TDGcYaZXWXt4Jq5OjxAIlpMaXO7k1tI
	O3EFw==
X-ME-Sender: <xms:k-zlaMMWa-WAUHsm9tMXCYnE-8T5V8Fq_TRz6R51E0UDpXdzfO9POw>
    <xme:k-zlaJ3J_BUEQblM99OFWETGpVq28q_TA_NzsvFSJvGjxktPnz24nc_pgeqqh74SB
    oyvksYmq6YBFdfmBUqmLjxDumJq9PLO59XaXyIGkOPuEU1EDQsn_w>
X-ME-Received: <xmr:k-zlaLl4kx-MfkduqlqUoxdHm3x2H5FSJvC3NB0pYMYqzOylV6UY3mIqXRzjEdTxQgVCcC_l3lm3pXGrh66kqK0Rv4vXGfVeBQEiohUR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvffukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epleehfffggeeiueefheeitefhgeevjedvvdejtdeuudevvddvtdektdfggeejffeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegviigvkhhivg
    hlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghrihgtshhunhhshhhi
    nhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:k-zlaAXHbS54SB3uZA7tCMTT75nH4xzLmXhuzHjAoEQZguPg5P21VA>
    <xmx:k-zlaBv4PWnI32-JgzXNVh--vJMFJRblEdAl5IL-4HLH5ir6jPeN-w>
    <xmx:k-zlaDY_K6N4w5xt7Jrx3ocBYAHuNkPlg-icwZyQRADFGiSgVMtuaQ>
    <xmx:k-zlaAW2NcQXyZ4h9Mm0Uf9RyfUvsfQ3B0MpYcpmwSjVxO5_0BMfoQ>
    <xmx:lOzlaCS2bnuZQi-f8gxxf8bhBXI7SeVugN_eKeQ_hm4oWqnxLeRvc5t->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 00:46:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e799531 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 04:46:09 +0000 (UTC)
Date: Wed, 8 Oct 2025 06:46:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <ericsunshine@gmail.com>, git@vger.kernel.org,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] ci: check formatting of our Rust code
Message-ID: <aOXsjnWBOt0qFGwc@pks.im>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
 <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
 <CAPig+cQ7xJky+F=g=NMrN6BQfP+ZV2KF4RF2eLqtULKgMTR5_g@mail.gmail.com>
 <aOWXSO5GInJI8-NZ@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOWXSO5GInJI8-NZ@fruit.crustytoothpaste.net>

On Tue, Oct 07, 2025 at 10:42:16PM +0000, brian m. carlson wrote:
> On 2025-10-07 at 17:13:18, Eric Sunshine wrote:
> > Later in the same thread, I wrote[2]:
> > 
> >     Project guidelines have long suggested 80 columns as a desirable
> >     maximum not only for C code, but for pretty much all other
> >     resources, including shell code, Perl code, and documentation
> >     files. This suggested maximum works well for adherents of
> >     80-columns and (presumably) hasn't been too onerous for developers
> >     who use wider windows; at least we haven't heard people clamoring
> >     to increase the suggested maximum column limit. As such, it does
> >     not seem far-fetched to expect that the project guidelines
> >     should/could/would also apply to Rust code.
> 
> My preference is actually that we stick with the default.  I use (and
> for a long time have used) a 132-character editor window and I find it
> quite useful to have the extra space.  The DEC VT100 did 132 columns
> (available on your local Linux system as `vt100-w`), so I think there's
> plenty of precedent for that being an acceptable width[0].
> 
> I did previously use 80-column terminals when I had a tiny laptop
> screen, but modern display resolutions over the past decade, even on
> smaller laptops, have made it entirely possible to get several wider
> terminal windows (or in my case, tmux panes) on one screen.  One of my
> current tmux panes is now 213×54 and I really enjoy the extra space.
> 
> The default Rust behaviour is 100 characters[1], which I think is a fine
> default.  I won't be enormously angsty if we say we still absolutely
> must stick to 80-character lines, but I also think we should take this
> opportunity to choose the Rust defaults for Rust.  C, Perl, and text
> formats like AsciiDoc do not have rigid defaults about indentation
> style, tabs vs. spaces, and line length; Rust does.  We wouldn't use
> tabs in Rust (the default is four spaces) because we use it everywhere
> else, so I think we should take the opportunity to use the Rust defaults
> here as well.

I am also slightly leaning into the direction of sticking with Rust's
default of 100 characters. It's not substantially more than 80, should
be reasonable to accommodate for in most modern setups, and sticks with
what the remainder of the ecosystem is doing.

So for now I'll leave it at 80 characters. But I don't feel strongly
about this, so if there is a majority in favor of 80 characters I'm
happy to adjust.

Thanks!

Patrick
