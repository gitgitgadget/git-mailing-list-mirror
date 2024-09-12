Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C919FA65
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726137669; cv=none; b=e32l/lVK/ut2HNwqnouvzRj1W895SY6yBFhWpJFfaCWq367dX24lKea2R10yNROMh1PbrAazguD7OUfsf3Sxruo77U5IaC8L3aHmIIxUqIzHKN+jhmqfwbEwztbe16HMT9IPdz6n/n3G4z6zpUFlfEjrhWYyG9GFttBz3ms3hmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726137669; c=relaxed/simple;
	bh=eXWa7l8DftCrkNCguPSk5LwLSVsmbD/tPxKIcB92R0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXxjVXKAmG5FE30GU8m4oMcBBc69cmpRlmOcX4tz+p1hVrw50WRU8tz2pG2EkpgRjhV/8Pj1TY5UgfOYksDjYBpbibjj9cFxBKBgGfLH+0EBDkizZne/Kbu+gK4kRk4C+CErO/S2UDYnNquffYC0nnatwvzA1fS6BPhH+tV6QMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NdW3pw+K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=al3zTZba; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NdW3pw+K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="al3zTZba"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EAA9911405C2;
	Thu, 12 Sep 2024 06:41:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 12 Sep 2024 06:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726137664; x=1726224064; bh=zrVbN197ff
	+7QrYwcHpxoc3qDYA5EtNMXzcwKueUvPQ=; b=NdW3pw+KWuONV2FUkpVE5Pnwug
	PmydcFdl31nZ332l5j3iigChAIqtBFhwmLOZobrzBM+qeTDrMGJf3M7QyD0cK7KP
	dJXY4T6Z/capemJWpDkKgZyGgiJffCFfI43/qWLd/sfwu4xkLVvdTD/KxWbotGGt
	OBJ2+O7AoY7LK5ZGNbg3Xr5Tf+bhH+4B4dy4PsXMWBRzouq9yOV5U2BqwgFvBr/3
	OYy9N3Gbi+AVYFX85mrM9Oocs8tqmpYqE6icwJ6zPbBhixR4CapU2byxLIL2/pgL
	ZpeVP/svWmj4HyR0Hdzs7TsFPd2OECAFpsYIopKk69qxSo3+ZXDsbP4eAK7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726137664; x=1726224064; bh=zrVbN197ff+7QrYwcHpxoc3qDYA5
	EtNMXzcwKueUvPQ=; b=al3zTZbahAXDGTIAUIQfjP/Btz8NvWNbQWxu66NhfaUC
	Wwg/8EE997UCIv2OcSEAia6r29pu+cqp5kmZ/+2fFW/hfjiUp9PINADmD4VTT7o/
	FHGz9Ytzo/oHBLYwDL4bFcdElNLyV0NfRCGZ+ARndNpydmmpxHQV01N/RuPTaQD7
	qLlGGfFhWsU4DVIeeqa2KaS+HNkNnPYE0YYua+fgQhtF+GJU6Zeo50HUV9+1Twkl
	tbjxU219gsn+omU/7H/uhoFPb3LLb7cKZ+5OOvHWOXmeHRlGV0j0vt5e2JnqE29n
	naR2QWM03mFXYjbAiTU75XISbINuZvDGxf9RWBOhTQ==
X-ME-Sender: <xms:QMXiZpiGmGxOhHZGp6oxc9C6wt9j8pWIe0K0iJGbVfcPyOixkfz4Jg>
    <xme:QMXiZuD683E_gQx_QRR4-0pcCUp4HuprsP5lLg4BWC6ghfKk1teERi1Ek2QB88q3f
    -tirlA7yw3l3KEfbA>
X-ME-Received: <xmr:QMXiZpFpJzb70y-1HujECv-TTtWGO0BCeNbAOzZKU6qAOpDAXegu2808uqBe0DVL7Y_VJuTTpw1VsUdThPwjDK2FPdxPouizMShQ48277Brc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QMXiZuSkL8zgzHqrYRFi6XK6fhAdU8KBbHjij0p8PbbPcBHAZDSYLQ>
    <xmx:QMXiZmzR4bS7EQ6XsdrVU7Z_bqlsR47UXuzDwFYgCowhztac5ilo-g>
    <xmx:QMXiZk7Pwx6cI1FisUFXVgvPd-nXHohzQRPZZZy5Ta5iXYxZVjb6RA>
    <xmx:QMXiZrzpJDhDHsrGzw0mueEcelG3-CRspnsDE4togvVOXVEgce3V-w>
    <xmx:QMXiZq-Q7eKpjdby7Rad_cwYFWacd55RXWLdRAN5vrAbrE1fDdOvRelW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 06:41:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e8a2d140 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 10:40:55 +0000 (UTC)
Date: Thu, 12 Sep 2024 12:41:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] ci: use more recent linux32 image
Message-ID: <ZuLFPxsDiMB9UBhF@pks.im>
References: <20240912094238.GA589050@coredump.intra.peff.net>
 <20240912094730.GC589828@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912094730.GC589828@coredump.intra.peff.net>

On Thu, Sep 12, 2024 at 05:47:30AM -0400, Jeff King wrote:
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 97f9b06310..db8e8f75a4 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -339,8 +339,8 @@ jobs:
>            image: alpine
>            distro: alpine-latest
>          - jobname: linux32
> -          image: daald/ubuntu32:xenial
> -          distro: ubuntu32-16.04
> +          image: i386/ubuntu:focal
> +          distro: ubuntu32-20.04
>          - jobname: pedantic
>            image: fedora
>            distro: fedora-latest

We could counteract the loss of testing against Ubuntu 16.04 by adding
it to GitLab CI instead:

    diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
    index 2589098eff7..80b1668ebeb 100644
    --- a/.gitlab-ci.yml
    +++ b/.gitlab-ci.yml
    @@ -25,6 +25,9 @@ test:linux:
           fi
       parallel:
         matrix:
    +      - jobname: linux-old
    +        image: ubuntu:16.04
    +        CC: gcc
           - jobname: linux-sha256
             image: ubuntu:latest
             CC: clang

I didn't test it, but it should work alright. GitLab doesn't put any
additional executables into the container, so it is entirely self
contained. Let me know in case you think this is a good idea and I'll
run a CI pipeline against this change.

It's not 32 bit, but at least we continue to verify that Git builds
against old distros.

Patrick
