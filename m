Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D1127AC35
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068020; cv=none; b=TsPrsVvsY77R+TfGIuBpdbsK+tONcMPSOi54gAWWtIE8Lly/k7u2XK6q2K4ncnbqeKj3PNTHidbr1uyKYR8puQZeMqH+VuMHnOn3XwmsK71t+F/wgL91oNOmNKqXhe2ITOd/r8mb+sXV27IjmhIyjdpYNCM2P2pY9ktjKrZRoHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068020; c=relaxed/simple;
	bh=mUJe1qxWSGEzR1YOP34xr033KfnnX5tbdVBiIzgcEdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cD351WVkxuoIymgqpIrMhTIA1Leok1GI72d5kAQtZW4/XeFtIyy72ejPv+kIzbg/u7d5r1Qhyfw8Pbhp+pr04A6/Q+AbnQ/QLpVw5It6oL9o3RxgbWhu5T7Nkojk6uCZypetNSpIVV4fvGXGJ6oGwTMeicr1kOhLM5IuMnkFliI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=adaWpFdX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QWGYpcVm; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="adaWpFdX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QWGYpcVm"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C3B27A0181;
	Fri,  1 Aug 2025 13:06:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 01 Aug 2025 13:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754068017; x=1754154417; bh=TBuP/g+a+N
	QE9FCYpv8+RQB5nyHj5xfNBvC4b7e7siY=; b=adaWpFdXRVrPXICvch2MJioCxD
	zxgbOu9jR7ez/+bCSv/kvkNCjHWP0VL5CO1MAfYqYml3osZ/xw6Vx7Ye1b7Z5DVK
	OlkAhOG1zneCji2d1ce8XI7lXTXvPLhurWe1yK0U7BnN2FTBIiUkb1tC/6j5MPxd
	9us/NLubNO3GfBX/SStvRoHhpS0DUhEbo1HzWrg30odJnHHbUzZflIkHmJsi7tiv
	GVnxwaq6cq/mGdTIizAMKJDYzYsf6YwPZbhCdif+hfHRVmxcZyvKKqBo8/Mnw+j4
	ECfyjgYmYBqAYXEhRfFpaxTTu7zUT0rCwwkwcWJLn/LqeHj8sFwVRxpVIWog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754068017; x=1754154417; bh=TBuP/g+a+NQE9FCYpv8+RQB5nyHj5xfNBvC
	4b7e7siY=; b=QWGYpcVmpK5fhI21YqPvYKjbAoRmZTK3XRz1rMD6qoUgxUg+Q75
	pr8sCPTuzG6n0u14GKcYivp+m9Q8VE4DnH6lZ1M++l/z+UTVbHwYHNi7t+oHJxf7
	kQnqdup2YRseu2zzC63AA0o3joL3tANC8jKROCzNQ/F/+ZhDYC8KqL+/y4SVsNbQ
	j+u2ezF5iTK0JyMWYSqhz8FBhjyWSKqvr4T05TIU0QC1fi2SVdtwD5VNoDnDOOjA
	Yk8+j5Yp2zg8tT0ZY6wNcgSxu/xw6jIZTRGZ/mCorYVwyPYUfI1+jPf1bhxBrv5N
	lEAaizZWRDTc9TDcXbVQVTBP4dwlppc5dHQ==
X-ME-Sender: <xms:MfSMaJEHoOVWmZbOBbaNGXK_vPE7erSyJ6VGmdQWevv0zivB50RmCQ>
    <xme:MfSMaKC3Qbf2lbMk7QOlOo1Gpxh6P7_26I6lpSPH6dEh9qr2DQScG6y117KytcU0x
    4gM1ppQlz38FVkt6Q>
X-ME-Received: <xmr:MfSMaHnw6UmXvDGBTJ3qFN3j4W-gVBqlsX78kyIwgQ28mhXz9woQ_6zvUgVLLqKP-fGPy6N70FKUPCb0ODEPnZlizeMuTlnbqywG1uQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrh
    hishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhn
    sehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:MfSMaIPxUaA7xMV8-nyQO5IGkaB6rh5U4DThtEhZo_g3ewmRrgcu1A>
    <xmx:MfSMaE_-pflN74589phcuPVPxKBPQQaBtDS6tCvEYNs9gNT2AUEvfw>
    <xmx:MfSMaKGqvPTOH9dWnDnor-U91UBGgW_wmFIfE0tGFSdXLa1q2MBS-Q>
    <xmx:MfSMaDhdf2JK3Cp3n6CJCDCmDh9LLmcQMPh-naiNpS4m-o8K_jT76g>
    <xmx:MfSMaLcfE3gbd1PZA-vYAotA8saUJxbodErEEGFyuJHJMqZoh5YEc-vS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 13:06:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  Toon Claes
 <toon@iotcl.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Derrick Stolee <stolee@gmail.com>,  Jeff King <peff@peff.net>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/4] last-modified: new subcommand to show when files
 were last modified
In-Reply-To: <aIyVft9PdlorttzZ@pks.im> (Patrick Steinhardt's message of "Fri,
	1 Aug 2025 12:22:54 +0200")
References: <20250716133206.1787549-1-toon@iotcl.com>
	<20250730175510.987383-2-toon@iotcl.com>
	<CAP8UFD0AEKDmvQJTanL+ZS+U66WAZz=FKSJ3LPE1QHSEyH-zNw@mail.gmail.com>
	<aIyVft9PdlorttzZ@pks.im>
Date: Fri, 01 Aug 2025 10:06:55 -0700
Message-ID: <xmqq7bznm0nk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > +static void last_modified_release(struct last_modified *lm)
>> 
>> I think these days we tend to name those functions using "clear"
>> instead of "release"
>
> It actually depends: if the structure can be immediately reused
> afterwards without requiring another reinit it would be caller "clear"
> indeed. On the other hand, if we only release memory it's "release".
>
> I think this function here falls into the latter category, so it's
> correctly named.

Given that even a long-time contributor gets confused (including me,
who needed to see where we documented this for our developers),
perhaps a clarification patch is in order?

--- >8 ---
Subject: CodingGuidelines: clarify that S_release() does not reinitialize

In the section for naming various API functions, the fact that
S_release() only releases the resources without preparing the
structure for immediate reuse becomes only apparent when you
readentries for S_release() and S_clear().

Clarify the description of S_release() a bit to make the entry self
sufficient.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
index c1046abfb7..76ec6268f2 100644
--- c/Documentation/CodingGuidelines
+++ w/Documentation/CodingGuidelines
@@ -610,8 +610,9 @@ For C programs:
     - `S_init()` initializes a structure without allocating the
       structure itself.
 
-    - `S_release()` releases a structure's contents without freeing the
-      structure.
+    - `S_release()` releases a structure's contents without reinitializing
+      the structure for immediate reuse, and without freeing the structure
+      itself.
 
     - `S_clear()` is equivalent to `S_release()` followed by `S_init()`
       such that the structure is directly usable after clearing it. When
