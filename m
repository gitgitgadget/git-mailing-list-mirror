Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D1AD31
	for <git@vger.kernel.org>; Sat, 30 Nov 2024 01:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732928976; cv=none; b=lGhNo7wAFSfNdGEiJUopzApnm93dELj5fxco3SeNa5FNeV2tAGliAROeYyXmmKsWx8/qkfMqC46a1vp/xLa6HzQtpy5V3phvo79oB6Kl45U2/5C5Mu062I63aDebSNThqK4FkXm5Z5ZF6t+WfrmuSc7VVxWOLKvc2uaJ9qmxb18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732928976; c=relaxed/simple;
	bh=Vpsr+9loWkFPvCSEJTQ9EzJGHu88ExuTSGQx9rLmY54=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bwA1f1OC6liazN7dbQBI8nW1Yc8uA/g7lPYRwnuaUIk1+1XisSqbCnElLefV4B8VLK0owAfba3RpnJxnlNbdIF1xAp1EXpP3w4jPzsclzni3IwNWFtrAN1ROJZz7WAwH+gJID9G1xyTF1QS86OwqhggXIqbJ8/m2MKCd+GRtHQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWB9443V; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWB9443V"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a742481aso21514195e9.3
        for <git@vger.kernel.org>; Fri, 29 Nov 2024 17:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732928972; x=1733533772; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yMAJgGxZGPXADE+VpgJ3FnqhSuyL7NwwSKyGFYNnUE=;
        b=UWB9443VSwEp5hghxkAPY0apdFSCJVSa3G61vKxIwBn78nKwPTIIzE23qsSMJt3x5t
         5u2y9nL7e6DNM52QoUgdh+8oIQCj7FJraKfKByZ7TM137hap7/sXjefNb57gfvqlzMkp
         s17Oa+mW+lYrHdt4ADL6wVI+5/csMtoMPhOvmEPVxrAk1CNEMYjTMP7BPC8Guve5gXQB
         vZh1Ifc39eVoOgJQixblzefSfNkW6+uCJVf44hbm5rLjgdyVhmA3OfK3NIBHPncFzspv
         1g9x3UKgSI7+YXAU9cFiTwOzJTL32K/JPi/+brhoUmHsQ6OPuNrl9Ai9a3/aQI7s/5RY
         wQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732928972; x=1733533772;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yMAJgGxZGPXADE+VpgJ3FnqhSuyL7NwwSKyGFYNnUE=;
        b=pO6xPEZfjE51k8jnrII1i7/NXhNZ7v35M3EUgIGMhpy3tLJFXEUZ5XPO3aROEs5xt9
         Hxib8R0vq+QA6099rCZuOoMulW/8KVlX9mA4UI6lXUCFwqD/6rIGomidRNKhpmHIdgqE
         GUk5yt7Pm9tLg0k0D/eHogYfx/AZZ+AeL3dOi1LFpz0fITMhiH/OF6XUKjtce8Gw/4wA
         w+ZT/Vm1skpm20ll2MvmxEf6/Q7tfpTM8lHZUQClryxPeIu9iLh/74Ksblx76IVJNF9a
         YelzPe923ERCToQKyILeQJMsn0MSqZphTqjxNyqqPlyBM00EMPfMtUvZ1g9V1ZTSxNPi
         Harg==
X-Gm-Message-State: AOJu0YwDClkgn/qqP+j8j8PICoaN+ykcb6Xb8fm4IBqFPOE0V3XbZw5O
	q8yTtJe+gYEY+ysuHfiXfcvAtvgFVGOquDxN7p4JWZVUF67Xn3pfyT0flA==
X-Gm-Gg: ASbGncslsa4BBmHAJ88qbbDMc+nEfK52r0biWHc+wNNi8ycQD8E/nv/zifBZ3GqaXxy
	+z9rF3eH415HNQqhLPZucGqnVGn6g/tJEvL5jJ7uOUrG1zaH5JlkBdvWgBRmxyy/QYTX6093Toh
	j7zFUnUI/E+3q+/ieKbmFLDhJQoviXC+pAhUyObPk+xNrSIFP6/kw/ucFjjn5XT/MPAbilnlEDE
	yHHOqiatHrT8cWVTHsMboH342+0kt4B3oSOPUaGjDFaWdSHJkM=
X-Google-Smtp-Source: AGHT+IEHiKEWpBVdIQVUYw0FeiHEsAO18ykzUzk0NSIIn6KANR/VdehuxE06lJgjY57oluZf/a9xLQ==
X-Received: by 2002:a05:600c:348a:b0:431:4e25:fe42 with SMTP id 5b1f17b1804b1-434a9e0fdbdmr119930355e9.32.1732928971861;
        Fri, 29 Nov 2024 17:09:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa6e929csm103189135e9.0.2024.11.29.17.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:09:31 -0800 (PST)
