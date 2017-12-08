Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65CBA20C31
	for <e@80x24.org>; Fri,  8 Dec 2017 17:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbdLHRCj (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:02:39 -0500
Received: from mout.gmx.net ([212.227.15.19]:59017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752050AbdLHRCg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:02:36 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lx83d-1f7gA50d1V-016hPZ; Fri, 08
 Dec 2017 18:02:32 +0100
Date:   Fri, 8 Dec 2017 18:02:31 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] version --build-options: report commit, too, if
 possible
In-Reply-To: <cover.1512752468.git.johannes.schindelin@gmx.de>
Message-ID: <908989103a06291e38c8551c447bc73eb781fb26.1512752468.git.johannes.schindelin@gmx.de>
References: <cover.1512752468.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Qg/WKH59cUh46qMQDmrzbC2Amem5v4eOn7gLRJ4UE/UjmrdQdpz
 hUtaDlfIbvxUjgOeYQityGnFr4CNqQYvb64t+T4Q6TGMAhZg4QWJ1TpL5PZB/S/v3OorM5T
 T1BxjU2mK42G35xAIt15NP8rQoRZqQv/HdnoGG1gaM5Ep/7lEPdHl1EZVqXrtrFGWvSBgBc
 Ej5fSaBmJaGtlzqWLdwRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jx/aqobMr78=:nV4H4vXquDJzttV3n/il9D
 102Cs02LV9uPjwwlTbWc0hAe897klI1GMminMdGaCFNJA1y8kXYCFbmkGtjYV8pNohNFT0eWh
 Sl+1LcI7+2TDXt7jdvgXsK9uq6dP25rOjlqobykb6B+kl8/UT3cchrkDfi1k8yjcIPcCt4/MV
 4iN4Vq3Rn+Xg/9fdKR1cC9tmXxoro2MJxT+5hySfGnrBniiB3IiN892VnQ/suzB5dhyw/Yycs
 NHu7LBwKzJEy42SsjKTXqhU93mep2TMhi3UoiDHK2V1FL3PEucEGSagaeqnYp53aUkayxYlGR
 piPOaBVhRoMyT2vEj0Jbck2WdGUAlcZTOgTJGj3/s/xjigQstgBzL2bBdka9NukkWfi2t/+n1
 mdjbuGeln2JvyENbr+MI5iqmMxMCoKGLmvFCQb+xbs6Q8S2ey+EgtBs2lR59iTgExMF5bPD1R
 ge0AF/MSSQVtxkn00+Bvaydq7ViQ54zY6ki4mE/A6SWO1JbNc03bl/i1BSHTZSeXdPd8gBFTS
 yCejMAM8MIDGZLjNxYiPEI4RfxupbgtutnkZi+rNULPRLjlMqu8GJ3TXmAcuoN1NDjnqCQh4q
 3cJaC+nsEt559JFo2Ql5Wf1CWS/VSK9/egVcjuEksAA3dmnj7+EiBWjcZxjFSnWtVJihFy4hr
 j+koIgBzBPj8kWyEldLH9+Tu7/+WfCP5xsQq7etKT89pLtjLjac/isU+Nij7FRzN/gCx1bMAa
 EgCUciPqM9BxQm6f4+59X3tNphLYacfk4Bs24vvO9PQz4v7Um3+2xzNRiG4YXR+sIvvDO1fd1
 c7ob1fserxTjPzLkSr1e//6++Rz7se4bC0f8zmhAXqhPmyAzuI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In particular when local tags are used (or tags that are pushed to some
fork) to build Git, it is very hard to figure out from which particular
revision a particular Git executable was built.

Let's just report that in our build options.

We need to be careful, though, to report when the current commit cannot be
determined, e.g. when building from a tarball without any associated Git
repository.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile  | 4 +++-
 help.c    | 2 ++
 version.c | 1 +
 version.h | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index fef9c8d2725..92a0ae3d8e3 100644
--- a/Makefile
+++ b/Makefile
@@ -1893,7 +1893,9 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 version.sp version.s version.o: GIT-VERSION-FILE GIT-USER-AGENT
 version.sp version.s version.o: EXTRA_CPPFLAGS = \
 	'-DGIT_VERSION="$(GIT_VERSION)"' \
-	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)'
+	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)' \
+	'-DGIT_BUILT_FROM_COMMIT="$(shell git rev-parse -q --verify HEAD || \
+		echo "(unknown)")"'
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
diff --git a/help.c b/help.c
index df1332fa3c9..6ebea665780 100644
--- a/help.c
+++ b/help.c
@@ -413,6 +413,8 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	printf("git version %s\n", git_version_string);
 
 	if (build_options) {
+		printf("built from commit: %s\n",
+		       git_built_from_commit_string);
 		printf("sizeof-long: %d\n", (int)sizeof(long));
 		printf("machine: %s\n", build_platform);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
diff --git a/version.c b/version.c
index 6106a8098c8..41b718c29e1 100644
--- a/version.c
+++ b/version.c
@@ -3,6 +3,7 @@
 #include "strbuf.h"
 
 const char git_version_string[] = GIT_VERSION;
+const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
 
 const char *git_user_agent(void)
 {
diff --git a/version.h b/version.h
index 6911a4f1558..7c62e805771 100644
--- a/version.h
+++ b/version.h
@@ -2,6 +2,7 @@
 #define VERSION_H
 
 extern const char git_version_string[];
+extern const char git_built_from_commit_string[];
 
 const char *git_user_agent(void);
 const char *git_user_agent_sanitized(void);
-- 
2.15.1.windows.2
