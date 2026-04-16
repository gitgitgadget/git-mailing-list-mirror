Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435EE257423
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365153; cv=none; b=YpxH/3HsibCHBJr8+PKarKKPSDvH0ayeC32rWpYRy5N5xSqrdtJrCL217WSpXXWmb9CSVxerZ/0PPrtVcOfy1IBvjR/jNI+9a5xI/s+LoLKIQDBfwSVJTiiyrVq21hakR/pHjX4mpwpblt8t4VWkjfuxgfdKDtytvI9kn3lJG90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365153; c=relaxed/simple;
	bh=8CcZr07iCbccI8+XkBwwLOhsVO7InA0T+qbEKXXYGA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sLieRLQGD52YBF1K1x3FH6DohjyS0lW/er0cBMFzov7nPdg139tl1w+E5M6rdx9XEKq7A/nyZh3spaw/nN6k22Y9mpKHsPRomAVG6vN5gD76IL/4JElpbAMCk3LmnkJa1iDf7tFfKehUo/6Bzc3O90wOcB6roQi1iMB4BH2IrdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ad9jAnGA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k7b6pCup; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ad9jAnGA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k7b6pCup"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E060EC004E;
	Thu, 16 Apr 2026 14:45:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 16 Apr 2026 14:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776365151; x=1776451551; bh=/T3hvII2LT
	BThEktppIDXpZiSAg46EN/h6YrqVniHEk=; b=ad9jAnGAuaPk6PhMXEEAnJ4eRA
	oP4EQq0tRYNI5AsuuEaNNheAwfqb6FFYbHZ0hDa5ZwG0oP2cWIVCfv1ujT64ZtL5
	Vbeuv3P0TynsTX+TTczVjfIR724K2V+4rT6bFUkAnsxvl2NFALO+K3266PWTGe27
	F6SvLHTYNFkKWi8VtAlbRvEDfZI5bxaEy+/IPotQ8SWWU3XlQnCcr0PBATLjkvgr
	urnR4IHtFjzRkKfSYGFZG+j2XJJlbDtEyvaoQjgA2rnBAfOYKQU2yCvudmOc2iix
	hoGXZpIIDzF2365jd9j8TTnZaRwdB0lF6WVmrIXbOSWhs19EQwvTT+1p22GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776365151; x=1776451551; bh=/T3hvII2LTBThEktppIDXpZiSAg46EN/h6Y
	rqVniHEk=; b=k7b6pCup/TOOCFzAeADJ4v3qS1sZKVXIFWqbjCbQky0/yFteiOr
	3wl674tf1Cxb+grMM5WG3q12p8+nfN5n/Ylf9P9fRCY/NkNsCY47V8b2TG67kgpN
	QAEO6usKPloUCViCd3Z/s493DHGNCLLzdYo+l7CL/857gYAsheRvtkkAidUCIOrv
	Y08flu6sP9AoVgMCywtpaIarcwK7qDrfaDSYnGCNV1l26JiCdTopcDUYVZviSQ7m
	4fAKSr/L9bA9SMoRGWtttZNoxOak8Z/dQiZmaAGz7BgVozsgtX2XKSAwFLgHGWHe
	Zn+AJohrPPQAtbQjGo54vXpWFW+NNE8n4jg==
X-ME-Sender: <xms:Xy7haYeM7GPxkFeTA3p8c5JPnyE4c9nmWtqC6uH60Jeez6TeyA1voA>
    <xme:Xy7haREGmsusZ6CaItBTD1vRPqQR3bFn8LSQ1IYU_JCU3OIxMWMkpzBoEJlc0EQwc
    ERutN0ytVE9e6GNQ985rZBQApKGh-5v9W-7NjBnL8xKv2Vu0ta63Q>
