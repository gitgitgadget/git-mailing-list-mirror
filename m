Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907331F4CBB
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763706; cv=none; b=NlsuuTVPTU3e7VN2CEsmSlJ+mgOkokAhUMnX8awC9XCbSKhoIRivsaSPYk8tMiqVY+8NJidRhU4pupXiUONNSCXQwTlOFT0A3rdI5FevesVjsuBFKiy544oFWEhGAeknzUJDMYmMut8NqEJu1ubrVSm1vplrty+HkluHdGyCoLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763706; c=relaxed/simple;
	bh=choSPPPnXeWW39pIB02MWkTPDGhl9x06Ck5sxY07maI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d5v9h/Qf84prFYPkismp2QHgMMDb2qECfx+wO8AAudw3HUBhbUObHiNrWPowHBQPLd8dypgpRSnnbJNdBtrFI9RpB8PNKKaw+DgKsLRXk+BS/4Ze2h0yCCZk9Xpc0GH/2IKNjEADNbvRGQxjorvqo+0NPA1mQGEjlyI8YZHRszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ydyJIh0O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TA0v0o5k; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ydyJIh0O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TA0v0o5k"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id AA46A138273E;
	Fri, 28 Feb 2025 12:28:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 28 Feb 2025 12:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740763703; x=1740850103; bh=JfQqD6aEKb
	Pjbn9q2wiKVOmmYa36Z2rCywRR2NMdsZs=; b=ydyJIh0Og6PTsSRD12QTfwWXxO
	yOigfkaDU5CerJJnHYETmVV8EKKU+fqWxQRtKRYo3PvoXBGj+At4BvlRox2RUwhc
	ApQvrxa+k3oAaf0t1ghkNq+JN8Yee3RCB1qNOY8SMfYRHMNzrXGQcIKu/6YZwWIB
	nX+cMB8bVNTnZmwEo138weH58Ce57SCoeEg/GCPXmstvr9Vn22otJ2D5SzgMF4J9
	REv9Q+OPRuuBPl6Fl8nZNOlnsXows085RNQi8y8ffNWEjacoO2i/NIG3Uq9mde1k
	IRZToyvlHbakLu/wxul527FZRJWjFFUjYW7+enXwBmtNNaSciMlrGgx+zQjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740763703; x=1740850103; bh=JfQqD6aEKbPjbn9q2wiKVOmmYa36Z2rCywR
	R2NMdsZs=; b=TA0v0o5kjNvqTGzp4hiD/zRX+MU6yGTAX+JxvyYpYEJ94lzDAn8
	/Sj2czNmCEVfzrbb63Eka23vmx9wl/gTiUqYX89jJmNflIjJTHNVcR1i236vZ5LL
	o0HKqpKQz5bhx8k6FDttFFbrbqP/5sy9hEdzRJSy29SWYtZgj/YqIwMYDhYrh9PG
	D8EIVNt+ZHZ+BSpWi1h4bv5vAZA1Ppe7CIA3UgTFOkczQbDZb0zDDtWrrfwv0diC
	EQ25CKryLnh9vJmsTiWmubAS5o4XSs8uCIhDEaS7AsTYngNQDv12NzAW2feiNzJj
	mt9zatSMhFEHuMXWRfsIIqeUFl0lCN1cZOA==
X-ME-Sender: <xms:N_LBZzH5u9l_hvwJJYUjcj2gOLxplINRQD8xNlef8LK6xcrvilHa8A>
    <xme:N_LBZwU8DRaywH7A9AIoYRMYCoT8dnWyfrzet_RUEe6EMfbVrkPYbdOg-4buGefXc
    AakaJiSqNQvmuuRbw>
X-ME-Received: <xmr:N_LBZ1Jki-lpNYpjDPVW0CEYLlrdjGEx2I03mOUNSoZc1zfY9AIELz4lxrqjurc4ReEx_9CCjNyiHhiU33H0KmQ9ONtNwK5jh75L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefgfevffdtieejvdfgffeggfffledvtdej
    ffehjedtuddtiedtgfdtvedtkeevieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpd
    hgihhtfedrihhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:N_LBZxHP9ohz6Z58kamwsHqDsleDTjCcfz0-uo51mDs8CKYXsRsp7A>
    <xmx:N_LBZ5U0D-0aTAWFOV-oKlR4D9tav3dyHIGU4C5Pwf4zF3bjIvEk-Q>
    <xmx:N_LBZ8Pd-cgPfpH-dNWKDn9srpj9boKmRzUbG80bBgDcMGIX8A1Nyg>
    <xmx:N_LBZ40vAgzCjb5sdQ8sfuJMSzzLN2lHJbHMygTsTpG0O8dMafqi8A>
    <xmx:N_LBZ_xCI6-l-uqR0_4j_T5yrSbvnIkpp9tIBTx5KxZFOkjSaZS-hJE3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 12:28:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re* [PATCH v2] BreakingChanges: early adopter option
