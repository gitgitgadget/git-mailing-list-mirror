Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261817C7A0
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718109952; cv=none; b=ANMH8ZcBcfWmxNlgjoewFNXV3RzdRZvFBD2r0rB7NyVXwijIZQchmKtCa/VUQi94Sf7N1Y3SbUQn3JF6gRR64CHijMk4MaW90bFcvfLPlJVGUow8K3BTdSe90S8uHhWk+2WtnTm3Zb9EAsv5a11jxVWw4CR9VSV8rrz5qF1ZCEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718109952; c=relaxed/simple;
	bh=MQAmDmdLFtzm6uIphB83Fr6w7JM9XjgWCxq18ZdB9z8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A0TaW9/IU+yU00mFD5vqR4ZmnA6DP/LmEL/JB5n0eNGSRfOwmtEPisICWfyPXWp0rZMXeoScXNfv/aTZHsM1KmOup50vldwFTfLP/QkoT9qAXdg6qUgy6bvxi72QyPTbMh0gfxoTcR16aD3b6lzRCPdmQfj7MQ5Mva3rzU0SCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frh13K+J; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frh13K+J"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f1691b18fso2596829f8f.2
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718109948; x=1718714748; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps2PkO+ufur1AheMByzs56ajwJMHtiSGZcmxrMvdet0=;
        b=frh13K+JJ9C6gQW99B/Qu2dtu8EoBj7DeqCHAZ6xyOHVZcu1k+gwtZfZliqh3Uz3ZX
         BLzkXTPYJ6hwlrgRG1t6C/sUyiSvZWP1a/CVObIaWs9VL4ut+LnAIZmxq2tQOTmJuI5N
         argbMYA1GRfVyMGL0zUgxLR0kRVkPwh8jn3f/WVfnPOFResN1SCjynjQortXio5TC84I
         IOhTkiNTK1kSHT7yZFfDiSSa8+04Ie9HJ07KM2DlX9KY6AZioxkiy2LdevdQaz9iDM5C
         E2i/hsZ7cmIerWaC+aJFh+iHGxj2JljsD6CHOsM+dDbddOZEZRLPrmoPOwIhutlS5BFj
         3SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718109948; x=1718714748;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ps2PkO+ufur1AheMByzs56ajwJMHtiSGZcmxrMvdet0=;
        b=iiqgqhE4bh8k3/7qy/YvNZWZbPnGRZRaNOlulJQ1LxNMW3E7wh9Agb6oIRfr+soIuE
         f0UylKdsEIwOzmzpZY+3dpopflvI9mpAJ+/a4re/dVobKbhqgS2EF8ViRNrWrVWVaoVb
         W1mcf7cRxI8Fi4U5Jsu1wV3yq8bkql/FJSoaNUklwf/tpFPijGAF66zOAICuD02gUcvR
         agts4IaLc8HU/6QMwHsXT8O5lk2TUmmcpQORgG8LJrvyfF6jOomQjtTCsv+N5LtK3OlG
         mLvrTs32LPxDqzmp4ObbsLC1Uk/vMzz+nuDMT7C1WQEdbmBsMueglCAd1/awDUiRrWm+
         nKbg==
X-Gm-Message-State: AOJu0YxbzyZJunVjKamidfwaxVXuj3NliOalme/nwa04H/70CuI7KtfN
	bHe63b++7yTrobNSZyVNZfK9ZqVT12YSkzrjMWhO1m+M+PgMLISi8TCiEw==
X-Google-Smtp-Source: AGHT+IHx76/6p/c5YYTvpAJfzLwkFNkxF6mqXLsvWgcFVfLctCCL7Yvq0kAIqMj+J6Ox80HFDJ+JkQ==
X-Received: by 2002:a5d:480b:0:b0:35f:2552:15bc with SMTP id ffacd0b85a97d-35f2552177dmr3894067f8f.49.1718109947908;
        Tue, 11 Jun 2024 05:45:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f16c8ded8sm8787419f8f.31.2024.06.11.05.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 05:45:47 -0700 (PDT)
Message-Id: <53395e8c08a8487f3e53dca15766307854a24b3b.1718109943.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>
References: <pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
	<pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 12:45:43 +0000
Subject: [PATCH v6 3/3] unbundle: support object verification for fetches
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

This commit extends object verification support for fetches in
`bundle.c:unbundle` by adding the `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH`
option to `verify_bundle_flags`. When this option is enabled,
`bundle.c:unbundle` invokes `fetch-pack.c:fetch_pack_fsck_objects` to
determine whether to append the "--fsck-objects" flag to
"git-index-pack".

`VERIFY_BUNDLE_FSCK_FOLLOW_FETCH` is now passed to `unbundle` in the
fetching process, including:

- `transport.c:fetch_refs_from_bundle` for direct bundle fetches.
- `bundle-uri.c:unbundle_from_file` for bundle-uri enabled fetches.

This addition ensures a consistent logic for object verification during
fetch operations. Tests have been added to confirm functionality in the
scenarios mentioned above.

