Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204DC3B389B
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073780; cv=none; b=F9hJXlIcwcx4Cnx5cZWiouo6qIJPCwIyRsbWWXlGtFn29v3OgdEZ3fvjcjz3fcELovGvfR7nsbRHmRrdY80J0PAz9TjYM31rU7RuNhoRUL/c6YmQJ1808d1fr+RT7pTD62WHyuH+vS4whZXKXGL04HVvtlroz2BgsQCLURVoWXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073780; c=relaxed/simple;
	bh=1fJzciyjOZoPl9z3cKUaJ0ojyY9Vv8Zv3wC3N5puvq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SsYqaCjQHtQ7j16dFtaLX2x3v8oE4csnHv2+uUjKsbNEyYaf4af8vjjq8vdfSHYWXk0FYRquQ79w1smdV9UO6qCntth5WRCy1AERymeTv3so+ZWIPALCjfMS4NTpXA1Jibq3aoiR6jySTwO4ZujlyjmyC5gwsotuUS3FoPEsgKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=omgoPDz1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eBpyvEKk; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="omgoPDz1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eBpyvEKk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F4691400183;
	Mon, 13 Apr 2026 05:49:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 05:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776073778;
	 x=1776160178; bh=uk3dO7uy8rD9on7NBveD8OlHVM9T2tVvqDi9BkJukI4=; b=
	omgoPDz1jU7JNJYdMi+S9ue80nPfg3KDi00XzCVpx6KtQbhCkNUVUtsgp7dwahdS
	voQZ/x9Dc4XIyjPzSNwFIfreiUt7zjUHuaXZg9TB7QSo/jlBdCx6v023TNgeUTNW
	PpXUUWF2jVUrRdLmD+RthvaejimhvtxoQECG62w75cugknXpPzmrIZqcFyP2VHyN
	jOpwHKnXxNLJ0KwhXwahdvGmDQnRBv/4nTq4Ne4rC+qBPTcnABGY4OqEw5W3XKhx
	kWcwbIJCNe1VyXFaWH2ADFlIeQCp1sX23SEWOLDZUYbMEo8+jWOTyRWccdiXDv6r
	bCgq6wYymvBfhN6Df3P9ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776073778; x=
	1776160178; bh=uk3dO7uy8rD9on7NBveD8OlHVM9T2tVvqDi9BkJukI4=; b=e
	BpyvEKk4KX1aOccnl5CfNJgO7IYCQVlrLOWRrZTKG/WxvQ8biFtPg/n1LHBmu1dN
	YBJCaP1t9v7TOowmr4lAz664+7sPjv8Gzl8oMpe8/Uv5wRHF0dDmC0lHW6k8Jj2q
	B0vqrOMVL4z0HE3h/70ucmH37hKUIOKu8xLhl9oh0qWd8pratRKB6sOq7zo3xgCu
	kgLATuaDzJ5H99npQJeVpk4APh4/ch5W6JHyVvjD1baQ+AjOO3XkT0EpBOoOA6Gd
	9xf1NffdcZFShDN2OCswQePZTBaWYVAMvZzTgm2NDT9222V+YrufbCctJu1Dnkdc
	wiSBB2UElSUucRJ1CYzag==
X-ME-Sender: <xms:MrzcaWG_YKlFoDXa_csE9Vvy_-7uJJaYgb8ogEBFiHogth-7thzLtA>
    <xme:MrzcadVBIm5-6H-gOIJSxmK04zX9rb9kfwBsSdmRWYDlbNY56MtX5kAGU9MES28r1
    Mj34q3vyaBA2idnSr6RyOSG6gZZckQS56JjxVYxHFCBnn9NeQW8vg>
X-ME-Received: <xmr:MrzcadxbYEbf7rayMaN2FBk-4fAsS00UW3-U09QTCndQ3xhTIh8RSN6Sf5lZWhwV1o3aU2LoM3XfRrN7WJw7cx9E89s9n3svq2POA8KZ4Qs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MrzcabMNOSjvFHsI5Bt3pw5t7Zh2NBtPdYHceSvWx1-Hj8AddEm_ZQ>
    <xmx:Mrzcae4kZCcotoixwj8yps3oOrtGr1qIh_UAXzcWT7ODUULHqoe4IQ>
    <xmx:MrzcacN40cvwLxKkMUulNjtOUiyLHWWSfNQjONwyS7AO1R23Sm44sQ>
    <xmx:MrzcaclPCEQADOw6ihs6ND28-H0fjtBMJCNK4d--cVMQBeQFSquUPA>
    <xmx:MrzcaRcS1kW5XLv9qcRS0zFHy3spr5nw1PLdS4eZE9OiSsA6h1ZlvJxX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 05:49:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c0fe5f1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 09:49:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Apr 2026 11:49:25 +0200
Subject: [PATCH 04/12] t: prepare `git config --unset` calls for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-pks-tests-with-set-e-v1-4-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

We have a couple of calls to `git config --unset` that ultimately end up
as no-ops as the configuration variables aren't set (anymore) in the
first place. These calls are mostly intended to recover unconditionally
from tests that may have executed only partially, but they'll ultimately
fail during a normal test run.

This hasn't been a problem until now as we aren't running tests with
`set -e`. This is about to change though, so let's silence the case
where we cannot unset the config keys.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4032-diff-inter-hunk-context.sh | 2 +-
 t/t7508-status.sh                  | 4 ++--
 t/t9138-git-svn-authors-prog.sh    | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index bada0cbd32..c98eb6abb2 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -17,7 +17,7 @@ f() {
 
 t() {
 	use_config=
-	git config --unset diff.interHunkContext
+	git config --unset diff.interHunkContext || :
 
 	case $# in
 	4) hunks=$4; cmd="diff -U$3";;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a5e21bf8bf..1167b835a4 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -773,8 +773,8 @@ test_expect_success TTY 'status --porcelain ignores color.status' '
 '
 
 # recover unconditionally from color tests
-git config --unset color.status
-git config --unset color.ui
+git config --unset color.status || :
+git config --unset color.ui || :
 
 test_expect_success 'status --porcelain respects -b' '
 
diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
index 784ec7fc2d..5bb38cb23a 100755
--- a/t/t9138-git-svn-authors-prog.sh
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -68,8 +68,8 @@ test_expect_success 'authors-file overrode authors-prog' '
 	)
 '
 
-git --git-dir=x/.git config --unset svn.authorsfile
-git --git-dir=x/.git config --unset svn.authorsprog
+git --git-dir=x/.git config --unset svn.authorsfile || :
+git --git-dir=x/.git config --unset svn.authorsprog || :
 
 test_expect_success 'authors-prog imported user without email' '
 	svn mkdir -m gg --username gg-hermit "$svnrepo"/gg &&

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

