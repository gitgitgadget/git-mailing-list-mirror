Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C303BFE38
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887082; cv=none; b=Pe1mv+kmFIffREeea/+fd8rBjE/RWIh5WY3AYfS2yBGPnFR/COpl4v74ARNC//kxE6dvChxp3+fpqbxmJ5/BC2W/Hm2sIUHryYWqlDxWVdCAysYDpzrDCpVIvAI2UxqonlnbabQgWJC1B94e+EatH+O9GvNWo4vnlWdXtDNg+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887082; c=relaxed/simple;
	bh=2wnqVUOt7hv0jwZuHRoC4SKAG2asn8UqM5ig4FGMY44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GWEyAYXPVeLQ01m++1nReymPJ9bsTj3WCEL+ASLhAbQFqeYxH23Iuklx7gp7UsG1Y1N4PEt32No1VKOpgm4+CkLMsMdku6Vb/H1T5qXPnZ9RW80tmuaBT2hALJeTk42evrqpRwPiBhC9I8jHBTx1dw0fx0WuWofMpFP9YlBBK0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SxV7K1x2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G69+1eNM; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SxV7K1x2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G69+1eNM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 49E2F7A002E;
	Fri, 19 Jun 2026 12:38:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 19 Jun 2026 12:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781887080; x=1781973480; bh=KutvYvl+sg
	9qMN9so0ThQ0wTjWMarlqOMZstk4LZr68=; b=SxV7K1x2FXrZbPFVoscdaAyuRV
	R6PP+j/U03rq2gJjOVZ6c5ZKP5P4xr7jIwEkJGfj1j5eiFhPa58RN8C1iNlBWt1l
	N+rwyWJYL/d+0JWPkUuMn3geCPDMn0DRYu+A+x5C2gfoc4L095gyzXYqoGlJ/tKn
	hJT7GTDG4HH6onp8929K58vR0fgW1rMDoxghdBcJAIjQ35BMBRtMc6JHeehzhuD1
	TfCdY6sZ4VOPToebkyS8nDJjGJATg+OCUebQrpV9It0wvTChbeur/ZeBFGwVME9q
	VYwVsNUS8pc4UsoqC2IwotYWUUWDHOTuLxWcGZ+33Ah9ndoNhAv0JYhK/3EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781887080; x=1781973480; bh=KutvYvl+sg9qMN9so0ThQ0wTjWMarlqOMZs
	tk4LZr68=; b=G69+1eNMAWBpw6zkoDzhkm0jkCXZjkYZakJv+pIzka1G7tEJiTp
	1S89AsY7rFA5jP4SjWhgfkztaMcqBDtb004xzFoIfSvVmjvDMf/pLUyVkTHsc6st
	29jUrx087bw104cme7yWLFLQFtYNt2/ovH0g0X57l7H6SaGs6b9Qrm8wWBXz4f6E
	99VLVP64vTQXn8fr3Maorg/DJvytx2eOgeIrjw1A64W5LTPAjJJHOjBfppF/vbRO
	xzH64V0gZI4AQLFkn9k4BxQ6N31X/S+W51Pc+RZWRXrrugBpbE+BV1YhpXMK9u0H
	cer/KEaW2WDuHoqLIQYPfnnApAMFy69XIPg==
X-ME-Sender: <xms:aHA1ah97twgEnK6E4wmrP7od9AddpFsEznZUsYPiRcs5ZzPXalQS1Q>
    <xme:aHA1assGgFTW7ErDCFVpENrotzN0f4a2GIaGEFojBmud8bqQr1cjYG_Rq9KN9uV72
    3pPIfGIIRDqoVO5OeysalDY__8llWTfZu2g5SROa23gC2wlWzJFFg>
