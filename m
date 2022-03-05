Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DB9C433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiCEAQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiCEAQO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:16:14 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39C427D137
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:15:17 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 1-20020a630c41000000b00378d9d6bd91so5299269pgm.17
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5/J/TQNvnprNfyNbTTu8oTUqdxY0t77pvG2ZrTX88sY=;
        b=F4JAl+Ipreodqxw+nDXd53bBQklbd5hZYaFKouK7s9R4hBmG7g2tQPMWVr5w9/kDcl
         OiRDZUe2EPpw/7cIg4CcFtaE7gjAg9pmaM71Xi2dORBprmmqgWYVG4jedblWDS9jpVZq
         pzbgIFK3DnSm5vcXmFbJQKaXkbuwgKUHIHFDJthYtD3QTBGNFY1mB25Ym0IgKJhLb0Wd
         TZnWuAf9n2GiYtRvoXXzxw37UlFTTKA+Kf1qHoA+ZmlCLAjgttE7pl865MnWDXW8DKLG
         xf3peD0dy5zpvOUwYKCbUfvTcPlf3YDka23G6bV7isoz3JxZpCksnDLdvuY2jTE72Axc
         C4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5/J/TQNvnprNfyNbTTu8oTUqdxY0t77pvG2ZrTX88sY=;
        b=grLmZpZifPPr7rXNQKndujw6b2bcCOiF4hf9UzZRFgcYk8Iig2vzmIVlB8PYDB3EPz
         bV/Y4bTjJXajAlsQvxf7MjBcYgj/KKUr/UM2LvAGZOI76fNhUQJou4pT112oCk7B1qO7
         oPO62mU+LniptIwBexPmqFcV0YNNNY8Xm9sokkgHEi/KljRsMGE2tQsAPa9jDPUmNJ+b
         uh45muOOldBplt9vjY0NGbXHx4IffGQ5127pnpB4xrwcNkYJ+MFclxxkzmZsecV8imII
         6ni8MZ+YwtTrY8x6pFnoTV7+yeyrvqeT/XksU5Z2ymTyoy7m0CKqMPt0sg4s/8sNqZsB
         dBmQ==
X-Gm-Message-State: AOAM530htWZTA392b/2hcJyDxEJSdZv0Nv2IZstLXy5hKYenAPjN3snl
        sXc6yiMNRlrGZcLuM6jn3Su3uFpwXj5lqbNTfA5Nk7L56bcOlS2v2HpIkC1OIVwNRSMe/ESV7UP
        HewoY13QBnmP6IP08BfGBg3dMIgkPCeUyHtwYiVmFvz08lsGEtJGQnJeUjdCw+7c=
X-Google-Smtp-Source: ABdhPJzr013PoHMisUr4VavLCDzu8ItqM5+ApDxEsliPhDHtqc6m/NN1I+p3kKDtKeVWo7koOZiKCf90VmCyXQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:90d5:0:b0:4e1:307c:d94a with SMTP id
 k21-20020aa790d5000000b004e1307cd94amr1097622pfk.38.1646439317046; Fri, 04
 Mar 2022 16:15:17 -0800 (PST)
Date:   Fri,  4 Mar 2022 16:14:01 -0800
In-Reply-To: <20220305001401.20888-1-chooglen@google.com>
Message-Id: <20220305001401.20888-14-chooglen@google.com>
Mime-Version: 1.0
References: <20220303005727.69270-1-chooglen@google.com> <20220305001401.20888-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 13/13] submodule--helper update-clone: check for --filter
 and --init
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git submodule update --filter" also requires the "--init" option. Teach
update-clone to do this usage check in C and remove the check from
git-submodule.sh.

In addition, change update-clone's usage string so that it teaches users
about "git submodule update" instead of "git submodule--helper
update-clone" (the string is copied from git-submodule.sh). This should
be more helpful to users since they don't invoke update-clone directly.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 20 +++++++++++++++++++-
 git-submodule.sh            |  5 -----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 296ab80bf2..bef9ab22d4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2545,7 +2545,12 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
+		N_("git submodule [--quiet] update"
+		" [--init [--filter=<filter-spec>]] [--remote]"
+		" [-N|--no-fetch] [-f|--force]"
+		" [--checkout|--merge|--rebase]"
+		" [--[no-]recommend-shallow] [--reference <repository>]"
+		" [--recursive] [--[no-]single-branch] [--] [<path>...]"),
 		NULL
 	};
 	suc.prefix = prefix;
@@ -2556,6 +2561,19 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
+
+	if (filter_options.choice && !suc.init) {
+		/*
+		 * NEEDSWORK: Don't use usage_with_options() because the
+		 * usage string is for "git submodule update", but the
+		 * options are for "git submodule--helper update-clone".
+		 *
+		 * This will no longer be an issue when "update-clone"
+		 * is replaced by "git submodule--helper update".
+		 */
+		usage(git_submodule_helper_usage[0]);
+	}
+
 	suc.filter_options = &filter_options;
 
 	if (update)
diff --git a/git-submodule.sh b/git-submodule.sh
index 51be7c7f7e..aa8bdfca9d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -356,11 +356,6 @@ cmd_update()
 		shift
 	done
 
-	if test -n "$filter" && test "$init" != "1"
-	then
-		usage
-	fi
-
 	{
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update-clone \
 		${GIT_QUIET:+--quiet} \
-- 
2.33.GIT

