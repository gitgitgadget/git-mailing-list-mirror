Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F67F312825
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776649976; cv=none; b=H5/3ZyPhnMcr4nyQ32IlGA8qS9iyRWlGms9wjPEORoVsZvt2670QtkV7XXFy1XR1v86ezzsa2qjtfQaJtzmh8vwjdNpgHKgBd2tkqb0O+xcyEXQluOOp09Ef4BUuQgKrbJUDsY4NgnC/SWHeFJNxsm9IaUKBO2MqWnSEd6tXIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776649976; c=relaxed/simple;
	bh=CNrx40LwNakLU3fXQsgDYxW55UORn69i/O0vHSulFg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t4Kro1ISVVsd74NhNU6NC0SOuYcuZYy9eTFNW/g1U+yqCIvikccNRwCXM4u3CME804JbpQlO7wYAkSuP2IXbZvOZ+xWIuPC6sRLRF/rtcR5Rojxo/BkRlGw051o/GWiOBPneJNR3hjwDr/28YwInmOvbwaNpvzorVN7L9p68TQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WWX26wEi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=clC4w7+b; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WWX26wEi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="clC4w7+b"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D14E7A00B1;
	Sun, 19 Apr 2026 21:52:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 19 Apr 2026 21:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776649974; x=1776736374; bh=CNrx40LwNa
	kLU3fXQsgDYxW55UORn69i/O0vHSulFg8=; b=WWX26wEitjoCCl0zmYHt0Iqjw4
	1CMpD5mpEDsXMEVLDAQRkEsz/Zm5MlDNMYw4rox3ThxZuevqiGFmRZ2vIamKX69V
	b2cRmg1Be3vuIvmNkcCZ66x2ZnSYkHURQs2m2pw8QpKIw2J2SCKqISc7ENuQvs3f
	/eGAQjShZlRZnBDoUNosBbRtvaCd3CO3O9PQyHrkmuZObGw9UhyPsidLGGS+tQxq
	cXh49RRXh7+quSAFwqZFINeC0pbgkcHlR2k+LO7gtjswrozfrJG3eR2p2DFzDM+u
	4d2CyKLGCyAIt16/MlQbGh98h47MGkEHcObWlXqbXSEhCZAn/qgpC+eZgo+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776649974; x=1776736374; bh=CNrx40LwNakLU3fXQsgDYxW55UORn69i/O0
	vHSulFg8=; b=clC4w7+bI1jxBC521BA2kT+cPH3pkSxZOTN0vRh6U0gxczHmCzF
	bEEpw773s3QXe9NMAUYlQby+Y6pGvOzCECs39BA6ascjha6mZAyjvGW2A3yrd9zq
	v1it7THmmqiGGyxDTHpeDRdUUkBMjT3FMIPtft5qF++Vs1CaMDp5WdnCpdmtpLjB
	m8nt+VuUpbH2UOImzSun9IPSEoJtEh4Ks1+i/jz2lb03gtSD9BmIXqaHbCgvl1pu
	ylhM8+oCnasNTrIFARQDMDsCuHU7SUFrCy+Dj+mqTkbBJ7TSLBG+beojrHV2ewO7
	296pnOi4zWCcFAbcR/W2VvsChZx3Tutz/kg==
X-ME-Sender: <xms:9YblaXFsTP4whNgh13m7sZcyfJBQDsFbGuRz8qLUwbfuTQ_mzQeVEg>
    <xme:9YblaYDzlN2kEIaI2TKi5ZH2YmfoXMJuS4ArX_vZl3brAmr0sh5VNypA1n4IkxXkl
    i-dUo3-u5JncCs3wPRpYm--OxgIVsbW49tYEtqvi4Osw-z1TVMJFg>
X-ME-Received: <xmr:9YblaS8I9O2rTN_cEYXLFHyz6qEmFERqHPupq12CMl4j9DGQcbdopuK0xDk1pV1HOaTdJ_2zUdhnqJDoxZIUqAoOmT6OMIej7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9YblacAlg8Gfkqt4c4r7U1swztAbiULY2gCa6bfmbWlCtxtCYouaCw>
    <xmx:9YblafRhN-xg-HgV6RyZmBTEY_joVDvXgoYQ5hp3Fx5u6lBNX0DGLg>
    <xmx:9YblabsLtsnpDNv5o-n_JN3wtOQSSzPYWHlG0C5EElhd3LdPZYgJqQ>
    <xmx:9YblaT13eXmmapCke_8DNlbKbOHABryoDUlj_LqtUkktNzIBRGP4Ig>
    <xmx:9oblaaTnp8a-URJPQgfHzAyyhHUhIG7D95torP-hYECQvxzemZJPWC-t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Apr 2026 21:52:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  Jeff King <peff@peff.net>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
In-Reply-To: <24a970c5-0d01-4f1d-b6ea-50be646351b3@gmail.com> (Derrick
	Stolee's message of "Sun, 19 Apr 2026 18:41:11 -0400")
References: <xmqqqzohd0sh.fsf@gitster.g>
	<8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
	<xmqq5x5s540j.fsf@gitster.g>
	<20260416051732.GA48541@coredump.intra.peff.net>
	<20260416053435.GA646718@coredump.intra.peff.net>
	<621c9da9-2ec0-462d-ae51-0be5e0ca6ab2@gmail.com>
	<xmqqik9q3n15.fsf@gitster.g> <aeFGumIlw+vcOt2a@nand.local>
	<24a970c5-0d01-4f1d-b6ea-50be646351b3@gmail.com>
Date: Sun, 19 Apr 2026 18:52:52 -0700
Message-ID: <xmqq5x5mv1mz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> ... interacting (or Git 2.25.0 and libgit2 or similar) such that
> the multi-pack-index continues regenerating with version 2,
> then the deletion doesn't fix it _forever_.

Yeah, delete and then set the configuration to force use of version
1 would have been needed, unless we took Peff's fix that is in
'master'.

Thanks for clarification.
