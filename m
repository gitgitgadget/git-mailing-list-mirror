Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D156BC43217
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiKJQhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiKJQhM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:37:12 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2528C4045B
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:12 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d20so1803612plr.10
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xpV1X8bj10MAWR4HwbecS3VZoVl9AG/NJ60/7j79D0=;
        b=kimtjEVynTHHT3Cx9BL+pY0c/KzvXHxCUH3BCUr14MQOIvP7QlHXyHXkrqSuxT34h4
         NwMjWSD7Yg9zVHjNjYlMkKdMgxtJBVUWyUCT7Rv0xBHJ+Q7yaNM0LmPR3k1pbowcOSVK
         pogCcHaAN3DLtvVWlbmmF9B9nPQLLq3AnUfYNsvLPGpvN896DrZaAkrhD0fndQgUHvET
         IpwaZL1kiS9gdj/oi2zSdNBuIBKF3EaZ9G8cwTIOBaHqHL3MqVlVKKuXltrd483wO5Nv
         iZEywzZ3DCe6BhlrvOfwq7Hltfj6Xn7SwUkyYYO5dzZ823YiMJFxQt667kKoThJDndEI
         malg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xpV1X8bj10MAWR4HwbecS3VZoVl9AG/NJ60/7j79D0=;
        b=vRZLGKxI7Unaki4kB+0CvdelGKIXV1Ig2Eu5hEFp2qgGRJpS+RIfMBZOj7Ej9ZIwlk
         +ojPtt55qsdZnf111j/rMRcn9mIGB1CLfqfBC7q2sRISU89TjMIBZ0jjNF8KUnAMQt59
         xVd26CeHfqeXkVIyaGPFb9gxRijCbeGM0VMfFa0am9u7usuAgPcTza9i1Sx7mS5BL0u/
         I5rLNxDDvBUzp6eBfCNMWNQIzEHpOjVKSfKO/bmvro5N7cgtFQaOp6UAlOL9cZbycDiP
         yr7tdtMfFtRDYJ1H+x51iYQalfQIZs0nSSg40vFmO/ZdxDqfbfIWswnwCCYBiLfPZHMp
         rtNg==
X-Gm-Message-State: ACrzQf1LxL/xyoCWBJ94y1k5JEimx+HOFEZFmBFDTkIRAhe07Y1tNCnv
        4osR84GhqABu15o/aV4Q5JQgkMNRrcQ=
X-Google-Smtp-Source: AMsMyM5Kj+dyQEi9jhjpit4tV87flIamC+VLgedx+z/X0DOwlhixMBmfA6YSxtdxr8cnIiLSQsJhSg==
X-Received: by 2002:a17:902:db0e:b0:186:9b38:ad26 with SMTP id m14-20020a170902db0e00b001869b38ad26mr66970394plx.43.1668098231223;
        Thu, 10 Nov 2022 08:37:11 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b0016d9b101413sm11579258plg.200.2022.11.10.08.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:37:10 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/11] bisect run: keep some of the post-v2.30.0 output
Date:   Thu, 10 Nov 2022 23:36:39 +0700
Message-Id: <17bef3e951cfe3c7cc226819abb3695887d6a686.1668097966.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1668097962.git.congdanhqx@gmail.com>
References: <cover.1668097286.git.congdanhqx@gmail.com> <cover.1668097962.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Preceding commits fixed output and behavior regressions in
d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell function
in C, 2021-09-13), which did not claim to be changing the output of
"git bisect run".

But some of the output it emitted was subjectively better, so once
we've asserted that we're back on v2.29.0 behavior, let's change some
of it back:

- We now quote the arguments again, but omit the first " " when
  printing the "running" line.
- Ditto for other cases where we emitted the argument
- We say "found first bad commit" again, not just "run success"

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Based-on-patch-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c    | 24 ++++++++--------
 t/t6030-bisect-porcelain.sh | 55 +++++++++++++++++++++++++++++++------
 2 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 05cab468e3..180c2faa7f 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1141,17 +1141,17 @@ static int get_first_good(const char *refname UNUSED,
 	return 1;
 }
 
-static int do_bisect_run(const char *command, const char *unquoted_cmd)
+static int do_bisect_run(const char *command)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
-	printf(_("running %s\n"), unquoted_cmd);
+	printf(_("running %s\n"), command);
 	cmd.use_shell = 1;
 	strvec_push(&cmd.args, command);
 	return run_command(&cmd);
 }
 
