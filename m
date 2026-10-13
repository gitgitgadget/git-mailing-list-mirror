Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33E6514764
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902860; cv=none; b=qoma22aTUMcg8vr5jIh1RWnQSWE2FMq2fD35yEjWnZ37GX1HV8iB1CzXx/AOnUJM8D3NGwtnMIioWmkz9kHIySNTt72FtKEVRyS9O7xdjJbnZ8g3F9jCODCyg28xWYid6QNVrg/CWWGnOQShBq/7sLo36glr8V2ozOGZqVdMdHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902860; c=relaxed/simple;
	bh=k8pg6Q6yvUnR9L0nG7VMd3noMQXzok4o2cUsCNhgENU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OO2CyDCrhJuCzYqLt8YpSp0/Gr30EXwABg42NEMbATfVPuLtQhRw+TDVwCVkUO4mIX+XPKgGrFNSAfzC2/jJiaSzy5Fp2C5+1aAX4qQCVT/P91k/QmltP832KLit+hvYz7kQzt2Q4DLDjn/hp9oFl5KrK3ZS4o6VFiYF0HV6u28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FlcGl429; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ua8gRWgC; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FlcGl429";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ua8gRWgC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A62F1D00192
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 10:47:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 13 Oct 2026 10:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791902857; x=1791989257; bh=hv4ScllEli
	C9v+4FdObhYs5YP8Cm/mt0A60jOQZUmSI=; b=FlcGl4299Iiumd4gCO0xVkICNs
	aLT+IAIUJbmvT8kRQK6vxDVauhST1B+KqZsrIf9P6fjuoDUqH/hEQchOHtAaWErv
	vr4lulqej8R1RdSkrELc5E+vzzDr+rROw4fVuTqM5rEX7zP7NzQvXU/wrZP4JHjp
	p87oPbEq+aoF8uK5vr2BkpMmtIK67tIRKdpjiqYYzfaUW/jJEiX2dVGLJ3I7jMup
	G8746GMK2wtCLAtXNfmic1/h8wwx+X5e8hpZLv+HLxo1e4moTsKBoJ1OqhyPLFwC
	uTgUWi2Z5uGMxKaQqhIi/7k22a8sNFaY+ocZSh+xRnQ/cxRk0wTulQBXoRSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791902857; x=1791989257; bh=hv4ScllEliC9v+4FdObhYs5YP8Cm/mt0A60
	jOQZUmSI=; b=Ua8gRWgCbZjew4t1nR3V6lJrnAwmwx62klclmTc5COgIY3W1KWE
	xonfKdkniACwz+Xx+Lox5B03nT9b3g4bO4oel5Q69VluD9UL3VAHlUHDyjC6RCnJ
	B+qC6eA6RXJlAKFvy/nI7+6TUUcdxdj2NJzuzny7X6kuvPEBwLozEn+9hLeBSlha
	XXsMvqdSmQTb4mWGuBrWnJBckXRHDgtRHN6eStigv5whDGm5FAE/It6uJn2t8/uW
	5ZHD32espEdVsdKUZs7fnCibZm+GaOyF/Llsv42IY6M6PiMyblzFplsypwtZEn2P
	STCNyd8eteDLN29YFzia/E+r/ZbRCdsjuEQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791902857; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:oVObYAoA/p4CUvKK2tsDIReWttQ5DTdWpHbyldQn2HExblf
	EazYQ4j0/U4i0G0QGOvYTOWjl1W8BMwcRySTMFPryNYmSINkS1+vgAmo/rpegHM+
	BQ7hoTXhMlw6NAFyrNBUCUNfESM+4fHhAsy5Ggm1R5B2zE7a/dDlyU1LxNjaCFN8
	K6b75e6xeQ1667mPcvjZ9JYP4h95ULavDVHIc3dVgJI/7rP3mxxeXGStjCZkFyY4
	jTp8bF0eyAuK+nwJfCIvI0raJ86Kapi5E6trFevShBqXB6SqP4tN+UDwakTWEbru
	OjGZEHGxaXJxcl8EisCQkuYKJyN4XGHgH3rvyLA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4i0WFIjQlfBh/f2BUztmdQg/Abvbml/Bb1pUWdD41Hk=:k8pg6Q6yvUnR9L0nG7VMd3noMQXzok4o2cUsCNhgENU=;
X-ME-Sender: <xms:iUTOauA5hZfARyRdLGPUa-UFhkBmVvxaCYCIIuhBlmhroqlgW0cotw>
    <xme:iUTOasMlqsfEOdVvifd4_tNwOzUt3-X_X-I1ol7osBCASJ41oJepeS4l1BIs_VQO_
    aKfDvUxIRlLCfoozh5VR4IpG71i4kTrqZRCpwAOS3kbROnVvSES6_xi>
