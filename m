Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87A21C189
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609600; cv=none; b=SNy0dKUF2sAYBOxTQsgo5HmGYeLL5Tmaunp3524SNnxRPFdBlRLwE5gM/rk8pjBE6OGtw4AnJILhpTuR7cKQm+riC9nm974WJhhfMgXx+0i/jC2BFehEHqHoa0Jzsxz1PaXCzen+yOiX8jh1c7OLjmAIA/m9rNOMFi6Nq7KLPUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609600; c=relaxed/simple;
	bh=SMn73DjJoJ3dtBuGHvdXj6B0v+5UKqljcj8+HAQcf4E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GubHRpyT7EAsbOBrWjVU+k2hRdZ6A4HJpGsCFZZd503vH5ttqcMdqhzHv5V/adLH/uy2zGUF2My2bQtFQfbBtmfO6XYO/5IO1Z1CQKES0e+PyLVPedutJYxB5txzdxB9A6+0adHibi5mw7iPw1b/9p+5TB5UR1bfwHdS8SZx77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czKTniWq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czKTniWq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso24236865e9.2
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 12:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745609592; x=1746214392; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RmSn7asz7hEC1eT6VuEZptJ+XlXYMloJrpZXIt3DhY=;
        b=czKTniWq48VODNgGdWiTrftwmDhR0ypyHdQn18YNoCtxG8CDplnbwSgDCQthS+cE80
         1YDicuecQMi2IoFsG+MgZkuiGP2eU28en8udgZ+XkRnqIRYnISIncPm8YA9BSK8xOHYi
         Lm476lCpvYKtt24hlNLaUI77S7N9YSa4QXgLCgkIbt0ASWHEU6SvOKDLNba6l28LoTwG
         SxH67RziSYgXyq75rS6hxhfCPZyul4lg+oTVuSnHF2uHscYmAnFPvs2fprCAQl3xe5Gp
         mC2SnYknG4cBtr/hd6V9w2qnXk5wUfiKqG0jZZsChZhqxkiOo0OYwTlUp4ZHvCOvXPF2
         mbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745609592; x=1746214392;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RmSn7asz7hEC1eT6VuEZptJ+XlXYMloJrpZXIt3DhY=;
        b=u0BasxzBK6Dpc9H1xm7TVe/VQNpZvVKzV6p3gmLjQPkBso3GAYZPQ9F+eDx0XunsEr
         I/bY2GZ/2p7GNcPQk5nqzW4whcIRHqlyQlhe9wtsI1slezZcFeyBVxuQIcJCCXJmX5Sc
         MIxswvJog0K/sHuXHlS3KVEy2Q+scusosPLpGnRebKH5o8HmVv86dLoyTWoIl9hYuM6g
         GNIKNpOf5rEMPj3Yg+Twjg/Q/j/lesYvJlRM6Z3tov+HHIMq7d1WTPoZrz6vHC7QBykF
         lhiQYXTV7JPH0UxIZeFra2WGAoQ26sCoUlIPfLsS/OfSLwcWE3tpL9UBAmSbx/Cxy86a
         5ktA==
X-Gm-Message-State: AOJu0YxDKZl8svb/ye4JKUyjqE+yH7xyZvIh5HII+ikK679VvLbKqoe6
	aZfdw6uIOvOKjACEWANuJB5VhYw2GhW8orTC2UROI2sdWiQOYDNz6I3f/A==
X-Gm-Gg: ASbGncufqMR43oLz7n1bJD58u9nP8/K+MVyG9P9MJ7NawmUNl8QbMXvNnwBoKMovBEZ
	q5PA4JEpI7XW6KEawTZGz5gBCr6/3bk1dk4Q/YGh/SRMXXvQOeCAHHhs221ZPcVYLHTEKALmvo+
	sGlWg55bvI4xAtENMmfenoUfvFp9sXvirbgYjqkEZqFG/cIZiKp6csFsIH7tEcvsXyr5mZa7qXj
	6MSh4tHbwfKfIT/+jnryZFoCITVhV0Tw39T/COeM+6LnZIzb39zK6zWJE9mG/74mWUxHRZVgqde
	DOocyprawCL7b5bjJM1cN3sklLFM5kWjiPDUGyQpMA==
