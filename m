Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B486D1531EF
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734839; cv=none; b=oVndhL/aClYWsVH/9dBq+MKGPvTq5j9v3jBekoCVFoz5cOK/TebawHgYEGf2D3abogkfE7+r8/gMtKLHhKEiaMFz5uc05mpD63OPIi2uL4CpgHQrvbg0Fr8EjUs1W8S6H+sBHXnreHyf7RwcgUC7fTxI9mqxjV2ycqp500+C7M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734839; c=relaxed/simple;
	bh=sdk/HbJwhUBZ/thrQ5AxODvI26U/jCRvQzqMfqtbKxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IqofRTCNxSoOO9N1pextz5xu7wlfEiegujmtV/WU0aEkTOK+3V/GngBUnHyBKvk0eaFTmrtr6ealqULJyLPOVgAIY/atCZHDM5I62WTcjfgjIhYeRwhXdELe0RS2FHFM9uLQ068bGcjiqb3QCa13N8QIl8pEFbAzqLCs4H05D2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kVKLb5XF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YAVkoOvB; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kVKLb5XF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YAVkoOvB"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 916ED25401C9;
	Fri, 24 Jan 2025 11:07:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 24 Jan 2025 11:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737734836; x=1737821236; bh=PJscM3tbhG
	GjyF1Jo1H1n0qwnMMhBoMCc/QKDH5YA7o=; b=kVKLb5XFBS+QXJ0OJFc8nibzQU
	7MpxuK8RG5WvnBmNU4cPI8hzHUY6ADOzP3vXGmiTVYnU7N6DVrCE0YqVLaB8WPZ5
	x/pGJTlpVpANkjgeQoW0x2hYFfniyw392ODdVnxyMz/fjHglM+YNCc0OxAcZQ4k9
	ipB+RJIZetpKzW7YLoivBI6MOPr4We35rjZhxE36OVX3O3lrHuJRvqmGAggpumvo
	mjjihaUo2GuEBF79hGWJKiCmGLMlhuvU4DCV6wQgf8L7hcVQJnnSMrSyOEbUyg9X
	1yx5eLVxGXO5ygwM8UlIiAMeXVdfEKCwUXB22yIcyWGCUygICXJsN6Z4Ng8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737734836; x=1737821236; bh=PJscM3tbhGGjyF1Jo1H1n0qwnMMhBoMCc/Q
	KDH5YA7o=; b=YAVkoOvBaMIlxBblfbL5hGw8Rmn9IA3FRP/nIDaZfdkwhFYuz6D
	V4EvTKZ+M1K2OBYDdIguL/gdY9LnjpMLtSRvuQHb+CNQfM8U4MIG6OKKM8KYVX2o
	gyJlVJkKsIRKqHRnYM3Nnpr/51pBjOZRrB1qsfL/lCXiSUdqCDXGWmqzUPv1e1On
	Mimieg3ioeiwVOFLAowRRQi2yF1UvYYjt3XAgFjWbSu2chBVIkogEXXwiUflUkvE
	KnP9Xblh8OhQAgNBxTzhj1X9uOmPTzOLSnMFY3TsSZEJnbRxsVNYhTdD/n1cPxvU
	BbdQis7GWDe5ydXUbiLoV49S9uROgnk4EtQ==
X-ME-Sender: <xms:s7qTZ_kIsiba87MjxA-T12MBsDA5ZxVfFCJ3cycFuHWDY1ZlUP36Dg>
    <xme:s7qTZy2kX-l0bPUUBCwKoWS4i8cbi8_B7fn1xGVQ8BCr-CM2nafeV8xk2q4LMZsrW
    sjnks89Vxn6ocIA3Q>
X-ME-Received: <xmr:s7qTZ1qtFaJne3L1r3ALjfRBx8gsQjEMfJWFtl0bqx0drkqqYfITVJZByuqDZjerLTqmDb6YpT80SLieTnUmXx8n9P-d8pK5gQlJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedggeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghilhesvg
    ifohhrmhdruggvpdhrtghpthhtoheplhhishhtsegvfihorhhmrdguvgdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:s7qTZ3kX1ZxuplDX1VdBfyKJ8u_xzDtz-MRUKNlmCHcKXCU1M22rAg>
    <xmx:s7qTZ914oQcNrypCMECgUpmKkQCVT2VHdsLXgY9FOrGDzoeIKmrDgg>
    <xmx:s7qTZ2ug-eRxZbH82rbTVP-9e6BMKWUx887uvtx_uBOpCS00lmZFbA>
    <xmx:s7qTZxUBq-NKGExQEP6A8zIKMKKXlo5I9PcRoKa8c-cpwDcM9f1xnA>
    <xmx:tLqTZ3qeh1NCslVCve3bc3cPo2TJG_MXUKH6_BxasOLOFk5BlRK6UNPy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 11:07:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Bence Ferdinandy <bence@ferdinandy.com>,  git@vger.kernel.org,
  Christian Hesse <mail@eworm.de>,  Christian Hesse <list@eworm.de>
Subject: Re: [PATCH] fetch set_head: fix non-mirror remotes in bare
 repositories
In-Reply-To: <Z5Mrk02wMdABtrVZ@pks.im> (Patrick Steinhardt's message of "Fri,
	24 Jan 2025 06:56:35 +0100")
References: <20250111202628.0e5894e4@leda.eworm.net>
	<20250112165125.130400-1-bence@ferdinandy.com>
	<Z5Mrk02wMdABtrVZ@pks.im>
Date: Fri, 24 Jan 2025 08:07:14 -0800
Message-ID: <xmqqldv0p559.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> index 2d9587059f..cfa63ae086 100755
>> --- a/t/t5510-fetch.sh
>> +++ b/t/t5510-fetch.sh
>> @@ -84,6 +84,19 @@ test_expect_success "fetch test remote HEAD" '
>>  	branch=$(git rev-parse refs/remotes/origin/main) &&
>>  	test "z$head" = "z$branch"'
>>  
>> +test_expect_success "fetch test remote HEAD in bare repository" '
>> +	cd "$D" &&
>> +	git init --bare barerepo &&
>> +	cd barerepo &&
>
> The `cd` needs to happen in a subshell. ALso, the same comment here
> regarding whether we want to have `test_when_finished` to clean up
> state.

Yes, indeed.  The change to another script we saw earlier followed
the "chdir around only in a subshell" pattern.

> I see though that you simply follow existing code style, both for the
> call to cd(1) and for the single-quote, so these are fine. This test
> file could use a makeover, but that is obviously outside of the scope of
> this patch series.

Terminating quote can stay, but chdir is a correctness issue that
may want to be addressed minimally (i.e. not making things worse,
while leaving it for later to clean up the existing ones).

Thanks.