In-Reply-To: <ZxA5OWL1AuQxA/NC@nand.local> (Taylor Blau's message of "Wed, 16
	Oct 2024 18:07:53 -0400")
References: <xmqq7cb77810.fsf@gitster.g> <xmqq1q0mcnt8.fsf@gitster.g>
	<Zw9ppbrFqVN5S50J@pks.im> <ZxA5OWL1AuQxA/NC@nand.local>
Date: Fri, 28 Feb 2025 09:28:21 -0800
Message-ID: <xmqqv7su2d3e.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> +== Procedure
> +
> +Discussing the desire to make breaking changes, declaring that breaking
> +changes are made at a certain version boundary, and recording these
> +decisions in this document, are necessary but not sufficient.
> +Because such changes are expected to be numerous, and the design and
> +implementation of them are expected to span over time, they have to
> +be deployable trivially at such a version boundary.
> +
> +The breaking changes MUST be guarded with the a compile-time switch,
> +WITH_BREAKING_CHANGES, to help this process.  When built with it,
> +the resulting Git binary together with its documentation would
> +behave as if these breaking changes slated for the next big version
> +boundary are already in effect.  We may also want to have a CI job
> +or two to exercise the work-in-progress version of Git with these
> +breaking changes.

So we decided to give up the runtime switching idea (which was what
the v1 iteration of this patch proposed), and instead to change the
behaviour at compile-time.  One major part of this decision was to
deal with documentation and other things that cannot be changed at
the runtime with a feature.* configuration.

>  == Git 3.0
>  
>  The following subsections document upcoming breaking changes for Git 3.0. There
> -is no planned release date for this breaking version yet.
> +is no planned release date for this breaking version yet.  The early
> +adopter configuration used for changes for this release is `feature.git3`.

Hence, we should strike the added sentence out of this hunk.  But I
forgot to do so when I prepared this v2.

We also discussed how to deal with irreversible changes to a
repository that renders it unusable by the current crop of Git, once
a such version of Git from the future touches it.  Floated was an
idea to put extensions.* mechanism to work for that purpose, but the
resulting document does not have anything to say about it.

Which I think is perfectly fine, because such a "repository
incompatibility change" should come with its own extensions.*
mechanism to protect the resulting repository, whether such a change
is part of the WITH_BREAKING_CHANGES feature set or not.  It is not
something the BreakingChanges document need to discuss.

So here is a small update to the text.

--- >8 ---
Subject: BreakingChanges: clarify the procedure

The point behind a compile-time switch is to ensure that we have a
mechanism to hide myriad of backward incompatible changes that may
be prepared and accumulated over time, yet make them available for
testing any time during the development toward the big version
boundary.  Add a few words to stress that point.

Since the document was first written, we have added the CI job that
the document anticipated us to have.  Rephrase to state the current
status.

The discussion in [*1*] made us abandon the "feature.git3" based
runtime switching of behaviour and instead adopt the compile-time
switching mechanism, but a stray sentence about runtime switching
still remained in the final text by mistake.  Remove it.

[Reference]

 *1* https://lore.kernel.org/git/xmqqldzel6ug.fsf@gitster.g/

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/BreakingChanges.adoc | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git c/Documentation/BreakingChanges.adoc w/Documentation/BreakingChanges.adoc
index 042709a461..bdfad29d8a 100644
--- c/Documentation/BreakingChanges.adoc
+++ w/Documentation/BreakingChanges.adoc
@@ -66,22 +66,21 @@ changes are made at a certain version boundary, and recording these
 decisions in this document, are necessary but not sufficient.
 Because such changes are expected to be numerous, and the design and
 implementation of them are expected to span over time, they have to
-be deployable trivially at such a version boundary.
+be deployable trivially at such a version boundary, prepared over long
+time.
 
 The breaking changes MUST be guarded with the a compile-time switch,
 WITH_BREAKING_CHANGES, to help this process.  When built with it,
 the resulting Git binary together with its documentation would
 behave as if these breaking changes slated for the next big version
-boundary are already in effect.  We may also want to have a CI job
-or two to exercise the work-in-progress version of Git with these
-breaking changes.
+boundary are already in effect.  We also have a CI job to exercise
+the work-in-progress version of Git with these breaking changes.
 
 
 == Git 3.0
 
 The following subsections document upcoming breaking changes for Git 3.0. There
-is no planned release date for this breaking version yet.  The early
-adopter configuration used for changes for this release is `feature.git3`.
+is no planned release date for this breaking version yet.
 
 Proposed changes and removals only include items which are "ready" to be done.
 In other words, this is not supposed to be a wishlist of features that should
