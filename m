Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A5D1EA8F
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088135; cv=none; b=VMLPcmt+HNVKAk624p+y85mAcRqINo+p7YMmzewCUaZV+frWa3uKPP6SJZQteS7P8M1fUIBo/Io6XbFdbLldIshMMHoUAXBjY8q5FTqXCctIRjZO/kjEY5zGYBSuZe4Rcp9JU0Wt90dYMiIBD87O8V/Uozr+OVMMf8VwGf5BIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088135; c=relaxed/simple;
	bh=/tENE3Kgl1cYhu0N5e4hM8lvQ9F5tFHbMwVAioiliyY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mi3Nj82vZ/tLihYxv8cmUBYcisk//ofSfuzMNbP9pDA2vXhLdtu72qUNGWb89DviwIGHZVs10HBsJUspeCjNJcnyd0M79KkpYi9EpVrWiT2k0ZrziFxODRx0PVaBvZh4ic73vfNkL8nie1j1zAxPREoYkiX86sxbl0XhkidnXY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QElXvkEp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QElXvkEp"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35f2266edd8so582695f8f.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 23:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718088130; x=1718692930; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1vTJEyiG2vXL6cdAMlKLrLvnBGFQoqjVV/+UtqDT8E=;
        b=QElXvkEpuI5s1P4AvEYvBB66aTj/eMCixtJH/7j2mjJA+wzw0ltuN2GgqrdFkPDGGD
         p5akwLyYJQfWFsTFdwg/ymN3TJhmSl+Afiuyr/ywRTmSl9H+0VkLDJfbuhhXUEHYcx9Q
         yHa9XsFzmnDRrqiLJ7SSlHG9+yo7xgNA3nFG1Y39Ka//2rjZV0ioYo9OFNLTUl2EMt/5
         cU1RQevwFtoacKO/A/luCzb3tbFHHSX6N/Cj08caVTd+WXFuhGykCHKrBZVIQIcItQBj
         mmMMXIKPF+Vvmz6W+4vDAfQ1KjvX1kegjjT46eD2Cks524N8WcEmuJpcX2Ob3oy49eqK
         R4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718088130; x=1718692930;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1vTJEyiG2vXL6cdAMlKLrLvnBGFQoqjVV/+UtqDT8E=;
        b=eRO6NeFBO4qGQcCW6/JJaHhhV2F8m0lt86IM6dX91blBlNSTGgvTtS7CAVHI0XRNlX
         Tk1NfkPOERLMYDiQAOSpWiimwJUN8ceeNt0Xy9PGz/R7Vd/ONrsbxHrzYEH9lTZ4OddK
         yQplt3qPBEv3SbjKdWLLpyHS3anppBmVBs47r2DyPTB259dkdRCejIrr4KKIja5hrgSV
         wc3xB2JwS2IFPpmsPphQ7kSasp1Jo5No1C247pHkEbzLVrCcZI1yrtRU/hKse4VqhIJG
         1U4vMO+rUhF0MT2wBkxmxyK7S171XIQTbNo+oP71d3TTSRPRrJH0k/AUNxtRh7m44FIv
         cG+A==
X-Gm-Message-State: AOJu0YxvhjZQtJ60urCCTxDEaHA1e+oyQl0KCCpPkeIPv7WSYock24Qu
	JPdcAu03vsFjte1m+5T2S/Psm7s68H8XlizezfUloZtpJtzlFj1TAjFd5w==
X-Google-Smtp-Source: AGHT+IGOHnlpCdhYt7nF0/K6v8OdnPNh1Ljh80qEiRbRUzvUnlrr5480h1MbFrNJC5KDVytTXnBxhQ==
X-Received: by 2002:a5d:45d0:0:b0:35f:1f36:c4c6 with SMTP id ffacd0b85a97d-35f1f36c558mr4718947f8f.62.1718088129938;
        Mon, 10 Jun 2024 23:42:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1d5f484csm6610953f8f.63.2024.06.10.23.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 23:42:09 -0700 (PDT)
Message-Id: <e958a3ab20c0c06f52a00038f39605f14302032a.1718088127.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
References: <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
	<pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 06:42:03 +0000
Subject: [PATCH v5 1/4] bundle-uri: verify oid before writing refs
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

