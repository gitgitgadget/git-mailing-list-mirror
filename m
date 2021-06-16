Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FA9C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A70C61241
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhFPArc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 20:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhFPAra (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 20:47:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D40C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 17:45:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i3-20020a259d030000b029054c59edf217so573204ybp.3
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 17:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+4gINbzM6jbipQ/SlVuYxWfW/gZphO4a+ijKs8CI7/U=;
        b=R3SfMs3TZneQyu4ii3evq1lRgIQYBZC9TWbgzIktqHFXmbUzG4T45ajIvO1ab7uIZZ
         fHkwL8VYIZIdLQoApjbHGc75tans4nIWfKOD38zF+hBxMFvGqABvoX2k2Y1HAxb6pMPL
         1n9a3sLG/r6m2OMkDgOolgtxOdRvRdfZzTQ/Xz+Irqgy19FhLTQh9JfdtG49A8HMu+vL
         6z2yQDmU9tW5LqXEXyJRnDjHgrk8Edj+HJU6Tg4Jv0i5JbMMg/YK60WLjDCnudxG9Y8z
         H72N2aQxwWrjOSkgDn3zQV7plQl8cLhHqRM8JeX2dMXl63Plq2pNbpdJkTy7/ciGgtdS
         D87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+4gINbzM6jbipQ/SlVuYxWfW/gZphO4a+ijKs8CI7/U=;
        b=h3GH5mNhfJOgqODJo0EYAQllMHXh47kA9spooLmdzUoJ6J64fXydDaMD7nu8Yn2M64
         omeXo+e2a5DTYrQIDbiyfCpsNF+2sfc579+/4EKUBalbi9qhYZ9NtFWHZk0u+/8vUbc7
         XcWMIgODeFSI+VgNn6StzYia6s4XJw0Z9Yq2VuO1xtzNiaiPJtvBAYqPtYijE026y23k
         mhjEFbPTZj92Uoz69w6BSYvghfsv75awHwyxQdtP/zPgTdk4qrkBFxIeQsqDJiDJqF+4
         YMT9g6Jy2Qd97iN9+bgAR/RlRuk19DlE5SOz/GPZWIaaRgNlGgUmdJmvDHF36CnDMIkI
         0Y/w==
X-Gm-Message-State: AOAM530Dm++CzVr/KZES9n2UbVRfmuKNzTUJcHIvWcYN3sqwaSKPM3oB
        5fDoc5Pi1vjb2jPLgoqTvwt2CBlW9jeeNmtm3P8ZcUmMC3f+mJB7l308U7go1LnrWekHsYvysNR
        gN2oomTxn0PHfrGRtFLQvi8VPpgvSk2w3PsKFs4Hl+Sc6jPoXmz3vtGzJCb2PfY/XvSxd/cjuAw
        ==
X-Google-Smtp-Source: ABdhPJxX7k3e/9if4G3hiA7dYH11AdzFmcLDd+/OF6ftSX4PYDWazuIwhyd4aB8We0yoAsvfE+GC2vhI8uooyB9MHgM=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:d4cc:f4a9:b043:ff6e])
 (user=emilyshaffer job=sendgmr) by 2002:a25:bcd1:: with SMTP id
 l17mr2326365ybm.33.1623804323514; Tue, 15 Jun 2021 17:45:23 -0700 (PDT)
Date:   Tue, 15 Jun 2021 17:45:08 -0700
In-Reply-To: <20210616004508.87186-1-emilyshaffer@google.com>
Message-Id: <20210616004508.87186-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210616004508.87186-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v2 4/4] submodule: cache superproject gitdir during 'update'
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A cached path to the superproject's gitdir might be added during 'git
submodule add', but in some cases - like submodules which were created
before 'git submodule add' learned to cache that info - it might be
useful to update the cache. Let's do it during 'git submodule update',
when we already have a handle to the superproject while calling
operations on the submodules.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 git-submodule.sh            | 10 ++++++++++
 t/t7406-submodule-update.sh | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4678378424..f98dcc16ae 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -648,6 +648,16 @@ cmd_update()
 			fi
 		fi
 
+		# Cache a pointer to the superproject's gitdir. This may have
+		# changed, so rewrite it unconditionally. Writes it to worktree
+		# if applicable, otherwise to local.
+		relative_gitdir="$(git rev-parse --path-format=relative \
+						 --prefix "${sm_path}" \
+						 --git-dir)"
+
+		git -C "$sm_path" config --worktree \
+			submodule.superprojectgitdir "$relative_gitdir"
+
 		if test -n "$recursive"
 		then
 			(
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f4f61fe554..c39821ba8e 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1061,4 +1061,14 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 	)
 '
 
+test_expect_success 'submodule update adds superproject gitdir to older repos' '
+	(cd super &&
+	 git -C submodule config --unset submodule.superprojectGitdir &&
+	 git submodule update &&
+	 echo "../.git" >expect &&
+	 git -C submodule config submodule.superprojectGitdir >actual &&
+	 test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.32.0.272.g935e593368-goog

