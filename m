Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC95211A05
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 04:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773116376; cv=none; b=eHIAi55gjmNZx5qZilDIxuTPfdO0N9YMy6tM5zcOX0OPKasKcLASTg5rUdSbX7YsrVyoDp0TG2IfyUq3UNs3SoU6wcL7GkB7WGhg3BpIQ9aFrafdDvJKMJTKn+DJaApV6KrEu2yF9uZx7DL9/7f/o5j98Je44xXHBxyHWm7DV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773116376; c=relaxed/simple;
	bh=NUIbQjxyaQDk5vmmOalElyHl9bzT7+HUDpuO9zv7GJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KIOcVl+Qwb0UNvrU1TvL4hFVeORz8IjQbUmtdN62FhLRbs16p8KmLvu5gwD2DmWgfZhMLTZYyQpZ4MulmOIP0DlGCxSLhZkrMRt4ezutmbpfbKHpcBAIIrNvv53Po8m4LCh2hKnMYBdJw9VNcJEIO+nrHjsMXMYVIjfx2VeXvss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4i1ZqLa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4i1ZqLa"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48538c5956bso19318195e9.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 21:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773116373; x=1773721173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NoEXRPJPwU5f/Q3fDhcwJBRqvLZoUVQ3wEyuuoPyyhE=;
        b=X4i1ZqLaD2glooA8S5Gp/yIMkL7eNgvoOs4SqMs3wmmEBCOiEDsndI76280a7adzk6
         J9S5uTmSimssDldW3XReWGPoMlDbpCwd5CJhWEPRzBo00HJ7SzoUA+F9gQpEMg9HGPq4
         xmYGOLL2Ve+CT9MrS87yDnTO6/UYjzam/ksrvdZsPm9aaRjk1l0vvBxA8maYIDJb25+m
         OM0qMKGDYxZcMIwaZ26ExoqfDO8onIAdbFRrMvvVdV5PA50NHdhUnF6zqIac39bIsgAG
         VIG6DdhCXIeY/n+04pkIr7sZ0px4XSC2qw8+gZKWpH7C+KLhmq5XkcBNTkMZ0Fo44u/p
         dOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773116373; x=1773721173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoEXRPJPwU5f/Q3fDhcwJBRqvLZoUVQ3wEyuuoPyyhE=;
        b=wd9dLVB2z7cr0eYUKoGOgrJCVifTOL/ICbYWYvOAaAYitVkgAyHJqJcUF0MW02W+xQ
         cmPTfW58rUYqCa14BeeS4hlLlbszgcgT8dKboT60QD4EVsKXLkbXTAgsZWVKOCQZBbQo
         XFCJq0+g7+SEbwGGuv7lJ+Z+hwowP1rVyU+NT8eoaZJJdWZymypHCjMPzOJOLb3GdJ3H
         B25PHPGuoLUbvUO0kSEKnWogncDe1eU0CM53k6WSOVFk2DU8JbNRIrHFH29p9vU/SS2p
         P5LhCOFmW7hZjpsmAXpj6sLv0/tHC2DZpsa4e11zWatT4jCpYVWZA1xbVL/OKWTLSq2Y
         K95g==
X-Gm-Message-State: AOJu0Yyk+7zawfiAUCsRrN1L6hqxyAQ90n/a8Kfk1KAmX3Kx5r/Bv1pr
	v3jdPBVqTc52HwpK1tFOMZZRjAXFWNYcm5ChSltdrZJfBAZ+R3AHdSgQadqyqohTGwI=
X-Gm-Gg: ATEYQzwpO+ffFzn8W3j7irfsXbwHKkV5yZL7hy5wrcySXqFOyT8AQrEnwbk4bsK8pd/
	PoZ63jlL6Wt/rYRT7wveO6p4bDSYqvz+Xb+iThtUtP0FRIlrRkg0P5v3CzSuBE/JHifH9sntIxb
	o15Ty5Q2iRZQJOfN3oyrd9NztzGW5UOR5WvpM86/nR0nRsy6DD5+pkwylCUMmdSAGbmnv+OVS5t
	1krFp5wcyu9bEDhq+TfGAt41bVQ3Fpu7P8wdUoJhOO439vmD9ta7pOyA1PZhTyb1B3iBbJbHxlo
	PPODarnIXiGJhpTaEa3o8SYeJxWqkJOi2fftY2ixg1rmzYTL/3r6j+QiYhdSIYA24uWOe7aW3iK
	ILbQTKhx8XG5LNOzYkYFBa9Z6CsIOhrkVWUtHlO0yWSX9MOe2/mGliXsBqiDviCPfO9XbdZtxjl
	m9ukJ6eqlIopD8lwGmyyDJTToiYWG0aZFyeq6+REFgQjSxra1YU3CGBIU6VYylePy456rWQFoVy
	5EsK+rJ7M7Qw0pI9d/KAL13KhTUj46S3iabknhYybuOJ2CEsPubYrSkijw=
