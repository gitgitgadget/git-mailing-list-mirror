Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C46529D297
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 23:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771631723; cv=none; b=UD5nfaAQJrpk5is4w1C/NjXzxf0/6M9dHNZHyGu5/MjGoQboPcJRXIY7wRzCeitQcbshTYRzti7eZKBoIemNu1pU01paQmmMsbfC941v4uVBAn3QXbKgSSeD0BPIsQEqWdcTjQ9IB66v5Ud07RzJ7PlWLn/EJNqqR8MukPWjXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771631723; c=relaxed/simple;
	bh=IQFUy2wjK7d0REqQmb/XDs5Qg1+W9DvbkWCquHMxRoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyoxWsAMA4fVEIjJvDhn4IujHpRH5mNE1oFuKzYVw5F8RGZ/wAU5rBYo0YE+aVOWhwVFcFJvuNGfbFjF3/k9SESfbmXicrA18f48Dety7c30XtRLWmqAtOseTjtDH96O2BGsmrptUbCuk9fh3vvyDEC6trMEVQ8CiAYEhrDP8fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=OsPbS16f; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="OsPbS16f"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771631718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1+qKgMDjqfTLyXQlTzXwSvKSzVAOjfvbmntCJBpi+o=;
	b=OsPbS16f7nzeDJbW5McI0mh0ZegEqzI4NqLQn/iBw7Tvp6uCRGQptH3cORUsFB61WbNex7
	5A4DhMjhDckMOcUqQx3p+TIwSJ33lumhNMZhrtSWHgutKuAADmQICwN0qw5hiWtDvem12m
	FGBk1oFzl0c8mZLat2rvfdY6CrISuEkBzwNSuIgFLO5FS6qdFk/slrmf65XWWpYLhLNQX2
	bjUsyB6FSff+6+LNXIB+9ns3hqNKmC4AhlMPyPX58gjit20yo3mGXFumEe10fhe72LRct2
	Np588GzrYDyoqBMI7Q8kRqrqY/hrXtVw6KHcYYMbL7b6jrFjLNAjCDdADOhJ8A==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [RFC PATCH v2] format-patch: better commit list for cover letter
Date: Sat, 21 Feb 2026 00:55:01 +0100
Message-ID: <20260220235502.759002-1-mroik@delayed.space>
In-Reply-To: <20260220230633.132213-1-mroik@delayed.space>
References: <20260220230633.132213-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3901; i=mroik@delayed.space; h=from:subject; bh=IQFUy2wjK7d0REqQmb/XDs5Qg1+W9DvbkWCquHMxRoc=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpmPQ/aQxGCAvvjDhpowkCyvH1H+5BZ2JCEUwlb F6uX9eP6oGJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZj0PwAKCRBIeX6hnBm+ 0eKzD/0SPlk3DfOXszbuBTeb44Qd9/3Jmk4wmHmruRpfRUnUqVFZbQWuc4om/g+z3lMjsqtHUF2 VOkoIZR4qOzSfH3egriQO1MCbmDfxAIr8kHA18JJqKGfqnzQRG+DalJePKCWvWqM2KQwUpY+N55 CFAL4N7NF+WxURfi79bMiTAO9RLNpS2c7fVzLAiRgj3rhk2cQ0HhRLzvjGh6/PpRPafNmqyoTdw NrcKs659IoEtlqDcITmshS4xZuVcz10piCYWePU//FMqmMEHJksurtxXpxcRf9qLpbsSD/L7srO dHpuKW0zKl8i5IqnxAZJH+T0A7wLD6Df7H2sBH5+pS62pVDGX9rBQRruvBDsDSqPDNGKsBZZ7SH ewXhBJqWxQ7sT8B0JJybIvyiBQ1jta7babMYrXqcVXy5GX7oF8r1ZEgdT3Njt2EL4X9v9uRH5Vr E5+Y/v4mf+LmZ6Of2G1eW9ipXoJjRXAmrW7Q6wqrTAhrwuf7BkJ1UhOOruB9QeMl3YGvEdRKKoV SkiagNyYxctPMvJFbLOOOSkDMerjyDZCuQMMeh20gNAJu27z/EgYzlQu+D/8043/zApKml4zEyL qfZEXUaAT4GX4az6b7vdXFLYJgHgZ2iS0zjPpBRvqL1oziMZumabuG7duc45UYRPIBGBKxqlokF a6w5atLlo4c2vwA==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

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

P.s. I'm sorry, the first version was a bit wrong. This one is correct.

[1] https://lore.kernel.org/git/xmqqbjhjxp2d.fsf@gitster.g/

 builtin/log.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c1cd3999a7..7d446b09b4 100644
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
+		strbuf_remove(sb_loglines, temp + 8, sb_loglines->len - (temp + 8));
+		strbuf_addch(sb_loglines, ':');
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

