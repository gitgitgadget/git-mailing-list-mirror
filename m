Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07191C433F5
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 00:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiAHAwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 19:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiAHAwh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 19:52:37 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EF5C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 16:52:36 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso5858860wmj.2
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 16:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=RbRH/PwhQTXoKLWLiFlygKOxsWF7ej2EFuyg/mJ3tIE=;
        b=dD4i7q/GCHZ6kSEAQTFSi71UEXQMydVnHw921EEkWLjvvLNbr2n4EKptEAMHxhR0td
         GxpE2y1mqPBlKBbTt04bOTOR5P0nmoo2kNSB8I6JsSELHsO/px8yFLUTSws4qG41s8MV
         0j7K2y4s2JzxbWf3v9X1jJH9tTMiDDDQ6/jqwvrQqYwUV8CEct93r9hDw6L0GkG/QohJ
         z7tFhPplY96egFqEkfDZik3NFHOVCp62Px5JDYoCAh4IPdwtHDEvz+IVgX/0OsxTLxTC
         HftgYM56HxXNevGrkl9/0504R+vdLnAsQTRhakZ1WPYP7X79K/I87hiDcRhUFssgIfeB
         DwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RbRH/PwhQTXoKLWLiFlygKOxsWF7ej2EFuyg/mJ3tIE=;
        b=3Wnlrta0Qlm8zC+sw7YdtE8VA+DY0r2Jfz+z8laiJ35l5O7jskw7+xR0UNzwlj+UgV
         MNCEQNOeJ9Y0ZT8kPcnSIjPzqWf8CZiEu3P2APBskCVPtS0YnNT85pmBWmgF7NZfO8u4
         bR1GhP1b+dSUjbQzq55JFinxJzpLtVeoxRWgjw+GOw+F2Yv9M/yXA0XtfwnpY+L50GRs
         A7UdgeNi8v4+8EO1yHK6wJ10UliZOho/hVXIqOlm6mpsll5l7OLQi0Y4pkb9OTCZr55C
         4sbDLBjHOepVYyNxW4SgeLUL8au85dQEYrF2GyVMs6KTbrtCIdOtCLYRb6Mqk/VA7PV4
         O5iA==
X-Gm-Message-State: AOAM531o74cec1KG1yCiZMJZcLNjnV48uiH2F2IENpRBi/1dXdAGhgiq
        373rfl8cvg+tF1lKF/SQ9TJjXdyMJOc=
X-Google-Smtp-Source: ABdhPJwLKtTtil58fxKu5zr+NY2WuEsz6/4R6T7bcTUlgLNixzZc+SEuOOVzCtPN17s6tk4+gMO7jw==
X-Received: by 2002:a05:600c:1c9f:: with SMTP id k31mr12807696wms.159.1641603155307;
        Fri, 07 Jan 2022 16:52:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h20sm59824wmq.38.2022.01.07.16.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 16:52:34 -0800 (PST)
Message-Id: <pull.1112.git.1641603153667.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Jan 2022 00:52:33 +0000
Subject: [PATCH] submodule--helper: check clone.defaultRemoteName in
 print-default-remote
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>,
        Sean Barag <barag@cockroachlabs.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <barag@cockroachlabs.com>

`git submodule update --remote` previously assumed that submodules in
detached-HEAD state (or with no remote configured via
branch.$branchname.remote) should always fetch from "origin". While this
was often true, users could rename the "origin" remote within that
submodule.  This would result in a pair of fatal errors:

    fatal: Needed a single revision
    fatal: Unable to find current origin/HEAD revision in submodule path
    'path/to/submodule'

Since de9ed3ef37 (clone: allow configurable default for `-o`/`--origin`,
2020-10-01) (released in git 2.30) however, that edge-case was trivially
easy to get into. Simply set `clone.defaultRemoteName`, clone a repo
with submodules, run `git submodule update --init`, and the next `git
submodule update --remote` would fail. Support clone.defaultRemoteName
in submodules by checking for the configured default remote name before
falling back to "origin".

