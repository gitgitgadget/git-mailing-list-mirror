Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038333EC835
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393982; cv=none; b=UkNa231w9ZMYSlaG6hbQXu4UwLWqBcKTGdgcnDw0J/Nlm09UZejvOLySX+pi8xH9rViAzYHxTmccmrKeSL3fGxtZbeJfYxScnYm3l7OIUcifl3lKEsWBieMJbnMUEHJ7LkS8lLeQkkMmC/fbtxL4jTQS0M4UkIGNL/ETWMwJWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393982; c=relaxed/simple;
	bh=ZnW0VRcVPaVK+2ZZRja6Hj3QSMa5kYY6Qnw7sjFZXgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRGaA7aCdY1N+pL6SG0lFEd+jdWLBaJs1vBLINqXNf645xfQqaWLHgtHC/9Vr/cd0tupo9OH7AIdlTqedT3BT/2s8pRQHF/wuMIO8U+2TAt6G+2v+qhtqanEk4hnBbhazHWOXnUuMMY5Q3pJaKK0VFjiFO3ImMl8e5ZLJadak+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=u6wnlR6C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AhcaK4Mm; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u6wnlR6C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AhcaK4Mm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5FD767A00C6
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 03:13:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 19 Oct 2026 03:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792393980; x=1792480380; bh=PhET1UY0Gs
	G1Nl5uFFLI6OVUprEvES4JcZ8fUYW8+qs=; b=u6wnlR6C1L9y+yB6Nka3uwjAfC
	jJzEtgsqM0BoSSGySsScrBz8AkPYuKcjnFQwgflsF9FI+mfzd9xAaSqBwMM3uEM0
	8GeJbFUNTcdB6Paoz4gZioiT7/sebKsGJJSi+5ECurKHqF2yvVXskJNpIjnci53L
	QoWHmdO9SWtQ93IkUs7R0GdHnyzcbLUsx8jB8f0S2YB6T2NVZfkkhPwt8s0BOQd1
	bZoURmLFWMzGsD6Owe2KY5YFsn3XlT+MwY+D2wzEwwPpood9ynMU2V5fKZQ+6AgO
	kWlR1kH3qXiTiXWqLdf4dUhmydVXVyip6561HFA1NF4BXRvWjcR722IPKlCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792393980; x=1792480380; bh=PhET1UY0GsG1Nl5uFFLI6OVUprEvES4JcZ8
	fUYW8+qs=; b=AhcaK4Mm/fmkS5j5CA7s2Zr3LDHUQgkiTUEj68MPleIlHiHCE2G
	PkPSsLOjpNjotYuVt6024Dcq0Bf7Tas4vhBmpYi0T2GYAiBtdoqE6XYqCZQjHN1M
	B/OCqWWzDdXcaGIlc5US78DZN31ftFCtrNnohysmIXwiLF7m+EcQtbr4HG0jaUOu
	aStKZt/AMmOQdDcEZ9cjJazRFxa0GTG+S5NKu9SKRXg2dVgamKFFGmxAMkXL4hSD
	lTuWCmtl8PEoz0tLQhBGfvcNwShKbeCVWWI30v/sC2uqL4pH8dc6V/KUESnn9w2u
	1lvSoLzZ9J05211wInLvofizgKZt6Tr/yZg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792393980; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:q6hFTUlRC0cZYCm23XAn+4dVu9EORhE1U/MTu3eEUn2EzAi
	NFOlk6Ji8M59X6K/J2NkkJtPFOm1QJYQlZ5DSMWO2aTmNfTzV4KbDQ9b3Qqz5xfT
	nPfMfdVVYKyG1BKsqbnaQzqTbG0d5ugse7YZ+k/ATf0LCC4xay/KRUM1t2HZAK8D
	t5gGdZafuFfpY387SOtWrKit43wBndo2brRs7vAsXf5xoliLHGkc/rVNAuoLpflX
	88PXWw3pNxlMcsi7K3YpPSa+VPilzHCfg+aIM1IO2+1MXBgG6Ixqeh6EBWLWBOJo
	FxSKjUBO0RPsn5qmkNUql2dprP5Lzc3rwiwrwoQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:HINQB0vm0m7x77Wvxqn7XMo+DftYY95E/pilXYVPl4A=:ZnW0VRcVPaVK+2ZZRja6Hj3QSMa5kYY6Qnw7sjFZXgg=;
