Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292D437F8DB
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593174; cv=none; b=PDXAt+XpnO4qdUSlsty9ZFcoteHEYVset6ipEYmVc6KD/Ni+OeqsOhAIWMxDzxH3DrSD/9tiCSHdkDdnwWbzYIDOqKfB13/aVaXgIkjT3Bg2g6tYKOh83zwhPAS7HnqF1QJ7cjJYjNKv9RQdmVddCCBMimmncceFrnPf3mzjRHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593174; c=relaxed/simple;
	bh=/BFEhJrIyR4KPNn8nmd224UpSFWqzqPylgSTJhfFUnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxo8PghqIkb8FnsVtqYeo09eaFBV+y4gr6EO+A7oWZM8mdxWW+RwelF3+7k5TjC7m4KwiGO+zNbG7CaoN/FG1bdTMpRt1VkjhzJKG3dWR4U+RZjYxnYWEWyexPKqJW/BvJUGI/MK+vGccWSmj9A0nQYfj3ehWg/Zj8KYfgHrFbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RsmVCiHU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d+FQAFxa; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RsmVCiHU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d+FQAFxa"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A7BFD14000A1;
	Mon, 24 Aug 2026 13:39:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 24 Aug 2026 13:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787593163; x=1787679563; bh=haMFQS5xRx
	WoBTYxArmLFVhKKk1UUM+rQLxAzw9uiOo=; b=RsmVCiHUyHHZTSFu7v0kKfNPcX
	LHAV5IQg3SJP1IvsjCinrkkHAra6cSvfCfaqRVZaxn8jwo1LbP5YpjvBC07XnOtp
	i3zWdLGTtZu3dlv+P+mC6RYiLLyU6JtMzpHxlCj7vMPwBwjuyN5oV2Hc+Z3/eHd5
	RbipR585I1hGIAnohQaZdcH1tVz0NfQGwb6Z6nPziF2biURzbPEKK9p1UfsztP12
	DtYT4TCdhElgc5i8Tb97wmNKMDW0Dsl+UabBu6AnhauVszv3+XMNIbatLO4WOHvZ
	5zU6/935gZoy713Sk/dox+HSt9jbbK1j2RTQGQrQn19FskDBdR4Ebvcr4lPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787593163; x=1787679563; bh=haMFQS5xRxWoBTYxArmLFVhKKk1UUM+rQLx
	Azw9uiOo=; b=d+FQAFxafmByss1Iv9HgzT22K9xpU3tNGe4D3NB5sYM4yfNIFRr
	GE9okQpQGQalWlpBajKt+Kq3ijtbXx4MKs9ajDBeMhD9yYypyYryEVoJVPyGedLU
	uNCWUGgfS1z3nXn4Sw1GxgRoLjbsG8XpjrFgeiU9GU60QjYqMZYAvvCsGgGeCsi9
	XcXoFUQFFsZTmoSNSCfWFGs18rGFG5u5P5TH1qgXQn7+0QxAu+uk9VeF2l7tvpou
	6+svyZuiIRZU3FIn97tY4BJolQuB3k6O3tqwjQIdrXQf67PTvNSmC/jdTt/yXuWw
	1zHDEXRYwXU//FQJPcioj2I2qzg4UEqGrZQ==
X-ME-Sender: <xms:y4GMavPCRMDT4x8igFS3zhV54BZGiHOYHAx47b3NUE0LXezCJdxdMg>
    <xme:y4GMahZLQ8i1XCG18KBOT2utEWxnrBPDuPq3HNL6VoJC08U8VQl60UKWgUrhDhzeR
    xBjO52Ub7tIJfXLkOJmJ7w1jshJ3B9MNCEoXB8Xupqkj2rljL2P60w>
