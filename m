Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7561FCE
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 04:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728275903; cv=none; b=MdxqDqvamaJyGZJ3ujowqFpKTF9VTwHSkEfCVS6VymZ8JZuvso35lMPFCT3wQBhezhUJMYfJrehXwwBjwq4i9k5XN3svtHJfIUM6VzI7FBz7oRfFGSrPdUMILX6XRDgcEChJjavfTB9PnR0UVopwOs4obVVdumTbtJsH6YXw3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728275903; c=relaxed/simple;
	bh=wguvN705VYnlx7RzeXCwBUYioii9p9yzrzMKH3dSwtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4K4cQxJaSCX4qk1so4nlv/4W3LfPLcCGwMgTVErQuc+zI0BQh08+uzvEBDxcmF9PbS4/rJ5yevPgAwGrTJHYSWl8HMR1Wkj5t2+btYamNQ+MsOgyWmU4mkEihnv75XSS/Lf6nqYFsHvXUEQi37qDyFjApZT2yuAhQ+3V4BrlxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mQXtxrgw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W6/Kuv7E; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mQXtxrgw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W6/Kuv7E"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E040813803A7;
	Mon,  7 Oct 2024 00:38:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 07 Oct 2024 00:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728275900; x=1728362300; bh=kCQ5+U1D53
	+3nR1JiUYulADpZUAepWGvCDss2lNthL8=; b=mQXtxrgwbgU5Yu1IfydCjs/22X
	D80HrF3N5gUk3yNq8tmP8grczJCeXVhUYmYciHrECBUK0j9uUcHyUxto/J6gLvW1
	4ZvJLHdCvwdg1hxeYi8aaONX5mUmYqUKF3nbWwGNmaTqWRRzKcKFFyIvuDRCrBVd
	guc7U5N9uHUzZr75IWUmu/48vnZwy+P3C3Mf9Bp2u5fu40vzcqFvMl9Mano+nCYl
	AAxNv3cuUO0BkF7MD6GBCRmjedeJGCUakRnL+w07EQmwwcgdrYpuslqWLEat+8i4
	ouBFK3OdhjCY9Kwu3wLDxRDK1s1zUyS+oqyggx5/1lytcDzCjzT7pntEyWUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728275900; x=1728362300; bh=kCQ5+U1D53+3nR1JiUYulADpZUAe
	pWGvCDss2lNthL8=; b=W6/Kuv7EWwQM3xbbRWnSRtwIY2UbTEcEVN4goT9NYMmN
	bkcs8Rpfp2zc2h1Ip0brGp+JYO5UyeZ9s3Mej3n8HqQGCDBHSAtYRRnIP0SOwuYY
	02DmwUOeLz/JRqB0mN3Xc5X/IHZgDYod4cmwottGPOX6R8A6cs+kIt9/wtnu+RNw
	0mpaJrXU3bbcMt6CNsF57rxlakAejSv5i0PSe3K8bOdRSL13uY1FENJ+XvqpVJ5F
	cURi3HaDeI875TKG/04pi3AD5k9pXLMV7jKYWS0PekIcreEeyNPkmftLJPplDdKi
	jS18qKVyYZ9nhamW/6q6d9Q9R5MfD7jFWtoAT+/FwA==
X-ME-Sender: <xms:vGUDZ5u1ewildz1YQ1TsfV3JVjK6Fv0rgqb3t4u44SEgmrk8s9m_Fg>
    <xme:vGUDZyexr962mMzXlZKn7T7yFyy1STvCkHrhy7Ut_H5KIBg7inAWAkN0wPXarN7Y1
    EmYzW2xLO_BayGwAw>
X-ME-Received: <xmr:vGUDZ8zPS8PtOEJ8skxOoI3RvWS7IDrIMrLQIxSAP1RO6ZRfCtfVinujz7V-z4c-M7etIwqWnxM2KR4UGE7mFCDWXiwb0XeldItGsianLjS9Sgw1LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:vGUDZwMu7AAig4RdR7lx3mn3L5UCr8j8IywK4aS5lT2rqhxnesnI8g>
    <xmx:vGUDZ58N7tYL2eGU3pJwKvYs34B8cPWOiSOM0UJ27c5rOSODRW0flQ>
    <xmx:vGUDZwVDE1XdtWY_b3ZxR23P5JKoqOfV1OhGMlTny3rZOQLA4Tg8AQ>
    <xmx:vGUDZ6eYoxj6kdx2wezltAKY3t9V2KOI-ugCRkoWU9KAw3LTqXYHRg>
    <xmx:vGUDZ0YkfZ56D6Qj74dgp4UNwIljVXGVTlVOsEFOvEHm5busrxnL0VEa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 00:38:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7f63b3e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 04:37:22 +0000 (UTC)
Date: Mon, 7 Oct 2024 06:38:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] cache-tree: detect mismatching number of index entries
Message-ID: <d63087c53c5e57c63fe27a7a7dffa8fdb312f30a.1728275640.git.ps@pks.im>
References: <cover.1726556195.git.ps@pks.im>
 <cover.1728275640.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728275640.git.ps@pks.im>

In t4058 we have some tests that exercise git-read-tree(1) when used
with a tree that contains duplicate entries. While the expectation is
that we fail, we ideally should fail gracefully without a segfault.

But that is not the case: we never check that the number of entries in
the cache-tree is less than or equal to the number of entries in the
index. This can lead to an out-of-bounds read as we unconditionally
access `istate->cache[idx]`, where `idx` is controlled by the number of
cache-tree entries and the current position therein. The result is a
segfault.

Fix this segfault by adding a sanity check for the number of index
entries before dereferencing them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 cache-tree.c               |  5 +++++
 t/t4058-diff-duplicates.sh | 12 ++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 4228b6fad4..1e62567308 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -933,6 +933,11 @@ static int verify_one(struct repository *r,
 		pos = 0;
 	}
 
+	if (it->entry_count + pos > istate->cache_nr) {
+		ret = error(_("corrupted cache-tree has entries not present in index"));
+		goto out;
+	}
+
 	i = 0;
 	while (i < it->entry_count) {
 		struct cache_entry *ce = istate->cache[pos + i];
diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
index 2501c89c1c..3f602adb05 100755
--- a/t/t4058-diff-duplicates.sh
+++ b/t/t4058-diff-duplicates.sh
@@ -132,15 +132,15 @@ test_expect_success 'create a few commits' '
 	rm commit_id up final
 '
 
-test_expect_failure 'git read-tree does not segfault' '
-	test_when_finished rm .git/index.lock &&
-	test_might_fail git read-tree --reset base
+test_expect_success 'git read-tree does not segfault' '
+	test_must_fail git read-tree --reset base 2>err &&
+	test_grep "error: corrupted cache-tree has entries not present in index" err
 '
 
-test_expect_failure 'reset --hard does not segfault' '
-	test_when_finished rm .git/index.lock &&
+test_expect_success 'reset --hard does not segfault' '
 	git checkout base &&
-	test_might_fail git reset --hard
+	test_must_fail git reset --hard 2>err &&
+	test_grep "error: corrupted cache-tree has entries not present in index" err
 '
 
 test_expect_failure 'git diff HEAD does not segfault' '
-- 
2.47.0.rc0.dirty

