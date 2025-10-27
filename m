Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CCE311C19
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580407; cv=none; b=Waw7Q75M6MQ77dSfpKPUhsfh+bKIzrTBC8H1J3zIs2Qt7IRdcCA/YtwcalLjxw3NDCAFspINw6n79jwOxp4Vv/bADMPHnJEeVSDP7amZCHwEmjKGpnla02a1Z6Fmm+5iouLxy44aRAeGlWLPmhKGZA7CrGloNjbclnW8ImdHTSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580407; c=relaxed/simple;
	bh=7N8ZpBAtJ1y/eeZK4o932grqqrL9if0iQvQ1OnK6g9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F42IaUpBD/1hWPIRJqyJbUyQXdAmZJ0unclql681cgDsOWh8/gC82mrCfZbtxlo7ns8oA7ID26Y6h3N95y0GdqgnNojUbR+OmoSiYD/BhG8aYFgf+OAJAlEULK28AltCLh66qQekFB54cnCe3g5JuR8qv0dox+7wa7VCwcE4dPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X1eDd5Mw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LZ0E5oZu; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X1eDd5Mw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LZ0E5oZu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A2B6EC037B;
	Mon, 27 Oct 2025 11:53:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 27 Oct 2025 11:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761580404; x=1761666804; bh=oz2sFLNGBN
	OyZZ9YF8aBUQPfGrOIgqD7Cw+VSqBi9xw=; b=X1eDd5Mwb6ce2RcWnNMrbqjblv
	Qb7Gd6cGxHLs68QdaiSuOuHTg0gKs1osNRbefaSEoUJEeqWOD/uPWwYmp9G+yta8
	88CYNbNuNCPy5+WP0BsamSK72X9YUCAziTKlU6NoZ8hGVuq9pIiY0RZzNC6UyPja
	Fh/CNWWSkWgpEEVzcxevPcEzZmhNQIArJaD9qqqmGvrDyIomXtytdu3p/3SfxvQH
	aHBjBfqYy93aJ0niKaWSPPfWpavIWGBMj1O4VkpNSaGi2St0wiUOSbKShrTCmkwM
	x2/47W6VAPxtYhOt16KCKY2gTfRWjoj4m/2wm79BOmGjTzDWbQEgnsda0fqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761580404; x=1761666804; bh=oz2sFLNGBNOyZZ9YF8aBUQPfGrOIgqD7Cw+
	VSqBi9xw=; b=LZ0E5oZuEpaq7LpM4YBIIcM1dK++S8KymvpIHg2t449C8iI1y9u
	VOrqMIwh2q8cidR8/E5d9HCXZubIwMxpVv4o47f8LySmqy34lGCQ9ji3gmeiorRc
	WNtZCRT3yXPfDubkMHoJNsRxdACLvP7Zvj1zf6FvBRxjPiRlvjt4skLlpO5rRsWe
	0j5x0Bi3z9HdVcmnojFm1ftQMlfwWZp3qF2Vr9cWgGYjd4DER8gO96eJnoIjs0vZ
	NoB6hGaHv6c04MC8N6R6AU962ZlfFi0S1VU8+G2KH6Wdv+0PyY7N1IGB6cTHjjIC
	viQ98+/SzJgXQoE+gebfN8HBZ/zudNnF0HA==
X-ME-Sender: <xms:c5X_aP-IKr4Bi0AIxjhPj0rM_GfUqUvZNNkw-ny7WjF-xpzF4TPZrA>
    <xme:c5X_aN9yE5tzFuiu4wCaxeZNvU5E2uvIhRHOraot6v807Gyjxw2Q6I_QuZcFbOYsT
    6961Uj3ZPBKXv2pQ1536LF7ucg2JpKvMdc5JrVFo4jNHvtgoKTixMI>
X-ME-Received: <xmr:c5X_aPQeVLPhcBRViNpprCxV_t-V09DDK79VNNIC7TU0EN_fD_Z1-okm62lDpb18baN0CRq8MORp9Ir2XhE7S8EfD8_kmccf1uBd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    thdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:c5X_aBfUP57RZfLV7ijdJOoeWTgkSGzswUnhGvLgat469o0_RseODQ>
    <xmx:c5X_aDDMonicegHOf8caS6p4sYKdSY-YpsqFLOucAo_ZIwmfAZAoWA>
    <xmx:c5X_aDlwUc_Ayao62WUhUPufRP8oBbF2gLxKBhQMCJWW-4o8uPb3ZA>
    <xmx:c5X_aOdZ5sbsyu3pGVQaWVCAGLuGDvXuCPC4h0yd0qU1RBdwZfXmPQ>
    <xmx:dJX_aF4BHb_sbFaSWNhI8K8MoLM4TP8NPx99Mk80tRQC5yMkJaFXMzHe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 11:53:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
  Jeff King <peff@peff.net>,
  Derrick Stolee <stolee@gmail.com>,
  Taylor Blau <me@ttaylorr.com>,
  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 00/10] builtin/maintenance: introduce "geometric"
 strategy
In-Reply-To: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
	(Patrick Steinhardt's message of "Mon, 27 Oct 2025 09:30:50 +0100")
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
	<20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
Date: Mon, 27 Oct 2025 08:53:22 -0700
Message-ID: <xmqqtszkjq8d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v4:
>   - Fix a flaky test because git-repack(1) always decides to rewrite the
>     MIDX, even though no packs have changed. This isn't a new issue, and
>     other maintenance tasks behave the same. So I decided to punt on it
>     for now.

Thanks, but this round raced against 'next', so let me fabricate the
following and queue it instead.

------- >8 -------
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 09:30:50 +0100
Subject: [PATCH] t7900: fix a flaky test due to git-repack always regenerating .midx

When a supposedly no-op "git repack" runs across a second boundary,
because the command always touches the MIDX file and updates its
timestamp, "ls -l $GIT_DIR/objects/pack/" before and after the
operation can change, which causes such a test to fail.  Only
compare the *.pack files in the directory before and after the
operation to work around this flakyness.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
[jc: taken from diff to v4 from v3 that was already merged to 'next']
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7900-maintenance.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 0d76693fee..614184a097 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -500,9 +500,9 @@ test_expect_success 'geometric repacking task' '
 
 		# Repacking should now cause a no-op geometric repack because
 		# no packfiles need to be combined.
-		ls -l .git/objects/pack >before &&
+		ls -l .git/objects/pack/*.pack >before &&
 		run_and_verify_geometric_pack 1 &&
-		ls -l .git/objects/pack >after &&
+		ls -l .git/objects/pack/*.pack >after &&
 		test_cmp before after &&
 
 		# This incremental change creates a new packfile that only
-- 
2.51.2-678-g0cd646409c

