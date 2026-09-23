Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7D1DDF0
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188748; cv=none; b=TxvWS8fewUH5RTyZ17bULctjdLQlhhx1k20YlUR07XYz2sg9UAyUzU7rW1KoW1zz+mKnX8fI+whvICWOhqPNYCtQTYZ7cn1k2rrqQIthlPvBfEFadVbMDCtW0wsXybALqDnSV8rSQlGpNhz8hSuD2u2+KTZmqC+dcJ6r8mZC5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188748; c=relaxed/simple;
	bh=jBLx/1Y8/zghWdPOB3rEq5BG2xVYwIzxGCI7AE8z9mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqM+QqpEPetidUwhSPKDIabNbX1/91Z0FidR58uxV53MTTuKSvIcDjMFbf+Mj/Xd0fFTvb7SgZmtguhnRD+MGCbPjGhGLlmL11+kNrjYNfYqo+p3CU25UXzEpkAVBB55RNnIczY2CEC9AXkjYs8P22q7re90XQ7fbOYGrtMa5HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qv53cAxb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L3pL9omI; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qv53cAxb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L3pL9omI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 425817A00EA;
	Wed, 23 Sep 2026 14:39:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 23 Sep 2026 14:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790188745; x=1790275145; bh=PANXRVrbSu
	v4aaX6guJxgraKR7kY7U879Na1g0yTb/E=; b=qv53cAxbZxwI9vD99LVrBTPYYI
	1flPgqZf2pJATf7PXqXSddmORZ3tInTHlNu771+XF+waoQJrNRvfDAHMYiSpcgJh
	IOnUqs7ehoTYnXcAg3O/eQPHqZ6EVTx/NFwzvoJXswrelwnPY/RkHFeqGrifhbxl
	3ZYC+9qRi/T25WawABN2tfOKyevnp/dAjS+GV/7QncW04YIn7/QAWXrzLn4l9+1o
	Mxz6vOgXtV75EsDiEfXi7vclBtHAvRMvJDuTvO0+kzoLDBgYS/g1m18XdtJrxpY+
	9LjWRtJdiaTBhsswoziPA81wRJXKdx7EoeIkHUiObuIN1pHIDMglNFinwuwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790188745; x=1790275145; bh=PANXRVrbSuv4aaX6guJxgraKR7kY7U879Na
	1g0yTb/E=; b=L3pL9omIuZrY3hG6p426FzPk+X6LMUgmoj94f+IGy3vhH6obn21
	ufpWa6Qmb3lJ2Q/smmY25B0FEXFBk7yTkuRPDL5f+ph0vrAf2qy+LlaacaNoYMDc
	uueeWWHaqbeHzffX+o7rVjY66F/oZDb62JIKG+/DaMsC9VD5lzPFHDMEBvDZkh6n
	f8d4wYjufdswd6O3acFedBv2bgIoz99b7D6ely69fejoD+KPRW82PeZCS9ADKeDz
	bLbo/uHxhKY4AxXl45HRwt+u+BkeCgp8Nd7u4z8Zi/vZEsBv10ENIOkgvjTx1CEc
	q/FmcFXQeN2TnnLknzlpv3UjxsI34rGfEVA==
X-ME-Sender: <xms:yRy0amwyixN1A7IOdpVzvjq6mbspPZjqFLZrW0GQkUE5KKQBb70hsg>
    <xme:yRy0apt38zZWRjTsdAKUrVrglIh1esTgdyCDwD_wM2oeVRAy3YndELhWVZbJVX1BC
    LNd1pIaP34BDER1VMjg18SWwtpV0oK0OSFg3UUQYFAmO4E3-ElL2qQ>
