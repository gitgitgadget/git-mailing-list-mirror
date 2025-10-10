Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8F02EF675
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092043; cv=none; b=TdhFpCHvXCmI6aqAxTol1jckIHtuFmtYNREHqhm+M607fYjMKAkR0MjudFl4NYxFAC6Q3E3zk7Fy7dDzWmb0U8+ZPW2T0w+oEqCKQbMEB0uIZQyvjo2ZmVRpepbnUwymOeUHiep6plzTi/sactXXvDJAZMCMG8fmwBytmXkZVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092043; c=relaxed/simple;
	bh=aPC3NoOShDVdaQSwXYZ5o5ftkAYifJR/Xd5f77j0IXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jApP1ZIRWG6TssOSrm13EON4+FfEMDimNNmtu6prWUmqyBSX/s8Dg3Wl4GnlZr56DHKheVJ+McEfhEPmTPnKDa9lxQAPb7WcDwft/H6Ucdz67DnoKzmoPox0X44K09AKIeXeSGGxk4+vHNDpoxCwmOqshcAAYsvwtgXxPapi9Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FngGbdhq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FngGbdhq"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso3523126a12.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 03:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760092040; x=1760696840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKNHL1fvRN8NHvGj3H5WPlGv33VzELZebFlYKp+EZpo=;
        b=FngGbdhqP3avUxqftykHLGFHS1s0r5+8jsDYP3xiH0MRPSql7xzZ59MWN+K35BIvsb
         6AHtBTCqwGbfZRaDyDrlrYU3vKlzkPvzEF5I8IHelrTDpX1IviWDsVweIY8f1jNMGPMw
         QLzW7JDYFtPQOYKLqVPLck9UBSPwy60h+k3FpJLFbyvCL9/EWAQ6zv3esxzqQVgPdVqL
         ant9UUpwFqqoJWeyEWllCL+diyqq+zgQuVnzC2atclPxxp0wlJ+o2YUodIG3ZxY/bQnX
         z4YQLq+wGShD7G3/gGOES/KulQVDoibnxvCVaOjPJ9zxycjNiTUotgmEjdXicpx7Z0kv
         cyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760092040; x=1760696840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKNHL1fvRN8NHvGj3H5WPlGv33VzELZebFlYKp+EZpo=;
        b=nwXmiGW/Xz4wSyVCbqPVjp5zrpYvrQjCYtK416hjQiRtgcsWTMO77yf1s6k57HON++
         SIw48+qNf9AX0u1ITwjHA2PcY1DOUVm5R2QcmqJP49oQPRh8NEpnyl4C6Lyz4NgVxVlw
         J6M52VScdLWp5O6Nb2Z2OaIlCDBXCtKyKRP4AiTrp5j5WbBzH08/1aYejjeT3FABdTsa
         w95dlHKjqoyRA/sfHOMxg1kH4fWBRaJPhPjvfUeYgARqya+4GwK2rBTpo30v0RrJZu2q
         l822jrvObaLBPUszwnkhRT6ED0vzbeuGAO18+lGbrguBVp4jZaq0Aky5YHWyF7sYF9Yu
         JlNA==
X-Gm-Message-State: AOJu0Yz5VfMEKsH6zMHKg0VHHz1CM3eaGBxq5bjy4B56Yjh7Syg5WNTk
	JuGAcAdq59zFl20NQ67vfdn8i4ikmK0RFkS0e1N7W8uHwnwDKeKSbku3Z+M9N/lj
X-Gm-Gg: ASbGncuXV7/HWQCgGeSPZ+9cXKItOkiWWqZsBkMjHo4SCHAaTg85+ZBT1W2Z+UNV7kp
	gMqVvByILAAOehFql4l6/HQ2VDqZ2zJXXookZHVz4kyUmdH1x5E0g/XvM+cvYeZ3vhECjLZu4gL
	39qxSMewc65NcsfJPRY0jAPFiZX8vo62mHNmdjvaRUOd5/6k2ejU6Qt/RshgVCPbG9Pm6LezFM2
	JfEHLArLYtrp0rNLMUEMQVm6hF/QZ7xLwVCHHEV23ArQC6hZP/J/KnQaHzshOC7RVG2asdkTnZ7
	khGZge6dvWtFcGKn28Cz1slvZBNVqJbMBW4HpfyR8wpKiqx1A0IF0eRJEnLl4kp3r1+j9h4QTHC
	vsQWbEcz6hX4ncbdwLopIfdvcE99HEcHW2hLcEDk+Z2aq3xCtiD+mV9ntTg==
