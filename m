Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D33934D93B
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817849; cv=none; b=ewTiWUkseXh5zGtgHhdypYIJx/xHJmlKqA+z/2FXzJ9LGJzdwVEYxMlhr6qG0w+eIC+N+22WuHpbbkF4gABq3pCaKttD8JTntzDQyO8XKLode+/E3kzRkp59d6kDXBJuaPVpK9gpFKn2HUa/wZLG85WYngxVodCe8zVjOlZGkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817849; c=relaxed/simple;
	bh=p6FS3Bk1wWQA7cMB8lBHbN73LP22/My4riVpbWbR/FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb1P36oFhrjJtDj+0ptHx1TPUbKIudF+rdlqZsWKIZO+C3+GqVMrfmLkqsT5EVFSIirlRXTLSdUJn1N7e2NXTp6CW0DptckYqaWZ0wGrKOyiDi4POlkAaEYLaMdxgWwOx5WJJY//YV2O77D9JNdq9DRZn3BnP3pE9/GwP/i8qw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ag6oRwTG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fPRNtkW2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ag6oRwTG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fPRNtkW2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 31954EC0191;
	Thu, 30 Oct 2025 05:50:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 30 Oct 2025 05:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761817847;
	 x=1761904247; bh=+WiO8rFIYRSsFJeKgZDpKT/lOTqrlPE8/4GHcJIZcUQ=; b=
	Ag6oRwTGlcPDcWdYzT1b78ai1qsTmNkJfjr4UzjAmL/Fw7sHP3FdY2+nIteC0OTV
	QlBHXLtlvzCS/1L+S3XfxOog/gR61M7b8eeC4xSaiPGeXNUB5bOTYyRoixzhNxML
	BFXm8gt3a85lZk3Hx100UIbGRz4nYsGDgMO8NMWHKpvOLI/jcu3QtvcqR9sjkhRi
	Xqha4j6NJA8VzrfwdcjurziIE2/bh+wUvI2XgKnHeZWJwxATvCGVQcT6UmuB17EW
	zRosG+p8UVcThH24uqRRVxWlx+8fJ1AS9YaicigNhPQQk/CYWzZiDckcaaqXKLGC
	jiJsGQEBaBAbTlQrpl+vKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761817847; x=
	1761904247; bh=+WiO8rFIYRSsFJeKgZDpKT/lOTqrlPE8/4GHcJIZcUQ=; b=f
	PRNtkW22Z4lE0h/5Q5+0dS8q92twiwbzCABBBxgFGFpc/BmdZuMCIsPMORFY5MSm
	bJgbU/paJtYYCQgVMPV4HEKyWDPWjzwlD+5F7+wwTzfhZnTnXWc3jf4thR7+Pm+b
	k3QB1wPlAFUUD1lwnaZLRcSq4igEI+R6OSAcgxr4ukdBSZggn2X4+cpWPTZUoLXr
	ChnKD9y6BRUy+m6YyXaRX5MqGTfxkZMtaTTcO2bdVrNtZfISlPmO9/tZD0M4yL5I
	fLylfQoFZaWbSiAeCAPPW7DzL80IayTHCbb9y3R3/rQzxLSGiyMubY1aam89NqGo
	Vdv5FHaD3sHPzoRmXERfw==
X-ME-Sender: <xms:9zQDaTaCDk5xPOMv7pzFg3wi4RzqNtHhjAx_DtesjGNUG0SroU7WiQ>
    <xme:9zQDaZa1IIZzJbZPNHzXrHJ2ACKxlZKqe2X692TCZUbHKoi-0y9LZ2T9kEuyrgaGD
    VFYSBlx2LzAeQAMNGYwbYPsKrEJodEW157v6ivurtK9zlfQfjLK>
X-ME-Received: <xmr:9zQDaa8iRGdmKXl35rUjDb2OacjpR0rIzfjqK7ZWQcZPGTEwAsp8RYzjJvYo9EMWFWm_KOGlcOsmJvaMtRQil9FIoFlLCSWSo8uBvdtxaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeifedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkih
    gvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9zQDaYgMoMO7RnpfyP6fEKmbKvWP2aWQlrNS8JbhDThLWRb1aLah4Q>
    <xmx:9zQDaae7CEEvOCRVIExE3UY9ONsJtAF2Wfe2ee86hG1Xaal5kZTxog>
    <xmx:9zQDafo92qcL-HjC9p2gyale9rxoOgk_Q5k6DSSpjYBZSEzC7_Ey8A>
    <xmx:9zQDafAS_gHbdSmowftz4hdS0ge2BvXLT8nal5ZhxGM_arKxSaHeqw>
    <xmx:9zQDaTMQictcSbadE0oiaWTC_YOKve8c2Zs46bAt4MCCDQrOi03_-PCz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 05:50:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4eae25de (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 09:50:46 +0000 (UTC)
Date: Thu, 30 Oct 2025 10:50:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] ci: use Debian instead of deprecated i386/ubuntu
Message-ID: <aQM08k9iLA1cKe45@pks.im>
References: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
 <20251024-b4-pks-rust-cbindgen-v2-3-4b4bd4f18490@pks.im>
 <CAH=ZcbB3J2Jt5Najc8p3z1iaig_Q0S_t5hGWRN-4fNRVGggARQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH=ZcbB3J2Jt5Najc8p3z1iaig_Q0S_t5hGWRN-4fNRVGggARQ@mail.gmail.com>

On Tue, Oct 28, 2025 at 01:17:53PM -0600, Ezekiel Newren wrote:
> On Fri, Oct 24, 2025 at 3:51 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/ci/lib.sh b/ci/lib.sh
> > index a5c4eb40bea..fdfde612339 100755
> > --- a/ci/lib.sh
> > +++ b/ci/lib.sh
> > @@ -250,7 +250,7 @@ then
> >                 CI_OS_NAME=osx
> >                 JOBS=$(nproc)
> >                 ;;
> > -       *,almalinux:*|*,alpine:*|*,debian:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
> > +       *,almalinux:*|*,alpine:*|*,debian:*|*,fedora:*|*,ubuntu:*|*,i386/debian:*)
> >                 CI_OS_NAME=linux
> >                 JOBS=$(nproc)
> >                 ;;
> >
> > --
> > 2.51.1.930.gacf6e81ea2.dirty
> >
> 
> Makes sense to me, but I wonder if we should test with other 32 bit
> linux distros. This isn't a critique or a suggestion, I'm just
> wondering out loud.

Potentially, I guess. I basically picked Debian because it's close to
Ubuntu and because we already support it in our CI. So it required the
least amount of churn.

We could eventually add additional 32 bit distros. The question of
course is whether that's really worth it. The importance of 32 bit is
overall dwindling, so it may be good enough to only test on a single
distro.

That being said, I don't really have a strong opinion on this.

Patrick
