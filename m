Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E77531AF8
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084373; cv=none; b=VP3QPLbxnGYpo7Y8+OlJzrUunq5SvGZE5uxdIhADyDeRwdsNHenS33bHhDvd9pOuTLM9IbX1GLgSsUJvUDH8CtJ5C0ylPOMRDFor90Cs6WTcW+F4Xzb1QbFa7GZH0Smt/Xv/ZKMbkYYxttjL8pDf9cStWGmoxzfduAmsSUc87NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084373; c=relaxed/simple;
	bh=suISy7EQKDQiIV77HcVO+NYf0ZFrfrUo9Rgb+7XD190=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=klQIlp+B3BngmMHcUFTfzcOQGILn7WpKdHJ7tQyfPGpUOQzYqViZNMbfAZyMai3HWsmr+ebC+sGgAYp8XosDMYUCvESF6AAw/vs/EJWBQGz7zM99QvJovAKwBKYQ6bKN1/TAOYadm9c53LlnyjYJX0TuIU5qBiZrLLkHEVPxO8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oPgrGY4J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yIwmz4J9; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oPgrGY4J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yIwmz4J9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97BBF7A011F
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:12:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 15 Oct 2026 13:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792084358; x=1792170758; bh=suISy7EQKD
	QiIV77HcVO+NYf0ZFrfrUo9Rgb+7XD190=; b=oPgrGY4JBNZl6RNWGpn0pocEzO
	6WoGsyL11mnOPQsidBYZeoNv/RuoPnHhIXezyAwcLstoX8ZpdU6oD9L/tmmMxvR/
	hnG0SCL3df+xQ/gYsNzcg9hrIEnfKLZQIoaTmTJlGwSVpBQho3Zos6bDOXVs1U7Y
	YHZ5muvRY3rdRc9+g5FE/TH16ZLujooWhzLp7cMvUca9etsTKh9LVluh/0Y8bOIf
	uEB0CgxhSwG+1lE1sFpGA14zoKCCBYrffUI47F03Fl47XGOsGd7qNAR9k5JiKBD1
	7YyEur+xBLleA6rJb0yR8W34wiLHBJlVmHgBiqQA9SPYNi6Lv8i2v9AkVmvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792084358; x=1792170758; bh=suISy7EQKDQiIV77HcVO+NYf0ZFrfrUo9Rg
	b+7XD190=; b=yIwmz4J92O9iSwYBm2kuTxSRQUGIanTyi7l0P7OWCbXe3msLXUZ
	UTq/c5l/VmsXQJ1F5P76Gl0n6VOKX18u+S/JTTZzGJkNYeOsgAFqw61S8EVhJWz3
	FdrF511kjxpenkCB+gbXZiBY4uFF1O+3ktrcX0VeoC2HoRa5U/UV+WnhJvUdcBTj
	mL0qFvrD2nFiPZMnvkXE7evEKm+aHL1bb74+ppqwPvRM8mb6dcoU3Kwkb2jzjtd6
	HoHwc4vN9onrRPTUbj17tnPCoHipKQwTKPtIareS9ol5Xqqx8d+yRHHJZ4HHRiIo
	b9NarC2Dr53CqJi/TUgHHSGaSjQyJO9TrrQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792084358; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:PYgl5IGTk047SI5kgyCMQCHLDZoNQkyRn7VeoD8Y8gx3kGe
	pIQGWgmdv9onUJRnYVPJTT8/f+/TUEbUdIKkK9Aqwo+yaxk92VU/Ds2xxolD/h+H
	0cocFDuoxTN7TZ2S/EP+aDesXfkHgAoDIvv7/eRpxSkwRZ3vcwaDlBUvsI7t4Dtn
	W55LCnNYSDx+pBov60x1hDUzd4GdAVRJMc6r95TUtbJIn1AmRvbbF1MjNQvcKLiS
	It1QtIVLhtbHT3XFqrQAd3S5Tw9bvpQ3slhnpKFKp3mKE8KLFOtd3cN4N+vODihn
	9pfGCcqilVOIV+n+Ls2Brxy9JhrL42Pje9NA+Zw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0i/OqKevSZiDoPHeN2LD1vkCpSNzv2vI1/pUBQ0HwOw=:suISy7EQKDQiIV77HcVO+NYf0ZFrfrUo9Rgb+7XD190=;
