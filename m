Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC055355803
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974118; cv=none; b=DSafmomdu1iRKMYVlrdGa6Txd1ot/baAFSrp9vmWIYAOGGtlXoM0xoPmAsR/fbRP9vx/UM6kN684NzBT2XBLyfzk/6GTeT8utxa64oa9t5/+744L8mpIszCzmgmHkrk+TxkTRIOR6qML0n0PTyc7Cs7qAj8Q7lVf8NCD3GEXnx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974118; c=relaxed/simple;
	bh=Ejo2Dd6Ui9C1wi5ck42zVcNiYRpH4qPfvf949UAQ0w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m03liRMZ3UB2fh13eLpaRj2WU6OV3y1IWE/br/qnsfohR7PsVvOFCL/wXq6k8Jkr+Wo29nveJJ82J3iCqE9oGVOp4Y8bFUJH5bbvqIworl0GZJxn/Drf+Vlyap0NBkgotuz1XkLBjXaeCHJd4I8i4Be5Zi4tSDNwdKwMVuMIhiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V4KcHFWE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RXys4VOz; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V4KcHFWE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RXys4VOz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED90B14000F7
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:35:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 06:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791974116; x=1792060516; bh=vA5C06VNq5
	4o4MwO9UrQMb1iH+sUOCXepErtEJUBqkc=; b=V4KcHFWE33k0oUYAP80NCo+bnP
	k+rKB75s30gE9mL/tQskQqs9I/boCRjFIIYrlvUpIWuBqWtMN2R+FwvsH7+t62IZ
	FlrqatGJmLgX8V4DtfKaLVqdqZVziZqAel+TU1UvL/EyoyQJpSwsqxwvrYVtUM1U
	TM+Rg7PLh1TtaIUn+Y56kx/1nJoCNuou+7P6wqPcSR52ULuC+dWN/fkcWa7IOegI
	rY9993LE2sk1JDqTHqTT+YBMzW4zP0nfgWn52ZjDSFuxByZU0LH95b/4JEd6Vjcs
	v0HI6QXbupFqmr34bUmpG2U2cH3mwRUxtH5+1cZbedd6dIEO0bWYOZ+g0h1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791974116; x=1792060516; bh=vA5C06VNq54o4MwO9UrQMb1iH+sUOCXepEr
	tEJUBqkc=; b=RXys4VOzjfoYsKBbnuzU9KXmXtJzZoOEO4OQEyPhIsAdJPWCqqv
	GGO6JzZBxjhhqi/3ZGdc8jVpkBCFAxJTgfjmK9NOx7zrOWjbtaH9AwiKJGNrH1fr
	qylqx3QjY7izvcZkSkFyOqd2med7zSxUvYrsGvHdA70gmzkas+t/g7Zp4pe35FB2
	aFA7RMONfg5iLzwiJ1XV7jTUwgAAlBpSiAoJ0ay3CKl+Y+ppac0jVzhhL2NJ/kHw
	QTbBJ4fKk0//Z45ppylKFFP6XHJJfWTw4GOl3ARMREbBYizRxYdNWUYgsf44oJ/B
	e1XaVMdzygIFL6iiu61xk2udz/Q9GAqxGtA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791974116; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:LMX7bDHyVHsDM1ZdZrWQaBgGpvt7zgkJIarY4vYUR41MCrQ
	dtYSOAMsZ/QLDoEKKnZRGSyCnMMWw+W7I5bJJ9Pqzlyc3K4Z/AoNHdqYyc0dAYsn
	Sr93ZH6sIq1AqZSazsSviwCEvWDHc9noRWWkblBqfiFvUJvjiNiqGFeECZs+bVpm
	QVhx0QtP2UjRS5r90Lf7ZhHkFIoftILDcFFfexO951/+ehJMdFwbzPLbr0tU3GUy
	YXZadTdEF65o7uiSmCc0vOajpCbt6q6ltRNXeyt4mJF+8Dal2bw3BSL8/vsYTkRS
	A6/RLZxExSloFqOMMUtG9foH/erlflvPgggG/nQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256://bwKqD0hiYseSCnjdI5z9HEA1zpSOvc2hQqN+MGvcg=:Ejo2Dd6Ui9C1wi5ck42zVcNiYRpH4qPfvf949UAQ0w4=;
X-ME-Sender: <xms:5FrPas_dYImFpxIQg8adEpCNxOdssLEhBKvtWIadR1T6450EJky7IA>
    <xme:5FrParlRh53CDFdcHlXBcnjiJoLwHSJAe5AEYLn1rWk-JI7vjpLNos_EqpPGpqya0
    wCK_ToPirUyIyGu91aNVcILMjHPxWkoaMh2KqNdXa3-e3PWh58-vg>
