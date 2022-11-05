Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C01FC433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiKERIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKERIR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:08:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE82E0B1
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:08:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l2so7528823pld.13
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QCCLi420XamhPYi2nK2ZtveTOFCgi6Gy6dRkWmkvDI=;
        b=p9lh27vFOl+LtiIECQ3hS5L5KpkcKs80PF6NOq+p7uBRHvm6PF8OL8+q/9wwtFpfHJ
         kY0LwzOykH2HRxxN280LsWkcTfuGK/XjdbrTeeMWCZV0fzV+s2Ekui03kKX8SftH+dgv
         m15+fixBvJU9o3wWVkoulPzSVEHkQElKjlgr2b/8egRArJisbQoTmXxMAYKCIxg0764O
         8+LBQb4QuGRWz/0Y5HKDcmN+gpl2uL08eYDfE+LFEoeWdrxJiwOLx6r9vLfcGpbnY2Xy
         3j8cn0pj0LHIz3tjYF8nTVPZU3LFrHbrxWaauKThNZ/vxoh+8JpZXtbTmfQ2KZvnwNNa
         fOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QCCLi420XamhPYi2nK2ZtveTOFCgi6Gy6dRkWmkvDI=;
        b=k40izDknFFBN/YbUVzve/hceSujpCZ51nOJ1nWt4UAhWNh7w7jKp5yPR1XYGnGRPLT
         IFDhsQPLUQVhKhHH7ANOOfl9IaE0KE00XracDV09SscWrEMgJ/mnnlsnSf4FJKjvxm6E
         goaKKaDIhf704O1nnKKkwt+x7sgr/1oxfdq6fJAUG00YHLAdx8BVcd1/ba+hFzIH4L7u
         BL+0VKT71ft5ThwqVHWvkIG9L07dWxwh6+BG56cVvLSjGtzrqx7sWoMWubYhM50z14bf
         BkJMdz+hdGPdgRP8rMWZSmboiAkgnQ20GPNCHK9ttX7s9OnU41WF+rIuA2Bp/Ib1ktKw
         XWFQ==
X-Gm-Message-State: ACrzQf3Xn+G3UArm9gkXengBGIOzm5009vEfRITNT4BRW+gX9iP12+y3
        Dg/pkOj5vS05Um9pLZcUohF2g0Ns3gQ=
X-Google-Smtp-Source: AMsMyM5+jW9W19ixZaJUvogm8GoFP/MJ8SlGEi1EGL4AF1vQUX+krymM+k2lhs1eqcDCHgG6Dibb7g==
X-Received: by 2002:a17:902:ea95:b0:186:a6b7:4410 with SMTP id x21-20020a170902ea9500b00186a6b74410mr42724210plb.109.1667668088865;
        Sat, 05 Nov 2022 10:08:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0056299fd2ba2sm1513192pfj.162.2022.11.05.10.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:08:08 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 05/13] bisect run: keep some of the post-v2.30.0 output
Date:   Sun,  6 Nov 2022 00:07:36 +0700
Message-Id: <5ba3bafdd48b47320624d0db06f379bc0a4b8d4e.1667667460.git.congdanhqx@gmail.com>
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
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c    | 12 ++++++------
 t/t6030-bisect-porcelain.sh | 16 ++++++++--------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7416283d07..f16b9df8fd 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1141,14 +1141,14 @@ static int get_first_good(const char *refname UNUSED,
 	return 1;
 }
 
-static int do_bisect_run(const char *command, int argc, const char **argv)
+static int do_bisect_run(const char *command, int argc UNUSED, const char **argv UNUSED)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	struct strbuf buf = STRBUF_INIT;
+	const char *trimed = command;
 
-	strbuf_join_argv(&buf, argc, argv, ' ');
-	printf(_("running %s\n"), buf.buf);
-	strbuf_release(&buf);
+	while (*trimed && isspace(*trimed))
+		trimed++;
+	printf(_("running %s\n"), trimed);
 	cmd.use_shell = 1;
 	strvec_push(&cmd.args, command);
 	return run_command(&cmd);
@@ -1266,7 +1266,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 			puts(_("bisect run success"));
 			res = BISECT_OK;
 		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
-			puts(_("bisect run success"));
+			puts(_("bisect found first bad commit"));
 			res = BISECT_OK;
 		} else if (res) {
 			error(_("bisect run failed: 'bisect-state"
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 914ea564b9..9e14e1e836 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -288,9 +288,9 @@ test_bisect_run_args () {
 test_expect_success 'git bisect run: args, stdout and stderr with no arguments' '
 	test_bisect_run_args <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
 	EOF_ARGS
-	running ./run.sh
+	running '\''./run.sh'\''
 	$HASH4 is the first bad commit
-	bisect run success
+	bisect found first bad commit
 	EOF_OUT
 	EOF_ERR
 '
@@ -299,9 +299,9 @@ test_expect_success 'git bisect run: args, stdout and stderr: "--" argument' '
 	test_bisect_run_args -- <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
 	<-->
 	EOF_ARGS
-	running ./run.sh --
+	running '\''./run.sh'\'' '\''--'\''
 	$HASH4 is the first bad commit
-	bisect run success
+	bisect found first bad commit
 	EOF_OUT
 	EOF_ERR
 '
@@ -313,9 +313,9 @@ test_expect_success 'git bisect run: args, stdout and stderr: "--log foo --no-lo
 	<--no-log>
 	<bar>
 	EOF_ARGS
-	running ./run.sh --log foo --no-log bar
+	running '\''./run.sh'\'' '\''--log'\'' '\''foo'\'' '\''--no-log'\'' '\''bar'\''
 	$HASH4 is the first bad commit
-	bisect run success
+	bisect found first bad commit
 	EOF_OUT
 	EOF_ERR
 '
@@ -324,9 +324,9 @@ test_expect_success 'git bisect run: args, stdout and stderr: "--bisect-start" a
 	test_bisect_run_args --bisect-start <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
 	<--bisect-start>
 	EOF_ARGS
-	running ./run.sh --bisect-start
+	running '\''./run.sh'\'' '\''--bisect-start'\''
 	$HASH4 is the first bad commit
-	bisect run success
+	bisect found first bad commit
 	EOF_OUT
 	EOF_ERR
 '
-- 
2.38.1.157.gedabe22e0a

