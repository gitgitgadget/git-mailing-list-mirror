Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 562C91F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753502AbeAaLGo (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:06:44 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38557 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeAaLGm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:06:42 -0500
Received: by mail-pf0-f195.google.com with SMTP id k19so12231849pfj.5
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TF8rky05rv7AWE2RfYiNTlGEzK2MswOwglMEXOdM0ow=;
        b=Xei6KNp0wFyjATcxOJDAo4rqUg7uzxIwf2NHwplOPbki0k5EWhcSHL46gSNs97d1kb
         DbNVnlx/oiLPYIOkINIWO6/q3Q0+z8ai5pof+L/BZGr5Ai972aR3iPFjuHJFx/fDY1i2
         VQeM/VF1TBZTY30ypo+kCy+NCA4p9+9hUU41uPnpv84UepJ27cj0xIZ/NLsu5DLIHZhL
         ELgwrf5UteRCU9Vo3TMVib/HDHrSUUqCeeVii1/cpi7Z7h/gu+FEyX4RVXN1f9/FCypY
         hIjmR+XXjAxm4qlJVw1t/9JmYyTSrm0ocZc665Ttu8gMD3Z+rrorlMr0TFnA1MVlKjvp
         rWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TF8rky05rv7AWE2RfYiNTlGEzK2MswOwglMEXOdM0ow=;
        b=s1bQh0fZTUE+btD6vPwXw3DsOyH/Eu8fYo+K11cPFCdEIuiZI58+3uV25gzIQjQBNN
         D6GlhUCoIIz60XUVAsDz4hV3QhisWkmQ2kOZ5+ewbF9x1vlYNj+YX0v4ah5LZJ1SoCHz
         Ljnw+bD0oHsYFn0OvHP0NA2nvaYWymph0H7ejyydeaX58ktJTzu+CoIaBNO3L5Fmuv1k
         HecmD5nNyN3qAuB2kedTsNGMjrM2T5T+NWEBqtUneIXVPwr1aF/LpPird6JLtmSYBbhr
         sc5yt8Abt/MB7LvAvlLTrvnGVFyfXnFCKQvtveallzepR0tpLyNUumGWdSJV9CkGyjGH
         tI/w==
X-Gm-Message-State: AKwxytfi0/xR/j28p3CfeFwWGOXti2I9Ac5w4PHCBBWED/VYeoA7aeEC
        Eg1KO6r4AM4jEcAUMTsucm1hFQ==
X-Google-Smtp-Source: AH8x2244O+emNjvQDZKKcfMiVtV88ZTecw/j2SZDJL+OQp74vUhl0rxewegqHNnAEeumWqv/wWl+Vg==
X-Received: by 10.101.101.68 with SMTP id a4mr25998691pgw.368.1517396802042;
        Wed, 31 Jan 2018 03:06:42 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id c8sm38070153pfm.130.2018.01.31.03.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:06:41 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:06:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 09/41] completion: use __gitcomp_builtin in _git_checkout
Date:   Wed, 31 Jan 2018 18:05:15 +0700
Message-Id: <20180131110547.20577-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are:

--ignore-other-worktrees
--progress

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c                     |  7 +++++--
 contrib/completion/git-completion.bash |  6 +-----
 t/t9902-completion.sh                  | 12 +++++++-----
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2a96358eb7..a6218024a6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1118,9 +1118,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			    2),
 		OPT_SET_INT('3', "theirs", &opts.writeout_stage, N_("checkout their version for unmerged files"),
 			    3),
-		OPT__FORCE(&opts.force, N_("force checkout (throw away local modifications)"), 0),
+		OPT__FORCE(&opts.force, N_("force checkout (throw away local modifications)"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('m', "merge", &opts.merge, N_("perform a 3-way merge with the new branch")),
-		OPT_BOOL(0, "overwrite-ignore", &opts.overwrite_ignore, N_("update ignored files (default)")),
+		OPT_BOOL_F(0, "overwrite-ignore", &opts.overwrite_ignore,
+			   N_("update ignored files (default)"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
 			   N_("conflict style (merge or diff3)")),
 		OPT_BOOL('p', "patch", &opts.patch_mode, N_("select hunks interactively")),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4a2858f09c..61880275ed 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1252,11 +1252,7 @@ _git_checkout ()
 		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
 		;;
 	--*)
-		__gitcomp "
-			--quiet --ours --theirs --track --no-track --merge
-			--conflict= --orphan --patch --detach --ignore-skip-worktree-bits
-			--recurse-submodules --no-recurse-submodules
-			"
+		__gitcomp_builtin checkout "--no-track --no-recurse-submodules"
 		;;
 	*)
 		# check if --track, --no-track, or --no-guess was specified
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index fc614dcbfa..e6485feb0a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1237,17 +1237,19 @@ test_expect_success 'double dash "git" itself' '
 test_expect_success 'double dash "git checkout"' '
 	test_completion "git checkout --" <<-\EOF
 	--quiet Z
+	--detach Z
+	--track Z
+	--orphan=Z
 	--ours Z
 	--theirs Z
-	--track Z
-	--no-track Z
 	--merge Z
-	--conflict=
-	--orphan Z
+	--conflict=Z
 	--patch Z
-	--detach Z
 	--ignore-skip-worktree-bits Z
+	--ignore-other-worktrees Z
 	--recurse-submodules Z
+	--progress Z
+	--no-track Z
 	--no-recurse-submodules Z
 	EOF
 '
-- 
2.16.1.205.g271f633410