X-ME-Sender: <xms:_MLVanOmlrG4VE_9a-zyH6JTrv5zpXKYrZ6pt8vFJTeq3sYmVimSFQ>
    <xme:_MLVan_QR_sxCe9oTuXx1iZQE3ytxWHrP2Mdc6BYMH-zF2tZpJWcohaVk8irZxwVP
    Uazek1IWOeq7FUAyfIW78r8jg4ZKKptR1f6gkTFxPnB_CISU8ukZrM>
X-ME-Received: <xmr:_MLVaj7WQg44QJP9aYQpf2KtowzxzvWzKbbgqlWQs5ZATuxwlUwCeg>
X-ME-Proxy-Cause: dmFkZTEJ90UnX7100m3Whx51FTFKmbi8kkWZo+rEz0TraHrv5n9ukEGGuESzbAUf1aHX7F
    sNOu9KpGP8/08RxJXsBqPAGI8NzRi46AWVX5hJCdm4BzS4vMSGWGI7oa65Zjrnxf2kGN6M
    DFjnlSuM6hQl7i7KMWEYYYwYCL4eoZFVfj1nbb7vsAYpK+w1Knuk9hEjTzuxnyKoJ6Ft71
    7LfCBfBNns6go+E7zv6hhfj3sWhGYogAmRnvd19DOFv7Nr97gLvzpH2VKvA4TLoquUS0cY
    kTsbiBIlUAEIwnleYGn0py9CC8ueRoKGsgSR999ebd8GrGZxbzZZO7rNouLjapLQQ1dWN8
    uzCmALDm/MFG3oGXTiukWvEhqpZ260tyJrHc1XWKgB2v2wFW+8C07JLXb/by+jrO12KBS/
    3WGqNivEXT++dQVyNBvVsBiAi9f7w/bjiG/N89NBj0/VJZOp3tMJGrTiWqmCSvPQO6mIiU
    +qO89G30olT23LlGPe0iCi/jAEgglXcuw1v4WIDxliECbEirdl9Yka8qpX7aDVxHm7FhB7
    ulcFisR9aWdKfxAY4VAFtu/I3LxFMIwdrtpxF2DV3LTrjM/RllgqyUsk1xYJ1KRDLzrpU0
    e20Pm0gLG/zu9bLAiC83TvRF2wrp6MeH8+PQXuxzBEI0K1rvx0j41kdvDB5w
X-ME-Proxy: <xmx:_MLVam0184vrCO20LndHADf2prxBuh6Nls4gADLOQMkfLZEP1GgRuA>
    <xmx:_MLVaiAr0MizkMyrbMz9lC8orwApGJbJrcQZ2-nCGpRO9Zh69hN86Q>
    <xmx:_MLVag0IeaZsy_aBfxvdDiydpADhu0PUnMQ7hn9dzZE58DqWUzbmkA>
    <xmx:_MLVakvOVCy_9bW2fioaIgRwHP3tp4Jlzii3jGaVz9DEG0TzreWIEw>
    <xmx:_MLVainqtr54NAw38gRdBGlgGzX6sYCgHhNMLfSCTQApnHmEDD21k01W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 03:12:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0bc36cba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 07:12:58 +0000 (UTC)
Date: Mon, 19 Oct 2026 09:12:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] github-ci: update macos jobs to macos-15
Message-ID: <atXC91tL7MHRioPZ@pks.im>
References: <xmqqfqy5clgz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfqy5clgz.fsf@gitster.g>

On Fri, Oct 16, 2026 at 03:46:36PM -0700, Junio C Hamano wrote:
> diff --git i/.github/workflows/main.yml w/.github/workflows/main.yml
> index b229739be8..d69f6f2b10 100644
> --- i/.github/workflows/main.yml
> +++ w/.github/workflows/main.yml
> @@ -349,16 +349,16 @@ jobs:
>          vector:
>            - jobname: osx-clang
>              cc: clang
> -            pool: macos-14
> +            pool: macos-15
>            - jobname: osx-reftable
>              cc: clang
> -            pool: macos-14
> +            pool: macos-15
>            - jobname: osx-gcc
>              cc: gcc-13
> -            pool: macos-14
> +            pool: macos-15
>            - jobname: osx-meson
>              cc: clang
> -            pool: macos-14
> +            pool: macos-15

Do we maybe want to update those jobs to use a mixture of macos-15 and
macos-26? In GitLab CI we use macos-15 for osx-clang and macos-26 for
everything else. Like that we have higher test coverage compared to only
exercising one major release.

Patrick
