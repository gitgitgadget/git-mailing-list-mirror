Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FCC368D40
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 04:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785384620; cv=none; b=Dn/r7ZlN84j8o9PMAI5McMJgFdCVW/5M0pc2JRO/NrNQDvOfjPiDJZq1f9M1FB9auZRFA85z9+a640kouOkHFduuvRtUARr7XjBw8VuQwPykaAThYyo7sYV0L7HtF26MTMbh3/wZrjwtED8BMdvS30AHXOCQPilvx/5drdD/Tng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785384620; c=relaxed/simple;
	bh=qw8AivJHsKbVNjGo4wU69FhXkW7hQ3Wx7ADZjYEj+IA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mzk8aspBJR4yF+PIymMXnxsIBwazlrT54/88/+Xyn8W6YHn59dEhUCMW/+pr4aGC7/56R6mUHIbBWrOhrROzsMHdNmdPs7jOJ4FpFQPkRXz/RQ6yYxzGHaQJvScQJ0RHhPjGDnQZnkrRmPDeg76FxQzYbgpRDxUBHtG1PdeLAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UxdpHEot; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TcCV9lXn; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UxdpHEot";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TcCV9lXn"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 94CAAEC07B1;
	Thu, 30 Jul 2026 00:10:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 30 Jul 2026 00:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785384617; x=1785471017; bh=IaNmGBkDaT
	jgEyZGSuzjZMqbL8POBmGSNF59tAbYGRo=; b=UxdpHEotgE85rIk04TGjNSwBLC
	zY7Pgmt+PoXmP7e0gswlaQ1vRQ5XN5vnDMgP1DUDwK7kmFWRv1xRVL1KzYsYisqC
	/zxn/6qV8N7Cit3UYkqDNrD0b531K8lYl6k8vCKK441MiCUgCr8hQpYpu2kKhNZG
	c1hNT1VdK2ywh5iZqcJf5XTapGzx/nvZTKt30oSYykEsk7yizLYduDTu5wUJ+uLG
	aCtDRRrjPWxYM5b3C9GUM4fgXNFDkXFmbe2DdYNhIs5TVkYTfeQN/IYp4RQ5jWrw
	+7w1UOqzt7CQ4kKPCPLxBvBeQAIe9N2N9WEQ6so/+TehYbjdLjAyOOZVbRnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785384617; x=1785471017; bh=IaNmGBkDaTjgEyZGSuzjZMqbL8POBmGSNF5
	9tAbYGRo=; b=TcCV9lXnnjbgPLwEnvH++azBWgBHWiSuHB62TJJorECpWaI9Zz/
	COn+K8OfbCSpNVS/YO/BVZH8Wh9QzDXe6SxxRc6iQi124XSRZbnAwZ8qAM3XYJwf
	A5sIP0KK1q+mGZxNJgbJA+jccqMxmDH329tu3yfrYzSHEFse8J7eBkCFoLfkbmll
	ICWMPB+9uqhWACuN8B1H+Yn3pu3lC5hfen02qe2IcL2jB1eZV/kr92VHQ2MM5mj3
	0o3zXDwhhGGqn5qjV1FIAE+aev6UMcMxIfB73DeKfHTJbggHcQoZxVaLtExG9XYn
	aLX4S5eU8cP9fg5dt4wsAhv8dHTGkxp0bvQ==
X-ME-Sender: <xms:qc5qarruhJy5CU7j7eBQirhElbsatK8oCMj0THG6iV6fos1QAiZ-8Q>
    <xme:qc5qasqBu9Xb7OT70fNnwiSBKzUgH6I-r3Evs0WNXKvjB1USXwjf-lwrAN4_ENo-v
    wvW5FYPmp_MS8ZbWvyllEp0-l9nx1EQcQLN_fTAx1XcbueiJ-k6Kh8>
