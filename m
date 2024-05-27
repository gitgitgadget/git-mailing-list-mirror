Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC31561FE0
	for <git@vger.kernel.org>; Mon, 27 May 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824527; cv=none; b=Vq+0acIFzUUvWgXGyXzwX9IrY6zj+iPYC4jVfNGnbKZ0KlNDCqr+ZtJCSn42lCi97uXenmJ56y1codAHIPu+nmwPF3cZYP0j3dBdHT+Qvh/dwO6Q4NRJCBcJIQRmuMCr0Ypn7XOfst5X7+pltINUVmldy/TRyDHcMbrtt/EvMsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824527; c=relaxed/simple;
	bh=nnG3eLZogJ5wtCXCjtutiGLTxZx7HY/8kHUpNz9Oez8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UfYa6JnQ0vKSIA4wNubQ3cTLP4VulE8QYC0jdDPD5vVZdaBWGndRKu2XYnuUT+MKB3HDb953X57AiKDf2duBRzlbsWiTuLfrp3Qpsl918GcHiCJeTJudPUOU4sDBnedoRePo+XBc1oUcBbHBeygfnUM61sQPFyeCTSWVACK6kUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUJhmifZ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUJhmifZ"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e719bab882so110311541fa.3
        for <git@vger.kernel.org>; Mon, 27 May 2024 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716824523; x=1717429323; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3qQXcgOINIL7zN+I1qR954vE86/L6T2GnKzsuxYR2o=;
        b=QUJhmifZNfNmp+o2nh+yYCi95xQE0jbm/RpjK8Cmfmx8VV7CG8R68WiqVypiVMNTll
         4HTOc3FzP3LjRJFXI7cnWlmTBct3AMbQe/fkLYSrvbCqfNuehF3DUfPbERz4JNVn4AE4
         aoBZg41lNVwNbg18uMGbR/XFkHwt0eUuPzaXMzXNT8Qg9vZSoPUX5T0PdsJPi7EMxXij
         BxgrdsdyeYFf0i8YoCjAXbWNcjWVDTMx+hHJGl4zB/6elbilisBs/yDwwKWGhkMM2wsO
         wWx1yUY8FKRlkmNlUCf8RPVgrv6EP9FBVovu7BruFdZD+D25cnpyuIi0IvzTd0Q21los
         N3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716824523; x=1717429323;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3qQXcgOINIL7zN+I1qR954vE86/L6T2GnKzsuxYR2o=;
        b=g/SbaVPXLI3NRlkoXkUB1Yk5SEhMfu5mcd5cIq0Ui1xW7C+qOR4EqRi6+s0D53+A8L
         0B97PN/cA7ygwWIt72JJnWcS8etp07QNDkaIJtN/2Cu8OtqFGdD5B/SD8yRDEKW74Vac
         nOaxEDlgjhoR3CXtt++MaWGq+L/8AG/DOaKiV7GDwK8ssWzqAqv3gYz9XY3xcWtAj9rI
         1rNTgdNqwdgALtnohsRsK2U6P70fZ1iB0yyNRH7u1K6tsNYXxOQ+fham6u8O4GcsyIkc
         J1ABG1jKueaW8EAwzKZ396JCMdkSLvSDUCOZZfZmErgCe01L5VT9jEBdqXJ/bhazkbCU
         Yq2A==
X-Gm-Message-State: AOJu0YwUNdQtW/oUkyr1d37wMmL3TtHb5D3ZIYkfa0WG8ni9KW51s/OY
	iEnEZQPx89Mc1InQjmtPWmFwPQ2Om9+OUMfQsHF1YsHp/7SUCeLVj4XVXw==
X-Google-Smtp-Source: AGHT+IGeQxdljboxtJSuZ9WmqEtJoH9xjBCJiIpa7shXS38PPOY48vmTzJlSHWCwpxqDeXJdIi50iA==
X-Received: by 2002:a2e:9f55:0:b0:2e8:5d2:5e8f with SMTP id 38308e7fff4ca-2e95b2875bemr55974461fa.34.1716824523374;
        Mon, 27 May 2024 08:42:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35867d26553sm4438111f8f.116.2024.05.27.08.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 08:42:02 -0700 (PDT)
Message-Id: <c19b8f633cb9f851948b3a17b5425f3310d900d5.1716824518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
	<pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 May 2024 15:41:57 +0000
Subject: [PATCH v3 4/4] unbundle: introduce new option
 UNBUNDLE_FSCK_FOLLOW_FETCH
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

This commit adds a new option `UNBUNDLE_FSCK_FOLLOW_FETCH` to
`unbundle_fsck_flags`, this new flag is currently used in the _fetch_
process by

- `transport.c:fetch_refs_from_bundle` for fetching directly from a
  bundle.
- `bundle-uri.c:unbundle_from_file` for unbundling bundles downloaded
  from bundle-uri.

