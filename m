Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167A12027C
	for <e@80x24.org>; Tue, 30 May 2017 20:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbdE3UqL (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 16:46:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36447 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdE3UqK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 16:46:10 -0400
Received: by mail-wr0-f193.google.com with SMTP id n104so4343863wrb.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u60HlWo3s0+b3IeNnZoHLuoQ6BbAiX0V1I00V3Hbj2Q=;
        b=c/HlE5c74xKPBqsLRmyXJNz+7bguoAq3c3LjhqCsSZON5KYH8u7uKeyrkQkUHic7eb
         OEHGJHqkSS/ZSEvJ/ZyJD2iFCXnqz5ISTXXeLBY0ghGQaOekHWHafWyDocUgXtsHYdZN
         Ah6iP5g2pD0nx26Qz2seP8BfosrhF5tveGQxLNw2MG9aAq6Hfsx2xhcu7RyQ6f+E30R+
         82ZEHl6kYlOmTrSHvaJT3DCL94yroVA2SePRsawNWFVslrhNE8sjK73sKY3tOyHQKOJW
         jQQzSMp0cvEhAMxFsbdU5N+VS6FdMc5InoCt9RILv/BwOEzgq69TSMDtPqVpwqvllGoK
         WhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u60HlWo3s0+b3IeNnZoHLuoQ6BbAiX0V1I00V3Hbj2Q=;
        b=KBHqkYQqFo19Wbt5/CLY1vDphdLTdBgRHGLuWD5mcgf3oyKRIw/3TtMdPqofzRS5l7
         s/t3lqw+1/f2e51ab4OY2GlgxisD+SFTmu7hEdoV4BjKCNDArhjKdansFskTltooCGpG
         M6J3B0SpFAclZGSkr9yC/nA+zdOC+8x8LD0SbB2YzQ7G5RgBdT1k97XtmCbRsir5UvQW
         bdmw04k5tUQCWYif4NXI7HtsJsVcxcwRxOee6xL1dUq5MUAQS7w/3Q1Osd5HMfQa2sGX
         mYjBH2pcwMFFV6r1wWASCnrhEvBpKyixQVZRIpntuJiu4vRQcZBz1OjxOLIc/r7DMEu4
         8SIA==
X-Gm-Message-State: AODbwcCPZ+ymGpfH6DlpRkYDIjWiI7l7D5ppMgE/PdMT7JHHGu3Qwe6u
        823PM3KM4YE9/jeMIQU=
X-Received: by 10.223.135.42 with SMTP id a39mr14545078wra.113.1496177168147;
        Tue, 30 May 2017 13:46:08 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 1sm21668776wrw.32.2017.05.30.13.46.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 May 2017 13:46:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6.5?/8] version: move --build-options to a test helper
Date:   Tue, 30 May 2017 20:45:53 +0000
Message-Id: <20170530204553.25968-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170530051742.3j3yn3ipfmyrrteu@sigill.intra.peff.net>
References: <20170530051742.3j3yn3ipfmyrrteu@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the undocumented --build-options argument to a test helper. It's
purely used for testing git itself, so it belongs in a test helper
instead of something that's part of the public plumbing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Tue, May 30, 2017 at 7:17 AM, Jeff King <peff@peff.net> wrote:
> The "git version" command didn't traditionally accept any
> options, and in fact ignores any you give it. When we added
> simple option parsing for "--build-options" in 6b9c38e14, we
> didn't improve this; we just loop over the arguments and
> pick out the one we recognize.
>
> Instead, let's move to a real parsing loop, complain about
> nonsense options, and recognize conventions like "-h".
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I assume nobody was running "git version --foobar" and expecting it to
> work. I guess we could also complain about "git version foobar" (no
> dashes), but this patch doesn't. Mainly I wanted the auto-generated
> options list.

Looks good to me. I started hacking this up the other day, but then
thought "wait a minute, isn't this just a test helper?" and wrote this
which I've rebased on top of your change.

I may be missing something here but isn't this a much straightforward
way to accomplish this, or is this used by some external program
outside of git.git that's going to rely on --build-options output?

 Makefile                      | 1 +
 help.c                        | 7 -------
 t/helper/.gitignore           | 1 +
 t/helper/test-long-is-64bit.c | 6 ++++++
 t/test-lib.sh                 | 9 +--------
 5 files changed, 9 insertions(+), 15 deletions(-)
 create mode 100644 t/helper/test-long-is-64bit.c

diff --git a/Makefile b/Makefile
index 2ed6db728a..aa908ae75a 100644
--- a/Makefile
+++ b/Makefile
@@ -623,6 +623,7 @@ TEST_PROGRAMS_NEED_X += test-hashmap
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-lazy-init-name-hash
 TEST_PROGRAMS_NEED_X += test-line-buffer
+TEST_PROGRAMS_NEED_X += test-long-is-64bit
 TEST_PROGRAMS_NEED_X += test-match-trees
 TEST_PROGRAMS_NEED_X += test-mergesort
 TEST_PROGRAMS_NEED_X += test-mktemp
diff --git a/help.c b/help.c
index f637fc8006..0a7628a922 100644
--- a/help.c
+++ b/help.c
@@ -384,14 +384,11 @@ const char *help_unknown_cmd(const char *cmd)
 
 int cmd_version(int argc, const char **argv, const char *prefix)
 {
-	int build_options = 0;
 	const char * const usage[] = {
 		N_("git version [<options>]"),
 		NULL
 	};
 	struct option options[] = {
-		OPT_BOOL(0, "build-options", &build_options,
-			 "also print build options"),
 		OPT_END()
 	};
 
@@ -405,10 +402,6 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	 */
 	printf("git version %s\n", git_version_string);
 
-	if (build_options) {
-		printf("sizeof-long: %d\n", (int)sizeof(long));
-		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
-	}
 	return 0;
 }
 
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index 721650256e..739c4c745c 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -13,6 +13,7 @@
 /test-index-version
 /test-lazy-init-name-hash
 /test-line-buffer
+/test-long-is-64bit
 /test-match-trees
 /test-mergesort
 /test-mktemp
diff --git a/t/helper/test-long-is-64bit.c b/t/helper/test-long-is-64bit.c
new file mode 100644
index 0000000000..45fc120432
--- /dev/null
+++ b/t/helper/test-long-is-64bit.c
@@ -0,0 +1,6 @@
+#include "git-compat-util.h"
+
+int cmd_main(int argc, const char **argv)
+{
+	return (8 <= (int)sizeof(long)) ? 0 : 1;
+}
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ec2571f018..bf649fbc03 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1165,14 +1165,7 @@ run_with_limited_cmdline () {
 
 test_lazy_prereq CMDLINE_LIMIT 'run_with_limited_cmdline true'
 
-build_option () {
-	git version --build-options |
-	sed -ne "s/^$1: //p"
-}
-
-test_lazy_prereq LONG_IS_64BIT '
-	test 8 -le "$(build_option sizeof-long)"
-'
+test_lazy_prereq LONG_IS_64BIT 'test-long-is-64bit'
 
 test_lazy_prereq TIME_IS_64BIT 'test-date is64bit'
 test_lazy_prereq TIME_T_IS_64BIT 'test-date time_t-is64bit'
-- 
2.13.0.303.g4ebf302169

