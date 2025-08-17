Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727A1A23A0
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755471268; cv=none; b=VkIwpUysMCMObYWDDneF7gQ4Yc1N9dSZq22iADQgyVpmAsBBxvaYL/fKvud2ChfwEWv4BSl9IxPg+Bbha4OVfZrf06/Pnm1Ac/NXF222/QvIqV8sqddDlf9WuXoPOgTTLpP0ZXjCtcKkrQwEXuMhlYRDtKaWlCdVWFwS79oowwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755471268; c=relaxed/simple;
	bh=YkUUwtiiR3wacKvV/FNAq6c8TiHwUq6i/8T59odMrCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tefn0njU8jQo3Cg2p44eAOvxYTd6J8EByy4pgeG/aQ7h2VIZAAz3YE72nfn3xR6rfGlU2rUNJfXoV6r0yP4cvOxUFsjnGybRVBLOj3tax16ofcOEw7VDRx6qGJjJdgRcFWfdd3c6vJ4+O6rZ/bkD9To/QmpD38HjndCKlKjMsIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=URRZQ7J/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kghsr2En; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="URRZQ7J/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kghsr2En"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E3B567A0048;
	Sun, 17 Aug 2025 18:54:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 17 Aug 2025 18:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755471264; x=1755557664; bh=YkUUwtiiR3
	wacKvV/FNAq6c8TiHwUq6i/8T59odMrCk=; b=URRZQ7J/ZVFHAe4HRePHSzpLcx
	tkbQtjqf9RKsQPGFDdgQlMUOA177zKvd8why4aXLf6tamrp2t4Gm5HCgn7rkAuIi
	d8UvD8sezdXTA9/PQII1yqo3GzukmvbCxxLDtundRXAhgxBrbvgSYWsLoGfG9gbR
	Tlp0QnVE1/smX/Ij0ZUXzSbItRkYxtKw8eJogYUK4VK/M2e54MGut+7grOtrvCLH
	rCZxSwAqMpSBojY3T+FjAwMaSvb7I24yywp/ZKEzNr4p5VmzeZhwKgFHqowpY684
	xzunFTGZJksuMgDXv69dQMGoVpvadO1Nv6G9PJmzwoD7tTyl2zy6xzigzecA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755471264; x=1755557664; bh=YkUUwtiiR3wacKvV/FNAq6c8TiHwUq6i/8T
	59odMrCk=; b=Kghsr2Ent5uZLaVhmX5yfv01ukwLOuDUU34qFHStWhwC+YNvyPE
	jmOrmIhwTKx1gYCXtPsCEzF9nqmnf1ZKRt00sPfDDOhdoOVQNLTrdjLyf73V/LQ0
	wG5vsvstKzg9/6PcjIWuhTvgSgmyf9eKg90v9A2z+5zyj+KwnJHJMpbwKjMrApi0
	0gco26UC0tDosfqyDW82t/ZzTxKaNl2uD/Zj0vALfqu45ii+7Ugb+W8KrO00vm+9
	kmeLiYEm+UesApKlvFt3X4vgK47PuXf9YMWM3DFpt5d9yZ7sXVIPj0gFH2HwRkK2
	AqEbaHO0v1fmoxXp77zWJ+ERBw6mmVfXGJA==
X-ME-Sender: <xms:oF2iaOfHG5mRwOHJWCyHtkiVMtEsJrHwI0MvxO7PPsuu7uJpIenT1w>
    <xme:oF2iaLev3_WcDCByHVJXX4j2JNhiWTGLzw4_2dpAEMKT2Yi9_m6i550aX4vHiHJBC
    9UHRrcfIFCPJP0CaA>
X-ME-Received: <xmr:oF2iaI--mj-80RAn0WkYsq6t-ttyOL1U7z0-HCc_39_1iE8mnW8y1btynY5jWb25lyy2kuz5vmL_opeB4yF5LoUS7-hDhTLP7owS6E0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepiihirhhosgihsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:oF2iaHkYTTR8czdf499IoVUZo1BSYrKL1Bsdy0tV1bjUK0nldNMXCw>
    <xmx:oF2iaK-i7RDkDhg2niGoNgQWyDbvnOonX1LVFgrxE9F8-7ZylWMEyA>
    <xmx:oF2iaFmIft6Npu1ejVWfxYt-rAxxFzhtB4p7LZaUnnWbqexZHtDuog>
    <xmx:oF2iaH3Emq0pz45YGpBtydgGgE6isu50wkN3_B6gu1GoIC01ZUO_RA>
    <xmx:oF2iaAFPEaklvl1AIkMS55n6WkRa8Kibf38RdFZlZrdmiXuFie8D5Qx_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Aug 2025 18:54:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ron Ziroby Romero <ziroby@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFE] Add JSON output to git log commands
In-Reply-To: <CAGW8g7mV6az3ybYf3uzHYQTGLDwc34eebZnha1EQ3Sb6B8E-fQ@mail.gmail.com>
	(Ron Ziroby Romero's message of "Sun, 17 Aug 2025 21:17:46 +0100")
References: <CAGW8g7mV6az3ybYf3uzHYQTGLDwc34eebZnha1EQ3Sb6B8E-fQ@mail.gmail.com>
Date: Sun, 17 Aug 2025 15:54:22 -0700
Message-ID: <xmqqqzx9k19d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ron Ziroby Romero <ziroby@gmail.com> writes:

> ## Design outline
>
> * Add a `PRETTY_JSON` constant.
> * Create a pretty-json.c file to output JSON log information
> * Modify pretty.c to call pretty-json to output JSON when the flag is set.
> * Use existing utility functions written in the existing source to
> output the JSON.

Is this limited to only giving another serialization format to what
is in `git cat-file commit` output for sequence of commits, which is
what I see in the example below?

Within that limited scope, I am curious what your plan is to deal
with header elements like "encoding", "gpgsig", "mergetag", etc.

And outside that scope, I am not sure what the most useful output
would be for things outside what is in each of the commit object.
E.g., various "diff" output, e.g. --stat, -p, --name-status...

Leaving that outside the scope would be a very clean way out to
avoid confusing design issues ;-)
