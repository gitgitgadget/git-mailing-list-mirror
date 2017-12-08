Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBB2620C31
	for <e@80x24.org>; Fri,  8 Dec 2017 17:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbdLHRCf (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:02:35 -0500
Received: from mout.gmx.net ([212.227.15.18]:56198 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752050AbdLHRCc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:02:32 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmKag-1evrmL23dK-00Zx6c; Fri, 08
 Dec 2017 18:02:27 +0100
Date:   Fri, 8 Dec 2017 18:02:26 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Adric Norris <landstander668@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] git version --build-options: report the build platform,
 too
In-Reply-To: <cover.1512752468.git.johannes.schindelin@gmx.de>
Message-ID: <978adf12e85ec6c4d407ba09da82945a08ee1f8c.1512752468.git.johannes.schindelin@gmx.de>
References: <cover.1512752468.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7QiYORUn0rxciUxcN+xKc82hLEYPblyYzHgmDSFczBD9Y9sqAAc
 qEf87VoLmm8YxtkuKdDfyODkd5PI8pZLSC6OPpryhqY164Z3E0Ux+kLHevsGvVgIvcI2MDP
 cvboNd0FCXylbtLTWW7zxj45NLJVTBZWJZfTWgUiA7wP2x9BQ+0XoYutQZfhijtdePdfl9f
 e78Gp70ADmRuUBZe55GZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dEOZMNF405M=:0kWfHK9oS2sM9dZGt+1w8g
 YmzBzuP+aNxk8RksrmffIgY1l71b7T4RFhWmuyVLgRy5MTsjiMD+dpN03vyzyRtH+Wi085DFy
 FJR0NGr+GRKnviaDVdvxMvHZqeJSCG3Xagna54gDhRbzNtMEENyvIT4JfWVHRbl3ui2LvJBe1
 7B5xcahJtMyIK820Ws5xUrAWYhm8CFjgtQRVKebP+HiX7UXfNGQo2xRSPCKD2RsU5s58nR6N0
 dmdunkvZfW8Vjrt49Qhvy7pu5wHxa/Tt/tz3YTAMogxLpaemM2ItxiukYdVE1iFyT43ol3xOH
 jooNgH2gZ9+Z+r+BBsFvPjnsFqJTlok8yYJrf1gWK7mWhS07e8uFhCrHYfJz+WG7TdauJAu7l
 EZoyGnjkkPNmVJUmYjXD8Vzw4vWvLK9Nwu7WBFE+YiErc/l5bVLI2MEYShdN4EyhCtwuJyaqC
 ocvSCtla9LFZfx3P16Kug43CY6bCPmNnDcZWtKHNH4mfjHv5p1X/9b9+gWRtdCzB4ZKkrV6cs
 b1Wezd9n244JhbBLS60hoKKs/eqlmeP7pVoqVbWPcYyGs4u2QWruecGrrIlaIkzg9IUUCuref
 Hkdcsb+b7nWXLtiruu80u/k6MLoPvGycKDccYkadsdrGNPiiGfMDlUsM/CAgAJqeb5eMUUdDg
 AFQQ5RydJ5RpgR9zme6seXhyziwKtcZvz8QsSWtTf3nPzdleCerMMneG8nnoBwo05QlSFrO/O
 mftpG3mcaTNksDlaNrPeMuwvGFgSd/tAF7uHE55xRbHuQVHlJ8yTNrPQI3dby412OQ1qKT2TP
 lb8/VyHCyHUFWMtxCdqVP38MReYIoj7RZHb5uGnCuoZUXUiu+g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Adric Norris <landstander668@gmail.com>

When asking for bug reports to include the output of `git version
--build-options`, the idea is that we get a better idea of the
environment where said bug occurs. In this context, it is useful to
distinguish between 32 and 64-bit builds.

We start by distinguishing between x86 and x86_64 (hoping that
interested parties will extend this to other architectures in the
future).  In addition, all 32-bit variants (i686, i586, etc.) are
collapsed into `x86'. An example of the output is:

   $ git version --build-options
   git version 2.9.3.windows.2.826.g06c0f2f
   sizeof-long: 4
   machine: x86_64

The label of `machine' was chosen so the new information will approximate
the output of `uname -m'.

Signed-off-by: Adric Norris <landstander668@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 help.c |  2 ++
 help.h | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/help.c b/help.c
index 88a3aeaeb9f..df1332fa3c9 100644
--- a/help.c
+++ b/help.c
@@ -390,6 +390,7 @@ const char *help_unknown_cmd(const char *cmd)
 
 int cmd_version(int argc, const char **argv, const char *prefix)
 {
+	static char build_platform[] = GIT_BUILD_PLATFORM;
 	int build_options = 0;
 	const char * const usage[] = {
 		N_("git version [<options>]"),
@@ -413,6 +414,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 
 	if (build_options) {
 		printf("sizeof-long: %d\n", (int)sizeof(long));
+		printf("machine: %s\n", build_platform);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 	}
 	return 0;
diff --git a/help.h b/help.h
index b21d7c94e8c..42dd9852194 100644
--- a/help.h
+++ b/help.h
@@ -33,3 +33,16 @@ extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds, stru
  */
 extern void help_unknown_ref(const char *ref, const char *cmd, const char *error);
 #endif /* HELP_H */
+
+/*
+ * identify build platform
+ */
+#ifndef GIT_BUILD_PLATFORM
+	#if defined __x86__ || defined __i386__ || defined __i586__ || defined __i686__
+		#define GIT_BUILD_PLATFORM "x86"
+	#elif defined __x86_64__
+		#define GIT_BUILD_PLATFORM "x86_64"
+	#else
+		#define GIT_BUILD_PLATFORM "unknown"
+	#endif
+#endif
-- 
2.15.1.windows.2


