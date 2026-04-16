Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417EA330B09
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363019; cv=none; b=UZ2ZfdKcM5Tnts2GaWULR8uayC4QKkrkA+wvYYACYvwiQ1Q2Wmhq0MB0FUjbxI4Kip8QeNzvXJymfecjlrPeTdc82D9Bhpki7owdLUG1MnycGR66il9VwWoZQ91o1SRP/RT8GZQOu28YlPJ8JYvXV0OMIYleu/+s+yfa5mvwSGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363019; c=relaxed/simple;
	bh=X1la8q3c5IIBvHkfvF7krJFue6KR7ZA5A4rU9iyrd2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TRpDUWgyUO72mZ3gB3p1iJthvH0Wu5mE4N8XH5cKU16mQ3siZhqqQSJndC4iNUyg8qUDJJ8h8ndHq9BLa3jRGZbHSZhWTvYA9KTZf1R1ZcaUn1n0ib964YpTBmp6rpjRrSHVEdbWFFRH26ceeqCC1STDDPJJ3UdbTUzJ7s5S/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XgFVv7qy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MEUCjN6E; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XgFVv7qy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MEUCjN6E"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B15714000C2;
	Thu, 16 Apr 2026 14:10:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 16 Apr 2026 14:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776363017; x=1776449417; bh=zr/2iIu+St
	NO2mzhwGWWKCl7ulIJ6wbOMYTepkvCiz4=; b=XgFVv7qycCfoeOk9h4y6+WqQ+V
	OSvgFYVmnmZ2mrjkDqTTwRJIfO3hzRzHvyprjQ0ir9WcLiHSqV46IcrjaCqe9wq+
	bBKtQEBmGn3JO3dWu1MR/HYK+wgEt0G9WqsUaWpr+miWu1gYo2lTfdJLEhrJlnsS
	92gkJ16JmR4aEmTo3Q2DI+h0c8ej6fHq9iunxS6tDePiEMZK3wF7F4lrmyGVEVv4
	8/ZjWrn1JAcF2vR739NLHy1eX57CFF1mnL86pRSgCBa7WWhVD+8f+hr8IRSGmdBC
	rKn8bSXclVbs06JQM/UheC5bkwAHjdbELByIn3SDQ35FJhVSIeS+I2oaXPoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776363017; x=1776449417; bh=zr/2iIu+StNO2mzhwGWWKCl7ulIJ6wbOMYT
	epkvCiz4=; b=MEUCjN6EbDcxk8UU6PyzSi8EVbZRIhcWjVDQo1mKAbXHLl6zx1b
	+b1UxwSkT/WFIiw3kkV5A2nFO3llSiv4oEzI957z5qZXsG5Dj7lnjgoBnvadC6nJ
	taSqFQ8qPOPX0s/a9t753JHzGcIx9EsTZ/LQtqibcDS8jGIenZEBEpXX5g7IO/YK
	Xe6ruWWv/FDThSktrm892u+H7DconEU334MVkbygn2XrPdq7r5lGJ8zkEDDQ/LPI
	TVaXjtOWq6JblkJsUn8NobCqdnBQTliu2OxcTlggLG6IMxEf4NV0v7eEFS0URIKi
	uIs9JTCK6sHseN2Y1kB5X+asElhHr91CZgQ==
X-ME-Sender: <xms:CSbhaTBSESJK2ORlVPuZIV0yoqOdxtbk1K-BisB-rP9U9gauiHe8zQ>
    <xme:CSbhaQYFpJC88G-cmX9QC_FDCrxfv_XA519-3jCqQkRNpjwsTZ3-Uw5bouY4YUcEG
    cbsrkpeRTGT8-Hj4E0WTN1WgQUtzpr9WBZQ4XUN79BLbGriNkpN>
X-ME-Received: <xmr:CSbhaW4a9Gr6WpC8LvLQ6_q0AGQvAlsLPb8iTqXgcbZhJ2yufaEbE8eHRdRx6_Dza0RIsoipMF67M39qLf_a0OCHjB1nQHTJEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeeilecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:CSbhaRY_tyCs1L1B5MArZ2PlrXY8HhjDBWLhkxihCD2wSYkl8qV99A>
    <xmx:CSbhaVhdEQJHPRLu84ZRs-wsUGs4znoozEShVY7E-7Mfq2VhtYsM-A>
    <xmx:CSbhaS8oXty29JqgvIPkgs8G2C41h8qyi90HV7DJuML9QGG6dBYCLQ>
    <xmx:CSbhaQqevo8N-BayIfJc4yGxUr8bB-L9nxPHPOca7BqVCJecBK3n5A>
    <xmx:CSbhac_fxHVYF8PinO4VFi-Ltsy9bY7R2jmY1Dd5sQ5pEXo_xxT7J_X1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 14:10:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
In-Reply-To: <20260416053435.GA646718@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 16 Apr 2026 01:34:35 -0400")
References: <xmqqqzohd0sh.fsf@gitster.g>
	<8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
	<xmqq5x5s540j.fsf@gitster.g>
	<20260416051732.GA48541@coredump.intra.peff.net>
	<20260416053435.GA646718@coredump.intra.peff.net>
Date: Thu, 16 Apr 2026 11:10:15 -0700
Message-ID: <xmqqldem22uw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Apr 16, 2026 at 01:17:33AM -0400, Jeff King wrote:
>
>> I think removing the .midx file (and optionally regenerating with the
>> old version) would be the appropriate workaround, but I wonder how hard
>> it would be to go back to generating v1 midx files by default. I know v2
>> is a building block for more advanced features, but for those who are
>> not using those features yet it is a strict regression.
>
> I think doing so is just this one-liner:

Let's do this before Git 2.54 final, then.

----- >8 -----
From: Jeff King <peff@peff.net>
Date: Thu, 16 Apr 2026 10:56:20 -0700
Subject: [PATCH] MIDX: keep the default version to MIDX v1

As deployed versions of Git and its reimplementations may not be
ready for the format bump, let's revert the default version of MIDX
file we write back to V1, and adjust the tests so that the ones that
do test features that require V2 to explicitly ask for it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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

