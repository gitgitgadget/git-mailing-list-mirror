Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A23469F8
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210663; cv=none; b=KP/6eYCngyGR6pw6dGvrAsT19HMAtYWMTK0sh85fISayGB7P2tsJMXpWGCo8o67xUDPLsuvox/+UfrltyCmvmTBfXhll3kiMF2bB0JdyX4Om8eEP6115P/bfRYh/one76drPCVzLxe1FqCzCTWtonathZdds4bWGNnH8EUrmJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210663; c=relaxed/simple;
	bh=MxOOQ3/xKptqIjfKww/DWpqPD0eLA15C4pMbTVP3AME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u2LPKkicuU4BsvBNgTSfTdmjpRyUp81wnCrZCAhicbdi4xqnD4HGJfGKqAd2VqqDNDI9h7M/tVR4mLoDY2r9/vjNZCOace3mb9ngD67AOYEitdOkmbPJuMuUrb6PuVTc+hnsXztPGmvqazu+8ln5fRGc/BNvlpmW8GUquCwLhWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SibH6rET; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oEeXrRBy; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SibH6rET";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oEeXrRBy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E1BD2EC0631;
	Fri, 27 Feb 2026 11:44:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 27 Feb 2026 11:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772210661; x=1772297061; bh=7gKYmGdgZd
	6z9wu1sbgucICEzBTApdiXfeV5QfHatvw=; b=SibH6rET396iwVfgxdmyxvS6IQ
	hxTqOOh7jDBGqxVoU0CZg6ocES5WktKehCyO8CVnDjAFviY3ctLAWmuroIVek09W
	OtfWSvDuK7SBE0hXwHLfLHSmCAputmgq4lUd8mKT7TO8gRMZYVPCO4t0iIYtGdcU
	uxaOMspdbBMUyYFP5gm0IU8hQ8vj7/Do38FYwxFupcp4+aMeXNwq6BY4vdJphylH
	S7xWlpSi0tlDOKgJ+ferPNkOJOuE/ZP9rbwgQARVKvbQ1WGaV928FNnAkAZn5F8Q
	9lz0Qd9IqHmPFueO5m6WeqQf6qwN+b6eNPmOLDbflnb9RnoB5hSMdjFaTJXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772210661; x=1772297061; bh=7gKYmGdgZd6z9wu1sbgucICEzBTApdiXfeV
	5QfHatvw=; b=oEeXrRByI0SBTC2pbGtOeQnQvgFhru1YE36P1SL8Xa9jqeh0xAA
	2oF49UB7OBeQFURRq3C+4GVuES67T+fyBsLFtErHFEoX6weJlZlfWPrTmDsUkERZ
	PunvGdhnfmzaetqTWQrx4Hs1mM8GNN49tJJA3i8MmPg/fEtDpXLChctGEiUabByl
	OxcTpwa3JK5LBKpM9VzZIGB7AcrVpjRGx3FgwB+BuuuvQVIkItOLYe5n/O130riO
	PVdXfL0pyn2HI1EXVGVYjn3loehnskBBeVFxA+DiweLKAywsKpjfC81ps8jTcsBu
	ESPbyNmH5r4hvlWYjBOnEpYYtxcIqgenedA==
X-ME-Sender: <xms:5cmhaYfzL-xdHYIKmj3jnsdk8VX_xpFoWIlxjtghJWXlyTXE6FJRzQ>
    <xme:5cmhaRO72Jo8zzDKvzOl-sRCM5QdKpIytNqmMez2P6W18eTCXhiiP8DLM4uVAO5Rd
    P0Ha-13ubIAdcrPSsnrfyXZAuqZIwFSYLJikQAawLvSefNIy0YFwg>
X-ME-Received: <xmr:5cmhaejGyAPyWLvRKN80PZbg7heV21FcYizWA9wI65xp3niG7QPRH7xbT94YpSVF0VXLMYUl4kKn0VsRxhoEvD0HoIcRPldOQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgruhhlsehprghulhhtrghrjhgrnhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhhuhgssehprghulhhishgrghgvvghkrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:5cmhac0uMWbxor9kjWIVFio4rYHSFnWiBP65FgSkAmMA_x3oTzWCew>
    <xmx:5cmhaQhROkur4XbbsPCovZdzpDdUCjF0BHB1EQcdFFQz2JPH67e7aA>
    <xmx:5cmhaUf-l16opgj9wmPkrsejFn4egbSzVlgQOS0wvLYC6gIc64sKHA>
    <xmx:5cmhabkhilg0G3ZebO78jDxNCnjAEFcBEyEvl0V9UJY-J3xl4dZlnA>
    <xmx:5cmhaYtn4003R8BzO6AFexIiVX-XHJWbsGazCLK0QsAiJKTFVZswJIpg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 11:44:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Paul Tarjan <paul@paultarjan.com>
Cc: git@vger.kernel.org,  Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v6 04/10] fsmonitor: use pthread_cond_timedwait for
 cookie wait
In-Reply-To: <20260227063118.9069-1-github@paulisageek.com> (Paul Tarjan's
	message of "Thu, 26 Feb 2026 23:31:18 -0700")
References: <xmqqzf4w8r20.fsf@gitster.g>
	<20260227063118.9069-1-github@paulisageek.com>
Date: Fri, 27 Feb 2026 08:44:19 -0800
Message-ID: <xmqqfr6mt9uk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Tarjan <paul@paultarjan.com> writes:

> The 1-second timeout only fires when the filesystem fails to deliver
> the cookie event at all (e.g. overlayfs in containers where inotify
> watches succeed but events never arrive). On a working filesystem
> the cookie event comes back in well under a millisecond, so the
> timeout never triggers.

I am not worried about that case.  When the filesystem is quiescent
and there is absolutely nothing fsmonitor needs to report, wouldn't
we see no "cookie event" delivered at all?

> When it does fire, the client falls back to
> a full scan, which is the safe default.

And if a every-one-second timeout forces somebody to fall back to a
full scan every second, that does not sound like a safe default to
me.

I am clearly missing something here.  Are we handling two different
kind of events, one that wakes us up to expect "cookie" events, and
the other "cookie" events, and we know the delivery of the former is
reliable while the latter not?  So on a quiescent filesystem we do
not even get the first kind of event to wake us up, and we do not
start waiting for "cookie" events with 1-sec timeout in the first
place?  If so, that does sound like a good arrangement.

