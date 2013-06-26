From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: [PATCH v7 5/5] pretty: --format output should honor logOutputEncoding
Date: Wed, 26 Jun 2013 14:19:50 +0400
Message-ID: <aa95cf382f3184e50143391b843b31248284dbd0.1372240999.git.Alex.Crezoff@gmail.com>
References: <cover.1372240998.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 26 12:20:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urmq3-00039K-Hk
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 12:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013Ab3FZKU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 06:20:27 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:32960 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab3FZKUV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 06:20:21 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so13215148lab.8
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 03:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=F4ou8nlPe7JH4nA6oYU1dqZTa7520q/Ng4Uvfyoy5Z4=;
        b=niOGEQlMwBEViHWz30SprkSEQzymmU6+QFqAk924MVwaTX9C2+vCTavqnP+Sh9HdWQ
         BnVg2YWQYuPQbAe0guoIskXNyRSi7e6fKwxZ33S7cBERIe4mb0u4qT/6RIZPyr3Vf4rC
         8UEA+OTk5TH9AGAEYQ9Ffpmmi/ipCcRNTMOeI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=F4ou8nlPe7JH4nA6oYU1dqZTa7520q/Ng4Uvfyoy5Z4=;
        b=pNGy128YmrwqZTlG6uiIoHtrypGxnp4aIvO1v5hBMR676cEXm7fOupHwRb7FUOvh0r
         6sdqH9pObVYAdkGiJ5Iu9DW9dHZSoAQDX3HVdvC+iHdvCWfyqi3UIWtfiguLS6R7Tpar
         zpMqGsXTV4kpM0zNk6G6gIhJeDlgPAp7ROq4SjuL31lDxzGU4xqodNj6GyXEU6qATQW6
         Qkense4tvU8kIoih3k8Kyh/NY6bPJQEwMu8SxUyqHQx7CBUIyinWMByfMH5T0mpiC/3h
         Oe2GITbMQQFDbGi3nfjE9mZyjmvLzsooSZNkwlrov7yKxMUjtsF+Czgjjkzr2vnLt0SY
         Wk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=F4ou8nlPe7JH4nA6oYU1dqZTa7520q/Ng4Uvfyoy5Z4=;
        b=mdJakROTbjTM+g4PCTl4m8mgFUHUpCgCDGD5KOp8vVyZfLxfom7qJBdT1P2dZcgw/M
         5cfZE1ruUoBvFS+ET0mbBenchEiThbDVae2uKaE+mvUpG/cCg85FcrSazBQpBZZlf9z1
         vr4ZSJfDQae9c/N8bM/0RQwsbVdnKbckwMtgqahX6Gxteuef2WXwQiPZHiltsk7fyjWC
         c09zi4/hzeLB3xPMZh9iPuZuMkBtUUInPH1zBu8v6sPGUQJlpVTAkwTT+4C2TjTE/apB
         sPFvgJzKuxhzT/rAM+na0BqczoeUeFDP0IZo5L0sXqkVllkVL8cpx2xRpBtpoS+WuZ9H
         AeGw==
X-Received: by 10.112.144.35 with SMTP id sj3mr1865325lbb.4.1372242019325;
        Wed, 26 Jun 2013 03:20:19 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id v18sm10130624lbd.5.2013.06.26.03.20.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Jun 2013 03:20:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1372240998.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1372240998.git.Alex.Crezoff@gmail.com>
References: <cover.1372149305.git.Alex.Crezoff@gmail.com> <cover.1372240998.git.Alex.Crezoff@gmail.com>
X-Gm-Message-State: ALoCoQkoVuENvB1pS+hg4E/ac4BxqRtlE0fua3RFufwbO6iAQL6U+5BarmzLfbW9OSMYCpTDghT7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229039>

One can set an alias
	$ git config [--global] alias.lg "log --graph --pretty=format:'%Cred%h%Creset
	-%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset'
	--abbrev-commit --date=local"

to see the log as a pretty tree (like *gitk* but in a terminal).

However, log messages written in an encoding i18n.commitEncoding which differs
from terminal encoding are shown corrupted even when i18n.logOutputEncoding
and terminal encoding are the same (e.g. log messages committed on a Cygwin box
with Windows-1251 encoding seen on a Linux box with a UTF-8 encoding and vice versa).

To simplify an example we can say the following two commands are expected
to give the same output to a terminal:

	$ git log --oneline --no-color
	$ git log --pretty=format:'%h %s'

However, the former pays attention to i18n.logOutputEncoding
configuration, while the latter does not when it formats "%s".

The same corruption is true for
	$ git diff --submodule=log
and
	$ git rev-list --pretty=format:%s HEAD
and
	$ git reset --hard

