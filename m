Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B3872092F
	for <e@80x24.org>; Sun, 22 Jan 2017 22:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750744AbdAVW5t (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 17:57:49 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35459 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdAVW5s (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 17:57:48 -0500
Received: by mail-wm0-f68.google.com with SMTP id d140so22157713wmd.2
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 14:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XU4U+uNLE62YWG34YvqSYIzKoIapv1mD+utMF6hEfq4=;
        b=jW/OltAnCPryMiaktnDuYgwE6PGXUoFajLFUbAJM2eZ/R3cKC9qnw+0ArhRTpEgi8t
         ZnYDzwXDZ6S3dNAJyRTPK6xfaHA5zS24oLQFhtZd8XCVp4tVQmrqnEWjekBHvtGBwI36
         GyOOqy1czo/aZpWKiapxHH3IRpDP0SFRItbLiAXKcGADdqzIgBwgxRAb3pqANSPHEBcv
         8hyTcanQj2gQiFyglLlGFn66JN5spYVFIsgzFU3wAHOGE/EAQ9qL0MdVGw8iY87k+DY+
         ZWzw6YT0wXR3Hp8GmitfHjEXgUxZRotaD5RPpQLOCeAUgLvxgFCPdlMx5HVM6cyxYW4I
         YdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XU4U+uNLE62YWG34YvqSYIzKoIapv1mD+utMF6hEfq4=;
        b=cw0lY1BMbUzTBKZ/XxhotzhElETFjnEpEujMu6zrUoptV0K8XAa1MmdjIZAQHg99G/
         hyDlHd5Scglb3MXfMszO0dkOpCV4ojnYDt766sRViklKdjRIKAsrAfuJ9lPZQqgjbPQR
         X58WX/sXKVw6xSkkIy1sb9KjKT4V+AQ5N5R2VqqqPD7yZRxn4VQFGULq3RxdavYb7MK1
         a0TDnmhnt17KRXBS3OL8SHrcViDEcKkS3WFGPaDjYdmCqXlpMWCJ/7hTJUAkDiC1KD7E
         MhQZR5RfoSYbGK9JS9nJ4C8LKsigz8BRsKRkQNSSUPeZ6XIqmybnvMQE4xRqrHAFzpVA
         PMUQ==
X-Gm-Message-State: AIkVDXKub2jgm+Uu5oTaOtTuBUvCPSfgKFLimilBdn26wxkFSklJqVDH+P4Tqj/e02FqMw==
X-Received: by 10.28.65.132 with SMTP id o126mr10645606wma.14.1485125867069;
        Sun, 22 Jan 2017 14:57:47 -0800 (PST)
Received: from localhost.localdomain ([2001:a62:fb:5c01:efe0:5d69:845c:6e94])
        by smtp.gmail.com with ESMTPSA id v201sm6468545wmv.4.2017.01.22.14.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jan 2017 14:57:46 -0800 (PST)
From:   bitte.keine.werbung.einwerfen@googlemail.com
X-Google-Original-From: cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     thomas.braun@virtuell-zuhause.de, szeder@ira.uka.de,
        john@keeping.me.uk, Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH 1/7] completion: teach options to submodule subcommands
Date:   Sun, 22 Jan 2017 23:57:18 +0100
Message-Id: <20170122225724.19360-2-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170122225724.19360-1-cornelius.weig@tngtech.com>
References: <20170122225724.19360-1-cornelius.weig@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

The subcommands of submodule have different long-options which command
line users need to type in. Therefore, teach bash completion to support
most subcommand options for submodule.
---
 contrib/completion/git-completion.bash | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6721ff8..c54a557 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2556,10 +2556,11 @@ _git_submodule ()
 	__git_has_doubledash && return
 
 	local subcommands="add status init deinit update summary foreach sync"
-	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
+	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	if [ -z "$subcommand" ]; then
 		case "$cur" in
 		--*)
-			__gitcomp "--quiet --cached"
+			__gitcomp "--quiet"
 			;;
 		*)
 			__gitcomp "$subcommands"
@@ -2567,6 +2568,33 @@ _git_submodule ()
 		esac
 		return
 	fi
+
+	case "$subcommand,$cur" in
+	add,--*)
+		__gitcomp "--branch --force --name --reference --depth"
+		;;
+	status,--*)
+		__gitcomp "--cached --recursive"
+		;;
+	deinit,--*)
+		__gitcomp "--force --all"
+		;;
+	update,--*)
+		__gitcomp "
+			--init --remote --no-fetch
+			--recommend-shallow --no-recommend-shallow
+			--force --rebase --merge --reference --depth --recursive --jobs
+		"
+		;;
+	summary,--*)
+		__gitcomp "--cached --files --summary-limit"
+		;;
+	foreach,--*|sync,--*)
+		__gitcomp "--recursive"
+		;;
+	*)
+		;;
+	esac
 }
 
 _git_svn ()
-- 
2.10.2