X-ME-Received: <xmr:aHA1akBUq7sV1i3jdkIgmyYlNjUG5UCP-z-41orA08pH3TH8tPR-6OWcj0lqEuHoF2OD-F8yZk9Q1REHmcnGTugMIWzAvDYbX_9e>
X-ME-Proxy-Cause: dmFkZTEmXXMK9/DvzZVKTkXErXX59kO7YcTxqLB6fEfBHCXe8x8oDJUMWqras8NjdsN2qE
    9XWoxBPmxLk++RcLPf0STLSpQ9SS66LuyybEACtJVHJZWoumsxLNg2Lyx95WAc/J8TYlDZ
    7yl635rRZyadMpOFkhdRYYPWDBMZTq6Y0WWAQ75sYjSKHPup5TRrBmYr/c8QW3T1iLMpVM
    TPipJAO2lpbO2+kBBAxXFtPspcuxUEEy0f02W2e4bgCvifwDaaRQ1NvWYtLWWs634FiKsB
    TAj6bj+uvNO9/z6L7qxqYw2WkKVO+ZIH5vWfob1dN87iBjukWJrvoKyc9qeEAT846Wu2pV
    B4xDnFb7Jep+BhADy7CiDZnlMBhM6GhBetHaqiKc0rdkZg2SKFsIWarsVfrycHGLOWWUfT
    vR6RJOYzuE+IVVoyqjGSJsV1yBRlripga/U45TsPj/CCL9R8co1+P28XJBheCxJ6FwYYOC
    p8St0K/e3vXBTFs08dnD1S87+AibJ91R0PHTO3KC7bpD4Zsk4H9zmN9Sxi86K8p0Ws2345
    7/YlpwopptQ73/Kc/f27+XwtqYc3yVVjoI66VISrg42IztA9TLXL0cBwaGRq2CWeVZgWPu
    hJecAOJqLJzkis5YzQF/S9UqTl79BE09IuWtmZPbo+Tem5OxowmAGd/GZsCw
X-ME-Proxy: <xmx:aHA1akVtxNmbKPyjCQojaVDwy67k6DImQB9JcRhJnUdY9hehrfQaXg>
    <xmx:aHA1aiC6q3GrcaBJfsydFc9h0cFLGP3PVqcu0gzlhcJYdFajTDSWWQ>
    <xmx:aHA1an9NbVNl1e9m1tLq8sa9PnVH-K2412xSnvGeT9B1fyMkKOyZCg>
    <xmx:aHA1apEsKdQsTj4GdjgrtXE6ZIT01DUOD3Rhg_NvHLyLjEwUR834_g>
    <xmx:aHA1anhK6qEL_WS4wX_BD0nemDK2rH3De5ktA-wU_fXMtI9pldNZosik>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 12:37:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jishnu C K <jishnuck26@gmail.com>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] help: prompt user to run corrected command on typo
In-Reply-To: <6a34dc40.2c570c9e.381c97.203f@mx.google.com> (Jishnu C. K.'s
	message of "Thu, 18 Jun 2026 23:05:52 -0700 (PDT)")
References: <20260618142033.15216-1-jishnuck26@gmail.com>
	<ajQuqTB580gqNP8D@denethor>
	<6a34dc40.2c570c9e.381c97.203f@mx.google.com>
Date: Fri, 19 Jun 2026 09:37:58 -0700
Message-ID: <xmqq5x3elc49.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jishnu C K <jishnuck26@gmail.com> writes:

> You're right that `help.autocorrect=prompt` exists and is similar.
> Our change differs in two ways:
>
> 1. No configuration needed. The existing prompt mode requires the user

I do not particularly see it as an advantage.

> 2. The prompt includes the original arguments. `help.autocorrect=prompt`
>    shows only:
>
>      Run 'checkout' instead [y/N]?
>
>    Our prompt shows the full corrected invocation:
>
>      Did you mean 'git checkout neo'? [y/N]
>
>    This lets the user confirm exactly what will run, including their
>    original arguments, before pressing 'y'.

This may be an improvement, but is there a reason why such a change
must be done as a parallel and unrelated (re)implementation and not
as an incrementa improvement to the code that implements the
existing feature?



