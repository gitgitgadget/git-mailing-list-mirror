Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D7EC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiKGShO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiKGSgn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:43 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9487E2717A
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:24 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso10230983wma.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52gDFZ/+n1Bm86Srvi2+P5tDi+9yXiVJ4AmRBf/KxJ8=;
        b=YH5RLjgQGZDNYHZfynjIUP9BLpGVgAZSeLYGV/oShBdr11in1UDHnuX9b51zaDymM+
         2tsJUjBM+R7uGGO//s3qgC/ImoI7iXxyU8C9vQ4Kt2XJ9V3G920nyPjuRAUO3TPezAAe
         jv54P4oHqzq3ePruQX+UomPrsfKDHIIXT/Co6uuWJ7vlbXL4xJ/eCZszDHBV1JPiC1Xu
         X/7/+I0spal4gJayf0wM0Dr5UFLxzkrt0DVhae2BjmWcYbUMX6rOcTS3eHq5txYXYSO9
         IlGS0qNiEH+DQw4Wjpkn8EMJGEApVWxamoloeP2gLn5DEjSaOdEmgi3KrP2dxUdR1sJY
         Wo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52gDFZ/+n1Bm86Srvi2+P5tDi+9yXiVJ4AmRBf/KxJ8=;
        b=oWPKmC8oR1dgsd7E9I0ximaksQfWHciRq7dUVUrIUu2o0Sehqk1dsLZgsdyE4rg4Mc
         tUj9TTFUf+YIWyP9BNYMjplqcW+FTMLCuUfewDWBT7QA0hTBlrY1QFRGwT2X8NBkXkcQ
         Ti9nkQibyW83X+QHlCu73jz4qLWLC10N8/FuDwji7xUuX/nWJGAentsSMZXRx7sPqXBD
         B232DUwa98vsVJzI6JwSvPuTo3QDZrkn/3zeeZQvOaF0Hpn7Bw8fppXpBZz44TgmgocC
         PT3LsENleHpZoKQc46i1uEHRuW42Zv99wV763FDRreoobPxOmbYrYX+baHrmjZzoYmGC
         wF8g==
X-Gm-Message-State: ACrzQf14SG8jDK6UhnM/NQbAcaXx6odqzU4iz+CaKv7nYinMAUmV6V7a
        s9t1RTl4hDX75GKGC7el0h+KQXrJiXI=
X-Google-Smtp-Source: AMsMyM6Ncr4dfzdw398MvFQdMWsZzD0h5Wu3D+Q0bruJ/NYFb5FAu/P2w3O+szAWWQEmPPtZjG//wA==
X-Received: by 2002:a05:600c:21a:b0:3cf:6e76:9830 with SMTP id 26-20020a05600c021a00b003cf6e769830mr30693875wmi.159.1667846182629;
        Mon, 07 Nov 2022 10:36:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b9-20020a05600010c900b002368424f89esm8107758wrx.67.2022.11.07.10.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:22 -0800 (PST)
Message-Id: <7c1f6a1ad609ecd33ceda5655cd8fc02137f3e5e.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:50 +0000
Subject: [PATCH 16/30] config: add config values for packed-refs v2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When updating the file format version for something as critical as ref
storage, the file format version must come with an extension change. The
extensions.refFormat config value is a multi-valued config value that
defaults to the pair "files" and "packed".

Add "packed-v2" as a possible value to extensions.refFormat. This
value specifies that the packed-refs file may exist in the version 2
format. (If the "packed" value does not exist, then the packed-refs file
must exist in version 2, not version 1.)

In order to select version 2 for writing, the user will have two
options. First, the user could remove "packed" and add "packed-v2" to
the extensions.refFormat list. This would imply that version 2 is the
only format available. However, this also means that version 1 files
would be ignored at read time, so this does not allow users to upgrade
repositories with existing packed-refs files.

Add a new refs.packedRefsVersion config option which allows specifying
which version to use during writes. Thus, when both "packed" and
"packed-v2" are in the extensions.refFormat list, the user can upgrade
from version 1 to version 2, or downgrade from 2 to 1.

