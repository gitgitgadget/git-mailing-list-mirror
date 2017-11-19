Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C32202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 15:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753093AbdKSPEM (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 10:04:12 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39947 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752994AbdKSPEK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 10:04:10 -0500
Received: by mail-wm0-f67.google.com with SMTP id b189so14057711wmd.5
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 07:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wGlpv/F0cDU60pWoe2O2kv3vXD3h+uCny7XxkuOAJrc=;
        b=cO8qmPoGT47vUqqI+mN4bl63yMd3z5hND45y5RgjtD/9MgFE81cYVCRyruW70Xzmj9
         R1wd5YEKId2wb2bwKDLw3QisNedzbw8cD5CIbxidietJBqXne253I051PMDbcXhmNUZH
         iW634csMJEfSEd7yhgg+8kj+nocuE6EiN8jUZG1N/mxLyJ2XYJOKRnjTKC9oBBdZxrMy
         QUWm61jwSkoEJXLYw/cEZf1/4L/h5vYDj3DX+OInuN91UtBwF19rs5yg+wOvqbApk3Co
         jxrY77wp9NL96gZGIGR3hqmpEOEcB77lMcy2xfRQbQY3UDj6Kn/cBYCCV2hwjofQrUqJ
         u72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGlpv/F0cDU60pWoe2O2kv3vXD3h+uCny7XxkuOAJrc=;
        b=dS+JxgZSeeNu8AoH0NqRFEnUhDbg6E+Mkz8DJcIo/LtC1YgK+wrIWrJIXEV/jyDRgI
         ML8JGdz9k1dlylpDaAH6uAcOlFxrvlCAMV2puKrgg9YQW+wdcBCDWAiA3y9+LVRjDT2A
         n19tM2fWO7uO77Pe9PXvYveFVNym/PVGzQBoIrVwOPgEod8HOLT7NldRANZLDjismifx
         tk4+sKUaX6MyhkTT74+bxKjZNQoEfSvnPiN7+bREzrWhm9i9+gfX+iU0zCrsKYSUJFJp
         Bf0IoNhTJQwYrudjPfeZ1PxUOwIOG3x9TQK5TZLy9HJ1bwsnLerNKpGivG5C7kWlObGt
         Rp1Q==
X-Gm-Message-State: AJaThX5Vc6FmANS1HTgT5wHZutZNWg6nVcxIgWrB0OgFmooVSRYfNr5O
        Jw+Ah9Xl/wUbNrUISdmASLGY/Lxs
X-Google-Smtp-Source: AGs4zMZM6jEtfTntBdjVLUF55UQTVjgiPbPfKwXr2Hv5AezzWbwgKndkvQnlG+sjwFqVt2BwSw7+rw==
X-Received: by 10.28.155.18 with SMTP id d18mr8366360wme.107.1511103848610;
        Sun, 19 Nov 2017 07:04:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 56sm5163518wrx.2.2017.11.19.07.04.07
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Nov 2017 07:04:07 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] branch: respect `pager.branch` in list-mode only
Date:   Sun, 19 Nov 2017 16:03:49 +0100
Message-Id: <f01753ca88cc14549c8f447105dda120ea9d38f4.1511103275.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <5f6be626171060e008005062560c76319b31958f.1511103275.git.martin.agren@gmail.com>
References: <5f6be626171060e008005062560c76319b31958f.1511103275.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to de121ffe5 (tag: respect `pager.tag` in list-mode only,
2017-08-02), use the DELAY_PAGER_CONFIG-mechanism to only respect
`pager.branch` when we are listing branches.

We have two possibilities of generalizing what that earlier commit made
to `git tag`. One is to interpret, e.g., --set-upstream-to as "it does
not use an editor, so we should page". Another, the one taken by this
commit, is to say "it does not list, so let's not page". That is in line
with the approach of the series on `pager.tag` and in particular the
wording in Documentation/git-tag.txt, which this commit reuses for
git-branch.txt.

This fixes the failing test added in the previous commit. Also adapt the
test for whether `git branch --set-upstream-to` respects `pager.branch`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-branch.txt | 6 ++++++
 t/t7006-pager.sh             | 6 +++---
 builtin/branch.c             | 3 +++
 git.c                        | 2 +-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index d6587c5e96..df24506e18 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -281,6 +281,12 @@ start-point is either a local or remote-tracking branch.
 	and the object it points at.  The format is the same as
 	that of linkgit:git-for-each-ref[1].
 
+CONFIGURATION
+-------------
+`pager.branch` is only respected when listing branches, i.e., when
+`--list` is used or implied.
+See linkgit:git-config[1].
+
 Examples
 --------
 
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 95547bb8c6..bb4fee3901 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -232,7 +232,7 @@ test_expect_success TTY 'git branch respects --no-pager' '
 	! test -e paginated.out
 '
 
-test_expect_failure TTY 'git branch --edit-description ignores pager.branch' '
+test_expect_success TTY 'git branch --edit-description ignores pager.branch' '
 	rm -f paginated.out editor.used &&
 	write_script editor <<-\EOF &&
 		echo "New description" >"$1"
@@ -243,13 +243,13 @@ test_expect_failure TTY 'git branch --edit-description ignores pager.branch' '
 	test -e editor.used
 '
 
-test_expect_success TTY 'git branch --set-upstream-to respects pager.branch' '
+test_expect_success TTY 'git branch --set-upstream-to ignores pager.branch' '
 	rm -f paginated.out &&
 	git branch other &&
 	test_when_finished "git branch -D other" &&
 	test_terminal git -c pager.branch branch --set-upstream-to=other &&
 	test_when_finished "git branch --unset-upstream" &&
-	test -e paginated.out
+	! test -e paginated.out
 '
 
 # A colored commit log will begin with an appropriate ANSI escape
diff --git a/builtin/branch.c b/builtin/branch.c
index 33fd5fcfd1..9c74689fb0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -675,6 +675,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		copy *= 2;
 	}
 
+	if (list)
+		setup_auto_pager("branch", 0);
+
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
diff --git a/git.c b/git.c
index 9e96dd4090..c870b9719c 100644
--- a/git.c
+++ b/git.c
@@ -372,7 +372,7 @@ static struct cmd_struct commands[] = {
 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
-	{ "branch", cmd_branch, RUN_SETUP },
+	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
 	{ "cat-file", cmd_cat_file, RUN_SETUP },
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
-- 
2.15.0.415.gac1375d7e

