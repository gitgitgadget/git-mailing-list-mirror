Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FEDC4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiKJQhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiKJQhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:37:09 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48A61AF11
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:08 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so5138504pjs.4
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFTB0hcW8PyylZazOX+m2kMtEqWxfOKc7h4Xd2Dzfxw=;
        b=MtW/394S3FDGQb8V9bRaUaUNehzeitEfo1QPdCnIYoqn9aPjuDviATjudsHW6U2tVy
         afCENuoQndtPP4pnajfgZPzp0dFxT+8LtsR44deMW0PYtLhsD2i85PjoDQY8M1USKDcC
         N0HFHC7BEOJZ/5S/hkSIuU3V2TyUVeJTW2F5TyJnD/zvC9pGxmBqcwgaycfOmkqE+dp5
         V1ahCDLdKx9OIqLkgG3IR9oRIckrQY+QeSMiN+a+aJanQHG1jqfyG4gPUfxDAjgNO0NB
         doj2F/ds9ZI0IJhvqirIH5hAqae32O60UVQ2iJ3VoX4PPc/YWuX8lBso4QZXFqhbzAcR
         ELow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFTB0hcW8PyylZazOX+m2kMtEqWxfOKc7h4Xd2Dzfxw=;
        b=urPimbopK9HBwj1HVRb+aAocX1S6fYIRF+C8XCiFqia8BmprUY/FUfK2glxJhUekEY
         ph9uW+rX0chXVIaePOhTWmKeZy+DpqFUYluUXIT8UDkBdTEmmW1oMWWN46DZ8Y3JbLGu
         oHrkhFy4ZHnDG6zOZ1eWXYkDdPq1IRWjtFutG7rnb7h8XFYxygWv0jGxSi0D5v3B4TLK
         9Qqt30EYHcVYqiVpAQ/Ag5QXXBNvLKGL8eKl6ulbbpTPxDU+pRlnPwvtU2rO00HD3yiC
         cpQsrsjqHnxtLH5RcVKpmHHWf9lk20RFyyW3sz3V4wiL0a7sCo9MWYWMvI8XdMw6fsWF
         jceQ==
X-Gm-Message-State: ACrzQf3aRbnd5QM94kkaL7SsUIvn4g6eXJmXFvp7RVbsPKFem66eAPtd
        mDA5ij4k+SvqHtp5O9bpqWNaVsZ/5Rs=
X-Google-Smtp-Source: AMsMyM5pl+GpkOGAk9a7wZSgNcPOXdy+KeDQY3B/kHQgCHnO9U+r0RsySamWlqmoLIP0tysC+VZyjQ==
X-Received: by 2002:a17:903:26cd:b0:188:4c74:e1de with SMTP id jg13-20020a17090326cd00b001884c74e1demr41020737plb.56.1668098228071;
        Thu, 10 Nov 2022 08:37:08 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b0016d9b101413sm11579258plg.200.2022.11.10.08.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:37:07 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/11] bisect: fix output regressions in v2.30.0
Date:   Thu, 10 Nov 2022 23:36:38 +0700
Message-Id: <912f32cedaa7476fd83e306e075a2b63d41326c4.1668097966.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1668097962.git.congdanhqx@gmail.com>
References: <cover.1668097286.git.congdanhqx@gmail.com> <cover.1668097962.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell
function in C, 2021-09-13) reimplemented parts of "git bisect run" in
C it changed the output we emitted so that:

 - The "running ..." line was now quoted
 - We lost the \n after our output
 - We started saying "bisect found ..." instead of "bisect run success"

Arguably some of this is better now, but as d1bbbe45df8 did not
advocate for changing the output, let's revert this for now. It'll be
easy to change it back if that's what we'd prefer.

This does not change the one remaining use of "command.buf" to emit
the quoted argument, as that's new in d1bbbe45df8.

Some of these cases were not tested for in the tests added in the
preceding commit, I didn't have time to fleshen those out, but a look
at f1de981e8b6 will show that the other output being adjusted here is
now equivalent to what it was before d1bbbe45df8.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c    | 27 +++++++++++++++------------
 t/t6030-bisect-porcelain.sh |  8 ++++----
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 08d83e6867..05cab468e3 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1141,17 +1141,17 @@ static int get_first_good(const char *refname UNUSED,
 	return 1;
 }
 
-static int do_bisect_run(const char *command)
+static int do_bisect_run(const char *command, const char *unquoted_cmd)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
-	printf(_("running %s\n"), command);
+	printf(_("running %s\n"), unquoted_cmd);
 	cmd.use_shell = 1;
 	strvec_push(&cmd.args, command);
 	return run_command(&cmd);
 }
 
