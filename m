Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017B19D8B7
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683384; cv=none; b=i7D6WNxXfRWMd4AlGFi97jyhs5mdBfoRoSx0WCL6pg7KHtp8o0eeAvxKOa7N2jZyTNyeeJ6QIXfbVT41tFF4/P2+MpbE52SfxZSG5oIbOsmioQvmq4QXjFUOINHyeDKIaRh6NEULBbNrAU1GUElV1+yPSh7UIzy7LSb5AN1CsDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683384; c=relaxed/simple;
	bh=lHTvfXKp0vMaGRiZO/r+WK58HlkgZM6ENW6iC+YztPo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M7FlI+rOFNv9+icNd9hGdhhsV35MgJrwWDjd9sYgdFChs6NXPsb/6mHjYalBO709rASWJ+lKOt12tdi4tjAtEsHps7nzxlOAkyn2KUikw8dp/PHC5V/YpDKBY2jxnB7JgrURkkUyAAC2lhf4ZLrw18QCiRiyCx1mhk84zMrqJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uIdCe7Lc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m9gtVpZr; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uIdCe7Lc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m9gtVpZr"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD9051140268;
	Fri, 11 Oct 2024 17:49:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 11 Oct 2024 17:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728683380; x=1728769780; bh=ROnmifSLGe
	yyzYraxl1xTigF60ozQrkgekJIzFPzDJY=; b=uIdCe7LcSFFqW7qIv/7KoSYM9C
	4CgPLeRU6pNnL7Am5baqwJOUdmcs7PDUNukcLdwsCxoFgAq4BQwHwY30+1OKNpQI
	N95ySfaP4/R1ipxAR5cQhN6F4ca0kVnapg8dqiUBpg8LHNkx1WD7YKR4axZxHlbm
	VFrDU39IR6Nv2FMvenpVnTaMR840wGnWiOMMrO+xtvyQKPc2VPkpBwRAy5RUQUPL
	5a+8UH3Zpx/52XXwOIUTIbmnnZln/DpZZfiIsCbJcc1/91xSfwTz54J4xw85N60O
	g92VnZgDHlzL9VpR0rza7rjxJk/CSa8DFvOafsCjoKCMIw4JdQyrkfZBSkVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728683380; x=1728769780; bh=ROnmifSLGeyyzYraxl1xTigF60oz
	QrkgekJIzFPzDJY=; b=m9gtVpZr/rMJtg65kVRK5vrgEFfEJ3H3bXC6JdFKv1eP
	Dm9sAxVCMpKBoSBrOAMGvfD/M3bKJWLufXK4iN1H1ETG6WJW/gMXGYoj05mKB3Hq
	bABrvuPBj87PMqf/6bRJIC77csj+FrU8QJ29IZlTE7feDcUZQOItPW+0tk4ETwBq
	ZlaTP4ABspiNvjWLtEcXum/NLZHXG4u9SCgXOK2JS+VXLTbf2vb3FwJf/wloyyRU
	C3i1FAZD7oWU5t8iCjLmaDcBSPC7gSJ3SYGBuIqeuKMu83Aty+6ln3BBhS1klqoM
	Tary5ygBZ3O9gGVEqMwk/vGiaYHXR0xvW8P1Hw2qgg==
X-ME-Sender: <xms:dJ0JZ9iSK_RPM75bUhmcrMPoR5egSPJe_VBgv7QtRVuFLt1FyoID7Q>
    <xme:dJ0JZyCykRPqYKDXDAMXelTnYq8AsQL66Ds3118ga7IHx4upjFN7aWcL7UOJyl7LZ
    OjU8v3eM0gbsc06aA>
X-ME-Received: <xmr:dJ0JZ9Hv8SdAt5V1EalDBgJkewmVChsE6l5dTghyN5p-YzgW0NiY7oWGdqHLyAHyKnNQBZ9ShV41_77EdAoSQIvbQeZu_qZxJTfCuno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepkefhue
    duteekgfdtueegvdfgueeiuedvlefggfefkedvffduvddvkeeuhfeifeejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dJ0JZyROCPcyijRenQRPTAn6-N-sttJZf4OloUJLIoHl7RkLma1n4w>
    <xmx:dJ0JZ6xhMSJZpl8ad47FF5b7a-58mC2_1zH78O8G0ZLVG_GzdzNa9w>
    <xmx:dJ0JZ466PaAsls_mXNXHs_XZBqhVpVmMV0MSSVGC1_aJA9fFctRMgA>
    <xmx:dJ0JZ_yTaUElwziCf6_AXcNKsWwfu5f7OHp414QMQHsQNdsGTmTw2w>
    <xmx:dJ0JZ194rsJQjmyz9KsUMEzvPqBhmXycmgN_UP2N4Aa58nxUMkiAfsBU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 17:49:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2] BreakingChanges: early adopter option