X-ME-Received: <xmr:qc5qatPMk7cnbHEikwKBWPE5C_1L6ugtqFUBmeWiA2yJbn71xDfXta-AVdrxJFlyf6JGiYh1sOH_PlyAuOVLmKUwDcb31Pvm9w>
X-ME-Proxy-Cause: dmFkZTGQWO+0Qp/dNCefMHLxhhhhPolD0gbe/xO2nXjnHBUVpWvzS5UC375JkIZ1pG3LV/
    pSIrL1BwO3PFrVvPAMCED/3/vECiUDF3tpjjkv6oO6cKirXQq/pmJ4Y3xe9H1p0hcdGfWs
    8IQNU83vCI4YwnUBSViVCAAdh/AVSftWQBwzJD+LyKwdVY8ZJN1BzfJwgYEAGG3yzSE5D5
    qqUTaDWfK6nwPDWj7l745Z35NemXEGz0j7Uc4REfNdiKQTyBtc7wQ1lAVU+K6kOIug77QC
    eOq874gvUKklricII6pU+iajGWe0NCRKFmeOePdamFZGXqXaSmIyaxgK3t2glFL1TfOQnh
    nfvjsK23VBET+hbRL2tOC+Sv/vygqiENRFAppsnJFn/HOTFXUeCGc8qSUpMT2p0XtBJOnb
    WT0GcHv5Ho9Xx2xelvcBmc9S5hzNjPzgbATsvroMAd9mRXPsV5SBDTLVYHaO3yK29uYm2v
    9LPZ46d7xwzAL24nmfA7nYYG3NqgZByOJ/BABMyEwy+Vtcr+ATpsuqqzEVVavPXehXDsv9
    hco0hEkcwgievns0MVoDKKKfHs9eJBFA8JkJbdEHCgYRidR8JWWhEopz69Js80xg0DVPkN
    /yv8BCIbisfhuLGizp8jli/pJi3CYXS0tzzGR11ahzrNoKjKav/0ebGanAxA
X-ME-Proxy: <xmx:qc5qatzVl5kURT0FuWCAzyVuXBu_w-4GU-GGFch7qEU2FxUzYod2EQ>
    <xmx:qc5qamvs2mtnGAa4umWVTJVgb5k7RTObUeBVRNhIo7XAv-0zKyw4OA>
    <xmx:qc5qam4Z2afwZAynQua9zku1ekke1oRB-rl0dwOVk8YASw_UOWaoxA>
    <xmx:qc5qalS7m-FbpPgyrErHsVNR0o1b1GNt1Scm69Uqs4R-IfFM3wR3Og>
    <xmx:qc5qaouvvLQuR1l3PfN34aiAiDnqsepKPZ-VRoIRic9uIBEzSqtztTsi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 00:10:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile: read configuration earlier
In-Reply-To: <20260729225944.1364947-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 29 Jul 2026 22:59:44 +0000")
References: <20260728135532.GA11894@coredump.intra.peff.net>
	<20260729225944.1364947-1-sandals@crustytoothpaste.net>
Date: Wed, 29 Jul 2026 21:10:15 -0700
Message-ID: <xmqqh5lhm82g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> When building with WITH_BREAKING_CHANGES, we need that option set before
> we generate the list of binaries to build, since it affects whether
> git-whatchanged is built.  That in turn, affects whether t1517 passes,
> since it does not if we are in breaking-changes mode and git-whatchanged
> or git-pack-redundant exist.  Load the configuration settings earlier in
> the Makefile so that we properly honor this value when building.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> I noticed that Peff's patches didn't quite fix the problem for me and I
> think we need this on top to make the tests pass properly.
>
>  Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

This is a scary patch because its correctness depends on what is
between lines 780-1050.  It turns out that this now lets config.mak*
to set quite a lot of symbols to affect the outcome:

 * PROGRAM_OBJS, BUILT_INS, TEST_BUILTIN_OBJS
 * WITH_BREAKING_CHANGES
 * SHELL_PATH
 * PERL_PATH
 * PYTHON_PATH
 * NO_RUST
 * DEBUG
 * uname_S?????
 * SPARSE_FLAGS
 * SPATCH_INCLUDE_FLAGS

Especially curious is that currently there is this bit:

	ifeq ($(uname_S),Windows)
	RUST_LIB_NAME = gitcore.lib
	else
	RUST_LIB_NAME = libgitcore.a
	endif

that comes WAY BEFORE config.mak.uname is included.  If the location
to include these files matter, then how could this bit have been
working?  I have no idea and since I have no access to Windows
development box so I wouldn't know.

> diff --git a/Makefile b/Makefile
> index 98e995e4be..6bfa461aeb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -781,6 +781,10 @@ clean-perl-script:
>  clean-python-script:
>  	$(RM) $(SCRIPT_PYTHON_GEN)
>  
> +include config.mak.uname
> +-include config.mak.autogen
> +-include config.mak
> +
>  SCRIPTS = $(SCRIPT_SH_GEN) \
>  	  $(SCRIPT_PERL_GEN) \
>  	  $(SCRIPT_PYTHON_GEN) \
> @@ -1050,10 +1054,6 @@ GIT-SPATCH-DEFINES: FORCE
>  		echo "$$FLAGS" >GIT-SPATCH-DEFINES; \
>              fi
>  
> -include config.mak.uname
> --include config.mak.autogen
> --include config.mak
> -
>  ifdef DEVELOPER
>  include config.mak.dev
>  endif
