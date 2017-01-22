Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8E22092F
	for <e@80x24.org>; Sun, 22 Jan 2017 22:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750762AbdAVW56 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 17:57:58 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33586 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbdAVW5y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 17:57:54 -0500
Received: by mail-wm0-f67.google.com with SMTP id r144so22135585wme.0
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 14:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EKXtWGH30UX006uzZ9ehylsZh/ggRmIyXIXsULnO80Q=;
        b=jjSXXRz9Z3mjON3P5Ka/0jm4TUBjeZZSGov6ujT4qSYrm/WZahiI29f0h3irV1c8JI
         pQWgGpck88MZaVqK+5uleOEvdziRTwNU07OE+F7SYbjPCqySI1CQIfdZcOgIcMf6H0Iu
         Oy+YnFrbkyV7vtT8RID0XEFyq7M6fepLJllAwxU5JmlnmppjVO/bmfmc/ZnCgSjTtZLp
         zhjLKWAsFqHVQ7TdIQDJaP0KQIM/iAdKpd9m3RAgSQqA+GzBexoFsJhbGfTvDYH63lQf
         FqmhosXQ9Gd2rt4J9sMNEmq6WP/uXtizXEqFSVx1oi+OSR4dRZavYb2jc8sbCJ7bWLZp
         aHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EKXtWGH30UX006uzZ9ehylsZh/ggRmIyXIXsULnO80Q=;
        b=MCYfH3FTa4b8pF5jVoC/3RXtjH6rbttrdbxGdKJPAUqlsZxZsiW07FyNhgLyrkUfAM
         pdpOQ1Uuu2K/hq4S1tuHBEQdqxX4wlG4GGG+HMSITfqX7/9NzKoPxKEBr0oPOk4npq43
         hWMjrWojjtvDePpgXajJCKiYXlBum42c9vqsjJDLn4ozkUN+5JD5W6wBWmZF5NY5dUJA
         kPpq/uZ/9irxlSc4cHtejEztyutx6PU60Dy4RVGZM2YxlkosCCnalByVNHd9FNC5Vr+A
         pdi5eUzaBmLak9zU2kjHB2JYq8xmLF++ibSgv0PWgvY9ETKXjFxA8lWSSgv6UmszKJzO
         7tog==
X-Gm-Message-State: AIkVDXK2sc+lrqazwjVTbhHPFhPITqr9YsRMcZEVAqCaMis3WD4+jTq8UPNEHqVxMlHy4Q==
X-Received: by 10.223.164.207 with SMTP id h15mr20603102wrb.142.1485125873215;
        Sun, 22 Jan 2017 14:57:53 -0800 (PST)
Received: from localhost.localdomain ([2001:a62:fb:5c01:efe0:5d69:845c:6e94])
        by smtp.gmail.com with ESMTPSA id v201sm6468545wmv.4.2017.01.22.14.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jan 2017 14:57:52 -0800 (PST)
From:   bitte.keine.werbung.einwerfen@googlemail.com
X-Google-Original-From: cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     thomas.braun@virtuell-zuhause.de, szeder@ira.uka.de,
        john@keeping.me.uk, Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH 5/7] completion: teach replace to complete options
Date:   Sun, 22 Jan 2017 23:57:22 +0100
Message-Id: <20170122225724.19360-6-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170122225724.19360-1-cornelius.weig@tngtech.com>
References: <20170122225724.19360-1-cornelius.weig@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Git-replace needs to complete references and its own options. In
addition to the existing references completions, do also complete the
options --edit --graft --format= --list --delete.
---
 contrib/completion/git-completion.bash | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 36fe439..e76cbd7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2408,6 +2408,12 @@ _git_remote ()
 
 _git_replace ()
 {
+	case "$cur" in
+	--*)
+		__gitcomp "--edit --graft --format= --list --delete"
+		return
+		;;
+	esac
 	__gitcomp_nl "$(__git_refs)"
 }
 
-- 
2.10.2

