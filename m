Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBA0C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 20:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C343261167
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 20:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348344AbhIHURA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 16:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbhIHUQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 16:16:56 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F34FC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 13:15:48 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e6-20020ac84e46000000b0029baad9aaa0so5453229qtw.11
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 13:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to;
        bh=JtYyfZNlcwi9zDUmHnDpuMFC26IDare8w5MNCylepxI=;
        b=jK6CTgWzMLx1aCJIFnKeUuMRJXrM/oHqYM/ngrH0HrHaGsL5fV8H2G41Qgosh25Jl6
         RPuDdoCbhnH0xgG9tNvMefI6js+oif2p2ymWcZnkJ9qiW/doO+IZ9ARJjMKkJWVzt41f
         SdkKuBN1qwU5CVe3GE+SsNok1Js+jFDBbA/QQce7wGBurfMtI47WG7GgVTEQ94hXwvH4
         TWRWzs0JN7N3dN63hhfg2olumz81QJXV1nmr9XKrQHn+DClcfkLgt2rcw20QWDbRBGlG
         7RpNwzwkBiwdLLpeS+vboRZbzZv16ijth07TAuB7iCbncHFYjZI5ydpKjaDQsdtQJeRL
         BTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=JtYyfZNlcwi9zDUmHnDpuMFC26IDare8w5MNCylepxI=;
        b=vmnrwjeEGm7SK4vjkGONdjObH+kG1BI6bQ8/kR/H7J6H5SyGy1/75o/kn7oQTxc5bh
         opYJR00wUpmpahRdvEnoyJ/0gqjjYEbiiFQHLLVFO25dx8fyIUwSBIbPdeiPp29D74cf
         M8C7um9s6kw0xLIHsop2/Pe75kE9rxwfH5h+YJRTU4gUdvAiwztM4NPq/MTHwi1/srdB
         g3fTEoKczHDXufX0OyBHgpf1kKuxXoDFLd18OCBGv3qemS51skiFhMzNVNWWUvtzkwob
         I/AG9wBY0NXrcUUBUQAmBdRWriOY4PeM9mva4iTWjT8EnQuHNUArjqh0nmnDrlvNCKjg
         uqlA==
X-Gm-Message-State: AOAM530Vc+R7Gn810r/LbDpFy3UadenFmhDrN0o1DQjdAT4gon+IGikq
        0GVqisPpojEz0P/COWZfofI9T9oIrxztmyREf8NJk7JWJAMBz6XMYssVMvZrqmxR/2iby93ADoI
        Pc5T5+o5I148LNlY2ksD/NLj7pVbDnX80ArDmiNWSfBWmSLdXPafYQNLrfz3FMA8=
X-Google-Smtp-Source: ABdhPJwPF0buKwRnAkCAOHEiLgmhaCBmSDwSIZeDbA5cHZOsqReqR7cSBN+s2w//Nz8KYnMFTLAh96OQvly4ag==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:f01f:16dd:49c0:66ce])
 (user=steadmon job=sendgmr) by 2002:ad4:40d1:: with SMTP id
 x17mr70983qvp.7.1631132147498; Wed, 08 Sep 2021 13:15:47 -0700 (PDT)
Date:   Wed,  8 Sep 2021 13:15:45 -0700
Message-Id: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [RFC PATCH] branch: add "inherit" option for branch.autoSetupMerge
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be helpful when creating a new branch to use the existing
tracking configuration from the branch point. However, there is
currently not a method to automatically do so.

Teach branch.autoSetupMerge a new "inherit" option. When this is set,
creating a new branch will cause the tracking configuration to default
to the configuration of the branch point, if set.

NEEDS WORK:
* this breaks `git checkout -b new-branch --recurse-submodules`
* add documentation
* add tests
* check corner cases, including whether this plays well with related
  cmd-line options (switch, checkout, branch)

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
I'll be looking into the --recurse-submodules breakage today, and then
I'll work on polishing the patch after that's fixed. But I thought it's
worth getting an idea of how the list feels about the feature in general
while I sort through the issues.

 branch.c | 36 +++++++++++++++++++++++++++++++++++-
 branch.h |  3 ++-
 config.c |  3 +++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 7a88a4861e..17d4cc5128 100644
--- a/branch.c
+++ b/branch.c
@@ -126,6 +126,38 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	return -1;
 }
 
+static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
+{
+	struct strbuf key = STRBUF_INIT;
+	char *remote;
+	const char *bare_ref;
+
+	bare_ref = orig_ref;
+	skip_prefix(orig_ref, "refs/heads/", &bare_ref);
+
+	strbuf_addf(&key, "branch.%s.remote", bare_ref);
+	if (git_config_get_string(key.buf, &remote)) {
+		warning("branch.autoSetupMerge=inherit, but could not find %s",
+			key.buf);
+		strbuf_release(&key);
+		return 1;
+	}
+	tracking->remote = remote;
+
+	strbuf_reset(&key);
+	strbuf_addf(&key, "branch.%s.merge", bare_ref);
+	if (git_config_get_string(key.buf, &tracking->src)) {
+		warning("branch.autoSetupMerge=inherit, but could not find %s",
+			key.buf);
+		strbuf_release(&key);
+		return 1;
+	}
+
+	tracking->matches = 1;
+	strbuf_release(&key);
+	return 0;
+}
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
@@ -139,7 +171,9 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
-	if (for_each_remote(find_tracked_branch, &tracking))
+	if (track == BRANCH_TRACK_INHERIT && inherit_tracking(&tracking, orig_ref))
+		return;
+	else if (for_each_remote(find_tracked_branch, &tracking))
 		return;
 
 	if (!tracking.matches)
diff --git a/branch.h b/branch.h
index df0be61506..6484bda8a2 100644
--- a/branch.h
+++ b/branch.h
@@ -10,7 +10,8 @@ enum branch_track {
 	BRANCH_TRACK_REMOTE,
 	BRANCH_TRACK_ALWAYS,
 	BRANCH_TRACK_EXPLICIT,
-	BRANCH_TRACK_OVERRIDE
+	BRANCH_TRACK_OVERRIDE,
+	BRANCH_TRACK_INHERIT
 };
 
 extern enum branch_track git_branch_track;
diff --git a/config.c b/config.c
index cb4a8058bf..4bd5a18faf 100644
--- a/config.c
+++ b/config.c
@@ -1580,6 +1580,9 @@ static int git_default_branch_config(const char *var, const char *value)
 		if (value && !strcasecmp(value, "always")) {
 			git_branch_track = BRANCH_TRACK_ALWAYS;
 			return 0;
+		} else if (value && !strcasecmp(value, "inherit")) {
+			git_branch_track = BRANCH_TRACK_INHERIT;
+			return 0;
 		}
 		git_branch_track = git_config_bool(var, value);
 		return 0;
-- 
2.33.0.153.gba50c8fa24-goog

