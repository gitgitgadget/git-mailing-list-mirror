Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12CA284B25
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939203; cv=none; b=u+hXO5FUUawBe7nKcXNGS2w/8gBPz5CMsbRBUF92DF+5NbtyOPPsMIcEFrfbOdV3JhZXGFjdeYfpoXatTxKX6QBz6vlSCqp7F6bw5g55t4/QpmUNnreJSwiuqpHzIJIxUoeRabf06VdcXSSufswwnU73fEK/14E+G7i3LJeAe38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939203; c=relaxed/simple;
	bh=AD2TV3epPa7HGCX/SmPlS3TrUjpeKq7qvJY8y0Nzu54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tIKx7HCR8hdnyRfPS1Wo/o5wggp7oQ0vqJ2WIGYHDs9nKMuAJuLfTQ+/dmjPcbMi82eNJWQzuYMdeIe4HTOt034jzG6QHQF8cmJ51menS/EmYYUHqPYZP33fJxFgh7PSk01WlvjnjO/6aRXL1WyPBmFXW/PVG/VadMfMPwAnCVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IfG4UK9a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KupxnJRm; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IfG4UK9a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KupxnJRm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CD221400085;
	Mon, 11 Aug 2025 15:06:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 11 Aug 2025 15:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754939201; x=1755025601; bh=7jMrXEav4p
	DdCPQoH2WUW9lmfyaRiLVB0s0qmj6HIxM=; b=IfG4UK9aO9M2tyD1rdveMNU6+c
	ck7kKYtxJOoIGNuKpnim4osjf2j4XNxVNgzGku8O7bmnIna6R73gzSCsgX4ntRAt
	BpYgok9B6scBXvie9Y8hmMOQfT5zx239YPLjwHa/YMhzl4PMh56UokayyPrY9C2V
	Hr8HD9/0ijeMFw98bV1hOnYDlI1ZKUKWiTylKLq3bIkdFswF1QgP+IaC9h25nVol
	NqD0Qt08fUfczIp6qeJXHqDq6mxtG8atT8YvGPNjtlP9Z8Q3CxI0Y9+6DIcYgmUc
	AT1x2YvtJgnjmoY5N44vt8cEBlXDeumnE6EdnPPvLltN86mGVo9AVHv3aWRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754939201; x=1755025601; bh=7jMrXEav4pDdCPQoH2WUW9lmfyaRiLVB0s0
	qmj6HIxM=; b=KupxnJRmocQlTJQQVIZr1Bw4QXwcWRZD76rgtniCFUQ41X7kGCn
	nbAqDZRQc563aKgOij9H+hIy64o0FQyVuto9NfsWoENn/0F55W5WBV901CKdSWWI
	DJSc0XE6WV9BanpQ8MYliS0CFmcCvSt6nd8LUmWFP9u/1Yb62j4ekuDyT0cYjql4
	f/kAhJIa1O/TLPMq4skCRcPAmQp/o2wGwWwQ4cb0U+swOV/grb0ht+uWjIU6GWno
	YszouEO/kv4uL3fdv3Xrr7xUyOZrAggHbCiDK0/NlD+q1GAnIzkkuxRPFhFs6fcp
	yjLrRm2XIKPlSvXnMAvkPt8NBMZbsysMG1A==
X-ME-Sender: <xms:QD-aaICYJ-NYz-yuIZQkGNDxhn0LUZHlBVbcqXivXN-UYmpJvEbKMQ>
    <xme:QD-aaFH8yE6t7ulzs0NdM0Z3ZRAesr78N9zQWefYnWFaw40lHhH3nbUtoYbXG8jau
    _2tY3W9hkXGEg4WPw>
X-ME-Received: <xmr:QD-aaIJCENAhzqwfjuvi2zmHGzYJRKptB9H6wfbN203VwoIIVSUmQ4yuSCKTdlEZoaTK6m90DUVGxfGaTDOnadDLkUHo4-j1ogf0GTs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeefvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehnohgsohiiohesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgv
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:QD-aaBlTxuudo8UH83i7bNnhoSjAkmHhnXiFMKZLBQ5w21jNPlnO6w>
    <xmx:QD-aaIQlvCkB3UgOS5aL5tp3WLPNkKV-MPGP5W5_4QkBGwTAVc_yHw>
    <xmx:QD-aaLKka2RoD4jNP9lOuTDrDCKHY6F8tduwuIomkj6ESEfh__1quw>
    <xmx:QD-aaGDyEcMT_7fpezxiqaFcT6Xu8pTJPnBtrwGRENoIyiEiELQyVQ>
    <xmx:QT-aaMzmmEino7phShjFSpF9DUGvAtXLd45wioc-B2vdB--aOIEk7mDj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 15:06:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jon Forrest <nobozo@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2] abbrev: allow extending beyond 20 chars to disambiguate
