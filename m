Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364C8C433DF
	for <git@archiver.kernel.org>; Sat, 23 May 2020 16:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D8DE20787
	for <git@archiver.kernel.org>; Sat, 23 May 2020 16:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7RhmC+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgEWQjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 12:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgEWQjj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 May 2020 12:39:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A71C061A0E
        for <git@vger.kernel.org>; Sat, 23 May 2020 09:39:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q9so6384130pjm.2
        for <git@vger.kernel.org>; Sat, 23 May 2020 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38U6hd2MjDNNOFlG2wFix5s0HifUS6rssR2Zq0kk+QA=;
        b=N7RhmC+YBHhuI2+HOH5hzoXit9Zm/Roa9krePiuj5tYIevYX3tarWtL0kViknIAU4O
         JAFjOC1tPb+dTbaaymS/BlF1KBYBG6BcXRXZAQMrAgYtPBouI3X4+HJY4s/7GLkT5FL1
         L8uZs7dZ3ioFQvuTPl3mfyF6GEfjLaIXGS9Fz2Vb3IjHbIYEPCqh72nrzh8JXY4n8z7s
         XY+KdYiy2P9htzRLLpOo873i9gW6UfV/CM56j/MZ4so+l8yymTGQQN/J72/yhYw3xLfV
         BZP2H3CkJ4YLxGra1JdM7GniJtq+GmDhqlraIiXxAM/ndkrDjXpKs8GDuvx4YK1jTd1J
         Pe9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38U6hd2MjDNNOFlG2wFix5s0HifUS6rssR2Zq0kk+QA=;
        b=k9pBEDOAiMhOsiDNkRIJdIOA6QOMoZTMQQOP3HDzwbbVNTUGdNKy851TpVsb+E3OAn
         Xph2ds6EfN69n9hO5uGI6oqhWlVZLxcj01ZFeQuhu9OI2yJG874SI0tt6zi1Sa6tOm3t
         m8xrcObndiqok3xBxSzRMSoczmfug1+t4WiJV7NxX3H15ixE4rN86w0x9Xp2Vg3jYt0s
         aKvGAK/YQASnVbRZbS7dNXT8Js213uchk9ZUyxUIjEUu9werwQQ8ssxJW1iuD7OB3Gls
         5uUSt4pBZSsFVoHj1Zx1OKNfuIQ60syGrA9Y7UafSeZqmFVCw+z2UIcJrqL2sKGnEZi3
         rQ9w==
X-Gm-Message-State: AOAM5302r3ouBXDN2hVK/lmNHJKqXcwrJLg2FCOhl1S812Hi54vWoaNA
        9ENEXIGwagEsAtVfX7kXB4U=
X-Google-Smtp-Source: ABdhPJxHPZgCTz604N1wH861Q4kc/U8N/jjNIzpZM4ZuuHYqzbacXMAqbwnzOWz+BMci6NscxsWbwA==
X-Received: by 2002:a17:90a:23a4:: with SMTP id g33mr10983770pje.79.1590251978678;
        Sat, 23 May 2020 09:39:38 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id m12sm9382511pjs.41.2020.05.23.09.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 09:39:37 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     shouryashukla.oo@gmail.com
Cc:     christian.couder@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4] submodule: port subcommand 'set-branch' from shell to C
Date:   Sat, 23 May 2020 22:09:29 +0530
Message-Id: <20200523163929.7040-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
References: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert submodule subcommand 'set-branch' to a builtin and call it via
'git-submodule.sh'.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Denton Liu <liu.denton@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
Thank you for the review Junio and Johannes. I have made the requested
changes.

 builtin/submodule--helper.c | 45 +++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 32 +++-----------------------
 2 files changed, 48 insertions(+), 29 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f50745a03f..7e844e8971 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2284,6 +2284,50 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int module_set_branch(int argc, const char **argv, const char *prefix)
+{
+	/*
+	 * We accept the `quiet` option for uniformity across subcommands,
+	 * though there is nothing to make less verbose in this subcommand.
+	 */
+	int quiet = 0, opt_default = 0, ret;
+	const char *opt_branch = NULL;
+	const char *path;
+	char *config_name;
+
+	struct option options[] = {
+		OPT__QUIET(&quiet,
+			N_("suppress output for setting default tracking branch")),
+		OPT_BOOL(0, "default", &opt_default,
+			N_("set the default tracking branch to master")),
+		OPT_STRING(0, "branch", &opt_branch, N_("branch"),
+			N_("set the default tracking branch")),
+		OPT_END()
+	};
+	const char *const usage[] = {
+		N_("git submodule--helper set-branch [--quiet] (-d|--default) <path>"),
+		N_("git submodule--helper set-branch [--quiet] (-b|--branch) <branch> <path>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+
+	if (!opt_branch && !opt_default)
+		die(_("--branch or --default required"));
+
+	if (opt_branch && opt_default)
+		die(_("--branch and --default are mutually exclusive"));
+
+	if (argc != 1 || !(path = argv[0]))
+		usage_with_options(usage, options);
+
+	config_name = xstrfmt("submodule.%s.branch", path);
+	ret = config_set_in_gitmodules_file_gently(config_name, opt_branch);
+
+	free(config_name);
+	return ret;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -2315,6 +2359,7 @@ static struct cmd_struct commands[] = {
 	{"check-name", check_name, 0},
 	{"config", module_config, 0},
 	{"set-url", module_set_url, 0},
+	{"set-branch", module_set_branch, 0},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 39ebdf25b5..8c56191f77 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -719,7 +719,7 @@ cmd_update()
 # $@ = requested path
 #
 cmd_set_branch() {
-	unset_branch=false
+	default=
 	branch=
 
 	while test $# -ne 0
@@ -729,7 +729,7 @@ cmd_set_branch() {
 			# we don't do anything with this but we need to accept it
 			;;
 		-d|--default)
-			unset_branch=true
+			default=1
 			;;
 		-b|--branch)
 			case "$2" in '') usage ;; esac
@@ -750,33 +750,7 @@ cmd_set_branch() {
 		shift
 	done
 
-	if test $# -ne 1
-	then
-		usage
-	fi
-
-	# we can't use `git submodule--helper name` here because internally, it
-	# hashes the path so a trailing slash could lead to an unintentional no match
-	name="$(git submodule--helper list "$1" | cut -f2)"
-	if test -z "$name"
-	then
-		exit 1
-	fi
-
-	test -n "$branch"; has_branch=$?
-	test "$unset_branch" = true; has_unset_branch=$?
-
-	if test $((!$has_branch != !$has_unset_branch)) -eq 0
-	then
-		usage
-	fi
-
-	if test $has_branch -eq 0
-	then
-		git submodule--helper config submodule."$name".branch "$branch"
-	else
-		git submodule--helper config --unset submodule."$name".branch
-	fi
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch $branch} ${default:+--default} -- "$@"
 }
 
 #
-- 
2.26.2