X-Google-Smtp-Source: AGHT+IHJacRrj39jy2Ur7EUV/VRd6uLxBmTvsut+4HloUjW3IGi5oTvOvBX9kis6oDXBC0oxVuhxdg==
X-Received: by 2002:a05:600c:ccc:b0:43c:fb95:c752 with SMTP id 5b1f17b1804b1-440ab76a757mr6344245e9.3.1745609592109;
        Fri, 25 Apr 2025 12:33:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5287a94sm34737425e9.0.2025.04.25.12.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:33:11 -0700 (PDT)
Message-Id: <1cbf0787d49ba25454763a2574fd46010e0f6390.1745609589.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v7.git.git.1745609589.gitgitgadget@gmail.com>
References: <pull.1897.v6.git.git.1745609278.gitgitgadget@gmail.com>
	<pull.1897.v7.git.git.1745609589.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Apr 2025 19:33:08 +0000
Subject: [PATCH v7 1/2] bundle-uri: copy all bundle references ino the
 refs/bundle space
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Toon Claes <toon@iotcl.com>,
    Scott Chacon <schacon@gmail.com>,
    Scott Chacon <schacon@gmail.com>

From: Scott Chacon <schacon@gmail.com>

When downloading bundles via the bundle-uri functionality, we only copy the
references from refs/heads into the refs/bundle space. I'm not sure why this
refspec is hardcoded to be so limited, but it makes the ref negotiation on
the subsequent fetch suboptimal, since it won't use objects that are
referenced outside of the current heads of the bundled repository.

This change to copy everything in refs/ in the bundle to refs/bundles/
significantly helps the subsequent fetch, since nearly all the references
are now included in the negotiation.

The update to the bundle-uri unbundling refspec puts all the heads from a
bundle file into refs/bundle/heads instead of directly into refs/bundle/ so
the tests also need to be updated to look in the new heirarchy.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
 Documentation/technical/bundle-uri.adoc |  14 +-
 bundle-uri.c                            |   2 +-
 t/t5558-clone-bundle-uri.sh             | 172 ++++++++++++------------
 3 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/Documentation/technical/bundle-uri.adoc b/Documentation/technical/bundle-uri.adoc
index 91d3a13e327..12283fa9ed5 100644
--- a/Documentation/technical/bundle-uri.adoc
+++ b/Documentation/technical/bundle-uri.adoc
@@ -232,13 +232,13 @@ will interact with bundle URIs according to the following flow:
    are present in the client repository. If some are missing, then the
    client delays unbundling until other bundles have been unbundled,
    making those OIDs present. When all required OIDs are present, the
-   client unbundles that data using a refspec. The default refspec is
-   `+refs/heads/*:refs/bundles/*`, but this can be configured. These refs
-   are stored so that later `git fetch` negotiations can communicate each
-   bundled ref as a `have`, reducing the size of the fetch over the Git
-   protocol. To allow pruning refs from this ref namespace, Git may
-   introduce a numbered namespace (such as `refs/bundles/<i>/*`) such that
-   stale bundle refs can be deleted.
+   client unbundles that data using a refspec. The refspec used is
+   `+refs/*:refs/bundles/*`. These refs are stored so that later
+   `git fetch` negotiations can communicate each bundled ref as a `have`,
+   reducing the size of the fetch over the Git protocol. To allow pruning
+   refs from this ref namespace, Git may introduce a numbered namespace
+   (such as `refs/bundles/<i>/*`) such that stale bundle refs can be
+   deleted.
 
 3. If the file is instead a bundle list, then the client inspects the
    `bundle.mode` to see if the list is of the `all` or `any` form.
diff --git a/bundle-uri.c b/bundle-uri.c
index 96d2ba726d9..dc120664d1e 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -403,7 +403,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 		const char *branch_name;
 		int has_old;
 
-		if (!skip_prefix(refname->string, "refs/heads/", &branch_name))
+		if (!skip_prefix(refname->string, "refs/", &branch_name))
 			continue;
 
 		strbuf_setlen(&bundle_ref, bundle_prefix_len);
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 3816ed5058d..33a7009e9a2 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -58,7 +58,7 @@ test_expect_success 'create bundle' '
 test_expect_success 'clone with path bundle' '
 	git clone --bundle-uri="clone-from/B.bundle" \
 		clone-from clone-path &&
