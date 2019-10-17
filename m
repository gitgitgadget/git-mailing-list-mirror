Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748D81F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 17:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440561AbfJQRfS (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 13:35:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34957 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440533AbfJQRfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 13:35:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10so2904264wrb.2
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 10:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ZxWWZTh6SOLlkJcWKVcdgxdqVOdzBSFhTdJi+uvz7M=;
        b=vCiu2LXmKbVlRL297vXbWrrVZJd4ftHG4VtN7D2gxN6RzLkPNk3/9aCCVUwf0tZ3cQ
         0Fk4cUzIPaMwAM0s1CbQPGZlIPLKoJL91s1T0GYW7iwb9qjdrR7JgGuKLZgkMq1kQaFk
         LqdZon0sLpHFrtbpFWrRoZNwBLfoyrXqWzxEOA6lMEEX3ZAUz6oTMCn6sqdN0el0KC7D
         8OeIBJDQXA+U3lrYI9zjH6NQbB3UAz8EGEolpeY+yHESwZEfwvMMstG2uZSn4rnQbpXN
         BBR4xNABki9UrjHfWvXZx3HmQv33knNzCQzj97jVFZ+zbqNGAX6vuCxEc1iYXD9jCjLI
         /7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ZxWWZTh6SOLlkJcWKVcdgxdqVOdzBSFhTdJi+uvz7M=;
        b=AyKEfyVDdEg4AfdIGa7MwkjDg2vc/1c0ChY4EiiPANSLErb/Qm8VCgS2fe8mWnRG2U
         hu+KFa1Ikao+EQ3hTp/t2/3SaiBNN4qJtn4nCIZ1WMH0hNwHwI6VnbAabXeadHE3H4w2
         E2FCW5RTTMHUWG7JUxWn4IkDMrdL40TxvXQFGgugPkLau8570yQ2X2bwgHnUouHVRmZX
         pfNzSNEubIlbFMnoN0A1OzP5GhcZ95vgXvPDtEzbFc/zPJag1fhpKCpFuVTGDl98b3m3
         s+oZU1anMpi1TCfKBxqXFxNlICUbtM3SYZxKyX+Od20lZhKe115nlIFMiB0yo2Zec+B1
         Hf0w==
X-Gm-Message-State: APjAAAWJWad6l38n8/0H6fGiHSzE6qGq6TzFVgveXi4fHTU9Iv2C8p1E
        gos5w+bKr/kso+kHorWgvnM=
X-Google-Smtp-Source: APXvYqwv6kldMGSzQ7rm2+6Aw6sY92ct1ocRkXnWzIqfcCoc+Ieeunqu2I7KN2nsWZoNXdNV33VRNQ==
X-Received: by 2002:adf:db81:: with SMTP id u1mr4013691wri.347.1571333714707;
        Thu, 17 Oct 2019 10:35:14 -0700 (PDT)
Received: from localhost.localdomain (x4db41bda.dyn.telefonica.de. [77.180.27.218])
        by smtp.gmail.com with ESMTPSA id f20sm2599876wmb.6.2019.10.17.10.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Oct 2019 10:35:14 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/6] completion: simplify completing 'git worktree' subcommands and options
Date:   Thu, 17 Oct 2019 19:34:59 +0200
Message-Id: <20191017173501.3198-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.1084.gae250eaa40
In-Reply-To: <20191017173501.3198-1-szeder.dev@gmail.com>
References: <20191017173501.3198-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The completion function for 'git worktree' uses separate but very
similar case arms to complete --options for each subcommand.

Combine these into a single case arm to avoid repetition.

Note that after this change we won't complete 'git worktree remove's
'--force' option, but that is consistent with our general stance on
not offering '--force', as it should be used with care.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 30 +++++++-------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 55a2d3e174..643272eb2f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2985,29 +2985,15 @@ _git_worktree ()
 {
 	local subcommands="add list lock move prune remove unlock"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
-	if [ -z "$subcommand" ]; then
+
+	case "$subcommand,$cur" in
+	,*)
 		__gitcomp "$subcommands"
-	else
-		case "$subcommand,$cur" in
-		add,--*)
-			__gitcomp_builtin worktree_add
-			;;
-		list,--*)
-			__gitcomp_builtin worktree_list
-			;;
-		lock,--*)
-			__gitcomp_builtin worktree_lock
-			;;
-		prune,--*)
-			__gitcomp_builtin worktree_prune
-			;;
-		remove,--*)
-			__gitcomp "--force"
-			;;
-		*)
-			;;
-		esac
-	fi
+		;;
+	*,--*)
+		__gitcomp_builtin worktree_$subcommand
+		;;
+	esac
 }
 
 __git_complete_common () {
-- 
2.23.0.1084.gae250eaa40

