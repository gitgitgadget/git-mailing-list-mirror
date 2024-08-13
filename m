Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DA51386C0
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585530; cv=none; b=e5vRXvgjSSYTolj7/ojk0VTh0CxZAzNmNwqR4QIbaf185gI+B7DACdgbgHn/UEiHNMGkJbiMRYqvWqFiphtX1ZtRBq0NZ/488KknkKEVvuvWSlZxKMfaNdBf85yRQMeXFcKDHSHJUZyZ/X4xhc6jT1pnwtA8f6j09A/y1JuSGrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585530; c=relaxed/simple;
	bh=TBWCXrgSjbDIMWFCLcEhRLPvQSI5+XgI8NNyQ81jo8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R3fCX5wr3qQgYOM3lIHS3ND1y5nX+HEszncQCbZFq5GjFm952nXHEPneINlS/slj7/KUkMhL4vkOYs5q9j9zDkJs/Wbo1Hv8aInjAJP7+g5FyaBy9oNLyt4zHxB9Lmpbhh1roE6wxXeFBftpRmmw2/JDtwzpecWsuHfZyVDWYZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCT4NkcE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCT4NkcE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723585528; x=1755121528;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=TBWCXrgSjbDIMWFCLcEhRLPvQSI5+XgI8NNyQ81jo8s=;
  b=NCT4NkcEnjnnbFYXn9OhAwehNSYLJi3lg2WCrWpFoO9yDnGOd8cqlyTU
   JxyqySaZCRaxySZPYsSLpq+FIa6n2kvkm7H5EAIgDcICzCLMv5tCsrPmR
   k43Nl1iZXPQuWj0snCBGgzVywxhhgmFV0jijVS/DiXbN8AhIDtaGIry3N
   APtW9bq7zDJbPQ1NF8jb55CiIxcENuBynla4rcc/IQNA3qdlNSAMFOcs0
   dp56ZelIhCtnIsxT+Su9yc17iqMc8XrDTlI5wqIL8uyKbUq/YVt0DCX36
   kGarqPdwfx8A7CZ//6E6wdiijqzs+U5Y98+8ChRoe8gDuABfEpKhPxdTI
   Q==;
X-CSE-ConnectionGUID: gi/mfwHTQ76NkES5dE4fuQ==
X-CSE-MsgGUID: urMZynkMQlWsz8y/35ABuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21909891"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21909891"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:45:27 -0700
X-CSE-ConnectionGUID: /u3La4SpTi+kIZk6GsGvzw==
X-CSE-MsgGUID: w62QEoaVSIqkJntyeKKybg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63213778"
Received: from jekeller-desk.amr.corp.intel.com (HELO localhost.localdomain) ([10.166.241.1])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:45:26 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 13 Aug 2024 14:45:22 -0700
Subject: [PATCH] format-patch: add support for mailmap file
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240813-jk-support-mailmap-git-format-patch-v1-1-1aea690ea5dd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPLTu2YC/x3NTQqDMBBA4avIrDswSSz9uUpxMWii0zYmTNIii
 Hdv6PLbvLdD8Sq+wL3bQf1XiqS1wZw6GBdeZ48yNYMl29PVOHy+sHxyTloxsrwjZ5ylYkgauWL
 mOi7YuxtdXLBnMgStlNUH2f6Xx3AcP1v8VKR1AAAA
To: git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
X-Mailer: b4 0.14.0

From: Jacob Keller <jacob.keller@gmail.com>

Git has support for a mailmap file which translates author and committer
names and email addresses to canonical values.

Git log has log.mailmap, and the associated --mailmap and --use-mailmap
options.

Teach git format-patch the format.mailmap and --mailmap options so that
formatting a patch can also reflect the canonical values from the
mailmap file.

Reported-by: Anthony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/log.c                      | 13 ++++++++++
 Documentation/git-format-patch.txt |  7 ++++++
 t/t4014-format-patch.sh            | 49 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4d4b60caa76a..94560add6fbc 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -975,6 +975,7 @@ struct format_config {
 	struct log_config log;
 	enum thread_level thread;
 	int do_signoff;
+	int use_mailmap;
 	enum auto_base_setting auto_base;
 	char *base_commit;
 	char *from;
@@ -1131,6 +1132,10 @@ static int git_format_config(const char *var, const char *value,
 		cfg->do_signoff = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "format.mailmap")) {
+		cfg->use_mailmap = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "format.signature")) {
 		FREE_AND_NULL(cfg->signature);
 		return git_config_string(&cfg->signature, var, value);
@@ -2042,6 +2047,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("generate a cover letter")),
 		OPT_BOOL(0, "numbered-files", &just_numbers,
 			    N_("use simple number sequence for output file names")),