-	git -C clone-path rev-parse refs/bundles/topic >actual &&
+	git -C clone-path rev-parse refs/bundles/heads/topic >actual &&
 	git -C clone-from rev-parse topic >expect &&
 	test_cmp expect actual
 '
@@ -68,9 +68,9 @@ test_expect_success 'clone with bundle that has bad header' '
 	git clone --bundle-uri="clone-from/bad-header.bundle" \
 		clone-from clone-bad-header 2>err &&
 	commit_b=$(git -C clone-from rev-parse B) &&
-	test_grep "trying to write ref '\''refs/bundles/topic'\'' with nonexistent object $commit_b" err &&
+	test_grep "trying to write ref '\''refs/bundles/heads/topic'\'' with nonexistent object $commit_b" err &&
 	git -C clone-bad-header for-each-ref --format="%(refname)" >refs &&
-	test_grep ! "refs/bundles/" refs
+	test_grep ! "refs/bundles/heads/" refs
 '
 
 test_expect_success 'clone with bundle that has bad object' '
@@ -78,8 +78,8 @@ test_expect_success 'clone with bundle that has bad object' '
 	git clone --bundle-uri="clone-from/bad-object.bundle" \
 		clone-from clone-bad-object-no-fsck &&
 	git -C clone-bad-object-no-fsck for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
-	test_write_lines refs/bundles/bad >expect &&
+	grep "refs/bundles/heads/" refs >actual &&
+	test_write_lines refs/bundles/heads/bad >expect &&
 	test_cmp expect actual &&
 
 	# Unbundle fails with fsckObjects set true, but clone can still proceed.
@@ -87,14 +87,14 @@ test_expect_success 'clone with bundle that has bad object' '
 		clone-from clone-bad-object-fsck 2>err &&
 	test_grep "missingEmail" err &&
 	git -C clone-bad-object-fsck for-each-ref --format="%(refname)" >refs &&
-	test_grep ! "refs/bundles/" refs
+	test_grep ! "refs/bundles/heads/" refs
 '
 
 test_expect_success 'clone with path bundle and non-default hash' '
 	test_when_finished "rm -rf clone-path-non-default-hash" &&
 	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="clone-from/B.bundle" \
 		clone-from clone-path-non-default-hash &&
-	git -C clone-path-non-default-hash rev-parse refs/bundles/topic >actual &&
+	git -C clone-path-non-default-hash rev-parse refs/bundles/heads/topic >actual &&
 	git -C clone-from rev-parse topic >expect &&
 	test_cmp expect actual
 '
@@ -102,7 +102,7 @@ test_expect_success 'clone with path bundle and non-default hash' '
 test_expect_success 'clone with file:// bundle' '
 	git clone --bundle-uri="file://$(pwd)/clone-from/B.bundle" \
 		clone-from clone-file &&
-	git -C clone-file rev-parse refs/bundles/topic >actual &&
+	git -C clone-file rev-parse refs/bundles/heads/topic >actual &&
 	git -C clone-from rev-parse topic >expect &&
 	test_cmp expect actual
 '
@@ -173,12 +173,12 @@ test_expect_success 'clone bundle list (file, no heuristic)' '
 	git -C clone-list-file cat-file --batch-check <oids &&
 
 	git -C clone-list-file for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/merge
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/merge
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect actual
 '
@@ -220,10 +220,10 @@ test_expect_success 'clone bundle list (file, all mode, some failures)' '
 	git -C clone-all-some cat-file --batch-check <oids &&
 
 	git -C clone-all-some for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
+	refs/bundles/heads/base
+	refs/bundles/heads/left
 	EOF
 	test_cmp expect actual
 '
@@ -253,7 +253,7 @@ test_expect_success 'clone bundle list (file, all mode, all failures)' '
 	git -C clone-all-fail cat-file --batch-check <oids &&
 
 	git -C clone-all-fail for-each-ref --format="%(refname)" >refs &&
-	! grep "refs/bundles/" refs
+	! grep "refs/bundles/heads/" refs
 '
 
 test_expect_success 'clone bundle list (file, any mode)' '
