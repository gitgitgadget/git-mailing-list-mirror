Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFA614F12D
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736979121; cv=none; b=sV4eRjr0NCJ/W3qHV4xE9oaEKPjeqxM/4sUrAw6UTW8PMK6jVYY3wfBGdSlbObe6mzYQSjt39q0qS4CRyNGXDq92LC7+2LDlShuMC554hTMYy6waa0b9aD5mYhgtAJ2eNpH9ll0r4RyGam7YuDhckiwM6cV6kULu9LO3/qJ0mWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736979121; c=relaxed/simple;
	bh=c1dYXEuCYpNZuRo5nmu1pw4hR0aJshb6fU4tB591+WA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IK19W8Z244xGeosmb6WcVMZLcW6H1Z0ryNFQ9qMHPhXo0TmvNL8JkXgJHjhWLM43unK1MfPLv5MnAuHpHLaQwQ5S/kx/pQRNYHsu7pzUctEFX/7cIobA3cdagQEoex6hExl7IqFEevwW6qaJJcadEpi5i9wvkI9DKnKC83OM7Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l5Yb2J+C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yPK+qo5F; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l5Yb2J+C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yPK+qo5F"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D09E52540112;
	Wed, 15 Jan 2025 17:11:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jan 2025 17:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736979118; x=1737065518; bh=Y+MQN9Lhhk
	mmo/LAQgNl6CSLG01JCVMilR0ivvTnzPQ=; b=l5Yb2J+CBhy+kFM0GwTvqjK9Nv
	V6M49yGWZB6jYuN3e9uo1uOZJJjuFmKQSDoObNluN/15G0qRxpPbbJd8ZBj5eJAn
	NZUfzYWndeBYLcnDhTxUsP5avM4vJkb2IYBjeoQqW2JovdKddpEzDP2sN5oHFNiq
	uhWZJacCVMcXXjonVN6Ka8kheUHYKuRAMQxw9sIwac/xJzVAsOsfyKx1hTPDuvl2
	JOJ9aHug98ybGCv7R67R2xH4mxTTQz03RihAqqgJpLVPu2q+36fr/qc4Dv72CnAS
	t1PZcUSMkkTRltWv5pBa8o2tw29gPundRmAkymtID+tAjgMy4X6hbgSSkZpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736979118; x=1737065518; bh=Y+MQN9Lhhkmmo/LAQgNl6CSLG01JCVMilR0
	ivvTnzPQ=; b=yPK+qo5FlTBZ97SFq2zn1JAifOMYX3cMjaMCZvi3vVTq2JKGaDa
	XT6kyTyIxe9H7Ztwhk+fdWZn8dBWckB4cWbQ4hU9exRHddN9MO5ksz8KKCSNOllp
	FB7mh4V7WAmFIikqZCxeUfBfkaH7iKFM25sw9rKYxqjOza/2R1+q6xphK11kiDMp
	7cAKBQir5PQ8vYMQ3AWieUg3bLS9LA9caxRBOD//i49RF+ISa3724D8gQckA868/
	JQpUpPVBLhsVOwA2KyUA19hfpPx/wGeL+EjjT0Gx38uTfQkcIfnX75EhaWN3zUZh
	lXnEYMGqZDUqYKNEiDdW+fNUf4zqaT+jX9A==
X-ME-Sender: <xms:rjKIZ-L4bJUu-f9VMqhtH_T6P2IykSY11N3JY1mInRWRGf2aGvQ66w>
    <xme:rjKIZ2IgTzvGL4sg1RTpZnUCOGC9p9KEav9szQmtDQsi8ubn3NizzEp5sp7Pt5RQi
    TkwbAXKZsQ5U4Rkjw>
X-ME-Received: <xmr:rjKIZ-stgSW9MwX4BqP2-B4bAjJKtZDI3KCE8hCHMwTfZ-00xRuZ4eivvgftVuirXXfBzy0NufsR5PjoAgSz3ESUMZCGZoRCwhGF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgtvghplhestggvphhlrdgvuhdprhgtph
    htthhopehjohhnrghsrdhkohhnrhgrugesuhhnihdqmhhuvghnshhtvghrrdguvgdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rjKIZzYbyWrZMlYLDJCyJ1vdF9ZymcgB6xHiNrJSXr6lIotO68zuNg>
    <xmx:rjKIZ1beHkxoz1H2JHNFyUAkvjMP6sYAT6O4TygXnwaOA5iuLQO5IQ>
    <xmx:rjKIZ_CKFDFdmhy-yB5fxEo0oFwpYKrLcY4Xx1G4oj67l4hQuFGAww>
    <xmx:rjKIZ7ZZcALkIyuNXHUKg1C9-gnJcbpf4yNgAa-MqwMAqFghIntfGQ>
    <xmx:rjKIZ6Nacvzlv8skNYSnhqkZr34KpV-YswzHMCGPQ4o0v08-_MLy5WMt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 17:11:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?t=C4=9Bj?= Cepl
 <mcepl@cepl.eu>,  Jonas Konrad <jonas.konrad@uni-muenster.de>,
  git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
In-Reply-To: <20250115212952.GA96537@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 15 Jan 2025 16:29:52 -0500")
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
	<D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
	<c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
	<20250115171423.GB57018@coredump.intra.peff.net>
	<xmqqmsfsx8oo.fsf@gitster.g>
	<20250115182419.GA86610@coredump.intra.peff.net>
	<xmqqa5brydz1.fsf@gitster.g>
	<20250115212952.GA96537@coredump.intra.peff.net>
Date: Wed, 15 Jan 2025 14:11:56 -0800
Message-ID: <xmqq1px3ybf7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> And it uses code 129, even for "-h". I don't see any explicit rationale
> for that in the history; I think it goes back to the beginning of
> parse-options. It happens via the PARSE_OPT_HELP flag, but curiously we
> also trigger that for ambiguous options (which should exit with error).
> That might be a bug-in-waiting if we start handling PARSE_OPT_HELP
> differently.

There is another class of callers that are protected by the same
"argc == 2 && !strcmp(argv[1], "-h")" condition, and they call
usage.c:usage(), instead of calling usage_with_options().  These
calls (but not all calls to usage()) need to be updated to use a
similar helper, say, show_usage_and_exit_if_asked().  Sigh...

