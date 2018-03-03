Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D991F404
	for <e@80x24.org>; Sat,  3 Mar 2018 03:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbeCCDsp (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 22:48:45 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44179 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeCCDso (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 22:48:44 -0500
Received: by mail-pl0-f66.google.com with SMTP id 9-v6so1294741ple.11
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 19:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2DawuETD9zWMFtTht84lom16un8wp1w0VcUBv0gR+Nk=;
        b=CL0AfvjyPRx3KixrPhX7jpWFTu5gXOJKKTiGV6oJsoCLhzuVMtenWwGndzcDRiuzVi
         bIEZ18mFsI4/d+vswWdDkc6yUdDjfz1Hw/7OjmfGmuU6TBuhliEBdYrvtPp99T8oTZ88
         1Gw1eW9my/kYuU77znhL3jCimHs/XWiY5X6+GYEIRrosYBxfV2qpNFWvL0oHXmKoyIel
         sw0DhXdILvOuvSUyKnPSWP/wDnnif+thYovRjctbOBVYy1yvlfbJ0qQ4iJtMqcMOre27
         oluDP2SajIZRCSxQLI8t6pksSxWuCOi/qpJ+nrYGn6rGLArSfG0Ue2JKrq3V82jn9WAe
         DSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2DawuETD9zWMFtTht84lom16un8wp1w0VcUBv0gR+Nk=;
        b=nJY4lF/lIK4wkhXumI2PeGVzOGXpEVYB0vbUd+DYORVz055v0mOJG6S/c5U5WHz2PL
         eVG/k7bEA1Wm4umeZzJQ2UtuvTr8oFX6t92GoeMWMo1NZWQZQv03TyH/0YrrSRC4nhYZ
         IzN/4RGRTQDPEvbLuHrqf/JlcgkiqAfB0c74817mJ0VU855YHDRocOVC2tPrphrD3YUe
         5mIu//suNMDKIXZ5PnHPmZmtC6CKoV7p1/KKBz7oR08dktOh9juX/olruU2NUrB3RuKR
         VCtTK94qta8UZ/fq2A4CT7URtXjFxd+5UxK9I+Q3L4ni0lgRBuFuPZWOeJAVnw3EdFzc
         j13w==
X-Gm-Message-State: APf1xPBOUTrwV48a53AH0sVPH9hGvT8G59mD0+Ndpg2xasUqMTPD1Ul8
        VVJc21u8U3Yj660T2WjW3KDZU6R5
X-Google-Smtp-Source: AG47ELvvbIPAWzSTjxkiizOS1WOFOLS7R8VtqzPdL2/4Hs3KDi/q4ZdCbWDGpyI3ZgMd3RRUi4+JBQ==
X-Received: by 2002:a17:902:6b83:: with SMTP id p3-v6mr7118938plk.18.1520048923645;
        Fri, 02 Mar 2018 19:48:43 -0800 (PST)
Received: from Dorabs-iMac.com (cpe-23-242-199-161.socal.res.rr.com. [23.242.199.161])
        by smtp.gmail.com with ESMTPSA id 205sm15721775pfw.88.2018.03.02.19.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Mar 2018 19:48:42 -0800 (PST)
From:   Dorab Patel <dorabpatel@gmail.com>
To:     git@vger.kernel.org
Cc:     Alexandre Julliard <julliard@winehq.org>,
        Dorab Patel <dorabpatel@gmail.com>
Subject: [PATCH] git.el: handle default excludesfile properly
Date:   Fri,  2 Mar 2018 19:48:03 -0800
Message-Id: <20180303034803.21589-1-dorabpatel@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous version only looked at core.excludesfile for locating the
excludesfile.  So, when core.excludesfile was not defined, it did not
use the possible default locations.

The current version uses either $XDG_CONFIG_HOME/git/ignore or
$HOME/.config/git/ignore for the default excludesfile location
depending on whether XDG_CONFIG_HOME is defined or not.  As per the
documentation of gitignore.

Signed-off-by: Dorab Patel <dorabpatel@gmail.com>
---
 contrib/emacs/git.el | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 97919f2d7..16c6b4c05 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -757,8 +757,12 @@ Return the list of files that haven't been handled."
 
 (defun git-get-exclude-files ()
   "Get the list of exclude files to pass to git-ls-files."
-  (let (files
-        (config (git-config "core.excludesfile")))
+  (let* (files
+	 (defaultconfig (if (getenv "XDG_CONFIG_HOME")
+			    (concat (file-name-as-directory (getenv "XDG_CONFIG_HOME")) "git/ignore")
+			  (concat (file-name-as-directory (getenv "HOME")) ".config/git/ignore")))
+	 (coreexcludes (git-config "core.excludesfile"))
+	 (config (if coreexcludes coreexcludes defaultconfig)))
     (when (file-readable-p ".git/info/exclude")
       (push ".git/info/exclude" files))
     (when (and config (file-readable-p config))
-- 
2.16.2