This patch makes pretty --format honor logOutputEncoding when it formats
log message.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 builtin/reset.c                  |  5 ++++-
 builtin/rev-list.c               |  1 +
 builtin/shortlog.c               |  1 +
 log-tree.c                       |  1 +
 submodule.c                      |  1 +
 t/t4041-diff-submodule-option.sh | 10 +++++-----
 t/t4205-log-pretty-formats.sh    | 34 +++++++++++++++++-----------------
 t/t6006-rev-list-format.sh       |  8 ++++----
 t/t7102-reset.sh                 |  2 +-
 9 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 6032131..afa6e02 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -93,10 +93,12 @@ static int reset_index(const unsigned char *sha1, int reset_type, int quiet)
 static void print_new_head_line(struct commit *commit)
 {
 	const char *hex, *body;
+	char *msg;
 
 	hex = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
 	printf(_("HEAD is now at %s"), hex);
-	body = strstr(commit->buffer, "\n\n");
+	msg = logmsg_reencode(commit, NULL, get_log_output_encoding());
+	body = strstr(msg, "\n\n");
 	if (body) {
 		const char *eol;
 		size_t len;
@@ -107,6 +109,7 @@ static void print_new_head_line(struct commit *commit)
 	}
 	else
 		printf("\n");
+	logmsg_free(msg, commit);
 }
 
 static void update_index_from_diff(struct diff_queue_struct *q,
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 67701be..a5ec30d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -111,6 +111,7 @@ static void show_commit(struct commit *commit, void *data)
 		ctx.date_mode = revs->date_mode;
 		ctx.date_mode_explicit = revs->date_mode_explicit;
 		ctx.fmt = revs->commit_format;
+		ctx.output_encoding = get_log_output_encoding();
 		pretty_print_commit(&ctx, commit, &buf);
 		if (revs->graph) {
 			if (buf.len) {
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 1fd6f8a..1434f8f 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -137,6 +137,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		ctx.subject = "";
 		ctx.after_subject = "";
 		ctx.date_mode = DATE_NORMAL;
+		ctx.output_encoding = get_log_output_encoding();
 		pretty_print_commit(&ctx, commit, &ufbuf);
 		buffer = ufbuf.buf;
 	} else if (*buffer) {
diff --git a/log-tree.c b/log-tree.c
index 1946e9c..5277d3e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -616,6 +616,7 @@ void show_log(struct rev_info *opt)
 	ctx.fmt = opt->commit_format;
 	ctx.mailmap = opt->mailmap;
 	ctx.color = opt->diffopt.use_color;
+	ctx.output_encoding = get_log_output_encoding();
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
diff --git a/submodule.c b/submodule.c
index 1821a5b..78734e1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -226,6 +226,7 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	while ((commit = get_revision(rev))) {
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode = rev->date_mode;
+		ctx.output_encoding = get_log_output_encoding();
 		strbuf_setlen(&sb, 0);
 		strbuf_addstr(&sb, line_prefix);
 		if (commit->object.flags & SYMMETRIC_LEFT) {
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 2a7877d..0a4f496 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -94,7 +94,7 @@ test_expect_success 'diff.submodule does not affect plumbing' '
 commit_file sm1 &&
 head2=$(add_file sm1 foo3)
 
-test_expect_failure 'modified submodule(forward)' '
+test_expect_success 'modified submodule(forward)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
@@ -103,7 +103,7 @@ test_expect_failure 'modified submodule(forward)' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'modified submodule(forward)' '
+test_expect_success 'modified submodule(forward)' '
 	git diff --submodule=log >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
@@ -112,7 +112,7 @@ test_expect_failure 'modified submodule(forward)' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'modified submodule(forward) --submodule' '
+test_expect_success 'modified submodule(forward) --submodule' '
 	git diff --submodule >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
@@ -143,7 +143,7 @@ head3=$(
 	git rev-parse --short --verify HEAD
 )
 
-test_expect_failure 'modified submodule(backward)' '
+test_expect_success 'modified submodule(backward)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2..$head3 (rewind):
@@ -154,7 +154,7 @@ test_expect_failure 'modified submodule(backward)' '
 '
 
 head4=$(add_file sm1 foo4 foo5)
-test_expect_failure 'modified submodule(backward and forward)' '
+test_expect_success 'modified submodule(backward and forward)' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2...$head4:
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 6b62da2..2fc9674 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -69,7 +69,7 @@ test_expect_success 'alias user-defined tformat with %s (iso-8859-1 encoding)' '
 	test_cmp expected-s actual-s
 '
 
-test_expect_failure 'alias user-defined tformat with %s (utf-8 encoding)' '
+test_expect_success 'alias user-defined tformat with %s (utf-8 encoding)' '
 	git log --oneline >expected-s &&
 	git log --pretty="tformat:%h %s" >actual-s &&
 	test_cmp expected-s actual-s
@@ -108,19 +108,19 @@ test_expect_success 'alias loop' '
 	test_must_fail git log --pretty=test-foo
 '
 
-test_expect_failure 'NUL separation' '
+test_expect_success 'NUL separation' '
 	printf "add bar\0$(commit_msg)" >expected &&
 	git log -z --pretty="format:%s" >actual &&
 	test_cmp expected actual
 '
 
-test_expect_failure 'NUL termination' '
+test_expect_success 'NUL termination' '
 	printf "add bar\0$(commit_msg)\0" >expected &&
 	git log -z --pretty="tformat:%s" >actual &&
 	test_cmp expected actual
 '
 
-test_expect_failure 'NUL separation with --stat' '
+test_expect_success 'NUL separation with --stat' '
 	stat0_part=$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=$(git diff-tree --no-commit-id --stat --root HEAD^) &&
 	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n" >expected &&
@@ -145,7 +145,7 @@ test_expect_success 'setup more commits' '
 	head4=$(git rev-parse --verify --short HEAD~3)
 '
 
-test_expect_failure 'left alignment formatting' "
+test_expect_success 'left alignment formatting' "
 	git log --pretty='format:%<(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -158,7 +158,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'left alignment formatting at the nth column' "
+test_expect_success 'left alignment formatting at the nth column' "
 	git log --pretty='format:%h %<|(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -171,7 +171,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'left alignment formatting with no padding' "
+test_expect_success 'left alignment formatting with no padding' "
 	git log --pretty='format:%<(1)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -184,7 +184,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'left alignment formatting with trunc' "
+test_expect_success 'left alignment formatting with trunc' "
 	git log --pretty='format:%<(10,trunc)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -197,7 +197,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'left alignment formatting with ltrunc' "
+test_expect_success 'left alignment formatting with ltrunc' "
 	git log --pretty='format:%<(10,ltrunc)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -210,7 +210,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'left alignment formatting with mtrunc' "
+test_expect_success 'left alignment formatting with mtrunc' "
 	git log --pretty='format:%<(10,mtrunc)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -223,7 +223,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'right alignment formatting' "
+test_expect_success 'right alignment formatting' "
 	git log --pretty='format:%>(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -236,7 +236,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'right alignment formatting at the nth column' "
+test_expect_success 'right alignment formatting at the nth column' "
 	git log --pretty='format:%h %>|(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -249,7 +249,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'right alignment formatting with no padding' "
+test_expect_success 'right alignment formatting with no padding' "
 	git log --pretty='format:%>(1)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -262,7 +262,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'center alignment formatting' "
+test_expect_success 'center alignment formatting' "
 	git log --pretty='format:%><(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -275,7 +275,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'center alignment formatting at the nth column' "
+test_expect_success 'center alignment formatting at the nth column' "
 	git log --pretty='format:%h %><|(40)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -288,7 +288,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'center alignment formatting with no padding' "
+test_expect_success 'center alignment formatting with no padding' "
 	git log --pretty='format:%><(1)%s' >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -301,7 +301,7 @@ EOF
 	test_cmp expected actual
 "
 
-test_expect_failure 'left/right alignment formatting with stealing' "
+test_expect_success 'left/right alignment formatting with stealing' "
 	git commit --amend -m short --author 'long long long <long@me.com>' &&
 	git log --pretty='format:%<(10,trunc)%s%>>(10,ltrunc)% an' >actual &&
 	# complete the incomplete line at the end
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index c66a07f..380c85b 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -141,7 +141,7 @@ commit $head1
 iso-8859-1
 EOF
 
-test_format failure subject %s <<EOF
+test_format subject %s <<EOF
 commit $head2
 $changed
 commit $head1
@@ -153,7 +153,7 @@ commit $head2
 commit $head1
 EOF
 
-test_format failure raw-body %B <<EOF
+test_format raw-body %B <<EOF
 commit $head2
 $changed
 
@@ -247,7 +247,7 @@ commit $head1
 iso-8859-1
 EOF
 
-test_format failure complex-subject %s <<EOF
+test_format complex-subject %s <<EOF
 commit $head3
 Test printing of complex bodies
 commit $head2
@@ -256,7 +256,7 @@ commit $head1
 $added
 EOF
 
-test_format failure complex-body %b <<EOF
+test_format complex-body %b <<EOF
 commit $head3
 This commit message is much longer than the others,
 and it will be encoded in iso8859-1. We should therefore
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 72e364e..27b1e93 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -55,7 +55,7 @@ check_changes () {
 	done | test_cmp .cat_expect -
 }
 
-test_expect_failure 'reset --hard message' '
+test_expect_success 'reset --hard message' '
 	hex=$(git log -1 --format="%h") &&
 	git reset --hard > .actual &&
 	echo HEAD is now at $hex $(commit_msg) > .expected &&
-- 
1.8.3.1.15.g5c23c1e