X-ME-Received: <xmr:iUTOarag5hPvtmuwxYIf2ynpQ8AJSqn8-a3qYUqYNm7OFtGyiPmu35PrA3Uk51eWoJjK5UrVK1E0y5oz1Iqp12g7I0RQ3p_H-IzH>
X-ME-Proxy-Cause: dmFkZTEU4igkAHo0HfaHRgWc1sElz0hwiCgo6b4eSdvaTZnfcA8St3hdHavzGHvU7HGK+X
    UsE6J6d7/odf6T+PLE/giPymiPn8SzMmztgn3BB75fz1Bq5dPQyMdCEglfBGkUMc9CGaGI
    5F+KKIT3kv2u9SQBvuhfeLoqFVyM5IkAwl0NYF8qrZ13pdW+EGfGqAsTHahcx3uEubNTz1
    uKOw1rLpsNb7k9DY8ya+FwaLKX8GMvdy2zhqbLd7Er8oZGnrcgwFB5bKCfct61jxl8Bdxp
    R06FEntN8eSh98wtUtF96VKZ9k7xmQBB9XB2RuyraYr3eHwpa0L0oMXbvWFfhvCeF5uMX1
    /LgbW3YjmHe4BsHRi4GOLNT0DBSUJmtys1Cf+GZzvjXtcEBDs19AU0d0aOQc5ac7sG3eXG
    OEA47MMfz96hcdl7wlxPxMP+LrYKRhjggaRvegnzNFKkLEYXRafpKHIPfO/aHBPz4wUdBe
    bUb5ckoVhhspbt8LjEba2rGM4qxSz/UrMgiKgvAmw84G+Zx5VY7RK34Tb+VfhFjFAyhS0M
    Y9AmwyI+lnmyixuzn77BN4ay8pe7SpcL8qmewQNOeswRTahp7A6GsbAfjIEjsN2mpbAZqk
    zo8SwCOcTWITvOL6aqlmmqePXRR8WE7SLKqlOo8djQKlfM+iKf1XGS8lEaiA
X-ME-Proxy: <xmx:iUTOajthS40B_CQgKB-PP5whVjDW81q0HiDK4cJIfrn2fwjgF095Zw>
    <xmx:iUTOalM3TRXyeIrmcfXAJqIk8ek6OTF40pyojvcvi-_jBlP0LofTEg>
    <xmx:iUTOai4_Sfujr830ohwI7M8WTc1o6BDRVHHI0GsBURSd3dGF1LTsiw>
    <xmx:iUTOajSxY_0PIoBGI70g08o7OBeG1knkmCnrPY3MT1Nh2PGPwrLRWg>
    <xmx:iUTOatwADgrMIngEin3b_NXH5VZDeM2F6j-7kNsmxQ_ONpL9-FUeKy6Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 10:47:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v2 5/8] ci: rename linux-TEST-vars job
In-Reply-To: <as3b-u7SzE3uPwQx@pks.im> (Patrick Steinhardt's message of "Tue,
	13 Oct 2026 09:21:30 +0200")
References: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
	<20261009-pks-ci-housekeeping-v2-5-6863d58ef691@pks.im>
	<askI1DGldZx8ElIN@szeder.dev> <as3b-u7SzE3uPwQx@pks.im>
Date: Tue, 13 Oct 2026 07:47:35 -0700
Message-ID: <xmqq33u91wu0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Seeing "linux-exotic", I would think of a job running tests on an
>> exotic Linux distro, or on an exotic platform...  but it wouldn't
>> occur to me that it intends to set a bunch of GIT_TEST_* variables,
>> simply because there is nothing in its name to indicate that.
>> 
>> I think this patch makes things worse.
>
> ... I think it's still a fair point. The question is whether we can come
> up with a better name then that is not an eyesore and that gives you a
> clue what the job is doing without you having to know about the
> underlying mechanism.
>
> A couple of names that come to my mind would be "linux-nondefault",
> "linux-optional-features"... and not much else. Do you have any
> suggestions?

Among the following, my current favourite is "feathre testbed".

== Feature & Capability Focus ==

* linux-experimental-features / linux-experimental

  Directly states that the job enables experimental features.  This
  is clear, standard industry terminology, and avoids any ambiguity
  about the Linux distribution itself.

* linux-feature-testbed

  Positions the job as a testbed specifically for experimental
  features, which aligns perfectly with its testing nature.

* linux-exotic-features

  Keeps the "exotic" keyword you proposed but qualifies it with
  "features", immediately removing the risk of sounding like an
  exotic Linux distribution.

== Build & Configuration Focus ==

* linux-nondefault / linux-nonstandard

  A build that departs from the standard, out-of-the-box
  configuration.

* linux-extra-knobs

  Uses Git-centric terminology.  Since you customize build-time
  configuration knobs to enable these experimental features, this is
  highly descriptive and intuitive for developers.

* linux-super-tweaked / linux-highly-tweaked

  Emphasizes that the build variables have been heavily customized.

* linux-custom-vars

  A direct, no-nonsense replacement for 'linux-TEST-vars' that
  clarifies that the variables are custom/customized rather than
  just "test" variables.

== Testing & Robustness Focus ==

* linux-stress-features

  Implies that we are stretching the capabilities of the build by
  turning on non-standard configurations.

* linux-edge-cases

  Focuses on the goal of the job: testing edge cases enabled by
  experimental configuration variables.

* linux-all-features

  If the experimental variables essentially turn on all optional
  features, this is a very clean and positive name.
k
