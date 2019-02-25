Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AE2820248
	for <e@80x24.org>; Mon, 25 Feb 2019 21:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfBYVyZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 16:54:25 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:54908 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbfBYVyY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 16:54:24 -0500
Received: by mail-qt1-f202.google.com with SMTP id j22so10437327qtq.21
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 13:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j12g4PkfMhum5AXx1xOCQwmkmFG+sCbcsnNprL6mqK0=;
        b=s0D08Vl86htk4aPMcZ6qSnx1FLhg/g8gtfaESB90BYbRXLutQTggGLCkhPv+i6NtiI
         2iVjLMIwFyX3EGQ4TLhRO/5/NBuODBdjzARO6rMuCbujjww69UVWH9RVVGdVY/5u6TzI
         bkoSLr2Xkuxrc88DY3sM98VAjBReeYMm0mb22m9wwPpA3yoToZ24clBgfch5+GKi7rrm
         HJ+08LQbnvmd+Cyouw76OCCpYdcnJPQnuH4DDluACpqiaZAOJROuoR4rFszQXZQmKLpP
         8CpXu0Xz6PhTWlomf3BILfxbVC6xCbRKXOhl67mVt3MX36mPCgF5vgZt1safo+qZtlZ4
         089Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j12g4PkfMhum5AXx1xOCQwmkmFG+sCbcsnNprL6mqK0=;
        b=q3VgUa+WRALEdQrRQjgSrckGGqyVm1lzfFM3WjoRisQU55yRP7h3cLRhfCgd+/GXZn
         UkYik/Ut7DQekuVk3rECyffw7iVHVfYWSctFvq+FD2dm81+dLIinCyHHWWPfWCZeax2Y
         nXjZNqyu5DHw+YxO6KWKwHQ+QEze/Q/ZC62aNt1F3XAG2DNrzoSapA7nr8oKim4TMh7z
         ZUHl0XyBfG+DqpCqc8NYquwY0f5VafyfQXiMuJs6IpN3Anm0OhmaxO+qRxyYHgiIhOcl
         45ryv30jN9pTdFGGZOF3SnNWyNQQh5gEY/MNktb0bdGzuffPPV6W43pWpoeolzFEZcNv
         KbrQ==
X-Gm-Message-State: AHQUAuYz0Km7p+Ror7PqHJ6uMc22lTOgJoyuuzIcRg6ZnKtK/LFjouTf
        9W9ATqaewUrAAFb+xvaDG8Cl3D+gZHlQsgmMtzF1sx29TfJLCQJKuaOVsdnmLWoyCIBHCLI6ozq
        XTHqo8xvSI+Py9ophtkOV//a4q2lmToqwWg1Etvrw+vLv+IoM3s4biHfPSIocgBJTPwZAnO6ZH4
        oe
X-Google-Smtp-Source: AHgI3IakiAXVSi1jkRgSbTWSFzU7UKjhRuZY0DOeue0+THNZoJ+g9ZqWm8PbMuHHlC4BL5U2Zjr4rVsVxt70kr/UHhRo
X-Received: by 2002:a0c:b7a8:: with SMTP id l40mr12362211qve.4.1551131662910;
 Mon, 25 Feb 2019 13:54:22 -0800 (PST)
Date:   Mon, 25 Feb 2019 13:54:07 -0800
In-Reply-To: <cover.1551131153.git.jonathantanmy@google.com>
Message-Id: <1c865e4ae91d207160f8d41607ceca6d8ca7d775.1551131153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1551131153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 2/8] t5601: check ssh command only with protocol v0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running the SSH command as part of a fetch, Git will write "SendEnv
GIT_PROTOCOL" as an option if protocol v1 or v2 is used, but not v0.
Update all tests that check this to run Git with
GIT_TEST_PROTOCOL_VERSION=0.

I chose not to do a more thorough fix (for example, checking the value of
GIT_TEST_PROTOCOL_VERSION to see if the SendEnv check needs to be done)
because a set of patches [1] that unifies the handling of SSH options,
including writing "SendEnv GIT_PROTOCOL" regardless of protocol version,
is in progress. When that is done, this patch should be reverted, since
the functionality in here is no longer needed.

As of this patch, all tests pass if GIT_TEST_PROTOCOL_VERSION is set to
1.

[1] https://public-inbox.org/git/cover.1545342797.git.steadmon@google.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5601-clone.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d6948cbdab..a454b143ea 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -345,7 +345,7 @@ expect_ssh () {
 }
 
 test_expect_success 'clone myhost:src uses ssh' '
-	git clone myhost:src ssh-clone &&
+	GIT_TEST_PROTOCOL_VERSION=0 git clone myhost:src ssh-clone &&
 	expect_ssh myhost src
 '
 
@@ -356,12 +356,12 @@ test_expect_success !MINGW,!CYGWIN 'clone local path foo:bar' '
 '
 
 test_expect_success 'bracketed hostnames are still ssh' '
-	git clone "[myhost:123]:src" ssh-bracket-clone &&
+	GIT_TEST_PROTOCOL_VERSION=0 git clone "[myhost:123]:src" ssh-bracket-clone &&
 	expect_ssh "-p 123" myhost src
 '
 
 test_expect_success 'OpenSSH variant passes -4' '
-	git clone -4 "[myhost:123]:src" ssh-ipv4-clone &&
+	GIT_TEST_PROTOCOL_VERSION=0 git clone -4 "[myhost:123]:src" ssh-ipv4-clone &&
 	expect_ssh "-4 -p 123" myhost src
 '
 
@@ -405,7 +405,7 @@ test_expect_success 'OpenSSH-like uplink is treated as ssh' '
 	test_when_finished "rm -f \"\$TRASH_DIRECTORY/uplink\"" &&
 	GIT_SSH="$TRASH_DIRECTORY/uplink" &&
 	test_when_finished "GIT_SSH=\"\$TRASH_DIRECTORY/ssh\$X\"" &&
-	git clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
+	GIT_TEST_PROTOCOL_VERSION=0 git clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
 	expect_ssh "-p 123" myhost src
 '
 
@@ -444,14 +444,14 @@ test_expect_success 'single quoted plink.exe in GIT_SSH_COMMAND' '
 
 test_expect_success 'GIT_SSH_VARIANT overrides plink detection' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
-	GIT_SSH_VARIANT=ssh \
-	git clone "[myhost:123]:src" ssh-bracket-clone-variant-1 &&
+	GIT_TEST_PROTOCOL_VERSION=0 GIT_SSH_VARIANT=ssh \
+		git clone "[myhost:123]:src" ssh-bracket-clone-variant-1 &&
 	expect_ssh "-p 123" myhost src
 '
 
 test_expect_success 'ssh.variant overrides plink detection' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
-	git -c ssh.variant=ssh \
+	GIT_TEST_PROTOCOL_VERSION=0 git -c ssh.variant=ssh \
 		clone "[myhost:123]:src" ssh-bracket-clone-variant-2 &&
 	expect_ssh "-p 123" myhost src
 '
@@ -482,7 +482,7 @@ counter=0
 # $3 path
 test_clone_url () {
 	counter=$(($counter + 1))
-	test_might_fail git clone "$1" tmp$counter &&
+	test_might_fail env GIT_TEST_PROTOCOL_VERSION=0 git clone "$1" tmp$counter &&
 	shift &&
 	expect_ssh "$@"
 }
-- 
2.19.0.271.gfe8321ec05.dirty

