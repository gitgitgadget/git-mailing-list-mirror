Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ADF1C6B4
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126204; cv=none; b=ouooJQYaq7EsfREF51yYulsxEuyswDvsVFCxMZ/okM782CG5vx3W48UrpxXq8+PsDqWc5vObWWf9+E2iQd6StWihlji653lMRgVRJjutiULGaeskYWn3i0YlwHpdxnTXpI0wmXzYJP3yrQgmdsSTXJd38gCy6Kswg6Amqrim6eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126204; c=relaxed/simple;
	bh=xzbMCsIaJ8VusIxEbrxBuX/PE4p0sQQE+hDN7wZTCAY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ewS4WKRg7yJIax/ZnXzFcHkKJcqDkO+gPOuURZCBI63kuTJWpkrBoEm6E3SaOuYePJoHfI4tHC+a8p2n9XrkPQWMOXUMfx3bnvEoh+BNqAM4vh7M9700mJxCRqN+5H56w3ZN4L2+fsAeLkWG4UURAb9nF58iwYnqeeQd/lxiau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtmJLnzM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtmJLnzM"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b4e5c3d0fso8882205e9.2
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756126201; x=1756731001; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76sFxLSev78gwOyDn6sqomYESJMsXQsfpEPl1dutXqA=;
        b=CtmJLnzMJVQqKu60/1wvf575hQ0iejYl5/bfyxgmhPHcqs+CCzax9GepcbHyotwi9d
         5p8iC1jds5UNUFWJTkejTItVXa7S3rxFqc34/J/Wb6Kh4zWlPan1EEAZeQmQnKgBdjfq
         WzlxL7Ug21SGTpeTSCoxzYaGECpdE3xm9fAZEPgI0fIzVDz+Tv2HDt5kiPKeZpSuskkg
         CkZUVbbG5DNM93GZ6NX9p1Mod3mxfXmKFm65LX4Q7Z98l9EoHdJiLVZYRHw5ab3/gJvI
         munUxk8R9rnA7+zpLEiQTxhP61YrBc1yFjXP9FNco5pahBcAevGzgu0ALo4hUYf781e8
         58pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756126201; x=1756731001;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76sFxLSev78gwOyDn6sqomYESJMsXQsfpEPl1dutXqA=;
        b=VqyMTm0foQoylqpEpuWVHJ5cYUV5Ujp5NiLsmxaTFBA+qWGVOB77DmHVy0fJCSJN/a
         o/c+6R/ebMqAXjakLVvhY3eFOwUPmsZvKtQzkRDR45vgdfLshOr2n6k96yDxisIfDRUC
         KQuLl7nDbsHzKJXmGlToDbXEQdXuJQn7+N/wFxDmsSK3X/aR+crCojILptZcbonCHZtp
         J0Rrth8bytDsI55At1zN4ZdYCVW9wmZQUKVNUsrJJc0iv2hkSeZ+FH4prcMQR9ToqVxh
         1WdLZlDAtrcUkB3eQDXQEn5wR571UrtH+09PEoqAxEI6ZZpyAajquKd6iVDxGwi07rmk
         BYkg==
X-Gm-Message-State: AOJu0Yx4W8gF7sSD7SpzXztp0HEDD+b2xfG8YAiR3a7O+r4CjFN0wfDK
	7vjFFhkKyedUlhtvaQHhMkPDXySBc24r71xyoSbWmCD4RX5V9RmQrPa19Mx7rDCR
X-Gm-Gg: ASbGncsTaLpYOFnu/toQXDuhR0rcnESOsCSZjfZiO2+DmjfB+x7tu+8Sv+qGs6/kUVN
	j+Q0U1VFuW/KvhqVw8YZnnSqWot7FjdC7x5YLfit2ghaWTecTqG1JiDkhmsj2ACD03kJtRI7wGk
	9ZkEYPnlnA+SbE6KHkLiPitIWiuByG8RrrAPK9PRJh/la/jFgf1miL/pnGjhUc/dA8w+SkbeYn5
	s/HS2pGgZ6DTE7BIpLlaAvVbF+jczmdiSf7HlkG15jf8PtoxMU9ocC7759SKUwIDnh3Wd3zTX/A
	QBzkqf8X3dno+UYH+dgpKmOPDeMuRf2cjtjV8xQRwGok86SnQwyYvexRaJJ5RuPlHlak98PdJmq
	cDOTBsYkhjnbPZbjf56yXU8e1nTae62noVQ==
X-Google-Smtp-Source: AGHT+IGpgv0muxSVqg2uYw1Sk2V7aRLnrmKXUgcX56Kxrd9V1gx3OR9XJ6PpRkdhA/MU/+rIpGxM4w==
X-Received: by 2002:a05:600c:3b18:b0:459:db5a:b0b9 with SMTP id 5b1f17b1804b1-45b517cfb8cmr92387465e9.28.1756126200383;
        Mon, 25 Aug 2025 05:50:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b575736f1sm107611945e9.13.2025.08.25.05.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 05:49:59 -0700 (PDT)
Message-Id: <2feedf5a1ee3cf7d7d4e06c088a2e43ccb841dcc.1756126197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1956.v2.git.1756126197.gitgitgadget@gmail.com>
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
	<pull.1956.v2.git.1756126197.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 Aug 2025 12:49:56 +0000
Subject: [PATCH v2 1/2] path-walk: fix setup of pending objects
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Users reported an issue where objects were missing from their local
repositories after a full repack using 'git repack -adf --path-walk'.
This was alarming and took a while to create a reproducer. Here, we fix
the bug and include a test case that would fail without this fix.

