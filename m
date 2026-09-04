Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29AE44C4E2
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514920; cv=none; b=CbNEraLnyn0fTkiShB2rvLEsNW5NvlmMwylEuneD7dUTiUfQqc8ob4YmziZtoq2fTwy3P0VN0RG++bnIoZOMvDx1utb69GLV6PWqhdNRfzsEbxDN9xCTiJvu/hR4LUzzInJ8jKEDOSg59Q264wSYOtKJO2NU1WEnvpA0sfSMNx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514920; c=relaxed/simple;
	bh=shl5ag3gYtMFCKQHuz7HWk0aAnEwGE9tb8IaRv+NCO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re96togetZaiuMJWZlZMkO5Mrbpqzu3YUbY5Khhsbvxzykaimrpz/M0QpL+ULNNFP25awpoigzXLsvirKA+Xy4f6nDGoPw2DnPMpPdMnesRU1Y9ZQf/9XuJI8gzICAyX9x0raJF0NFQvTMPHXLcBj+Nbfj4+2SUJqamUDr9emkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rZMhDUBg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xihVmttJ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rZMhDUBg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xihVmttJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B1AC81D0011D;
	Fri,  4 Sep 2026 05:41:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 05:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788514916; x=1788601316; bh=kjwx4W78Q/
	uEYW03klKVcoD4dc/O8IVVb+C2Uv9sysE=; b=rZMhDUBgfVZWIYhaQSBjmIrY//
	SG5/ubyAMxVXMDWIu+uYOt1jyHapJOLxLYQrrUZUX+pGur9pHtpBMO0vvGkuF/R9
	cQ8w6zKfAMXZCDJc7oFmnyOvg6vCr/sLo30FeyYr5Jb68BryWg4IUsDrQy3n34nR
	6EvMg6ahHu9djawBuT3qzMv2oC8M+WXXlsC1C4yce5j2rJoWMSt2ar9wgKT6SbHi
	fY6frGdGwkW8mJakxWq4xeOsqmOLTja7hdXfqftlE7QrVMaxhYld5dV8i0Yf9FQe
	us2mMMJ3bBTsTMP3wzYGy7aoFIqzQr4wgd03G/j4+Xb4GnW6O6C0NmuGgo3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788514916; x=1788601316; bh=kjwx4W78Q/uEYW03klKVcoD4dc/O8IVVb+C
	2Uv9sysE=; b=xihVmttJ6YfNKV+XKSJBTrRiCRCj/XJ6iC8SXKq9p5ixUU+6skq
	CMbbtXt4B2pIJGl3AYKannzwU0epov1WO5pVNdyCMcpXRIUKTWaJ2UTuBihAqxrz
	dYkIiLaVOJiWsxUtB47Hbf3ZChcw05IpQMEyue+U/ySfXZZcONbpTtjQu2re6G0I
	kMD+P9pRSvaM6d/ExIlky4zAGk6ntK+xceXLq9Y5laBHdmKn1hAqzdosyZRoEe0K
	DWnler/SkEXfux4I3F75dIfdZcTzoIhxmJ+9lLfSVQxA0/W3aVr/Xx4RGsbQ1F3i
	UiqKgBIokWIiL1Tg4n7hihbvUpnW4DgsN9w==
X-ME-Sender: <xms:ZJKaahZqoHGchTzpUrbbqXEB4ZYaI-Z3q23wHPuxrfZj62GD8Fm8PQ>
    <xme:ZJKaav3mthL4UrqJjlkUznSeF4V0toEsxrU33nnAfFGRszxlzBirC2fXZeN0b6B0K
    ZF-rI-VLzAkfSBK9uVaC8gROOixidlSVNpRytaW8uF2pHfR-zj7HolG>
