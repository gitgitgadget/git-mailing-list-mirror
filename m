Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC842F616B
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643106; cv=none; b=S4Xvpu5QvbCYkObmNhOdABz2oifVsLo9413gGPk06t7L/v1T9tiK/RZvFw5FEm3Ftk/rrWEzpisWP4VjdIqnyTqCxGoZVtrDtwjHTXRnvIC1tsDjhzSZPuLHld5gyQZZwo890t36sqUSM5eS/hi7kNoGPKNfund3JYRNBrRSsdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643106; c=relaxed/simple;
	bh=SGAT59Um8tj8LjTPA8hJNIlk0ermpBdx9/oS/kQ2H6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPcrBMTAt0svkH+6Wr5HlvgfF5KbC7WXHeZ640sCzLgGuTBMYAhEhhPJD64KQELbiX+5ayleA2PgtsFmN5rFD0Yg8+mwhRIJNR//WQyKi/ap2NDK/uNarxdOV7FWhW0/CcXv95XbSWqa/hyLGbf1WLwUaxdU4U6gSBN2Iq8R4gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jZvlcq2v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XnLEFCLt; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jZvlcq2v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XnLEFCLt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DCCA7EC033D;
	Tue, 28 Oct 2025 05:18:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 05:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761643102; x=1761729502; bh=xSSzEKuRQ+
	NC2l74OcZ/uOlF8BYDAqbLUnJAiPBMHRk=; b=jZvlcq2vkI3AESW3PlLNE9vBvn
	ne6Ci7Szb7lBaCSmdTarY4HeETNzntPSIryv/IV47z0957Lt3v7JQW/0JYLO1N5E
	EHW/HgZjhz/qckSMOgt8N+/EEiIeloAhBjb1EHrlPZ7lNh/1BwcjcOB93cURI77B
	H6K9JHOuDH+3e75I7zaCB5ih9mC+n/Z6bfmka/ysVF1H5NkGQ4xN0E1MjZMRM+Re
	s27DV6CZlXz1oCAtpOLceUIkD81Y4EhpE7IbBwBO8tYF69pkdUMLIRSG8Ml5Ptqb
	Oh58XFAhQa353Nn60LPVsUfPvPzbnpaAITEN4Kei65mkeP53kPi4SVN7lrXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761643102; x=1761729502; bh=xSSzEKuRQ+NC2l74OcZ/uOlF8BYDAqbLUnJ
	AiPBMHRk=; b=XnLEFCLteHsWyH14cmODbKNJyWi5sdspK7MNWXTvfo3JSw9PsS7
	6IQYdy9kN4S2GaiUdhpbH1Gy1J4ooRsjFCD2Vqx8PAO1Q0RgEO9AZj8MKX66J4xM
	U6DiWuG1d/SotE9nPrMr0uMFmWiE96QrqST3FDDH4ETJAwlQI1v4/z5yvhkhPngN
	rqBRCTuddwOdEBCOyxG6xiWWZ5HqUIXMmfrAGEtLXg8n/xJ+VGwaTPRWmRqzNvrt
	L0Yg+FMjj99ZQUsMqz3XasQXaggCj1vl9naDfGCKdEpo9JQC+fiASnGBF3EttuaM
	4dgZMiSh1x/NLW0l3WBTdBYLwmEEBOlHoNA==
X-ME-Sender: <xms:XooAaWQnbqp4koLEqPPHz5gREMtoVA72Aw2xWU04rw2h8N6fo8papQ>
    <xme:XooAaSxeqfO-Z0yVU_s8sKC-fSvfypO4-me4ayE0fMgLaWTDtjmdcXepCNg92SJZc
    Bp8wkipZvSEcYoQRs6gFL2Ss5jBxw1plmjA5OZhSVpTEThJ8DfS>
X-ME-Received: <xmr:XooAaY2uMlAsAO8emjb5iAyc-x_C1OtgRD05GYRN9pqpodrGQTtVikT4Yv_TkRjghxRgdgkvuMw4Ao2gbl-zQ3wlQRfJPD6Rf-lE4Xtw-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfefggffhudeltdetueevffeuueetuefhheeikeethfejkefggedvgfegteeltdeinecu
    ffhomhgrihhnpehgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhooh
    hthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:XooAaQ4Og7dNhcfm9q289v4ZwkT4VWkpffytRKW-0wKJ3-76DOZjaA>
    <xmx:XooAabXFlqeoT-ZkwYpsaKcNJCAV7VEt_rRY4o-Dr5VISCNCRXUfmA>
    <xmx:XooAafAZRVib35m7hvJCMk7LNyo7ByScbhPbm7_8MFHALzZDaD0Nqw>
    <xmx:XooAaa6-5DtBLL2mu9DP10XSjlr1IGtTU28wl9MuVeoICXOTXaTQIw>
    <xmx:XooAaS6Y882a1spowpLQR1vjUj6p6u2pfFstidK7VaIS3T0Lb8zWWdGl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 05:18:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d3d46884 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 09:18:21 +0000 (UTC)
Date: Tue, 28 Oct 2025 10:18:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 10/14] rust: add a build.rs script for tests
Message-ID: <aQCKWtgcYQVPzIPz@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-11-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027004404.2152927-11-sandals@crustytoothpaste.net>

On Mon, Oct 27, 2025 at 12:44:00AM +0000, brian m. carlson wrote:
> diff --git a/Makefile b/Makefile
> index 7e5a735ca6..7c36302717 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2948,7 +2948,7 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
>  $(LIB_FILE): $(LIB_OBJS)
>  	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>  
> -$(RUST_LIB): Cargo.toml $(RUST_SOURCES)
> +$(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(XDIFF_LIB) $(LIB_FILE) $(REFTABLE_LIB)
>  	$(QUIET_CARGO)cargo build $(CARGO_ARGS)

We have recently removed the separare xdiff and reftable libraries, so
it shouldn't be necessary to have these anymore.

But one thing I'm curious about: don't we have a circular dependency
between the Rust and C library now? I guess that's somewhat expected, as
we'll want to call Rust from C and vice versa. But on the Meson side I
think we need to adjust our logic so that we don't pull the Rust library
into libgit.a to break this cycle.

> diff --git a/build.rs b/build.rs
> new file mode 100644
> index 0000000000..136d58c35a
> --- /dev/null
> +++ b/build.rs
> @@ -0,0 +1,21 @@
> +// This program is free software; you can redistribute it and/or modify
> +// it under the terms of the GNU General Public License as published by
> +// the Free Software Foundation: version 2 of the License, dated June 1991.
> +//
> +// This program is distributed in the hope that it will be useful,
> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +// GNU General Public License for more details.
> +//
> +// You should have received a copy of the GNU General Public License along
> +// with this program; if not, see <https://www.gnu.org/licenses/>.
> +
> +fn main() {
> +    println!("cargo::rustc-link-search=.");
> +    println!("cargo::rustc-link-search=reftable");
> +    println!("cargo::rustc-link-search=xdiff");
> +    println!("cargo::rustc-link-lib=git");
> +    println!("cargo::rustc-link-lib=reftable");
> +    println!("cargo::rustc-link-lib=z");
> +    println!("cargo::rustc-link-lib=xdiff");
> +}

How do we ensure that the correct libraries are linked here? E.g. for
libz, if there are multiple such libraries, which one gets precedence?

Patrick
