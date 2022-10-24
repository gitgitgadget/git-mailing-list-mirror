Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E11AC38A2D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 21:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiJXVzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiJXVzL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 17:55:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04911EC4D
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:09:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l14so10594050wrw.2
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mdgqviqxc9y6T4fAO6kDqLLief+c5Jt3pudwn3+YNc=;
        b=kEl1fiuQTbVeUJmtIDd9ylZPpRbY+0RJhXfYN9e86zxdwRfaGb1DsrVlESS+J2X1o+
         GsWdrbYAyH7l+gEoR9dPHH7JBJVN6ZUVHJshBybLg1C1FIOHVC1KDz3M+drYATbUOJgP
         9e9k5MtyAjVx/NeXYfCvXBH3h5CWhCBTQTuNa99be3n0Jrbz5R7Wf5L4ocupgTx9Pp4U
         Jd8T1J9npVJmoy+fYVoHZH5pYLwl73mUH0b52aMuEsEoJJcyEuqE/GXFEo0RWO1ISufN
         CYLszr5v4wCaZdedy0vSdZKinLXOqgKlAhZvxmzaqap19TSAU1nsxkNdfIwFWLKjOvhq
         1edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mdgqviqxc9y6T4fAO6kDqLLief+c5Jt3pudwn3+YNc=;
        b=YeH1Ihj4ZXY+HUB0VsL+WqEPSkNgMYVQj7lbIO4Zz8yHsT8MkPvmBQHi8/5QsZOn/u
         OQW5wUwSpFve1F8x7hr3i+p2DtyOC8USoo8v4PwhGHlmTX4qTlt0jCHLw6iSwLJ3yX12
         A0ltYljBGrLw7yhNAzOh1aALwtDngFG866w0YUsGU188nbxa0lJ+T4QfN1GyLke4Idb5
         /FNi27hyilGCa2kmiIwHt760M0tl71tHMCNz6QCPXFNnFyRK/lu8NhGgYeSI72fHkEYv
         BbMuQH1bItLq9SwYQPjG5cMlCn0Igh0mC7WpfFyJt0KybVqciPKdvjRZQLOHMymOSacu
         +Z5g==
X-Gm-Message-State: ACrzQf2kCpw9iW0MQHmbj3sbkIBaZvQFgIVy4/evdmCVNfK7M792Q22H
        CxqU+b6gwQCTzKYKW3QQz5CHNbYB1TI=
X-Google-Smtp-Source: AMsMyM7HvejaBdLrNl9OP8RHNb/n5jkYVSFR4JIgxdjhTkCbAWBKnlG5F7OCIzyDUHMpqurVGxrblQ==
X-Received: by 2002:a05:6000:170b:b0:22e:44d0:6bae with SMTP id n11-20020a056000170b00b0022e44d06baemr22497604wrc.99.1666642071898;
        Mon, 24 Oct 2022 13:07:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q21-20020a7bce95000000b003c7087f6ca8sm740576wmj.2.2022.10.24.13.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:07:51 -0700 (PDT)
Message-Id: <bb0b4add03c158a0b32306cbe075960fff53d78a.1666642065.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v5.git.1666642064.gitgitgadget@gmail.com>
References: <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
        <pull.1359.v5.git.1666642064.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 20:07:42 +0000
Subject: [PATCH v5 4/6] patch-id: fix patch-id for mode changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>, Jerry Zhang <Jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jerry Zhang <Jerry@skydio.com>

Currently patch-id as used in rebase and cherry-pick does not account
for file modes if the file is modified. One consequence of this is
that if you have a local patch that changes modes, but upstream
has applied an outdated version of the patch that doesn't include
that mode change, "git rebase" will drop your local version of the
patch along with your mode changes. It also means that internal
patch-id doesn't produce the same output as the builtin, which does
account for mode changes due to them being part of diff output.

Fix by adding mode to the patch-id if it has changed, in the same
format that would be produced by diff, so that it is compatible
with builtin patch-id.

Signed-off-by: Jerry Zhang <Jerry@skydio.com>
---
 diff.c                     |  5 +++++
 t/t3419-rebase-patch-id.sh | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 199b63dbcc3..0e336c48560 100644
--- a/diff.c
+++ b/diff.c
@@ -6256,6 +6256,11 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		} else if (p->two->mode == 0) {
 			patch_id_add_string(&ctx, "deletedfilemode");
 			patch_id_add_mode(&ctx, p->one->mode);
+		} else if (p->one->mode != p->two->mode) {
+			patch_id_add_string(&ctx, "oldmode");
+			patch_id_add_mode(&ctx, p->one->mode);
+			patch_id_add_string(&ctx, "newmode");
+			patch_id_add_mode(&ctx, p->two->mode);
 		}
 
 		if (diff_header_only) {
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index d24e55aac8d..7181f176b81 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -48,7 +48,17 @@ test_expect_success 'setup: 500 lines' '
 	git branch -f squashed main &&
 	git checkout -q -f squashed &&
 	git reset -q --soft HEAD~2 &&
-	git commit -q -m squashed
+	git commit -q -m squashed &&
+
+	git branch -f mode main &&
+	git checkout -q -f mode &&
+	test_chmod +x file &&
+	git commit -q -a --amend &&
+
+	git branch -f modeother other &&
+	git checkout -q -f modeother &&
+	test_chmod +x file &&
+	git commit -q -a --amend
 '
 
 test_expect_success 'detect upstream patch' '
@@ -71,6 +81,13 @@ test_expect_success 'detect upstream patch binary' '
 	test_when_finished "rm .gitattributes"
 '
 
+test_expect_success 'detect upstream patch modechange' '
+	git checkout -q modeother^{} &&
+	git rebase mode &&
+	git rev-list mode...HEAD~ >revs &&
+	test_must_be_empty revs
+'
+
 test_expect_success 'do not drop patch' '
 	git checkout -q other^{} &&
 	test_must_fail git rebase squashed &&
@@ -85,4 +102,16 @@ test_expect_success 'do not drop patch binary' '
 	test_when_finished "rm .gitattributes"
 '
 
+test_expect_success 'do not drop patch modechange' '
+	git checkout -q modeother^{} &&
+	git rebase other &&
+	cat >expected <<-\EOF &&
+	diff --git a/file b/file
+	old mode 100644
+	new mode 100755
+	EOF
+	git diff HEAD~ >modediff &&
+	test_cmp expected modediff
+'
+
 test_done
-- 
gitgitgadget