Message-Id: <pull.1832.v2.git.1732928970059.gitgitgadget@gmail.com>
In-Reply-To: <pull.1832.git.1732740464398.gitgitgadget@gmail.com>
References: <pull.1832.git.1732740464398.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 30 Nov 2024 01:09:29 +0000
Subject: [PATCH v2] fast-import: disallow more path components
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Jeff King <peff@peff.net>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Instead of just disallowing '.' and '..', make use of verify_path() to
ensure that fast-import will disallow anything we wouldn't allow into
the index, such as anything under .git/, .gitmodules as a symlink, or
a dos drive prefix on Windows.

Since a few fast-export and fast-import tests that tried to stress-test
the correct handling of quoting relied on filenames that fail
is_valid_win32_path(), such as spaces or periods at the end of filenames
or backslashes within the filename, turn off core.protectNTFS for those
tests to ensure they keep passing.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    Disallow verify_path() failures from fast-import
    
    Since en/fast-import-path-sanitize has already made it to next, this
    commit is based on that. (See
    https://lore.kernel.org/git/pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com/
    for discussion of that series.)
    
    Changes relative to that commit: this fixes up the error message as
    suggested by Kristoffer, and makes the checks more encompassing as
    suggested by Patrick and Peff -- in particular, using verify_path() as
    suggested by Peff.
    
    Changes since v1:
    
     * Moved the check to a higher level, as suggested by Peff.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1832%2Fnewren%2Fdisallow-verify-path-fast-import-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1832/newren/disallow-verify-path-fast-import-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1832

Range-diff vs v1:

 1:  2c23d601112 ! 1:  787e9d71ae7 fast-import: disallow more path components
     @@ Commit message
          or backslashes within the filename, turn off core.protectNTFS for those
          tests to ensure they keep passing.
      
     +    Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/fast-import.c ##
     @@ builtin/fast-import.c
       #include "refs.h"
       #include "csum-file.h"
       #include "quote.h"
     -@@ builtin/fast-import.c: static int tree_content_set(
     - 		die("Empty path component found in input");
     - 	if (!*slash1 && !S_ISDIR(mode) && subtree)
     - 		die("Non-directories cannot have subtrees");
     -+	if (!verify_path(p, mode))
     -+		die("invalid path '%s'", p);
     - 
     - 	if (!root->tree)
     - 		load_tree(root);
      @@ builtin/fast-import.c: static int tree_content_set(
       		root->tree = t = grow_tree_content(t, t->entry_count);
       	e = new_tree_entry();
     @@ builtin/fast-import.c: static int tree_content_set(
       	e->versions[0].mode = 0;
       	oidclr(&e->versions[0].oid, the_repository->hash_algo);
       	t->entries[t->entry_count++] = e;
     +@@ builtin/fast-import.c: static void file_change_m(const char *p, struct branch *b)
     + 		tree_content_replace(&b->branch_tree, &oid, mode, NULL);
     + 		return;
     + 	}
     ++
     ++	if (!verify_path(path.buf, mode))
     ++		die("invalid path '%s'", path.buf);
     + 	tree_content_set(&b->branch_tree, path.buf, &oid, mode, NULL);
     + }
     + 
     +@@ builtin/fast-import.c: static void file_change_cr(const char *p, struct branch *b, int rename)
     + 			leaf.tree);
     + 		return;
     + 	}
     ++	if (!verify_path(dest.buf, leaf.versions[1].mode))
     ++		die("invalid path '%s'", dest.buf);
     + 	tree_content_set(&b->branch_tree, dest.buf,
     + 		&leaf.versions[1].oid,
     + 		leaf.versions[1].mode,
      
       ## t/t9300-fast-import.sh ##
      @@ t/t9300-fast-import.sh: test_expect_success 'B: fail on invalid committer (5)' '


 builtin/fast-import.c  |  8 +++-
 t/t9300-fast-import.sh | 88 ++++++++++++++++++++++++++++++++++++++++--
 t/t9350-fast-export.sh |  2 +-
 3 files changed, 91 insertions(+), 7 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 3e7ec1f1198..265d1b7d52b 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -13,6 +13,7 @@
 #include "delta.h"
 #include "pack.h"
 #include "path.h"
+#include "read-cache-ll.h"
 #include "refs.h"
 #include "csum-file.h"
 #include "quote.h"
@@ -1468,8 +1469,6 @@ static int tree_content_set(
 		root->tree = t = grow_tree_content(t, t->entry_count);
 	e = new_tree_entry();
 	e->name = to_atom(p, n);
-	if (is_dot_or_dotdot(e->name->str_dat))
-		die("path %s contains invalid component", p);
 	e->versions[0].mode = 0;
 	oidclr(&e->versions[0].oid, the_repository->hash_algo);
 	t->entries[t->entry_count++] = e;
@@ -2416,6 +2415,9 @@ static void file_change_m(const char *p, struct branch *b)
 		tree_content_replace(&b->branch_tree, &oid, mode, NULL);
 		return;
 	}
+
+	if (!verify_path(path.buf, mode))
+		die("invalid path '%s'", path.buf);
 	tree_content_set(&b->branch_tree, path.buf, &oid, mode, NULL);
 }
 
