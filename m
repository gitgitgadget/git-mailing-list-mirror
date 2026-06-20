Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865502EC086
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781951834; cv=none; b=EF1M2ij1Pd+QrNBrchv9yBvb8BmP5J90zw2rGkI2RrzYMrSyNKssQfZJfYeTYB6NEIco0H//nfnzMB3wPV3UCWUxeMfZeUY0TJFZAaUaN/rghlPx1X8fz7/EPKJ/CpkyFntTlotS12qzor2eGg8L1GN+057+K0OJUmRcXsnbbEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781951834; c=relaxed/simple;
	bh=UDOh+AZUL5x6XaluSyMXvCfzxQoHDAn10BsGuOj6UIk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sg1SujB+AUeVaS9Izl/SQFopzl9CqUUZVrTKd1Yt23yyvHP5dvnw47TAj+ynbTg9/kdjfguUNgSIXTBvlG4iXQypf/gg/Ar5PrOkh2QAFN8bFgNp8ym14Af3RK9Uzf5mu1j3V5CF2LaxWjpUvpSNdKPw4d0j+4wkja2d7JAxmHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r1uwYLOl; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1uwYLOl"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-137d464c47eso3081001c88.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 03:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781951833; x=1782556633; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6W9JQ6J0nGpJEc5w+fgDt2EsSFHt+9SDQuu/Ci+aFY=;
        b=r1uwYLOlyPLMevftrSL3X/200U8Z/A8DXpbw6uW2Y1giTW4GxcTvUDSt54zYEL4IQm
         FJT7PosswzZJ3yWuhSq33PUp5Vl8rPeEqFz09JOdueFUMp8KcySPr2e///T8KF1CvlPF
         2CuvyLh/eYYJ46ZxNwrajAZrdgZmHCnTYnpV4LF2bO6RbS7f2DC2fTdOqkRKowqtHghx
         aBbLK5K9/p2ijL6PP3RddeIEkmw8d1QWcvCQuTQrPZr/+8HUff/LNEiixvZAnMlKslaM
         LNMtFTMPIvQPJDuVlkRmX1pkQU2ihLvc0KWA/PQclPK6c0dk8101B5DqRv5d+63nvGcP
         Wx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781951833; x=1782556633;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F6W9JQ6J0nGpJEc5w+fgDt2EsSFHt+9SDQuu/Ci+aFY=;
        b=DPcYO282DVWwfJWRQBmYf+M2DBscdYgtdAi7ieXe3/Dn5QOf+MTC6SnnJPqeBThjbe
         9W7FZDHcIFL2sQuHF+xOg5yWxxGJW2aFXMeR0ZdV0cmOytyRSMlVNAS3tLfG1Dr1h3/X
         p7AtQyQUbFfr+kcLIg/PlT/J2/lXm+SFZtPMTRitR94rVzLZuEGUD7dY3JRkBEXTYIrm
         i/EaSOncJe9m4cj3iwOI3CzDZdClclc+LaidtfEv2ohXV6jjBxhvEKXezLkjMcECiFrK
         A7avHLEfJY6DUBz899TPsJnujld8lWXraPizrkKEzRMYPiXbjeFSa1pfkqvz8+wSrUEq
         //tw==
X-Gm-Message-State: AOJu0Yy8WTD0VoD09uvg+lsHXNmr1cYfVkr6qOzuaE/P4EYxbka4LDmy
	O4AqIH8vRiC18GIAuo8OWgfaO4+DM+G3Kw3rVSfW3icnYNhR3cPobdshtyUnrbpK
X-Gm-Gg: AfdE7ckM0t4pQm7rylLGDAkefBlX+sQXZtgen1hBvnZPwYnt/klxBbyPJSY734G/DnV
	sNgHRUa8yMapu0/G9r3T9MBbW/eeptYeyKbQEeNwiEw5ViBgJkFxvm1LScyWtpk8FYBpRUimS3B
	EyMGK4oDwZQPNaJB5xVu34bx1Qu7kYhK94tKoV9/MvlxaY0CRqn0AOoW/4gqLkNG5MxmUqtvuQT
	S/A4V02JLb0gmujh287EJpJ5sybRUv9LAsO7O2OSIbQApUfCkVBOnS6pNhxScDRlF69FUlKW8ig
	06mYfwUGS7R1ykEDKqiri/89VPEJpyhZnoBURyuVGAcpa8UKlM+dyNorwsJdX72jsHmFyh3sgnu
	BaBAm1kkQNOcNyX0kn1yzEwBrZKPSNXMiuqX3ogfaSunIvdBqPkEOUsGFTv+OfBrYHrZhRMmDw9
	12tcpfm+lpBVhlkNxh
X-Received: by 2002:a05:7300:230f:b0:30b:c0b4:db42 with SMTP id 5a478bee46e88-30c0798b0abmr4537655eec.11.1781951832508;
        Sat, 20 Jun 2026 03:37:12 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.54.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be95ebfsm3231378eec.31.2026.06.20.03.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 03:37:11 -0700 (PDT)
Message-Id: <faf5bc98ede79965e23bfe1535127d6f52221680.1781951820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jun 2026 10:36:58 +0000
Subject: [PATCH/RFC 5/6] t6099, t6600: add side-exhaustion regression tests
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
index 0000000000..bae3ea7f83
--- /dev/null
+++ b/t/t6099-merge-base-side-exhaustion.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description='merge-base with ancestor among merge-base candidates
+
+Test that merge-base --all correctly handles cases where
+multiple merge-base candidates exist and one is an ancestor
+of another.  The side-exhaustion optimization in
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
index 775c077c87..f5560b0c1c 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -294,6 +294,31 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 	test_all_modes get_merge_bases_many
 '
 
+test_expect_success 'setup mixed finite/INFINITY topology' '
+	# Create a commit outside all saved commit-graph files so it always
+	# has INFINITY generation, while its parent (ps-X) is in the graph
+	# with a finite generation.  Use the ps-* orphan topology so we do
+	# not pollute the grid-based rev-list tests.
+	git checkout ps-X &&
+	test_env GIT_TEST_COMMIT_GRAPH= test_commit pm-INF
+'
+
+test_expect_success 'get_merge_bases_many:mixed-finite-infinity' '
+	# One tip (pm-INF) is outside the commit-graph with INFINITY
+	# generation; the other (ps-B) is in the graph with finite
+	# generation.  The walk starts in the INFINITY region and crosses
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

