Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022041B0F19
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771628822; cv=none; b=IKX6ihd3FEb+Z+xFNahYrANeDlLmZWxumjrbZbUvS4moYIinK14N5+K3Z4eTxfRpHyAIXmVjyy2bremYu/uAJc1DlswI7/rF6trFg/hB7BswgmbxptYF+3hBgrtW+oMPQS1wBos3od+0E20q8DATmXIEVL34UF33RfiWd491N1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771628822; c=relaxed/simple;
	bh=rkBKVJMT5DmUDsFTkuwyt0LKAw/o/MIAQ/GBt9YJJkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zls4GHggBdtSgZUBdz3eT/Ru76b6UytgU87Q907r31Xo90A36LMQEmjDWwew5UoN0yIFkM51aA88+JsBLQpCIlUTfn/zQwZYA+wQd2NOZDvipOJON9pqvf5M8HgREGXG9CEZPIckV2na4qle7Wjqu2oYE0i55a6zb1CtS2tq/qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=AYy7PLDv; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="AYy7PLDv"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771628811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EEvwqdhwKATzT/Z+Y119pHJ7w7sHVBP4thw0PF7I6sI=;
	b=AYy7PLDv7HxVHv+bHFC/3SeUz5s3jTHunL1gLgEAZd62cpVLeRM/pwHIRNJZp8fXEAL3Ln
	tlKxX+3G+5aWm0rXa40JdidpR5MwOoDBDa5WeQsOZhLpOMsBFprFuugcEwp/+L/8h5ZUJE
	g1w8ENP36F03g+0hhuZQbTKH9G5lOM+NoZOEq1vxjuOWEb25bfoPUN62rsZtcbNiCS2Udp
	5tKKh44TxczqpepMBIxALg7XpTHFHEtLoGfsldLcnSvCUTnFGfGFGOjm+VXQbgYYVRG9OL
	EmIdaZb4ez5rO5uN8h50L0CGZH1+tm0EcqiqoomXntok9nE/K21rQz9m7/mGSg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [RFC PATCH] format-patch: better commit list for cover letter
Date: Sat, 21 Feb 2026 00:06:31 +0100
Message-ID: <20260220230633.132213-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3820; i=mroik@delayed.space; h=from:subject; bh=rkBKVJMT5DmUDsFTkuwyt0LKAw/o/MIAQ/GBt9YJJkQ=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpmOjrkfxcPmkwXx+uBkUbQzJklAsBk5qePRhr5 G1eBkSLsMCJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZjo6wAKCRBIeX6hnBm+ 0aX2D/40c9Khqu3X7MNTrlwj3BHvH1sEPZGrIz2wt48ohLwn+/2UEprI8L+XfeOb+1piUgBNnBs 74/Xhd5P/L/JTo/EexEgDWH66m0Fvtm6zOyNCl98tJxL0l6VQFcp3EEJOT11RnhB3sQU6u37WcS g78cp02THVvUUtVyeak5hNzM8pF9wro99iZcNmkEnFzcHjxPTG3FNf+yapNAJQn8xG706/GKM3S RTkmOL7u226kMpTocM7pUvwWbpOIDmNYsxLLsIV0pVuYtFsW4smpUyWYBAey6fkGuEDCnsvJAOG ooMTEfAFoUVqwXrADNALStRfiZL7OG6/UC1BK5O+1FTA7VC7ulXWaYmNeBovye1toH79FwfE0Ug Gl3bQoGYA10DnScUKSXMPRw6qyYpdskJE3599kVA1nRRts7x5UbA+3HNb6mTmvWBjK11M81gXbi +v8NjbBBwFX3qwYf6kk3GyPfzn/veTRClRD/fw+I5YKXUiqd1ZI+MltF8nTZMHF1zc87wO4RkCw UuW9v8Q0+1st+Ak7J3XkgXfrkcd0pcfZshVDlqYmSQ2vEhTn6V3Ewa7d5polkVCIih8TMW+ZyRn FfPzPHuE2K79IB5f1irZzYvwDX8ZPhtd7y2coOP/IugDtsF07+rA6Hstg7P5+/RttKkRU9B2A2P KOPOtmFJHt0ME1w==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

