Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AD1C43217
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiKERII (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiKERIF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:08:05 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89159DFAB
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:08:04 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b29so7055209pfp.13
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWKfCu3eizclDoAKKYbSK6+t0cQM0hGqk2Q2WU2E+ZE=;
        b=WDX5JjLal5smXXZBCvt3eynugIc4c6w7YUrWzzdOTxxeMDhMHpsDNKFSN+KeWDPmtJ
         vRyQSV6vgVL+QRDd6TypbcoN8DF8W0ChkqoRQ26GYe1WplJqABc8R5PrkXPAHwBnukY2
         l4UUPz88fcEZ6w0uHbqaZdTFbyWTmdDQBFSxn2SwI0A6eAaDs6/ySgrX/yo9ODMleOy5
         aMd9rbujNJXYUv2hATa4JN5SknGRhDqlAhBwK88Efrm7kFeg5VorTpVWYXpsxJpkUaj5
         z7aGpyro37fOeUNjyjsMAMVwsJ/S/alX+dzTM+QFkuNBlW1S3CwxArV/L/XaV1Fi0LjO
         w1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWKfCu3eizclDoAKKYbSK6+t0cQM0hGqk2Q2WU2E+ZE=;
        b=AgGqwnieJ+HpVRcErJBCkXy5T7S3UzmPdQaUjkWcvUCy//LZbUAzcA+ElRpM3aKejO
         wMRMEXohMICWAqN/01iUhBHzpw86/Fu0gyzq7gKGBUUaozxADhLycxNX8V5tqGZeCSzx
         Bf6sThmjCTty4Accz3hTHecvbOum/RVjiwAkiccPHLvG6TO8Yx5yDDtArhDzx+tBkbi3
         YkemYcgMT3MD6XLw6xujur9bwhSoQuR2zpS62A72ZzGdlwOjmfQM2+z9CxgtPu3Md+HL
         BnQvzvcqQLzN0EH6y3kezLG3/QqvlgVs2FSzohsfI/R1CpHYOzVVe8MLNJLvMv7VyYGf
         hOMg==
X-Gm-Message-State: ACrzQf2bcYAUcjWeBLA8WP4c9bmtxPBrl0u5+lViGhfEOgvX3JqYZKss
        SLuVEql5FW7MHHWTBQkRKEcaL5rEZFo=
X-Google-Smtp-Source: AMsMyM5s3a6Vsn3oVIGnhbg8xkBV2/ZCsEaOqE9fzyenmUCdRwjHViJsOx9zzPbaekbOaxDT0GWZyA==
X-Received: by 2002:a05:6a00:852:b0:56d:e2bc:1978 with SMTP id q18-20020a056a00085200b0056de2bc1978mr22695766pfk.47.1667668083657;
        Sat, 05 Nov 2022 10:08:03 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0056299fd2ba2sm1513192pfj.162.2022.11.05.10.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:08:03 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/13] bisect--helper: pass arg[cv] down to do_bisect_run
Date:   Sun,  6 Nov 2022 00:07:34 +0700
Message-Id: <8a815e231100b8bfcf2b03355cf11a36b2962a38.1667667460.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667460.git.congdanhqx@gmail.com>
References: <cover.1667667058.git.congdanhqx@gmail.com> <cover.1667667460.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell
function in C, 2021-09-13) has changed the logging of bisect-run by
adding one more space before argv[0], and single-quoting all arguments.

In a later change, we would like to restore the old behaviours,
which would need information regarding argc and argv.

Let's pass them down, now.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ee1197c8b2..35e5dc4bbf 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1141,7 +1141,7 @@ static int get_first_good(const char *refname UNUSED,
 	return 1;
 }
 
-static int do_bisect_run(const char *command)
+static int do_bisect_run(const char *command, int argc UNUSED, const char **argv UNUSED)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
@@ -1151,7 +1151,7 @@ static int do_bisect_run(const char *command)
 	return run_command(&cmd);
 }
 
-static int verify_good(const struct bisect_terms *terms, const char *command)
+static int verify_good(const struct bisect_terms *terms, const char *command, int argc, const char **argv)
 {
 	int rc;
 	enum bisect_error res;
@@ -1171,7 +1171,7 @@ static int verify_good(const struct bisect_terms *terms, const char *command)
 	if (res != BISECT_OK)
 		return -1;
 
-	rc = do_bisect_run(command);
+	rc = do_bisect_run(command, argc, argv);
 
 	res = bisect_checkout(&current_rev, no_checkout);
 	if (res != BISECT_OK)
@@ -1198,7 +1198,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 
 	sq_quote_argv(&command, argv);
 	while (1) {
-		res = do_bisect_run(command.buf);
+		res = do_bisect_run(command.buf, argc, argv);
 
 		/*
 		 * Exit code 126 and 127 can either come from the shell
@@ -1208,7 +1208,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 		 * missing or non-executable script.
 		 */
 		if (is_first_run && (res == 126 || res == 127)) {
-			int rc = verify_good(terms, command.buf);
+			int rc = verify_good(terms, command.buf, argc, argv);
 			is_first_run = 0;
 			if (rc < 0) {
 				error(_("unable to verify '%s' on good"
-- 
2.38.1.157.gedabe22e0a

