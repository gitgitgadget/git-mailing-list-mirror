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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A290C432BE
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 359E6610D2
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhHSUKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbhHSUKs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 16:10:48 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D87C061756
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:10:11 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id x10-20020a05622a000ab02902982df43057so3415346qtw.9
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1qdRTQjSkrijWEztupM+Dn+VxpuMQu76dkre4l8ppG8=;
        b=jiYdA8ypaeCPY+slT7QEgywvndhS9xpzyq4Cc+EQxHRnIxZX0PYnOfrRKw7cF5u8OV
         u5WCKLSMEg2MztBZeimudWIMgIyDWadSnP2TfrbwM9PZO+EPJxbwzQsFJ4mIjUEjaq4y
         xM+8g4aa6guFtYQYjXniJk88rEZ2fYkQgUiYq0L9xymYQVG4b+7ubggWEXOV7Et27XZX
         hDlBFTX83UVjBfMGlPgoh5pp+oIua0L+CrjVyPJg2l7zikha60Qm4qBMvEu2bwoSwe6M
         u6hdWyh7Xp61DA7blRvQi/Hp1qrqE5MO3It7GT6qSq9sp3iM+VMlswKuccf3cTSek8PN
         fSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1qdRTQjSkrijWEztupM+Dn+VxpuMQu76dkre4l8ppG8=;
        b=CXvhZRabSHZ3iz2+siC4Mx9rM72H14GS1ZqjaBtbPU45+WWpua23mAqxkr+o6mMYyZ
         xTRkGwbzAXTdnVfx5SFkJyy1Wu2aTG96whFo7OgvfYgBEUJeTJZK8cGUNVFj7yDipORM
         q+d8WuP0C2y3hZr+ErnKVGaOrWEmtvIGr7qcMoiXyKppatWidxgxYLsCez7BJeWasBEW
         X+7r9y6n+hcHEULRMs+3PBOAD5zeOZKIzNRaJYXQZXbAdH3h32ox5246zXOTDWNyziXp
         vx2a+SPSAbBx46YGWyYhg0lrMJrWkroRgnBHQzINZu4hSKlUaordciJ9+Bt3TVLe7ppf
         6Whg==
X-Gm-Message-State: AOAM532KHltAktkMCI8euTNWMctt1hkuDuo6P3mJkqkNA60tSjFVgIuS
        FCd9qC9xJj6JeYWiKG5HuLsb+wAYbNOl8663AzezXwEP/vMSk6hI63DbEDf7yxJEpn6RE7CbAoo
        ai42m7rbb67uDUlzJIwo//sN7rVy/zoajExJhipOToh6OsH+St4ZuHzwz4omFZopfyufDCnwQwg
        ==
X-Google-Smtp-Source: ABdhPJwhJYk9fK6bf0M/Y7ZW4oLEYQufnHBMtcPjxbsetea9eBOHeSbvwRq0i+yO4tFqpwLbbi/oZ4XFG1t/enn/ejM=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:5c:aa12:af53:acbb])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:126:: with SMTP id
 w6mr16377166qvs.61.1629403810601; Thu, 19 Aug 2021 13:10:10 -0700 (PDT)
Date:   Thu, 19 Aug 2021 13:09:53 -0700
In-Reply-To: <20210819200953.2105230-1-emilyshaffer@google.com>
Message-Id: <20210819200953.2105230-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210819200953.2105230-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 4/4] submodule: record superproject gitdir during 'update'
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A recorded hint path to the superproject's gitdir might be added during
'git submodule add', but in some cases - like submodules which were
created before 'git submodule add' learned to record that info - it might
be useful to update the hint. Let's do it during 'git submodule
update', when we already have a handle to the superproject while calling
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
2.33.0.rc2.250.ged5fa647cd-goog

