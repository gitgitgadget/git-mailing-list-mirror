Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40A11FE90
	for <e@80x24.org>; Thu, 20 Apr 2017 05:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940992AbdDTF5S (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 01:57:18 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35594 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935350AbdDTF5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 01:57:16 -0400
Received: by mail-io0-f195.google.com with SMTP id d203so12474904iof.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 22:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smkent.net; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=pypODPdUEi8fR7ZeBOJiZRMtz4MrFAOEzemVa/1+Pd0=;
        b=ZWfgizio846FfJTpFMr10951gQY4iZTL5CTgqVbuG7sPHHNLCM/+5cu4fv/0chgt4/
         BQbxzfRPI8Iy+eOg80mfoXBTf/yfeS2tIot68Fz5g+/SevBMViOhi8fLb+hFM8d1JOJR
         gZT7C55qhEFqY7SpWPOfOWQX9+GO/t6Zvcb8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pypODPdUEi8fR7ZeBOJiZRMtz4MrFAOEzemVa/1+Pd0=;
        b=kvFrQO0+kaq9/a+ol2IXabRUJE7sTuHVGsF7dd9X7mdb6xtMPG/A92Hpn7a81khrml
         CJgSisgUiraDB6dTXKmA3qxNnqEsUZfBMkstVhlhppW5AEEELQ2VPQtuYGaw94ZYcalG
         Vm7aukn5dQtj0iFIj1Y/ie6JIAjT/4qNSgqo9mMpfZ0G6PSJR8I0fHulGslWE3gh2mTw
         1UR9b/DVZKraeX9FBIz78fvLA6/9y+pfrQgfpryGb4EzFOhrbx+SH22kmvD1dHujaUYL
         MafkITXivgYupfKKBY+3JoBBZA9NAAW75lZ377BM72soAGULj5/r35bWDzSls1B3xuhx
         9j/w==
X-Gm-Message-State: AN3rC/6itQuhVljmSCO0ycFXoZPyo77zovtd04hMdIwhGvkNm9zZSaDn
        09rf3cNSSI41rA==
X-Received: by 10.99.64.69 with SMTP id n66mr6463098pga.197.1492667835756;
        Wed, 19 Apr 2017 22:57:15 -0700 (PDT)
Received: from localhost (c-73-53-29-115.hsd1.wa.comcast.net. [73.53.29.115])
        by smtp.gmail.com with ESMTPSA id p68sm7767394pga.6.2017.04.19.22.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 22:57:14 -0700 (PDT)
Date:   Wed, 19 Apr 2017 22:57:08 -0700
From:   Stephen Kent <smkent@smkent.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH] Add color slots for branch names in "git status --short
 --branch"
Message-ID: <201704556286334.8b7dc718029e6dd189dadb3703bfa@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stephen Kent <smkent@smkent.net>
---
 Documentation/config.txt               | 5 ++++-
 builtin/commit.c                       | 4 ++++
 contrib/completion/git-completion.bash | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874..96e9cf8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1137,7 +1137,10 @@ color.status.<slot>::
 	`untracked` (files which are not tracked by Git),
 	`branch` (the current branch),
 	`nobranch` (the color the 'no branch' warning is shown in, defaulting
-	to red), or
+	to red),
+	`localBranch` or `remoteBranch` (the local and remote branch names,
+	respectively, when branch and tracking information is displayed in the
+	status short-format), or
 	`unmerged` (files which have unmerged changes).
 
 color.ui::
diff --git a/builtin/commit.c b/builtin/commit.c
index 4e288bc..43846d5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1263,6 +1263,10 @@ static int parse_status_slot(const char *slot)
 		return WT_STATUS_NOBRANCH;
 	if (!strcasecmp(slot, "unmerged"))
 		return WT_STATUS_UNMERGED;
+	if (!strcasecmp(slot, "localBranch"))
+		return WT_STATUS_LOCAL_BRANCH;
+	if (!strcasecmp(slot, "remoteBranch"))
+		return WT_STATUS_REMOTE_BRANCH;
 	return -1;
 }
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1150164..f0542b6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2377,7 +2377,9 @@ _git_config ()
 		color.status.added
 		color.status.changed
 		color.status.header
+		color.status.localBranch
 		color.status.nobranch
+		color.status.remoteBranch
 		color.status.unmerged
 		color.status.untracked
 		color.status.updated
-- 
1.9.1

