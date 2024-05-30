Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2A1C6A3
	for <git@vger.kernel.org>; Thu, 30 May 2024 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057297; cv=none; b=Op+3ncUlSKTKdrok5vC4EKNJwNotstLu4lBoebeefsdK6hrEJxw0N/naWWvKVIKsQx6gROJMi3LL+OzXMrbmp+31cnAXm+gcFGh6AqA39J1mhcmcafeKgT/63KfIroCoOVI7eOsUX4+DQ8B/fzPMDgneKfAGD+gUsn9HuRAgsrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057297; c=relaxed/simple;
	bh=/tENE3Kgl1cYhu0N5e4hM8lvQ9F5tFHbMwVAioiliyY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sjSKY+O72BikTvOBGS8CjrTOh9RizgB9NvwzDiXCcKjLHuaCbdHTLgP2pOndHGFT9ltmGS4HAhVNs3cf2f/XMwLNjZJmrlWrtgWxBj0XA7gibFVon8lhudxuu4LPf3jJ5xteM/XKQbtdWRNIKCCq7Db1IMtD/XQdOtfEjATtgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atlhm7pK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atlhm7pK"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-354fb2d8f51so601183f8f.3
        for <git@vger.kernel.org>; Thu, 30 May 2024 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717057293; x=1717662093; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1vTJEyiG2vXL6cdAMlKLrLvnBGFQoqjVV/+UtqDT8E=;
        b=atlhm7pKGbDMFRqI1Uq/bRXjfm/O5GcZJZ8Nei2D7iJ5ydmrPJxkt/7fm2o0Vdq2l2
         Ynf/XqdpAN/26fTpfN8UEJ+4DTwRsSrpdjbI8hH447MZoayfI4CHfKOA4n4MGuADWZw8
         Q669PqO5hup6gszg43v46mFU7a0RCsCIJ4AVyYGncbLzqSZXWcoF4ZbMp7pEeHajuH1i
         VV1oWUhINHcOVy4SqnZdME8P0R1boEbaia5bJMQUHsptGXRkXd1GLPYUl6mHcNfsEhef
         DlNP46+hj/1bbdQ3TC87jaX6fFy70mNAOqmKwnOow+pzea80fw4T9mX6HnsXNr8WyrLp
         ZHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717057293; x=1717662093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1vTJEyiG2vXL6cdAMlKLrLvnBGFQoqjVV/+UtqDT8E=;
        b=i3WNaoeO5OmWxcZJqIwVJhP6tlv71KuVUw5FtJOKRaHR5yIZjfRY2Et24aPKOmhQLF
         gpykV7JiF0VuqeEq+v7e3EJr2VBtpe8p5cKzguxwyZQ3f4hhbtR2hyd17jjOK1b371rd
         qgvrCkZrN5ui0Ll3ORZCm7sLSTXxXqXATOb+v884NppR/JutkCspc/qcJRkZWhVD7rzn
         PIslFmogbKgql8j9ESAGxhR6bmQ+/I0bGkAQGZlC6Rlzg2Z5MLvdMl4mry3J7Db+TdWM
         Jx3Kh3gWY6REyf/QXrV0GYqDHUzMDr0LBApMxrBBBcWQbuauZa9xvpTCI9qGmKaknqqJ
         vA6w==
X-Gm-Message-State: AOJu0YzWjI4rEZ7pztR34DA3le97gGHUbR2p08OyIxfts6iCwDUQZb2/
	j+HW6dmSFVMMgmQGcX3LGx8WEr/1QoT2UOlKnAG7plZ+hKwrAH495yf/jQ==
X-Google-Smtp-Source: AGHT+IE4aQWpnoYYbfIqbqXTKDjXCJGKD9UUCx3Mj9//TccgWlqbgt5MUBiJmHwbAVGUBwc1fOUUNg==
X-Received: by 2002:a5d:5146:0:b0:355:673:dd95 with SMTP id ffacd0b85a97d-35dc009f5bemr914419f8f.38.1717057293269;
        Thu, 30 May 2024 01:21:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557dcf03f0sm16852833f8f.98.2024.05.30.01.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 01:21:32 -0700 (PDT)
Message-Id: <e958a3ab20c0c06f52a00038f39605f14302032a.1717057290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
References: <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
	<pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 May 2024 08:21:27 +0000
Subject: [PATCH v4 1/4] bundle-uri: verify oid before writing refs
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

