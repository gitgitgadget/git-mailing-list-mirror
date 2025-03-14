Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A6645
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 00:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741911660; cv=none; b=E7DKk9bHpWSGSf4XQZ5YaD9MAJzEkwlQTvv81L9H5aA/pIb3YrOzFovL6bXSlYsmfGwXj0+lLsd2dAEwQZlAh8gnIlBmH7T4HoNgXG/K7OzdOj8asrEOzhFkL0mVp54Td/YrdkLGfIgebaIKYO/0GO+q/fCUmJQSuW4ZcR/qAAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741911660; c=relaxed/simple;
	bh=mRgayroK1BcvKQ1Rwkhhb2r2ZaNecThni6T14iI6YB0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nrLaBaBbM316J8wh06w04nEx0aHfdJJWKxdV+ZQvSYM2V/KY+E2Fl80rL8B+BRZjQylGRSsr+pRD6aHJWUqHVeHdjd420vM/i2RbqNtApoThD6iDL4OQOLgYEPai/ntadea69nu5B/Jlpyun07O5PVecgefTw1P/MG6/8uTC5x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agY239zb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agY239zb"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913fdd003bso843105f8f.1
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741911656; x=1742516456; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b18BZcSRc2K7cJv/D+oSBt1xsZUSo9cA8FGp4u8zQRI=;
        b=agY239zbjajhTmXIxjRrVtzKjjS4/Nl9Wj72ICTTWJAy6vk8/ngLtUDZrWFijZIZvV
         4uuNLBaNosSZ6DCS+WFDZJ1t0f8l5DNpl4ZzQ/M5giBnZK4w6q10LvVaON6+tCuYCRhc
         0QB6AXL9pgY812i1U5B79V2Mk64h6bgXu3/4tsVVcDJ7FzSqs4ydmAURIxXv2+mVL+F0
         tX7XuAj6os9EmGouIe6F2gvPhSLrjkvUY3dFaRPP4MponDltYtW3spQ2g5gZITLfP4OF
         8Zv1GsnJokj/ZfyBZthrXbJMh2pZUIytFcj/XnJ8dQwVzuxXP0wJSfiDkfzY2pLCYUJM
         A0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741911656; x=1742516456;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b18BZcSRc2K7cJv/D+oSBt1xsZUSo9cA8FGp4u8zQRI=;
        b=I896cL0okOC8qPe/oXDip0wzqZbCOvEUsw3cnCOS9TtRVEZAM3ovavgc5vIKjHOzJl
         /sgtxMVtWgXrRmNX5v+EHzgCMEwkV8NBGay5dffsv91269Ql1ZAKBglI4yZWIPpCvp+t
         vcfFShjVw+SjWFEUillxO7+Kk+TBxR3/OX+8k/ML8PJ/qcYkAKu3mC4MMpplPeYI0wPS
         vA7i7ybI2ZOBYWVug6uDQzEWqfTN7hWJMFb2TEvcWieVVz/c5SB0pLxv7r+VlbyukJ18
         0shbYzDU6aWcARmwkrOauH80Kpx8pQjVMSUBd6Od+uGyxlpd6NnqwxP9+nNKMT+Y01lA
         ERpA==
X-Gm-Message-State: AOJu0YxVhzHAS3L5A3xyQf6XtIO6m5Dg97i8GyII3EBpOAvgay3mi3QW
	VKIc9D39tc77MN0rh7y8XpC47DvR91Vttvovi588qLedNN0iuk0xOuAhsQ==
X-Gm-Gg: ASbGncvSp50E+BNTAnRby1t+YPQ02lNjSkc9frC48cKCoXqWg9gb+VJqs+oqSuQYrxp
	ev9sGtYlH5XJlSbJT0y1mw72FFdmplA3OoqpX5j6UnNC6p13MbnTMNfin+SqStDrQ8m2DUhcVCl
	UHYt3PGOzeLe7b3IzeS+pYd/xxDe/IeOuOzTa+8PvdSFdg81WNXjbwZvVAnxPdXv+X9ew/Cg4aL
	1ZAzm2PZLgOH7ToVjzBKMge8cot1ahagnIRQHlhMOBme+PbsqRyktAPzU33CtwQVIkldvFy4ot6
	VU2Pnuo4kev6vpcZorZ7ZpwGxk0X2TrSPSRPebZbi8vQUQ==
X-Google-Smtp-Source: AGHT+IETWu3r7f8/skQpVXs1kPJifZaYtDpJh2fnYrj875Ji6kEyLEBToujmhHEJfeE4wdi0Kx4oWg==
X-Received: by 2002:a05:6000:1447:b0:391:65c:1b05 with SMTP id ffacd0b85a97d-3971bfce005mr519747f8f.11.1741911656384;
        Thu, 13 Mar 2025 17:20:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a10sm3706888f8f.36.2025.03.13.17.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 17:20:54 -0700 (PDT)
Message-Id: <80dcc2ba3aa0ef72abe18f8525d571ea39ac6382.1741911652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Mar 2025 00:20:51 +0000
Subject: [PATCH 2/3] ci: add build checking for side-effects in assert() calls
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

