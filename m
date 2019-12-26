Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5681EC2D0DC
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 19:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E782080D
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 19:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H09lc6Q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfLZTCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 14:02:00 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:37468 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfLZTB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 14:01:59 -0500
Received: by mail-ed1-f45.google.com with SMTP id cy15so23482995edb.4
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 11:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=96MUwtZu6NPDxyV7ei3g6CI/Wmwxa1h/TSlAOIf15N8=;
        b=H09lc6Q4iM0hsFO/PCDYSYpDTcT1V4EqzqRUqVJ6NW1p0VWnaeiB21hGyWgZVrGWJa
         G8F74aYNkGT3JJMJAaaiDUcD3OgkayZ1Ddq+ywR3vvpOfbOATlEF2j1xl28X8Ra6/9DN
         ApsXUuK1Nw/66AT7VOEp6fVgylzcHKdOfWEyDF/BHk1OQ8QgvUlTlk4I4xKvpUhUVdI1
         QkFTWYxq6yJCA7PbZRAqczE1+TniFhavp+QYzrXc7UEYxAAB++RymSfa4U/jf3mHuS1z
         G3Y8OFSmC6tAr2zGTXoJcULSgu82mlsZOHOod7+2410O8T9gwCpbV97E4UAdkJDFS3Hp
         IO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=96MUwtZu6NPDxyV7ei3g6CI/Wmwxa1h/TSlAOIf15N8=;
        b=kA5sT0nFaPW6CyR2251/C7/f2Q/f75kKUsLvl0cULDJqWnl5lXyHMX4bCddK+zlMVd
         dkvk/Yup7Uu1JE3BLtUDpb2eU+2gJEBvuwrJxexaICzzN42zPyEpBDai9Mvncz56yI1g
         +saq8iF7Jzc4Vou3XdxcyXfsphHEePGlckhd5pIXTNGeHKQN9y9AimjFrql4obxo6MYw
         6K/nzau+8RuDIEA1ErXRP2Ob4n5MQImoxlwtpChVTokG8ws6mWralMHUxigPMmQS5het
         1Dnd530+6uH2IbUsjMJ7IXcKQJ5mnhv1ifvhbG/yfRfrco84d4jOLrgMOF+vIKuDiPB4
         bHLg==
X-Gm-Message-State: APjAAAVvnDXe1YZugBw/2kU8j1+znZpmLLi+S4NkmaoGQpz21mdGDdk2
        3WsF6iRcKqgduQo6A6VusNQqiYhc
X-Google-Smtp-Source: APXvYqw4OFZ8F5Y6oQ2MYd4iydrDHy4nmc1cfT2CFpmr4x3BK30v6ZQk1iAI4EEzQmn8u3fw8dSJGA==
X-Received: by 2002:a50:eb95:: with SMTP id y21mr51121236edr.212.1577386917604;
        Thu, 26 Dec 2019 11:01:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm3767412ejm.1.2019.12.26.11.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Dec 2019 11:01:57 -0800 (PST)
Message-Id: <fce80f1b95f83915076640ca0be01aa473744777.1577386915.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.499.git.1577386915.gitgitgadget@gmail.com>
References: <pull.499.git.1577386915.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Zoli=20Szab=C3=B3?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 26 Dec 2019 19:01:55 +0000
Subject: [PATCH 1/1] git-gui: add possibility to open currently selected file
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        =?UTF-8?q?Zoli=20Szab=C3=B3?= <zoli.szabo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Zoli=20Szab=C3=B3?= <zoli.szabo@gmail.com>

...in the default associated app (e.g. in a text editor / IDE).

Many times there's the need to quickly open a source file (the one you're
looking at in Git GUI) in the predefined text editor / IDE. Of course,
the file can be searched for in your preferred file manager or directly
in the text editor, but having the option to directly open the current
file from Git GUI would be just faster. This change enables just that by:
 - Diff header path context menu -> Open;
 - or double-clicking the diff header path.

One "downside" of the approach is that executable files will be run
and not opened for editing.

Signed-off-by: Zoli Szabó <zoli.szabo@gmail.com>
---
 git-gui.sh | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index c1be733e3e..705b97f7ab 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2248,8 +2248,8 @@ proc do_git_gui {} {
 	}
 }
 
-proc do_explore {} {
-	global _gitworktree
+# Get the system-specific explorer app/command.
+proc get_explorer {} {
 	set explorer {}
 	if {[is_Cygwin] || [is_Windows]} {
 		set explorer "explorer.exe"
@@ -2259,9 +2259,25 @@ proc do_explore {} {
 		# freedesktop.org-conforming system is our best shot
 		set explorer "xdg-open"
 	}
+	return $explorer
+}
+
+proc do_explore {} {
+	global _gitworktree
+	set explorer [get_explorer]
 	eval exec $explorer [list [file nativename $_gitworktree]] &
 }
 
+# Trigger opening a file (relative to the working tree) by the default
+# associated app of the OS (e.g. a text editor or IDE).
+# FIXME: What about executables (will be run, not opened for editing)?
+proc do_file_open {file} {
+	global _gitworktree
+	set explorer [get_explorer]
+	set full_file_path [file join $_gitworktree $file]
+	eval exec $explorer [list [file nativename $full_file_path]] &
+}
+
 set is_quitting 0
 set ret_code    1
 
@@ -3530,8 +3546,14 @@ $ctxm add command \
 			-type STRING \
 			-- $current_diff_path
 	}
+$ctxm add command \
+	-label [mc Open] \
+	-command {
+		do_file_open $current_diff_path
+	}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 bind_button3 .vpane.lower.diff.header.path "tk_popup $ctxm %X %Y"
+bind .vpane.lower.diff.header.path <Double-1> {do_file_open $current_diff_path}
 
 # -- Diff Body
 #
-- 
gitgitgadget
