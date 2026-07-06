Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1CB376467
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344962; cv=none; b=O4AVaNOQUtSjtkeMN/0Z44VhKgVYQKd5bwbKqSw+eyHQOF2Pc4zwZwOTfrzSKtC+j4B5tEScpV10na7v98XJGvh0zX6gXs1dKxqy+YxeASFzMQVB9t2rycm33uW8zY+sP0YLyq1LWW/WcqRXyaQCLqf/ZVgVRmpLhbtnwIFNh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344962; c=relaxed/simple;
	bh=bSAePSVUYaMnEFiiBuUIbqzUA59ucBmKnmMrDv0y2ew=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lw+fP+IYVf3AG1F8aV+wvSoRLVClNG+htnbHp4Q9FIky35KfnANpVBzQKmtFk/Vi+Aj/tQMT7sbuOG9lq0L/J/vPKtvlMfiKIrEU2ARmBHyqFDNjgEjVgWdHgL71ZXmhDLnbVQzCD5BOw5RPOXGQu9u0nt/wJvWqSOdK7Cai2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDEL2REL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDEL2REL"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-842338c18e0so2433720b3a.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 06:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783344961; x=1783949761; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDZnBjxenYaBJjk8uCNqihPL3xm61Nnoj2j6p7G+3PY=;
        b=RDEL2RELwBRWM25/rhyeXmPiWkN0NLZrasIazRYXxsSpxRGRzT02Y8/XOf/yQES2sf
         i8LSDj3iY34x+pnk+8Ntc0dhNlgwbfwLH9UzaJe6+vII9V3UfN9mFYGY8z9vGJQa/U6C
         gT/JIIQjInQ0PGSYMQ5oMVavvlxMASY/OaM63XlcoTTJJCEKyhIzumE3OMFci15LB61I
         F//ilVSG7ij1S0aRENJICAHqaXnWraSpZMjlBCHPH3LHc1G2s+TsjO+UlX6EWfrbrN0o
         +GS0wT5lvi40j0q9VMLw/vDC5jh0SDne5qWGhM998ok9luumYh/+IRMsAvuyPYsvc8Qg
         Qcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344961; x=1783949761;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GDZnBjxenYaBJjk8uCNqihPL3xm61Nnoj2j6p7G+3PY=;
        b=X+Ryw1YJB7vNPETomYAEC9jcNuqI9xNTV3kdMpfWQBfw+KMAEVhk38lkLAKwEGS8S/
         VoJwk4F434z6hTLOWSZpva++LjE/EDv+d2Sis58w7UkMeEG6NlewyPQ8YY0HLegsxzhL
         dIQLuhdu9t3PHdeBiHDC2NUw/LjCOvIwvLKf7Ek32yKvNbLQyeHlKCFBvLkc2RDjnZuV
         4sJMmZDSoA22SRat6yoVdodySHkEXKDpvYNJMrypGm1y683/689uuEN6y6c+yf1HVu3b
         +rD/3OyZfhLc0LkfhyC8AYFE/I0nR4k0hKiOi5oJYZ6RAvpWQQ+B38ozwl70Bwa/bNbx
         8oTQ==
X-Gm-Message-State: AOJu0Yw802FvUjSaEA9X3d2qPDl+WqV6tJyM/NizY0CiTizCRna7apE2
	obp/V3Xa92+ssRJ5Fe5AEQxYKxJKctSJzbE+S8nka7CQsyCJNDLi+83TS5U2kA==
X-Gm-Gg: AfdE7cnjVFDc8kDi/cIb6gC0BC0ybQ5sY+athdMHdYgxa9qpc+Hg9rQcTMcKdeVDRuu
	yvvc9YQBWXB3A2hm+Ew57oqSPvmHM6Ij68/iYjJsmFqFutSDZ1epMh0Oieuq7yu+p9wcWEGBNGq
	z2QMA2+5Z3nOxkYQjm/8PTx1D16wcXaN6gEt481LztTnKUoRmP1skBVagyRNvXTvI58fGlD+mpM
	eTpI6Rk2jxPQecobkrUXHe3TIyP8EZJPqWUviJxoVkrtLGzg8w+WnunN6wWITeuv+ZG3dJ5a01d
	2j2sb0D/TE+lMffZGlH2B2QtHME5Umzzy7zNMDKgof5B7Vu/4RGBQY8HVGf0ZHvhFWRPLMPbIso
	uWwpycg5pqvW4k9hLt46UTfr2f5MLs275ffZqC6kE33Az9RLP0dZHeNAKiOiQjCUI1IaDE0v5W4
	AY8ejkceAGIM93
