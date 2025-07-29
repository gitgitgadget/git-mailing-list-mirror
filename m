Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E83A2594BD
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753777154; cv=none; b=R2dh+Jku5Sf0s9hwIsBqgRKj5QAhAiBL3g6vanIohY6FKJGWnLZ9J8o/9fhLGsXG1aeAPdWpDPDfi/gAS6yGmIGFl4X2b7rHYwcs7bNQCvm+Vnx2J/rh1eHy/y1t99jLGRXirbYJq2bRy8ZVLyV8bufHwcdadLFI2KvTrF9dny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753777154; c=relaxed/simple;
	bh=Z6/tzLKsADSdI5Q3gCka4rcXV4jbvNrX1grjQsbHVQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJgwHDqnMRRUrPXw88PRNYCmi+IhXp3+gbXvYFlB3qUpUnYMP7HlccBSrwyPpF4Je41+P7I0qVoR3yYATNkV2U9o/52vkLZIwC6zYf+oEuPzHGzocwCMRqAk/caE9OjpH67ZlKB0JeDV5b3HJtANwl/7NvUSYVQwZKZPBkCnoAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzKyB/Vr; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzKyB/Vr"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-749248d06faso4551778b3a.2
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 01:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753777152; x=1754381952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8oN3Hk4+qJiRjJAym8MSx2pYwUyFywx+ShdpxEmajI=;
        b=UzKyB/Vr/x/rOQNyZl0y40WWLKjVkEOsKbMnwe9oZ6ClyyZsN3707pMRUIOenAZex/
         v+ZnDCGeznjaoiM4ivQNq0EGbu9QWziK1UxiLhfCWCmWXZmIY8hhQb4G6LGSamDy6/Dn
         d6FpltlWfoEHN5tJ4hJZZAHebv9YvFjpU/f6d9WRtumsco28850YJINmu3e5+6pZehhl
         4TMyjF+8NKf/vv+IZJEHS5PwH/OAu2OVchwxGxWk/w0BH+rEHoEMH9LQBPS1uVoQg0Y1
         Lu2JksNbF/J/qzlOin5kvO+BbHO0Ueds0M2a420Xsj8SVhnvTUeb/hdFE80nicRjU8Zd
         cspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753777152; x=1754381952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8oN3Hk4+qJiRjJAym8MSx2pYwUyFywx+ShdpxEmajI=;
        b=DGoJAP0S9phGoKnEyPfuu2rJPzFO+cKTKeylUE++4xPdU98HZZnb5C4Vs9W+bpl3BX
         qXQGQPYAqsi051vq9/Tg4U237tfqTVp3uwS8j7eyCcYFgnR56BNY2zw7EkZGOKkarrud
         HO0hzvfBHcMQfGCoPPLtiETmd1Edfa7OnmEcqCKat6ab6IPTxNQ7YL9wuBKxCJC0PpmT
         H/6zCg10UOjI94NXiplmwtVfOC0w96NifrhkCmEZoQQwITbpxM53Lt8aNo0YBTc1yJ7/
         aaZsK+/bUb5mIxCn8DTeUPoZT5zQ89Zn8y8IV0wIA1UMpyCkGfKf6qZEt+RZgo0iQXj4
         oxBg==
X-Gm-Message-State: AOJu0YzJzppr8ZTHfVxmGuTWeGcrtPRdtgBaB8bUgHJHAuD8rpS9H8hU
	TmFWCHpnGpJMOHMJNfWm0ynSGjEOL8NqyMnvYLTxzQvB4JK54ak6HQmLKIuTgScDHGvAfQ==