Currently, the implementation does not use refs.packedRefsVersion, as
that is delayed until we have the code to write that file format
version. However, we can add the necessary enum values and flag
constants to communicate the presence of "packed-v2" in the
extensions.refFormat list.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config.txt            |  2 ++
 Documentation/config/extensions.txt | 27 ++++++++++++++++++++++-----
 Documentation/config/refs.txt       | 13 +++++++++++++
 refs.c                              |  4 +++-
 refs/packed-backend.c               | 17 ++++++++++++++++-
 refs/refs-internal.h                |  5 +++--
 repository.h                        |  1 +
 setup.c                             |  2 ++
 t/t3212-ref-formats.sh              | 19 +++++++++++++++++++
 9 files changed, 81 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/config/refs.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e93aef8626..e480f99c3e1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -493,6 +493,8 @@ include::config/rebase.txt[]
 
 include::config/receive.txt[]
 
+include::config/refs.txt[]
+
 include::config/remote.txt[]
 
 include::config/remotes.txt[]
diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
index 18071c336d0..05abb821e07 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -35,17 +35,34 @@ indicate the existence of different layers:
 	`files`, the `packed` format will only be used to group multiple
 	loose object files upon request via the `git pack-refs` command or
 	via the `pack-refs` maintenance task.
+
+`packed-v2`;;
+	When present, references may be stored as a group in a
+	`packed-refs` file in its version 2 format. This file is in the
+	same position and interacts with loose refs the same as when the
+	`packed` value exists. Both `packed` and `packed-v2` must exist to
+	upgrade an existing `packed-refs` file from version 1 to version 2
+	or to downgrade from version 2 to version 1. When both are
+	present, the `refs.packedRefsVersion` config value indicates which
+	file format version is used during writes, but both versions are
+	understood when reading the file.
 --
 +
 The following combinations are supported by this version of Git:
 +
 --
-`files` and `packed`;;
+`files` and (`packed` and/or `packed-v2`);;
 	This set of values indicates that references are stored both as
-	loose reference files and in the `packed-refs` file in its v1
-	format. Loose references are preferred, and the `packed-refs` file
-	is updated only when deleting a reference that is stored in the
-	`packed-refs` file or during a `git pack-refs` command.
+	loose reference files and in the `packed-refs` file. Loose
+	references are preferred, and the `packed-refs` file is updated
+	only when deleting a reference that is stored in the `packed-refs`
+	file or during a `git pack-refs` command.
++
+The presence of `packed` and `packed-v2` specifies whether the `packed-refs`
+file is allowed to be in its v1 or v2 formats, respectively. When only one
+is present, Git will refuse to read the `packed-refs` file that do not
+match the expected format. When both are present, the `refs.packedRefsVersion`
+config option indicates which file format is used during writes.
 
 `files`;;
 	When only this value is present, Git will ignore the `packed-refs`
diff --git a/Documentation/config/refs.txt b/Documentation/config/refs.txt
new file mode 100644
index 00000000000..b2fdb2923f7
--- /dev/null
+++ b/Documentation/config/refs.txt
@@ -0,0 +1,13 @@
+refs.packedRefsVersion::
+	Specifies the file format version to use when writing a `packed-refs`
+	file. Defaults to `1`.
++
+The only other value currently allowed is `2`, which uses a structured file
+format to result in a smaller `packed-refs` file. In order to write this
+file format version, the repository must also have the `packed-v2` extension
+enabled. The most typical setup will include the
+`core.repositoryFormatVersion=1` config value and the `extensions.refFormat`
+key will have three values: `files`, `packed`, and `packed-v2`.
++
+If `extensions.refFormat` has the value `packed-v2` and not `packed`, then
+`refs.packedRefsVersion` defaults to `2`.
diff --git a/refs.c b/refs.c
index 21441ddb162..bf53d1445f2 100644
--- a/refs.c
+++ b/refs.c
@@ -1987,6 +1987,8 @@ static int add_ref_format_flags(enum ref_format_flags flags, int caps) {
 		caps |= REF_STORE_FORMAT_FILES;
 	if (flags & REF_FORMAT_PACKED)
 		caps |= REF_STORE_FORMAT_PACKED;
+	if (flags & REF_FORMAT_PACKED_V2)
+		caps |= REF_STORE_FORMAT_PACKED_V2;
 
 	return caps;
 }
@@ -2006,7 +2008,7 @@ static struct ref_store *ref_store_init(struct repository *repo,
 	flags = add_ref_format_flags(repo->ref_format, flags);
 
 	if (!(flags & REF_STORE_FORMAT_FILES) &&
-	    (flags & REF_STORE_FORMAT_PACKED))
+	    packed_refs_enabled(flags))
 		be_name = "packed";
 
 	be = find_ref_storage_backend(be_name);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 7ed9475812c..655aab939be 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -236,7 +236,13 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 	if (!load_contents(snapshot))
 		return snapshot;
 