X-Received: by 2002:a05:6a00:32ce:b0:842:614e:cc94 with SMTP id d2e1a72fcca58-84826d69104mr519926b3a.26.1783344960640;
        Mon, 06 Jul 2026 06:36:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.42.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dd3bd3sm3836310b3a.58.2026.07.06.06.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:35:59 -0700 (PDT)
Message-Id: <d8ffdcb4f8c1988c109761ddb9daff8c07caa2b1.1783344957.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
References: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 13:35:55 +0000
Subject: [PATCH 1/2] t: add tests for ref tombstone scenarios
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

Add a performance test and a correctness test for update-ref when
many tombstones are present in a reftable.

The performance test (p1401) exercises two scenarios:

 - All refs are deleted (creating tombstones) and then re-created
   with the same names, which currently exhibits quadratic behavior.

 - An asymmetric variant where refs are deleted and then new,
   differently-named refs are created.  When the tombstones sort
   after the new refs, every create scans all tombstones, making
   this case even worse than re-creating the same refs.

The correctness test (t0610) verifies that refs deleted and then
re-created with the same names are visible afterwards.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/perf/p1401-ref-store-tombstones.sh | 44 ++++++++++++++++++++++++++++
 t/t0610-reftable-basics.sh           | 22 ++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100755 t/perf/p1401-ref-store-tombstones.sh

diff --git a/t/perf/p1401-ref-store-tombstones.sh b/t/perf/p1401-ref-store-tombstones.sh
new file mode 100755
index 0000000000..e40a6dcbf4
--- /dev/null
+++ b/t/perf/p1401-ref-store-tombstones.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description="Tests performance of ref operations with many tombstones"
+
+. ./perf-lib.sh
+
+test_expect_success "setup" '
+	git init --ref-format=reftable repo &&
+	blob=$(echo foo | git -C repo hash-object -w --stdin) &&
+	for i in $(test_seq 8000)
+	do
+		printf "create refs/tags/tag-%d %s\n" "$i" "$blob" ||
+		return 1
+	done >repo/input &&
+	git -C repo update-ref --stdin <repo/input &&
+	git -C repo for-each-ref --format="delete %(refname)" |
+	git -C repo update-ref --stdin
+'
+
+test_perf "recreate refs after mass delete" '
+	git -C repo update-ref --stdin <repo/input &&
+	git -C repo for-each-ref --format="delete %(refname)" |
+	git -C repo update-ref --stdin
+'
+
+test_expect_success "setup asymmetric" '
+	for i in $(test_seq 8000)
+	do
+		printf "create refs/tags/old-%d %s\n" "$i" "$blob" ||
+		return 1
+	done >repo/input-old &&
+	sed "s/old-/new-/" <repo/input-old >repo/input-new &&
+	git -C repo update-ref --stdin <repo/input-old &&
+	git -C repo for-each-ref --format="delete %(refname)" |
+	git -C repo update-ref --stdin
+'
+
+test_perf "create new refs after deleting differently-named refs" '
+	git -C repo update-ref --stdin <repo/input-new &&
+	git -C repo for-each-ref --format="delete %(refname)" |
+	git -C repo update-ref --stdin
+'
+
+test_done
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index e19e036898..4b7cfe38e4 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -1163,4 +1163,26 @@ test_expect_success 'writes do not persist peeled value for invalid tags' '
 	)
 '
 
+test_expect_success 'delete and re-create refs with tombstones' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo A &&
+	A=$(git -C repo rev-parse HEAD) &&
+	cat >input <<-EOF &&
+	create refs/tags/a $A
+	create refs/tags/b $A
+	create refs/tags/c $A
+	EOF
+	git -C repo update-ref --stdin <input &&
+
+	# delete all tags, leaving tombstones
+	git -C repo for-each-ref --format="delete %(refname)" refs/tags/ |
+	git -C repo update-ref --stdin &&
+
+	# re-create the same refs and verify they are visible
+	git -C repo update-ref --stdin <input &&
+	git -C repo tag -l >actual &&
+	test_line_count = 3 actual
+'
+
 test_done
-- 
gitgitgadget