X-ME-Sender: <xms:hgnRauUFSTEKp3JraQDloZ6sU9wrYYJ0mf6xvtwtaFsubsB0H1Wf1w>
    <xme:hgnRauSB8JO9fV5C-4azhdWsPAxlKHB8-vjmXcRb1Ri0JVWuErxsjVWZ8CD_PWq0E
    KssIaIJ4aVYifAKL3RV0h3bkvvLcMyuSeJGA_Rkopk4Xykzpd-0p0s>
X-ME-Received: <xmr:hgnRasOADdHwe93LGfu1qE3Cf2sEReS7rzMGyvu2jg3ke6Ys3lfDIZWRNfACSO22OcycMH1J92b_vGUzqSUNlGFi_thCzUGJyzan>
X-ME-Proxy-Cause: dmFkZTFiiOvWj0PObESu3H7Cc9mGaCvTLBfvVYbVB2Nrh5b+6MkDa9RN3Crz03MXQurdAM
    KLTBIh1KW4k7J2jCWAtzEbyaQDZ85KeIf5ldMM9TDWQqZcFzjrbDaR1XHx4bYfIXl6oX+F
    c7VgBfrGMfY84rBATnWppsagjpnJ61c0vvYlO/L7LEbWXKBk7lNz0EiTZXmXGRuh2Q++VC
    ZZS+G7CcEjelv3HPazj0GnRJhA9hAKvRcXSoEgbFnXm/dpln2PZfH1WUiUZPkssCW2j168
    53WOweMboIERzfp1MeJbAErjQiNdk3y/0FyFVYgpSsnvj2gJvlX/tpVAz6x0/k9S1hPLBI
    7RYc0UqCqwAmvbY/9pD9ubJ27FLsxeLezV2c5ZpKZEuq1XtLoqfvuFtwr85W9Ml9UsfxC0
    b23K0JyhwXJMJi8h1cG+6kSBhwD0crANW262gCMHRWdTPHu13EwTnj10Kg3EEw6CBoGGbe
    24wyGMvacDOADjZvWxMZF+o5zdxHUzqGwU+4XAKeevXf4KPMg1YFbr7MaPZjwCILdc3MbV
    9Ujkbb5J3xMfZR2kESwyMILIueCk4qyemlt/8uas4AefAf7Ggx1kBSs2gfGzFHrcxyZcxK
    p33bFcpXYtfn1ERAuEKsgjjSZe8qG829qWsZf2jIYFagztM+rI0260LDThiA
X-ME-Proxy: <xmx:hgnRasR0INb1NNdvOorxS98VZlZqpFFWusv8qfQGdkA-xkpmRQLb1Q>
    <xmx:hgnRaqie31f-g5mM5qUnQznQGghQlxVXhS832esGk3BvxXgfb_fssA>
    <xmx:hgnRal-c0dTEAPfDx8rnN7hTDDoAV6_xhV_Jbb3o4MG_gFBuYGBYDg>
    <xmx:hgnRahFlWYeaIGbW6wybBeWD0BexzuW-McisXPvA2KASTo4N_XSReA>
    <xmx:hgnRahECOQUrMrCpprwdhaqbZDT0hkzp7-ewSNRiB7pgSu2awqCUb-oM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 13:12:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Todd Zullinger
 <tmz@pobox.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 0/8] ci: some housekeeping and modernizations
In-Reply-To: <atBoE11OSvlFIKis@pks.im> (Patrick Steinhardt's message of "Thu,
	15 Oct 2026 07:43:47 +0200")
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
	<20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
	<xmqqwlrktkzz.fsf@gitster.g> <atBoE11OSvlFIKis@pks.im>
Date: Thu, 15 Oct 2026 10:12:36 -0700
Message-ID: <xmqqv772opkr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Makes sense. I'll keep the base as-is for now. I assume it's less work
> for you this way with a primed rerere cache.

It is exactly the same amount of human work with a primed rerere
cache to resolve, but the conflict that gets autoresolved with
rerere still stops automation, so overall it slows me down slightly.

Hopefully at v3 this topic is mature enough to require no more
rerolls, so it does not matter ;-)

