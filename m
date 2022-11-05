Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A98C433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiKERIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKERII (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:08:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BABEE08B
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:08:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p12so2064342plq.4
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqtsFEImrv+PGMPFGChSgSAJ+j/5GMEgmedC7QxWQV0=;
        b=hrTtrEnHZR5nMYRqCUjrQOO9J0h3RdjeS9PT7+TzyoNrScZh+2NbqtjV8xtTc3Nn1a
         HHvXsWx/Wk04MTHPN71ggil9s788aPicBnv39bqg1XJbCxPJMn7FLyPvQBa+0KVlP0Sd
         W954HTHKdK1y7urFUqWjjgtvlDxSmrzaaQqWvy/z99dyLfEnz/uPlIYL7xeSHc50RQUs
         mspneCAuNIIJJiVg/zr6k/JrzqyspNABpfJM3Q0mq6msCgc9DLq/x9CF3bJdaSttYZpA
         AmcTGa471PcC38s2pQzhsNPz2A9UR6TsGLw9smrkYvJ3Jqp4OndJOm/XpLi7kJmrwjye
         dsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqtsFEImrv+PGMPFGChSgSAJ+j/5GMEgmedC7QxWQV0=;
        b=eYCSz1zA14l/65ti9ygo1+Dmtbi2TlxWXBp80mvIv4McOsnAUP95nVwi5KnlimPsyc
         BR1c7Pqu2w7ARjQaZtbG2HaEl0m8cWb+F3+HIpAq7UyLoGOVCjNpk5qfRn7XScA8nr8Y
         lVWrMd5HfkgHgCt6bzZKs69xCiUXj2OaRVbw7NGNJ3OzzjTg2BC+ir3r8k8afeIkb9i9
         beVQ5wIf9RHvLck3wewPUhvkGhyQMypcazQR4qr+wfjRt+Ectw/tIDgVLVu47QTrVe41
         ppTorOL7zxTnD7IW79XM/jmnmJz0E1fppb2FGHmP/saGcVXDI4RLUeungtkW7L8/0/JU
         hUDg==
X-Gm-Message-State: ACrzQf2pGi7c706CXJV3LMz1F4K1QJZocKt0Vtkml6zBDWtaROUIKEy5
        2fHFqQamJIYQK0ObUjCIsVU9wrh4COo=
X-Google-Smtp-Source: AMsMyM5TMyiuwk17cbt97HRp05xS70LI/QN/hJLfh32mxb5jUYwu05RjJo4iChvlgufFeiGSkJBV4Q==
X-Received: by 2002:a17:90b:50e:b0:213:d7cb:83e3 with SMTP id r14-20020a17090b050e00b00213d7cb83e3mr35156407pjz.232.1667668086236;
        Sat, 05 Nov 2022 10:08:06 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0056299fd2ba2sm1513192pfj.162.2022.11.05.10.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:08:05 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 04/13] bisect: fix output regressions in v2.30.0
Date:   Sun,  6 Nov 2022 00:07:35 +0700
Message-Id: <31cd78f53878b09ae74e40994070fbc8c25102f7.1667667460.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667460.git.congdanhqx@gmail.com>
References: <cover.1667667058.git.congdanhqx@gmail.com> <cover.1667667460.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

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
 builtin/bisect--helper.c    | 13 ++++++++-----
 t/t6030-bisect-porcelain.sh |  8 ++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 35e5dc4bbf..7416283d07 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1141,11 +1141,14 @@ static int get_first_good(const char *refname UNUSED,
 	return 1;
 }
 
-static int do_bisect_run(const char *command, int argc UNUSED, const char **argv UNUSED)
+static int do_bisect_run(const char *command, int argc, const char **argv)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf buf = STRBUF_INIT;
 
-	printf(_("running %s\n"), command);
+	strbuf_join_argv(&buf, argc, argv, ' ');
+	printf(_("running %s\n"), buf.buf);
+	strbuf_release(&buf);
 	cmd.use_shell = 1;
 	strvec_push(&cmd.args, command);
 	return run_command(&cmd);
@@ -1260,13 +1263,13 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
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
+			error(_("bisect run failed: 'bisect-state"
 				" %s' exited with error code %d"), new_state, res);
 		} else {
 			continue;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 6901bbd202..914ea564b9 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -285,7 +285,7 @@ test_bisect_run_args () {
 	test_cmp expect.args actual.args
 }
 
-test_expect_failure 'git bisect run: args, stdout and stderr with no arguments' '
+test_expect_success 'git bisect run: args, stdout and stderr with no arguments' '
 	test_bisect_run_args <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
 	EOF_ARGS
 	running ./run.sh
@@ -295,7 +295,7 @@ test_expect_failure 'git bisect run: args, stdout and stderr with no arguments'
 	EOF_ERR
 '
 
-test_expect_failure 'git bisect run: args, stdout and stderr: "--" argument' '
+test_expect_success 'git bisect run: args, stdout and stderr: "--" argument' '
 	test_bisect_run_args -- <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
 	<-->
 	EOF_ARGS
@@ -306,7 +306,7 @@ test_expect_failure 'git bisect run: args, stdout and stderr: "--" argument' '
 	EOF_ERR
 '
 
-test_expect_failure 'git bisect run: args, stdout and stderr: "--log foo --no-log bar" arguments' '
+test_expect_success 'git bisect run: args, stdout and stderr: "--log foo --no-log bar" arguments' '
 	test_bisect_run_args --log foo --no-log bar <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
 	<--log>
 	<foo>
@@ -320,7 +320,7 @@ test_expect_failure 'git bisect run: args, stdout and stderr: "--log foo --no-lo
 	EOF_ERR
 '
 
-test_expect_failure 'git bisect run: args, stdout and stderr: "--bisect-start" argument' '
+test_expect_success 'git bisect run: args, stdout and stderr: "--bisect-start" argument' '
 	test_bisect_run_args --bisect-start <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
 	<--bisect-start>
 	EOF_ARGS
-- 
2.38.1.157.gedabe22e0a