In-Reply-To: <xmqqfrdx517b.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	11 Aug 2025 08:26:32 -0700")
References: <xmqqfrdx517b.fsf@gitster.g>
Date: Mon, 11 Aug 2025 12:06:39 -0700
Message-ID: <xmqqzfc51xvk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When you have two or more objects with object names that share more
than half the length of the hash algorithm in use (e.g. 10 bytes for
SHA-1 that produces 20-byte/160-bit hash), find_unique_abbrev()
fails to show disambiguation.

To see how many leading letters of a given full object name is
sufficiently unambiguous, the algorithm starts from a initial
length, guessed based on the estimated number of objects in the
repository, and see if another object that shares the prefix, and
keeps extending the abbreviation.  The loop stops at GIT_MAX_RAWSZ,
which is counted as the number of bytes, since 5b20ace6 (sha1_name:
unroll len loop in find_unique_abbrev_r(), 2017-10-08); before that
change, it extended up to GIT_SHA1_HEXSZ, which was the correct
limit because the loop is adding one output letter per iteration
and back then SHA256 was not in the picture.

Pass the max length of the hash being in use in the current
repository down the code path, and use it to compute the code to
update the abbreviation length required to make it unique.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object-name.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/object-name.c b/object-name.c
index 11aa0e6afc..8f9af57c0a 100644
--- a/object-name.c
+++ b/object-name.c
@@ -680,6 +680,7 @@ static unsigned msb(unsigned long val)
 struct min_abbrev_data {
 	unsigned int init_len;
 	unsigned int cur_len;
+	unsigned int max_len;
 	char *hex;
 	struct repository *repo;
 	const struct object_id *oid;
@@ -699,12 +700,12 @@ static inline char get_hex_char_from_oid(const struct object_id *oid,
 static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 {
 	struct min_abbrev_data *mad = cb_data;
-
 	unsigned int i = mad->init_len;
+
 	while (mad->hex[i] && mad->hex[i] == get_hex_char_from_oid(oid, i))
 		i++;
 
-	if (i < GIT_MAX_RAWSZ && i >= mad->cur_len)
+	if (mad->cur_len <= i && i < mad->max_len)
 		mad->cur_len = i + 1;
 
 	return 0;
@@ -864,6 +865,7 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 	mad.repo = r;
 	mad.init_len = len;
 	mad.cur_len = len;
+	mad.max_len = hexsz;
 	mad.hex = hex;
 	mad.oid = oid;
 

Range-diff:
1:  2e1d2b4ef6 ! 1:  5c67e57f14 abbrev: allow extending beyond 20 chars to disambiguate
    @@ Commit message
         keeps extending the abbreviation.  The loop stops at GIT_MAX_RAWSZ,
         which is counted as the number of bytes, since 5b20ace6 (sha1_name:
         unroll len loop in find_unique_abbrev_r(), 2017-10-08); before that
    -    change, it extended up to GIT_MAX_HEXSZ, which is the correct limit
    -    because the loop is adding one output letter per iteration.
    +    change, it extended up to GIT_SHA1_HEXSZ, which was the correct
    +    limit because the loop is adding one output letter per iteration and
    +    back then SHA256 was not in the picture.
    +
    +    Pass the max length of the hash being in use in the current
    +    repository down the code path, and use it to compute the code to
    +    update the abbreviation length required to make it unique.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## object-name.c ##
    -@@ object-name.c: static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
    +@@ object-name.c: static unsigned msb(unsigned long val)
    + struct min_abbrev_data {
    + 	unsigned int init_len;
    + 	unsigned int cur_len;
    ++	unsigned int max_len;
    + 	char *hex;
    + 	struct repository *repo;
    + 	const struct object_id *oid;
    +@@ object-name.c: static inline char get_hex_char_from_oid(const struct object_id *oid,
    + static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
    + {
    + 	struct min_abbrev_data *mad = cb_data;
    +-
    + 	unsigned int i = mad->init_len;
    ++
      	while (mad->hex[i] && mad->hex[i] == get_hex_char_from_oid(oid, i))
      		i++;
      
     -	if (i < GIT_MAX_RAWSZ && i >= mad->cur_len)
    -+	if (i < GIT_MAX_HEXSZ && i >= mad->cur_len)
    ++	if (mad->cur_len <= i && i < mad->max_len)
      		mad->cur_len = i + 1;
      
      	return 0;
    +@@ object-name.c: int repo_find_unique_abbrev_r(struct repository *r, char *hex,
    + 	mad.repo = r;
    + 	mad.init_len = len;
    + 	mad.cur_len = len;
    ++	mad.max_len = hexsz;
    + 	mad.hex = hex;
    + 	mad.oid = oid;
    + 
-- 
2.51.0-rc1-144-g869f44a1ca