X-ME-Received: <xmr:Xy7haR1uxgooNM73E6aPYpETRKYu81jRCdlfGQSPpVyrzNsnKkW5hi74XBCoaIzBHNmnZ0aVtjwB7TDzH0ih_m89WZ3xmnChRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Xy7haZkayAtee_QPcIBL2cVv8mrJcZqqyhtA5ITvFr70WnkeTDQjCQ>
    <xmx:Xy7haR-GOjQoKD86a9dAtqtIcFV2lvp_oQTUtzmRUPlg-wnoSb-z8Q>
    <xmx:Xy7haepO-1tEL_-tnPuXC8rHJxYyAXARAIxiESPc7a4LoMJDNtNGcA>
    <xmx:Xy7haakd2PQ8bWlSM16xA_DovrAb53lDFk5yoyPUhxH9TUynEvutVg>
    <xmx:Xy7haX-GOTWo0sWclOoLyR2edPwyLmgDbTIs7fRQcoZ54hf-TEfGFNFe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 14:45:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] MIDX: revert the default version to v1
In-Reply-To: <xmqqldem22uw.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	16 Apr 2026 11:10:15 -0700")
References: <xmqqqzohd0sh.fsf@gitster.g>
	<8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
	<xmqq5x5s540j.fsf@gitster.g>
	<20260416051732.GA48541@coredump.intra.peff.net>
	<20260416053435.GA646718@coredump.intra.peff.net>
	<xmqqldem22uw.fsf@gitster.g>
Date: Thu, 16 Apr 2026 11:45:49 -0700
Message-ID: <xmqq8qam217m.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Jeff King <peff@peff.net>

Dscho reports that fetching into a repository with Git 2.54-rc2 made
it unusable with Git 2.53, as the recent code by default writes
version 2 multi-pack-index files.  Version 2 is the base of more
advanced features to come, but using it where these features are not
used is a strict regression.

As deployed versions of Git and its reimplementations may not be
ready for the format bump, let's revert the default version of MIDX
file we write back to V1, and adjust tests that exercise V2-specific
features to explicitly request V2.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Let me reword the proposed log message to talk about background a
   bit more why we want to do this.

 midx-write.c                        | 2 +-
 t/t5319-multi-pack-index.sh         | 5 ++++-
 t/t5335-compact-multi-pack-index.sh | 7 +++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 0ff2e45aa7..607de889f9 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1259,7 +1259,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	struct tempfile *incr;
 	struct write_midx_context ctx = {
 		.preferred_pack_idx = NO_PREFERRED_PACK,
-		.version = MIDX_VERSION_V2,
+		.version = MIDX_VERSION_V1,
 	 };
 	struct multi_pack_index *midx_to_free = NULL;
 	int bitmapped_packs_concat_len = 0;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 58e0b685b1..ed1f993a74 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -19,9 +19,12 @@ midx_read_expect () {
 	NUM_CHUNKS=$3
 	OBJECT_DIR=$4
 	EXTRA_CHUNKS="$5"
+	# This reflects the default midx version we write; it should switch
+	# to 2 if we flip the default.
+	VERSION=1
 	{
 		cat <<-EOF &&
-		header: 4d494458 2 $HASH_LEN $NUM_CHUNKS $NUM_PACKS
+		header: 4d494458 $VERSION $HASH_LEN $NUM_CHUNKS $NUM_PACKS
 		chunks: pack-names oid-fanout oid-lookup object-offsets$EXTRA_CHUNKS
 		num_objects: $NUM_OBJECTS
 		packs:
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
index 40f3844282..4ad007169a 100755
--- a/t/t5335-compact-multi-pack-index.sh
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -57,6 +57,13 @@ test_midx_layer_object_uniqueness () {
 	done <$midx_chain
 }
 
+# MIDX compaction requires the v2 format, so make it the default
+# for the rest of this script. We check below that trying
+# compaction with v1 fails using "git -c", which will override this.
+test_expect_success 'set midx version config' '
+	git config --global midx.version 2
+'
+
 test_expect_success 'MIDX compaction with lex-ordered pack names' '
 	git init midx-compact-lex-order &&
 	(
-- 
2.54.0-rc2-109-g879cd67f0d

