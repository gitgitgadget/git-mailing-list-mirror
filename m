Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BDAC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2C46128E
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhKQBAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 20:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhKQBAM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 20:00:12 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECEDC061746
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:57:14 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id lj10-20020a17090b344a00b001a653d07ad8so2157191pjb.3
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V3qykwMN4wHWktrVL99TQAqGyHQLsaQkqRKTO9qhMYM=;
        b=tV4DkTnNsD3XeaDQjRE/h1A+QO8srrHwDpaNv9hOMUddgQeYD2KDns6FctKYoGTPS4
         uFzEiMhhj5hiA5jdz3mJvh8pIyZnCXS+F6dYrvJ20ytyrGfH0Qc9m7AeVpsVZFu6NjWN
         4Mm4YKbcTe123a8Pmtjg2sAuuNhTmt1OjzeeVszVecnyOJqmL+h4+HB4/oZ0hQp2Ocma
         quAfVQA5xnvwAy1nW4+4JCbt9CjDMDWGWTZEWSftgfzpovp9sZRM+mDI/PSILWNBzDcg
         kpxAI9SbQN23HoXyb50UvN5CRhUcFg34eYzQ93dOUcOo4Zx4faQce0NiKL4vs/hovOFy
         Eb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V3qykwMN4wHWktrVL99TQAqGyHQLsaQkqRKTO9qhMYM=;
        b=4B6P8lOe1vC3xl3uMTwxqIKtjSCMHlQwLBRkXq5H7S2fPk7s90w6KNthRH0pm3tpIv
         VZ+D1m5n2anvft5u6yOO60T7Pl7RpYtiV/04X+dCMP9L41DVIFsVBqARgqL23BwTLxYt
         3OqVZjwz+R/MBfjde2pKjpsoRe71nNVXsYYdYS71/yoiv3XsvlkG+FMmTgiDfxe45nYZ
         mTEM6sdn+VlgaaCRKsd7X4BZ/NE3bEIl3Ok/3iPmSVM19hhoPgeMqx8qIrru+qeyg5g5
         4GZkA1UT3SsFbgxZlO8hUsKeV7KnbiMOoonexjouswRR6F39ptbJ3lQF6FU8F6bQUSyF
         B4lw==
X-Gm-Message-State: AOAM531bLWezf/HobJSm86f2zFpFtqPv8ujaPhReOZlRsNID5o0c42i1
        wtE+u/Xxaabimc9F+zzxdurf9pLkfh6jPY9YCPXg7YK7uAfhnJQp/Wh5tXaoJvR46KcCygriFMw
        +UuXocCfk/3ZEM1KGgKF0U8uQhShQjMuiabyWvMMUCfMAHE31Z3gmGBFBkXO14o1zzGnHGkHPlg
        ==
X-Google-Smtp-Source: ABdhPJwCR6zJmuPNKyTubsx6fItNPNK1qeHLYB5HIFCn84TSHes4Da+YxMA7lrfJe7Al0bulJp+a+Lf1Vvh2UzB2Anc=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:205d:7edd:a3da:3608])
 (user=emilyshaffer job=sendgmr) by 2002:a17:90a:bf0b:: with SMTP id
 c11mr4197208pjs.208.1637110634205; Tue, 16 Nov 2021 16:57:14 -0800 (PST)
Date:   Tue, 16 Nov 2021 16:57:00 -0800
In-Reply-To: <20211117005701.371808-1-emilyshaffer@google.com>
Message-Id: <20211117005701.371808-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20211117005701.371808-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v6 4/5] submodule: record superproject gitdir during 'update'
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A recorded path to the superproject's gitdir might be added during
'git submodule add', but in some cases - like submodules which were
created before 'git submodule add' learned to record that info - it might
be useful to update the hint. Let's do it during 'git submodule
update', when we already have a handle to the superproject while calling
operations on the submodules.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 git-submodule.sh            | 15 +++++++++++++++
 t/t7406-submodule-update.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 652861aa66..7c247bee7f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -449,6 +449,21 @@ cmd_update()
 			;;
 		esac
 
+		# Store a poitner to the superproject's gitdir. This may have
+		# changed, unless it's a fresh clone. Write to worktree if
+		# applicable, and point to superproject's worktree gitdir if
+		# applicable.
+		if test -z "$just_cloned"
+		then
+			sm_gitdir="$(git -C "$sm_path" rev-parse --absolute-git-dir)"
+			relative_gitdir="$(git rev-parse --path-format=relative \
+							 --prefix "${sm_gitdir}" \
+							 --git-dir)"
+
+			git -C "$sm_path" config --worktree \
+				submodule.superprojectgitdir "$relative_gitdir"
+		fi
+
 		if test -n "$recursive"
 		then
 			(
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 11cccbb333..b42a339982 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1061,4 +1061,31 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 	)
 '
 
+test_expect_success 'submodule update adds superproject gitdir to older repos' '
+	(cd super &&
+	 git -C submodule config --unset submodule.superprojectGitdir &&
+	 git submodule update &&
+	 test-tool path-utils relative_path \
+		"$(git rev-parse --absolute-git-dir)" \
+		"$(git -C submodule rev-parse --absolute-git-dir)" >expect &&
+	 git -C submodule config submodule.superprojectGitdir >actual &&
+	 test_cmp expect actual
+	)
+'
+
+test_expect_success 'submodule update uses config.worktree if applicable' '
+	(cd super &&
+	 git -C submodule config --unset submodule.superprojectGitDir &&
+	 git -C submodule config extensions.worktreeConfig true &&
+	 git submodule update &&
+	 test-tool path-utils relative_path \
+		"$(git rev-parse --absolute-git-dir)" \
+		"$(git -C submodule rev-parse --absolute-git-dir)" >expect &&
+	 git -C submodule config submodule.superprojectGitdir >actual &&
+	 test_cmp expect actual &&
+
+	 test_file_not_empty "$(git -C submodule rev-parse --absolute-git-dir)/config.worktree"
+	)
+'
+
 test_done
-- 
2.34.0.rc1.387.gb447b232ab-goog

