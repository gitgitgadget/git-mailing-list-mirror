Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEE7C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiCCA6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiCCA6e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:58:34 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83A5151D09
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:57:49 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id a12-20020a65640c000000b003756296df5cso1878438pgv.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6b3Koiu50iGgu4+CvsJvU3gtyLeMDqKt6mcoMXU061M=;
        b=K16rjuSKGjZqYQxWjBvr0jkvjRbdpWZkMIHyx/5YB6qi1MCQF5QZF+byxQYkcksB7S
         oq/j2k3kJ31UNzSRWISzZYU+6g45b5FxO11d9S46n2IHbaXXEE0ik4Agi258dCzrxVdR
         YJjtnSWiXF/3DNlf3agozqECS1NCmFYI/stDeNgC+LaOH/krc3u3eLFoxetvmEsSmBru
         kYVstGzCctQNHlh3iarN2BhMtVhRaNzfC3Dx6NeEW+5m6S/ofyJfYd/0+SL5fLF4b9xw
         Ka1Gv3ECnYqTV31ZYShS7nSsucdWK+GoIzPpHnhBq5Z1PzRbSQOX7Kr2yBu239YydFkI
         Zzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6b3Koiu50iGgu4+CvsJvU3gtyLeMDqKt6mcoMXU061M=;
        b=T6ArXdlW7wwXumJIzcctYcq9iPRtsWLNyhROr3ZH2c7Xmo6T07zjpvU790cm7Sc8RN
         UeVxlKN2cc6OCm340Dl7Zz4Z9LJtAmVLR+MTSs+KLDPvcjGZv4s5LYZMDZGBduR64MGl
         hC46CM+KmFx0Z+9Ag5OvvylJ2QePfZWhMqnE0x3jYa8/fQHgFjpQe8E9CIEdi15D1uxm
         UH/UVoX7uDL9Q1/wtp8A3WsmfYr4JO65s+7RJJS1x+Xv/i281hSs0A6+PTQQfAuxbk/o
         HpiLhUov5nYPPuIUPUJCO/y3r9TsXmSwf0xm7Chn5gPapA9BfAqKd0I9HQ1L2cneSzJe
         F3rw==
X-Gm-Message-State: AOAM531xBXqWKlMOMyxrP0lJwNbUcn09iPmDLnHN/41/WZ31ccnNvkIH
        cKFvMuNY9ys5TU9YSKwE4ZOIH6Tdbf38NOI1T4cTeq/74EM/AZmQLuIJkZ9VdY8UZwByXWDkLzY
        yjdetkYYHy96nSbuW+z+D5gMMAT+1WGd+KhNd8HBYOXDIegPCr3wmS4icia+OVy0=
X-Google-Smtp-Source: ABdhPJwk0mcI+CjSeR6iB6Qjz8C8nFVe/UZAci2eh++aaYxeTI8Br/RbOt/CHsq+LyN7Y5ZxKQaGwgSeJD/0Ww==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:f87:b0:1bc:b82b:69fc with SMTP id
 ft7-20020a17090b0f8700b001bcb82b69fcmr2581556pjb.236.1646269069143; Wed, 02
 Mar 2022 16:57:49 -0800 (PST)
Date:   Wed,  2 Mar 2022 16:57:18 -0800
In-Reply-To: <20220303005727.69270-1-chooglen@google.com>
Message-Id: <20220303005727.69270-5-chooglen@google.com>
Mime-Version: 1.0
References: <20220301044132.39474-1-chooglen@google.com> <20220303005727.69270-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 04/13] submodule--helper run-update-procedure: remove --suboid
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
instead of doing it in git-subomdule.sh.

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