Often when sending patch series there's a need to clarify to the
reviewer what's the purpose of said series, since it might be difficult
to understand it from reading the commits messages one by one.

"git format-patch" provides the useful "--cover-letter" flag to declare
if we want it to generate a template for us to use. By default it will
generate a "git shortlog" of the changes, which developers find less
useful than they'd like, mainly because the shortlog groups commits by
author, and gives no obvious chronological order.

Teach the make_cover_letter() a better cover letter format to replace
the current. The format can be seen from the following example:

    [1/3] abcc234s: this is a summary
    [2/3] 73s84ns2: this is another summary

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
This patch comes after a small off-topic[1] that discussed the
usefulness (or the lack thereof) of the current cover letter template.
This patch hopes to make a better format so that developers won't have
to make their own custom script to generate better info.

[1] https://lore.kernel.org/git/xmqqbjhjxp2d.fsf@gitster.g/

 builtin/log.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c1cd3999a7..4fea895527 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -30,7 +30,6 @@
 #include "reflog-walk.h"
 #include "patch-ids.h"
 #include "path.h"
-#include "shortlog.h"
 #include "remote.h"
 #include "string-list.h"
 #include "parse-options.h"
@@ -40,6 +39,8 @@
 #include "mailmap.h"
 #include "progress.h"
 #include "commit-slab.h"
+#include "pretty.h"
+#include "strbuf.h"
 
 #include "commit-reach.h"
 #include "range-diff.h"
@@ -1324,6 +1325,29 @@ static void get_notes_args(struct strvec *arg, struct rev_info *rev)
 	}
 }
 
+static void generate_cover_commit_list(FILE *cover_file, struct commit** list, int nr)
+{
+	char* commit_hash_buf = malloc(GIT_MAX_HEXSZ + 1);
+	struct strbuf *sb_loglines = malloc(sizeof(struct strbuf));
+	int temp;
+
+	for (int i = 0; i < nr; i++) {
+		strbuf_init(sb_loglines, 0);
+		strbuf_addf(sb_loglines, "[%0*d/%d] ", decimal_width(nr), i + 1, nr);
+		temp = sb_loglines->len;
+		strbuf_addstr(sb_loglines, oid_to_hex_r(commit_hash_buf, &list[i]->object.oid));
+		strbuf_addch(sb_loglines, ':');
+		strbuf_remove(sb_loglines, temp, sb_loglines->len - temp - 8);
+		strbuf_addch(sb_loglines, ' ');
+		pp_commit_easy(CMIT_FMT_ONELINE, list[i], sb_loglines);
+		fprintf(cover_file, "%s\n", sb_loglines->buf);
+	}
+
+	fprintf(cover_file, "\n");
+	strbuf_release(sb_loglines);
+	free(commit_hash_buf);
+}
+
 static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			      struct commit *origin,
 			      int nr, struct commit **list,
@@ -1333,7 +1357,6 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			      const struct format_config *cfg)
 {
 	const char *from;
-	struct shortlog log;
 	struct strbuf sb = STRBUF_INIT;
 	int i;
 	const char *encoding = "UTF-8";
@@ -1377,18 +1400,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	free(pp.after_subject);
 	strbuf_release(&sb);
 
-	shortlog_init(&log);
-	log.wrap_lines = 1;
-	log.wrap = MAIL_DEFAULT_WRAP;
-	log.in1 = 2;
-	log.in2 = 4;
-	log.file = rev->diffopt.file;
-	log.groups = SHORTLOG_GROUP_AUTHOR;
-	shortlog_finish_setup(&log);
-	for (i = 0; i < nr; i++)
-		shortlog_add_commit(&log, list[i]);
-
-	shortlog_output(&log);
+	generate_cover_commit_list(rev->diffopt.file, list, nr);
 
 	/* We can only do diffstat with a unique reference point */
 	if (origin)

base-commit: a8e89346a7731cb3104010f322c65e2a0c922618
-- 
2.53.0

