Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05A7C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5DF61156
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhJNUgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 16:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhJNUgs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 16:36:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D8CC061768
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:34:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso8624864ybj.1
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QoIuthpLr65F7LoCkm9qKz6B4flEd++2C1i+hilV5+A=;
        b=IjE2LX5fNoXJt+trlDfqKv5a62+2a5hXLATlLS5kCats3iN8DGXptvQbgLPoTLtKSw
         dIMC4M8PUY4fkQAYZ6V9ap9y8/GhpzBfdQFT4CwMvv/qPRAv3l1j7TOn8o/yAt2raWu6
         V3vAhdWIk7z436wAsT+qYgT7bv057cO+peK+UaE8VvrUH1+VJ9e7s30J0cbacEvAiYb/
         aZCXYel7MlvZCCZ4mBsM7FdZQCTeBWCk6wUsA6Lqg41okT5aecemQGv3N4Hgo/4vzmD3
         CRdm2x+eePQkbaiQz4ar0JR3RvxL01WO7jyuPDBEI97xyhwGwfyzYYi87Ad35bVH8Laz
         +ZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QoIuthpLr65F7LoCkm9qKz6B4flEd++2C1i+hilV5+A=;
        b=nAPXHAHEx4aN17Y28npZKq3OOjc7uUj47uduPBCV8TSET0RsL+0B4baqOer+WNkmRV
         XwlBi3S2k5ffyC0XfWhn5SagwyuW+SVFOVC70MtQPmEZRABEpoN0GV/kUGTTLESHuSxf
         2K96yJnExobLjC/cjDs36xYfmAKgJBCQ+Xx5ObuwkUqf+TrK7RBjbu4TJG5gLBGxAZv5
         GmSGU1ONdwINN1YonkFJxOSgzc995MWZOKYk1ZnolpU2QvJts5wlDIOuxsGV9HzG7C8Y
         WKHHGNElZ569aaEMP+5FCf25VCoxsQ9TnONkZMHB4rcLJAf8KQCXOijJ1nvrY8vNtkv3
         7cFQ==
X-Gm-Message-State: AOAM5317PNjKli8eKZXzhm/x/Enqbu+5thmE/Va7diO5A96twQJH4UyQ
        NLu9cvATaekAqtWrN2YqOMxN/V0DSU9V/20s2YhwRvddQedKc3gEwVJ09SXGdluWKoCHEzpAOqp
        x7nPmiAWvF53O7x3eCJoSZ1QLJsujvJ4SFlROhPtLa//yMzUmxRkeJCVVJgbFrknlbouoflx3ig
        ==
X-Google-Smtp-Source: ABdhPJxnmiOMbs+zyXTvMxgPmwBdfivkHEFTNJFAvE80X9ESw2Nup0i0Latbz0T3oDGn9c3zWgou1hQWzTNSbOdMb18=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:e9ae:673a:ec5:a064])
 (user=emilyshaffer job=sendgmr) by 2002:a25:cfc9:: with SMTP id
 f192mr8177700ybg.122.1634243681486; Thu, 14 Oct 2021 13:34:41 -0700 (PDT)
Date:   Thu, 14 Oct 2021 13:34:16 -0700
In-Reply-To: <20211014203416.2802639-1-emilyshaffer@google.com>
Message-Id: <20211014203416.2802639-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20211014203416.2802639-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 4/4] submodule: record superproject gitdir during 'update'
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
 git-submodule.sh            | 14 ++++++++++++++
 t/t7406-submodule-update.sh | 12 ++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 652861aa66..ec02eb5971 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -449,6 +449,20 @@ cmd_update()
 			;;
 		esac
 
+		# Cache a pointer to the superproject's gitdir. This may have
+		# changed, unless it's a fresh clone. Writes it to worktree
+		# if applicable, otherwise to local.
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
index 11cccbb333..7fd5741a5a 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1061,4 +1061,16 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
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
 test_done
-- 
2.33.0.1079.g6e70778dc9-goog