When using the bundle-uri mechanism with a bundle list containing
multiple interrelated bundles, we encountered a bug where tips from
downloaded bundles were not discovered, thus resulting in rather slow
clones. This was particularly problematic when employing the
"creationTokens" heuristic.

To reproduce this issue, consider a repository with a single branch
"main" pointing to commit "A". Firstly, create a base bundle with:

  git bundle create base.bundle main

Then, add a new commit "B" on top of "A", and create an incremental
bundle for "main":

  git bundle create incr.bundle A..main

Now, generate a bundle list with the following content:

  [bundle]
      version = 1
      mode = all
      heuristic = creationToken

  [bundle "base"]
      uri = base.bundle
      creationToken = 1

  [bundle "incr"]
      uri = incr.bundle
      creationToken = 2

A fresh clone with the bundle list above should result in a reference
"refs/bundles/main" pointing to "B" in the new repository. However, git
would still download everything from the server, as if it had fetched
nothing locally.

So why the "refs/bundles/main" is not discovered? After some digging I
found that:

1. Bundles in bundle list are downloaded to local files via
   `bundle-uri.c:download_bundle_list` or via
   `bundle-uri.c:fetch_bundles_by_token` for the "creationToken"
   heuristic.
2. Each bundle is unbundled via `bundle-uri.c:unbundle_from_file`, which
   is called by `bundle-uri.c:unbundle_all_bundles` or called within
   `bundle-uri.c:fetch_bundles_by_token` for the "creationToken"
   heuristic.
3. To get all prerequisites of the bundle, the bundle header is read
   inside `bundle-uri.c:unbundle_from_file` to by calling
   `bundle.c:read_bundle_header`.
4. Then it calls `bundle.c:unbundle`, which calls
   `bundle.c:verify_bundle` to ensure the repository contains all the
   prerequisites.
5. `bundle.c:verify_bundle` calls `parse_object`, which eventually
   invokes `packfile.c:prepare_packed_git` or
   `packfile.c:reprepare_packed_git`, filling
   `raw_object_store->packed_git` and setting `packed_git_initialized`.
6. If `bundle.c:unbundle` succeeds, it writes refs via
   `refs.c:refs_update_ref` with `REF_SKIP_OID_VERIFICATION` set. Here
   bundle refs which can target arbitrary objects are written to the
   repository.
7. Finally, in `fetch-pack.c:do_fetch_pack_v2`, the functions
   `fetch-pack.c:mark_complete_and_common_ref` and
   `fetch-pack.c:mark_tips` are called with `OBJECT_INFO_QUICK` set to
   find local tips for negotiation. The `OBJECT_INFO_QUICK` flag
   prevents `packfile.c:reprepare_packed_git` from being called,
   resulting in failures to parse OIDs that reside only in the latest
   bundle.

In the example above, when unbunding "incr.bundle", "base.pack" is added
to `packed_git` due to prerequisites verification. However, "B" cannot
be found for negotiation because it exists in "incr.pack", which is not
included in `packed_git`.

This commit fixes the bug by removing `REF_SKIP_OID_VERIFICATION` flag
when writing bundle refs. When `refs.c:refs_update_ref` is called to to
write the corresponding bundle refs, it triggers
`refs.c:ref_transaction_commit`.  This, in turn, invokes
`refs.c:ref_transaction_prepare`, which calls `transaction_prepare` of
the refs storage backend. For files backend, this function is
`files-backend.c:files_transaction_prepare`, and for reftable backend,
it is `reftable-backend.c:reftable_be_transaction_prepare`. Both
functions eventually call `object.c:parse_object`, which can invoke
`packfile.c:reprepare_packed_git` to refresh `packed_git`. This ensures
that bundle refs point to valid objects and that all tips from bundle
refs are correctly parsed during subsequent negotiations.

A test has been added to demonstrate that bundles with incorrect
headers, where refs point to non-existent objects, do not result in any
bundle refs being created in the repository. Additionally, a set of
negotiation-related tests for fetching with bundle-uri has been
included.