So we now have a relatively consistent logic for checking objects during
fetching. Add tests for the above two situations are added.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 bundle-uri.c                |  2 +-
 bundle.c                    | 10 +++++++++-
 bundle.h                    |  1 +
 t/t5558-clone-bundle-uri.sh | 36 +++++++++++++++++++++++++++++++-----
 t/t5607-clone-bundle.sh     | 23 +++++++++++++++++++++++
 transport.c                 |  2 +-
 6 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 80f02aac6f1..0da3e5a61b9 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -373,7 +373,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	 * the prerequisite commits.
 	 */
 	if ((result = unbundle(r, &header, bundle_fd, NULL,
-			       VERIFY_BUNDLE_QUIET, UNBUNDLE_FSCK_ALWAYS)))
+			       VERIFY_BUNDLE_QUIET, UNBUNDLE_FSCK_FOLLOW_FETCH)))
 		return 1;
 
 	/*
diff --git a/bundle.c b/bundle.c
index a922d592782..c7344543aa4 100644
--- a/bundle.c
+++ b/bundle.c
@@ -17,6 +17,7 @@
 #include "list-objects-filter-options.h"
 #include "connected.h"
 #include "write-or-die.h"
+#include "fetch-pack.h"
 
 static const char v2_bundle_signature[] = "# v2 git bundle\n";
 static const char v3_bundle_signature[] = "# v3 git bundle\n";
@@ -616,6 +617,7 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	     enum unbundle_fsck_flags fsck_flags)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
+	int fsck_objects = 0;
 
 	if (verify_bundle(r, header, flags))
 		return -1;
@@ -628,13 +630,19 @@ int unbundle(struct repository *r, struct bundle_header *header,
 
 	switch (fsck_flags) {
 	case UNBUNDLE_FSCK_ALWAYS:
-		strvec_push(&ip.args, "--fsck-objects");
+		fsck_objects = 1;
+		break;
+	case UNBUNDLE_FSCK_FOLLOW_FETCH:
+		fsck_objects = fetch_pack_fsck_objects();
 		break;
 	case UNBUNDLE_FSCK_NEVER:
 	default:
 		break;
 	}
 
+	if (fsck_objects)
+		strvec_push(&ip.args, "--fsck-objects");
+
 	if (extra_index_pack_args) {
 		strvec_pushv(&ip.args, extra_index_pack_args->v);
 		strvec_clear(extra_index_pack_args);
diff --git a/bundle.h b/bundle.h
index cfa9daddda6..c46488422ce 100644
--- a/bundle.h
+++ b/bundle.h
@@ -33,6 +33,7 @@ int create_bundle(struct repository *r, const char *path,
 enum unbundle_fsck_flags {
 	UNBUNDLE_FSCK_NEVER = 0,
 	UNBUNDLE_FSCK_ALWAYS,
+	UNBUNDLE_FSCK_FOLLOW_FETCH,
 };
 
 enum verify_bundle_flags {
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index a5b04d6f187..3df4d44e78f 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -19,13 +19,30 @@ test_expect_success 'fail to clone from non-bundle file' '
 
 test_expect_success 'create bundle' '
 	git init clone-from &&
-	git -C clone-from checkout -b topic &&
+	(
+		cd clone-from &&
+		git checkout -b topic &&
+
+		test_commit A &&
+		git bundle create A.bundle topic &&
+
+		test_commit B &&
+		git bundle create B.bundle topic &&
+
+		cat >data <<-EOF &&
+		tree $(git rev-parse HEAD^{tree})
+		parent $(git rev-parse HEAD)
+		author A U Thor
+		committer A U Thor
 
-	test_commit -C clone-from A &&
-	git -C clone-from bundle create A.bundle topic &&
+		commit: this is a commit with bad emails
 
-	test_commit -C clone-from B &&
-	git -C clone-from bundle create B.bundle topic
+		EOF
+		git hash-object --literally -t commit -w --stdin <data >commit &&
+		git branch bad $(cat commit) &&
+		git bundle create bad.bundle bad &&
+		git update-ref -d refs/heads/bad
+	)
 '
 
 test_expect_success 'clone with path bundle' '
@@ -36,6 +53,15 @@ test_expect_success 'clone with path bundle' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone with bad bundle' '
+	git -c fetch.fsckObjects=true clone --bundle-uri="clone-from/bad.bundle" \
+		clone-from clone-bad 2>err &&
+	# Unbundle fails, but clone can still proceed.
+	test_grep "missingEmail" err &&
+	git -C clone-bad for-each-ref --format="%(refname)" >refs &&
+	! grep "refs/bundles/" refs
+'
+
 test_expect_success 'clone with path bundle and non-default hash' '
 	test_when_finished "rm -rf clone-path-non-default-hash" &&
 	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="clone-from/B.bundle" \
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 0d1e92d9963..423b35ac237 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -138,6 +138,29 @@ test_expect_success 'fetch SHA-1 from bundle' '
 	git fetch --no-tags foo/tip.bundle "$(cat hash)"
 '
 
+test_expect_success 'clone bundle with fetch.fsckObjects' '
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
+	test_must_fail git -c fetch.fsckObjects=true \
+		clone bundle-fsck/bad.bundle bundle-fsck-clone 2>err &&
+	test_grep "missingEmail" err
+'
+
 test_expect_success 'git bundle uses expected default format' '
 	git bundle create bundle HEAD^.. &&
 	cat >expect <<-EOF &&
diff --git a/transport.c b/transport.c
index 6799988f10c..a140d4b03c0 100644
--- a/transport.c
+++ b/transport.c
@@ -184,7 +184,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
 	ret = unbundle(the_repository, &data->header, data->fd,
-		       &extra_index_pack_args, 0, UNBUNDLE_FSCK_ALWAYS);
+		       &extra_index_pack_args, 0, UNBUNDLE_FSCK_FOLLOW_FETCH);
 	transport->hash_algo = data->header.hash_algo;
 	return ret;
 }
-- 
gitgitgadget
