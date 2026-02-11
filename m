Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75F21257F
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813909; cv=none; b=QFM5DqEQSvNIOnGzxaFR1FJdgIp28ybEQ4n6kp1F1+9D0ntYzmkPiyWxwubTcLncy5K8qOejZnyrFU/mEXDNRdOC8IY7ntaOcGtn49bgv6ZgqUAO7HpGB0xBUCeujvOiV/giTS8OAkuR0kZshj8vIzBpIOx/bkBA2HU/KvvTsgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813909; c=relaxed/simple;
	bh=YWX/ckdu/ZeVxMsOesjclCuXi0XPZ6Y1lpFpKsIpA3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jpfTtgZu29Sk4LoikGNrAI9rkwwmxG5ReMa6tNi3ayrCPi15w4e8t2C6giqI5/hR5Sn74flRZftjGd350Yi0zNcyML9KzwXh8ccT3zsbNYB4DAqUT6mGFG0//ZNg9qHAXVZ5VFWLwDrEL39G283L2xZ37O4wYMvtH0xigp2MVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bF3Meh2U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n87HIUmA; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bF3Meh2U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n87HIUmA"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CDD7F7A01AE;
	Wed, 11 Feb 2026 07:45:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 11 Feb 2026 07:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1770813906; x=1770900306; bh=hWn7a9p3wW
	5BWEJDqbuKJqtRHT4v489BGelRyfNpuMg=; b=bF3Meh2UkHQweQc8jr343nD0Jx
	cwMfBI2uvd7iMYcszFmpi56iPFWhfT0GsDmP50NAQwaONLRbc4WEGdcOr1yNlL/2
	4FpIVJtDa0DnolwPkVOITUVpIFWuWAINSlS8vJggUN72dsqLBaEB44QK6I0Hk6SQ
	Ko7jg+XoqZWOl4gUobUZZ3ALyehRLFdtvYeNEi+DsFk0HHUL5RQQNNZfMJR7hIOn
	F0nCEuZ6W6Err5Uy//RolZauGNIFXzgNNIBySJMDjwMv/t4HLEmV0h3/5J6257V1
	989wH7PIk9llzPV/UKA5mAT1l4qU72HlAzOJYOu5D0R2FXKqeyObp4MoGL4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1770813906; x=1770900306; bh=hWn7a9p3wW5BWEJDqbuKJqtRHT4v
	489BGelRyfNpuMg=; b=n87HIUmAp/2t3ymLSadPMDFzXTV0z7IN+x2Et9B8IdF1
	EAv8/WfQbLNi9tNz29mYY49DEUGsBwOiC2CtNQGfx1pLE2ZGfWvx/mzRKHWTP9C9
	Hy9mU/iys0KVkBHJE50wOgoKdfy+J9NwzHMJ0qEJKVui8SPV+D0zGJdWQlCJTCEz
	Id+DJLmMASqZKcrjWdnMTOqz+CLr/abH24krCRcnhFewXIvjnIG0p0bJIDO605ir
	xdyS+Ils5KzLjFOAWKwJyqi6N3YvXEdHJFJfGRwqhnuFu9Jq7URA/YDMtlsAGI0W
	L9Z8OgJqhxi8dz4jU8v9Wgg0FY897j2RgG85koOtZA==
X-ME-Sender: <xms:0nmMacSOIZ5Uuq8oBjl5rzzC4oHapvqIeCj4fPBffRlVDeCa9SfhjQ>
    <xme:0nmMafyA0ec3uVmsmMYJ-fSuhlBE_3607P3M_x7wyO6Y4u60eqkOO-9w0Vy3fGwH5
    T45Oy2W_rpKNMbzcs4K9oBvQX41G_mVKFArUm_52v9sfrqt1BRe7Q>
X-ME-Received: <xmr:0nmMaXdJr5IreUYWgueoFsAWGAmsDhooE43lZYpEeA5x0MVzjqPZ3IWw2bxvZxs2wWbaGd_eTohd14nZMyBwCihMp9ATTYL0niLQ733JT5MM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eigfeitdffffdvvdeuheehjeehheeludduhfehkeekgeeggfeuffehveegteejfeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhifrghnkhhose
    hgihhtlhgrsgdrtghomh
X-ME-Proxy: <xmx:0nmMabJ6MQSRsVpSnlJRP42STbiIPsro9KSjwzgs7_dRKIKO-tR6ag>
    <xmx:0nmMaYGnK5-bHgddZrIZJSR46ikBKSlifZmfdU8dsQhyBsvmNcwpHQ>
    <xmx:0nmMaVojmOQAqOT4zfzIJxdMoQfIok5guGVTkHpYZlj2_-0l9ueIzA>
    <xmx:0nmMaRScFoN8MPEyxqf4E6NbCKZXryOkoZ3E7eOu3bV1jbUDBCI6OA>
    <xmx:0nmMaQDWhOySvYG4ENKFPk54aQ5VuaSSSvsp4Lmbj20Fty67cuitflJ2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 07:45:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a38b0a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 12:45:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Feb 2026 13:44:59 +0100