X-Gm-Gg: ASbGncv7lvwd+w7bL3SS2jpdM+ZAPv+chjhE2ewVD1KZgfy0LeZAeLJvq/H227Zn2D+
	6P8clMvmclbNWaLq51TuyAOk/AxdKhKkcURQm4Y4RMKkXjMj28CLwwY1nKCs3AGlpqhW2S5NL7T
	zLJgS+Z0UYc0bid4lR3UC08dUkHGoiv9KmrWe5qYA1Nm0RN22iMq88uolsEZG5hNO9BQhPCVa1A
	Yi7HA1VyNAhG3fHY8yZMeMGrEFas1OfLuD+n8JtJVddnonZ6al1cs2KgS17yCLNv38RLa2JIIBP
	ThU9zs7dqMfgP6fUfxRNuaozjAMjXWdr7DTvV4+bk/JIItt9FDQWK6e5l0Peu+Qq1vL51/mTWLW
	5GuiHbTyt1LqReKcUEXrYlg05rbPJpmPVRqp5yeDsttsRZdsJSr2HdM7wnerVXWVs
X-Google-Smtp-Source: AGHT+IHcqjE1AKDQyhDknJJl+PxEwl+ZHiR9N1JCpE9mdUddA2WSBxF8FQ7YINaoGlqJI7VyNUWzuw==
X-Received: by 2002:a05:6a00:92a3:b0:758:72b9:e5da with SMTP id d2e1a72fcca58-763349b9fa3mr17034884b3a.17.1753777152259;
        Tue, 29 Jul 2025 01:19:12 -0700 (PDT)