X-ME-Received: <xmr:y4GMarrE4jrGyR8xCQw8hPJFKINiOuRR3knpz8bEIfRWGokiE6KGjUN6vJzUiqo0falawA_VNfhA1Smy8Nnr5eMqU_LcnMaW3Wr5q96b1Q>
X-ME-Proxy-Cause: dmFkZTFINDO+4S+Ni1gB3c3Bx3XuZ7Hn7CpUiVgCZPUNM6AlSLw4RCSAOdo83Ki2zLUeKI
    k2hA7n555LKZ3OpnAA4qZKoT9mUGqL6JZjNeDD0USryfh5AX0zAdjn53MqfS/P/WPfJf2A
    RcY04SGj5JNcG6iUe/SKMOizLUYqECkArZCYauDfWvhigKLT+nU8voZQLvsMM93mV8M2gu
    ZRsBJAI4PS9hq+ocW9PUMKIk5cIcaAdU05t0gLKpssEpoNsdzObj+voDBvNOz8bY7/zro8
    vz+BG+DA7KQYqA22brWJEypKLCvQkmgnMCETNLxl4TS22tW+C8DPy2GNahHSIlcQ17IOo8
    XUN3E3ANjH2u83JLvTKG0LhpUUm1Pl/rvaozh4/jA/lREB848fAEVWlRwIhHBfDelBzyTx
    xDLyG9Mxx3cYz9ZpnBQ1gyaIEVzdBwlHem5oumDfV3KqD2tuwefso4EOVbjcmNVvlna9Bf
    i84GJkGc8Dkt2akCcoOMi7pvRDLo9oyQ7KCgzeyOJE4bpcsLUoWCT/rCXxcD7tGebJ/yeo
    hLDdjepfrQ+mX7KIm76+LDrro6X12NTmz0wKf9Oq3kzpyoEOBnXGZNuOhCnTFR20wpZmmA
    OkQZvqD2lF1Vaotmy/ocQ4/sobHMeha5tmFDgc+Vio2oq4vQkzHO99lr+U8g
X-ME-Proxy: <xmx:y4GMatZij1-UCTRY2_RnN5CgDpTxwSnDZPFTjs3NEED4W80tMmzd1Q>
    <xmx:y4GMarTUgp6kYV8hmlG_WftUXh-jYdRJn8bxpumTtEACmUKealtI_A>
    <xmx:y4GMas7JT0GYrDr9HVZ3EcWVEROUI9VY5rLzNydNXpykTUw3KDNIvw>
    <xmx:y4GMaowKA5o_PU6g4B2A7SUEa9rykxMu32340uB37NJ8f8BSn2V7UQ>
    <xmx:y4GMar1kBzmlUcLA7tT4lnL1WWPb9_VB-9XmaAuDrLGvl5gL6LnUGwfa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 13:39:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 337c4d29 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Aug 2026 17:39:19 +0000 (UTC)
Date: Mon, 24 Aug 2026 19:39:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Nikolaus Schuetz via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Nikolaus Schuetz <nikolauspschuetz@gmail.com>
Subject: Re: [PATCH v2] t1401: check symbolic-ref exit codes and --quiet
 silence
Message-ID: <aoyBxOCdAq3qeAvW@pks.im>
References: <pull.2204.git.1786655554197.gitgitgadget@gmail.com>
 <pull.2204.v2.git.1787264402361.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2204.v2.git.1787264402361.gitgitgadget@gmail.com>

On Thu, Aug 20, 2026 at 10:20:02PM +0000, Nikolaus Schuetz via GitGitGadget wrote:
> From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
> 
> git-symbolic-ref(1) documents that reading a name that is not a
> symbolic ref exits non-zero, and that --quiet does so silently.
> Tests such as t2020 and t5621 already rely on "symbolic-ref -q HEAD"
> failing on a detached HEAD, but none pins the exact exit codes or
> checks that --quiet actually suppresses the diagnostic.
> 
> Assert that a non-symbolic ref exits 128 with the "is not a symbolic
> ref" message, and that --quiet instead exits 1 with no output.

I'm still not completely sold that this difference is intentional. As
you mentioned elsewhere, in one code path we use `exit(1)` and in the
other we use `die(...)` to print an error message, which returs 128. But
that to me feels more like nobody noticed that those return different
error codes rather than an intentional difference in design, so casting
that behaviour into stone with new tests feels wrong to me.

I'd suggest that we either:

  - Continue not checking for the exact error code.

  - Adapt the `exit(1)` to instead be `die(NULL)` so that we have the
    same error code across both code paths and then verify that both
    have the same error code.

Thanks!

Patrick
