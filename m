Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7860C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 13:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD81206ED
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 13:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/Ys//Qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgBNNxY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:53:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55316 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgBNNxY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 08:53:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so10024161wmj.5
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 05:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=xr/NzZG0zkn/fDRazX3ShNG6MqOrdP69/CSGuWOvWAA=;
        b=G/Ys//QkVE+nC6HzdL/7dPNk7lrg4EyJbLK+74dW7lCWxWq+nWOO9jnvw50YXo8cSQ
         E0837CFzWt5ctLHnr6RdRYhZR328kGIMmK0M4GzOvh+M7Dr94+1qHACgmlPl0+uc9c5b
         Ya8jMIXuXXq1kbgTY15QCizyD9Cw0H9vK++hLLzDtcjqG6OPol6oTrgfFwrSZV5t644Y
         ZLjMMpuxFMD/74tC7TKXiQMD7BLfmXlIWGExBGNGGFi2j3EBYncFAKgBFzlAtfeUPzwD
         3xcrbXOlPaC4L7GlJfJdMf9WgcefE7XV3tRz51HvhSmf2YT9+dc1UNyRSIX+wYU80FtL
         ls5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xr/NzZG0zkn/fDRazX3ShNG6MqOrdP69/CSGuWOvWAA=;
        b=WF1k3i/Oyo0RXshCxHOe0UKts6RWwWMq+DbFzyDWF1WWks/myQ8OuhVQQJesO4Z7ex
         AbzfZEu1y/xATL07SSghSODXUDnL+V8oRS89MIWhL1auAkDmXIqhPo2WiNJ9JEchjsWc
         M/S8/bO01SPyxrvCWTkc/2GF4ZjwMHvKLhG2hlzNtwn4q8KTJREZNnkhAEEizU3lQM9U
         nNTDO35rksjzy6EqVCt1aEztYqp4GQEEJstI1aLiKJ9V3+1l4raILCYd01OYaSfGFOVH
         2nuGICWo53TZC+X/NSNEIsoM9c77+IDOAm2FsZ1XpO7r+U1paOTjKzN/5Yg8oz9PdSMc
         RoVQ==
X-Gm-Message-State: APjAAAW72Ngd/WsKRW1k1SsZ078Fe7x5paYHxUP7bEpsYhs6NJ2O3o14
        SaqBzlBCxSITe4ph5gRd31ZgL87S
X-Google-Smtp-Source: APXvYqwIUstV13DM/MhsvDKrKOUZaVt9eKZfEQLArKQmeiuk5JnL7V0BBNZwkL/2j10KAdiuMdURnw==
X-Received: by 2002:a1c:5441:: with SMTP id p1mr5051348wmi.161.1581688402662;
        Fri, 14 Feb 2020 05:53:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16sm7038544wmj.39.2020.02.14.05.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:53:22 -0800 (PST)
Message-Id: <pull.709.git.git.1581688401866.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Feb 2020 13:53:21 +0000
Subject: [PATCH] t9001, t9116: avoid pipes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When grepping through the output of a command in the test suite, there
is always a chance that something goes wrong, in which case there would
not be anything useful to debug.

Let's redirect the output into a file instead, and grep that file, so
that the log can be inspected easily if the grep fails.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Avoid pipes in git-svn tests
    
    This is one more of those patches that convert the pattern a | b to a
    >file && b<file so that failures in a are caught, too.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-709%2Fdscho%2Favoid-pipes-in-svn-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-709/dscho/avoid-pipes-in-svn-tests-v1
Pull-Request: https://github.com/git/git/pull/709

 t/t9001-send-email.sh  |  4 ++--
 t/t9116-git-svn-log.sh | 12 ++++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index a834afab4d7..90f61c34009 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1194,8 +1194,8 @@ test_expect_success $PREREQ 'in-reply-to but no threading' '
 		--to=nobody@example.com \
 		--in-reply-to="<in-reply-id@example.com>" \
 		--no-thread \
-		$patches |
-	grep "In-Reply-To: <in-reply-id@example.com>"
+		$patches >out &&
+	grep "In-Reply-To: <in-reply-id@example.com>" out
 '
 
 test_expect_success $PREREQ 'no in-reply-to and no threading' '
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 45773ee560d..0a9f1ef366d 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -43,14 +43,18 @@ test_expect_success 'setup repository and import' '
 
 test_expect_success 'run log' "
 	git reset --hard origin/a &&
-	git svn log -r2 origin/trunk | grep ^r2 &&
-	git svn log -r4 origin/trunk | grep ^r4 &&
-	git svn log -r3 | grep ^r3
+	git svn log -r2 origin/trunk >out &&
+	grep ^r2 out &&
+	git svn log -r4 origin/trunk >out &&
+	grep ^r4 out &&
+	git svn log -r3 >out &&
+	grep ^r3 out
 	"
 
 test_expect_success 'run log against a from trunk' "
 	git reset --hard origin/trunk &&
-	git svn log -r3 origin/a | grep ^r3
+	git svn log -r3 origin/a >out &&
+	grep ^r3 out
 	"
 
 printf 'r1 \nr2 \nr4 \n' > expected-range-r1-r2-r4

base-commit: d8437c57fa0752716dde2d3747e7c22bf7ce2e41
-- 
gitgitgadget