Reviewed-by: Karthik Nayak <karthik.188@gmail.com>
Reviewed-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 bundle-uri.c                |   3 +-
 t/t5558-clone-bundle-uri.sh | 153 +++++++++++++++++++++++++++++++++++-
 2 files changed, 150 insertions(+), 6 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 91b3319a5c1..65666a11d9c 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -400,8 +400,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 		refs_update_ref(get_main_ref_store(the_repository),
 				"fetched bundle", bundle_ref.buf, oid,
 				has_old ? &old_oid : NULL,
-				REF_SKIP_OID_VERIFICATION,
-				UPDATE_REFS_MSG_ON_ERR);
+				0, UPDATE_REFS_MSG_ON_ERR);
 	}
 
 	bundle_header_release(&header);
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 1ca5f745e73..8f4f802e4f1 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -19,10 +19,19 @@ test_expect_success 'fail to clone from non-bundle file' '
 
 test_expect_success 'create bundle' '
 	git init clone-from &&
-	git -C clone-from checkout -b topic &&
-	test_commit -C clone-from A &&
-	test_commit -C clone-from B &&
-	git -C clone-from bundle create B.bundle topic
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
+		# Create a bundle with reference pointing to non-existent object.
+		sed "s/$(git rev-parse A)/$(git rev-parse B)/" <A.bundle >bad-header.bundle
+	)
 '
 
 test_expect_success 'clone with path bundle' '
@@ -33,6 +42,16 @@ test_expect_success 'clone with path bundle' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone with bundle that has bad header' '
+	git clone --bundle-uri="clone-from/bad-header.bundle" \
+		clone-from clone-bad-header 2>err &&
+	# Write bundle ref fails, but clone can still proceed.
+	commit_b=$(git -C clone-from rev-parse B) &&
+	test_grep "trying to write ref '\''refs/bundles/topic'\'' with nonexistent object $commit_b" err &&
+	git -C clone-bad-header for-each-ref --format="%(refname)" >refs &&
+	! grep "refs/bundles/" refs
+'
+
 test_expect_success 'clone with path bundle and non-default hash' '
 	test_when_finished "rm -rf clone-path-non-default-hash" &&
 	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="clone-from/B.bundle" \
@@ -259,6 +278,132 @@ test_expect_success 'clone bundle list (file, any mode, all failures)' '
 	! grep "refs/bundles/" refs
 '
 
+#########################################################################
+# Clone negotiation related tests begin here
+
+test_expect_success 'negotiation: bundle with part of wanted commits' '
+	test_when_finished rm -rf trace*.txt &&
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --bundle-uri="clone-from/A.bundle" \
+		clone-from nego-bundle-part &&
+	git -C nego-bundle-part for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/topic
+	EOF
+	test_cmp expect actual &&
+	# Ensure that refs/bundles/topic are sent as "have".
+	grep "clone> have $(git -C clone-from rev-parse A)" trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle with all wanted commits' '
+	test_when_finished rm -rf trace*.txt &&
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --single-branch --branch=topic --no-tags \
+		--bundle-uri="clone-from/B.bundle" \
+		clone-from nego-bundle-all &&
+	git -C nego-bundle-all for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/topic
+	EOF
+	test_cmp expect actual &&
+	# We already have all needed commits so no "want" needed.
+	! grep "clone> want " trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle list (no heuristic)' '
+	test_when_finished rm -f trace*.txt &&
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+
+	[bundle "bundle-2"]
+		uri = file://$(pwd)/clone-from/bundle-2.bundle
+	EOF
+
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from nego-bundle-list-no-heuristic &&
+
+	git -C nego-bundle-list-no-heuristic for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	EOF
+	test_cmp expect actual &&
+	grep "clone> have $(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/left)" trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle list (creationToken)' '
+	test_when_finished rm -f trace*.txt &&
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = file://$(pwd)/clone-from/bundle-2.bundle
+		creationToken = 2
+	EOF
+
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from nego-bundle-list-heuristic &&
+
+	git -C nego-bundle-list-heuristic for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	EOF
+	test_cmp expect actual &&
+	grep "clone> have $(git -C nego-bundle-list-heuristic rev-parse refs/bundles/left)" trace-packet.txt
+'
+
+test_expect_success 'negotiation: bundle list with all wanted commits' '
+	test_when_finished rm -f trace*.txt &&
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = file://$(pwd)/clone-from/bundle-2.bundle
+		creationToken = 2
+	EOF
+
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git clone --no-local --single-branch --branch=left --no-tags \
+		--bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from nego-bundle-list-all &&
+
+	git -C nego-bundle-list-all for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	EOF
+	test_cmp expect actual &&
+	# We already have all needed commits so no "want" needed.
+	! grep "clone> want " trace-packet.txt
+'
+
 #########################################################################
 # HTTP tests begin here
 
-- 
gitgitgadget

