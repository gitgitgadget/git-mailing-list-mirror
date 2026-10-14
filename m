Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546B331A63
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974123; cv=none; b=oAIOTk8pEWKqCdYLpjdG4l4bTDi290aEVlu6QsAADHtkiCQcVbLwSW3CUy1HYCqZWFprLlUVo83PU2wVp66EfpH8lEjlwoaJQIBaHVDw4dStnvO2NApQ2aAKn7r9FX3/6c7Q6zbl0ciohdNpcg717AwzeEqn62hEBE5Bv8tBh5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974123; c=relaxed/simple;
	bh=eNnPtTHpoVNKuE7u/YbC5r69L9qHzrsIwfbBP4ib2y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGLP7B9yOivXmBNpEY2sLPjXH3AZJ3ZoKgktqhhiWpHyrsV+ICm6JVwbhYqcnJ6sTzDa8enheqH046zV5PELgr36Qt2WRTxZROIojGyfx+XJuWiobe71j5D6ipt5NIa/uhivrJUBBNTlh06DL5LPHdTkbVqNRqgYnAa+axKipVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JKRct4o7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kcO9ILww; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JKRct4o7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kcO9ILww"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2B436EC0324
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:35:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 06:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791974121; x=1792060521; bh=zQXVLUBhEb
	z6iaAsK5hq0LDMoVN+p4xVwrBXs56rA5w=; b=JKRct4o7+IPt0DduD+LaI+Yyoz
	j0UieSkQy2XBe1feX4NpyB/3lDlldlbR1g55WKj7v2+yKLTH7SSDdW3IePmslrgT
	47wQuvtGn1rdR/CWaxt5zk/isonTUwZUefwIUQkb03m+J2pMEI3scLylGG0CAIEC
	TNQn0AqRJfRJk3NeVqilvmnUBwZ5cmmPwhQTyGq8VgqWikz79EiRmEEMPQKFaoVw
	W8G5k4O91ivdiMZYfBy/5fbF+ClYX8UbVSUjt+HgXHmv9+ewKlqlu+n2vHqtBv82
	OFEkIK3s0LoWImNCL9BPiFrVzLzl0kL3oLLoXNzBp28K7OVsAJYLvPDKlP0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791974121; x=1792060521; bh=zQXVLUBhEbz6iaAsK5hq0LDMoVN+p4xVwrB
	Xs56rA5w=; b=kcO9ILwwtnQbIAB/LEvMoA1I3r8h0FzYO7glDwYxHZAubZw7LnF
	fBazNvbtJ+FTdSf9+hddy8sGu2AZFnRE/wcT35qPQxLRl2QKgQKZo1XgX3RjmJU9
	81rAUuKk/IiOzqsJRMXv2+yH7jhM3sgN26Ak0CJaKBS31U20XdubxI2+xUVYrlrb
	gb3FD5Oc8mguahAogr/0sgdl4zHjyrUFecQYcwrYkk8mY0E+ulVfgU+U2j5nuRB7
	obYT3OVJPgmDfGLUVXSFbvOOJfIPhcbcGNn465WTpHk3gHQYWN2SXUaPbPWTn6Km
	D5QKS0hHZYldvf8XbAfDmmAyAUnm3dl0UdQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791974121; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:vCpUvbjpLAnaz3fqUHF7M+Nx8HLZCqkqBtopaID1KVvYxyj
	F1Mi1hDz0aEyYpbK2MI7Jbw/J+IWxuODOWi2a366CQbUy94BjOc3IcC1gm6sdgsL
	bz/g1k/SBIfttYQ0scUVINpJWW1KLRG/Om8YUgTfSr9lR0YBgYFuuXTnz2JJ2YUd
	kEgXsCRYkmv1xa8oKxoQVpTqVFdbqDErJHuk/4PwH+kXK25Kef9oC4h1FyV5iDSV
	iGN0jFrBmIg8ZwfrCxCdTH3UAFP58qtfaph5JXbZnnH6PAoO0EdcvNikDBJ0PoEg
	4fCbpPcZviiNV3OsIXF1IBe4vVofKcGfEag1OEg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DUM/5hSVJi+z6xoMMdcbtiV9h32/qVasEuZn8KHJxrE=:eNnPtTHpoVNKuE7u/YbC5r69L9qHzrsIwfbBP4ib2y0=;
X-ME-Sender: <xms:6VrPajKVX7WM6E3my1vZ6VdcBlMReRUDandCJ2Omghu3KZacz9sNNQ>
    <xme:6VrPauBYAhvULqf2V_kuMhSjR-WEyrpG-T0vennOuhheJAM5l3RGv0JJOjqmWJPW-
    I6UKCPb7-x06julFv9TZ6Ebi-uNKWfsahaM7Zezl2xDsdpCGBi9-Q>
