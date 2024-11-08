Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B610D528
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 03:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035636; cv=none; b=f/Qt8lQAHNzOmJa48UfYdWFaLPfkdYiYI3cclGBOVV4ZkkGqzuO/A6qcJGrKMU1Bl5pnZwKOHTQ9aFh64Om5oCiOOfrMNh5uJc7hcST9tnTj910IWycZTTHYlKbzcbfdxib2tgIO9VIDY7JAVEI0CiP+CFdFF40XWF77kSNLrTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035636; c=relaxed/simple;
	bh=X7Jj5FQcEprUUZhC6kulnXJqNJqZktCgz4wkOmRkXtQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OW4KNj+N3N//8Ieswesbl6Q8mvnKipY6Ie8/tGkFP0ZPk2UHVGZRx4RXnKYsubEGP1fMBSVuWJNj0S4/XCVgVVZ8Pafn7ChsielYYN8V8TSeEk993KAloDBz+YI+6NooK6SPJLFH/UivihIStEI9zx6Yt2tVPbw1dRd0tBDz7p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bV0SiLgS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jDUy5C9X; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bV0SiLgS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jDUy5C9X"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A1F8411400F6;
	Thu,  7 Nov 2024 22:13:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 07 Nov 2024 22:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731035633;
	 x=1731122033; bh=o1vJ5hRcuq/GLENS9LmuB8hu4PS6tfV+44las3kAMhM=; b=
	bV0SiLgStVm8pw2bUR+ZmmWs+tT06HZ5D+hYz6XQMuD5/zbBwAD0Ckt+UCkr/N48
	8BfKgcXWEsOETwdHcVCGm55fvDa+ivzVIkcPc89m800+IYCO11HSV2QF7PsHGDOc
	VUGssFC05Vy1bG26MgfMdWe872LA+HSNCWdXt1eDpzJabO3a4/mlNERov7fpc9UK
	lpb3l3jSATm8ESVB9+9CgCSTXI/0LS1WwI+7ndt10lYjVPz4pojCAGvzIYWefojW
	8iRBdJB8W1naVowIZg7KnwODCUMJ1ERKpPODBRgYldarE2tyK5z/6+MRddazyE/D
	c2nfXa2qhQtfJqG5VJRH5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731035633; x=
	1731122033; bh=o1vJ5hRcuq/GLENS9LmuB8hu4PS6tfV+44las3kAMhM=; b=j
	DUy5C9XTN7Ac2pg6K4pBSYkmF0HC0vVdiaH1USqLg1cWLADssBD54zS/6zjI9jHE
	TRtJfQUPZ+CGsv2TsPYfVM+QMIyk4yZnyiX6B90O8XcE0kf1XFuAVBHf+z21D1g7
	QqYLS5Xp5lX8io4ZVq6Rj6eruWRY6HL+8FAR2xKj9SpgrnY3M/VnPCoiMIQ7UJtA
	N8pB0gDEqcw0UkqcsBsuHWHCLHVpyjDlU5lMWKlcwfVX6V6qfYErggVBX2WpdrgL
	M2hcDDvKJWDTznRu675StQYKxTALCg19EHIlhSiGz45ITus73kXWxhlzWOJWkKtg
	JQQMZyiDFNZqVarwCGFJg==
X-ME-Sender: <xms:8YEtZ8X0C1b0G5Pd1X4pHNkhlg3l-yyVnHRTntr3o3rvhycdb4VIeQ>
    <xme:8YEtZwlSkiQKpEpH3QBhHUDlHhJRdJuAFIQb8Ajh3uGiUKAVrKPFy7BaFLb2uaRUj
    8OT5cQUEzP3XjgwuA>
X-ME-Received: <xmr:8YEtZwZcrW0O4jGhcO5H0YneUFNB67OGTpUqXgIvIYJT_CqUA6edR1YNlXa1wlpf9lh9HJYGQn_uRMmpjyqPoJWKdOcq3vrK6Blc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffg
    kefhhfetieffteehleehtdfghedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghouggvsehkhhgruh
    hgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:8YEtZ7X-6MEWW8mNlmHvxi3WcvL6heSy8AhRb88udtZjQuk_QpfedA>
    <xmx:8YEtZ2nVKuYyLevtqXG-0lZUwtqRpXdSyETGswTJ9i7fpChuYSsoxw>
    <xmx:8YEtZwfQq8cU1o0j9ksT1uSYiJr2rAQANpyC0iTHYqEVeyl5Sk70rg>
    <xmx:8YEtZ4FuH6wgujhaT8QNtSh_XjkAvLYJwnYwyX2bLPbBzB_NYHPDAQ>
    <xmx:8YEtZ0YVpGVcKW9L4p88sU11lLGNhb0CLxsqFjDt4NoLAWmjs5sjbFg5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 22:13:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org,  "Patrick Steinhardt" <ps@pks.im>,  "Taylor Blau"
 <me@ttaylorr.com>
Subject: Re: [PATCH] t1400: fix --no-create-reflog test and description
In-Reply-To: <4e68a04f-fb5e-49f9-8ba2-661027d8165d@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 07 Nov 2024 13:11:15 +0100")
References: <ab7d4c8d89c075de05bf04f1f9dc195145455964.1729439476.git.code@khaugsbakk.name>
	<4e68a04f-fb5e-49f9-8ba2-661027d8165d@app.fastmail.com>
Date: Fri, 08 Nov 2024 12:13:51 +0900
Message-ID: <xmqqwmhepgcw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> I didn’t get the impression that this is expecting a reroll.  But I
> haven’t seen it mentioned or applied to `seen`/`next`?

If the interim maintainer did not think it is ready to be queued to
'seen', I won't go back to the list archive to pick it up (after
all, that is part of trusting interim maintainer is about---otherwise
I have to go back and consume all the list backlog, which does not
make sense).

If a topic is worth resurrecting, do resend it for discussion.
Looking at the archived discussion (for this topic I am making an
exception), I did not get an impression that this got a "yeah this
is a good thing to do" support, only a lukewarm "it may be a
starting point in a good direction".

Thanks.
