Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC9CC4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiKERIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiKERIR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:08:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5150610B76
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:08:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so7002196pjk.1
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwwhjvUZbGwC1Q7VY+wqYjMrtxoFGAbUAgTR1EqcyEk=;
        b=fkHNfUMt5UMGJ58/oNy0FsOS/R59slJFNrHaA/NY8vaAJ+IxSn2MU7SzqrC2Z0++vw
         8kinDbFSniNVqty1OU7c8ZesrbZ7wS7ZuShMG6vEXTSxb9otZQpIZja8pM4Ws5TVICi8
         Ygs3kY0PRXmuG1FtWhVeGzIIJS1ZQGbGU1zESVXJPEXoiP9WB4oomBMMrgxgiUjuJPkh
         FMmkFVrep0itLPvT6iBOKdJIanXF7PZlSZjcB0igkph55Uf6TaqLb+pBI2+lkWunu1qZ
         SLYjmFy5sGhYyQ6g6S3yFubsLuJayGP8/TK9626RcDPF1wI8c01EQCV8Fx0sOMpzZOPP
         Hd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwwhjvUZbGwC1Q7VY+wqYjMrtxoFGAbUAgTR1EqcyEk=;
        b=l/fhFXDWQUPdXuwyTSyQ742+qbCH9KRyW8Ii4+Yse6D6yWVLuMJa2nal3adeHy2D6V
         otJW7TVM/j2dnYIw0m6Bpl326R5RkO3ks7mGLZlFm0j2ouRVU0ukj5CRc0KPtK+odfPB
         pn5jH3zXa0hytp+79Ktjqez/WtAoZDPHw2Tqb41mspoGzkAiI3QdeGuggk+DRi//n6Dr
         BpNKjylEezBtXBBShf4m0aGirbD3IjQepOVKuRVJzRoS/afwUGWgzbGSBaPYwCcME68E
         xFinhhpoK7Nn8o0PKWwY7UTI3CXgEjMAK7GHMpolCNw29csaoF+rViuKLWuMeJeQUkFa
         8MHQ==
X-Gm-Message-State: ACrzQf3VZ7UIFMdwWGMiEjGewNQVLX7pqd12a+bWLJPNs7yYnmMcA7Xf
        ax9ak0XJOWxckw9THBXw2FrhkJP8jf0=
X-Google-Smtp-Source: AMsMyM5FaiJ3HgRiFJ9hmAgGCjxbJ21ZNNKQBDVz+62Nv2k7kyIomZ5PQksDSKfvrMwqtdcBULUiyw==
X-Received: by 2002:a17:90b:3a88:b0:213:f069:7197 with SMTP id om8-20020a17090b3a8800b00213f0697197mr30650629pjb.181.1667668091465;
        Sat, 05 Nov 2022 10:08:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0056299fd2ba2sm1513192pfj.162.2022.11.05.10.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:08:11 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/13] bisect--helper: remove unused arguments from do_bisect_run
Date:   Sun,  6 Nov 2022 00:07:37 +0700
Message-Id: <32ad47ddc521320dd67947b20fe548184d1a6b36.1667667460.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667460.git.congdanhqx@gmail.com>
References: <cover.1667667058.git.congdanhqx@gmail.com> <cover.1667667460.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Those arguments become unused with previous commit, let's remove them
now.  This effectively reverts commit HEAD~3.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index f16b9df8fd..b99cbb0dbe 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1141,7 +1141,7 @@ static int get_first_good(const char *refname UNUSED,
 	return 1;
 }
 
-static int do_bisect_run(const char *command, int argc UNUSED, const char **argv UNUSED)
+static int do_bisect_run(const char *command)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	const char *trimed = command;
@@ -1154,7 +1154,7 @@ static int do_bisect_run(const char *command, int argc UNUSED, const char **argv
 	return run_command(&cmd);
 }
 
-static int verify_good(const struct bisect_terms *terms, const char *command, int argc, const char **argv)
+static int verify_good(const struct bisect_terms *terms, const char *command)
 {
 	int rc;
 	enum bisect_error res;
@@ -1174,7 +1174,7 @@ static int verify_good(const struct bisect_terms *terms, const char *command, in
 	if (res != BISECT_OK)
 		return -1;
 
-	rc = do_bisect_run(command, argc, argv);
+	rc = do_bisect_run(command);
 
 	res = bisect_checkout(&current_rev, no_checkout);
 	if (res != BISECT_OK)
@@ -1201,7 +1201,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 
 	sq_quote_argv(&command, argv);
 	while (1) {
-		res = do_bisect_run(command.buf, argc, argv);
+		res = do_bisect_run(command.buf);
 
 		/*
 		 * Exit code 126 and 127 can either come from the shell
@@ -1211,7 +1211,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 		 * missing or non-executable script.
 		 */
 		if (is_first_run && (res == 126 || res == 127)) {
-			int rc = verify_good(terms, command.buf, argc, argv);
+			int rc = verify_good(terms, command.buf);
 			is_first_run = 0;
 			if (rc < 0) {
 				error(_("unable to verify '%s' on good"
-- 
2.38.1.157.gedabe22e0a