X-ME-Received: <xmr:6VrPakCqa22E7pCLw1UK8C1eoeC7l8XenuV-dqqZLKdGnHbeTGpvxQ>
X-ME-Proxy-Cause: dmFkZTEQICkGBp5gbC6i7vO6Wcsi7XbaNtnX/kdZUiyMa38uNKlNkUGAS+qrDS1NgXI5BW
    IDQdhjmOtSzlniXdWrigfGUoesskkjR/ONEqnHzqvKUf3/dbtQGZ+RvMmphPAC5HB4qfaI
    NT+fnOwKwdDNfTq6yM8+vjHm8HQS11nuddiMzT1Pn310iAYbawgmZ7SX/53J+n2r7EJ9xm
    3KDco+P0jObTUQJiGW5Je1O9ojMb1Hl3+LvlgsqVw071Lm+g6UvH4bi16/UY8FxU+GnWv7
    Wcj/CR+DQZxz0b62swbmKGZIxjW5TOBUwrtmvbbKUP0sTpfPw8VW3kwMQToUNzMqYrNtqJ
    BSHDlI4ri4hHMWtaRepUtIZtOGoFlU9AyS9sbD2lR2MpsZ02VP6PWgFela0I1OL9CvRdn+
    hcs1G8zlk0F0rB+cprloEnGR/I0sr+kup4sBndCvxDOtfq0pxbNHriUjmiE5qZIVTut3k6
    /bL8TzV2GvSgWOeLTiAXo+LnOqJVkqA4QxaJZEhMnqpiP0nIEvIzBPw0sJBGRgvMEi50ZY
    NvQbSGaC/YdbxoClD8OdWyfmn+Ls8n9+GCArQWEiX14FCAonZvCNKiMkWOPQCB/pCydwHC
    oM9Sv/AoNOuqF6db9x1rpOetHN3bUzlq+8B4Gf2NO7slLpdzeA/RFk9ii/Xw
X-ME-Proxy: <xmx:6VrPaoAnbkpgy-Gzi68uwxxrxriTcezPJ-QyimoAHoUdxnV1KzZqLg>
    <xmx:6VrPanqOeUdWs5EOyfPFVhj5HxynqBXDuZsv4UR0QW3cAaCKLJEUrA>
    <xmx:6VrPaqmfN81B17pfjV5dL8DT4tHnskEDOHSj48VTLo9iuE0fWiPp_g>
    <xmx:6VrPavwYJm7_IkstFtr36Nnd96QIvNlDcsDTKOFPCVK2tQXljaNBpA>
    <xmx:6VrPaogxnFMxIKZIFHh8tsZyEgQWfRNs3KSmeaBAfNx9dydX8u-Z25a5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 06:35:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 929db79e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 10:35:19 +0000 (UTC)
Date: Wed, 14 Oct 2026 12:35:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 8/8] ci: improve reftable test coverage
Message-ID: <as9a5RngDLM8Miue@pks.im>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-8-04c24e1f480d@pks.im>
 <20261014092137.GF1341124@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014092137.GF1341124@coredump.intra.peff.net>

On Wed, Oct 14, 2026 at 05:21:37AM -0400, Jeff King wrote:
> On Wed, Oct 14, 2026 at 10:30:34AM +0200, Patrick Steinhardt wrote:
> 
> > The "linux-reftable" job exercises Git with reftables as its default
> > backend. But this job is arguably redundant because we already have the
> > "linux-reftable-leaks" job that exercises reftables with the leak
> > sanitizer enabled, and it is unlikely that we will catch any extra bugs
> > with the leak sanitizer disabled.
> > 
> > One may thus be triggered to just drop the "linux-reftable" job in favor
> > of the leak-checking variant. But the latter disables a couple of other
> > tests that exercise git-p4, git-svn and other tools. Those tools may not
> > be an essential part of Git nowadays, but I don't quite feel comfortable
> > with reducing test coverage.
> > 
> > Instead, adapt the job to run reftables together with SHA256. which is
> > an area that we don't have test coverage for.
> 
> Hmm. Aren't both sha256 and reftables by default part of the breaking
> changes flag? So I think we probably are already getting coverage there.

SHA256 is, but reftables is not. Quoting "t/test-lib.sh":

  GIT_TEST_BUILTIN_HASH=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-hash: //p')
  GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
  export GIT_DEFAULT_HASH
  GIT_DEFAULT_REF_STORAGE_FORMAT="${GIT_TEST_DEFAULT_REF_STORAGE_FORMAT:-files}"
  export GIT_DEFAULT_REF_STORAGE_FORMAT

So we will run our tests with the default hash function, but we will
run with the "files" backend by default.

Patrick