Signed-off-by: Sean Barag <barag@cockroachlabs.com>
---
    [RFC PATCH] submodule--helper: check clone.defaultRemoteName in
    print-default-remote
    
    What used to be an edge case with git submodule update --remote got
    significantly easier to reproduce in 2.30+ with clone.defaultRemoteName
    set in git config. git-submodule.sh relies on git submodule--helper
    print-default-remote to determine which remote to fetch from, which
    falls back to "origin" when an explicit remote can't be found (e.g.
    detached HEAD states). Where clone.defaultRemoteName is set, however,
    that fallback to "origin" is no longer appropriate, because the "origin"
    remote doesn't exist. Either way, this results in a fatal error:
    
    fatal: Needed a single revision
    fatal: Unable to find current origin/HEAD revision in submodule path
    'path/to/submodule'
    
    
    This RFC patch adds a check for clone.defaultRemoteName in
    submodule-helper's get_default_remote(), but would love some feedback
    before this becomes a proper [PATCH] email. This works in my initial
    testing and in the added test case, but it feels like I'm missing
    something.
    
    Should I add test cases that don't rely on detached HEAD state perhaps?
    I'm not thrilled with the duplication of git_config_get_string calls for
    clone.defaultRemoteName, but extracting that logic to a static char
    *get_clone_default_remote_name() felt worse. I'd be happy to have any
    feedback y'all can provide :)
    
    From a high-level, I suppose this leaves the pre-2.30 edge case
    unresolved: users can still rename a submodule's remote to something
    else (something != clone.defaultRemoteName if it's set, or something !=
    "origin" if it's not set) and trigger this failure. Perhaps a long-term
    solution would involve querying the list of remotes for each submodule,
    and if there's only one remote assuming it's the correct one to fetch
    from, with the proposed solution as a fallback for multi-remote
    situations.
    
    Anyway, please let me know what I can do to clean this up, make it more
    robust, etc. before it becomes a more formal patch submission. Thanks in
    advance! Sean Barag
    
    Related conversations:
    
     * The original bug report:
       https://lore.kernel.org/git/2d58fe40-9e8c-4653-8170-5411fd3cf6f4@www.fastmail.com
    
     * An adjacent conversation about submodule--helper and remote names:
       https://lore.kernel.org/git/ae3baa2a-2f30-8e8a-f3cf-d8210e7225b0@gmail.com
       
       Philippe Blain levraiphilippeblain@gmail.com, Atharva Raykar
       raykar.ath@gmail.com, Christian Couder christian.couder@gmail.com,
       Shourya Shukla periperidip@gmail.com, Emily Shaffer
       emilyshaffer@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1112%2Fsjbarag%2Fcheck-clone.defaultremotename-in-submodule-helper-print-default-remote-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1112/sjbarag/check-clone.defaultremotename-in-submodule-helper-print-default-remote-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1112

 builtin/submodule--helper.c | 35 +++++++++++++++++++++++++----------
 t/t7400-submodule-basic.sh  | 18 ++++++++++++++++++
 2 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9b25a508e6a..2d1468508ff 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -38,18 +38,33 @@ static char *get_default_remote(void)
 	if (!refname)
 		die(_("No such ref: %s"), "HEAD");
 
-	/* detached HEAD */
-	if (!strcmp(refname, "HEAD"))
-		return xstrdup("origin");
+	/* detached HEAD should use the configured default remote name or fall back to "origin" */
+	if (!strcmp(refname, "HEAD")) {
+		strbuf_addstr(&sb, "clone.defaultRemoteName");
 
-	if (!skip_prefix(refname, "refs/heads/", &refname))
-		die(_("Expecting a full ref name, got %s"), refname);
+		if (!git_config_get_string(sb.buf, &dest))
+			ret = dest;
+		else
+			ret = xstrdup("origin");
+	} else {
+		if (!skip_prefix(refname, "refs/heads/", &refname))
+			die(_("Expecting a full ref name, got %s"), refname);
 
-	strbuf_addf(&sb, "branch.%s.remote", refname);
-	if (git_config_get_string(sb.buf, &dest))
-		ret = xstrdup("origin");
-	else
-		ret = dest;
+		strbuf_addf(&sb, "branch.%s.remote", refname);
+		if (!git_config_get_string(sb.buf, &dest))
+			/* use configured remote name if one is present */
+			ret = dest;
+		else {
+			/* otherwise use configured *default* remote name, falling back to "origin" */
+			strbuf_reset(&sb);
+			strbuf_addstr(&sb, "clone.defaultRemoteName");
+
+			if (!git_config_get_string(sb.buf, &dest))
+				ret = dest;
+			else
+				ret = xstrdup("origin");
+		}
+	}
 
 	strbuf_release(&sb);
 	return ret;
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index e7cec2e457a..ce0801321a9 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1416,4 +1416,22 @@ test_expect_success 'recursive clone respects -q' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'submodule update --remote respects clone.defaultRemoteName' '
+	test_when_finished "rm -rf multisuper_clone" &&
+
+	# expect is intentionally empty.
+	# no output expected, since submodule "sub0" will be up to date
+	> expect &&
+
+	git clone multisuper multisuper_clone &&
+	git -C multisuper_clone submodule update --init -- sub0 &&
+	git -C multisuper_clone/sub0 remote rename origin upstream &&
+	git \
+		-C multisuper_clone \
+		-c clone.defaultRemoteName=upstream \
+		submodule update --remote -- sub0 \
+		2>&1 >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: e83ba647f7c61cf945690d6a0bd8c172a6498dc8
-- 
gitgitgadget