X-Google-Smtp-Source: AGHT+IFJovVukOTR+onIqza5RNfwim3are9m6SX1+U/gKiQLXlvTUPcV85scFJwzRTtNyTxQMilIXw==
X-Received: by 2002:a05:6402:518b:b0:62f:4915:bc47 with SMTP id 4fb4d7f45d1cf-639d5b41857mr9220989a12.1.1760092039622;
        Fri, 10 Oct 2025 03:27:19 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:70de:2d8a:d550:c37c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f750sm1960729a12.14.2025.10.10.03.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:27:19 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 10 Oct 2025 12:27:13 +0200
Subject: [PATCH 9/9] refs: add a '--required' flag to 'git refs optimize'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-9-c7962be584fa@gmail.com>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8058; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=aPC3NoOShDVdaQSwXYZ5o5ftkAYifJR/Xd5f77j0IXg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjo34AbRFS5wfZJpTIvidKAfj1rElTWpAgH+
 EYC8QRgs9Fb5okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo6N+AAAoJED7VnySO
 Rox/QWML/jkHy2aiWWutLRjVrAsYL1VcKijsG+pwE7+dQRPh5EiVLYVoWXUMAxtheJEDO4EMuWS
 j1O2JHEJcwDAum3xZk0R6ho1T681lllbhMlqF6F9upGepinQTQfuQUtyv3T3eaNDWXoHsSjCD1J
 4ebrRaMZcpoG6zZqmdhRE0hH73FMOtXELtNPcgFwzIEj5oxTlwA5/YDlgjek+3U2l8+8szi6xxm
 UDjD1+t7tLbAdYF+MhzVB6TTOjsSASrT7yg0gxuXjPPlb/C2QxBnrfXFiVIIWFIlMe0bMjW/E8B
 A33BsVjvevHuol6M7s5/kcFIDETIVQQSlKJsUr3AfvHGTo6rgndElrQVZ2wB77BdiOLeAJCZWJV
 M0gMdEFr6WcXWrP3ovggLr3fxZU9x9HKwuCiaurJRS0/xfCfHa8UNK8phDsoRrXIvhym8pl+8Si
 85CEDRlARNTXV8oTq3MNfIuMC6mhApIbabojW/EGjLtk77VA2QHlndQsKJj15S5qjT2OZjEWkF4
 7c=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git pack-refs' and 'git refs optimize' commands allow users to
optimize their reference backends. However they provide no functionality
to check if optimization is required without performing it.

Add a '--required' flag to these commands to do that. This is useful
on the server side where this information can be utilized to perform
more targetted maintenance runs of the repository.

Add a corresponding test for the files backend. For the reftable
backend, this cannot be tested easily as it performs auto-compaction.
However, an earlier commit ensured the functionality was covered by
unit test.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-pack-refs.adoc     |  1 +
 Documentation/git-refs.adoc          |  1 +
 Documentation/pack-refs-options.adoc |  5 +++++
 builtin/pack-refs.c                  |  2 +-
 builtin/refs.c                       |  2 +-
 pack-refs.c                          | 11 ++++++++++-
 pack-refs.h                          | 10 ++++++++--
 refs.c                               |  7 +++++++
 refs.h                               |  7 +++++++
 t/pack-refs-tests.sh                 | 20 ++++++++++++++++++++
 10 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-pack-refs.adoc b/Documentation/git-pack-refs.adoc
index fde9f2f294..62bc01b29b 100644
--- a/Documentation/git-pack-refs.adoc
+++ b/Documentation/git-pack-refs.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git pack-refs' [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
+                [--required]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index fa33680cc7..4df28b7d92 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -20,6 +20,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [ --stdin | (<pattern>...)]
 git refs exists <ref>
 git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
+		  [--required]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/pack-refs-options.adoc b/Documentation/pack-refs-options.adoc
index 0b11282941..66d69530b9 100644
--- a/Documentation/pack-refs-options.adoc
+++ b/Documentation/pack-refs-options.adoc
@@ -50,3 +50,8 @@ the provided `--exclude` patterns.
 +
 When used with `--include`, refs provided to `--include`, minus refs that are
 provided to `--exclude` will be packed.
+
+--required::
+
+Check if pack-refs is required to run, without actually performing the changes.
+Returns an exit code of 0 if optimization is required.
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 3446b84cda..bd2df4d0b7 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -8,7 +8,7 @@ int cmd_pack_refs(int argc,
 		  struct repository *repo)
 {
 	static char const * const pack_refs_usage[] = {
-		N_("git pack-refs " PACK_REFS_OPTS),
+		N_("git pack-refs " PACK_REFS_OPTS(PACK_REFS_OPTS_SPACES_14)),
 		NULL
 	};
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 3064f888b2..fca55997be 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -20,7 +20,7 @@
 	N_("git refs exists <ref>")
 
 #define REFS_OPTIMIZE_USAGE \
-	N_("git refs optimize " PACK_REFS_OPTS)
+	N_("git refs optimize " PACK_REFS_OPTS(PACK_REFS_OPTS_SPACES_18))
 
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo UNUSED)
diff --git a/pack-refs.c b/pack-refs.c
index fee77fbf9f..5d4d4266de 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -21,6 +21,7 @@ int pack_refs_core(int argc,
 	};
 	struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
