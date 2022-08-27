Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882A4C0502E
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiH0MrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbiH0Mo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DB93A5
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j26so2103008wms.0
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=/kwZIue7j8EWKzTdscC6miqTsBYC8i81DbI86N2OYWE=;
        b=JXsinyWPXwGGLnqNfqWGR97FlGwMLv2MOcCMxOuS4OG4k8VswApb07tIygRDmw1+uM
         oUThnWBQqZlN3r28nvuZAit5Zxj8l/Ue/R7Jjr4RgcViG80iGE4v4wToyWX+SPyW7l4H
         Ewdz3aD6UNFRRr/hwoZ59pTp6ZGROi6d3z7DgkSk7vkrH2mny0t2nn9f3gzgZvjxe7v9
         qHkLoHyutJCJYyD7jLetizn5a2X84a467hGj8JueIbRcGta3DnQlzh+4Byar6uV6q676
         1IOf8oS/w2jGBuu6hS4+7REs/C/q3GzNIpPDMeipyKzSCGTP/xgPzTi2kNKcu94BytNi
         5PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=/kwZIue7j8EWKzTdscC6miqTsBYC8i81DbI86N2OYWE=;
        b=7UKIvOf42Zqv0AKv0HgqNUlNT7EJSbm/Iu/eJUL6fq/2mhpidf9cozqwGW4XOlJKt4
         hFqEuCmFNpb4SOMJ6nyDZWZQya6c+pE8Y7AOFpRN5fidVqoHiP0rnkgRv+qjDLlfrNz3
         1vDEHVCcbl8CvEYQ56M41wZ98L6UTZlKjeHmfU6Fm6/Y/JWPmGFJhRZ2RgmZhtZrYKYK
         ov+iXkg6ZnxCwx8KvxaRhClGBxLDaBtXoSBDYNCmVAL3cGT5OmAlgGyQwUQPcTlFdi5I
         uuzv3pz6Zsq/71SDE4BFnifchDnDZW/3JRnD8b6KZVvnm8HZ1b4ZfSH7rMGaTCk18dGv
         FBng==
X-Gm-Message-State: ACgBeo1dPkEeeGsSgfU+KsPp/PzwFmPDXZL6lvpNS0FM66NCAW2fCaSt
        IsH2kKOH5GY6vqS7Ubgy8Z+dfncUfA0=
X-Google-Smtp-Source: AA6agR5boSidE+G/JyO0n5+MCjnO8nEdkL5j8cNGKBe8mWNcTq/3LVNreGwSlL8f2tMJDG91ITCdCg==
X-Received: by 2002:a05:600c:40d5:b0:3a5:3d9f:6e7f with SMTP id m21-20020a05600c40d500b003a53d9f6e7fmr2244635wmh.21.1661604282667;
        Sat, 27 Aug 2022 05:44:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k35-20020a05600c1ca300b003a5f3de6fddsm2978374wms.25.2022.08.27.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:42 -0700 (PDT)
Message-Id: <189d2b3ba46ce67ece7f8852d3ced4682ce8a645.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:20 +0000
Subject: [PATCH v5 12/16] bisect--helper: make `state` optional
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for making `git bisect` a real built-in, let's prepare
the `bisect--helper` built-in to handle `git bisect--helper good` and
`git bisect--helper bad`, i.e. do not require the `state` subcommand to
be passed explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 22 +++++++++++++++++++++-
 git-bisect.sh            |  2 +-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3f333cfae76..9f78bd45ca5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1447,6 +1447,7 @@ static int cmd_bisect_run(int argc, const char **argv, const char *prefix)
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
+	struct strvec args = STRVEC_INIT;
 	parse_opt_subcommand_fn *fn = NULL;
 	int res = 0;
 	struct option options[] = {
@@ -1464,10 +1465,29 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     bisect_usage, 0);
+			     bisect_usage, PARSE_OPT_SUBCOMMAND_OPTIONAL);
+
+	if (!fn) {
+		if (!argc)
+			usage_msg_opt(_("need a command"), bisect_usage,
+				      options);
+
+		set_terms("bad", "good");
+		get_terms();
+		if (check_and_set_terms(argv[0]))
+			usage_msg_optf(_("unknown command: '%s'"), bisect_usage,
+				       options, argv[0]);
+
+		strvec_push(&args, "state");
+		strvec_pushv(&args, argv);
+		argc = args.nr;
+		argv = args.v;
+		fn = cmd_bisect_state;
+	}
 
 	res = fn(argc, argv, prefix);
 	free_terms();
+	strvec_clear(&args);
 
 	return is_bisect_success(res) ? 0 : -res;
 }
diff --git a/git-bisect.sh b/git-bisect.sh
index e19847eba0d..f4df8709d84 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -60,7 +60,7 @@ case "$#" in
 	start)
 		git bisect--helper start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		git bisect--helper state "$cmd" "$@" ;;
+		git bisect--helper "$cmd" "$@" ;;
 	skip)
 		git bisect--helper skip "$@" || exit;;
 	next)
-- 
gitgitgadget