X-ME-Received: <xmr:ZJKaahWwIdcB58PtK9AGqa15VXG9iZE3Bbv1oapSbJYZvr8zoR_p68jZuMG2dlBhD8jdAg>
X-ME-Proxy-Cause: dmFkZTEeRi9expALcJPDWNLKtwaRD23JekA/KnAzAlZbhyxSpzh4QOS5nuvGvu2fkhCkok
    nnXwueBRXXDj7Sl6CTzeRcutrEKmPkZMUH7m9/m+hKTpjbP71C3z8d+bUmmmZV/U1S1FyK
    0mB9YG+63H6i3FvYorE7qDEY63V8edx/WU5GI3/pMoCobjWGGP6piBd3loQw9hwAwt09Z/
    ei98y3K8mW+U7elFb8+NLuCoUOldN0N1BFc2UE4xdait0V/mg8isQK9dOXk41vRGru8Cb7
    /+v4ljA3DJU3Md43IncZed7I2lqlc5nE9k41lx/JoeJhxWWY11DWDR/wkNz9wq8OkrPnsE
    /oXOFv4533+9gLZ6lvJh2pa5GfNEJwmVBok+kWHFf584/Swf0k94ZVs9+VyJsKHLaw8+sS
    ZXhrEOXtnxlJlVqcLgLlvtimu7y/zANJS/gh5Et7oGCKEWELK6sO9vhKzAD6WRSSaNPadx
    g9/16jRh1LuBpe1mXYosTo/++7R2jSRB0y8rV37hl9DL/qFCV7VlKZ8XuXcxncHLIF+xmS
    ugOnMK+z2835WmlLUmiRK/IrB0bZIOmNsT0LLl8l0xt4KoG3HonSLuA4UmhxEBK4MJtrmn
    EWuBPI0HbxBdF5I6fLu3b6CkCbRSpKMsi7IqMMIh3wv0yskzJ9sAtRFhwhtg
X-ME-Proxy: <xmx:ZJKaapVasU8Iv4plrOP0wgaBB50WoOThB2SzIAc2016-_8mysAuFPg>
    <xmx:ZJKaagfromeVvJsJ73sf3t60Pc0wli3gI39Wca6YzSCgjst9r5waog>
    <xmx:ZJKaaiXdi0YpDj7vzdX3TDWDlEnKiadgRq6FNxfN1Lju5-UnicDB5A>
    <xmx:ZJKaapdwKxTt082uqSweIfs9R1mZqlX6R3sU-P3YNfPPh23Ecz3XFQ>
    <xmx:ZJKaan1Pz7gMugSayOX-zyAfAtivVNvWVOr-5U6Gu4s59NyqDxS3jnn7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:41:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2a9489ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 09:41:52 +0000 (UTC)
Date: Fri, 4 Sep 2026 11:41:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t3507: pin CHERRY_PICK_HEAD absence for a
 conflicting --no-commit
Message-ID: <apqSXT4lT7v0ILjp@pks.im>
References: <20260903125524.67889-1-f@lex.la>
 <xmqq7bl29g2p.fsf@gitster.g>
 <20260903214553.53942-1-f@lex.la>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903214553.53942-1-f@lex.la>

On Fri, Sep 04, 2026 at 12:45:53AM +0300, Aleksei Sviridkin wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > It is not apparent what problem, if any, the description
> > above claims the commit addresses.  Nor is it clear why
> > checking these combinations is relevant.
> > [...]
> > Can you help me understand the above two paragraphs a bit better?
> 
> The test pins the one combination t3507 did not cover. The file already
> checks CHERRY_PICK_HEAD after a conflicting pick, after a clean pick, and
> after a clean pick under --no-commit, but not after a conflicting pick
> under --no-commit. That is the case a user hits by accident: the pick
> stops on conflicts, they resolve and run "git commit", and the original
> author is not restored. --no-commit never wrote the ref, d7e5c0cbfb skips
> it on purpose. Your reading is right and Gemini's is backwards: under
> --no-commit we do not want CHERRY_PICK_HEAD, and the test asserts it is
> absent. Without it, teaching git to write the ref there would leave the
> whole file green.

The question is whether it really makes sense to have tests for every
single edge case. In a perfect world we of course would, but in the real
world there are a) gazillions of different combinations and b) every
test brings its own overhead as it increases both wall time and
maintenance costs.

That doesn't specifically mean that this one test you add here is not
useful. But we need to have a better argument than "we didn't have it
yet". For example we might've seen regressions, the logic is extremely
fragile or we risk bad consequences like data loss or an unrecoverable
situation if a property does not hold.

It's a thin line to walk at times, and I usually wouldn't care about
this too much. But over the last couple weeks we've seen more patch
series that add random tests to our test case without good reasoning
just for the sake of adding a test. And that's something that we need to
contain a bit.

Thanks!

Patrick