Received: from localhost.localdomain (awork062197.netvigator.com. [203.198.28.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b2de3dbsm7385871b3a.113.2025.07.29.01.19.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Jul 2025 01:19:11 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	hi@arnes.space,
	michal@isc.org,
	peff@peff.net,
	yldhome2d2@gmail.com
Subject: [PATCH] diff: ensure consistent diff behavior with -I<regex> across output formats
Date: Tue, 29 Jul 2025 16:18:20 +0800
Message-ID: <20250729081820.34626-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.50.1.440.g2157409008
In-Reply-To: <xmqqikjg47qt.fsf@gitster.g>
References: <xmqqikjg47qt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the `-I<regex>` option was inconsistently applied across
various `git diff` output formats. In some cases, files would appear
in the `--name-only` output but not in the accompanying `--stat` or
`-p` outputs, despite the user explicitly requesting to ignore certain
changes using `-I<regex>`. To provide this consistency, Introduces
the diffcore_ignore() function in the new diffcore-ignore.c file, which
removes changes matching `-I<regex>`, and call diffcore_ignore() in
diffcore_std().

This patch ensures that the behavior of `-I<regex>` is applied
consistently across multiple diff output formats (`--name-only`,
`--name-status`, `--stat`, and `-p`). Only `--raw` and `--check` will
ignore `-I<regex>` and retain the original output.

Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
---
 Makefile                |   1 +
 diff.c                  |   2 +
 diffcore-ignore.c       | 152 ++++++++++++++++++++++++++++++++++++++++
 diffcore.h              |   1 +
 t/t4013-diff-various.sh |  57 ++++++++++++++-
 5 files changed, 211 insertions(+), 2 deletions(-)
 create mode 100644 diffcore-ignore.c

diff --git a/Makefile b/Makefile
index 5f7dd79dfa..2cdbd5d3fb 100644
--- a/Makefile
+++ b/Makefile
@@ -1014,6 +1014,7 @@ LIB_OBJS += diff-no-index.o
 LIB_OBJS += diff.o
 LIB_OBJS += diffcore-break.o
 LIB_OBJS += diffcore-delta.o
+LIB_OBJS += diffcore-ignore.o
 LIB_OBJS += diffcore-order.o
 LIB_OBJS += diffcore-pickaxe.o
 LIB_OBJS += diffcore-rename.o
diff --git a/diff.c b/diff.c
index dca87e164f..b9eed89531 100644
--- a/diff.c
+++ b/diff.c
@@ -7088,6 +7088,8 @@ void diffcore_std(struct diff_options *options)
 	}
 	if (options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK)
 		diffcore_pickaxe(options);
+	if (options->ignore_regex)
+		diffcore_ignore(options);
 	if (options->orderfile)
 		diffcore_order(options->orderfile);
 	if (options->rotate_to)
diff --git a/diffcore-ignore.c b/diffcore-ignore.c
new file mode 100644
index 0000000000..1578b264c1
--- /dev/null
+++ b/diffcore-ignore.c
@@ -0,0 +1,152 @@
+#include "git-compat-util.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "xdiff-interface.h"
+
+#define KEEP   0
+#define IGNORE 1
+
+struct diffignore_cb {
+	regex_t **regex;
+	size_t sz;
+	int miss;
+};
+
+/*
+ * Check for any added or deleted line that does not match the ignore pattern.
+ * If found, mark data->miss=1 and return early.
+ */
+static int diffignore_consume(void *priv, char *line, unsigned long len)
+{
+	struct diffignore_cb *data = priv;
+
+	if (line[0] != '+' && line[0] != '-')
+		return 0;
+	if (data->miss)
+		BUG("Already matched in diffignore_consume! Broken xdiff_emit_line_fn?");
+
+	/* check if any of the regexes match */
+	data->miss = 1;
+	for (size_t nr = 0; nr < data->sz; nr++) {
+		regmatch_t regmatch;
+		regex_t *regex = data->regex[nr];
+
+		if (!regexec_buf(regex, line + 1, len - 1, 1,
+				 &regmatch, 0)) {
+			data->miss = 0;
+			break;
+		}
+	}
+
+	/* stop looking for miss */
+	if (data->miss)
+		return 1;
+	return 0;
+}
+
+/* return IGNORE to ignore this change, return KEEP to keep it. */
+static int diff_ignore(mmfile_t *one, mmfile_t *two, struct diff_options *o)
+{
+	struct diffignore_cb ecbdata;
+	xpparam_t xpp;
+	xdemitconf_t xecfg;
+	int ret;
+
+	/*
+	 * We have both sides; need to run textual diff and check if
+	 * there are any unmatched (non-ignored) added or deleted lines.
+	 */
+	memset(&xpp, 0, sizeof(xpp));
+	memset(&xecfg, 0, sizeof(xecfg));
+	ecbdata.regex = o->ignore_regex;
+	ecbdata.sz = o->ignore_regex_nr;
+	ecbdata.miss = 0;
+	xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
+	xecfg.ctxlen = 0;
+	xecfg.interhunkctxlen = 0;
+
+	/*
+	 * An xdiff error might be our "data->miss" from above. See the
+	 * comment for xdiff_emit_line_fn in xdiff-interface.h
+	 */
+	ret = xdi_diff_outf(one, two, NULL, diffignore_consume,
+			    &ecbdata, &xpp, &xecfg);
+
+	/* error happened, keep this change */
+	if (ret)
+		return KEEP;
+	/* If no regex matches, keep this change */
+	return ecbdata.miss ? KEEP : IGNORE;
+}
+
+/* return IGNORE to ignore this change, return KEEP to keep it. */
+static int ignore_match(struct diff_filepair *p, struct diff_options *o)
+{
+	struct userdiff_driver *textconv_one = NULL;
+	struct userdiff_driver *textconv_two = NULL;
+	mmfile_t mf1, mf2;
+	int ret;
+
+	/* keep unmerged */
+	if (!DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two))
+		return KEEP;
+
+	if (o->flags.allow_textconv) {
+		textconv_one = get_textconv(o->repo, p->one);
+		textconv_two = get_textconv(o->repo, p->two);
+	}
+
+	/* unmodified pair will be ignored anyway */
+	if (textconv_one == textconv_two && diff_unmodified_pair(p))
+		return IGNORE;
+
+	/* keep binary files if diff cannot be performed */
+	if (!o->flags.text &&
+	    ((!textconv_one && diff_filespec_is_binary(o->repo, p->one)) ||
+	     (!textconv_two && diff_filespec_is_binary(o->repo, p->two))))
+		return KEEP;
+
+	mf1.size = fill_textconv(o->repo, textconv_one, p->one, &mf1.ptr);
+	mf2.size = fill_textconv(o->repo, textconv_two, p->two, &mf2.ptr);
+
+	ret = diff_ignore(&mf1, &mf2, o);
+
+	if (textconv_one)
+		free(mf1.ptr);
+	if (textconv_two)
+		free(mf2.ptr);
+	diff_free_filespec_data(p->one);
+	diff_free_filespec_data(p->two);
+
+	return ret;
+}
+
+void diffcore_ignore(struct diff_options *o)
+{
+	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue_struct outq = DIFF_QUEUE_INIT;
+
+	if (o->output_format &
+	    (DIFF_FORMAT_PATCH |
+	     DIFF_FORMAT_RAW |
+	     DIFF_FORMAT_CHECKDIFF)) {
+		/*
+		 * If we are generating a patch, let builtin_diff() ignore
+		 * changes and return early here. If we are generating raw
+		 * output or detecting malformed code, we cannot ignore
+		 * changes, so we return early.
+		 */
+		return;
+	}
+
+	for (int i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (ignore_match(p, o))
+			diff_free_filepair(p);
+		else
+			diff_q(&outq, p);
+	}
+
+	free(q->queue);
+	*q = outq;
+}
diff --git a/diffcore.h b/diffcore.h
index 9c0a0e7aaf..97e6e3553b 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -189,6 +189,7 @@ void diffcore_rename_extended(struct diff_options *options,
 			      struct strmap *cached_pairs);
 void diffcore_merge_broken(void);
 void diffcore_pickaxe(struct diff_options *);
