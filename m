Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 915C51F404
	for <e@80x24.org>; Mon, 26 Mar 2018 21:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeCZVbu (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 17:31:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:52329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeCZVbt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 17:31:49 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVIva-1f4LCp0vEs-00YlN5; Mon, 26
 Mar 2018 23:31:45 +0200
Date:   Mon, 26 Mar 2018 23:31:44 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Dan Jacques <dnj@google.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 2/2] mingw/msvc: use the new-style RUNTIME_PREFIX helper
In-Reply-To: <20180325205120.17730-1-dnj@google.com>
Message-ID: <nycvar.QRO.7.76.6.1803262331420.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180325205120.17730-1-dnj@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:N70rblkbMpJ9Io0P3BV9bYyad2sUfneBEdpsr1/weJn7eJiZ/qP
 jibW+zeifS83nycb/7oXtzjcdn6wdKG4U3riL+hp9FgROjFxkJkoZFWbJgXOJSfZX7T4its
 EIk1EIhZZOSd9Azlcx144JYAXeEsQNZ7evDWe0mFKMaZ4ARJ1HMbO24wihvaTZoBRz8cZ66
 5YqGb0hQXEBJykxkaXNoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:alESQML0uj0=:ljQ6czFkocOsjJAL7aiplb
 IHNd/k3m6y/KfzKg+J1mZeat/dabD9SxFzd7d4V7IagvfC7ERdnZt3/7dQI4y0QS+bGoaub5t
 ToXGSglCyzO3CF+HxD7NcFpYbAQHUO8YvtMtQ5iAKxUT+2r8OYvV+kxwZqv9UUeUP0RAzovUZ
 Tek74oMOmHW0vkY3E8Ma/L4sn3a571RY7RLZQC5UB2hEzxSkjyMZ2zIESoroLFP2U2Q88mM2d
 efV9ndkogmrZ55Au61Cu9U2TAjz8IHjhh1WXHy1O8cHPhNdqI3YVkGScfwHWLve/t4OotzA7g
 2THyJgXOXutJWaP5aAV9VyWKleeu9HiDAsG1IiWE3ivraJoQQf/X+bTzOWplWEQPcyprDSvAo
 nT2FDqEZN7tMwBlA8VhjPpMkPinY+4WV1mgF6pWf/QDQaLkeUKpZ82vK/gLdd9TOG3uiN/rCL
 lNSsMkRo8MobUkwMjiQsh/krnxQJlFLDONTfpmcDylinNnZO5FVVGzGQ3hLXWZRoLqrgHJs6P
 vN2g8Os6ljI1dCS/mGKCee35WrVB6b0mi05pCwcCGacruZkMPtm15LfedlMY/B9wxYkkVn5By
 6mNKc1fl2FLvKt5srXUNr+KztB7DeJqd0A1D1tTn5HylvfD1kHNEh3MXBOvZJO+QfbnbO17mu
 +Ku98flTcoqBQBqKJEqAlekt69/vAlb+YnSPO3AUEbdIVY+O4R3zmCJ77P44KZkF0AWnZezKO
 RhN1lceCV9qMouwevHM/qBTQczbTE5Myul3L35HETZZcEUyzvcdfwur1F7M7tVgPyf85fjCzf
 af2M2Tsj460XpiXvZ00fH5BcrhkrNxpTTGpujVoYkp5DS9NHYtsRhvHHKZaTSbmk9LxW8Xb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change also allows us to stop overriding argv[0] with the absolute
path of the executable, allowing us to preserve e.g. the case of the
executable's file name.

This fixes https://github.com/git-for-windows/git/issues/1496 partially.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c   | 5 ++---
 config.mak.uname | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index a67872b..6ded1c8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2221,7 +2221,7 @@ void mingw_startup(void)
 		die_startup();
 
 	/* determine size of argv and environ conversion buffer */
-	maxlen = wcslen(_wpgmptr);
+	maxlen = wcslen(wargv[0]);
 	for (i = 1; i < argc; i++)
 		maxlen = max(maxlen, wcslen(wargv[i]));
 	for (i = 0; wenv[i]; i++)
@@ -2241,8 +2241,7 @@ void mingw_startup(void)
 	buffer = malloc_startup(maxlen);
 
 	/* convert command line arguments and environment to UTF-8 */
-	__argv[0] = wcstoutfdup_startup(buffer, _wpgmptr, maxlen);
-	for (i = 1; i < argc; i++)
+	for (i = 0; i < argc; i++)
 		__argv[i] = wcstoutfdup_startup(buffer, wargv[i], maxlen);
 	for (i = 0; wenv[i]; i++)
 		environ[i] = wcstoutfdup_startup(buffer, wenv[i], maxlen);
diff --git a/config.mak.uname b/config.mak.uname
index e1cfe5e..a6e734c 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -357,6 +357,7 @@ ifeq ($(uname_S),Windows)
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	NO_SVN_TESTS = YesPlease
 	RUNTIME_PREFIX = YesPlease
+	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
@@ -506,6 +507,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
 	RUNTIME_PREFIX = YesPlease
+	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
-- 
2.7.4