@@ -282,9 +282,9 @@ test_expect_success 'clone bundle list (file, any mode)' '
 	git -C clone-any-file cat-file --batch-check <oids &&
 
 	git -C clone-any-file for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
+	refs/bundles/heads/base
 	EOF
 	test_cmp expect actual
 '
@@ -313,7 +313,7 @@ test_expect_success 'clone bundle list (file, any mode, all failures)' '
 	git -C clone-any-fail cat-file --batch-check <oids &&
 
 	git -C clone-any-fail for-each-ref --format="%(refname)" >refs &&
-	! grep "refs/bundles/" refs
+	! grep "refs/bundles/heads/" refs
 '
 
 test_expect_success 'negotiation: bundle with part of wanted commits' '
@@ -322,10 +322,10 @@ test_expect_success 'negotiation: bundle with part of wanted commits' '
 	git clone --no-local --bundle-uri="clone-from/A.bundle" \
 		clone-from nego-bundle-part &&
 	git -C nego-bundle-part for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
-	test_write_lines refs/bundles/topic >expect &&
+	grep "refs/bundles/heads/" refs >actual &&
+	test_write_lines refs/bundles/heads/topic >expect &&
 	test_cmp expect actual &&
-	# Ensure that refs/bundles/topic are sent as "have".
+	# Ensure that refs/bundles/heads/topic are sent as "have".
 	tip=$(git -C clone-from rev-parse A) &&
 	test_grep "clone> have $tip" trace-packet.txt
 '
@@ -337,8 +337,8 @@ test_expect_success 'negotiation: bundle with all wanted commits' '
 		--bundle-uri="clone-from/B.bundle" \
 		clone-from nego-bundle-all &&
 	git -C nego-bundle-all for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
-	test_write_lines refs/bundles/topic >expect &&
+	grep "refs/bundles/heads/" refs >actual &&
+	test_write_lines refs/bundles/heads/topic >expect &&
 	test_cmp expect actual &&
 	# We already have all needed commits so no "want" needed.
 	test_grep ! "clone> want " trace-packet.txt
@@ -363,13 +363,13 @@ test_expect_success 'negotiation: bundle list (no heuristic)' '
 		clone-from nego-bundle-list-no-heuristic &&
 
 	git -C nego-bundle-list-no-heuristic for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
+	refs/bundles/heads/base
+	refs/bundles/heads/left
 	EOF
 	test_cmp expect actual &&
-	tip=$(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/left) &&
+	tip=$(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/heads/left) &&
 	test_grep "clone> have $tip" trace-packet.txt
 '
 
@@ -395,13 +395,13 @@ test_expect_success 'negotiation: bundle list (creationToken)' '
 		clone-from nego-bundle-list-heuristic &&
 
 	git -C nego-bundle-list-heuristic for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
+	refs/bundles/heads/base
+	refs/bundles/heads/left
 	EOF
 	test_cmp expect actual &&
-	tip=$(git -C nego-bundle-list-heuristic rev-parse refs/bundles/left) &&
+	tip=$(git -C nego-bundle-list-heuristic rev-parse refs/bundles/heads/left) &&
 	test_grep "clone> have $tip" trace-packet.txt
 '
 
@@ -428,10 +428,10 @@ test_expect_success 'negotiation: bundle list with all wanted commits' '
 		clone-from nego-bundle-list-all &&
 
 	git -C nego-bundle-list-all for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
+	refs/bundles/heads/base
+	refs/bundles/heads/left
 	EOF
 	test_cmp expect actual &&
 	# We already have all needed commits so no "want" needed.
@@ -465,7 +465,7 @@ test_expect_success 'clone HTTP bundle' '
 
 	git clone --bundle-uri="$HTTPD_URL/B.bundle" \
 		"$HTTPD_URL/smart/fetch.git" clone-http &&
-	git -C clone-http rev-parse refs/bundles/topic >actual &&
+	git -C clone-http rev-parse refs/bundles/heads/topic >actual &&
 	git -C clone-from rev-parse topic >expect &&
 	test_cmp expect actual &&
 
@@ -476,7 +476,7 @@ test_expect_success 'clone HTTP bundle with non-default hash' '
 	test_when_finished "rm -rf clone-http-non-default-hash" &&
 	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="$HTTPD_URL/B.bundle" \
 		"$HTTPD_URL/smart/fetch.git" clone-http-non-default-hash &&
