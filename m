Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE483A48DF
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782649559; cv=none; b=JpmchyMb7h/XaqAQCZ/RSsMaV0dR5xqmd/ABViC4uqCZJi3f9oHEufY4WeXvRJT0nqVnndHqe10Xqntfez4flMnZoo1dhF71ymLUjbKp67N7hgSVRPQSr/CDOeLI9xGLbE49LaMjReAhCXVlIbJEsJ6+F7p5Ltme0B8KXM/TH4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782649559; c=relaxed/simple;
	bh=O/jFhhQAvZl6kF2mI7b0UmvH9wKo5GsFXphU3ScIF5o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bvgqN4H4CfsMr2QKwT7ZAk+DIAEeITbJw47J1ddXBbSbAXFc1lNDoyl9U60d0Z7ERnE4uxpKb+cIImqJKr0RzXgiVWcGnViuq4rhH4puoMQQahZ/F7tLQWg5Hmn/UHkWsx1hYGv+EGm3vhSQ379x+xfuXC/B7CYayg8SnDXfNCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWqsfUGZ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWqsfUGZ"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8eefd0c5f59so6535576d6.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782649557; x=1783254357; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4CEdaL3wXcEP1AlcWsuZJDb3C13fQEZwrdmqLsOhBo=;
        b=VWqsfUGZrizfsRc4rWy3jA/SCeN8j+X/+EN5GDQLD5xIvrnyYsGVHfUpZJRwH/jS9N
         ivk/HGG8muWzGxAuGFEynydy8EbDfRov9pbCgiOyaI4eF7bsfbK5g16IdjoGLVz3Sfdo
         ZfaqBkd1NHqPEFxsMP6FfOHy4we0f6JTr5B/VqzKGVPEk13Ztgvs1nzuYy6EdXldLf5X
         Rrhhm1ziSvOydFxWe9qBKceh9vW0O+80a9UFjcXBsjqyhLHaM4n9D8tIhgIfiCeruGrv
         GSyGumRW2XOkyYHB4tYlcw7dat6Hl16BtCAd/MjiE6PvH4gionO5G0gjNFsGfhkNlMiF
         YBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782649557; x=1783254357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4CEdaL3wXcEP1AlcWsuZJDb3C13fQEZwrdmqLsOhBo=;
        b=lRKGcXDUNKFlT0xbKMJmdJQvYo4nVNC7dCIzQDZyvx5483DAJCaECUnO+LOAwbk05q
         N0c8iQXMv6vQAikCsbH5Bqd3FDxZtIWgtxk4dilaP1DdHB5srT5Ax12KeQ02wXcLz1V7
         WFPi1oasaE865Lp21+4wnht+nOW+NcoULwiOvNKObaL9+8UlkwCH9IfP7uQqG3+HAgQo
         6tQzlCE2qigRIoe5znXi62FL/7PVFOsO0r7nX80udqsfi6RwBjyfZVqdxw0/7IXnjcg8
         +09J2ej22lvSSe5okbeFGyJ3yRMPX0l8lSPMXMjN4dbI+J2Jopugew5Qzs6f8twRCAXd
         CxRw==
X-Gm-Message-State: AOJu0Ywe+jUBi+1x5hXzF8EgsoCUiHSuJCLhucnp5WNFmYp+8+uGiMWH
	h+KzKSZCDDgJivUfMW7EY25wrMqOf673RZI6yiYw2DLydzw4pg6Zw2+IeZR5/A==
X-Gm-Gg: AfdE7clRIZlIqd8H3nND4C0Rfl2Nxy886NCcTnJYIMemdtboY8UR6qOVbpeGuULzhGu
	dRODcLbSnD41doFom3UlaULvNU2IgjXLMB8L6FdT1J3IViKdnLs7zXfNwhrMvtR5wcuN1bhdEF3
	rQpaW/uejdTK55oVtWFDVCCvdYo3ezKo3VZIDdIFYq1WQghPPZSHreIAWr0ALljaOTKLC8CaFrl
	vJNdGUhdhArUPzDBfDc+t2rrYAxu7+Iae6O79Te8+xhJat55OEAap333YuhVFJBPKkBjNOcDFeF
	pGWY3BWLeaLEVLOqY5lfag3wZAX4BpRWbAl5d0eViH1e14EhV1/YhWhZl3szZwUKVCq513igHsp
	Q03BX6S4CzfJZGk1XPhXOzKAzpsOQaVI1AtN4yNvPtSzzz81fGp2aMm9prK9n4/rpmR3OrNRty2
	dp+Ompye0YEy1he47f
X-Received: by 2002:a0c:f985:0:b0:8e9:f62b:8f91 with SMTP id 6a1803df08f44-8e9f62b919bmr67844696d6.55.1782649557072;
        Sun, 28 Jun 2026 05:25:57 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.135.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f604c56sm277801476d6.16.2026.06.28.05.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 05:25:56 -0700 (PDT)
Message-Id: <017bf156c57ceb2df33b316d4537baf3a72672fd.1782649547.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
	<pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 12:25:41 +0000
