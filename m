Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1918A55
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759416326; cv=none; b=EDu/w2qLmDxoYm8lsDvMK01b2ETC3Fv5kklFbfPNpewTDKawVcFF+pYYlnu43qyY83x5fS1LVBkOKfNbV9TnfdYoH4jLDUcUYNagrxah/FR8J3ihWWeQfAN6fnM9MaJqKmkweAudJVlBVs7yVmG1vOVWw3J1O15/gqHXLQIZ8P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759416326; c=relaxed/simple;
	bh=iPoG/HBAmkx+P83jO1pFbAGAMG44fuoVLx3iz7VLRF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wb/APOyMsra1WSZkARrpDpz/DG38QrzfpIbL+NpxLGICDkHejb0oqLc43YzTq/ZzEaHVwai+Usvn5NlimcRgsxjjacbp7mJLAPcUAa2ieWM6Ki2BRuZtRczYPNKEyFN3jsVzr1hjFia3loj8swT4Kp4cHsxrfPBHrGjM1vJP5fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FfubuwtD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CsiUfZ5R; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FfubuwtD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CsiUfZ5R"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E192B1D001BB;
	Thu,  2 Oct 2025 10:45:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 02 Oct 2025 10:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759416320; x=1759502720; bh=Qa581bF1w2
	lc6obSjNz5wkyhf8Xt29XCBP1dxeAGvow=; b=FfubuwtD0EmOvU1f0VtO47otOW
	+B71XRubAQ8g1GWg/khQSQHrY/aalNVmgRmb2V7pGHmTzk+n89i7ZlFgJIwL6tBD
	00AuGh6VL7Ofa3mYecErA8hp/q7wmQtnAUOjHT7F38AzXWpHm0ZWDMq5GKoRHS/d
	lOlXOgURj/1wO8eMnie612QqiT0+p4JTBK9Prnp7ku3uNnczjNz0R838AHGmGDev
	hnH4WStMMvH7DpOw83vZLAO8hiFnxVUmElHyC33TlZuNMQ7cjvzwWIYGDftXl+gN
	COelkwgYQypB4lkcy5f24IJxPcNKmxfaE1FedZR4a9g9jFxzmOhHh+2crifA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759416320; x=1759502720; bh=Qa581bF1w2lc6obSjNz5wkyhf8Xt29XCBP1
	dxeAGvow=; b=CsiUfZ5RHAiHM20g7TkXS8+qI2A5S7PzWra2fo0VPAtzXTyHntJ
	T44NL6jnRLog5kEJRDwSLSQzjxs5OWuELCVhqPjRr/CpupCmUulHU+op6sdNLJwA
	e7sWZGA5PTN6ev9IHcAkdmDorhLDVmwGcvptGvY6ksBqEmbqzY7gd3Dy4oim4XC9
	vmpXAnvhnPu8atk6UUnkMVgdBuq3nucogetiD03ybk26iSbaXtVEPKXJMaY4AmrX
	SXXlDtvN5va9VpJq8q7gzxQJ0+tpvAkhJy2Kx8HUfvY2EawLKF8CEE+OZJZxcWl3
	WLj7nPmMNe69zmtd08I9KnbuInpdSCFWmIw==
X-ME-Sender: <xms:_4_eaJaLJATGrTmkHp-XDJ0D0hW60Bu98gXWSopKvt9hEwg49CF6TA>
    <xme:_4_eaHQZbXanNSFtn9MUA8duQWfi8zisL1jH2LoQGXwl8G8xPOlubJaDGYfEnEaXt
    Lxk1o2Pdm5jsvKcg0ptDnrUB_OGpl_4Ay9m-vkx-kRZXF3YnuTR>
X-ME-Received: <xmr:_4_eaEShVCOO0NfPVnXtOj6cBZszPQOMz3-G_ezLFCFchvSUbVfKmvxb1zdRcHRiKdAyx4O4qCLYMgtH-8ZJRH2fObZwZsDA7A5l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekiedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohephhgrnhihrghnghdrthhonhihsegshihtvggurghntggvrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrg
    hnhihouhhnghesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_4_eaDTsPDxVdshdE-bSjzrDLf_dHc4zMTJdwsDMj1zeaHjhbyynrw>
    <xmx:_4_eaB4HLW-x3-NPtvlIkvqUFSW1_XpXKniXN66lXabtLMt7hiNV8g>
    <xmx:_4_eaH1VNWJs4CmWHLuhUPg4RgjVEXU0E9b2ytkGS2qLhtTuLf6hKQ>
    <xmx:_4_eaED8-EZxJvEBP_9tjTAZq2wLzEiGYlNt6PveIZfnoqU9L47BGg>
    <xmx:AJDeaKoYCl7ENj4nPJhGeAAsXbdwV-YtLiwXxB3LPS51dEiH3-8f5uPB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 10:45:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Han Young <hanyang.tony@bytedance.com>,  git@vger.kernel.org,  Han Young
 <hanyoung@protonmail.com>
Subject: Re: [PATCH 0/1] files-backend: check symref name before update
In-Reply-To: <CAOLa=ZSboPeTNSSh1fsaKc+Ef5DhaKGX+mNiRzyYfvFERa=JLQ@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 2 Oct 2025 02:34:53 -0700")
References: <20251001150805.9652-1-hanyang.tony@bytedance.com>
	<CAOLa=ZSboPeTNSSh1fsaKc+Ef5DhaKGX+mNiRzyYfvFERa=JLQ@mail.gmail.com>
Date: Thu, 02 Oct 2025 07:45:18 -0700
Message-ID: <xmqqjz1dxszl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The bigger question for me is if there is an instance that you'd want to
> modify the HEAD file manually. Or is there a way this can be done via
> any of the existing Git commands. Otherwise, I'm not sure I would call
> this a bug.

As we discussed downthread, I tend to agree with you here that this
is a corrupt repository leading the tool to do a nonsensical thing,
and the true bug here is that "fsck" is not catching it.  But I do
not mind if we add a check at runtime, probably at the location the
patch under discussion identified, that makes sure a symbolic ref
points at a valid target the same way "git fsck" does.

Thanks.