The root cause is that certain objects existed in the index and had no
second versions. These objects are usually blobs, though trees can be
included if a cache-tree exists. The issue is that the revision walk
adds these objects to the "pending" list and the path-walk API forgets
to mark the lists it creates at this point as "maybe_interesting". If
these paths only ever have a single version in the history of the repo
(including the current staged version) then the parent directory never
tries to add a new object to the list and mark the list as
"maybe_interesting". Thus, when walking the list later, the group is
skipped as it is expected that no objects are interesting. This happens
even when there are actually no UNINTERESTING objects at all! This is
based on the optimization enabled by the pack.useSparse=true config
option, which is the default.

Thus, we create a test case that demonstrates the many cases of this
issue for reproducibility:

 1. File a/b/c has only one committed version.
 2. Files a/i and x/y only exist as staged changes.
 3. Tree x/ only exists in the cache-tree.

After performing a non-path-walk repack to force all loose objects into
packfiles, run a --path-walk repack followed by 'git fsck'. This fsck is
what fails with the following errors:

  error: invalid object 100644 f2e41136... for 'a/b/c'

    This is the dropped instance of the single-versioned a/b/c file.

  broken link from    tree cfda31d8...
                to    tree 3f725fcd...

    This is the missing tree for the single-versioned a/b/ directory.

  missing blob 0ddf2bae... (a/i)
  missing blob 975fbec8... (x/y)
  missing blob a60d869d... (file)
  missing blob f2e41136... (a/b/c)

  missing tree 3f725fcd... (a/b/)

  dangling tree 5896d7e... (staged root tree)

Note that since the staged root tree is missing, the fsck output cannot
even report that the staged x/ tree is missing as well.

The core problem here is that the "maybe_interesting" member of 'struct
type_and_oid_list' is not initialized to '1'. This member was added in
6333e7ae0b (path-walk: mark trees and blobs as UNINTERESTING,
2024-12-20) in a way to help when creating packfiles for a small commit
range using the sparse path algorithm (enabled by pack.useSparse=true).

The idea here is that the list is marked as "maybe_interesting" if an
object is added that does not have the UNINTERESTING flag on it. Later,
this is checked again in case all objects in the list were marked
UNINTERESTING after that point in time. In this case, the algorithm
skips the list as there is no reason to visit it.

This leads to the problem where the "maybe_interesting" member was not
appropriately initialized when the list is created from pending objects.
Initializing this in the correct places fixes the bug.

To reduce risk of similar bugs around initializing this structure, a
follow-up change will make initializing lists use a shared method.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 path-walk.c       |  2 ++
 t/t7700-repack.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/path-walk.c b/path-walk.c
index 2d4ddbadd50f..1215ed398f4f 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -385,6 +385,7 @@ static int setup_pending_objects(struct path_walk_info *info,
 					list->type = OBJ_TREE;
 					strmap_put(&ctx->paths_to_lists, path, list);
 				}
+				list->maybe_interesting = 1;
 				oid_array_append(&list->oids, &obj->oid);
 				free(path);
 			} else {
@@ -404,6 +405,7 @@ static int setup_pending_objects(struct path_walk_info *info,
 					list->type = OBJ_BLOB;
 					strmap_put(&ctx->paths_to_lists, path, list);
 				}
+				list->maybe_interesting = 1;
 				oid_array_append(&list->oids, &obj->oid);
 			} else {
 				/* assume a root tree, such as a lightweight tag. */
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 611755cc139b..73b78bdd887d 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -838,4 +838,67 @@ test_expect_success '-n overrides repack.updateServerInfo=true' '
 	test_server_info_missing
 '
 
+test_expect_success 'pending objects are repacked appropriately' '
+	test_when_finished rm -rf pending &&
+	git init pending &&
+
+	(
+		cd pending &&
+
+		# Commit file, a/b/c and never change them.
+		mkdir -p a/b &&
+		echo singleton >file &&
+		echo stuff >a/b/c &&
+		echo more >a/d &&
+		git add file a &&
+		git commit -m "single blobs" &&
+
+		# Files a/d and a/e will not be singletons.
+		echo d >a/d &&
+		echo e >a/e &&
+		git add a &&
+		git commit -m "more blobs" &&
+
+		# This use of a sparse index helps to force
+		# test that the cache-tree is walked, too.
+		git sparse-checkout set --sparse-index a x &&
+
+		# Create staged changes:
+		# * a/e now has multiple versions.
+		# * a/i now has only one version.
+		echo f >a/d &&
+		echo h >a/e &&
+		echo i >a/i &&
+		git add a &&
+
+		# Stage and unstage a change to make use of
+		# resolve-undo cache and how that impacts fsck.
+		mkdir x &&
+		echo y >x/y &&
+		git add x &&
+		xy=$(git rev-parse :x/y) &&
+		git rm --cached x/y &&
+
+		# The blob for x/y must persist through repacks,
+		# but fsck currently ignores the REUC extension
+		# for finding links to the blob.
+		cat >expect <<-EOF &&
+		dangling blob $xy
+		EOF
+
+		# Bring the loose objects into a packfile to avoid
+		# leftovers in next test. Without this, the loose
+		# objects persist and the test succeeds for other
+		# reasons.
+		git repack -adf &&
+		git fsck >out &&
+		test_cmp expect out &&
+
+		# Test path walk version with pack.useSparse.
+		git -c pack.useSparse=true repack -adf --path-walk &&
+		git fsck >out &&
+		test_cmp expect out
+	)
+'
+
 test_done
-- 
gitgitgadget

