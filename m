Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4123B156677
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754232741; cv=none; b=GmHAPo1N9Srk8MyPG/0ZRL5olWj+/qj+0ke4TpRgGHNxrjquzF//Ju1IRkuXENFmhhwdmwC6zn2XS5BrJfZc9Jgr8KAvHnKSmcChub4zGeoY5z1OYEqTrWPEFa41qGQQnkL4+R42HkBDm6GfGF0CVo2tq3oRNv9GNib/PfmbmME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754232741; c=relaxed/simple;
	bh=vCUinTViVWKyJrVGZcE2569H0L/6t6UYTA6CObVm9Bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C5+mryeWXHNcK18RpgaTmpXb0oHeOGuQDUTdvRc0VkZZPwmjSP0e3Cfj7q0j8ZQdyULRUmW2i8ho+3zHmFqLa/qNFQmVKFvFr0j3ZPH5q2cL8HknJmLS6+XJxYgG2ISIXeLGRK0hfkan1nBi0uNl7PpwH8WPfFZ12lidaD3gP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoZuxTWj; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoZuxTWj"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76be8e4b59aso1175580b3a.1
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754232739; x=1754837539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCPMN5QV9g7Z1B7xnhm5t39s5Lb37HzqlXh6QRCBeyQ=;
        b=NoZuxTWjZFt+wZcs4/8aaKhA/9PadaosSH84OqlKRAL33HuKLhXgXiZ+acf/6KtHrj
         Aia5A3bBbyK3rhKc+1GJHUFLcUgoNPEyUFAaaZR0MuoT92BvFMSd2hC3GY085TchwW7y
         9DBa0vqrdNXJzbjM30ptTGBQaiU+LA6SPwFtmX0z2Iy2jZuwEdMJufABBY7teQNOjgF4
         yjfKS2DI81Dx7ujIWqh9QymZfKtgtWxkICL35y0jwz0yqs7fSD2HmrpLDwoyYv9ksTBD
         FLAaxeDw3DCJXTgViUMnN2By/axX8nKF5XrouB162OWwQlvHsoHmKMKWcJgkNwNnLRiP
         lhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754232739; x=1754837539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCPMN5QV9g7Z1B7xnhm5t39s5Lb37HzqlXh6QRCBeyQ=;
        b=cP6zEpU9jGV9jUouxeAuGTLFgsztAhhXYkiWtVLcq5ikj3BxCGt+zN24BylQ16S57y
         dR03L77z8Y0jc0d54wWcXu5GmJq6tOcLYAC8moAHvCBR3QXBZEqb/+dByg3fFYIMA6hF
         ZHosGh2sD4JbJJ8zOqLqPNXVtEKEs3ddUTIHmgQlzJMDxF/C/5BhiOD3byZGfb69PAaP
         A/8LklNzAgQkNYj+h+sYW35FR7WDc3ncSFsLoIayPyfSMWqkB646tMjuK0y/AJcaAiuA
         75QtW1BaqDFfeBfUNPbszheHuCE2CpzFWJe1BhDRFmE5UZnqCvho0/9agqvQC5SVP6xu
         RFAw==
X-Gm-Message-State: AOJu0YwNeIlYiQy+hB05y9d1vDSOR3jeuG2Fk/DC0XZ7KUZxWZ28K8In
	Tsf7zbQh5eNcjL694TAbrxL7BSaUZFEaEfju3kPARCXObO1dV+Dd/BCb5Nw9j4RS769WBFyM
X-Gm-Gg: ASbGnct4T18lT1VJH+29fP2dA3bJzcGRNeu23U/DmG9ovCwN13EIK77P8mIZbrO5R2t
	gM2N+4KBm9c4p9eW3hfqSRZBHmzfuYl9+Gmq4lrcPhzCcWpxWrKNVxl+2YetxAHzGHT4+bpCHDN
	tXlbNwUvZVTHsX5QBrpocHF6kVvhmUVCC0E9E73543Ya9wkOK6YusTyJCQ+7hDvwRe8bZsKmnb/
	XDWJ7jjfm1Nywr3d4QVa57hSzmNlVoCJz/sodcPmCgETFom0Ff1esMiN1eTQ+3yJd+ZHo+wjjgJ
	k3OU56DBmP/72U0vmo3hXQimJV/DIzJ0sZZ0qZZrZVh8MlYtrF4oEdiJ//WYn6YzDOSdPpqjePQ
	d3RBJisoOh4Fiq2UNFtp28hri+WgdSM+SsYUGqHlIlCAvWTaqzDoCjXvfZ3ofG5ya
X-Google-Smtp-Source: AGHT+IE++6Ib4iOSzkAOLcwixuqnBbUdlk6H+xCq9RBnY6Ke+xtnWxl7vR09c0mNIoUKYeeJqFePJQ==
X-Received: by 2002:a05:6a21:898d:b0:23f:fe65:6f2c with SMTP id adf61e73a8af0-23ffe657721mr2561553637.33.1754232739265;
        Sun, 03 Aug 2025 07:52:19 -0700 (PDT)
