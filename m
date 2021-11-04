Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3515DC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 23:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1936861215
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 23:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhKDXwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 19:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhKDXwd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 19:52:33 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C9AC061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 16:49:54 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id k63-20020a628442000000b004812ea67c34so4886398pfd.2
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 16:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VP1JQEESXQRZnGmzjO+twoEcTFqKxG/iXsJViD0Mfog=;
        b=eLgOtEGJJgBLvNqlLJYMDu/tSV+Kt3Hxz34Ib/zaWf2ecRPTHoDY4SyQLEP+D2u0MK
         QPS2yc64xuKAmsGN+wIDOcMQHy9iydwdozH6ztvNMJ2UHbBhiSht7gWqZkOlCtDf+PIr
         bIoxDHOD6uM/3ECGDIgU1InFnFH1ULk0t6PdspMX0vNc+pVijK93TMLKLcgn6H0/2Gkb
         ummCZK+ms05oL66izQSgETjaHxvKc/pJENzik/YtzUURm0dhFs24HxpM72044ACfEWhv
         30iSuw49A9qgC26GwnKQJ27ZTZ9AZknzr7mGsjzvkyn9nZ7sHmMlZeKWp1Uq7h48YS/I
         j9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VP1JQEESXQRZnGmzjO+twoEcTFqKxG/iXsJViD0Mfog=;
        b=wt8hyVCrJezD+Iam4N+6ZS1HSoa5FxgTB3pGrruI7nFSEUUbjdfSHhbqKFH2JyKIA6
         /bxR6dXzcLdBO4jZOh6j02Lmvee+mJ5pcNVzFhusObd0VwjImWWCaQ2XZ1VRfsBpPYUs
         Emp4B+WLD7j0YSEYhevlKZN8HkFvIHvbRXALrzAT8c2MaHssXiWT88lXpXxhAFMLLKMU
         ARqwBSv6+rip8f64wsjFgN9bbiwsgF6Beut9bmKTvcjTI1o8htYCmx/6Ap8IW66lUQh7
         0sEfoOHhyFJilxubr8/4CHh4M7pZYRkegNmzLEODggN43B0fv7usOETI8Zee3V2MLd/0
         t/8w==
X-Gm-Message-State: AOAM531PqRR48+FM4YTdOPlz/7mFcun+47r4E0lvfPM8kYU7D5NJQoYg
        4yCmnEa1oVe6y+rFWnCH9fv31FaPCdiUeW6jbw9Fx/FWL+AQuPRnyXq5WuVGfozh5F0bYXN2wMU
        s1HEd9NtMJnDMZjWQjM54hWuhaQLtRd2UErhHs43DoRAGbcE9UIEVWstkRLsZyHKQmBPeMhdSmQ
        ==
X-Google-Smtp-Source: ABdhPJwsFHP9fYWpeypv6YpZHL6RWlk6zITMCqwZl0ycV/20OiG1ny8q7mSFWXIfNQ1DJImzdg0Q2yXVDZ/5ao4qdyk=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:35a1:c171:b6f3:d46c])
 (user=emilyshaffer job=sendgmr) by 2002:a17:902:654b:b0:13d:c967:9cbd with
 SMTP id d11-20020a170902654b00b0013dc9679cbdmr47627732pln.88.1636069793943;
 Thu, 04 Nov 2021 16:49:53 -0700 (PDT)
Date:   Thu,  4 Nov 2021 16:49:42 -0700
In-Reply-To: <20211104234942.3473650-1-emilyshaffer@google.com>
Message-Id: <20211104234942.3473650-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20211104234942.3473650-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v5 4/4] submodule: record superproject gitdir during 'update'
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
index 652861aa66..873d64eb99 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -449,6 +449,20 @@ cmd_update()
 			;;
 		esac
 
+		# Cache a pointer to the superproject's common dir. This may have
+		# changed, unless it's a fresh clone. Writes it to worktree
+		# if applicable, otherwise to local.
+		if test -z "$just_cloned"
+		then
+			sm_gitdir="$(git -C "$sm_path" rev-parse --absolute-git-dir)"
+			relative_gitdir="$(git rev-parse --path-format=relative \
+							 --prefix "${sm_gitdir}" \
+							 --git-common-dir)"
+
+			git -C "$sm_path" config --worktree \
+				submodule.superprojectgitdir "$relative_gitdir"
+		fi
+
 		if test -n "$recursive"
 		then
 			(
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 11cccbb333..5146237abc 100755
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
+		"$(git rev-parse --path-format=absolute --git-common-dir)" \
+		"$(git -C submodule rev-parse --path-format=absolute --git-common-dir)" >expect &&
+	 git -C submodule config submodule.superprojectGitdir >actual &&
+	 test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.34.0.rc0.344.g81b53c2807-goog