+void diffcore_ignore(struct diff_options *);
 void diffcore_order(const char *orderfile);
 void diffcore_rotate(struct diff_options *);
 
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 8ebd170451..344623ecbe 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -609,10 +609,10 @@ test_expect_success 'show A B ... -- <pathspec>' '
 	test_cmp expect actual
 '
 
-test_expect_success 'diff -I<regex>: setup' '
+test_expect_success 'diff -I<regex>: setup file0' '
 	git checkout master &&
 	test_seq 50 >file0 &&
-	git commit -m "Set up -I<regex> test file" file0 &&
+	git commit -m "Set up -I<regex> test file0" file0 &&
 	test_seq 50 | sed -e "s/13/ten and three/" -e "/7\$/d" >file0 &&
 	echo >>file0
 '
@@ -643,6 +643,59 @@ test_expect_success 'diff -I<regex> --stat' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff -I<regex>: setup file1' '
+	test_seq 50 >file1 &&
+	git add file1 &&
+	test_seq 50 | sed -e "s/13/ten and three/" -e "/^[124-9]/ s/\$/ /" >file1
+'
+
+test_expect_success 'diff -I<regex>: ignore file1' '
+	git diff --ignore-blank-lines -I"ten.*e" -I"^[124-9]" >actual &&
+	cat >expect <<-\EOF &&
+	diff --git a/file0 b/file0
+	--- a/file0
+	+++ b/file0
+	@@ -34,7 +31,6 @@
+	 34
+	 35
+	 36
+	-37
+	 38
+	 39
+	 40
+	EOF
+	compare_diff_patch expect actual &&
+
+	git diff --stat --ignore-blank-lines -I"ten.*e" -I"^[124-9]" >actual &&
+	cat >expect <<-\EOF &&
+	 file0 | 1 -
+	 1 file changed, 1 deletion(-)
+	EOF
+	test_cmp expect actual &&
+
+	git diff --name-status --ignore-blank-lines -I"ten.*e" -I"^[124-9]" >actual &&
+	cat >expect <<-\EOF &&
+	M	file0
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff -I<regex> --raw: --raw ignores -I<regex>' '
+	git diff --raw >expect &&
+	git diff --raw --ignore-blank-lines -I"ten.*e" -I"^[124-9]" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff -I<regex> --check: --check ignores -I<regex>' '
+	test_must_fail git diff --check 2>&1 >expect &&
+	test_must_fail git diff --check --ignore-blank-lines -I"ten.*e" -I"^[124-9]" 2>&1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff -I<regex>: rm file1' '
+	git rm -f file1
+'
+
 test_expect_success 'diff -I<regex>: detect malformed regex' '
 	test_expect_code 129 git diff --ignore-matching-lines="^[124-9" 2>error &&
 	test_grep "invalid regex given to -I: " error
-- 
2.50.1.440.g2157409008