Subject: [PATCH v4 3/8] t6099, t6600: add side-exhaustion regression tests
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add t6099 to test the case where multiple merge-base candidates exist
and one is an ancestor of another. This exercises the side-exhaustion
optimization in paint_down_to_common together with the
remove_redundant safety net in get_merge_bases_many_0.

Add a mixed finite/INFINITY test to t6600 where one tip is outside
the commit-graph (INFINITY generation) and the other is inside.
This exercises the region transition: the walk starts in the
INFINITY region where side-exhaustion is disabled, then crosses
into the finite region where it can fire.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/meson.build                         |  1 +
 t/t6099-merge-base-side-exhaustion.sh | 82 +++++++++++++++++++++++++++
 t/t6600-test-reach.sh                 | 25 ++++++++
 3 files changed, 108 insertions(+)
 create mode 100755 t/t6099-merge-base-side-exhaustion.sh

diff --git a/t/meson.build b/t/meson.build
index 3219264fe7..ee6ebdffb9 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -786,6 +786,7 @@ integration_tests = [
   't6041-bisect-submodule.sh',
   't6050-replace.sh',
   't6060-merge-index.sh',
+  't6099-merge-base-side-exhaustion.sh',
   't6100-rev-list-in-order.sh',
   't6101-rev-parse-parents.sh',
   't6102-rev-list-unexpected-objects.sh',
diff --git a/t/t6099-merge-base-side-exhaustion.sh b/t/t6099-merge-base-side-exhaustion.sh
new file mode 100755
index 0000000000..4f1e0d50ef
--- /dev/null
+++ b/t/t6099-merge-base-side-exhaustion.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description='merge-base with ancestor among merge-base candidates
+
+Test that merge-base --all correctly handles cases where
+multiple merge-base candidates exist and one is an ancestor
+of another. The side-exhaustion optimization in
+paint_down_to_common may exit before STALE propagation
+removes the ancestor, but remove_redundant catches it.
+
+Graph shape (parents are below children):
+
+   A ----------- X
+   |\           /|
+   | B---------/ |
+   | |           |
+   e2 \         f2
+   |   |         |
+   e1 d1        f1
+    \  |        /
+     \ |       /
+      \|      /
+       C
+
+A and X are the two tips.
+B and C are both reachable from A and X.
+B reaches C through d1.
+Only B should appear in merge-base --all output.
+'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'setup ancestor merge-base candidate' '
+	test_commit C &&
+
+	git checkout -b d-chain HEAD &&
+	test_commit d1 &&
+	test_commit B &&
+
+	git checkout -b e-path C &&
+	test_commit e1 &&
+	test_commit e2 &&
+
+	git checkout -b f-path C &&
+	test_commit f1 &&
+	test_commit f2 &&
+
+	git checkout -b branch-A e-path &&
+	test_merge A B &&
+
+	git checkout -b branch-X f-path &&
+	test_merge X B &&
+
+	git commit-graph write --reachable
+'
+
+test_expect_success 'merge-base --all excludes ancestor candidate' '
+	git rev-parse B >expected &&
+	git merge-base --all A X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'merge-base (single) finds shallowest' '
+	git rev-parse B >expected &&
+	git merge-base A X >actual &&
+	test_cmp expected actual
+'
+
+# Without commit-graph: generation numbers are INFINITY,
+# side-exhaustion optimization does not fire.
+test_expect_success 'merge-base --all without commit-graph' '
+	rm -f .git/objects/info/commit-graph &&
+	git rev-parse B >expected &&
+	git merge-base --all A X >actual &&
+	test_cmp expected actual
+'
+
+test_done
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index c2e091aad1..4b771b4c58 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -294,6 +294,31 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 	test_all_modes get_merge_bases_many
 '
 
+test_expect_success 'setup mixed finite/INFINITY topology' '
+	# Create a commit outside all saved commit-graph files so it always
+	# has INFINITY generation, while its parent (ps-X) is in the graph
+	# with a finite generation. Use the ps-* orphan topology so we do
+	# not pollute the grid-based rev-list tests.
+	git checkout ps-X &&
+	test_env GIT_TEST_COMMIT_GRAPH= test_commit pm-INF
+'
+
+test_expect_success 'get_merge_bases_many:mixed-finite-infinity' '
+	# One tip (pm-INF) is outside the commit-graph with INFINITY
+	# generation; the other (ps-B) is in the graph with finite
+	# generation. The walk starts in the INFINITY region and crosses
+	# into the finite region where side-exhaustion can fire.
+	cat >input <<-\EOF &&
+	A:pm-INF
+	X:ps-B
+	EOF
+	{
+		echo "get_merge_bases_many(A,X):" &&
+		git rev-parse ps-X
+	} >expect &&
+	test_all_modes get_merge_bases_many
+'
+
 test_expect_success 'reduce_heads' '
 	cat >input <<-\EOF &&
 	X:commit-1-10
-- 
gitgitgadget

