Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC451EF0A9
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478697; cv=none; b=RB+zqhxGoInQbJySgxAyBEPhqP8UqvrJqPi/xJ3wIMiQaoRJuVvlST5uylhi8YEzq65k8kYZFPQ7XPLiCV9xj3cB2l1GFg4tYerxEwTUvJpSrto06yB89/vZ57PH5rZk/jjvZTRfhIrlTaUtT6KAzbhY4Efn53cqWYLX97SrmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478697; c=relaxed/simple;
	bh=MeMGqfOY4O8IVPcymTxBy0IYX607kdJjKNEvxDqo7kY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l9Q062b49jsK+tb3QuwM+bf/usq/7uiYe02aLFaPs3NQALvJE+cGGT5f49bZuk0fxZ1lXh9oBPUq+r0e12JhICq9VVk9+vOxTxREU6v2cbpby1rdQDtEo6bEccugug0ulHFN9k4MZBnBbzDH9mC520UHuJVBA3gZae27QKaQRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=u+Hj7SNy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJkpW3o7; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u+Hj7SNy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJkpW3o7"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D8E6B2540120;
	Fri,  6 Dec 2024 04:51:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 06 Dec 2024 04:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1733478692; x=1733565092; bh=r/+3sNGiGe
	R2f1C625iJtDVDghGA9whkR+xF2gtvLGA=; b=u+Hj7SNy9n2rKvtrw/aCsUM86g
	AQGX09L+KMVdSsGYa7Igqp9+O5uEKiHGEYocotgHaz79KvPXmV5BH91Pn1IXKwET
	63j28kUvxekt8WmWxKeHHM1nOoKiyzZJXwv0yIxdLWPW832rZtjDJYCoiW3fr3mQ
	/k+YnmrdQWZdnI1XLML8w7nHoe7pkucbwYREqST+ANqvD3AeKDLJi9pYWE/yBA4M
	PjXw1eqez3qHuELj2bpHD4PBlwinRA0XuKGOkZWWq991ixNpfD2wNalhwzrv030T
	c1oJeGq/w26lChGsZ4Y6zP1YvJ5Sa/jUhs+0mwz/TeLP84Y1+AXWkpWsNeiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1733478692; x=1733565092; bh=r/+3sNGiGeR2f1C625iJtDVDghGA
	9whkR+xF2gtvLGA=; b=ZJkpW3o7hWNRB3uiP+U0bBnhBzksAV9wFFxInjnbQQ96
	xYZPdYe5pIet0X9VpdzQ6tTd7BywWtb3V+JGmJzJivdSPsABSpqrX3cEvJaxFWY0
	+0sYGpF1XtAd0sfvbRhfievEtMQijCwNsyY8b5a6LD1jAmiqTWcKwquBN5E1OD0i
	siVJikjEQ4Es4vpVFiAN3HxkWUKNzqbpB6hCfB7wI4Kp65JCxqdV1SeP/tnm4POB
	ScpEMeSd/4FW8qjb0MpKBzT/U0kyKVQjquIPANXyuA4WpciOKsCjgXz2/nCOaJI3
	lCpt++PlnZm/mbSOz8qlHiG0awHyDXV1YoLUrE3vxQ==
X-ME-Sender: <xms:JMlSZ_Z9GG_d-bfKbgE9mumwHgKxTjRIhfrX3FdlKwXH9lURdD79Nw>
    <xme:JMlSZ-bBVgls5LhgPYFipizcyT-y7gxCqIjkARKfZuX7cgRelNjrCbkcqNx6kcFDg
    ov1p3KydoDq5ko7qA>
X-ME-Received: <xmr:JMlSZx-LjReymKE__Knar8mlq6SObdP3OqyBv8hHbFT9hXMQwg1E_-i0ToI4l7NQxn_wTX6TRwMokYvCebTsvJ8wH0Gl1nMYTlwErIXgGNaIhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfh
    rhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqne
    cuggftrfgrthhtvghrnhepiefgiedtffffvddvueehheejheehleduudfhheekkeeggefg
    ueffheevgeetjeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggrrhhnihesvhgrlhho
    hhgrihdrtghomh
