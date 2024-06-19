Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1481E878
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 04:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770064; cv=none; b=IVZ6Tf9vrP9PRVTUc0J1CMyH31wpk8XzboTwbY1Q7bKVZGW3CwbCFWwJjswAt1XIawrbqoHFty0i0NyB2woa37XCZNOLjPfducTMHSZ7GmdKggyGL/LnyXUnbHtphJYr3Cwlnx67xesurv7LlQ/SMUdq2TqXFbp9FKD4zaHVhdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770064; c=relaxed/simple;
	bh=goahdHC0bhv79QvkBiNBpJLU2kLpCqLgPvVxKR3y3fc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EyioNCKT2WgBZTPG8CmyqdER2Mb5x5gxrKuG74KhC/Mp5G5TY7SlfIoF4PaCM7mIW+lGsKa5O1UDBG8zRvE9JJM3RWpyvphXthB3DZePpslEltk5ydCa9iN2i5PpuDT56k1wwVE6VZwefolPheqUeNwf9rbSmRXYC59HSGvQIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbt9sTCJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbt9sTCJ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4217136a74dso52235715e9.2
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 21:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718770060; x=1719374860; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rCoptn6/1iOlh1t6aP7j88THCgrCtNgzDRbpN55RYo=;
        b=mbt9sTCJDuQPqSZNLfIx2dWzJqJUwonQNL6o1eJr94gK4PshHo3XTxNTGFsy0etYGi
         1de2B57u4VnQS3ngohfnEMLfeJiewZjivJoGG73WxXoA20eCWfsVz2jkU5fZsepNb2BW
         DJ0AZpm7j8baiMjUC9dAmoygX7yOQHMT98ufGByQVMMTkO2Uy7P1cVGKkCP3oGP0GNGU
         /iykajj9KzI3KwMEStAsysQadgWoe5yCtcFj942oywQqrd9iqxrtV6RhTr8OqjRnJHH5
         o2YJTNTdsyPUWp7lsMftm1q4Tf+DEHkqbUB71J/vUtFfkNHqb1S7TCg/Em+rHqfibvD+
         oejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718770060; x=1719374860;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rCoptn6/1iOlh1t6aP7j88THCgrCtNgzDRbpN55RYo=;
        b=YCCDlzYp/4K1PEexP+f8fuzlmCwOkpC1tSPebOEnr7eNoFOTIuwkLaZsXq9G6Qy4WG
         lUepEeisGU8fdFkh1lYxUB4o13fQBHLg/BIo76Vf8IrC/zxktQ/MMtUK57862NkReXKD
         OHQhLxBcHZ2JpPYzaGwerCO0LczsvpxVUqlvONkCnPuVAjNIjEpUL4XS71AGA3z00uW1
         RgHUTBks5wBSQkejN6uR21j1LQNUddm4numZHbvEf5gNSljPD2L1/AyHLFcmPFkKldDe
         vBQkW9Zl4UAadh59sZqAeoICIfwBlaeb2xS90pNH2WBuHTZ54eOLJLeoUXzKEcQZ2cTT
         hN/A==
X-Gm-Message-State: AOJu0Yx/Jf02yWwUEF72JZWnBAR0fM5zMBYVY9zhSSwqOfYEbf2t/p9q
	QvtlII9lMZpGlfneVVfN2+YLkblRbH3mheQk8yGj4LRfOTeP61OUROzwow==
X-Google-Smtp-Source: AGHT+IGCMhSx6r7cGfEWOT96MOSQ+OcUH3rNUTP3lHtjyuLAntz1RYAScM9O8auEZnhDe71jtacMIQ==
X-Received: by 2002:a7b:cb93:0:b0:421:82ed:28d1 with SMTP id 5b1f17b1804b1-424752a3cbcmr6698705e9.41.1718770059619;
        Tue, 18 Jun 2024 21:07:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4246bddc59bsm74754705e9.5.2024.06.18.21.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 21:07:38 -0700 (PDT)