X-ME-Received: <xmr:yRy0als3gQR2O895001y_MfKMx7HX5e-YSW0L6hvJ-9gRIIiycDFAQ>
X-ME-Proxy-Cause: dmFkZTFGsHiyqpp9m+Im8P02+zyuxUmVWObuk94Ul/SybA0YmHk8PEb2HxQTZkLJuTH/gQ
    ULe9Gx5cZtCaBOmSGWw+mtmeDi66gzfnAqNJpHcWXMf+6AWL2I4jd4Wo3bXSBVvx4evor3
    Dr8j81raYLoc/qFyEBy50yp4RSmKcWPLFt4ZFsaDvi/bORr1Q8hJYbLOsjIndSVDGcintc
    xQ4dbYUp82OcfHQts3YENJRegXd/aJQeNP6ccJ8rcvFqzrvFpYup0+fE++n4a71dVK0G3j
    4Ly8wzm3utXZONU+7zNICO8EDPy7Qpa5/YKN22ALCKxOARNi5p0qrLkR1xkLmn6uCNtiHJ
    roqO2CxXJsstjtbOwXB646dcUJtunrzTzUClLXVyey2IjcT08b6xEOiQOcqcEkpdROdtY0
    X1nvyeO1mnpQiQouEVhpRbPKXPZXaMt7txXXVjzxCSPNIUbkJuTVJYaKEjR1A3oMgCba7w
    kdbTa2ZxuxKNlqujBkhz3f/Xb6RaYC00FcM8bZ8+zhyxpPDjGHorzixbOWFbTNh/y2ID7h
    zBmKIo0tSHrEezdclldX2+3M/PSz7ydFEoyg+BioUOLyxTONh+3/mmwuxUsDNpMb9tZ4RP
    sPc+ckHEuPQfoYpaXOfPawGKzrkd3QI3MG131BmA/K9xv3kkabU3Ph71/p8A
X-ME-Proxy: <xmx:yRy0amPXbt0Rk3Ou4YqAZBNnVcrsm4Hbmp974z8fid3ttI9IFhChSA>
    <xmx:yRy0ar0iWrFigL9pidnmM1rguYGOvYnZW6gQU9_P72s4gglpGep_8w>
    <xmx:yRy0aqMZZHXXtVg2I49-Rms6gxNHEncRAtdm3u0fCybgK2CGh1L1og>
    <xmx:yRy0aj1mvlRWIuNM2BlXc3WPgPi4QZ_mCGFL4KLHORTJyZV-4Szwzw>
    <xmx:yRy0apuRzWBMES8A7XRqaWba6GVO39Q3HSossbR-GasYeFcmZeCbrTyT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 14:39:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 927c5943 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Sep 2026 18:39:03 +0000 (UTC)
Date: Wed, 23 Sep 2026 20:38:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH REGRESSION] builtin/rebase: allow user to amend committed
 conflicts again
Message-ID: <arQcwhuMtcZNoAmI@pks.im>
References: <20260923-pks-rebase-conflict-bug-v1-1-3d3ccf5022bc@pks.im>
 <CABPp-BFadjqtOB_9cYkrs9UBgTp0hQxu4oiV_yqzYOuiu6g45w@mail.gmail.com>
 <arQZDXxf0139omx5@pks.im>
 <xmqqzex7akcv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzex7akcv.fsf@gitster.g>

On Wed, Sep 23, 2026 at 11:33:20AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > It makes me wonder whether we can instead fix git-commit(1) itself to
> > maybe not reset authorship information. But that's probably a much
> > harder change to do, and probably it would make the mess that we have
> > with the ".git/rebase-merge" state directory even bigger.
> 
> I do not think I understand what you mean by "fix git-commit".  Make
> it pay attention to some file in .git/ directory and override the
> authorship information over what it usually uses, and make sure it
> removes that file after it consumed it, or something like that?

Yeah, exactly. The fact that it resets authorship information of a
conflicting commit is probably quite surprising overall as an outcome.
It's arguable whether this even qualifies as "fix", as in the end
git-commit(1) simply does what it always does. But it probably doesn't
match the expected outcome in many cases.

Patrick
