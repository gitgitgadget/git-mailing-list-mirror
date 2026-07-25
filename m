Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212973C2E
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784999176; cv=none; b=A/1eehnnf2zSreF0FCxFm0vH9vpqvDm7a0hVPUP7CkM9M6OpMmBDphGCB6j7ZGWyziCoVMkDWGJOaMoCMIwbL/EGrNdvLrXF6Hus4SYvGL75/u5CKG8ZJYdtly58YLkIYJQ8LWc3AqzYjMyE5W1ow6U71DhDwR3VClo/NWhAVDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784999176; c=relaxed/simple;
	bh=44RMZpWE/2HBiTTCP2FJNJ4evoLZSfT6tkAK2Ybu5iM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vDHzabhDXRkW9Cr8zJxFgL9qno5EIlWdXV7e+tNGeqiZH+Af3t96jh4fnVwA0v6G4SstvxY3VGS0MEmK0I0pLBapyb1Y9vKelr5uebnGuAoFQyzO2ZQkxEDUJ1NIWCSGrWLPpsfhE/lXVpcJ5qyZRhoOxsFJmqspsnvYP0Oi66A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=viMEtYUZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JcVncrM0; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="viMEtYUZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JcVncrM0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 05330EC00BE;
	Sat, 25 Jul 2026 13:06:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 25 Jul 2026 13:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784999174; x=1785085574; bh=uQcoT9M2Yp
	AYN9F2WS8/RfWIN+O5VxdiiWi0gGWcEGA=; b=viMEtYUZT7ScUpFlJSL3falXh7
	UhFuWvivnaNPXW2rl8t+kkDnBbFIozcUvoPb70CGaXpdwGeLRKJqLqCewEew5GHz
	53ZubuzE4z8lyNIEOukfPp2mksfUIkaiMHn71TBwHWgQtJdEgdZLfbw/EFeyLlVD
	zwgqObtn4RQL4pyg7ieq/Wj2g8KEJXDOcXfZkQOgYYitVD25Ubn22IO74bsTfy0t
	bNlEgVJffZI2Hc5gvzCiMeqgVKfGtkHwdndr8aBGoIAIOExSHDSItwMmbyrEGNuP
	xKqwQsRfodl9sBYs6SR8dSfVd9RB6+LkYW1EUXOHhZsg3NhxeDdPUIpe4mpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784999174; x=1785085574; bh=uQcoT9M2YpAYN9F2WS8/RfWIN+O5VxdiiWi
	0gGWcEGA=; b=JcVncrM0rlvKOqvOzpeOugNtQ4gFxHB97Zamv/4M6xYr1KlU+Z9
	bWpDET1sAUJF64Ns7XPvGSDDPe0dnC7DTRLPlf4vQ9OQPFONC8OAvpmIQXRtlqn0
	dWeRSI9/BPmUAVY+US0+GZ/naZ03iz/mpRSypuGyKTWp1XxvsCGW4MJXUF1FVQwv
	8T4aWplzpIOvVOnXfOKMyWW1oO4pq1zclkc7sw54LshA2X7JnB7Vq3tp1AGfAVxF
	qyPB3FkJqyjXuT8KjZMXbLwSai6CY8JnB9MxkIjX1V9paPgw2Wa7qp1JvCWCj0pJ
	X8GVPY8uRsxQakve5bgw7reOfPAFaVe51mw==
X-ME-Sender: <xms:Be1kanGl-dz4M2R53d4tmlcE_RHvon-u3YGYpa37mxUXH_bU-s-GCg>
    <xme:Be1karzu7JTwd7wYs-b9L3O1A4wFmRW3hFPKU0-yqgEiULEWAn1RW6WlO8eVSdMtZ
    mas0CzGysvCPLr7fUctuTNUVQ5lSbQeEFhwpODV7tZHz9ORwz6chBw>