Message-Id: <698dd6e49b78d1f14c9eda1a1161fe3eff10028e.1718770053.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v8.git.1718770053.gitgitgadget@gmail.com>
References: <pull.1730.v7.git.1718632535.gitgitgadget@gmail.com>
	<pull.1730.v8.git.1718770053.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 04:07:33 +0000
Subject: [PATCH v8 3/3] unbundle: extend object verification for fetches
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

The existing fetch.fsckObjects and transfer.fsckObjects configurations
were not fully applied to bundle-involved fetches, including direct
bundle fetches and bundle-uri enabled fetches. Furthermore, there was no
object verification support for unbundle.

This commit extends object verification support in `bundle.c:unbundle`
by adding the `VERIFY_BUNDLE_FSCK` option to `verify_bundle_flags`. When
this option is enabled, we append the `--fsck-objects` flag to
`git-index-pack`.

The `VERIFY_BUNDLE_FSCK` option is now used by bundle-involved fetches,
where we use `fetch-pack.c:fetch_pack_fsck_objects` to determine whether
to enable this option for `bundle.c:unbundle`, specifically in:

- `transport.c:fetch_refs_from_bundle` for direct bundle fetches.
- `bundle-uri.c:unbundle_from_file` for bundle-uri enabled fetches.

This addition ensures a consistent logic for object verification during
fetches. Tests have been added to confirm functionality in the scenarios
mentioned above.

Reviewed-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 bundle-uri.c                |  3 ++-
 bundle.c                    |  3 +++
 bundle.h                    |  1 +
 t/t5558-clone-bundle-uri.sh | 34 +++++++++++++++++++++++++++++++++-
 t/t5607-clone-bundle.sh     | 35 +++++++++++++++++++++++++++++++++++
 transport.c                 |  3 ++-
 6 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 65666a11d9c..ed9b49fdbc1 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -9,6 +9,7 @@
 #include "hashmap.h"
 #include "pkt-line.h"
 #include "config.h"