-static int verify_good(const struct bisect_terms *terms, const char *command, const char *unquoted_cmd)
+static int verify_good(const struct bisect_terms *terms, const char *command)
 {
 	int rc;
 	enum bisect_error res;
@@ -1171,7 +1171,7 @@ static int verify_good(const struct bisect_terms *terms, const char *command, co
 	if (res != BISECT_OK)
 		return -1;
 
-	rc = do_bisect_run(command, unquoted_cmd);
+	rc = do_bisect_run(command);
 
 	res = bisect_checkout(&current_rev, no_checkout);
 	if (res != BISECT_OK)
@@ -1184,7 +1184,6 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 {
 	int res = BISECT_OK;
 	struct strbuf command = STRBUF_INIT;
-	struct strbuf unquoted = STRBUF_INIT;
 	const char *new_state;
 	int temporary_stdout_fd, saved_stdout;
 	int is_first_run = 1;
@@ -1198,9 +1197,9 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 	}
 
 	sq_quote_argv(&command, argv);
-	strbuf_join_argv(&unquoted, argc, argv,' ');
+	strbuf_ltrim(&command);
 	while (1) {
-		res = do_bisect_run(command.buf, unquoted.buf);
+		res = do_bisect_run(command.buf);
 
 		/*
 		 * Exit code 126 and 127 can either come from the shell
@@ -1210,11 +1209,11 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 		 * missing or non-executable script.
 		 */
 		if (is_first_run && (res == 126 || res == 127)) {
-			int rc = verify_good(terms, command.buf, unquoted.buf);
+			int rc = verify_good(terms, command.buf);
 			is_first_run = 0;
 			if (rc < 0) {
-				error(_("unable to verify '%s' on good"
-					" revision"), unquoted.buf);
+				error(_("unable to verify %s on good"
+					" revision"), command.buf);
 				res = BISECT_FAILED;
 				break;
 			}
@@ -1228,7 +1227,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 
 		if (res < 0 || 128 <= res) {
 			error(_("bisect run failed: exit code %d from"
-				" '%s' is < 0 or >= 128"), res, unquoted.buf);
+				" %s is < 0 or >= 128"), res, command.buf);
 			break;
 		}
 
@@ -1265,7 +1264,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 			puts(_("bisect run success"));
 			res = BISECT_OK;
 		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
-			puts(_("bisect run success"));
+			puts(_("bisect found first bad commit"));
 			res = BISECT_OK;
 		} else if (res) {
 			error(_("bisect run failed: 'bisect-state %s'"
@@ -1276,7 +1275,6 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 		break;
 	}
 
-	strbuf_release(&unquoted);
 	strbuf_release(&command);
 	return res;
 }
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index a3dc5c8140..34fd45a48e 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -288,9 +288,9 @@ test_bisect_run_args () {
 test_expect_success 'git bisect run: args, stdout and stderr with no arguments' "
 	test_bisect_run_args <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
 	EOF_ARGS
-	running ./run.sh
+	running './run.sh'
 	$HASH4 is the first bad commit
-	bisect run success
+	bisect found first bad commit
 	EOF_OUT
 	EOF_ERR
 "
@@ -299,9 +299,9 @@ test_expect_success 'git bisect run: args, stdout and stderr: "--" argument' "
 	test_bisect_run_args -- <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
 	<-->
 	EOF_ARGS
-	running ./run.sh --
+	running './run.sh' '--'
 	$HASH4 is the first bad commit
-	bisect run success
+	bisect found first bad commit
 	EOF_OUT
 	EOF_ERR
 "
@@ -313,9 +313,9 @@ test_expect_success 'git bisect run: args, stdout and stderr: "--log foo --no-lo
 	<--no-log>
 	<bar>
 	EOF_ARGS
-	running ./run.sh --log foo --no-log bar
+	running './run.sh' '--log' 'foo' '--no-log' 'bar'
 	$HASH4 is the first bad commit
-	bisect run success
+	bisect found first bad commit
 	EOF_OUT
 	EOF_ERR
 "
@@ -324,13 +324,52 @@ test_expect_success 'git bisect run: args, stdout and stderr: "--bisect-start" a
 	test_bisect_run_args --bisect-start <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
 	<--bisect-start>
 	EOF_ARGS
-	running ./run.sh --bisect-start
+	running './run.sh' '--bisect-start'
 	$HASH4 is the first bad commit
-	bisect run success
+	bisect found first bad commit
 	EOF_OUT
 	EOF_ERR
 "
 
+test_expect_success 'git bisect run: negative exit code' "
+	write_script fail.sh <<-'EOF' &&
+	exit 255
+	EOF
+	cat <<-'EOF' >expect &&
+	bisect run failed: exit code -1 from './fail.sh' is < 0 or >= 128
+	EOF
+	test_when_finished 'git bisect reset' &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	! git bisect run ./fail.sh 2>err &&
+	sed -En 's/.*(bisect.*code) (-?[0-9]+) (from.*)/\1 -1 \3/p' err >actual &&
+	test_cmp expect actual
+"
+
+test_expect_failure 'git bisect run: unable to verify on good' "
+	write_script fail.sh <<-'EOF' &&
+	head=\$(git rev-parse --verify HEAD)
+	good=\$(git rev-parse --verify $HASH1)
+	if test "\$head" = "\$good"
+	then
+		exit 255
+	else
+		exit 127
+	fi
+	EOF
+	cat <<-'EOF' >expect &&
+	unable to verify './fail.sh' on good revision
+	EOF
+	test_when_finished 'git bisect reset' &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	! git bisect run ./fail.sh 2>err &&
+	sed -n 's/.*\(unable to verify.*\)/\1/p' err >actual &&
+	test_cmp expect actual
+"
+
 # We want to automatically find the commit that
 # added "Another" into hello.
 test_expect_success '"git bisect run" simple case' '
-- 
2.38.1.157.gedabe22e0a

