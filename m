Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8160217C9E7
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351236; cv=none; b=a26tcKBKT62jbSSSEAIz8qZhqMQPbVso7cf+pbLPLyqOSAHCyvrVAjrTBMAM8aut6OisBleEw1T6paDbRN2cZLpSkYxajfl/IZphv4yKDQtt1AiEhWvspyDSYDoHysYl0w2tAOHoZ61svE2iXAHmerwVToA9RzdqBbjnNdDt8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351236; c=relaxed/simple;
	bh=bSULJlxtVNqnJX8mpHGotBpuObbIv6k8aPobOOTv0JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dD9aa5KaJieu5RqfccfIXpU6sQP5Qb1STppOq5gMfb55unvo374d1oOr77KQFFleEP3W6/xdyJRUAURzc2ndMEeNyaGi/GyOskKBaU8nCK58/fP1ebstv6Qm1F+ZrzZxBqu8rYyMzICsS3VygmxeMZRwlZZbnGD78AQmv2uQ4+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W3F/0Tsq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LbNoh4Ho; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W3F/0Tsq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LbNoh4Ho"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C6F1C1380438;
	Thu, 26 Sep 2024 07:47:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 26 Sep 2024 07:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351233; x=1727437633; bh=GQw7GlHGqU
	1RpVgcbMcB2CRzIDPh2g4DVK4wZI0fpFA=; b=W3F/0Tsqil/W1fVb5Z7ktZtYel
	yu+ND+qCjN5A0L+PeNz8VkkVrFHJ40vG0OrhVDXRq9l0tC5pfekvMuC53pPf7ytj
	Z9BUg55RQcK+isYq7NiVJDAkurFkKiLcE5eFurnQV7HAS1VZucsMS9Nmb4hAVg/u
	EmqY78qf7ra+BAPutyXCXyGPovt8Ra8+7jWRRYJK0/366GmbM6fp4XANxR6JnI8y
	mM39G6s/gsWvQxWCiwm1uR1B3h7d+TLq68aC/HuNfDtrBNqGzUzNigLqlWsulNxQ
	Vxu+8lLT39V1EYNbtlQSnGPHogSXNfR4JxyTRYzM7RmNi28VBzwB8PP9BSlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351233; x=1727437633; bh=GQw7GlHGqU1RpVgcbMcB2CRzIDPh
	2g4DVK4wZI0fpFA=; b=LbNoh4Ho/FgqokGSAZp0IjEjfslTzVArPxax4CFsP2ae
	2BYtqxVbaWtvPydih5xE1ulHZkdQEIxx5HjXEqvi5WBA1A/nBVsCRBZh0nx50PSu
	kqlhVT3EtAP1An2fehIsN9OIq6bCTPGD7btlXcW9rPErAg/rK/hlX5zXNtWDn3Pm
	4DqHG4jp10GFMc5x1MxP+IWvLWisLjzJSRhmKPCMczbKKmGXjW8j6TcpSZb3IdBF
	O4SX9d3+tprJIimFeoLfkiYSc/TrBMhzTxW9YBTChPqYlKaqLI2vWv12lHESPIwT
	2hqHQx/FRbvzcL4RrJd7ssHmvDYf9yhtOxnPit8kQw==
X-ME-Sender: <xms:wUn1ZsTYQSv4YIOtWptYUlUZyDFve-ba-zDXrTpay0EyoycWjVS6kw>
    <xme:wUn1Zpx_b6gzUGYfqWByIv0l-6Y7KvohmopvHs_b6Ck6joK8qm87S5_JdsMalbPxE
    jK4bERgyKt4gj5e6A>
X-ME-Received: <xmr:wUn1Zp3VT8ebRl4F5_-btfbmW1MpRSOnwqdk2gj0Cd9CGKUheq-1bKsOHfmbzdHY4psjOdzYAH6gx5UTbuTzWcOeG9l36HGQdCgsGwi2tTgQlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wUn1ZgBuiO5ZMtfWUncMr1fFlDTHW8rNUlVVaskZIDs13bsXozlvLQ>
    <xmx:wUn1ZliaLsc_MsBH1NpWOlJs1WSsJwSazSq4JKsUxAzRUWRqo_jnGQ>
    <xmx:wUn1ZspjiceByfIK0F9n5Th7ORNncjgapZ1yIdOSN5NFNawBSOl_ag>
    <xmx:wUn1ZoiK_AEG35a8KVdXqJiaZ3yz64oLz_vSnQqfzbMYWerh1-Gm2w>
    <xmx:wUn1Zqu4itWYZmf5XTXDuwDmaqfQip13Ha1HfLUNs4-AFUKWa1sqTbrz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:47:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3d577f95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:46:35 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:47:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 23/23] diffcore-break: fix leaking filespecs when merging
 broken pairs
Message-ID: <8cbc41425f1100928c64c02602e62e1070998ec6.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

When merging file pairs after they have been broken up we queue a new
file pair and discard the broken-up ones. The newly-queued file pair
reuses one filespec of the broken up pairs each, where the respective
other filespec gets discarded. But we only end up freeing the filespec's
data, not the filespec itself, and thus leak memory.

Fix these leaks by using `free_filespec()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diffcore-break.c                  | 4 ++--
 t/t4008-diff-break-rewrite.sh     | 2 ++
 t/t4022-diff-rewrite.sh           | 1 +
 t/t4023-diff-rename-typechange.sh | 1 +
 t/t4031-diff-rewrite-binary.sh    | 1 +
 t/t7524-commit-summary.sh         | 2 ++
 6 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/diffcore-break.c b/diffcore-break.c
index 831b66b5c3..02735f80c6 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -266,8 +266,8 @@ static void merge_broken(struct diff_filepair *p,
 	 * in the resulting tree.
 	 */
 	d->one->rename_used++;
-	diff_free_filespec_data(d->two);
-	diff_free_filespec_data(c->one);
+	free_filespec(d->two);
+	free_filespec(c->one);
 	free(d);
 	free(c);
 }
diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
index 562aaf3a2a..b0ef0026e0 100755
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -21,6 +21,8 @@ With -B, this should be detected as two complete rewrites.
 
 Further, with -B and -M together, these should turn into two renames.
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index 6fed993ea0..77bc36d5d8 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -2,6 +2,7 @@
 
 test_description='rewrite diff'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-data.sh
 
diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
index 787605ce3f..e6f4fe441e 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -2,6 +2,7 @@
 
 test_description='typechange rename detection'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index c4394a27b5..1b8cd3e4c9 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -2,6 +2,7 @@
 
 test_description='rewrite diff on binary file'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We must be large enough to meet the MINIMUM_BREAK_SIZE
diff --git a/t/t7524-commit-summary.sh b/t/t7524-commit-summary.sh
index 47b2f1dc22..a8fceb6a47 100755
--- a/t/t7524-commit-summary.sh
+++ b/t/t7524-commit-summary.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git commit summary'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.46.2.852.g229c0bf0e5.dirty

