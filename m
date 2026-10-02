Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2061734F24E
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926694; cv=none; b=VoTXUtMCALjeDkqOW8K/VvrDiJqprjXXpqeCZYruNwKzQZWzb5SGC8/j4BwNDVNLv9AWIjdUfWr7tD1LAGKIDydSWnaw5pwKAK++uKlc9wXwbVKCg60G21fPEasaiusohQ2m5BXRhYGeX8GXP23YkOTVBAL7qPhYBn0NTIhI8PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926694; c=relaxed/simple;
	bh=CcdIBvMI7NwoJQh1BHJpGdPXieJvxJeHaybwo9GbVhs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=edTm4Ff1M7XXnrdj+/bb6JW4wieNq5vpTOXaC761y3VuroxQrPCuqZiV54CjCe7nqwKxdgePkhniXwUk/Yzqfb/aTpWGAVirEX262H3wRi7dCtSPaw22UxiNOzLeRhL1XvVU0XGLDTKGTqRI5lnP3KCddTSVQBVqB3/hs8XCNZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RAE/Zt8V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lQ3BPzf/; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RAE/Zt8V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQ3BPzf/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A104EC027D
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 03:38:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 03:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790926691; x=1791013091; bh=9fNRukvMqQ
	Zm+wePhDlYwpUPwjko8B/FqB6wLdredoM=; b=RAE/Zt8VSY0hDrUKCYL/YVdK2J
	7j9Z9dlxdAG/4VUq9RsNhiq+5Wp/TBshgRZQR8xoOghSxicAksNWjw3xFi/J0q+X
	I4fwdZoa0YD0uRrGQ6mggR61TR9ozELhYzkPg3/FNpz6/cxq95Oxstpi37mKtSPQ
	eeVK/GtFOzi+0mW6p/zyzBlKDDQMej82p+dvNPq7YsT034jBDaKYsQ+n+lgnbjsY
	EzHR81LRgZiNsuSMmBcW2dUzUILGvokfFpxuoOxCZBABQMde94whnznTs+ET/foO
	1bIavyEH8QaYDKzXuo95V5HFp2o9CrhU75cpJvjMud6xrBJldDADImC5ml2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790926691; x=1791013091; bh=9fNRukvMqQZm+wePhDlYwpUPwjko8B/FqB6
	wLdredoM=; b=lQ3BPzf/q6nbbIdOuLJLDLUOY6Tn2glAjEVgM3nqaqHWSLugwAT
	LLpGP5A3Orm64woRVCqoTYAzuevuwi8r+Zl0CAltjxi3cPKBPofNXYbjZjQxr8Qh
	BCZJNWbnDjC1XSaMSV1MY2ofvYiJ6o50NsUEtcrpjy/mFOReZGlMa19CfZbyWeP6
	+o+sRnaG8uEMa0TF0Tcg1MyKWylGx7/6Le+ycWIlBMAsdriULOUMpbkoJALcuWDR
	GGs72IH28kK2wuwX+Fb6SK1QwyR0KZhrmu3PKw6v+6CT/qtAwDnz2Fz29AWFAZfU
	29c07HofEfYBcCsvF0st6BuqDO70fSseIHQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790926691; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:xP7tZy5fSLXGfEhqoe/FUxPWaQnaabLz9GQL7jMQcfRuBsP
	Wb3BMLoVkirgq6Z6ygrve7nXl/DN2XCMFTZEzgOBvdEZdPAEi+KnoxRox+hhOKye
	UiJV+WmQLttAQRq4RQnBZKXxumXwZBMfljiDCg4vzNmuPEYNTgGY9DEprPQx5dik
	aHh28EtO/+RpiVGK9Gb/ksEEp5Z5ayLyIShZKFnB7qSUpybJ80vFMw9mFro9zlmw
	1qtwpn+E2dDz22XGIYaiA14vXUIVWnhCRy4gvBYRFqfdtCJMWoZGozlzCtduHUmb
	LAC/66rH6BIZIL5wyxZdpAkOTgHduIF2CJA/yiQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:rzm5eMZvU3vcoEyvGI/P07W3NGUReOtf0cX4N5Widq4=:CcdIBvMI7NwoJQh1BHJpGdPXieJvxJeHaybwo9GbVhs=;
X-ME-Sender: <xms:Yl-_aoSp74vuWX9i-JuFssB98vsMYrtxjVJRThPT61ceEHuuo9XiMw>
    <xme:Yl-_asyFNgj_j4GjOpB4uf6thEbmENPGaUPZr5GkO0vuCxIxCZcb3RtxFtlqqN_rP
    nfJlvlhIyODdcCwJ1l7Qcby7psrgDSZEVIMtJb8hYH5KSEXyrHJ7g>
