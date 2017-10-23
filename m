Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 901B8202A2
	for <e@80x24.org>; Mon, 23 Oct 2017 17:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbdJWRGB (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 13:06:01 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:53535 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbdJWRF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 13:05:59 -0400
Received: by mail-qt0-f195.google.com with SMTP id n61so27005885qte.10
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 10:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wy/Ch3aooRHa29rlWLMfV674hGg6mPZe0jwOrN3dYPo=;
        b=qqGPgEE35TGFEr3cj4EvtXSeaPkXEhh6ZB4gAWbyFmbrmx+4wuJig0Wn3rVCWQVutN
         nskDTsCyxcHJobOel/nGTmAOplQtl/LODw+HYJMJ87T7QFTtoFN8HChIlutWDvsGQ3Al
         ctZ3gD+BSd95R9QCeCry2ZlUkLKAf5KlAV4Qe97nilsw8pNnzrUdLg6aFYgHq+1idWsI
         W4zIloPHBDx29x51Ha82zYSt3i1jUeIWQ2RRlLhSuf3ReP6Spu2psMuRmtl8M18vq9Dx
         jUg1LB4cGRtxXjX/f8CYjr34bz0FVoDH0rslvp4mHQCezfShAPDaOowujSf+e76GE8K8
         CyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wy/Ch3aooRHa29rlWLMfV674hGg6mPZe0jwOrN3dYPo=;
        b=JkDfj5KB7/UUXoRxuJ44qrKp7RHdZ+2HgiZmiSnRR/HwZnwp9Dy2QVLQ/yqEZk9hzp
         MfmTRYiXmIPrxafdrB4gdiEpVkHKRUPtJr5bQ5J03/kJ/T/wiseqUJ337pB0axSC01+G
         FPeXQ4BrA/+7BEnUOrJm8dy7yHFSxkWdn8eVFWLSaCCTzSyWEhxh4q/kXvI9aJh+e2Un
         hCAYJCMQ5wUbGBCQ3Wj9CooPuuAij4loCqVWkXQBhLHJnV0j/Bpwk4q6K3Mv2ktMRzOY
         OdavPlNGa9jJh1VG3pohptJXijTdaQvZgngjpUt2Hd1dtDV+UyyUV3/w05EoDITEu+2b
         8EYw==
X-Gm-Message-State: AMCzsaVTNo24xmCiz76aueH1S6XuKdNZ5u8jlX0fX2vWwcV1/qmByTiQ
        N/0zTrumRB0sa9PxqwjQX7s=
X-Google-Smtp-Source: ABhQp+QAKuzVZEwPSu+4ldv2aHfrkrJo4ERlskT61bgH47FyMPZsl7umqC4hwFK6NJrEZdX8bOFWaA==
X-Received: by 10.200.44.46 with SMTP id d43mr21564328qta.283.1508778358935;
        Mon, 23 Oct 2017 10:05:58 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id p64sm4885397qkd.67.2017.10.23.10.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 10:05:58 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v4 3/4] status: document options to show matching ignored files
Date:   Mon, 23 Oct 2017 13:05:33 -0400
Message-Id: <20171023170534.157740-4-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171023170534.157740-1-jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171023170534.157740-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 Documentation/git-status.txt                      | 21 +++++++++++++++++-
 Documentation/technical/api-directory-listing.txt | 27 +++++++++++++++++++----
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 9f3a78a36c..fc282e0a92 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -97,8 +97,27 @@ configuration variable documented in linkgit:git-config[1].
 	(and suppresses the output of submodule summaries when the config option
 	`status.submoduleSummary` is set).
 
---ignored::
+--ignored[=<mode>]::
 	Show ignored files as well.
++
+The mode parameter is used to specify the handling of ignored files.
+It is optional: it defaults to 'traditional'.
++
+The possible options are:
++
+	- 'traditional' - Shows ignored files and directories, unless
+			  --untracked-files=all is specifed, in which case
+			  individual files in ignored directories are
+			  displayed.
+	- 'no'	        - Show no ignored files.
+	- 'matching'    - Shows ignored files and directories matching an
+			  ignore pattern.
++
+When 'matching' mode is specified, paths that explicity match an
+ignored pattern are shown. If a directory matches an ignore pattern,
+then it is shown, but not paths contained in the ignored directory. If
+a directory does not match an ignore pattern, but all contents are
+ignored, then the directory is not shown, but all contents are shown.
 
 -z::
 	Terminate entries with NUL, instead of LF.  This implies
diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
index 6c77b4920c..7fae00f44f 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -22,16 +22,20 @@ The notable options are:
 
 `flags`::
 
-	A bit-field of options (the `*IGNORED*` flags are mutually exclusive):
+	A bit-field of options:
 
 `DIR_SHOW_IGNORED`:::
 
-	Return just ignored files in `entries[]`, not untracked files.
+	Return just ignored files in `entries[]`, not untracked
+	files. This flag is mutually exclusive with
+	`DIR_SHOW_IGNORED_TOO`.
 
 `DIR_SHOW_IGNORED_TOO`:::
 
-	Similar to `DIR_SHOW_IGNORED`, but return ignored files in `ignored[]`
-	in addition to untracked files in `entries[]`.
+	Similar to `DIR_SHOW_IGNORED`, but return ignored files in
+	`ignored[]` in addition to untracked files in
+	`entries[]`. This flag is mutually exclusive with
+	`DIR_SHOW_IGNORED`.
 
 `DIR_KEEP_UNTRACKED_CONTENTS`:::
 
@@ -39,6 +43,21 @@ The notable options are:
 	untracked contents of untracked directories are also returned in
 	`entries[]`.
 
+`DIR_SHOW_IGNORED_TOO_MODE_MATCHING`:::
+
+	Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if
+	this is set, returns ignored files and directories that match
+	an exclude pattern. If a directory matches an exclude pattern,
+	then the directory is returned and the contained paths are
+	not. A directory that does not match an exclude pattern will
+	not be returned even if all of its contents are ignored. In
+	this case, the contents are returned as individual entries.
++
+If this is set, files and directories that explicity match an ignore
+pattern are reported. Implicity ignored directories (directories that
+do not match an ignore pattern, but whose contents are all ignored)
+are not reported, instead all of the contents are reported.
+
 `DIR_COLLECT_IGNORED`:::
 
 	Special mode for git-add. Return ignored files in `ignored[]` and
-- 
2.13.6

