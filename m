Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E09B79CF
	for <git@vger.kernel.org>; Wed, 21 May 2025 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825071; cv=none; b=t6KNbKbF9brE2c+JWCRpb52H32Wg3oBFNlsb6YrAbfM+1LvkpQZcC6R+9rw238SEWozl4Ve4jhS3/OvVbgjf4bDBB8H5c7hv5c1r9dXC8Dx0oRxuJh+OHs7Ibh+QF6SyZiNsLbls0fpNKo6xlULu/1msQC9cekpWsPua8vDjiGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825071; c=relaxed/simple;
	bh=fB2/tnHy+LZ2zTJQHzIxsECJ/7Wm9U5kax7bIHuPMaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIkqaVaYdPsegxuMkToQnKseqypi76Wx8T8UjkDO4lE2iorw5PQ+lQPAeDlZnLCev+JOb6FaG+ZVFzpt3deZE4/D+F8vAmSi4yLUJFaq8Yo4jCfnePAoHMYKI7JFqU53RLguGXwGpRYT4of0VbSEFPBHOdRKJofCnN+p2Se/SvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t/47O9u+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eLE8S6Om; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t/47O9u+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eLE8S6Om"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C0251380444;
	Wed, 21 May 2025 06:57:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 21 May 2025 06:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747825067; x=1747911467; bh=g4p8YqyQIu
	hmdTAX/sEpVk/bva/njRIFuPIj3c7VpXI=; b=t/47O9u+LLyMMgp571Qh56FiX2
	9xvuwAUbCC0QmvBhgsnZEbyeqXk/d4H2JWiG10bkty9ACr64tJt9gFN+Pm3jRxwU
	46Iq9l8SUJDbQmfyLSq/2pG1ZwIhb+pRMt2nT8jUtAgNCOAnbI10sNcn3nBhkOd+
	28LwPeS4+41MUXVzm4Q4Zj5HGWqP7pvheX1utKHO2nRcHyp6+Qn6a8F5sx6YZHso
	5n/K3nXmvm/BMV/XhDBO64IBprCOOmnAxxvLpni7/1ONbqojviyoyXhQY8TOE3/1
	NYGZwH6Fu+7injwThDde37409DDjjzy3PgD8xsclFZBgjWWF3kb04sdDq/cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747825067; x=1747911467; bh=g4p8YqyQIuhmdTAX/sEpVk/bva/njRIFuPI
	j3c7VpXI=; b=eLE8S6Omq9zdSdYG2C1/6v/MzW+X9WnN4H/YDQjuqik++s9NPX9
	Lioo1ed0WgCymiClAySt2PzKAEsJwnB+c4uA4k0KcLd76O5lhy4s1V9FPv1g492f
	cDF/fy5FDFFpfjNLGyWwhUqFK8tYtU/6PfPFoz9uz9qwH6fY8xi7qPGJVuyQ8IyC
	Jf8d5URHE+AMVsU6JK2wc7g5zzN0xiwJY4sYLsueftVoZNnhHOWiLEizLT/BBb0k
	IUGv4la9iTP6DyGw+zVtF9wfkSOYPzaNb3IgVISF39p31HfKGqhvY2DzkI0U5nFG
	sLPSLXbdcPoPWq85ICwNf/0F9kMx4dpdhzg==
X-ME-Sender: <xms:q7EtaFY0pm5KJHTR3-46wEQpMAs0wI_Ij2_KsJVBfLDTGDtoHzwUQg>
    <xme:q7EtaMaoB4shI_N2Aie0zXqCIGZpE5Hn3Sv7KJVLhv6HTFvIp5TNAsWN8DlfYn-RJ
    4Jy9ZmURbaIg6JGSg>
X-ME-Received: <xmr:q7EtaH8YzVXIGKJUvPBNeJ5AWM04g646Wdc28bRM9IZteBNBsrzVN3Jve0CqN-WCcagLc3KNswx-7PtFjbDdJZ7fqweA5CaqPMrMZXuxwE6jkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledtucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeuteffudfgheetgfevlefhueeu
    veeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:q7EtaDr0TMjQoCk8VaS81apvy9MK_m-HEIHcwGjulBB1XtdjrTvDFA>
    <xmx:q7EtaArd6xnT5HmrWss4r1CHCNb94YqMeG-2LV7kH0fUNTb0Bv2bFA>
    <xmx:q7EtaJS1IuTuoBPSjOC3PSwiBIc4U2wg2Kfk45YbQe9moL2B8irDTA>
    <xmx:q7EtaIrZ94CwzJLCRVtvEvGBa5ZXQkvMl4WV27zu9XKp21gEGWPgTg>
    <xmx:q7EtaJYxapm2EfAt7YWmyVZWZZ49kyprSEeLZ8yaG1kLEVLifoprlp0p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 06:57:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6f7bbce1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 21 May 2025 10:57:44 +0000 (UTC)
Date: Wed, 21 May 2025 12:57:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
Message-ID: <aC2xp4Cdb0j6OX-G@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>

On Tue, May 06, 2025 at 12:59:49PM +0200, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series starts to parse TAP output generated by our tests when
> executing them via Meson. This has the benefit that Meson starts to
> understand skipped tests and reports how many subtests have been
> executed:
> 
>     ```
>     $ meson test t002*
>     ninja: Entering directory `/home/pks/Development/git/build'
>      1/10 t0024-crlf-archive                  OK              0.17s   2 subtests passed
>      2/10 t0022-crlf-rename                   OK              0.18s   2 subtests passed
>      3/10 t0029-core-unsetenvvars             SKIP            0.15s
>      4/10 t0023-crlf-am                       OK              0.18s   2 subtests passed
>      5/10 t0025-crlf-renormalize              OK              0.21s   3 subtests passed
>      6/10 t0026-eol-config                    OK              0.25s   5 subtests passed
>      7/10 t0020-crlf                          OK              0.81s   36 subtests passed
>      8/10 t0028-working-tree-encoding         OK              0.85s   22 subtests passed
>      9/10 t0021-conversion                    OK              3.45s   38 subtests passed
>     10/10 t0027-auto-crlf                     OK             26.35s   2600 subtests passed
>     
>     Ok:                9
>     Fail:              0
>     Skipped:           1
>     ```
> 
> This new feature is only enabled with Meson 1.8 and newer, which
> contains a bugfix that we have upstreamed [1] to make the TAP parser
> work in `meson test --interactive` mode.
> 
> Despite the changes to Meson itself, this patch series also contains a
> couple of fixes for our test suite that caused us to not generate proper
> TAP output.
> 
> Thanks!
> 
> Patrick
> 
> [1]: https://github.com/mesonbuild/meson/pull/13980

Junio, I noticed that this series isn't yet part of the "What's cooking"
report. Is that intentional or an oversight?

Thanks!

Patrick