-	git -C clone-http-non-default-hash rev-parse refs/bundles/topic >actual &&
+	git -C clone-http-non-default-hash rev-parse refs/bundles/heads/topic >actual &&
 	git -C clone-from rev-parse topic >expect &&
 	test_cmp expect actual
 '
@@ -553,12 +553,12 @@ test_expect_success 'clone bundle list (HTTP, any mode)' '
 	git -C clone-any-http cat-file --batch-check <oids &&
 
 	git -C clone-list-file for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/merge
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/merge
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect actual
 '
@@ -641,9 +641,9 @@ test_expect_success 'clone incomplete bundle list (http, creationToken)' '
 	test_cmp expect actual &&
 
 	# We now have only one bundle ref.
-	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
+	refs/bundles/heads/base
 	EOF
 	test_cmp expect refs &&
 
@@ -679,13 +679,13 @@ test_expect_success 'clone incomplete bundle list (http, creationToken)' '
 	test_cmp expect actual &&
 
 	# We now have all bundle refs.
-	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/merge
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/merge
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect refs
 '
@@ -721,9 +721,9 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 	test_cmp expect actual &&
 
 	# only received base ref from bundle-1
-	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
+	refs/bundles/heads/base
 	EOF
 	test_cmp expect refs &&
 
@@ -749,10 +749,10 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 	test_cmp expect actual &&
 
 	# received left from bundle-2
-	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
+	refs/bundles/heads/base
+	refs/bundles/heads/left
 	EOF
 	test_cmp expect refs &&
 
@@ -795,12 +795,12 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 
 	# received merge ref from bundle-4, but right is missing
 	# because we did not download bundle-3.
-	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/merge
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/merge
 	EOF
 	test_cmp expect refs &&
 
@@ -862,7 +862,7 @@ test_expect_success 'creationToken heuristic with failed downloads (clone)' '
 	test_cmp expect actual &&
 
 	# All bundles failed to unbundle
-	git -C download-1 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C download-1 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	test_must_be_empty refs &&
 
 	# Case 2: middle bundle does not exist, only two bundles can unbundle
@@ -909,10 +909,10 @@ test_expect_success 'creationToken heuristic with failed downloads (clone)' '
 	test_cmp expect actual &&
 
 	# bundle-1 and bundle-3 could unbundle, but bundle-4 could not
-	git -C download-2 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C download-2 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-EOF &&
-	refs/bundles/base
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect refs &&
 
@@ -961,11 +961,11 @@ test_expect_success 'creationToken heuristic with failed downloads (clone)' '
 	test_cmp expect actual &&
 
 	# fake.bundle did not unbundle, but the others did.
-	git -C download-3 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C download-3 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect refs
 '
@@ -1083,15 +1083,15 @@ test_expect_success 'creationToken heuristic with failed downloads (fetch)' '
 	test_cmp expect actual &&
 
 	# Check which bundles have unbundled by refs
-	git -C fetch-1 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-1 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/lefter
-	refs/bundles/merge
-	refs/bundles/right
-	refs/bundles/righter
-	refs/bundles/top
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/lefter
+	refs/bundles/heads/merge
+	refs/bundles/heads/right
+	refs/bundles/heads/righter
+	refs/bundles/heads/top
 	EOF
 	test_cmp expect refs &&
 
@@ -1144,12 +1144,12 @@ test_expect_success 'creationToken heuristic with failed downloads (fetch)' '
 	test_cmp expect actual &&
 
 	# Check which bundles have unbundled by refs
-	git -C fetch-2 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-2 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/merge
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/merge
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect refs &&
 
@@ -1204,13 +1204,13 @@ test_expect_success 'creationToken heuristic with failed downloads (fetch)' '
 	test_cmp expect actual &&
 
 	# Check which bundles have unbundled by refs
-	git -C fetch-3 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-3 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/lefter
-	refs/bundles/right
-	refs/bundles/righter
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/lefter
+	refs/bundles/heads/right
+	refs/bundles/heads/righter
 	EOF
 	test_cmp expect refs
 '
-- 
gitgitgadget