@@ -2453,6 +2455,8 @@ static void file_change_cr(const char *p, struct branch *b, int rename)
 			leaf.tree);
 		return;
 	}
+	if (!verify_path(dest.buf, leaf.versions[1].mode))
+		die("invalid path '%s'", dest.buf);
 	tree_content_set(&b->branch_tree, dest.buf,
 		&leaf.versions[1].oid,
 		leaf.versions[1].mode,
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5a5127fffa7..e2b1db6bc2f 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -522,7 +522,7 @@ test_expect_success 'B: fail on invalid committer (5)' '
 	test_must_fail git fast-import <input
 '
 
-test_expect_success 'B: fail on invalid file path' '
+test_expect_success 'B: fail on invalid file path of ..' '
 	cat >input <<-INPUT_END &&
 	blob
 	mark :1
@@ -542,6 +542,86 @@ test_expect_success 'B: fail on invalid file path' '
 	test_must_fail git fast-import <input
 '
 
+test_expect_success 'B: fail on invalid file path of .' '
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data <<EOF
+	File contents
+	EOF
+
+	commit refs/heads/badpath
+	committer Name <email> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	Commit Message
+	COMMIT
+	M 100644 :1 ./invalid-path
+	INPUT_END
+
+	test_when_finished "git update-ref -d refs/heads/badpath" &&
+	test_must_fail git fast-import <input
+'
+
+test_expect_success WINDOWS 'B: fail on invalid file path of C:' '
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data <<EOF
+	File contents
+	EOF
+
+	commit refs/heads/badpath
+	committer Name <email> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	Commit Message
+	COMMIT
+	M 100644 :1 C:/invalid-path
+	INPUT_END
+
+	test_when_finished "git update-ref -d refs/heads/badpath" &&
+	test_must_fail git fast-import <input
+'
+
+test_expect_success 'B: fail on invalid file path of .git' '
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data <<EOF
+	File contents
+	EOF
+
+	commit refs/heads/badpath
+	committer Name <email> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	Commit Message
+	COMMIT
+	M 100644 :1 .git/invalid-path
+	INPUT_END
+
+	test_when_finished "git update-ref -d refs/heads/badpath" &&
+	test_must_fail git fast-import <input
+'
+
+test_expect_success 'B: fail on invalid file path of .gitmodules' '
+	cat >input <<-INPUT_END &&
+	blob
+	mark :1
+	data <<EOF
+	File contents
+	EOF
+
+	commit refs/heads/badpath
+	committer Name <email> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	Commit Message
+	COMMIT
+	M 120000 :1 .gitmodules
+	INPUT_END
+
+	test_when_finished "git update-ref -d refs/heads/badpath" &&
+	test_must_fail git fast-import <input
+'
+
 ###
 ### series C
 ###
@@ -966,7 +1046,7 @@ test_expect_success 'L: verify internal tree sorting' '
 	:100644 100644 M	ba
 	EXPECT_END
 
-	git fast-import <input &&
+	git -c core.protectNTFS=false fast-import <input &&
 	GIT_PRINT_SHA1_ELLIPSIS="yes" git diff-tree --abbrev --raw L^ L >output &&
 	cut -d" " -f1,2,5 output >actual &&
 	test_cmp expect actual
@@ -3117,7 +3197,7 @@ test_path_eol_success () {
 	test_expect_success "S: paths at EOL with $test must work" '
 		test_when_finished "git branch -D S-path-eol" &&
 
-		git fast-import --export-marks=marks.out <<-EOF >out 2>err &&
+		git -c core.protectNTFS=false fast-import --export-marks=marks.out <<-EOF >out 2>err &&
 		blob
 		mark :401
 		data <<BLOB
@@ -3226,7 +3306,7 @@ test_path_space_success () {
 	test_expect_success "S: paths before space with $test must work" '
 		test_when_finished "git branch -D S-path-space" &&
 
-		git fast-import --export-marks=marks.out <<-EOF 2>err &&
+		git -c core.protectNTFS=false fast-import --export-marks=marks.out <<-EOF 2>err &&
 		blob
 		mark :401
 		data <<BLOB
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 1eb035ee4ce..bb83e5accd9 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -631,7 +631,7 @@ test_expect_success 'fast-export quotes pathnames' '
 	 git rev-list HEAD >expect &&
 	 git init result &&
 	 cd result &&
-	 git fast-import <../export.out &&
+	 git -c core.protectNTFS=false fast-import <../export.out &&
 	 git rev-list HEAD >actual &&
 	 test_cmp ../expect actual
 	)

base-commit: 4a2790a257b314ab59f6f2e25f3d7ca120219922
-- 
gitgitgadget
