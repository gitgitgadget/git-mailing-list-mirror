Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F014F70
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415475; cv=none; b=uaS+NJAR3s84fUhTcPKPSkft2GdWWSVTwCvyqQ1/DEHxGb+YGkxL7ObYRp/xWE/2YUp6idZqE/5Xtj9Wkc6FguFYVq2TkSjCDwQVJJg4bqeyQD9V7gwkvSIsaB1/3ZN5sdAS5T5rl8hDAk+lkzbu8V0a0H8C4/abBwRMD1kHjP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415475; c=relaxed/simple;
	bh=5oq6M644BpfxQIILnb5h0azugT9iYJhVXuZxi6ua9BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4XFa8y8WcORMxs76SEI7+JGUoredQPVlobVoOcry8nFyk5QmlykEm3yRvJWU/chU+3hLmujN859+tC29y/kcfmVw1cAPojxV0cA46RZ8IzhywYHkBoViwkzEFv8heD1PYiLNBq3tcomUC65d3xV9P24fdRuPElisSVUUDO6qaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OFPblUHc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b/9L22Ju; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OFPblUHc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b/9L22Ju"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55BE114000CA;
	Thu,  6 Nov 2025 02:51:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 06 Nov 2025 02:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762415472; x=1762501872; bh=vKkFvDKdq8
	bVkcFZzowr2ugKg8SZTScoMZ7Hlu4JFl8=; b=OFPblUHczO8JDjOqlHn4nVt/Cv
	O9GeD0mRIDyWAPiSgkPKIGBt6t/yghXaNa7QV+AZzSGNnWM1Bw83cl3gXYjtvUfi
	qe42d1kO2EUQr4QWv4YRmN/Kz5chuYIhHLCj+nBxd/QsFw0EMDaxrvz3v/lOOfH+
	ylrGIdOOvFefOFDC+ZOxtWK2dGsbYlVHPzd6Nnt/cRN6hFc8THy4CV+P7+VRnGOp
	cd3Jevgwtwnj8esKIrvwjJzVF88TdIkpxOUngdHn8siQI7w0FpIa+84pNct2h5sf
	hzc5SScygZQDVKNOe1PHGFMVBjIUrYwVtLG2+6hVw1Wh7731vjLYHW03F/mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762415472; x=1762501872; bh=vKkFvDKdq8bVkcFZzowr2ugKg8SZTScoMZ7
	Hlu4JFl8=; b=b/9L22Ju5AZq/aGL5RzXedisc+ghBPP7xZbxdbF3k2wKIlfrBW9
	X6yxmwkxrlQVpY8gNiIKp9GaVab8QqSGwZQrdM8vX5fIRnnkWtcLPNKrvX8NBu8a
	+lZ2yCc+6r2GF7zdTEDxguIQioXLU9tlTbX0Mb9ogerYOXoXgM97m/VhM/7ooMx0
	MxmzxFKyPbrguHYULZHoeGCJk9SBLfJIdDybYAQsvkzENJ3IOq4LQakEOqCzXPnd
	5ZAEoscY/NuguYWY7rPYhpJu6FGHyC52g8YiBnsBxVHBfscfivEjK7idPGOvseyD
	2JsVaoJlqeHNzfCR2xDR4DTEezwi9azcUIA==
X-ME-Sender: <xms:cFMMaXRyfDFp0DnNV-wwU1zoglU8c3W6JIN7IPnpWPn-c-H9oxaTAQ>
    <xme:cFMMafyz7170iV7TPs_rleczZ5dKk5TZEWJU8LDNUUOrpmkwST9jJ8l7dWFZTESxo
    bvXY88Tlne0v4rbVvIBp_GlVqPXXcTaKYxuYDODJ7i_h0FND7JxjQ>
X-ME-Received: <xmr:cFMMaR0Y_qnCTYD0g3zexEqVQ32K-BlB6P33O9ZnsWGjR-PleYMT7_UwRau412DnYlxhXlHCn7K7xPrAmL9mGG-jICYWBNeybJak4x3JgBd_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeivddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdortd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffveejgeduffeiueffvddvleeltdefvdevhf
    efhefhueeuvdegheegvedtueeufeenucffohhmrghinhepmhgvshhonhgsuhhilhgurdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepph
    hssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehtmhiisehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:cFMMaV5gtuTwC0Mv-OOhmFKJz4vJjL9W5oyvVQudgGI8LabHv_T0hw>
    <xmx:cFMMacWxJESMyV3iwC8j6VInxd8Livlnfzl0Q6fyYlvXk_dDvOo7vg>
    <xmx:cFMMacD8iAHlmPTWQU1M6AEcGlIXF8y1RFzR5IGxrO2r6-mMG_K-3Q>
    <xmx:cFMMaT4xU8Ol5LA2THy4P9oe_Ohwhcp_-b6ivt4H0pYBnmNdr9yOsw>
    <xmx:cFMMaZWk6OH0eG47QSHsq_teVObFJqj0zw9mBqMdRgzX4GB36floJwsP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 02:51:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c43a71ab (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 6 Nov 2025 07:51:10 +0000 (UTC)
Date: Thu, 6 Nov 2025 08:51:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] meson: make GIT_HTML_PATH configurable
Message-ID: <aQxTatYlnSJwNjta@pks.im>
References: <385992f6020703558f0ba75a1be6c4f9dae08b83.1762264709.git.ben.knoble+github@gmail.com>
 <xmqqms51rhbx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms51rhbx.fsf@gitster.g>

On Tue, Nov 04, 2025 at 06:41:06AM -0800, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
> 
> > Makefile-based builds can configure Git's internal HTML_PATH by defining
> > htmldir, which is useful for packagers that put documentation in
> > different locations. Gentoo, for example, uses version-suffixed
> > directories like ${prefix}/share/doc/git-2.51 and puts the HTML
> > documentation in an 'html' subdirectory of the same.
> >
> > Propagate the same configuration knob to Meson-based builds so that
> > "git --html-path" on such systems can be configured to output the
> > correct directory.
> >
> > Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> > ---
> 
> Makes sense (a more meson-minded person needs to double check my
> knee-jerk reaction, though).  It is surprising that 
> 
>     $ git grep "dir', " meson_options.txt
>     meson_options.txt:option('perllibdir', type: 'string', value: '',
> 
> has only a single hit (now two), though.  I thought we have a lot
> more flexibility in our build process.

That was a concious decision when I introduced Meson. The discussion
back then was whether most of the build options that we have are even
used anywhere, so we eventually agreed to only add options on an
as-needed basis.

> I am also a bit surprised that these things are of type 'string'; I
> somehow was expecting that more modern build system would offer
> richer (relative to Makefile, that is) types like 'filename' or
> 'path'.

Meson provides tools to handle paths nicely [1], but it ultimately ends
up using strings indeed.

[1]: https://mesonbuild.com/Fs-module.html

Patrick
