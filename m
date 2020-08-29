Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4F5C433E6
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 22:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AED20776
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 22:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOdJ/z22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgH2W5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 18:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgH2W5K (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 18:57:10 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF5CC061573
        for <git@vger.kernel.org>; Sat, 29 Aug 2020 15:57:09 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z2so2283912qtv.12
        for <git@vger.kernel.org>; Sat, 29 Aug 2020 15:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TizANQBGCz+3bKkZSG+sHwWG+Fm/ik5G+UxP+cwypd0=;
        b=uOdJ/z22eRY6mJNlXjxU2evzMWx7khqySU3fYG6MrgLv7e7U3SLXS9gZzcBoweQDZa
         7xaFkUHrH21OZ7sLplHlPKppof+1xqIy0A8kkHvrxYvz2GWbqOeCYvQKSxHv+xXpFWme
         tJ9wgu+/p2UKiPzKCHWpTcNVcI6lsxSh91Q9lOiRdmNQ3PmtKy6dLQdXMdi1mC6vnPqN
         SDDc5EtruXt90vTfi1fb2hsdaBOdPypAz/fMHyjJOJYUkx07v87o2SHLuT5d+6kkQ7M0
         H+bij9ZIQiebuI6n7DxliMANc8qtQTmYKh5Lmrd8XvAm0WMQ5HNDM/AFzY2lFVFir//Q
         YiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TizANQBGCz+3bKkZSG+sHwWG+Fm/ik5G+UxP+cwypd0=;
        b=mufT06oawNckNX5OV/8tYJsGrAqWy85T2sVFI/3289Q7Ow8cDZsWIJXRYGllf78RYM
         cmk4v6P0YpQu3OJ1ljICLXcKD5wO/PJLgLGDXAKG/54RRQflBOPsCStFLY4T5+0eLwYX
         Kato0tetxFIpg7OC714y1K8Mt3WFQ2GId91FJQJvQjI2LTDozmTQCUmCSnO3ZAk4La6B
         yP2h7bE4rl2LHWMkDPmxMM4Ga3Ci9iZwOYU7EFbfY282diGk4EoV/0PjB4eZSEDX6ojh
         kKCLonGCzjL10Tpuk1QNbQ4u84N66CkDhvJ8aECc/CEPYZV0NecLyDVSc8wE2Q6uinyr
         DG0g==
X-Gm-Message-State: AOAM531rSExNH1vZ+s6h3tRqK32slu1Sh9MNHIb2/iyvgYo5Z45KyGEf
        FwWyzXsgtC9a1GhYd+oSpcD2+WfLBL/J2A==
X-Google-Smtp-Source: ABdhPJzRF2WH6yzjIJ6ShxOUoU1ecM56hwHd8wUWVxTOrNxNSTAGza1mOqAHd6NYps60f2agqgGyEQ==
X-Received: by 2002:ac8:3836:: with SMTP id q51mr7337527qtb.41.1598741827970;
        Sat, 29 Aug 2020 15:57:07 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id o13sm3910865qko.48.2020.08.29.15.57.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Aug 2020 15:57:07 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH] t3200: clean side effect of git checkout --orphan
Date:   Sat, 29 Aug 2020 18:56:48 -0400
Message-Id: <20200829225648.11971-1-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "refuse --edit-description on unborn branch for now" test in t3200
switches to an orphan branch, causing subsequent git commands
referencing HEAD to fail. Avoid this side-effect by switching back to
master after that test finishes.

This has gone undetected, as the next effected test expects failure -
but it currently fails for the wrong reason.

Verbose output of the next test referencing HEAD,
"--merged is incompatible with --no-merged":

  fatal: malformed object name HEAD

Which this commit corrects to:

  error: option `no-merged' is incompatible with --merged

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
We might considered updating "--merged is incompatible with --no-merged"
tests to not only test for failure, but check the contents of the error
message to ensure they fail for the correct reason, e.g.:

test_expect_success '--merged is incompatible with --no-merged' '
  test_must_fail git branch --merged HEAD --no-merged HEAD 2>error &&
  test_i18ngrep "is incompatible with --merged" error
'

However, I intend to submit a patch enabling ref-filter to accept
multiple merged/no-merged filters, which would make said updates
irrelevant.

 t/t3200-branch.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 4c0734157b..028c88d1b2 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1287,6 +1287,7 @@ test_expect_success 'detect typo in branch name when using --edit-description' '
 '
 
 test_expect_success 'refuse --edit-description on unborn branch for now' '
+	test_when_finished "git checkout master" &&
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
 	EOF
-- 
2.24.3 (Apple Git-128)