X-ME-Proxy: <xmx:JMlSZ1qCuZmDUx9Ug99VqqEgmFpGNgt7Bk3KlVWP-4VCXda9dDPmUQ>
    <xmx:JMlSZ6ogVZJBqe1gz5pzUnIlVRArGc5sGOHR28t0815i1r3UM8lU8A>
    <xmx:JMlSZ7RANtM2pf_HCkFUCpkLHSbgxCEHPKbhvqFiGK9O2KzrP_zoXA>
    <xmx:JMlSZyrWyNwQzch3My-6gDJDd_Fkjscr9S31j_4n36VoyBnwI0nmBA>
    <xmx:JMlSZ9WI2vfjI_C0ETA4W_bJ8faasizirAVTy0HGA7Nw8LBt8PLCmnwC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 04:51:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f1d12d95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 09:50:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 10:51:05 +0100
Subject: [PATCH] object-name: fix reversed ordering with magic pathspecs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
X-B4-Tracking: v=1; b=H4sIAAjJUmcC/x2NQQqAMAwEvyI5G2hLLehXxEPRqEHR0ogI4t+N3
 nZgmL1BKDMJNMUNmU4W3jcFWxbQz3GbCHlQBmect84ETIugiphiFsKRr49I94Ary4FmrH10JgY
 bKtBKyqTS/9B2z/MCMAVCd3EAAAA=
X-Change-ID: 20241206-pks-rev-parse-fix-reversed-list-0f94a20a6165
To: git@vger.kernel.org
Cc: Aarni Koskela <aarni@valohai.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

It was reported that magic pathspecs started to return results in
reverse recency order starting with Git v2.47.0. This behaviour bisects
to 57fb139b5e (object-name: fix leaking commit list items, 2024-08-01),
which has refactored `get_oid_oneline()` to plug a couple of memory
leaks.

As part of that refactoring we have started to create a copy of the
passed-in list of commits and work on that list instead. The intent of
this was to stop modifying the caller-provided commit list such that the
caller can properly free all commit list items, including those that we
might potentially drop.

We already knew to create such a copy beforehand with the `backup` list,
which was used to clear the `ONELINE_SEEN` commit mark after we were
done. So the refactoring simply renamed that list to `copy` and started
to operate on that list instead. There is a gotcha though: the backup
list, and thus now also the copied list, is always being prepended to,
so the resulting list is in reverse order! The end result is that we
pop commits from the wrong end of the commit list, returning commits in
reverse recency order.

Fix the bug by appending to the list instead.

Reported-by: Aarni Koskela <aarni@valohai.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
This patch applies on top of v2.47.0, which is the first version which
had this regression.
---
 object-name.c                 |  4 ++--
 t/t4208-log-magic-pathspec.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/object-name.c b/object-name.c
index c892fbe80aa7173dfcc1995de5a75bc322c6adb7..34433d2a01d6a23ce6b4ca19b85c53b7b82fd0e5 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1401,7 +1401,7 @@ static int get_oid_oneline(struct repository *r,
 			   const char *prefix, struct object_id *oid,
 			   const struct commit_list *list)
 {
-	struct commit_list *copy = NULL;
+	struct commit_list *copy = NULL, **copy_tail = &copy;
 	const struct commit_list *l;
 	int found = 0;
 	int negative = 0;
@@ -1423,7 +1423,7 @@ static int get_oid_oneline(struct repository *r,
 
 	for (l = list; l; l = l->next) {
 		l->item->object.flags |= ONELINE_SEEN;
-		commit_list_insert(l->item, &copy);
+		copy_tail = &commit_list_insert(l->item, copy_tail)->next;
 	}
 	while (copy) {
 		const char *p, *buf;
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index 2a46eb6bedbe283a08fd77917b7fb17da155b027..2d80b9044bcf9ec8e2f11b6afd2b0fe8e2fcabfd 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -58,6 +58,19 @@ test_expect_success '"git log :/any/path/" should not segfault' '
 	test_must_fail git log :/any/path/
 '
 
+test_expect_success ':/ favors more recent matching commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit common-old &&
+		test_commit --no-tag common-new &&
+		git rev-parse HEAD >expect &&
+		git rev-parse :/common >actual &&
+		test_cmp expect actual
+	)
+'
+
 # This differs from the ":/a" check above in that :/in looks like a pathspec,
 # but doesn't match an actual file.
 test_expect_success '"git log :/in" should not be ambiguous' '

---
base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
change-id: 20241206-pks-rev-parse-fix-reversed-list-0f94a20a6165

