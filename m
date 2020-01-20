Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76614C32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 21:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC5B22527
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 21:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovUc/2px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgATVRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 16:17:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40125 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgATVRT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 16:17:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so804948wmi.5
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 13:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hznTf6HV8XtiNQNC5Eh2EgVT6lJ2vCswf79N90ip/MQ=;
        b=ovUc/2pxtH1qP7ekAooKPXhgMTw1XqJD/DmYdQAYIysuyU5TMoJH8aO9T6A5BQR3gW
         R8DqBkUUgrALS24DCwmenp4QKOw6x7XlXp57Rn2SSJZdrAf5tw8VY3xNW8Eb/b7V+w0R
         oiLlxt4uFalG9Yx8KSVOVsjHPo1Jyk6sN16o0iHMp9LBIKvycQmkaxrC/EwT3FTeuqC0
         CZFr3erGRv+HTyoanjiSCQZW29Bgi156cF49Gs5BQ5uQIzqAZmMb9MClrAobWg0LL+sL
         KqHbaAc3WJHz9UYqAXGRgjRlTq8b8p/P9P5iXN6D3elnBixI2uf2+MXm7AQdbOGlF7/V
         dY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hznTf6HV8XtiNQNC5Eh2EgVT6lJ2vCswf79N90ip/MQ=;
        b=XczzMYzXGyZhFpxRJYC4spXK1MpJCgMILUgihXjRRIfGgBkYqsi2Xc30N5TgMphu62
         FwAxeirzePLB+xbgeCD21dXNR0RwyaX0w/WqzUkSRBxs58HJrqva7ZXdiDsCTbPbJsD3
         GKQxO1trUY6hShiG7+A84QkAujHvwJNNGwXOFFHseM9nmzp4l26/wpzfElulJ3hqfkQl
         nPGLXX+H620KV5OFKHRUjQdQWMgetvD4Yy/OcbkYZ9j+tq3I8FuP5CCbXRSuh9H4lzSo
         vBtbV+XDPTaKtOlZLP9feOsKb8WFBFGreB6yTSI6T43awg+5nmXCQPM53XoyPxSrJvzj
         DTxg==
X-Gm-Message-State: APjAAAXtWRFGcH+6OfKUWkApYO+BuLmE6OF3HDq1fYK0LiyV/sgMlMzd
        jrX95SurzYO3WllU3HMgBN72/0Bo
X-Google-Smtp-Source: APXvYqy0KWKhVvkelZzATFOAMPj/tOBepzFj5cXLKP2EkHaKwqWRwPzmEM3nKXrhlNsuRTgVfFrk6Q==
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr713557wma.139.1579555037229;
        Mon, 20 Jan 2020 13:17:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm755022wmm.15.2020.01.20.13.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 13:17:16 -0800 (PST)
Message-Id: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Jan 2020 21:17:16 +0000
Subject: [PATCH] git-p4: Add hook p4-pre-pedit-changelist
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

Add an additional hook to the git-p4 command to allow a hook to modify
the text of the changelist prior to displaying the p4editor command.

This hook will be called prior to checking for the flag
"--prepare-p4-only".

The hook is optional, if it does not exist, it will be skipped.

The hook takes a single parameter, the filename of the temporary file
that contains the P4 submit text.

The hook should return a zero exit code on success or a non-zero exit
code on failure.  If the hook returns a non-zero exit code, git-p4
will revert the P4 edits by calling p4_revert(f) on each file that was
flagged as edited and then it will return False so the calling method
may continue as it does in existing failure cases.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
    git-p4: Add hook p4-pre-pedit-changelist
    
    Our company's workflow requires that our P4 check-in messages have a
    specific format. A helpful feature in the GIT-P4 program would be a hook
    that occurs after the P4 change list is created but before it is
    displayed in the editor that would allow an external program to possibly
    edit the changelist text.
    
    My suggestion for the hook name is p4-pre-edit-changelist.
    
    It would take a single parameter, the full path of the temporary file.
    If the hook returns a non-zero exit code, it would cancel the current P4
    submit.
    
    The hook should be optional.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-698%2Fseraphire%2Fseraphire%2Fp4-hook-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-698/seraphire/seraphire/p4-hook-v1
Pull-Request: https://github.com/git/git/pull/698

 git-p4.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 40d9e7c594..1f8c7383df 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2026,6 +2026,17 @@ def applyCommit(self, id):
         tmpFile.write(submitTemplate)
         tmpFile.close()
 
+        # Run the pre-edit hook to allow programmatic update to the changelist
+        hooks_path = gitConfig("core.hooksPath")
+        if len(hooks_path) <= 0:
+            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
+
+        hook_file = os.path.join(hooks_path, "p4-pre-edit-changelist")
+        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file, fileName]) != 0:
+            for f in editedFiles:
+                p4_revert(f)
+            return False
+
         if self.prepare_p4_only:
             #
             # Leave the p4 tree prepared, and the submit template around

base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
-- 
gitgitgadget
