Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91F3A1FAE2
	for <e@80x24.org>; Mon, 19 Mar 2018 15:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934144AbeCSPxN (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 11:53:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43419 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934075AbeCSPxF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 11:53:05 -0400
Received: by mail-wr0-f195.google.com with SMTP id o1so19103969wro.10
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 08:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TmOBCvuXgijSwjoVG+IMgVsEWp7AsNO9EsZkCg2A9rc=;
        b=oaWxkD29kkLskseWTePMbSF6reBR2PI3zdNt6epclPbhZKwgr53pUX5rvXCx5BLOef
         fHbSQSa5Cm6gM2RPLob/ItRr5Q23bJ6seKeGBQ9oZCsV2oMYt3PZ1pli/xYoYinAenlT
         e/gFAj6PZ6+5zfL4cktzGR1a9/pOK492CF/CvxhvlcqOr1wmQdj82c2Hf2uSYVqmW8PW
         PBr+JZdZo8Zi9w+fpCuXQM586w7GshuvPRq76DxnLIPtUvwdh/KeqkKj4acAUiWe/4tn
         kl6TH8GMyzCwEjAK/bmoYRnpfiQzfRGjDNeTQiQJ+kg0SBHuR7fu0sIZ6BIrWdSfUPJ6
         L0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=TmOBCvuXgijSwjoVG+IMgVsEWp7AsNO9EsZkCg2A9rc=;
        b=afM6XIimU7GJG+uSpfrfqrGdmkH2lYgj9AaAKEjXwHpu8G2pilx/AqqF5Xyfxu892T
         vtcNsgC0JhaR1+4wNFcgtQTkaJrrP59ceeRQ4BbdxrfvfiGByGnYQK3sVXWdDK4OyAOl
         kzyszMLUKXMj23PLGFgba1OBjsuPDnm85G0gEq/67goVjibAv2JOM7SqOCaFRdgpzQLN
         Nn8xXPsE/J5gSohOfA+2KcMGtjcpEevU8Xp9/CaHZMTlp6yDUPrrwTQ+AS0xJBDLnmKV
         KkZsXZaCy1KAT4lBxCOlYigE8jC6uOFvzMkDEZM8WM/zJQ5qHyNzbXyKivqwGZfuXh5f
         l7VA==
X-Gm-Message-State: AElRT7F66UeF0doR/K6fCICUEcEplmBfUqrFaVdIATmIR2d77Szp/dfu
        9d2JcbsGvzS6JFjv+Hnxv31bWGTU
X-Google-Smtp-Source: AG47ELu4vwFNMda8C30zaJu6s6vqId4ik6dZHNSL/XKNr5Z7yi3ZuMMuXaLO5800uvnmDPfYcG0RgQ==
X-Received: by 10.223.144.69 with SMTP id h63mr970009wrh.218.1521474784111;
        Mon, 19 Mar 2018 08:53:04 -0700 (PDT)
Received: from FUJITSU-PCD-030.progesoft.local (151-0-155-178.ip281.fastwebnet.it. [151.0.155.178])
        by smtp.gmail.com with ESMTPSA id k184sm826991wmk.45.2018.03.19.08.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 08:53:03 -0700 (PDT)
From:   Michele Locati <michele@locati.it>
To:     git@vger.kernel.org
Cc:     charles@hashpling.org, Michele Locati <michele@locati.it>
Subject: [PATCH v2] filter-branch: use printf instead of echo -e
Date:   Mon, 19 Mar 2018 16:52:59 +0100
Message-Id: <20180319155259.13200-1-michele@locati.it>
X-Mailer: git-send-email 2.16.2.windows.1
In-Reply-To: <20180319144905.11564-1-michele@locati.it>
References: <20180319144905.11564-1-michele@locati.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to echo a tab character, it's better to use printf instead of
"echo -e", because it's more portable (for instance, "echo -e" doesn't work
as expected on a Mac).

This solves the "fatal: Not a valid object name" error in git-filter-branch
when using the --state-branch option.

Furthermore, let's switch from "/bin/echo" to just "echo", so that the
built-in echo command is used where available.

Signed-off-by: Michele Locati <michele@locati.it>
---
 git-filter-branch.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 1b7e4b2cd..98c76ec58 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -627,12 +627,12 @@ then
 				print H "$_:$f\n" or die;
 			}
 			close(H) or die;' || die "Unable to save state")
-	state_tree=$(/bin/echo -e "100644 blob $state_blob\tfilter.map" | git mktree)
+	state_tree=$(printf '100644 blob %s\tfilter.map\n' "$state_blob" | git mktree)
 	if test -n "$state_commit"
 	then
-		state_commit=$(/bin/echo "Sync" | git commit-tree "$state_tree" -p "$state_commit")
+		state_commit=$(echo "Sync" | git commit-tree "$state_tree" -p "$state_commit")
 	else
-		state_commit=$(/bin/echo "Sync" | git commit-tree "$state_tree" )
+		state_commit=$(echo "Sync" | git commit-tree "$state_tree" )
 	fi
 	git update-ref "$state_branch" "$state_commit"
 fi
-- 
2.16.2.windows.1

