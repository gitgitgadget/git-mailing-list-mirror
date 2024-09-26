Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DAD17C9E7
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351232; cv=none; b=DcK66juJXjFLE5cWxAShZaLsbEAqm9rDyV0GCYHwlqtkvRcMtRqkQyH+ZCP5zm0S2JthB7uUJlMnNiAJ7KbCEk5spDMK2ecVUWMeiWRsi+yQ3TR8TfO0s7wPsMavEWbPJOLAxd1R2wXAs6qD3NZhO/vTOBxJlAOmJjrAof2B30w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351232; c=relaxed/simple;
	bh=LfoLiZVw0Lhpzdg0odGVf4R5LPqGjjneVSxRlOEFXhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bouxIMQ0cia2yrh2CJYKS26g4oJd8UxnIIhH9rkTidwy4rDgI2AcyHCpzwa+B6wr1PTMHqUMTB11mrIXY+H/3yX+3pC20lTQeeDVoj21ZgtMU9vOoaEOlRp7vJz26ALdz3QBoy6+CaOr/LQ9rmEVuoplj/glXcdtXk+EH2+F/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HAykDAmz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AS0aPRtT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HAykDAmz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AS0aPRtT"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 95E231140249;
	Thu, 26 Sep 2024 07:47:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 26 Sep 2024 07:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351229; x=1727437629; bh=0LfSDKdkrg
	ZDMOPYEbctadthjKt6uEGXCQQ2Ua7B3Qg=; b=HAykDAmz7OdNvpMQRYmei6CPTI
	0QfGru85VfWUyiyz7bHu2eNOr9vffiyqCFwrAmNu+LYzE12pig5fuBaDySaJyXJ1
	Y4EBEXuSqg0J3jSyKhK9csSQLGLzlK3+MBFhJFNJ3EwDjiMWse89YaqGw3oYt1tJ
	Y2mw3qIa56ipMgEJjaalUIkXou+bqVZNVL75XqIcu9i4jMZ+zeZN+MNaOyovsngO
	HDKFwyvLzNqz7mQGq3j74wBDUAp9yJg7fH7KMi3fZ+y0y3kIyYOK0jmMXoHYTzPw
	HVuz2srt927HrhTrF9SU6Ws/Kz77U/DyezcyiHb2AIpUXccHmvzTp2KP84GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351229; x=1727437629; bh=0LfSDKdkrgZDMOPYEbctadthjKt6
	uEGXCQQ2Ua7B3Qg=; b=AS0aPRtTpyP2FsyxatbOmad+QAoA/v3dYpUXHLoWz0P7
	4TaQ+675qWdN5KN1oX7P3NruQpwQt6nUIY1eHnnequWBdNml6TGDJQK+/VRIRrBl
	jThKxwVZtXKat94axKHYgbn8v7G7ugGx9d/M65aa+Tmnes+gXSrAI0j37geJ9ZbK
	0kpqstFJzVCFf9zh6ihrsBsQn2D0Z50er3LMa1XRhY8dL4P0IvFwiz6MuhZYKDyI
	M6ElQNF+0uW0pWl14nEpOdRFD64o1pdc8zv7WlWelOnWz3R11Y8de1DjU8we3Tj9
	wo+VT184gmOokh29CL2OPO7ZBmZngRA0BZwTvy55Dw==
X-ME-Sender: <xms:vUn1ZoUhGPIxPazq3FErPx7zILryIuIr_uuFdvv9qswxkg2ViejupA>
    <xme:vUn1Zsnf9UYA5QaAD_Jun7GvLAFTqHMzPjY-t4KH95krjzG3WafyLYelkKc0Hgypk
    mKQvYmBnVcWcXNKfQ>
X-ME-Received: <xmr:vUn1ZsY2a7CSatvg6qMDhJTIBBruSM-oHWW0WV3N4q1WHap-TCrCvJWuBicmYVoaWj_4rq4iq7foQTFcy1dnbPmyLe-q9DJLqRxNdpYK3SgoRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:vUn1ZnWiR-ibpEOXwBqNWZo8TFCqSTiRPC9kkORVuwBk9Itjav9xwA>
    <xmx:vUn1ZikOlbhVJ8Gg5KKApGiC8gH06mqCGSY2VIe2NaTXBXvLytzKVA>
    <xmx:vUn1Zsd54p4vnwFcyPz5LhAX-6lAzMpBm7XZg1MeKvuJGB9SSdDIuw>
    <xmx:vUn1ZkE16Ge5g7YdRs88LWS2ip4rZPZHGakqVy0tKVgrDhWJ0M6TQQ>
    <xmx:vUn1ZkixPz2VdUIcfDDbkSB-B1RlwOlt-wI38A4PToyt7mY2tVrVuAw5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:47:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e66ab40d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:46:30 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:47:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 22/23] revision: fix leaking parents when simplifying
 commits
Message-ID: <8e7ea54863f9fde80bc99d654140146cbb1247f7.1727351062.git.ps@pks.im>
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

When simplifying commits, e.g. because they are treesame with their
parents, we unset the commit's parent pointers but never free them. Plug
the resulting memory leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c                        | 5 +++++
 t/t1414-reflog-walk.sh            | 1 +
 t/t5310-pack-bitmaps.sh           | 1 +
 t/t5326-multi-pack-bitmaps.sh     | 2 ++
 t/t6004-rev-list-path-optim.sh    | 1 +
 t/t6019-rev-list-ancestry-path.sh | 1 +
 t/t6111-rev-list-treesame.sh      | 1 +
 7 files changed, 12 insertions(+)

diff --git a/revision.c b/revision.c
index 2d7ad2bddf..e79f39e555 100644
--- a/revision.c
+++ b/revision.c
@@ -1071,7 +1071,11 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 					ts->treesame[nth_parent] = 1;
 				continue;
 			}
+
+			free_commit_list(parent->next);
 			parent->next = NULL;
+			while (commit->parents != parent)
+				pop_commit(&commit->parents);
 			commit->parents = parent;
 
 			/*
@@ -1103,6 +1107,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 					die("cannot simplify commit %s (invalid %s)",
 					    oid_to_hex(&commit->object.oid),
 					    oid_to_hex(&p->object.oid));
+				free_commit_list(p->parents);
 				p->parents = NULL;
 			}
 		/* fallthrough */
diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index be6c3f472c..49d28166da 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -4,6 +4,7 @@ test_description='various tests of reflog walk (log -g) behavior'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up some reflog entries' '
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index a6de7c5764..7044c7d7c6 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -2,6 +2,7 @@
 
 test_description='exercise basic bitmap functionality'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 832b92619c..6eaa692f33 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='exercise basic multi-pack bitmap functionality'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 
diff --git a/t/t6004-rev-list-path-optim.sh b/t/t6004-rev-list-path-optim.sh
index cd4f420e2a..5416241ede 100755
--- a/t/t6004-rev-list-path-optim.sh
+++ b/t/t6004-rev-list-path-optim.sh
@@ -16,6 +16,7 @@ test_description='git rev-list trivial path optimization test
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index 738da23628..1aabab6956 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -29,6 +29,7 @@ test_description='--ancestry-path'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_merge () {
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index 90ff141640..f63bc8d3da 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -16,6 +16,7 @@ test_description='TREESAME and limiting'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 note () {
-- 
2.46.2.852.g229c0bf0e5.dirty

