Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D09642092F
	for <e@80x24.org>; Sun, 22 Jan 2017 22:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750774AbdAVW6H (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 17:58:07 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36610 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdAVW6G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 17:58:06 -0500
Received: by mail-wm0-f68.google.com with SMTP id r126so22108337wmr.3
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 14:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xbjK8i6K2hNMdHybLB7hG+QXff7141aaFo7tRFRb0x8=;
        b=DrcYghRswEFWfRnqEVebEradrqu+r/BY4nKDZe3goYm0yUNgMhpqZ+Mjk3PH/pd2td
         F9GXRljjvLfUs2K4lo+32Tj5Fk9gwKSoHGmptJDhUyVkrnScJOP/ug5pz7dkgj98ogMU
         q/c+SmxgkU8cJftnlazLUj/tS0twwRsstibJ93Moir8pOc1NNBGn+eWwT4aUo5pkOAUk
         J4kDYvaae2od4rNC04Ip2GI3rvmTVwunDXIwq2vdqDE5nA/QQIA8Brefmk/0WeBAJCHH
         spixV5O50bqpV94ZOjtyT/qiTJAKl2b8zVlhtsVLcmXDFa8s7dnxRheX86zgd4NZikHt
         QHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xbjK8i6K2hNMdHybLB7hG+QXff7141aaFo7tRFRb0x8=;
        b=gDpu1IU3JZ2ycDKQxAkemJ5C+V9jwhc+QXqN4x8zYMDXHMAaAjDciGQ/Tl/fNzZUte
         7dqjQG/2ulEMdvHz31q3h8awcFF67pyOMfT3NPMvqiGe8ZWDQZBtbV8dsgMZN+ea8ZRC
         5XrsIjsiHaqavnsxHk3aZGp1K+QJ4uk5ZUYn9rMLPPYFahBWy1/7C59FcqqblQVIQbrC
         QKhG7wwJPnYK2XWivyxZQSw3XGBg4tuL8r+l+wvdAnMooEBYAqMifKDcYgqUigi90gDL
         Ucaxmzi1fqcLJNMUZ9U31R7G8yswMlOvSNckZhKFKov9dF5bwzuipOq3CbHNa/UXsTrV
         evEA==
X-Gm-Message-State: AIkVDXJ6X7oSyWyUrvjaLAzf6I6UJo0ED0y7BC5Asf3nFwq/qsosENdqfMa70bpQnWlEEw==
X-Received: by 10.223.143.45 with SMTP id p42mr20192159wrb.120.1485125874732;
        Sun, 22 Jan 2017 14:57:54 -0800 (PST)
Received: from localhost.localdomain ([2001:a62:fb:5c01:efe0:5d69:845c:6e94])
        by smtp.gmail.com with ESMTPSA id v201sm6468545wmv.4.2017.01.22.14.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jan 2017 14:57:53 -0800 (PST)
From:   bitte.keine.werbung.einwerfen@googlemail.com
X-Google-Original-From: cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     thomas.braun@virtuell-zuhause.de, szeder@ira.uka.de,
        john@keeping.me.uk, Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH 6/7] completion: teach remote subcommands option completion
Date:   Sun, 22 Jan 2017 23:57:23 +0100
Message-Id: <20170122225724.19360-7-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170122225724.19360-1-cornelius.weig@tngtech.com>
References: <20170122225724.19360-1-cornelius.weig@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Git-remote needs to complete remote names, its subcommands, and options
thereof. In addition to the existing subcommand and remote name
completion, do also complete the options

 - add: --track --master --fetch --tags --no-tags --mirror=
 - set-url: --push --add --delete
 - get-url: --push --all
 - prune: --dry-run
---
 contrib/completion/git-completion.bash | 36 +++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e76cbd7..0e09519 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2384,24 +2384,46 @@ _git_config ()
 
 _git_remote ()
 {
-	local subcommands="add rename remove set-head set-branches set-url show prune update"
+	local subcommands="
+		add rename remove set-head set-branches
+		get-url set-url show prune update
+		"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
-		__gitcomp "$subcommands"
+		case "$cur" in
+		--*)
+			__gitcomp "--verbose"
+			;;
+		*)
+			__gitcomp "$subcommands"
+			;;
+		esac
 		return
 	fi
 
-	case "$subcommand" in
-	rename|remove|set-url|show|prune)
-		__gitcomp_nl "$(__git_remotes)"
+	case "$subcommand,$cur" in
+	add,--*)
+		__gitcomp "--track --master --fetch --tags --no-tags --mirror="
 		;;
-	set-head|set-branches)
+	add,*)
+		;;
+	set-head,*|set-branches,*)
 		__git_complete_remote_or_refspec
 		;;
-	update)
+	update,*)
 		__gitcomp "$(__git_get_config_variables "remotes")"
 		;;
+	set-url,--*)
+		__gitcomp "--push --add --delete"
+		;;
+	get-url,--*)
+		__gitcomp "--push --all"
+		;;
+	prune,--*)
+		__gitcomp "--dry-run"
+		;;
 	*)
+		__gitcomp_nl "$(__git_remotes)"
 		;;
 	esac
 }
-- 
2.10.2

