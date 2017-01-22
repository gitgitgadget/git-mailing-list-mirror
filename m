Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A1D2092F
	for <e@80x24.org>; Sun, 22 Jan 2017 22:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750756AbdAVW5z (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 17:57:55 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33574 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdAVW5x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 17:57:53 -0500
Received: by mail-wm0-f65.google.com with SMTP id r144so22135449wme.0
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 14:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hcJIBFr4achMEZmhGpdgpD6BqFnaKSC9M9ombDjb+4I=;
        b=eNYfQ9tNg9R/Ksp7aqJMwKhaUkogh+azAHeXJOQ5iyh9UldjTejvRjxo8H9q5j3Vv2
         B876pe+Xh1Y+vBrN9PUAGOk42wQM0GrI30+hgIKZPk+CrcItGkeYMjm7vE+9WxI6xUm4
         QdpddDq3y4N8+cuYq0HyZR9FNDLsB+uZVjDMAg4siq0+sM5xAXenXAuMNB7lRaJRN4O4
         LXCzGmxvUL8UqF89GFaSFtpncu+KkPpYXKchZYTXD3D3Zu0JxlBr8kbbjujPVkJNAO/o
         sCcPBeAFs7rTz1YB37f1oKHfO0YPADwFgZhThVEuNM9T6UuMv0gy79NIRwsjtZGfZe4o
         IJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hcJIBFr4achMEZmhGpdgpD6BqFnaKSC9M9ombDjb+4I=;
        b=TjMsrN8GdtMKT29RE6Wb9HyU7WMkxl/ane15Mmf7frMqFeStJzrTdJt7aL/q5rWO1P
         BB7TAGt5dxvLnyrN3Zd/WlaJ2UnGu5C+wzUQyPJr94PJffVscniEc9IsgxZwsXDhHJIY
         j4gT/DDFDBN9Da/BbauKkSJ10IuDyCNu5a6NX+dtWaqygZVDLSRNsX2Xt/EMfdbYmiU+
         XkRk5OTJATEaYBNAsyaUPoIjedlN4vLhGzQ+VzKT1jIo3yNDTMvayA7CZ3Fzcyj0IY72
         zclXUBTk7F2vITxdnmtdf4qD/sFjdaNwfG92FqoTb4OVGnh56B2fwNpwuo+znCL5r1td
         X1yA==
X-Gm-Message-State: AIkVDXI5vbWA0eNPeVDBZa5YEKFTARzqiExTHioMJu3aG5oJ+r4FzSrg0hJKC8AfwE6xmw==
X-Received: by 10.223.143.48 with SMTP id p45mr20848965wrb.33.1485125871875;
        Sun, 22 Jan 2017 14:57:51 -0800 (PST)
Received: from localhost.localdomain ([2001:a62:fb:5c01:efe0:5d69:845c:6e94])
        by smtp.gmail.com with ESMTPSA id v201sm6468545wmv.4.2017.01.22.14.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jan 2017 14:57:50 -0800 (PST)
From:   bitte.keine.werbung.einwerfen@googlemail.com
X-Google-Original-From: cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     thomas.braun@virtuell-zuhause.de, szeder@ira.uka.de,
        john@keeping.me.uk, Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH 4/7] completion: teach ls-remote to complete options
Date:   Sun, 22 Jan 2017 23:57:21 +0100
Message-Id: <20170122225724.19360-5-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170122225724.19360-1-cornelius.weig@tngtech.com>
References: <20170122225724.19360-1-cornelius.weig@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

ls-remote needs to complete remote names and its own options. In
addition to the existing remote name completions, do also complete
the options --heads, --tags, --refs, and --get-url.
---
 contrib/completion/git-completion.bash | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 652c7e2..36fe439 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1449,6 +1449,12 @@ _git_ls_files ()
 
 _git_ls_remote ()
 {
+	case "$cur" in
+	--*)
+		__gitcomp "--heads --tags --refs --get-url"
+		return
+		;;
+	esac
 	__gitcomp_nl "$(__git_remotes)"
 }
 
-- 
2.10.2

