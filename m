Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6220BC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJTXRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJTXRF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:17:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0C722C63C
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:17:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n12so1926442wrp.10
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mdgqviqxc9y6T4fAO6kDqLLief+c5Jt3pudwn3+YNc=;
        b=TlPfiipL1IW/nU/DFkZar7dbdse6rYn3eqpPqkjpNQ4MIFzjnqwFdd6OvB4MiUk1WR
         2UiFCsFEIHV1HoWeXCVyanxfhZvnkPqdpARIDYU37zf2CdV8GkdwHs0SwuN+/x2i1Nsr
         Hwap77Rz0q44mENd5y1jsWhYaeJFvaN/EVaZP4DSfNB3NybWlolPws7Vav0Plgh9W52R
         ggp1x7XizS6XAEotr4YiCL1HgRgr8qshKl7Om4pk8/MU8lB18kxlbSuFKCmCGXHaZfUH
         7Io6unwbYaIeAmWrKTPqF063Qx2yCrlMhfv9mU0DRWyibHOLfypuHIKJGM7UDMwLoOlD
         QEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mdgqviqxc9y6T4fAO6kDqLLief+c5Jt3pudwn3+YNc=;
        b=6WCSTDAcvccGHN37WwuisWfZZucRl21P40mBN8+uYfVv2qIvh0R9bf2qG9H6VQYso5
         L9DvUMRm5AUvqFDXNym/qk2N3jXz4x+NIO3BoQR6AhKd/N8/YZFd9mg8bXpkQP27m3gC
         CFH9eEq/wos5HT8SIeC+KGn7Tfnz4hWbKLxFhJugy4OUfBoFFNvaMLkiUMHLU58s70Pg
         knCp3EiPCSCcxxKqwr6o0gEw3cu+s/t9fKkadM3PJCQpoZmGkprDo3rVaFvUBBPChW78
         kU+AaJHWzTiUKoVnEQaoylkimhrkpfTBmNF6Pb0KdSkSFOQHl2K3MmBo+ZaEqh+DJgj0
         IfPg==
X-Gm-Message-State: ACrzQf3jP0PSX693gUwAyb4FN8tzvZmRtXWXS4WD3YX2eOmAywdOANAR
        w94OMdWJxpH0jMyYRNVXnVtgj4q8JT4=
X-Google-Smtp-Source: AMsMyM6yubKQuepc2kK7Um1QrH/ngKv4T9V0DE7ndpg0SPzM0ahO20iY8MQVvcb8Fm6CNzaYdH9PmQ==
X-Received: by 2002:a5d:584f:0:b0:22e:4276:d92b with SMTP id i15-20020a5d584f000000b0022e4276d92bmr10393904wrf.697.1666307822097;
        Thu, 20 Oct 2022 16:17:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c229900b003b492338f45sm765386wmf.39.2022.10.20.16.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 16:17:01 -0700 (PDT)
Message-Id: <bb0b4add03c158a0b32306cbe075960fff53d78a.1666307815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
References: <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
        <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 23:16:53 +0000
Subject: [PATCH v4 4/6] patch-id: fix patch-id for mode changes
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