+#include "fetch-pack.h"
 #include "remote.h"
 
 static struct {
@@ -373,7 +374,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	 * the prerequisite commits.
 	 */
 	if ((result = unbundle(r, &header, bundle_fd, NULL,
-			       VERIFY_BUNDLE_QUIET)))
+			       VERIFY_BUNDLE_QUIET | (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0))))
 		return 1;
 
 	/*
diff --git a/bundle.c b/bundle.c
index 95367c2d0a0..f124a2a5626 100644
--- a/bundle.c
+++ b/bundle.c
@@ -625,6 +625,9 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	if (header->filter.choice)
 		strvec_push(&ip.args, "--promisor=from-bundle");
 
+	if (flags & VERIFY_BUNDLE_FSCK)
+		strvec_push(&ip.args, "--fsck-objects");
+
 	if (extra_index_pack_args) {
 		strvec_pushv(&ip.args, extra_index_pack_args->v);
 		strvec_clear(extra_index_pack_args);
diff --git a/bundle.h b/bundle.h
index 021adbdcbb3..5ccc9a061a4 100644
--- a/bundle.h
+++ b/bundle.h
@@ -33,6 +33,7 @@ int create_bundle(struct repository *r, const char *path,
 enum verify_bundle_flags {
 	VERIFY_BUNDLE_VERBOSE = (1 << 0),
 	VERIFY_BUNDLE_QUIET = (1 << 1),
+	VERIFY_BUNDLE_FSCK = (1 << 2),
 };
 
 int verify_bundle(struct repository *r, struct bundle_header *header,
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index a0895913fe9..cd05321e176 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -36,7 +36,22 @@ test_expect_success 'create bundle' '
 		sed -e "/^$/q" -e "s/$commit_a /$commit_b /" \
 			<A.bundle >bad-header.bundle &&
 		convert_bundle_to_pack \
-			<A.bundle >>bad-header.bundle
+			<A.bundle >>bad-header.bundle &&
+
+		tree_b=$(git rev-parse B^{tree}) &&
+		cat >data <<-EOF &&
+		tree $tree_b
+		parent $commit_b
+		author A U Thor
+		committer A U Thor
+
+		commit: this is a commit with bad emails
+
+		EOF
+		bad_commit=$(git hash-object --literally -t commit -w --stdin <data) &&
+		git branch bad $bad_commit &&
+		git bundle create bad-object.bundle bad &&
+		git update-ref -d refs/heads/bad
 	)
 '
 
@@ -58,6 +73,23 @@ test_expect_success 'clone with bundle that has bad header' '
 	test_grep ! "refs/bundles/" refs
 '
 
+test_expect_success 'clone with bundle that has bad object' '
+	# Unbundle succeeds if no fsckObjects configured.
+	git clone --bundle-uri="clone-from/bad-object.bundle" \
+		clone-from clone-bad-object-no-fsck &&
+	git -C clone-bad-object-no-fsck for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	test_write_lines refs/bundles/bad >expect &&
+	test_cmp expect actual &&
+
+	# Unbundle fails with fsckObjects set true, but clone can still proceed.
+	git -c fetch.fsckObjects=true clone --bundle-uri="clone-from/bad-object.bundle" \
+		clone-from clone-bad-object-fsck 2>err &&
+	test_grep "missingEmail" err &&
+	git -C clone-bad-object-fsck for-each-ref --format="%(refname)" >refs &&
+	test_grep ! "refs/bundles/" refs
+'
+
 test_expect_success 'clone with path bundle and non-default hash' '
 	test_when_finished "rm -rf clone-path-non-default-hash" &&
 	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="clone-from/B.bundle" \
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 0d1e92d9963..489c6570da5 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -138,6 +138,41 @@ test_expect_success 'fetch SHA-1 from bundle' '
 	git fetch --no-tags foo/tip.bundle "$(cat hash)"
 '
 
+test_expect_success 'clone bundle with different fsckObjects configurations' '
+	test_create_repo bundle-fsck &&
+	(
+		cd bundle-fsck &&
+		test_commit A &&
+		commit_a=$(git rev-parse A) &&
+		tree_a=$(git rev-parse A^{tree}) &&
+		cat >data <<-EOF &&
+		tree $tree_a
+		parent $commit_a
+		author A U Thor
+		committer A U Thor
+
+		commit: this is a commit with bad emails
+
+		EOF
+		bad_commit=$(git hash-object --literally -t commit -w --stdin <data) &&
+		git branch bad $bad_commit &&
+		git bundle create bad.bundle bad
+	) &&
+
+	git clone bundle-fsck/bad.bundle bundle-no-fsck &&
+
+	git -c fetch.fsckObjects=false -c transfer.fsckObjects=true \
+		clone bundle-fsck/bad.bundle bundle-fetch-no-fsck &&
+
+	test_must_fail git -c fetch.fsckObjects=true \
+		clone bundle-fsck/bad.bundle bundle-fetch-fsck 2>err &&
+	test_grep "missingEmail" err &&
+
+	test_must_fail git -c transfer.fsckObjects=true \
+		clone bundle-fsck/bad.bundle bundle-transfer-fsck 2>err &&
+	test_grep "missingEmail" err
+'
+
 test_expect_success 'git bundle uses expected default format' '
 	git bundle create bundle HEAD^.. &&
 	cat >expect <<-EOF &&
diff --git a/transport.c b/transport.c
index 0ad04b77fd2..a93c4171f7b 100644
--- a/transport.c
+++ b/transport.c
@@ -184,7 +184,8 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
 	ret = unbundle(the_repository, &data->header, data->fd,
-		       &extra_index_pack_args, 0);
+		       &extra_index_pack_args,
+		       fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0);
 	transport->hash_algo = data->header.hash_algo;
 	return ret;
 }
-- 
gitgitgadget