-	if (parse_packed_format_v1_header(refs, snapshot, &sorted)) {
+	/*
+	 * If this is a v1 file format, but we don't have v1 enabled,
+	 * then ignore it the same way we would as if we didn't
+	 * understand it.
+	 */
+	if (parse_packed_format_v1_header(refs, snapshot, &sorted) ||
+	    !(refs->store_flags & REF_STORE_FORMAT_PACKED)) {
 		clear_snapshot(refs);
 		return NULL;
 	}
@@ -310,6 +316,12 @@ static int packed_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		packed_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
 	struct snapshot *snapshot = get_snapshot(refs);
 
+	if (!snapshot) {
+		/* refname is not a packed reference. */
+		*failure_errno = ENOENT;
+		return -1;
+	}
+
 	return packed_read_raw_ref_v1(refs, snapshot, refname,
 				      oid, type, failure_errno);
 }
@@ -410,6 +422,9 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	 */
 	snapshot = get_snapshot(refs);
 
+	if (!snapshot)
+		return empty_ref_iterator_begin();
+
 	if (prefix && *prefix)
 		start = find_reference_location_v1(snapshot, prefix, 0);
 	else
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index a1900848a87..39b93fce97c 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -522,11 +522,12 @@ struct ref_store;
 				 REF_STORE_MAIN)
 
 #define REF_STORE_FORMAT_FILES		(1 << 8) /* can use loose ref files */
-#define REF_STORE_FORMAT_PACKED		(1 << 9) /* can use packed-refs file */
+#define REF_STORE_FORMAT_PACKED		(1 << 9) /* can use v1 packed-refs file */
+#define REF_STORE_FORMAT_PACKED_V2	(1 << 10) /* can use v2 packed-refs file */
 
 static inline int packed_refs_enabled(int flags)
 {
-	return flags & REF_STORE_FORMAT_PACKED;
+	return flags & (REF_STORE_FORMAT_PACKED | REF_STORE_FORMAT_PACKED_V2);
 }
 
 /*
diff --git a/repository.h b/repository.h
index 5cfde4282c5..ee3a90efc72 100644
--- a/repository.h
+++ b/repository.h
@@ -64,6 +64,7 @@ struct repo_path_cache {
 enum ref_format_flags {
 	REF_FORMAT_FILES = (1 << 0),
 	REF_FORMAT_PACKED = (1 << 1),
+	REF_FORMAT_PACKED_V2 = (1 << 2),
 };
 
 struct repository {
diff --git a/setup.c b/setup.c
index a5e63479558..72bfa289ade 100644
--- a/setup.c
+++ b/setup.c
@@ -582,6 +582,8 @@ static enum extension_result handle_extension(const char *var,
 			data->ref_format |= REF_FORMAT_FILES;
 		else if (!strcmp(value, "packed"))
 			data->ref_format |= REF_FORMAT_PACKED;
+		else if (!strcmp(value, "packed-v2"))
+			data->ref_format |= REF_FORMAT_PACKED_V2;
 		else
 			return error(_("invalid value for '%s': '%s'"),
 				     "extensions.refFormat", value);
diff --git a/t/t3212-ref-formats.sh b/t/t3212-ref-formats.sh
index 67aa65c116f..cd1b399bbb8 100755
--- a/t/t3212-ref-formats.sh
+++ b/t/t3212-ref-formats.sh
@@ -56,4 +56,23 @@ test_expect_success 'extensions.refFormat=files only' '
 	)
 '
 
+test_expect_success 'extensions.refFormat=files,packed-v2' '
+	test_commit Q &&
+	git pack-refs --all &&
+	git init no-packed-v1 &&
+	(
+		cd no-packed-v1 &&
+		git config core.repositoryFormatVersion 1 &&
+		git config extensions.refFormat files &&
+		git config --add extensions.refFormat packed-v2 &&
+		test_commit A &&
+		test_commit B &&
+
+		# Refuse to parse a v1 packed-refs file.
+		cp ../.git/packed-refs .git/packed-refs &&
+		test_must_fail git rev-parse refs/tags/Q &&
+		rm -f .git/packed-refs
+	)
+'
+
 test_done
-- 
gitgitgadget