In-Reply-To: <xmqq7cb77810.fsf@gitster.g>
References: <xmqq7cb77810.fsf@gitster.g>
Date: Fri, 11 Oct 2024 14:49:39 -0700
Message-ID: <xmqq1q0mcnt8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Discussing the desire to make breaking changes, declaring that
breaking changes are made at a certain version boundary, and
recording these decisions in this document, are necessary but not
sufficient.  We need to make sure that we can implement, test, and
deploy such impactful changes.

Earlier we considered to guard the breaking changes with a run-time
check of the `feature.git<version>` configuration to allow brave
users and developers to opt into them as early adoptors.  But the
engineering cost to support such a run-time switch, covering new and
disappearing git subcommands and how "git help" would adjust the
documentation to the run-time switch, would be unrealistically high
to be worth it.

Formalize the mechanism based on a compile-time switch to allow
early adopters to opt into the breaking change in a version of Git
before the planned version for the breaking change.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * As we discussed and came to agreement during the review of v1,
   let's specify this as a build-time knob.

 Documentation/BreakingChanges.txt | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
index 2b64665694..eeb26c9155 100644
--- a/Documentation/BreakingChanges.txt
+++ b/Documentation/BreakingChanges.txt
@@ -59,10 +59,29 @@ over time. If circumstances change, an earlier decision to deprecate or change
 something may need to be revisited from time to time. So do not take items on
 this list to mean "it is settled, do not waste our time bringing it up again".
 
+== Procedure
+
+Discussing the desire to make breaking changes, declaring that breaking
+changes are made at a certain version boundary, and recording these
+decisions in this document, are necessary but not sufficient.
+Because such changes are expected to be numerous, and the design and
+implementation of them are expected to span over time, they have to
+be deployable trivially at such a version boundary.
+
+The breaking changes MUST be guarded with the a compile-time switch,
+WITH_BREAKING_CHANGES, to help this process.  When built with it,
+the resulting Git binary together with its documentation would
+behave as if these breaking changes slated for the next big version
+boundary are already in effect.  We may also want to have a CI job
+or two to exercise the work-in-progress version of Git with these
+breaking changes.
+
+
 == Git 3.0
 
 The following subsections document upcoming breaking changes for Git 3.0. There
-is no planned release date for this breaking version yet.
+is no planned release date for this breaking version yet.  The early
+adopter configuration used for changes for this release is `feature.git3`.
 
 Proposed changes and removals only include items which are "ready" to be done.
 In other words, this is not supposed to be a wishlist of features that should

Interdiff against v1:
  diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
  index cc19e03230..eeb26c9155 100644
  --- a/Documentation/BreakingChanges.txt
  +++ b/Documentation/BreakingChanges.txt
  @@ -68,15 +68,13 @@ Because such changes are expected to be numerous, and the design and
   implementation of them are expected to span over time, they have to
   be deployable trivially at such a version boundary.
   
  -The breaking changes MUST be guarded with the configuration
  -variable, `feature.git<version>` to help this process.  Each
  -individual breaking change must be implemented in such a way that
  -for a user who has this configuration variable set to true, it goes
  -in effect even before Git <version>.  Note that setting the
  -configuration to `false` MUST have no effect, either before or AFTER
  -Git <version>.  In other words, this is purely an option to recruit
  -early adopters and not a mechanism to keep the old behaviour after
  -the announced version boundary for breaking changes.
  +The breaking changes MUST be guarded with the a compile-time switch,
  +WITH_BREAKING_CHANGES, to help this process.  When built with it,
  +the resulting Git binary together with its documentation would
  +behave as if these breaking changes slated for the next big version
  +boundary are already in effect.  We may also want to have a CI job
  +or two to exercise the work-in-progress version of Git with these
  +breaking changes.
   
   
   == Git 3.0
-- 
2.47.0-150-gc349d40f0e