Received: from localhost.localdomain (n058152109003.netvigator.com. [58.152.109.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b423d2f5035sm5052588a12.39.2025.08.03.07.52.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 03 Aug 2025 07:52:18 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	hi@arnes.space,
	michal@isc.org,
	peff@peff.net,
	yldhome2d2@gmail.com
Subject: [PATCH v2] diff: ensure consistent diff behavior with -I<regex> across output formats
Date: Sun,  3 Aug 2025 22:51:55 +0800
Message-Id: <20250803145155.57894-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqcy9io73j.fsf@gitster.g>
References: <xmqqcy9io73j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`git diff -I<regex>` option is inconsistently applied across various
output formats. In some cases, files would appear in the `--name-only`
output but not in the accompanying `--stat` or `-p` outputs, despite
the user explicitly requesting to ignore certain changes using
`-I<regex>`. Not only for `-I<regex>`, but this inconsistency also
exists for other output formats that have `.diff_from_content` set
(e.g. `-w`, `--ignore-space-at-eol` and `--ignore-space-change`).

To provide this consistency, introduces diffcore_ignore() to filter
out file pairs which only contains changes marked for ignoring before
flush diff output. Add test cases in t4015 and t4013 to verify that
files ignored by each ignore option do not appear in the output when
using the `--name-only` and `--name-status` options.

Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
---
 Makefile                   |   1 +
 diff.c                     |   2 +
 diffcore-ignore.c          | 151 +++++++++++++++++++++++++++++++++++++
 diffcore.h                 |   1 +
 meson.build                |   1 +
 t/t4013-diff-various.sh    |  53 +++++++++++++
 t/t4015-diff-whitespace.sh |  10 ++-
 7 files changed, 217 insertions(+), 2 deletions(-)
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
index dca87e164f..1f905b5354 100644
--- a/diff.c
+++ b/diff.c
@@ -7088,6 +7088,8 @@ void diffcore_std(struct diff_options *options)
 	}
 	if (options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK)
 		diffcore_pickaxe(options);
+	if (options->flags.diff_from_contents)
+		diffcore_ignore(options);
 	if (options->orderfile)
 		diffcore_order(options->orderfile);
 	if (options->rotate_to)
diff --git a/diffcore-ignore.c b/diffcore-ignore.c
new file mode 100644
index 0000000000..2b80911449
--- /dev/null
+++ b/diffcore-ignore.c
@@ -0,0 +1,151 @@
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
+	xpp.flags = o->xdl_opts & XDF_WHITESPACE_FLAGS;
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
+	if (DIFF_PAIR_UNMERGED(p))
+		return KEEP;
+
+	/* keep add/delete */
+	if (!DIFF_FILE_VALID(p->one) || !DIFF_FILE_VALID(p->two))
+		return KEEP;
+
+	/* keep mode changed pair */
+	if (DIFF_PAIR_MODE_CHANGED(p))
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
+	if (!(o->output_format & (DIFF_FORMAT_NAME | DIFF_FORMAT_NAME_STATUS)))
+		return;
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
 
diff --git a/meson.build b/meson.build
index 92d62695e3..c95c9b92bd 100644
--- a/meson.build
+++ b/meson.build
@@ -329,6 +329,7 @@ libgit_sources = [
   'diffcore-delta.c',
   'diffcore-order.c',
   'diffcore-pickaxe.c',
+  'diffcore-ignore.c',
   'diffcore-rename.c',
   'diffcore-rotate.c',
   'dir-iterator.c',
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 8ebd170451..72eb7ae703 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -643,6 +643,59 @@ test_expect_success 'diff -I<regex> --stat' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff -I<regex>: setup file1' '
+	test_seq 50 >file1 &&
+	git add file1 &&
+	test_seq 50 | sed -e "s/13/ten and three/" -e "s/^[124-9].*/& /" >file1
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
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 52e3e476ff..6e46a070e5 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -11,7 +11,7 @@ test_description='Test special whitespace in diff engine.
 . "$TEST_DIRECTORY"/lib-diff.sh
 
 for opt_res in --patch --quiet -s --stat --shortstat --dirstat=lines \
-	       --raw! --name-only! --name-status!
+	       --name-only --name-status --raw!
 do
 	opts=${opt_res%!} expect_failure=
 	test "$opts" = "$opt_res" ||
@@ -43,7 +43,13 @@ do
 		echo foo >x &&
 		git add x &&
 		echo " foo" >x &&
-		$expect_failure git diff -w $opts --exit-code x
+		$expect_failure git diff -w $opts --exit-code x &&
+		echo "foo " >x &&
+		$expect_failure git diff --ignore-space-at-eol $opts --exit-code x &&
+		echo "fo o" >x &&
+		git add x &&
+		echo "fo  o " >x &&
+		$expect_failure git diff --ignore-space-change $opts --exit-code x
 	'
 done
 
-- 
2.39.5 (Apple Git-154)

