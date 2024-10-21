Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E715575F
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493974; cv=none; b=fHESZuTkDrHfo/s0uwFfZgH25CSeFcYjuVWoydfJ+B68LydbNXorSLamIznWMrf/sPGpgEm2kgkuf9X2ckGAN80N+A45/7+g24h7a3vZ9F9LP4m5yuOsoKDmVSgDhfDy7H+pGkxp72qK53jUyInQFoD7/imCrrn6BleNRiJCDUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493974; c=relaxed/simple;
	bh=jmbNTREPZ7KsFkaDEHrJpBZVtiQOZPF/lAy/oGId4JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlXcZuZEz7Xw3/06G1OOvmyLjpjZYVIIe+0sFPmPgSgUeMQeEg/bmmiSDLXUrqqDzmDr4wS9OActiRZWYliEiKd5bDGKzgl6eXUNspFPZwN9gZUU9QR66jAOxCtcsqtC5M5iheIOK0SSQfRL0zfnB1wqCS+CLMTR5va9LHjZmsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yqzDr7Pr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=miYgJIlF; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yqzDr7Pr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="miYgJIlF"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C63BF1380472;
	Mon, 21 Oct 2024 02:59:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Oct 2024 02:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729493971; x=1729580371; bh=02ocXmI7HZ
	H8G6PtN7jGOjB2qiyLhWHVDfzU9MGWgZk=; b=yqzDr7Pr9nkiedsvw6tk5VZtxj
	xSRfuZT1Qzf0RxpZOBWt/alcDT3s4NM/ujKWZnmBx7mFScEVuksnHKsz9frscmSf
	yhZdq4dLg9r4XTE9RTpQcRUT38senCH2RPKqFQe4bSwUeGsfwCJCO8L7YEFe5r6x
	p6ae5USnmIK1bH4NfhydWm9KCGyY2n+xsNop5tezS4MZ6QYR5H3gIZQIpQ0OdcAp
	DJHenVxfwdB6MUPxoic1pO48e6riWhK50/4+lRBe39NNi8ZkLVgniZb5idnQ1hrv
	k3+4xANh0iHStcUPFWRWQJ4f15bSuNc3g4Pqu6kUEXSwvzYk5NDggonJ1Qlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729493971; x=1729580371; bh=02ocXmI7HZH8G6PtN7jGOjB2qiyL
	hWHVDfzU9MGWgZk=; b=miYgJIlFpvCNPaXz93IklH86JNXIaqRmq/LQ7vJVtVqZ
	bMKT0A6OsbLJQV0aYCh04dPS1o7VoJyPEzXLCVchVZpp+JtcHwDxYn0HIXvvXYtK
	PXKH6dC7yKA3iirkS0LvnbuADmtz8IXBt5UigzUxbUb1Tm8xeLJCCQO3gwaFq406
	63dDC/9xgm8Q9s8IkIxWrXqJ0iJQAee7oeh8D6CHtqUX7FXeZoTo4KJaNpeJdv/I
	r/RaqnyKvhtwCGXx5uBwhzTPXy2EiyqvICsl5TWvIz/GkSxB2PEdza4QYGGLbr+V
	Eek75ZlrN7/TmqMiTRgCZwYt0sFNyBsqGCRRpD8+iw==
X-ME-Sender: <xms:0_sVZ9aICANeHZ_b7qglq5Z-fegBXVhLFnb1ELW3_csTgRBkPhd0sQ>
    <xme:0_sVZ0aj0PZ3i89qmIvGfK82-VgoVlI9IiETZDYEG51ThPBwmS7JTM7YkYYDuBOVT
    TD-7D0IFKFt8il8cA>
X-ME-Received: <xmr:0_sVZ__Abrk8kVKt6z1c0o7wkJ1AOlTXG_Op3Jppv644Y5KhWjZyisAu0WCn0an8JXwy8ftxk2NBHllTvtd7gDoKg07TGDH-IpUO2CJWhU8S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehkedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedtgeetffekffefhfelvdeivddthfdtfedtueeuudfg
    kefffffgudejuefhuedtgfenucffohhmrghinheptghlrghrqdguvggtlhhsrdhhthenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepvggurhgvvghlsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgt
    phhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:0_sVZ7qyhMfhMHJ8-0i0h-zyzF8C-Bq2Lyku0--ABsGzK-bnNcQijg>
    <xmx:0_sVZ4r5zneaUHiAuU-4M-aU-vTTc1T4YAYAO5KBi5sSgcDAqjAQpw>
    <xmx:0_sVZxTYcC_FPoYEiXd55cqQOpPVrtm81ds-NutQ5zG7GBw57O09TQ>
    <xmx:0_sVZwqKO5KtvMje4lZGbkmjBY701GMIexBs4UYV5x2PE5SVUzl2Rg>
    <xmx:0_sVZ9DG5MPSpWplGwiyc57mjpquWxPC9gwsBh8K2xbavHfO3Ra5fda->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 02:59:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 61cefbce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 06:58:01 +0000 (UTC)
Date: Mon, 21 Oct 2024 08:59:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/3] Makefile: extract script to generate clar
 declarations
Message-ID: <ZxX7w7dGdalOyDo4@pks.im>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
 <cover.1728985514.git.ps@pks.im>
 <7a619677c7af6ba8213a36208e20ab75c4318e38.1728985514.git.ps@pks.im>
 <871q0dcu8i.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q0dcu8i.fsf@iotcl.com>

On Fri, Oct 18, 2024 at 05:21:17PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/t/unit-tests/generate-clar-decls.sh b/t/unit-tests/generate-clar-decls.sh
> > new file mode 100755
> > index 00000000000..81da732917a
> > --- /dev/null
> > +++ b/t/unit-tests/generate-clar-decls.sh
> > @@ -0,0 +1,16 @@
> > +#!/bin/sh
> > +
> > +if test $# -lt 2
> > +then
> > +	echo "USAGE: $0 <OUTPUT> <SUITE>..." 2>&1
> > +	exit 1
> > +fi
> > +
> > +OUTPUT="$1"
> > +shift
> > +
> > +for suite in "$@"
> > +do
> > +	sed -ne "s/^\(void test_$suite__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p" "$suite" ||
> 
> In the Makefile the first `suite` was wrapped in curly braces. And I
> think we need to keep them in this script as well. I noticed because I
> was reviewing this code in my editor I've noticed it highlights
> "source__" as the variable name. You can see what happens if you add
> `set -x` to the top of the script:
> 
>     $ make t/unit-tests/clar-decls.h V=1
>     /bin/sh t/unit-tests/generate-clar-decls.sh "t/unit-tests/clar-decls.h" t/unit-tests/ctype.c t/unit-tests/strvec.c
>     + test 3 -lt 2
>     + OUTPUT=t/unit-tests/clar-decls.h
>     + shift
>     + for suite in "$@"
>     + sed -ne 's/^\(void test_[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p' t/unit-tests/ctype.c
>     + for suite in "$@"
>     + sed -ne 's/^\(void test_[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p' t/unit-tests/strvec.c
> 
> So it seems the script currently works "by accident".

Oh, indeed.

> You should replace the first $suite with something like:
> 
>     $(basename $suite .c)
> 
> One other suggestion, and feel free to disagree. What do you think about
> replacing the `$(patsubst ...)` in the recipe to `$(filter %.c,$^)`?

Yup, both of these are good suggestions.

Thanks!

Patrick
