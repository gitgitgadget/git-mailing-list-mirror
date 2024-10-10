Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C40118C03D
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539785; cv=none; b=KJOnpg8oDU/KfK5pN2QuLexRTnu/80AQ7bqlFhKJFK2Pk2Js799UFeHcQpa/v6k2nLG8XbaSpt3ydKjNagFu2H/x+tXe0KoAusENHUR4XNSyVwHiQIV7STlOeWoLWuwyliS01XwSB2E6VRQP/rFZS1HX/i7yLZOu8Zs8axkaw10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539785; c=relaxed/simple;
	bh=fqQxREUtW2gLeiQzBdz92A8jJ+25R3mZzxmnPxnEzVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXvEMpl18zgI14NXAY6xOMhP8sTjxYw3N4pxLupFGdcTL1DYQbBhy3uztPdQo76gAO1DUmDzVK2IunrEoOSUXJ+Efq2GYj8ihlivQzWdPuTZ3VigLUFDx6MkfhwQN1bbSdalfai/wBb120nB/IEmEe5MzZ/eVh28i/Z5+ubH1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EDbOT2yE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SX4XxABb; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EDbOT2yE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SX4XxABb"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 356C413805D8;
	Thu, 10 Oct 2024 01:56:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 10 Oct 2024 01:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728539783; x=1728626183; bh=EhBE8Y3LO7
	+Ne27/p0bghyV46wBnvqgNkQQQQAImMVo=; b=EDbOT2yE/GvadKHQa5IZUURDSG
	hQyHnPLwuE5FCr1jEWUiOogptbgM195wJ/SdMl8ky+pE5TJsDTc73pJvi6+K7Irv
	oAP1Kiu5WFLmQmojgH2yRVxeT0u6/yTyWnPJduBMoJ4zF0d1U1U8iEylUqrCl32/
	XQQDizzYjz1Xqx7/BGpDQHN6M1yS/Ou/9B1Mtw62CehzlS2Rv7nYIL1MU9jfReW6
	+mddRGmMHhnrLnuK3EID65cQbUZgueO3Qd0cdyXY6gvl/kQGAx5t1nG8CyiSplsq
	nps2wAQo8DNQx6h5adlGxA8/9K7XFKrLZBcVL68w/wghFNEO3H4Ve2bn4nlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728539783; x=1728626183; bh=EhBE8Y3LO7+Ne27/p0bghyV46wBn
	vqgNkQQQQAImMVo=; b=SX4XxABb3z8NuFt6CkEplDd6cdcvvkE5DOWB61Hdq/nK
	0mKAgdhXlA0A6JoTFexYYZXtsxKsI+47u/5KUXR93mhleoGKsWnC6WbJetfiXeR4
	V9AlTzQhF+WleWoY5w4AG4fAk1yfpDy2I5HQ5xAkQKrtwD6zWJfSEvE0Cpg4iejz
	maH6wY4Q1PGY/yb1Dq8DLOQ0ut65m3uNLJ25+vqSr5MFggjg6ENSyt2GXbuAMlPS
	gdcCyndFZ1MT84Iw8R6Tia2RYve9UigOqVVN3LOZf++Vv2KqShPc96kCtV+fQIA5
	H9QLe5t0kBkw96bCguYj/zZUnB5HgpXg5Z2WU9dhRQ==
X-ME-Sender: <xms:h2wHZ4uEYCY1AkQtN-I3-_8cQeiJqWW3ptDPewAQTWUrIf_7FpvFeg>
    <xme:h2wHZ1dtRxC7hD18lW8TmULZJCqxL1E2qXE6DEexqrpRnuVDV2aMut-Fp7kbdlng8
    PmZsZO70mCL9QlhzQ>
X-ME-Received: <xmr:h2wHZzwQOlDSYqm-C6vZLjA8shHUlF2EWyVciRXu3t461oPmD8Vv42rLtGcSJqk6xKKGGnnkIN-THgtMyXra4JXg3XsTkdoLEFBwz-DCqL733eEz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:h2wHZ7M9gpdcRh6uyP_s56sk9TOjTviemQtHsHnqXLw9UbfiPwPu5A>
    <xmx:h2wHZ4_bKt1dY2Jc0UGVvCWuepHP1ItkkC_yctCBN5xOFKGmRlR30g>
    <xmx:h2wHZzWSPJexHgf6KypmluMh9bnfHSFEwD3N04qt0dofVDmsLVsMeA>
    <xmx:h2wHZxdwnwFlSC5-0AslFUD8ugw9j0g3AaPL_Q1sGIJjSP12cO0bnQ>
    <xmx:h2wHZ3Yp7w-hoIFC5e3WgOOZlQWolNGPJBB8i_nKfnaGuXMjtUNrAAO9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Oct 2024 01:56:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81ea2135 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Oct 2024 05:55:16 +0000 (UTC)
Date: Thu, 10 Oct 2024 07:56:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/5] t7300: work around platform-specific behaviour with
 long paths on MinGW
Message-ID: <ZwdsgHdNp108lISP@pks.im>
References: <cover.1728480039.git.ps@pks.im>
 <bdaf16a06168b7320e8dd1115258f00745a104c7.1728480039.git.ps@pks.im>
 <xmqqr08pruv6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr08pruv6.fsf@gitster.g>

On Wed, Oct 09, 2024 at 11:31:25AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> > index 0aae0dee67..12ab25296b 100755
> > --- a/t/t7300-clean.sh
> > +++ b/t/t7300-clean.sh
> > @@ -747,7 +747,7 @@ test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
> >  	test_must_fail git clean -xdf 2>.git/err &&
> >  	# grepping for a strerror string is unportable but it is OK here with
> >  	# MINGW prereq
> 
> I find it amusing that this talks about limiting the test to MINGW
> yet we need to accept two variants ;-)

Agreed, I was quite confused by this. I hope that Johannes may shed a
bit more light on this, as I couldn't make much sense of it. Was this a
change on our side? Did MinGW change? Is it something else entirely? No
idea.

Patrick