-static int verify_good(const struct bisect_terms *terms, const char *command)
+static int verify_good(const struct bisect_terms *terms, const char *command, const char *unquoted_cmd)
 {
 	int rc;
 	enum bisect_error res;
@@ -1171,7 +1171,7 @@ static int verify_good(const struct bisect_terms *terms, const char *command)
 	if (res != BISECT_OK)
 		return -1;
 
-	rc = do_bisect_run(command);
+	rc = do_bisect_run(command, unquoted_cmd);
 
 	res = bisect_checkout(&current_rev, no_checkout);
 	if (res != BISECT_OK)
@@ -1184,6 +1184,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 {
 	int res = BISECT_OK;
 	struct strbuf command = STRBUF_INIT;
+	struct strbuf unquoted = STRBUF_INIT;
 	const char *new_state;
 	int temporary_stdout_fd, saved_stdout;
 	int is_first_run = 1;
@@ -1197,8 +1198,9 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 	}
 
 	sq_quote_argv(&command, argv);
+	strbuf_join_argv(&unquoted, argc, argv,' ');
 	while (1) {
-		res = do_bisect_run(command.buf);
+		res = do_bisect_run(command.buf, unquoted.buf);
 
 		/*
 		 * Exit code 126 and 127 can either come from the shell
@@ -1208,11 +1210,11 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 		 * missing or non-executable script.
 		 */
 		if (is_first_run && (res == 126 || res == 127)) {
-			int rc = verify_good(terms, command.buf);
+			int rc = verify_good(terms, command.buf, unquoted.buf);
 			is_first_run = 0;
 			if (rc < 0) {
 				error(_("unable to verify '%s' on good"
-					" revision"), command.buf);
+					" revision"), unquoted.buf);
 				res = BISECT_FAILED;
 				break;
 			}
@@ -1226,7 +1228,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 
 		if (res < 0 || 128 <= res) {
 			error(_("bisect run failed: exit code %d from"
-				" '%s' is < 0 or >= 128"), res, command.buf);
+				" '%s' is < 0 or >= 128"), res, unquoted.buf);
 			break;
 		}
 
@@ -1260,20 +1262,21 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 		if (res == BISECT_ONLY_SKIPPED_LEFT)
 			error(_("bisect run cannot continue any more"));
 		else if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) {
-			printf(_("bisect run success"));
+			puts(_("bisect run success"));
 			res = BISECT_OK;
 		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
-			printf(_("bisect found first bad commit"));
+			puts(_("bisect run success"));
 			res = BISECT_OK;
 		} else if (res) {
-			error(_("bisect run failed: 'git bisect--helper --bisect-state"
-				" %s' exited with error code %d"), new_state, res);
+			error(_("bisect run failed: 'bisect-state %s'"
+				" exited with error code %d"), new_state, res);
 		} else {
 			continue;
 		}
 		break;
 	}
 
+	strbuf_release(&unquoted);
 	strbuf_release(&command);
 	return res;
 }
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 6c2c57cadf..a3dc5c8140 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -285,7 +285,7 @@ test_bisect_run_args () {
 	test_cmp expect.args actual.args
 }
 
-test_expect_failure 'git bisect run: args, stdout and stderr with no arguments' "
+test_expect_success 'git bisect run: args, stdout and stderr with no arguments' "
 	test_bisect_run_args <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
 	EOF_ARGS
 	running ./run.sh
@@ -295,7 +295,7 @@ test_expect_failure 'git bisect run: args, stdout and stderr with no arguments'
 	EOF_ERR
 "
 
-test_expect_failure 'git bisect run: args, stdout and stderr: "--" argument' "
+test_expect_success 'git bisect run: args, stdout and stderr: "--" argument' "
 	test_bisect_run_args -- <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
 	<-->
 	EOF_ARGS
@@ -306,7 +306,7 @@ test_expect_failure 'git bisect run: args, stdout and stderr: "--" argument' "
 	EOF_ERR
 "
 
-test_expect_failure 'git bisect run: args, stdout and stderr: "--log foo --no-log bar" arguments' "
+test_expect_success 'git bisect run: args, stdout and stderr: "--log foo --no-log bar" arguments' "
 	test_bisect_run_args --log foo --no-log bar <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
 	<--log>
 	<foo>
@@ -320,7 +320,7 @@ test_expect_failure 'git bisect run: args, stdout and stderr: "--log foo --no-lo
 	EOF_ERR
 "
 
-test_expect_failure 'git bisect run: args, stdout and stderr: "--bisect-start" argument' "
+test_expect_success 'git bisect run: args, stdout and stderr: "--bisect-start" argument' "
 	test_bisect_run_args --bisect-start <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
 	<--bisect-start>
 	EOF_ARGS
-- 
2.38.1.157.gedabe22e0a