It is a big no-no to have side-effects in an assertion, because if the
assert() is compiled out, you don't get that side-effect, leading to the
code behaving differently.  That can be a large headache to debug.

We have roughly 566 assert() calls in our codebase (my grep might have
picked up things that aren't actually assert() calls, but most appeared
to be).  All but 9 of them can be determined by gcc to be free of side
effects with a clever redefine of assert().  The current 9 appear to be
free of side effects to me as well, but are too complicated for a
compiler/linker to figure that since each assertion involves some kind
of function call.  Add a CI job which will find and report these
possibly problematic assertions, and have the job suggest to the user
that they replace these with BUG_IF_NOT() calls.

Example output from running:

```
ERROR: The compiler could not verify the following assert()
       calls are free of side-effects.  Please replace with
       BUG_IF_NOT() calls.
/home/newren/floss/git/diffcore-rename.c:1409
	assert(!dir_rename_count || strmap_empty(dir_rename_count));
/home/newren/floss/git/merge-ort.c:1645
			assert(renames->deferred[side].trivial_merges_okay &&
			       !strset_contains(&renames->deferred[side].target_dirs,
						path));
/home/newren/floss/git/merge-ort.c:794
	assert(omittable_hint ==
	       (!starts_with(type_short_descriptions[type], "CONFLICT") &&
		!starts_with(type_short_descriptions[type], "ERROR")) ||
	       type == CONFLICT_DIR_RENAME_SUGGESTED);
/home/newren/floss/git/merge-recursive.c:1200
	assert(!merge_remote_util(commit));
/home/newren/floss/git/object-file.c:2709
	assert(would_convert_to_git_filter_fd(istate, path));
/home/newren/floss/git/parallel-checkout.c:280
	assert(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
/home/newren/floss/git/scalar.c:244
	assert(have_fsmonitor_support());
/home/newren/floss/git/scalar.c:254
	assert(have_fsmonitor_support());
/home/newren/floss/git/sequencer.c:4968
		assert(!(opts->signoff || opts->no_commit ||
			 opts->record_origin || should_edit(opts) ||
			 opts->committer_date_is_author_date ||
			 opts->ignore_date));
```

Note that if there are possibly problematic assertions, not necessarily
all of them will be shown in a single run, because the compiler errors
may include something like "ld: ... more undefined references to
`not_supposed_to_survive' follow" instead of listing each individually.
But in such cases, once you clean up a few that are shown in your first
run, subsequent runs will show (some of) the ones that remain, allowing
you to iteratively remove them all.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Makefile                      |  4 ++++
 ci/check-unsafe-assertions.sh | 18 ++++++++++++++++++
 ci/run-static-analysis.sh     |  2 ++
 git-compat-util.h             |  6 ++++++
 4 files changed, 30 insertions(+)
 create mode 100755 ci/check-unsafe-assertions.sh

diff --git a/Makefile b/Makefile
index 7315507381e..57774912f18 100644
--- a/Makefile
+++ b/Makefile
@@ -2261,6 +2261,10 @@ ifdef WITH_BREAKING_CHANGES
 	BASIC_CFLAGS += -DWITH_BREAKING_CHANGES
 endif
 
+ifdef CHECK_ASSERTION_SIDE_EFFECTS
+	BASIC_CFLAGS += -DCHECK_ASSERTION_SIDE_EFFECTS
+endif
+
 ifdef INCLUDE_LIBGIT_RS
 	# Enable symbol hiding in contrib/libgit-sys/libgitpub.a without making
 	# us rebuild the whole tree every time we run a Rust build.
diff --git a/ci/check-unsafe-assertions.sh b/ci/check-unsafe-assertions.sh
new file mode 100755
index 00000000000..d66091efd22
--- /dev/null
+++ b/ci/check-unsafe-assertions.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+make CHECK_ASSERTION_SIDE_EFFECTS=1 >compiler_output 2>compiler_error
+if test $? != 0
+then
+    echo "ERROR: The compiler could not verify the following assert()" >&2
+    echo "       calls are free of side-effects.  Please replace with" >&2
+    echo "       BUG_IF_NOT() calls." >&2
+    grep undefined.reference.to..not_supposed_to_survive compiler_error \
+      | sed -e s/:[^:]*$// | sort | uniq | tr ':' ' ' \
+      | while read f l
+      do
+	printf "${f}:${l}\n  "
+	awk -v start="$l" 'NR >= start { print; if (/\);/) exit }' $f
+      done
+    exit 1
+fi
+rm compiler_output compiler_error
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index 0d51e5ce0e7..ae714e020ae 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -31,4 +31,6 @@ exit 1
 
 make check-pot
 
+${0%/*}/check-unsafe-assertions.sh
+
 save_good_tree
diff --git a/git-compat-util.h b/git-compat-util.h
index c3415ad7e0a..0aefd763751 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1584,4 +1584,10 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
 	((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
 #endif /* !__GNUC__ */
 
+#ifdef CHECK_ASSERTION_SIDE_EFFECTS
+#undef assert
+extern int not_supposed_to_survive;
+#define assert(expr) ((void)(not_supposed_to_survive || (expr)))
+#endif /* CHECK_ASSERTION_SIDE_EFFECTS */
+
 #endif
-- 
gitgitgadget

