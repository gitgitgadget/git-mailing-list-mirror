Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236F8C433F5
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiCEAPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiCEAPt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:15:49 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F430244A01
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:15:01 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id lj1-20020a17090b344100b001bf2d53a2feso1416462pjb.5
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LEvv4KLPlmLJnGFaMlTpr54E3wbXX/ErQGbx/l49qxA=;
        b=ogfUG8tD0SBU3qReunK2OiOhNxJ3/6cTflJOdpPLGn9fXLfcz/cSGGEP3CpCQIfj/N
         hTgC7fUKXX5jr8hcWQkYRqmarsPhEu1BO4X7rlJFxs1cYvTsBWPaaioaxCzHlH2pY9pU
         wJ3103Vm0ROQTiwJkwE2Vx5kAWlxw5hfGep/meABI6W1THnJ0lknBumBvca/g6ezIFjq
         X5VERYPRCQ40xbpJzDg0Wx565PcH3sfERDwSh0p8zGpC/hKL+8CVMIkBzbi3u2FrHFZC
         UhiCz0z500s2SZ+Me5W4YI+2pBKCEdt6srp9xMSqFWX7G0aXIWD/ohFGxNB0ZE5eC4Nn
         Q6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LEvv4KLPlmLJnGFaMlTpr54E3wbXX/ErQGbx/l49qxA=;
        b=jHSJz6NJABQkXSf+HG1SZfjhlcTpiVgaXBmm7kM5dwr80sMZVgSgdTWKMWQhBL4G7Z
         4PyTlONvnH+9NEV/GxWWQjl75IzTaVIy4zzYhqfIt4A2eEGuCeZMThB0+06WooNSGzd+
         h/FLpz7olCa45vkv3/N4gX5ROx2VYXGZZvxS2EUr1M4IVPAzyGzymPkmdcXr7rFMnC0i
         I+2wJmnD2OneITEh2xevAaloKLldGnI/U1jaQXurw18Ed59W0Ew+l41PpNdw6oNNtjU2
         AMZmQuMEsTqkXTGuFkZV2OM4qOY9/1PWLDAD7OoWOuXzOt5Q2d15dZw3vgLTrxdym1LM
         +9Ow==
X-Gm-Message-State: AOAM532ba+74W1T+e8q9ORKFBN8IJTMwikHq5yu2JFZGL/vXF4OcymJO
        TV5iUteJboEs1qOk6PcjVpQOX6n/Y7UWt8JbP7QP1aJC+v8t1Lt4gK8sFWYuQuGnPwSFKGQAjVl
        53iHNBZ5RI20EY6ofXuEnA+Aa2hMihailRljx+4AyXPfYNm7kJNt1lWaWjUSpYk0=
X-Google-Smtp-Source: ABdhPJw2zH7OLUbwG4MRa6G3C+l37BnINvkCRqCJYZPRdPJjYVfSfHRAhnsL7+Z76JKUQfA8X7QUWt2NBrnzLw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4f43:b0:1bc:7e5c:e024 with SMTP
 id pj3-20020a17090b4f4300b001bc7e5ce024mr766747pjb.0.1646439299929; Fri, 04
 Mar 2022 16:14:59 -0800 (PST)
Date:   Fri,  4 Mar 2022 16:13:52 -0800
In-Reply-To: <20220305001401.20888-1-chooglen@google.com>
Message-Id: <20220305001401.20888-5-chooglen@google.com>
Mime-Version: 1.0
References: <20220303005727.69270-1-chooglen@google.com> <20220305001401.20888-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 04/13] submodule--helper run-update-procedure: remove --suboid
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

Teach run-update-procedure to determine the oid of the submodule's HEAD
instead of doing it in git-submodule.sh.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 9 ++++++---
 git-submodule.sh            | 8 +-------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1b67a3887c..77ca4270f4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2594,9 +2594,6 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "oid", &update_data.oid, N_("sha1"),
 			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
 			       parse_opt_object_id),
-		OPT_CALLBACK_F(0, "suboid", &update_data.suboid, N_("subsha1"),
-			       N_("SHA1 of submodule's HEAD"), PARSE_OPT_NONEG,
-			       parse_opt_object_id),
 		OPT_END()
 	};
 
@@ -3032,6 +3029,12 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 /* NEEDSWORK: this is a temporary name until we delete update_submodule() */
 static int update_submodule2(struct update_data *update_data)
 {
+	if (update_data->just_cloned)
+		oidcpy(&update_data->suboid, null_oid());
+	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
+		die(_("Unable to find current revision in submodule path '%s'"),
+			update_data->displaypath);
+
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
 		return do_run_update_procedure(update_data);
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 87772ac891..32a09302ab 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -406,14 +406,9 @@ cmd_update()
 
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 
-		if test $just_cloned -eq 1
+		if test $just_cloned -eq 0
 		then
-			subsha1=
-		else
 			just_cloned=
-			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
-				git rev-parse --verify HEAD) ||
-			die "fatal: $(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
 		fi
 
 		if test -n "$remote"
@@ -441,7 +436,6 @@ cmd_update()
 			  ${update:+--update "$update"} \
 			  ${prefix:+--recursive-prefix "$prefix"} \
 			  ${sha1:+--oid "$sha1"} \
-			  ${subsha1:+--suboid "$subsha1"} \
 			  "--" \
 			  "$sm_path")
 
-- 
2.33.GIT