Subject: [PATCH] builtin/pack-objects: don't fetch objects when merging
 packs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260211-pks-pack-objects-stdin-skip-backfill-fetch-v1-1-870cad56d8ae@pks.im>
X-B4-Tracking: v=1; b=H4sIAMp5jGkC/x2NQQqDMBAAvyJ7diEbULBfKR5M3NRtJIZsEEH8e
 0OPM4eZG5SLsMKru6HwKSpHakB9B35b0odR1sZgjR2NJYM5KubFRzzcl31V1LpKQo2S0TUfZN8
 xcPUbhnHiYTATOSJowVw4yPWfvefn+QG69+BtfAAAAA==
X-Change-ID: 20260210-pks-pack-objects-stdin-skip-backfill-fetch-f69e55091b11
To: git@vger.kernel.org
Cc: Lukas Wanko <lwanko@gitlab.com>
X-Mailer: b4 0.14.3

The "--stdin-packs" option can be used to merge objects from multiple
packfiles given via stdin into a new packfile. One big upside of this
option is that we don't have to perform a complete rev walk to enumerate
objects. Instead, we can simply enumerate all objects that are part of
the specified packfiles, which can be significantly faster in very large
repositories.

There is one downside though: when we don't perform a rev walk we also
don't have a good way to learn about the respective object's names. As a
consequence, we cannot use the name hashes as a heuristic to get better
delta selection.

We try to offset this downside though by performing a localized rev
walk: we queue all objects that we're about to repack as interesting,
and all objects from excluded packfiles as uninteresting. We then
perform a best-effort rev walk that allows us to fill in object names.

There is one gotcha here though: when "--exclude-promisor-objects" has
not been given we will perform backfill fetches for any promised objects
that are missing. This used to not be an issue though as this option was
mutually exclusive with "--stdin-packs". But that has changed recently,
and starting with dcc9c7ef47 (builtin/repack: handle promisor packs with
geometric repacking, 2026-01-05) we will now repack promisor packs
during geometric compaction. The consequence is that a geometric repack
may now perform a bunch of backfill fetches.

We of course cannot passe "--exclude-promisor-objects" to fix this
issue -- after all, the whole intent is to repack objects part of a
promisor pack. But arguably we don't have to: the rev walk is intended
as best effort, and we already configure it to ignore missing links to
other objects. So we can adapt the walk to unconditionally disable
fetching any missing objects.

Do so and add a test that verifies we don't backfill any objects.

Reported-by: Lukas Wanko <lwanko@gitlab.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

we've recently encountered this issue in a partial clone of one of our
own repositoires. Thanks!

Patrick
---
 builtin/pack-objects.c        | 10 ++++++++++
 t/t5331-pack-objects-stdin.sh | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9807dd0eff..4053f9659f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3925,8 +3925,16 @@ static void add_unreachable_loose_objects(struct rev_info *revs);
 
 static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 {
+	int prev_fetch_if_missing = fetch_if_missing;
 	struct rev_info revs;
 
+	/*
+	 * The revision walk may hit objects that are promised, only. As the
+	 * walk is best-effort though we don't want to perform backfill fetches
+	 * for them.
+	 */
+	fetch_if_missing = 0;
+
 	repo_init_revisions(the_repository, &revs, NULL);
 	/*
 	 * Use a revision walk to fill in the namehash of objects in the include
@@ -3962,6 +3970,8 @@ static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 			   stdin_packs_found_nr);
 	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_hints",
 			   stdin_packs_hints_nr);
+
+	fetch_if_missing = prev_fetch_if_missing;
 }
 
 static void add_cruft_object_entry(const struct object_id *oid, enum object_type type,
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index cd949025b9..c3bbc76b0d 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -358,6 +358,24 @@ test_expect_success '--stdin-packs with promisors' '
 	)
 '
 
+test_expect_success '--stdin-packs does not perform backfill fetch' '
+	test_when_finished "rm -rf remote client" &&
+
+	git init remote &&
+	test_commit_bulk -C remote 10 &&
+	git -C remote config set --local uploadpack.allowfilter 1 &&
+	git -C remote config set --local uploadpack.allowanysha1inwant 1 &&
+
+	git clone --filter=tree:0 "file://$(pwd)/remote" client &&
+	(
+		cd client &&
+		ls .git/objects/pack/*.promisor | sed "s|.*/||; s/\.promisor$/.pack/" >packs &&
+		test_line_count -gt 1 packs &&
+		GIT_TRACE2_EVENT="$(pwd)/event.log" git pack-objects --stdin-packs pack <packs &&
+		test_grep ! "\"event\":\"child_start\"" event.log
+	)
+'
+
 stdin_packs__follow_with_only () {
 	rm -fr stdin_packs__follow_with_only &&
 	git init stdin_packs__follow_with_only &&

---
base-commit: 864f55e1906897b630333675a52874c0fec2a45c
change-id: 20260210-pks-pack-objects-stdin-skip-backfill-fetch-f69e55091b11