+		OPT_BOOL(0, "use-mailmap", &cfg.use_mailmap, N_("use mail map file")),
+		OPT_ALIAS(0, "mailmap", "use-mailmap"),
 		OPT_STRING(0, "suffix", &fmt_patch_suffix, N_("sfx"),
 			    N_("use <sfx> instead of '.patch'")),
 		OPT_INTEGER(0, "start-number", &start_number,
@@ -2160,6 +2167,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	rev.force_in_body_from = force_in_body_from;
 
+	if (cfg.use_mailmap) {
+		rev.mailmap = xmalloc(sizeof(struct string_list));
+		string_list_init_nodup(rev.mailmap);
+		read_mailmap(rev.mailmap);
+	}
+
 	if (!fmt_patch_suffix)
 		fmt_patch_suffix = cfg.fmt_patch_suffix;
 
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 8708b3159309..f3de349990bf 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -30,6 +30,7 @@ SYNOPSIS
 		   [--range-diff=<previous> [--creation-factor=<percent>]]
 		   [--filename-max-length=<n>]
 		   [--progress]
+		   [(--mailmap|--no-mailmap|--use-mailmap|--no-use-mailmap)]
 		   [<common-diff-options>]
 		   [ <since> | <revision-range> ]
 
@@ -145,6 +146,12 @@ include::diff-options.txt[]
 	Print all commits to the standard output in mbox format,
 	instead of creating a file for each one.
 
+--[no-]mailmap::
+--[no-]use-mailmap::
+	Use mailmap file to map author and committer names and email
+	addresses to canonical real names and email addresses. See
+	linkgit:git-shortlog[1].
+
 --attach[=<boundary>]::
 	Create multipart/mixed attachment, the first part of
 	which is the commit message and the patch itself in the
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 884f83fb8a45..3a3ebddfe5c4 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1215,7 +1215,7 @@ check_author() {
 	echo content >>file &&
 	git add file &&
 	GIT_AUTHOR_NAME=$1 git commit -m author-check &&
-	git format-patch --stdout -1 >patch &&
+	git format-patch $2 --stdout -1 >patch &&
 	sed -n "/^From: /p; /^ /p; /^$/q" patch >actual &&
 	test_cmp expect actual
 }
@@ -1285,6 +1285,53 @@ test_expect_success 'format-patch wraps extremely long from-header (rfc2047)' '
 	check_author "Foö Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar"
 '
 
+cat >mail.map <<'EOF'
+Foo B. Baz <author@example.com>
+EOF
+
+cat >expect <<'EOF'
+From: "Foo B. Baz" <author@example.com>
+EOF
+test_expect_success 'format-patch format.mailmap maps properly' '
+	test_config format.mailmap true &&
+	test_config mailmap.file mail.map &&
+	check_author "Foo B. Bar"
+'
+
+cat >expect <<'EOF'
+From: "Foo B. Bar" <author@example.com>
+EOF
+test_expect_success 'format-patch --no-mailmap overrides format.mailmap' '
+	test_config format.mailmap true &&
+	test_config mailmap.file mail.map &&
+	check_author "Foo B. Bar" "--no-mailmap"
+'
+
+cat >expect <<'EOF'
+From: "Foo B. Bar" <author@example.com>
+EOF
+test_expect_success 'format-patch --no-use-mailmap overrides format.mailmap' '
+	test_config format.mailmap true &&
+	test_config mailmap.file mail.map &&
+	check_author "Foo B. Bar" "--no-use-mailmap"
+'
+
+cat >expect <<'EOF'
+From: "Foo B. Baz" <author@example.com>
+EOF
+test_expect_success 'format-patch --mailmap' '
+	test_config mailmap.file mail.map &&
+	check_author "Foo B. Bar" "--mailmap"
+'
+
+cat >expect <<'EOF'
+From: "Foo B. Baz" <author@example.com>
+EOF
+test_expect_success 'format-patch --use-mailmap' '
+	test_config mailmap.file mail.map &&
+	check_author "Foo B. Bar" "--use-mailmap"
+'
+
 cat >expect <<'EOF'
 From: Foö Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar
  Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo

---
base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
change-id: 20240813-jk-support-mailmap-git-format-patch-439073f25010

Best regards,
-- 
Jacob Keller <jacob.keller@gmail.com>

