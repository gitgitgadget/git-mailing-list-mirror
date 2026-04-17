Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF0637F735
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423072; cv=none; b=axF2N/Jo2AADVKuoz6XcEe3+ug7nY9Lysq6QA+umYkBmzQjyUcnQ+6V+02/QgRc5uTl4hQ6XugcQb/tiW+fqnV4yTeQts+nm4M5+oduheK0QCWi2Ii9fgHBPhPCP/H0SNDA+iFkK72rTMia9WIA3179vHnOb2bQe7QW++0lZJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423072; c=relaxed/simple;
	bh=ObdRYQZFYbTS1ePGjWS1xpHk5P/smc3lj+j09EyDTFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zoj8z3ZK5KpUpm9R9arj7Zt9WGLlgBfqX1mEH/4XX6I3g4jayw63Uc9RL/sTkSEgSBA/XW4h87xeGORd8nUPMnUPdb0AVc4k/lwUMA5WnhHjPH+rPZbLiFC9v0+xebbMDIYh6UC1+QqKBbpydROWROAgM6CujcoJZcnVFyVnVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hD/f4GAi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qw5qv9ea; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hD/f4GAi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qw5qv9ea"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1ECA0EC00AE;
	Fri, 17 Apr 2026 06:51:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 17 Apr 2026 06:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776423069;
	 x=1776509469; bh=5YRy/pMMUCTvNK4T36qBGqlCkGz6vOMwPQ4qWbLjTRI=; b=
	hD/f4GAibifYdaEUdQAny5i00jZJORc/bUs+2xxIOgsyhoRQZEgHD0/xgBhyqGFt
	9VFeM7ztCnfsPldDxLuRt+m7crLYmkx14u1ID+8z8YwvrQOgVsjSGAUnYfKhpOlV
	jP4V4l8ru+CKToVPw9sv5C77OeDcoGmNbm0eMvtwIfkmmydZ4Gfv3rHP62UqQ7Hv
	s2ENcRmfeBkj7PUBi8WpQO0NQ6hwopMtBZyuNsyU2nsofXYp5ArnwgudLIqXiKv2
	w2HY0YNkCwtlHVMdcS1vMZP7xDbuATvHQExj4SFcrE2AnRavZh80oNgcRD8y0yZ+
	IbKWr65xQy4fXnrfzCNt9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776423069; x=
	1776509469; bh=5YRy/pMMUCTvNK4T36qBGqlCkGz6vOMwPQ4qWbLjTRI=; b=Q
	w5qv9eaDEF/QGUKXoGgOPOjKf7oIYFRI9qPJH5W7l2FkohbVowfGCC1anQYxIXAJ
	Z2v3M/NOFHqh/fzAhMhUFfrrpuOsZ1f1b20rDN49LxjCCTf4ppgHN7Qc6tg8UV9p
	W3osftO7fczYBc1SHE4XfElg6b6L8F7+iWqTaGde16dFcndYP/g6RRMDlb1281o/
	gxBi2nGPxYZbM6aa2IViQiWh9TvooyeASRPBcJ+TZwsMUjO45VFSHXoDzawUj5a3
	uaks50eWwjkdQw0DPgUSzpGdJK23yQu7RtRxFvFDga0SP9r03OrIytNGvH2uXE23
	eQLNBRmFc+UEN3dOeNqpw==
X-ME-Sender: <xms:nRDiaRjmOgYAOUzVhCxQri6dY2NRv7QSp1eOv4HfQwQxkvV8t56qPA>
    <xme:nRDiadBIHOOWEIAnoz_FPyTtat_MNZ5rOatpRb-XEBEYvjTdeiEnbXHBcrc_Rl2ri
    S5jHqP2IZjaWHtJWL8rTfS-kniXonz-Ffz1v9QOdClZzH9rTzda8g>
X-ME-Received: <xmr:nRDiaWHuHwrh38gGDHSkmSaMAtOc5yvp4S-aUvlT4p-q34gVLue-9ybBdNvBJ-_qZZsNEFyhVE6shq067e5tkOiKH65K4NMytgrB0DwU47Rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvght
X-ME-Proxy: <xmx:nRDiaVKzT7j1AzTSRGMBVmg8IsZJ94arhgxfFV7STjgzx6JwwE6N5w>
    <xmx:nRDiaak75C3KxgQMaYxjKBaG9nWH59mwLr4ENTMMDhRqBEmMyY2yvA>
    <xmx:nRDiadSKKXTtI-n1pB6sV7S7bd_bFzD2WRXcY6TPhvqVLCqzS9tumg>
    <xmx:nRDiacKnxSMP2l2N-nLrdfNM6i8M17hODEtDbc5bmZBkkUEcysRE7A>
    <xmx:nRDiaQCsseoXZ0nO_thm6J9POi1QaGIgDOjgu4eySsdRXxXKt_0OXITg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 06:51:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 49b53bd6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Apr 2026 10:51:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Apr 2026 12:50:50 +0200
Subject: [PATCH v4 04/12] t: prepare `git config --unset` calls for `set
 -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-b4-pks-tests-with-set-e-v4-4-44d43efdafb1@pks.im>
References: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
In-Reply-To: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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
2.54.0.rc2.529.gd9106f7525.dirty

