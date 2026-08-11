Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16146426D3F
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440544; cv=none; b=UhhuLUzmVEX1yVYPzH2g2DoFuVq3Eluq1iJwuCel6/DzFtTXdWQeRG5GfSULthc6YyPdlCH4aBRHEPNGym3jJgdoAaryfHd7SrhqcAmdq4F5jg/gpS06mOFayluxwMUg4vwADoqS2zUCoL7vWHeJxaiT/ZBxMOSNhvn0j0i3OiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440544; c=relaxed/simple;
	bh=YBi63T9orPHcHx8153qtF0N7SBxwMXa8HpA6vbO3vwU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sMAndZ6d2XwbkywkUOram8hE/ZNLMcMz09SZOiwnMb9Of5M9ZpeuyFnfKJxvfS5wdMv+91dJZJybirXyBoyjWKNbvoT2qxapdeR/BhRvszmQPzClhvC0sjQcg36YT2SrIoVXpZwGFXgpHhEHCEzyv2k6xWLszKHVLjm1NtHB4L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M89XapON; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M89XapON"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso3637125a91.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440540; x=1787045340; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=az0kQBkCe3HjyLYy95RbzTSRcjP/6NeT/w+/aE3wlsg=;
        b=M89XapONKmusGMYWPBOd87Dn+G8rownkhF1Mzu2EsFz2UV5IrnugtI318HHgUUVftj
         n7KAqoHfIaNiDIpPj65La6s4S98CvINjqSGSRT4WmNtPFxvi9UKvxeh2uFzyzLk/yjpM
         bv0wTo1LUDVfWnhXlL2/LSYrITKQeUJmoviCo+A8Kf9ZHINwi1WqCjoxvI4BlUZD2Di1
         74R7R9awVQWKSB4IYrhaluB5JTLHttxO85f9OQ67NUfPDowCcyXcuBUiDWd11SaHBgpF
         uPzfw1FfhZ2BFAeXgZ3KzTjjbRwYQCxe1RD7SWo0x2n4Nrceo8LrLdciEHlifEeAPI5P
         BZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440540; x=1787045340;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=az0kQBkCe3HjyLYy95RbzTSRcjP/6NeT/w+/aE3wlsg=;
        b=M0BdQIp3emFBznncSbDMRuARYPh+d/y1r16t9mB2VgEXd39l8s+ad/Fe/X6H1F84D7
         LrRjvaP8acS934KX1GUd/cdmMqNzHqIY59RsxS9/3hLWpxNwhI9C9+AOJMBapfVCVuc/
         zaJqf3KW674YyzvK9ZpWIYqRkQSwvrd8a1rZ2f32CcGCzltWd5pr9iXLyfThK1wRAPeR
         tAlMdn8pJ2O3etByrk9n5LRNDyBr6aVeBH4wBNFotp3tMHfUMWqEEGqCcS/HyArUCzwF
         0ge4nGVG9sMsi7/kV1qkve6z/Yt6fRuZ3Lt0WtNA7VVvdUcbV1Lshd2bXNBH7ciqwzLw
         JjNQ==
X-Gm-Message-State: AOJu0YxGeFrXyVFDt+30QZnqRsC5P6urItcJ7s7ECqwT6MBjtsOB5kWh
	IQa1xwyNv0nRXRVUoR1P2BPwcPc9q5/vRE+i0L3tglJjHDa+a5ChambuJgH55Q==
X-Gm-Gg: AR+sD12sysJvcRby9TFJADowxJgIm7nXrK+hng7aR3eekQsgzO+HJh/G19N4kuGLjTx
	Yl5htbGHrycEKrtC1kUeL8Zr6kolAJcO6By5iUiafNiZtk02nRv7d3J60Az4jlyxp0EPvlDXOF3
	HgrH84pXnYyAu/omb7PgLSmX1seqyFo47BG41o4gB/aGZUhYShl/mW86qr8oYBHAgi0z7NkVZz8
	PXu6S9IXWuh6kf3b5QsBkyN0vENKuvgB70BRJd649e9UYVRJBmznPz9o4m5Lo3UrB9a+mCBIkw5
	aelT7pAyc7VaiIzv6/0GfMmD1rHgk7te2jPc3vJNCP+j4UQGQECeMeKiRMP7fVBPaPhnWYvqTSL
	O6xbxpEIZGoJqih6hdiJ3xdau29hBlVSFGQhpaZOzjsXFe2V2kb/mBu/DHnSuOSXt2d5UKxhvnR
	yyKaoLzvpare5Z56vjrNjSi+bGhkP5X/AnNqZ1Qj7kn4neZchXbijTVpmojS1lwzM=
X-Received: by 2002:a17:90b:5286:b0:390:b41a:b92b with SMTP id 98e67ed59e1d1-392ec338de1mr2306190a91.4.1786440539973;
        Tue, 11 Aug 2026 02:28:59 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.196.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392ee2119ffsm1236106a91.5.2026.08.11.02.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:28:59 -0700 (PDT)
Message-Id: <f4bb58fd46ac9f44bb7b2f6caa27c02eb6dac659.1786440533.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Aug 2026 09:28:46 +0000
Subject: [PATCH v8 04/10] t6099: add side-exhaustion regression test
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add t6099 to test the case where multiple merge-base candidates exist
and one is an ancestor of another. This exercises the side-exhaustion
optimization in paint_down_to_common together with the
remove_redundant safety net in get_merge_bases_many_0.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/meson.build                         |  1 +
 t/t6099-merge-base-side-exhaustion.sh | 82 +++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100755 t/t6099-merge-base-side-exhaustion.sh

diff --git a/t/meson.build b/t/meson.build
index a25f37d2f5..655c94f860 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -795,6 +795,7 @@ integration_tests = [
   't6041-bisect-submodule.sh',
   't6050-replace.sh',
   't6060-merge-index.sh',
+  't6099-merge-base-side-exhaustion.sh',
   't6100-rev-list-in-order.sh',
   't6101-rev-parse-parents.sh',
   't6102-rev-list-unexpected-objects.sh',
diff --git a/t/t6099-merge-base-side-exhaustion.sh b/t/t6099-merge-base-side-exhaustion.sh
new file mode 100755
index 0000000000..0e12b5a0b0
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
+   A ----- X
+   |\     /|
+   | B---/ |
+   |  \    |
+   e2  \   f2
+   |   |   |
+   e1  d1  f1
+    \  |  /
+     \ | /
+      \|/
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
-- 
gitgitgadget

