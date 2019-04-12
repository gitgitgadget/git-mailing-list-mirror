Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D54D20248
	for <e@80x24.org>; Fri, 12 Apr 2019 12:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfDLMAf (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 08:00:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46425 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfDLMAe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 08:00:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id d1so8069888edd.13
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 05:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pDAzqZgidp9Ac8078IjNUa202C1/co4UXZSblVoI2mI=;
        b=VS3MlpsY2pYhibKUAlucqBqhf8u2SknVP7BdzXDXghg436ryvgeGB+zVelGlgiBRJ1
         oNIADhHj1gdVBcZaAqMRI0sotHbkrBZu6H/bHOApdtLLNu85gmXw/qYW/VEHdZ4MJKn8
         u6o2WsTCVoLN4x+a3LpS95RDOCuSN3KE6B5QLvh5MxcQyvRG87TcfVdFAx3bhycEKdmg
         YSBsFu5TYUwsWbgyziincMRGlOtkZf9z47Ltuvx9KoRoH2DKwRSjOraLsxxYhTZbBTtX
         dNgw7jB/fRTDs+SfXvn4SGXTZJO9ndvJvGCqZVhAcjFkSo6F6AchgS3hU9/8cq5U0jWa
         hFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pDAzqZgidp9Ac8078IjNUa202C1/co4UXZSblVoI2mI=;
        b=XVoBjXDb9/d9lip0+hTJAGvlbMaqEWNhGm9C4lnMOBC1XJvVHu1FICu2uZjklNmNL/
         +kWxag1Y4p6P8rcgwXWMj9lEFG+1AHrN0NmDyvlq25boc59a/FzE6eZBATv6yHX+5FPU
         NJPsbndX8Wn/HBte7dx6qsybuBVubvu6m+145NKB2Kq16Ym7b7UFbA2qZaAbU7o+7Cq4
         9WiFMRZ9B8eLMlMZz9DmQMaCP32KSRO99AVynmILJUI9m8N0Mm1dKUNpS5hZiqdhpO8T
         NQp611dz+kyKZ+tH+jQibibXev4UD8AW0YjZi06Uz20/foc5TqYJqy69AwQpOkQaMa+7
         WMJA==
X-Gm-Message-State: APjAAAWowxpy4+iE5qauK105wY8+NCEkwtS+gIuazEGsE5bc/2tnWXx5
        t/600pN5QsX5WN+F31dDAzdidIMl
X-Google-Smtp-Source: APXvYqyK4jOOyoOy1ValeOXCdFLasSz5mNKX6beMix7uocN+K0uskRPVITR41yLo7ztYLm2uQUs9kA==
X-Received: by 2002:aa7:d39a:: with SMTP id x26mr13197810edq.48.1555070433296;
        Fri, 12 Apr 2019 05:00:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2sm10944eds.15.2019.04.12.05.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 05:00:32 -0700 (PDT)
Date:   Fri, 12 Apr 2019 05:00:32 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 12:00:25 GMT
Message-Id: <7dc5293e9e0f8997674b1273393f22954e72c4cd.1555070430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.168.git.gitgitgadget@gmail.com>
References: <pull.168.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/7] help -a: do not list commands that are excluded from the
 build
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When built with NO_CURL or with NO_UNIX_SOCKETS, some commands are
skipped from the build. It does not make sense to list them in the
output of `git help -a`, so let's just not.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile            | 14 ++++++++++++--
 generate-cmdlist.sh | 10 +++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 26f8ed2228..8f3c477ab3 100644
--- a/Makefile
+++ b/Makefile
@@ -611,6 +611,7 @@ FUZZ_PROGRAMS =
 LIB_OBJS =
 PROGRAM_OBJS =
 PROGRAMS =
+EXCLUDED_PROGRAMS =
 SCRIPT_PERL =
 SCRIPT_PYTHON =
 SCRIPT_SH =
@@ -1323,6 +1324,7 @@ ifdef NO_CURL
 	REMOTE_CURL_PRIMARY =
 	REMOTE_CURL_ALIASES =
 	REMOTE_CURL_NAMES =
+	EXCLUDED_PROGRAMS += git-http-fetch git-http-push
 else
 	ifdef CURLDIR
 		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
@@ -1347,7 +1349,11 @@ endif
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
 			PROGRAM_OBJS += http-push.o
+		else
+			EXCLUDED_PROGRAMS += git-http-push
 		endif
+	else
+		EXCLUDED_PROGRAMS += git-http-push
 	endif
 	curl_check := $(shell (echo 072200; $(CURL_CONFIG) --vernum | sed -e '/^70[BC]/s/^/0/') 2>/dev/null | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "072200"
@@ -1593,7 +1599,9 @@ ifdef NO_INET_PTON
 	LIB_OBJS += compat/inet_pton.o
 	BASIC_CFLAGS += -DNO_INET_PTON
 endif
-ifndef NO_UNIX_SOCKETS
+ifdef NO_UNIX_SOCKETS
+	EXCLUDED_PROGRAMS += git-credential-cache git-credential-cache--daemon
+else
 	LIB_OBJS += unix-socket.o
 	PROGRAM_OBJS += credential-cache.o
 	PROGRAM_OBJS += credential-cache--daemon.o
@@ -2112,7 +2120,9 @@ $(BUILT_INS): git$X
 command-list.h: generate-cmdlist.sh command-list.txt
 
 command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt Documentation/config/*.txt
-	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
+		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
+		command-list.txt >$@+ && mv $@+ $@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 709d67405b..7867b99d19 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -6,7 +6,7 @@ die () {
 }
 
 command_list () {
-	grep -v '^#' "$1"
+	eval grep -ve '^#' $exclude_programs "$1"
 }
 
 get_categories () {
@@ -93,6 +93,14 @@ EOF
 EOF
 }
 
+exclude_programs=
+while test "a$1" = "a--exclude-program"
+do
+	shift
+	exclude_programs="$exclude_programs -e \"^$1 \""
+	shift
+done
+
 echo "/* Automatically generated by generate-cmdlist.sh */
 struct cmdname_help {
 	const char *name;
-- 
gitgitgadget