X-ME-Received: <xmr:Yl-_aq1NZikE3iA8ibPvXC6O-v2KgBrldxQzNI1U-ykxLUQbDrGWP4icyBqbDFpnqNm6ik5rx18uSkXE1qExmljLEMQJTZI6kOZ8>
X-ME-Proxy-Cause: dmFkZTGiKr4JPjWuyCi5wBT95bi4sPq7PUbzLQbqsDfPEcnpWPB6SR0Ik2XLDf/MR29eVp
    VAfWTPvTgb/duSfFk/3IRPjr+TjcUntcFeyK7N5Dqv3epdlIJWWipAovQR7KO1YbO4egOJ
    y0rEzV0kWWNMNTO9Ft+dkaghdwtJqrvoa7Aq2GTeGuNrtiqLqmWE+EY9Wl2A/2Ahm0iLeP
    sLVlqXE5TcWOH1QjDkIluSOXAjXIJqAgQViCMUspYixnwMkAhb0ejXcJoCnU7KYM/0VVdO
    iArMRQpI7G43qzV02hJ2MauweTsbkqfgVu3k9AICTSzIgJYO/4bSLMIHqhuCuCTvJ3UqAc
    TVT9CbhSe7/LRcrRBguSi4xD2jeVIurof1OMd3kQujFvRVqVsGR80cnwlm7yZ4ZW90DBkc
    Cbgo4AQ44LP89rVP+j34yGmd0ry7g1R3+mgGP/RrLQ7RmE4I5EOYt1cfVg6CuX2m1gL+LH
    MI2qSy6MuKRv/bLzPO6kJiubpvygssdTEbd6IaSUqLwapzo480jtv9j6C0w38HYNcU1Klk
    WHD6HHdLl2rKrmwG62x/tKDRwhqE9ZECIXfKHoTw2ibMCDioh2a1hVSUAnmQCi80ETpr60
    W+XTDQqCcxkqDtHSEIY9rGKsEk0lgcfKVAOd8pbNC2TpfWKOEtMTYHTstCIQ
X-ME-Proxy: <xmx:Yl-_aq6O9AR1Gb3vbUMKpq-Zovqkr1wdZfed-mnVdif6vDzcdqmYjg>
    <xmx:Yl-_atVJ-u2v0P43yXQZnnbrhKlijRlyyxilomZyJvsuyX3jY8tA6A>
    <xmx:Yl-_apAb2UZ2OlRH-UeJ-fZM9nonc8Vrcqpx3TPZpdRQ437CmifJOA>
    <xmx:Yl-_as4v3wnyhimMUQoVHDEMQ8QyQ_zD_OUAdjk_lKRa-FmK0tFPQA>
    <xmx:Y1-_aiVuBdJqZyq2QaG2d4M6XnPOsmIMBLKtXvZTMATQBqWDHKlXDrQ8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 03:38:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/3] [doc] Remove gittutorial-2
In-Reply-To: <040938c6-6fc9-4727-901a-9be2b0b3a6cf@app.fastmail.com> (Julia
	Evans's message of "Thu, 01 Oct 2026 18:21:30 -0400")
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
	<xmqq5wzojy31.fsf@gitster.g>
	<8a5b742a-3f11-4bfa-954b-ffdd839b6d43@app.fastmail.com>
	<xmqqzewzch55.fsf@gitster.g>
	<040938c6-6fc9-4727-901a-9be2b0b3a6cf@app.fastmail.com>
Date: Fri, 02 Oct 2026 00:38:09 -0700
Message-ID: <xmqqfqyo363i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> 3. 22 people who are new to Git have tested the new draft so far
> 3.1. Several of the testers said in the post-tutorial survey that they wanted more
>    information on branching and collaboration with Git. This was the most common
>    "what do you wish this tutorial covered?" request.
> 3.2. Several of the testers also said that the new version is a lot of
>    material, and they were not able to finish it because they didn't have time
> 4. Writing tutorial material is a lot of work, it will take time to do a good
>    job of covering branching and collaboration

Good info to share more widely around here.

> It's important for us to cover branching, collaboration, and how to restore
> old work in our tutorial material.

OK.

> option 1: Refer folks to the contents of the current `gittutorial` (in some new
> location?) to learn branching and collaboration. I think this is what you are
> suggesting (?).

Not at all.  If the material in the existing document is inadequate,
after examining why it is inadequate (e.g., perhaps it assumes
certain prerequisite knowledge or work experience that today's new
users are unlikely to have), we decide if we can salvage it or we
need to write from scratch.  It is very likely that it is the latter
case---otherwise we wouldn't be having this conversation to begin
with.

> option 2: Ship the new tutorial without a guide to branching and collaboration,
> with that to come later. Not ideal, but I think this is better than option 1,
> since at least we are not pointing users to a tutorial that we know will not
> help them.

I think this, #1, and #3 are essentially different sides of the the
same coin.  If gittutorial can fill the gap, we use it as a stop-gap
measure while we prepare a better one.  If it is so bad that it
would contaminate new users' minds, and they are better off learning
the hard way from more technical documentation and external books
instead of tutorial, we won't give them any stop-gap.  We may or may
not have external material we can recommend.
