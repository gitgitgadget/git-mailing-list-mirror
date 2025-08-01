Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C320A222582
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754040237; cv=none; b=uC6b5dij2ykMyDjxwgKhS7N9g8iiWnYfYYdr7HyGEjxA20zb96Ho5xbKEVgH6ejlTnkgfM3jnPxslDzXX1m/5gkqfyR2rvYs4vBSxArACcKJulB7yK01lshk6Gm1ohYSAPwW+J/d0aqH6+usx/3UzVC59x7HVorShkHwMdz6dNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754040237; c=relaxed/simple;
	bh=qJEf2p2zD9YmGspxiYZ/r53cR6eBzqNdd//GSyRcTaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVz0EtJd9aoF/bDbixbv7Bu6pRZTUuOIEH3BJgsaZng/5WavtSI/kqBcEh6+o9mOasR26HUgs1qvN9jrDB+2Rr7gEAO5jUubmqz98V7XNBhnc3owVYiBnSLmO2cddNdLZ+W1h4pWP/90Erkihodhp4c+72ofx1r7eep85XNADbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HuaDmWoB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q7ZjdZDO; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HuaDmWoB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q7ZjdZDO"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF7E11400043;
	Fri,  1 Aug 2025 05:23:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 01 Aug 2025 05:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754040234;
	 x=1754126634; bh=jLh//51fvkvTU4oWowWd8U+atwXjATzfy1S9H1Pb3ag=; b=
	HuaDmWoBC66ocfycoqWakL3ZmeSc2eT1KDbLa9TM7fcO84fR3pslj+Sg0U21ImkE
	BdNI7f4fVZAhCYf/DDM7EXElPw0fLwl6D2AM+6I30NJnKGnIczrVttzMfthXRArA
	lmJFBoE2enNsnVVxoRfaTJJ4VUDt4irqIrbzKEMb61KkYpKnlAnCtitiqvbSbLgx
	rTJIraOtAa+dcZYLgKDyHkQTTZWnsiu/bGOCz9PJ9cRUpg3tFtS17dLJFoz76eh2
	R8PwnGwuQfjjabyhgVAC2/y5DjrDlFTNhdEe+NHh/JFhEnB9oHNGiNnDesjQVu/W
	k5J9KxxG5oFuhYqVVPfXhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754040234; x=
	1754126634; bh=jLh//51fvkvTU4oWowWd8U+atwXjATzfy1S9H1Pb3ag=; b=Q
	7ZjdZDOKjt449pa5TQXN0yQ0MfkPhVIQu2Giy7sEjpcdqzfp5vFTx2DYvJ24vryG
	R1KCfs+5RyOZVT0Yv0Xcf/W360HAS2wPI7XDnRALUKo8dPRg1dEmazrISvkOkqzr
	Sm3ShULhXyTGs8f5th0w7tBUys5ShKHhK95and41c6dp2KswJfGngmK8or1lIAqh
	AESaS5EPYKcvizqSH55j79vMg6/O8BgP5LwaVfPWtTkOkpA2/BGY+YjbBaJSYeMk
	kg8LQigyMoWta6sCoKwOmp++yi7ApEyRKhpadrrTTJrjKEq/odnZXdHM2sLHQbuC
	7wf5sQKo3yBkhLE0Sn/vA==
X-ME-Sender: <xms:qoeMaGzxNrY6KtMTMEkCf2GTnN6gW3LeKbQkWqilt1kYtEo2pOFuog>
    <xme:qoeMaCfJJF4UXA7yEJ1S4H354RE4KAxLNErpEPY5HjxV8LIPQRSh7lprjACKdgmxR
    Ks5bMUFDfPw_E848g>
X-ME-Received: <xmr:qoeMaKL4MIxnd6a7sZslrICTlV862pcCg4qAhBvzPG83HJ9A2eXwCzhdvvZQv7RRuH9K2CXI1KgoDfJpndWBQzjoxsjL4IAnXiHKc0wtGIVF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtih
    hnsehmrghrthhinhdrshht
X-ME-Proxy: <xmx:qoeMaLHmWUtuA2hzOURUJY4T-3gNW9Lx1pNcRRK31PBZTHOvw5_ZyA>
    <xmx:qoeMaMoqTqETL5V1Yie3ZzJR_26QAdSERJYDs3ncVBMw7sm-OVCukQ>
    <xmx:qoeMaMRmhmLPNaXSfi6J7haXtXM_KVs-zLwBIqh7SnrNrNcj27RLuw>
    <xmx:qoeMaBPRDxpKbwMYz9I3Q9BanSn6ufVQLa4J95a5_GwvsOoKwaPCzQ>
    <xmx:qoeMaCvIETVpfhBsHHhORC--1opVgUuXNGpikNsLpl5tWZwMqr1Z4gSX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 05:23:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aed54aa7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 09:23:52 +0000 (UTC)
Date: Fri, 1 Aug 2025 11:23:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Martin =?utf-8?Q?Storsj=C3=B6?= <martin@martin.st>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] meson: Tolerate errors from git ls-files --deduplicate
Message-ID: <aIyHoF70z0jV-sj8@pks.im>
References: <69faab5-43d4-812c-90f-c518ff7f618@martin.st>
 <20250801075649.1796238-1-martin@martin.st>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250801075649.1796238-1-martin@martin.st>

On Fri, Aug 01, 2025 at 10:56:22AM +0300, Martin Storsjö wrote:
> When using the Meson build system with an old-enough Git version
> that does not yet know the `git ls-files --deduplicate` option one
> can observe the following error:
> 
>     ../meson.build:697:19: ERROR: Command `/usr/bin/git -C /home/martin/code/git ls-files --deduplicate '*.h' ':!contrib' ':!compat/inet_ntop.c' ':!compat/inet_pton.c' ':!compat/nedmalloc' ':!compat/obstack.*' ':!compat/poll' ':!compat/regex' ':!sha1collisiondetection' ':!sha1dc' ':!t/unit-tests/clar' ':!t/t[0-9][0-9][0-9][0-9]*' ':!xdiff'` failed with status 129.
> 
> The failing command is used to find all header files in our code
> base, which is required for static analysis.
> 
> Static analysis is an entirely optional feature that distributors
> typically don't care about, and we already know to skip running the
> command when we are not in a Git repository. But we do not handle
> the above failure gracefully, even though we could.
> 
> Fix this by passing `check: false` to `run_command`, which makes it
> tolerate failures. Then check `returncode()` manually to decide
> whether to inspect the output.
> 
> Signed-off-by: Martin Storsjö <martin@martin.st>
> ---
>  meson.build | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 9bc1826cb6..9b519e6eed 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -694,9 +694,12 @@ third_party_excludes = [
>  
>  headers_to_check = []
>  if git.found() and fs.exists(meson.project_source_root() / '.git')
> -  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: true).stdout().split()
> -    headers_to_check += header
> -  endforeach
> +  ls_headers = run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: false)
> +  if ls_headers.returncode() == 0
> +    foreach header : ls_headers.stdout().split()
> +      headers_to_check += header
> +    endforeach
> +  endif
>  endif

Yup, this looks reasonable to me. We could have an `else` branch that
warns about the command failing, for example like this:

    warning("could not find headers: " + ls_headers.stderr())

But other than that I'm happy.

Thanks!

Patrick