X-Received: by 2002:a05:600c:1d04:b0:485:3428:774c with SMTP id 5b1f17b1804b1-485419a286cmr31199945e9.4.1773116373298;
        Mon, 09 Mar 2026 21:19:33 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a6bbcesm45030165e9.3.2026.03.09.21.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 21:19:32 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH] format-patch: write numbered list in cover letter
Date: Tue, 10 Mar 2026 05:19:29 +0100
Message-ID: <20260310041929.1687483-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover letter generated with 'git format-patch --cover-letter' uses
shortlog grouping commits by author. For a single author patch grouping
by author add useless information and makes it hard to follow patch
references: "second patch does x and y patch does z"

Replace the shortlog with a numbered list of patches:

  [1/2]: first commit
  [2/2]: second commit

shortlog grouping by author is lost, both for single author patches
and multiple author patches

suggested as #leftoverbits by Junio C Hamano at
https://lore.kernel.org/git/xmqqbjhjxp2d.fsf@gitster.g/

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
I haven't tried to group by author on multiple authors patches to keep it simple 
but I believe it's doable.

 Documentation/git-format-patch.adoc           |  5 ++--
 builtin/log.c                                 | 26 +++++++++----------
 ..._--stdout_--cover-letter_-n_initial..main^ |  5 ++--
 t/t4014-format-patch.sh                       | 16 +++---------
 4 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 36146006fa..420f05099c 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -319,8 +319,9 @@ feeding the result to `git send-email`.
 --cover-letter::
 --no-cover-letter::
 	In addition to the patches, generate a cover letter file
-	containing the branch description, shortlog and the overall diffstat.  You can
-	fill in a description in the file before sending it out.
+	containing the branch description, numbered [n/m] list of patches and
+	the overall diffstat.  You can fill in a description in the file before
+	sending it out.
 
 --encode-email-headers::
 --no-encode-email-headers::
diff --git a/builtin/log.c b/builtin/log.c
index 7cb919bca9..002af4fa59 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1332,7 +1332,6 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			      const struct format_config *cfg)
 {
 	const char *from;
-	struct shortlog log;
 	struct strbuf sb = STRBUF_INIT;
 	int i;
 	const char *encoding = "UTF-8";
@@ -1340,6 +1339,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	struct pretty_print_context pp = {0};
 	struct commit *head = list[0];
 	char *to_free = NULL;
+	struct strbuf oneline = STRBUF_INIT;
+	struct pretty_print_context ctx = {0};
 
 	if (!cmit_fmt_is_mail(rev->commit_format))
 		die(_("cover letter needs email format"));
@@ -1376,18 +1377,17 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
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
+	ctx.fmt = CMIT_FMT_USERFORMAT;
+	ctx.output_encoding = get_log_output_encoding();
+
+	for (i = nr - 1; i >= 0; i--) {
+		strbuf_reset(&oneline);
+		repo_format_commit_message(the_repository, list[i], "%s", &oneline, &ctx);
+		fprintf(rev->diffopt.file, "  [%d/%d]: %s\n", nr - i, nr, oneline.buf);
+	}
+	fprintf(rev->diffopt.file, "\n");
+
+	strbuf_release(&oneline);
 
 	/* We can only do diffstat with a unique reference point */
 	if (origin)
diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..main^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..main^
index 567f222198..ad78528e1e 100644
--- a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..main^
+++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..main^
@@ -6,9 +6,8 @@ Subject: [DIFFERENT_PREFIX 0/2] *** SUBJECT HERE ***
 
 *** BLURB HERE ***
 
-A U Thor (2):
-  Second
-  Third
+  [1/2]: Second
+  [2/2]: Third
 
  dir/sub | 4 ++++
  file0   | 3 +++
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 2135b65cee..3ffccb8ee8 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -693,20 +693,10 @@ test_expect_success 'cover-letter inherits diff options' '
 	grep "file => foo .* 0 *\$" 0000-cover-letter.patch
 '
 
-cat >expect <<EOF
-  This is an excessively long subject line for a message due to the
-    habit some projects have of not having a short, one-line subject at
-    the start of the commit message, but rather sticking a whole
-    paragraph right at the start as the only thing in the commit
-    message. It had better not become the filename for the patch.
-  foo
-
-EOF
-
-test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
+test_expect_success 'cover-letter lists patches in numbered format' '
 	git format-patch --cover-letter -2 &&
-	sed -e "1,/A U Thor/d" -e "/^\$/q" 0000-cover-letter.patch >output &&
-	test_cmp expect output
+	grep "^  \[1/2\]:" 0000-cover-letter.patch &&
+	grep "^  \[2/2\]:" 0000-cover-letter.patch
 '
 
 cat >expect <<EOF
-- 
2.43.0

