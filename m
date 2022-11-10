Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD0EC4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiKJQgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiKJQgf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:36:35 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CEB1AF11
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:36:34 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k5so1945727pjo.5
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6/M+xBbwX8AymapkCXKPkiluUoOMHcEae5Zp2niHWQ=;
        b=kDzTyGQ3ubC50gAgD0K6puUB3Qf/UjzLVf46vbhfz+1k3RUFeitm/nWml6jz4uDXRI
         wvA4wyI9JKN9BYipbYgkG+yZLbkvh/1TC/ACR9mIGQiWJc4FgOmdBUYNY+b1/Jz7Hk4G
         XE5Yn2tPsizqCbfCpJt6aX2G7Zyny4CA+RT4qBJO+/j9MMi9tIwplOtLEcqvoOoCBXk9
         QdCpTlyvY4+2Mz/KUgO5mrc1CAGU4lJKNnNxHZ1I5nzMUrVCgMZerjpTcjIgbSTi6qQK
         CIBSZif1byWq27Tfu837N6ihEDDdSXZ2BnZeGvTPaGm2+jpDBMOxPRmksvY3gaQytLCP
         GS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6/M+xBbwX8AymapkCXKPkiluUoOMHcEae5Zp2niHWQ=;
        b=ufS9w9T6mbaBGcLkVHmD4OI1OFec0ci46atHP91cme8OxHm4gSPvO7riLexR66vTXt
         iwjIHjrwWNdWy5YtBtPsw4WrQ0NY4sFNXmzNPvqcPmIBKXFp0St9HBZoDHc7YXJvn/VQ
         823XkPmfrSPvUuwvZoNzs+Fcck+/1SJth5HIGJeqYd+o0QoovvoBsWUMGAW3b8oESiCy
         /3ZWHb2aBNYWSgEriHC4dXUFsDIH0HVErntpFVCtLVHHtXG7BJ0XZ14ZqEBST97++ixb
         n3o7EXjS2R02ZU+YycqhsK4pEk0LLiIQf6wyykOLFMA6oLweEgmb4b1Px+n5NQMPiGSI
         8ijw==
X-Gm-Message-State: ACrzQf3CDjT2k01j0vhJXt2jloK+/5jjnPBh9D+ySMZlZJ3FP3tLqz5h
        EYaKh1fnpHt8DSCmsktu38bmESbRKV0=
X-Google-Smtp-Source: AMsMyM47TaUUUbXcqhPbF9yOaYSNYe2HNQzFpj1rmDT4+lOu48FruYmy3B/L5ndfVmwcOXf1Vu8Egg==
X-Received: by 2002:a17:902:9b8e:b0:187:30ec:67dd with SMTP id y14-20020a1709029b8e00b0018730ec67ddmr50695347plp.79.1668098193385;
        Thu, 10 Nov 2022 08:36:33 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id b29-20020a631b5d000000b0047022e07035sm9371372pgm.47.2022.11.10.08.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:36:32 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/3] bisect--helper: remove unused options
Date:   Thu, 10 Nov 2022 23:36:20 +0700
Message-Id: <6b80fd93980ec5171fe0637cbd1a8173a5337da4.1668097286.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1668097286.git.congdanhqx@gmail.com>
References: <cover.1667561761.git.congdanhqx@gmail.com> <cover.1668097286.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git-bisect.sh' used to have a 'bisect_next_check' to check if we have
both good/bad, old/new terms set or not.  In commit 129a6cf344
(bisect--helper: `bisect_next_check` shell function in C, 2019-01-02),
a subcommand for bisect--helper was introduced to port the check to C.
Since d1bbbe45df (bisect--helper: reimplement `bisect_run` shell
function in C, 2021-09-13), all users of 'bisect_next_check' was
re-implemented in C, this subcommand was no longer used but we forgot
to remove '--bisect-next-check'.

'git-bisect.sh' also used to have a 'bisect_write' function, whose
third positional parameter was a "nolog" flag.  This flag was only used
when 'bisect_start' invoked 'bisect_write' to write the starting good
and bad revisions.  Then 0f30233a11 (bisect--helper: `bisect_write`
shell function in C, 2019-01-02) ported it to C as a command mode of
'bisect--helper', which (incorrectly) added the '--no-log' option,
and convert the only place ('bisect_start') that call 'bisect_write'
with 'nolog' to 'git bisect--helper --bisect-write' with 'nolog'
instead of '--no-log', since 'bisect--helper' has command modes not
subcommands, all other command modes see and handle that option as well.
This bogus state didn't last long, however, because in the same patch
series 06f5608c14 (bisect--helper: `bisect_start` shell function
partially in C, 2019-01-02) the C reimplementation of bisect_start()
started calling the bisect_write() C function, this time with the
right 'nolog' function parameter. From then on there was no need for
the '--no-log' option in 'bisect--helper'. Eventually all bisect
subcommands were ported to C as 'bisect--helper' command modes, each
calling the bisect_write() C function instead, but when the
'--bisect-write' command mode was removed in 68efed8c8a
(bisect--helper: retire `--bisect-write` subcommand, 2021-02-03) it
forgot to remove that '--no-log' option.
'--no-log' option had never been used and it's unused now.

Let's remove --bisect-next-check and --no-log from option parsing.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1d2ce8a0e1..5ec2e67f59 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1283,7 +1283,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
 		BISECT_AUTOSTART,
@@ -1295,12 +1294,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_VISUALIZE,
 		BISECT_RUN,
 	} cmdmode = 0;
-	int res = 0, nolog = 0;
+	int res = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
-			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
 			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
@@ -1319,8 +1316,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
 		OPT_CMDMODE(0, "bisect-run", &cmdmode,
 			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
-		OPT_BOOL(0, "no-log", &nolog,
-			 N_("no log for BISECT_WRITE")),
 		OPT_END()
 	};
 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
-- 
2.38.1.157.gedabe22e0a

