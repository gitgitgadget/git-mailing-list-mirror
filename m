Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04602C54EB4
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 06:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjAVGMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 01:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAVGMs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 01:12:48 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4520DD51D
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so8508452wmb.0
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TELS1RC3bPR/JOiEBxfSoYL+GhZIw/AaeR38ux0uFNg=;
        b=VzfTzxpeK+rnCv+aixXORg/zSfyVvpHJW5ZAREJLflDpk5CGh9fBHvsDXkmlcuYagz
         hUoX7RIqTB4JCUW3406R5NFNtGTLbWxortNWbthLFxBhMgdNC439VHhXgUx37E0LNrv4
         msUz/JY+v91pRhr7PHDaUkgkqkAX51rUVTzQiT3mPap7TkECgW6E4FSP7pAY67y+Svrc
         fN0+yX9pNC8DbebCxIufAlw+K/eM7Vi9fOJaUZhVUIpXXjekqPEArnQzu2uVSRcN4Aq/
         +wgyiW8iVrqyFfbdOCxJ5g7XDOB7QcKpZbqHw6IA0++HFhIkfbd6oOEfmMjvxziZCgXN
         zjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TELS1RC3bPR/JOiEBxfSoYL+GhZIw/AaeR38ux0uFNg=;
        b=Frgsw4TuuoL6x6Ad4A0b+Il6gdpubmhSYq4bC9Fv0ikeJv9i5dg75xvHJMAEXOkPhE
         bOGf2peXlSUyW1puoNrYfsdsNtnvCqcRbtZg23uiUD2xczHySDGBq3jJrLhc+PyN4oau
         CTIEUWTzYOpQMSkPEElgV6tDKEYnlsM08sprb1Srjmo4WYJpO6bn0xYW2sr7/MuUdN0s
         CAIZb9u0sTC0+eSm8826QpmeHrSUY7H8jDJOlUW5yqu3UbDGH/9r6Wq25jlo3Mr4VOUl
         JKEPYkQCfnSLK+NLaRii/+0G1ctBBzkcwaRFdipAATINrCquAg3zS5c/JK6aeMaYzGrN
         v9gA==
X-Gm-Message-State: AFqh2krDjwE1LoW2y7RWlqY8ASfFO4jyxpcD/ZUDazzRoTOgep/YwsXs
        PNwVlpn+8S1k4uMe0KwCpi1bFA7WAsg=
X-Google-Smtp-Source: AMrXdXvNQjKNj9DckQTNorTQxRDNQXrlAcNdF4qy71bPNQ4ZDSFsQrnULBWz4JUX7a+LTWw8PGP1nA==
X-Received: by 2002:a05:600c:d2:b0:3da:f475:6480 with SMTP id u18-20020a05600c00d200b003daf4756480mr19746361wmm.7.1674367963498;
        Sat, 21 Jan 2023 22:12:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x15-20020a05600c188f00b003db122d5ac2sm6742384wmp.15.2023.01.21.22.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 22:12:42 -0800 (PST)
Message-Id: <8a676e6ec1a30a0220ca0d222211a4cdbf0646a2.1674367961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
        <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Jan 2023 06:12:32 +0000
Subject: [PATCH v4 1/9] rebase: mark --update-refs as requiring the merge
 backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

--update-refs is built in terms of the sequencer, which requires the
merge backend.  It was already marked as incompatible with the apply
backend in the git-rebase manual, but the code didn't check for this
incompatibility and warn the user.  Check and error now.

While at it, fix a typo in t3422...and fix some misleading wording
(most options which used to be am-specific have since been implemented
in the merge backend as well).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt           |  2 ++
 builtin/rebase.c                       |  3 +++
 t/t3422-rebase-incompatible-options.sh | 15 ++++++++++-----
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index d811c1cf443..6490bc96a15 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -630,6 +630,8 @@ start would be overridden by the presence of
 +
 If the configuration variable `rebase.updateRefs` is set, then this option
 can be used to override and disable this setting.
++
+See also INCOMPATIBLE OPTIONS below.
 
 INCOMPATIBLE OPTIONS
 --------------------
diff --git a/builtin/rebase.c b/builtin/rebase.c
index a26cc0cfdb5..c111b89e137 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1492,6 +1492,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (options.update_refs)
+		imply_merge(&options, "--update-refs");
+
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
 			imply_merge(&options, "--merge");
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 6dabb05a2ad..9da39cd91c2 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -25,11 +25,11 @@ test_expect_success 'setup' '
 '
 
 #
-# Rebase has lots of useful options like --whitepsace=fix, which are
-# actually all built in terms of flags to git-am.  Since neither
-# --merge nor --interactive (nor any options that imply those two) use
-# git-am, using them together will result in flags like --whitespace=fix
-# being ignored.  Make sure rebase warns the user and aborts instead.
+# Rebase has a couple options which are specific to the apply backend,
+# and several options which are specific to the merge backend.  Flags
+# from the different sets cannot work together, and we do not want to
+# just ignore one of the sets of flags.  Make sure rebase warns the
+# user and aborts instead.
 #
 
 test_rebase_am_only () {
@@ -60,6 +60,11 @@ test_rebase_am_only () {
 		test_must_fail git rebase $opt --exec 'true' A
 	"
 
+	test_expect_success "$opt incompatible with --update-refs" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --update-refs A
+	"
+
 }
 
 test_rebase_am_only --whitespace=fix
-- 
gitgitgadget