Reviewed-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 bundle-uri.c                |  2 +-
 bundle.c                    |  5 +++++
 bundle.h                    |  1 +
 t/t5558-clone-bundle-uri.sh | 35 ++++++++++++++++++++++++++++++++++-
 t/t5607-clone-bundle.sh     | 33 +++++++++++++++++++++++++++++++++
 transport.c                 |  2 +-
 6 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 65666a11d9c..e7ebac6ce57 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -373,7 +373,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	 * the prerequisite commits.
 	 */
 	if ((result = unbundle(r, &header, bundle_fd, NULL,
-			       VERIFY_BUNDLE_QUIET)))
+			       VERIFY_BUNDLE_QUIET | VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)))
 		return 1;
 
 	/*
diff --git a/bundle.c b/bundle.c
index 95367c2d0a0..20bbfffbb43 100644
--- a/bundle.c
+++ b/bundle.c
@@ -17,6 +17,7 @@
 #include "list-objects-filter-options.h"
 #include "connected.h"
 #include "write-or-die.h"
+#include "fetch-pack.h"
 
 static const char v2_bundle_signature[] = "# v2 git bundle\n";
 static const char v3_bundle_signature[] = "# v3 git bundle\n";
@@ -625,6 +626,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	if (header->filter.choice)
 		strvec_push(&ip.args, "--promisor=from-bundle");
 
+	if (flags & VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)
+		if (fetch_pack_fsck_objects())
+			strvec_push(&ip.args, "--fsck-objects");
+
 	if (extra_index_pack_args) {
 		strvec_pushv(&ip.args, extra_index_pack_args->v);
 		strvec_clear(extra_index_pack_args);
diff --git a/bundle.h b/bundle.h
index 021adbdcbb3..545df6e9d40 100644
--- a/bundle.h
+++ b/bundle.h
@@ -33,6 +33,7 @@ int create_bundle(struct repository *r, const char *path,
 enum verify_bundle_flags {
 	VERIFY_BUNDLE_VERBOSE = (1 << 0),
 	VERIFY_BUNDLE_QUIET = (1 << 1),
+	VERIFY_BUNDLE_FSCK_FOLLOW_FETCH = (1 << 2),
 };
 
 int verify_bundle(struct repository *r, struct bundle_header *header,
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 8f4f802e4f1..48be1b18802 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -30,7 +30,21 @@ test_expect_success 'create bundle' '
 		git bundle create B.bundle topic &&
 
 		# Create a bundle with reference pointing to non-existent object.
-		sed "s/$(git rev-parse A)/$(git rev-parse B)/" <A.bundle >bad-header.bundle
+		sed "s/$(git rev-parse A)/$(git rev-parse B)/" <A.bundle >bad-header.bundle &&
+
+		cat >data <<-EOF &&
+		tree $(git rev-parse HEAD^{tree})
+		parent $(git rev-parse HEAD)
+		author A U Thor
+		committer A U Thor
+
+		commit: this is a commit with bad emails
+
+		EOF
+		git hash-object --literally -t commit -w --stdin <data >commit &&
+		git branch bad $(cat commit) &&
+		git bundle create bad-object.bundle bad &&
+		git update-ref -d refs/heads/bad
 	)
 '
 
@@ -52,6 +66,25 @@ test_expect_success 'clone with bundle that has bad header' '
 	! grep "refs/bundles/" refs
 '
 
+test_expect_success 'clone with bundle that has bad object' '
+	# Unbundle succeeds if no fsckObjects confugured.
+	git clone --bundle-uri="clone-from/bad-object.bundle" \
+		clone-from clone-bad-object-no-fsck &&
+	git -C clone-bad-object-no-fsck for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/bad
+	EOF
+	test_cmp expect actual &&
+
+	# Unbundle fails with fsckObjects set true, but clone can still proceed.
+	git -c fetch.fsckObjects=true clone --bundle-uri="clone-from/bad-object.bundle" \
+		clone-from clone-bad-object-fsck 2>err &&
+	test_grep "missingEmail" err &&
+	git -C clone-bad-object-fsck for-each-ref --format="%(refname)" >refs &&
+	! grep "refs/bundles/" refs
+'
+
 test_expect_success 'clone with path bundle and non-default hash' '
 	test_when_finished "rm -rf clone-path-non-default-hash" &&
 	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="clone-from/B.bundle" \
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 0d1e92d9963..5182efc0b45 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -138,6 +138,39 @@ test_expect_success 'fetch SHA-1 from bundle' '
 	git fetch --no-tags foo/tip.bundle "$(cat hash)"
 '
 
+test_expect_success 'clone bundle with different fsckObjects configurations' '
+	test_create_repo bundle-fsck &&
+	(
+		cd bundle-fsck &&
+		test_commit first &&
+		cat >data <<-EOF &&
+		tree $(git rev-parse HEAD^{tree})
+		parent $(git rev-parse HEAD)
+		author A U Thor
+		committer A U Thor
+
+		commit: this is a commit with bad emails
+
+		EOF
+		git hash-object --literally -t commit -w --stdin <data >commit &&
+		git branch bad $(cat commit) &&
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
index 0ad04b77fd2..6cd5683bb45 100644
--- a/transport.c
+++ b/transport.c
@@ -184,7 +184,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
 	ret = unbundle(the_repository, &data->header, data->fd,
-		       &extra_index_pack_args, 0);
+		       &extra_index_pack_args, VERIFY_BUNDLE_FSCK_FOLLOW_FETCH);
 	transport->hash_algo = data->header.hash_algo;
 	return ret;
 }
-- 
gitgitgadget