X-ME-Received: <xmr:Be1kamiWLJnOy41TnV4zpOHAHfOLJxUe_wnp6rxfHkNCmrqLgIlfIRBX-lYjuNuXQru7j9zm2_Ad0wWUXUpZgZivzHLsaeazVg>
X-ME-Proxy-Cause: dmFkZTEmB3USK51KmKh0n+5cp9CKHKVkQUNxrKK8CYZJpsdSwb8/PMItyPc2IEtSGjwcfO
    DjF+kiDxLaQH5tBcK7snlcVSZ74uIGQDKpQLV8IUamnLsOhIAB7Vjnko365t471ZOpRrCW
    Y9pJCwRJNuTCpyoQWoS7dlKze+NOegqp5hXQD7LeD69HBgz0596sz9C8GuB2RutEvmmDvc
    CtC5N1KJVh2wB4gpMuQshGB+EWZXI7HQVowuFuEPZQEWFDMFRu97584yJdhWb5EiNZ+Abd
    kC+190a3W3VR+m7ybSCZeTlCjoMSxOPNAfwjmM/Famow1dEUODPqk1Nl2T9/4zYP5agzBc
    bFEHiuwuE66AHWnY51djW81X2bMydX5CbJMvnr4yuSBk/AqAiZ3NZ3m/RrJb2FUPRv+NtI
    SM46tNVMTe7Egq9Ny+JLi78M0zXOH65IQ3LP2K8ZY0lxpYP5xM6JklWosBXX2RRRuuklpd
    NuxaMcHJyLRrA0BunZLwYmBRNI+zkF3myeUW9TnG0vUzVOYT8S4eIGtUgSJ4iV7yqyqb4W
    iqnoIAypn0vObV+Dn14LeMlen7OlvYYJTM94qUn91IfpY8+D90yvvkeRF2MBaim6Wh1rln
    +Jkrlu/kq6dfVZZHBHrLCKDAAw1XAyAv70l7GNCX5skPzKEvkcb1ZOMhgG9g
X-ME-Proxy: <xmx:Be1kauz9xwfLrSM9dV9vaGfxY8bN1aBqfAbT45_epre_YWR4wDz_9A>
    <xmx:Be1kahKhOiZMRV_nTXyaNkug_u5nlBDGcmA3L1dmOQufhe9P7VvxhQ>
    <xmx:Be1katRB1hZvQYv_QDRdcI9x4rdGPEL7q1uPQ2j8BcbOYd7aj9yaYg>
    <xmx:Be1kahqJoS2wg9HtqbFgwjEHbL-smLnIkGk-H8S6M-AHLMVARxyJvw>
    <xmx:Bu1kaogYEh_zwXbHdIvw62JVZSCXHttPQL3hHx8cl1Zgj5nJCSMlS_Zm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Jul 2026 13:06:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] remote: plug memory leaks
In-Reply-To: <20260725161819.GA2343104@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 25 Jul 2026 12:18:19 -0400")
References: <xmqqv7a33nm9.fsf@gitster.g> <xmqqpl0b12gj.fsf@gitster.g>
	<20260725161819.GA2343104@coredump.intra.peff.net>
Date: Sat, 25 Jul 2026 10:06:12 -0700
Message-ID: <xmqq1pcryp6j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> We should not rely on that assumption, because we sometimes discard the
> configset (e.g., when discovering the repo, or when writing a new config
> option). I couldn't come up with a case that fails, but I think it is
> mostly luck (or lack of imagination) that there is no code path that
> invalidates the configset between when we read the remote config and
> when we actually use it.
>
> So even though in something like:
>
>     git -c url.$PWD.insteadOf=$PWD clone $PWD dst
>
> we end up with a state were the instead-of structs are broken, nobody is
> reading them at that point.
>
> So I think this v2 is doing the right thing.

Thanks.

I had somebody else dig into the entire codebase and they claim that
there is only one existing (ab)user of the configuration API that
assumes that the configset-held strings will stay forever, which is
the comment_line_string stuff that is stored from the configuration
callback without getting copied.  I do not necessarily believe it is
the only one, but this particular code indeed seems to rely on the
assumption.  #leftoverbits perhaps.

