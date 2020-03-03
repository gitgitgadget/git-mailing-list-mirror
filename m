Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73280C3F2D7
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 04:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A4F2465D
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 04:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ImTz7TgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgCCEFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:05:13 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54835 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgCCEFN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 23:05:13 -0500
Received: by mail-pl1-f202.google.com with SMTP id s13so1073024plr.21
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 20:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=eyqt565TJD1fzhKAvaHffcGa98xhIkR8cuRtr2Nwydw=;
        b=ImTz7TgYXB4Sgt/t+gKLT0jKrSWT6nzj5IBqCtyAQ7iQ2F9N2xWuUWzT5RiUzTcE1U
         kleB16MTcNvk3kbiiS08QN8rBuK1O9h3Qm8fwad3Q32bJfXIqdsEczwQag/l2QN8mFRf
         TDtUfVJwTVkOMqRESUqt0AtUzTAVZy33JnntnX/+hE5rJhY8vYCWss498Ujimeqw+iqu
         CA5RP9Phu96FnyrvkpByReLGg5SY0GLFIMCrfiXww8+RbYmSmSV5osF/a5x3HhJaJc8C
         31OWf5+Apjl1Q8jO5bRQltq+hEnjyccEKDj5k1Iw4Z7K+ACbZL+EHh7Dfwg91UJysM/F
         jy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=eyqt565TJD1fzhKAvaHffcGa98xhIkR8cuRtr2Nwydw=;
        b=bIWGaoiFQn/fj0f31d6yU+2jBHqeH/8kFO0Zb7Vxeb/yGtyQExqXAEX1te3aq6fDIU
         z8pTI1GuUlWF8g29VRtWcvCswIUsaVEAHtykbxQe19PAFAUEhgkCHBA1aCsVWUFQZVB8
         POdDvZzAmnyfFj52L5FUJA31qO4uvvV2D1SfJFhYk92x4vgTbUko6UOjOvCaM+6xH7sP
         9kK1UKUX9qesdoQiwIXbUGm0nK/iO2Mpuig9tGLxhBSHw8cwVXnZtCwJSg6Y7NljZVFM
         zWIESLxh/cQw9J1Pa5Ziv0tA0Jipig0FxCuCCksurLr4gbG02Rc6VV89h68DRG3OaM3E
         xHgw==
X-Gm-Message-State: ANhLgQ36XHBTJjo+LKb8aSLSRgyn+qo0SOxcTHB9Z69BPLAuNuE9Bvjf
        dx01reuAK8iSEgoqNtZQ27nG6DniVxHtgznoUOpPSq2dn1r7s7dBpvJ+HiHSQpcGJ5q/Lc3FQoY
        Meg/RgrPKQIYLeeHVt13RbxVfAbcllS+zBHSCUjFC2+2+p/K1trFl18AUjbzxUHp2Iu+W+MuCBQ
        ==
X-Google-Smtp-Source: ADFU+vufqesmEmReKKNrhYGWZ52o4GkFM16YNwjO/K7USydvinaDci2ADGFmkutu3F1id7+Mab5dXtLDJOWzxOBj6Ak=
X-Received: by 2002:a63:ed01:: with SMTP id d1mr2037443pgi.95.1583208310218;
 Mon, 02 Mar 2020 20:05:10 -0800 (PST)
Date:   Mon,  2 Mar 2020 20:05:06 -0800
In-Reply-To: <20200228195805.GA190372@google.com>
Message-Id: <20200303040506.241376-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] prefix_path: show gitdir if worktree unavailable
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If there is no worktree at present, we can still hint the user about
Git's current directory by showing them the absolute path to the Git
directory. Even though the Git directory doesn't make it as easy to
locate the worktree in question, it can still help a user figure out
what's going on while developing a script.

This fixes a segmentation fault introduced in e0020b2f829.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
This patch is built on top of es/outside-repo-errmsg-hints. I think it
doesn't need to be, since that change is in master, though.

Sounds like there's a segfault in the wild:
https://lore.kernel.org/git/20200228195805.GA190372@google.com

I figured since the error doesn't specify "this is the worktree" or
"this is the gitdir" to the user, it didn't need more prettying when
falling back to gitdir in this patch.

It seems to me that if we are checking whether something is inside or
outside of the repository, we definitely will get a good result from
get_git_dir() - if there's no Git dir, then there's no repository to be
in or out of.

CI run here: https://github.com/gitgitgadget/git/pull/572/checks

 - Emily

 pathspec.c | 8 ++++++--
 setup.c    | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 166d255642..8243e06eab 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -438,9 +438,13 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	} else {
 		match = prefix_path_gently(prefix, prefixlen,
 					   &prefixlen, copyfrom);
-		if (!match)
+		if (!match) {
+			const char *hint_path = get_git_work_tree();
+			if (!hint_path)
+				hint_path = get_git_dir();
 			die(_("%s: '%s' is outside repository at '%s'"), elt,
-			    copyfrom, absolute_path(get_git_work_tree()));
+			    copyfrom, absolute_path(hint_path));
+		}
 	}
 
 	item->match = match;
diff --git a/setup.c b/setup.c
index 17814a080b..f4897287f7 100644
--- a/setup.c
+++ b/setup.c
@@ -120,9 +120,13 @@ char *prefix_path_gently(const char *prefix, int len,
 char *prefix_path(const char *prefix, int len, const char *path)
 {
 	char *r = prefix_path_gently(prefix, len, NULL, path);
-	if (!r)
+	if (!r) {
+		const char *hint_path = get_git_work_tree();
+		if (!hint_path)
+			hint_path = get_git_dir();
 		die(_("'%s' is outside repository at '%s'"), path,
-		    absolute_path(get_git_work_tree()));
+		    absolute_path(hint_path));
+	}
 	return r;
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog

