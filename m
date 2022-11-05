Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5137BC4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKERED (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKERD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:03:57 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7BFDFA3
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:03:56 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g129so6914044pgc.7
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md3Dr9Ue9e0sMOst3OmzF34QnMrubnqgr/qyoSJKszM=;
        b=ee0h8fLPUW9VCikQpZc2QLgDzjyG3m37qK6vss3k0QXvUHyeY+F24J4spFhT/9F92z
         dM8MIyw9XGVyW13rF31n0Rv2olC6kTDWvuNs5GCJ0clsioENm0ULAckFPHl1s5HnZhah
         w6vN82cSKg2UX3YaUOht6hfT088EvFWiQD0q9NHCWyyOtQ9kdhCyUAS8Pu5XTAa5wQ5G
         ZZub1gxdDIIiBi5fuSpM45stCPr0iVwLNw6EJNu4Gvep21Iq8qlDPFBoPVbPo+xu4qIv
         ClaE2bKFp3L8x7D+8xqGLcX9IWiQWLq9RFEwzhmTcBRBRp9eLO4MOJ7+0rZ2EmXxqkd7
         E3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md3Dr9Ue9e0sMOst3OmzF34QnMrubnqgr/qyoSJKszM=;
        b=t6x0wwl9GLYWvfzSzkuCAQBHL2HelMPMUTQO8eBx2z4JfMma+mYULDTK5/5mg6Vl2E
         OQVMoWcfo1SnR2hOXFBXaQq+ywVFwImUyDExYvDTCImwZJeoVojRunJ8wgYIH7N6cSer
         MOZOyyleSjaaw5DzZN/N15S/4ZUhjLipFIOMsf17hwtNUnyVPJ9115FpatWWBg6qO6xr
         gC0lFm3CbMgsJmhWh4SvTXsmZnWAytOWCmYBRZUKqkpk0HAVASjtfgnzb6AKXZRV4qeO
         h8YnmTuASVzAa2xvFdzHNro1hK05VqJM8biViJbac5KyVWHvjxNJNVuvhuqCKiXpZEYq
         MAGA==
X-Gm-Message-State: ACrzQf3SiwjIQlq0S8eJ44ALZ1aLtV/uh4uu5TXskpmV/p5agQqNFlWp
        9xL2IFGbw5yd33thixweFEJASGU2Y54=
X-Google-Smtp-Source: AMsMyM7PQG50JzLOcvhQFCDmBgIBSZnaYUNMnc55jgdRSpGpcoC+nQ3kSfWWHZoU92f7sCqG8kcjzA==
X-Received: by 2002:a63:194b:0:b0:457:7295:8de0 with SMTP id 11-20020a63194b000000b0045772958de0mr36099801pgz.612.1667667835354;
        Sat, 05 Nov 2022 10:03:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id jb14-20020a170903258e00b0016c0c82e85csm1910789plb.75.2022.11.05.10.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:03:54 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 1/3] bisect--helper: remove unused options
Date:   Sun,  6 Nov 2022 00:03:34 +0700
Message-Id: <6b80fd93980ec5171fe0637cbd1a8173a5337da4.1667667058.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667058.git.congdanhqx@gmail.com>
References: <cover.1667561761.git.congdanhqx@gmail.com> <cover.1667667058.git.congdanhqx@gmail.com>
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

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
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

