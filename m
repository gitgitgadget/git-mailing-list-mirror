Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD664417
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751489; cv=none; b=qzBSUkVedlbfYcy003hM+GyaSdZBFSMKvqbArntWeWX34Qup04LqwzhEdE1EzegjD1H0Y5QVsgaQNBd6kfWghjucuus/VU8Rj1bLGnYjQejgHr0IB/BtJECzvUzKQy8BqD6q0jt6IY7OGpzfUqb+GhFGeWEs6C5v0dkCo24QXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751489; c=relaxed/simple;
	bh=z73mdDzNaFG/F8/QUj7UaGTODOLyVEmawvUWo+PlGU0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CiATcR52NqBq18h+iStcEeX35rGotQBSIz3m1Y1fKRbZ47vQpjepEEDTH56CPVbHaDNSPNnyCSZvprD8ICgVNPzf2Ov62cBMd0v5vDIty/G0p5gR/gQnNcOAiGxHtHi7w9FVA8DKUgon0K8JjpNJdNIU+6yfdpm+xEXFzmgPmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VH/pmQp+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH/pmQp+"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ef75adf44so3694475e9.3
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 17:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706751485; x=1707356285; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOOZa5dwNDVldGL3UVEGbXFAIPT2xntKxgTVQVWIFGQ=;
        b=VH/pmQp+UGJ2vigYcfBSiAt0Oy8QG5hFsjAOifi2vMJow7sRRrhvcwD4GYION1thmR
         Sj9GO6dNwEdNJiGtJDGNu8lSvtzIUXnLxpzlqzlkt+tZxI1h2/FusXq1gi64xVM9cmxR
         7m1CqsYnBtK0yMMC25P0QfBpTqpQStISZQDfKQamRl5gr1ycz43JhSn6294UY1lfW7zN
         XnxNUqWw0oSCq+pb6WdH9K+pdUJjHGe0ci3HLsimWZnJq4ZNbKIbZA738FRW39U5N4bZ
         llpxdNy5vkgYQZbpJVDr/ckPLkh1GpBl/fJ4qHP8kezhjWjv6mwzQ8fVWlEEm1l56gNy
         bSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706751485; x=1707356285;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOOZa5dwNDVldGL3UVEGbXFAIPT2xntKxgTVQVWIFGQ=;
        b=NDjK09mQ201ptlrsHczHpeRsvU4SKp/YTUEL3tRueYUbh3a7QFbe+1xYDVYmvE+Pkg
         VoVynyIVM/C8KQ/d528AfGhL11102tsnD7gKI5nrWsyQIsWHANW5C5xV1GYrKx54A0sC
         xoGRrIdYbF7zQHYzD5OxT4gujnUBZww/FacReX+tBjcoLYmpjviMCJZo3KcHoWkjxW/D
         LX3TATrlv1t4oRQnlAC5rMptXkpjnjFsRP4Yod25q+j+/ZMeahpWd6UMdjVUSCydHi4r
         9fyT/U8UOla+UI+ArBGikjmcRNi5zk86/Ndf2oaQtvZAPcOLcpe8DC1pdtUo9dZlJ5fp
         +hFA==
X-Gm-Message-State: AOJu0YwsL4xLRMvX7JLwE2syc15LjRDXGgtYdc+bPEfB6QHXrQ0TYigS
	1bppmEBq9bKbvaa3GwutGq3udfUJkX+iGM/WKZi0Fn6RLdsa3yHhwBUFlla6
X-Google-Smtp-Source: AGHT+IEfbP44k4jmlSRJHE5PmxvJwRxEMKCq5qQtVnROpxbBs9ad33rlsZGp7TZbEVIyvtvy6ei+Rw==
X-Received: by 2002:a05:600c:1d0a:b0:40e:a32c:988d with SMTP id l10-20020a05600c1d0a00b0040ea32c988dmr2550150wms.4.1706751484793;
        Wed, 31 Jan 2024 17:38:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5Ic1ocwpkF7VGvHlBXgjP6rVYfKVdw2J0gJQ/UoGNMlmuLARAyQwVaiOfeNXnCNfDz0K/0PwTZAOsswlc6Ixb8K3ZzefaYBXSvm3qVYQ=
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bk24-20020a0560001d9800b0033add8aa1d2sm14347971wrb.44.2024.01.31.17.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 17:38:04 -0800 (PST)
Message-ID: <cdf7fc7fe8a9d5664c9fdfb85f8c9293aa446c13.1706751483.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1658.v4.git.git.1706751483.gitgitgadget@gmail.com>
References: <pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>
	<pull.1658.v4.git.git.1706751483.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Feb 2024 01:38:01 +0000
Subject: [PATCH v4 1/2] index-pack: test and document
 --strict=<msg-id>=<severity>...
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
Cc: Jonathan Tan <jonathantanmy@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

5d477a334a (fsck (receive-pack): allow demoting errors to warnings,
2015-06-22) allowed a list of fsck msg to downgrade to be passed to
--strict. However this is a hidden argument that was not documented nor
tested. Though it is true that most users would not call this option
directly, (nor use index-pack for that matter) it is still useful to
document and test this feature.

Reviewed-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-index-pack.txt |  9 +++++++--
 builtin/index-pack.c             |  2 +-
 t/t5300-pack-object.sh           | 22 ++++++++++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 6486620c3d8..694bb9409bf 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -79,8 +79,13 @@ OPTIONS
 	to force the version for the generated pack index, and to force
 	64-bit index entries on objects located above the given offset.
 
---strict::
-	Die, if the pack contains broken objects or links.
+--strict[=<msg-id>=<severity>...]::
+	Die, if the pack contains broken objects or links. An optional
+	comma-separated list of `<msg-id>=<severity>` can be passed to change
+	the severity of some possible issues, e.g.,
+	 `--strict="missingEmail=ignore,badTagName=error"`. See the entry for the
+	`fsck.<msg-id>` configuration options in linkgit:git-fsck[1] for more
+	information on the possible values of `<msg-id>` and `<severity>`.
 
 --progress-title::
 	For internal use only.
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1ea87e01f29..240c7021168 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -24,7 +24,7 @@
 #include "setup.h"
 
 static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
+"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-id>=<severity>...]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
 struct object_entry {
 	struct pack_idx_entry idx;
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index d402ec18b79..496fffa0f8a 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -441,6 +441,28 @@ test_expect_success 'index-pack with --strict' '
 	)
 '
 
+test_expect_success 'index-pack with --strict downgrading fsck msgs' '
+	test_when_finished rm -rf strict &&
+	git init strict &&
+	(
+		cd strict &&
+		test_commit first hello &&
+		cat >commit <<-EOF &&
+		tree $(git rev-parse HEAD^{tree})
+		parent $(git rev-parse HEAD)
+		author A U Thor
+		committer A U Thor
+
+		commit: this is a commit with bad emails
+
+		EOF
+		git hash-object --literally -t commit -w --stdin <commit >commit_list &&
+		PACK=$(git pack-objects test <commit_list) &&
+		test_must_fail git index-pack --strict "test-$PACK.pack" &&
+		git index-pack --strict="missingEmail=ignore" "test-$PACK.pack"
+	)
+'
+
 test_expect_success 'honor pack.packSizeLimit' '
 	git config pack.packSizeLimit 3m &&
 	packname_10=$(git pack-objects test-10 <obj-list) &&
-- 
gitgitgadget