X-ME-Received: <xmr:5FrPaqWUqA3vuozb5pjBNa2NeMRakHqsNvfXQWhrODbURN0MRGv-mQ>
X-ME-Proxy-Cause: dmFkZTEQICkGBp5gbC6i7vO6Wcsi7XbaNtnX/kdZUiyMa38uNKlNkUGAS+qrDS1NgXI5BW
    IDQdhjmOtSzlniXdWrigfGUoesskkjR/ONEqnHzqvKUf3/dbtQGZ+RvMmphPAC5HB4qfaI
    NT+fnOwKwdDNfTq6yM8+vjHm8HQS11nuddiMzT1Pn310iAYbawgmZ7SX/53J+n2r7EJ9xm
    3KDco+P0jObTUQJiGW5Je1O9ojMb1Hl3+LvlgsqVw071Lm+g6UvH4bi16/UY8FxU+GnWv7
    Wcj/CR+DQZxz0b62swbmKGZIxjW5TOBUwrtmvbbKUP0sTpfPw8VW3kwMQToUNzMqYrNteD
    Ll9Y+x0DSP1ziwyIHbWYqp25uY8iqP0aM4MD73n62o/1rI3mwySLhRvrILkBt+4z8uqg+3
    I+LCYOaNrpHK0/fH6pamkFmRvAYF/DwKulAuVeJSZWb2IEdto9RTl4KffPKnTLsoHtdxS9
    4jo9as8Ivg0nszR5symtBkIRQWjFeJIeBBlNpnaVM6rfOCp6lcUwBlHdAAaRMFebIdvAOZ
    9KpOFp1tcOalsQouJCTMVWafiBv8Sg44JSFC+au7qKCvxndfacbnvUt+sf6feC3qHiNu/P
    lI3nNm68s7ybkm/J8iP2bhVymls5VrrSlA3o6X3E95hxaL+SLjFEQh0xjQHQ
X-ME-Proxy: <xmx:5FrPaoGyEOpUolDzaUiqInPgl0NTgsV2ozx_4-Hs6DDxsrQaAgOp-w>
    <xmx:5FrPauejfUtSWF-pyEpCJ2BSfR_mQ13jH7P8CP3HX9bsqHScaS-YwA>
    <xmx:5FrPahKtsHRjq4pNcQVsNscEj50ghjgACiPonr2exS6zCTrCGmHDdw>
    <xmx:5FrParEkielJBMZv0XkLNu2AM4aRP5869r5EurMSBru5ewa_R4YRBg>
    <xmx:5FrPaulOD_n0nq4eC5HTW2PnCG8RPo15QxCWtH3Vu-e-ZuuPSFE1f7HH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 06:35:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a19e5c94 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 10:35:15 +0000 (UTC)
Date: Wed, 14 Oct 2026 12:35:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 4/8] ci: switch away from unsupported i386/ubuntu image
Message-ID: <as9a4WHSXY4pagpp@pks.im>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
 <20261014-pks-ci-housekeeping-v3-4-04c24e1f480d@pks.im>
 <20261014091705.GC1341124@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014091705.GC1341124@coredump.intra.peff.net>

On Wed, Oct 14, 2026 at 05:17:05AM -0400, Jeff King wrote:
> On Wed, Oct 14, 2026 at 10:30:30AM +0200, Patrick Steinhardt wrote:
> 
> > The linux32 job is used to exercise Git on a 32 bit platform. That job
> > uses i386/ubuntu:20.04 though, and that version of Ubuntu is end of life
> > nowadays. Furthermore, Ubuntu 20.04 is the last release that has support
> > for 32 bit, so we cannot upgrade the image to a later version, either.
> > 
> > Switch the job over to use i386/debian instead. Note that starting with
> > Debian 13, support for i386 has been reduced [1]. But Debian still
> > releases 32 bit Docker images for the latest release nowadays, so we
> > will have coverage until at least 2030.
> 
> Makes sense. I did notice this hunk, though:
> 
> > @@ -48,10 +48,6 @@ ubuntu-*|i386/ubuntu-*|debian-*)
> >  		SVN='libsvn-perl subversion'
> >  		LANGUAGES='language-pack-is'
> >  		;;
> > -	i386/ubuntu-*)
> > -		SVN=
> > -		LANGUAGES='language-pack-is'
> > -		;;
> 
> I think we have some tests which use is_IS as an exotic locale, which I
> assume is why we add this dependency. Do we need to do something similar
> for Debian so we don't skip those gettext tests on the 32-bit job, or
> does it just work on Debian?

On Debian we already install "locales-all", so I don't think we have to
do anything there.

Patrick
