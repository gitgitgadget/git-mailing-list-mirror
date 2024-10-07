Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2DC13B58B
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 04:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728275906; cv=none; b=EB+Yi+dWz4tLjl7IoSY28ZkDII91HCcDR05c0knTNMc0Cq/YrIbHtqPGF+A9RPHBJWymvDs+RG6p7T7HfiiHACfyExNhS0I+0QV/6/JGEj4nW2t9fUlZh9//x5OMyG2OirD9ATNNlLHWPL8u8/TAb9LB8J6S5q0rKZuHJxpUKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728275906; c=relaxed/simple;
	bh=CT5qE4fKBipG42aB+ehTQI6vfJrG1b8Mm454URLpGb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6ci4c1SPKSqBTcBpD3gnOUBeJIFFf0jqVxr9qCEb9L0V/6ZCizeiqCpcqRQQJH3Que4cyhj4IJU9j5vxzJOFK8si8cjeDwCyFj4FfViKDGC9hICNQ3+uUXmV7vpEDAfCZ0X/IdVez+AwX0fihj1rKtY5dHF7c+zSjkvLpiYxdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fenwPimS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eibkSAsb; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fenwPimS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eibkSAsb"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CD9B114021C;
	Mon,  7 Oct 2024 00:38:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 07 Oct 2024 00:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728275904; x=1728362304; bh=ye801GLyTx
	ZfhU6VtnpGVzHAUWybF6RuZXySO0tt/eQ=; b=fenwPimSi9rMc9LalAcX2jeQ6U
	NzNgEvPHJVwZchDMlQahHwK/22wAvistLVDkE+73S6e5zy7uypLpprUbXlqCDke4
	stm66cTn4QrjEH2zB9YU320YtKRBhiDyzfn2DNhfuXC+heazV8lSaVnoixumbmcF
	ElQBOmaXqbjqTjqOYGKprdGziSLMDem5wtRBfOZi9eyCFSrSxByuN2/XbWDw2Xlf
	tinD2HQoF4KXRaZFplz3qvFSY0EjCFmJyx2/yKAAkdOPgywqvaEZ9/1E8p0wxu8o
	iqCnt13u/Hcz+bdcU87T7Q2RFgVz8nFVqugrVbnmaWYnFwHyCrVh57Xe6fqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728275904; x=1728362304; bh=ye801GLyTxZfhU6VtnpGVzHAUWyb
	F6RuZXySO0tt/eQ=; b=eibkSAsbObSiPWPdeaWAMsgIESb7xMe3s5TWVxNSANps
	BXB0iyuXLWcEBCecC4k3fjoi0okkErGcfiir09C1IRpFo7O4bDTnbIl2vQ3Xd0hB
	mMQpStM0Ck+rXpRUuzYLxfufEn6+OXnHZM8yvaaH12ycLfJyH4SKoMkIOEmOq/ZK
	og2kxAAJJ7Vdcs8ji6Xzd0PjxGWAZWHunPy8QHfmy/tk5BdBM4obRMSZkfItFpSB
	a/sTKK+FXzA+9IjIgPjWtO0Dti8hmArKAPU3Ira110ybR6+6J6opSMccF1N+dgf4
	zfHz5zWhNdbsXcwn/4VTCyFsJw4pEfXB4+oH9qNiFQ==
X-ME-Sender: <xms:v2UDZyOtMYW3F1lS3z_rJ_nRUsk6qQnbDvjSM51S2GoG7gBkLizkuQ>
    <xme:v2UDZw9G7pWOnCFIprI0OGSiEY0-Qk41WFfr3jmtlrMe-QO2uZagGI3_xeV7MrMcw
    hte3RM-JP-W37KOug>
X-ME-Received: <xmr:v2UDZ5SmmXhmPBWSzOCGTjK22_l6eiDapWXHI0iFgwG587d-vMlUbQPjG-pfzxV01_nALkPjsyBdNOeqCK-AE-O29htvfe4UVF4pSyPtP34nNrMEtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:v2UDZytRaJK7MF8756yj_yOykvqDsQF0yEI8DgI8-ClgZfqiWHV7Bg>
    <xmx:v2UDZ6f1PmkoSrOmICzSjTrGOYW4n9T3uojDrAu4nt5vBe3mG-QF1Q>
    <xmx:v2UDZ20-XSlC4jttksRbEf4bLk4OwVuWDTjvyJ4FhMJqbbq0gvCG6g>
    <xmx:v2UDZ-8T4-frc3V61XYbPw88gBsOW1WGjXRkhHMapea-1uvb_H6Vrg>
    <xmx:wGUDZ64kNN071u-X5yYnIPLkYaJof6KngVwyOmyYoRvqdWaYPn5NYP-m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 00:38:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1d480114 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 04:37:25 +0000 (UTC)
Date: Mon, 7 Oct 2024 06:38:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] unpack-trees: detect mismatching number of
 cache-tree/index entries
Message-ID: <5e578c1f4161ba5c23fd5b27e792807b632e9c06.1728275640.git.ps@pks.im>
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

Same as the preceding commit, we unconditionally dereference the index's
cache entries depending on the number of cache-tree entries, which can
lead to a segfault when the cache-tree is corrupted. Fix this bug.

This also makes t4058 pass with the leak sanitizer enabled.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4058-diff-duplicates.sh | 7 +++++--
 unpack-trees.c             | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
index 3f602adb05..18e5ac88c3 100755
--- a/t/t4058-diff-duplicates.sh
+++ b/t/t4058-diff-duplicates.sh
@@ -10,6 +10,8 @@
 #   that the diff output isn't wildly unreasonable.
 
 test_description='test tree diff when trees have duplicate entries'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # make_tree_entry <mode> <mode> <sha1>
@@ -143,11 +145,12 @@ test_expect_success 'reset --hard does not segfault' '
 	test_grep "error: corrupted cache-tree has entries not present in index" err
 '
 
-test_expect_failure 'git diff HEAD does not segfault' '
+test_expect_success 'git diff HEAD does not segfault' '
 	git checkout base &&
 	GIT_TEST_CHECK_CACHE_TREE=false &&
 	git reset --hard &&
-	test_might_fail git diff HEAD
+	test_must_fail git diff HEAD 2>err &&
+	test_grep "error: corrupted cache-tree has entries not present in index" err
 '
 
 test_expect_failure 'can switch to another branch when status is empty' '
diff --git a/unpack-trees.c b/unpack-trees.c
index 21cc197d47..e10a9d1209 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -808,6 +808,8 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
 
 	if (!o->merge)
 		BUG("We need cache-tree to do this optimization");
+	if (nr_entries + pos > o->src_index->cache_nr)
+		return error(_("corrupted cache-tree has entries not present in index"));
 
 	/*
 	 * Do what unpack_callback() and unpack_single_entry() normally
-- 
2.47.0.rc0.dirty