+	bool check_required = false;
 	int pack_all = 0;
 	int ret;
 
@@ -28,6 +29,7 @@ int pack_refs_core(int argc,
 		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
 		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), OPTIMIZE_REFS_PRUNE),
 		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), OPTIMIZE_REFS_AUTO),
+		OPT_BOOL(0, "required", &check_required, N_("check if optimization is required")),
 		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
 			N_("references to include")),
 		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
@@ -47,7 +49,14 @@ int pack_refs_core(int argc,
 	if (!pack_refs_opts.includes->nr)
 		string_list_append(pack_refs_opts.includes, "refs/tags/*");
 
-	ret = refs_optimize(get_main_ref_store(repo), &pack_refs_opts);
+	if (check_required) {
+		bool required = false;
+		ret = refs_optimize_required(get_main_ref_store(repo), &pack_refs_opts,
+					     &required);
+		ret |= !required;
+	} else {
+		ret = refs_optimize(get_main_ref_store(repo), &pack_refs_opts);
+	}
 
 	clear_ref_exclusions(&excludes);
 	string_list_clear(&included_refs, 0);
diff --git a/pack-refs.h b/pack-refs.h
index 5de27e7da8..59951ff692 100644
--- a/pack-refs.h
+++ b/pack-refs.h
@@ -7,9 +7,15 @@ struct repository;
  * Shared usage string for options common to git-pack-refs(1)
  * and git-refs-optimize(1). The command-specific part (e.g., "git refs optimize ")
  * must be prepended by the caller.
+ *
+ * Since multiple commands use the same opts, they need to provide the appropriate
+ * spaces for correct alignment.
  */
-#define PACK_REFS_OPTS \
-	"[--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]"
+#define PACK_REFS_OPTS_SPACES_14 "              "
+#define PACK_REFS_OPTS_SPACES_18 "                  "
+#define PACK_REFS_OPTS(spaces)                                                        \
+	"[--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]\n" \
+	spaces "[--required]"
 
 /*
  * The core logic for pack-refs and its clones.
diff --git a/refs.c b/refs.c
index 514fb85af2..59a48b36b7 100644
--- a/refs.c
+++ b/refs.c
@@ -2317,6 +2317,13 @@ int refs_optimize(struct ref_store *refs, struct optimize_refs_opts *opts)
 	return refs->be->optimize(refs, opts);
 }
 
+int refs_optimize_required(struct ref_store *refs,
+			   struct optimize_refs_opts *opts,
+			   bool *required)
+{
+	return refs->be->optimize_required(refs, opts, required);
+}
+
 int reference_get_peeled_oid(struct repository *repo,
 			     const struct reference *ref,
 			     struct object_id *peeled_oid)
diff --git a/refs.h b/refs.h
index 58b222ac02..59f0e519c0 100644
--- a/refs.h
+++ b/refs.h
@@ -522,6 +522,13 @@ struct optimize_refs_opts {
  */
 int refs_optimize(struct ref_store *refs, struct optimize_refs_opts *opts);
 
+/*
+ * Check if refs backend can be optimized by calling 'refs_optimize'.
+ */
+int refs_optimize_required(struct ref_store *ref_store,
+			   struct optimize_refs_opts *opts,
+			   bool *required);
+
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
  */
diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 6a71838ffa..d3e58572e2 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -460,3 +460,23 @@ test_expect_success 'pack-refs does not store invalid peeled tag value' '
 	)
 '
 
+test_expect_success "refs optimize --required works as expected" '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty --message "initial" &&
+		test_must_fail git ${pack_refs} --all --auto --required &&
+
+		# Create 14 additional references, which brings us to
+		# 15 together with the default branch.
+		printf "create refs/heads/loose-%d HEAD\n" $(test_seq 14) >stdin &&
+		git update-ref --stdin <stdin &&
+		test_path_is_missing .git/packed-refs &&
+		test_must_fail git ${pack_refs} --all --auto --required &&
+
+		# Create the 16th reference, which should cause us to repack.
+		git update-ref refs/heads/loose-15 HEAD &&
+		git ${pack_refs} --all --auto --required
+	)
+'

-- 
2.51.0

