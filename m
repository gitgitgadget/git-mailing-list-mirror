Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C177220357
	for <e@80x24.org>; Mon, 10 Jul 2017 14:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932336AbdGJOR5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 10:17:57 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33042 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbdGJOR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 10:17:56 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so12913211pgb.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P0ZGZzbLvrNwSbX3dmCoX4vI8mxRVeSPNobaEMiS7aw=;
        b=CTVOSyxjPfWK2uAoq8c9j66i7tiCQRrzhXySvQkBnFX1N0ujHVEkGcrk+LSLU5gX2H
         Ke3YK95OctDzH9yAxqt5nf4Vcr82WFA2W+ca0egluSmMo14EsNFIKA7XYfA2eXM2XoEm
         WU8doAqrO66j8FPYM6+Dg+PtG1Z2QPekCyQ9XIxVgd57Ktk1wlPTEZoCrIqPAPNjj2Vt
         hEe+LXJhTWP7d2qmMdo1cC2A+8zhshUTUBs/7TGsJz6a6Oig6bqNAksQ4b38GLGpPCm5
         zUykFevQsXpupbtMjqpWXXZQgQaDXxDD41denKEIxuo4otYqdtI583VbMAwQDwCYdkfa
         RqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P0ZGZzbLvrNwSbX3dmCoX4vI8mxRVeSPNobaEMiS7aw=;
        b=cf7FR5ki681j1llPlvjJ2j8gfbd4jDbyo624bNGJhsPrGHwTJMbHaJJfwCMUVmaKMi
         1uHYf0vNtQEPTq4g3pakiVPkc4tdidkce7Pq1q0Nf+LMUflQW8yLWdv9z6U0mZs/uoUH
         joXkfDq7ih3kBQIhE4ASLVXXOg6Yrz1TcDqVVdaDeCY/IN3nQRQlJxzvNSNIAM3bFto2
         VsOihBVF/6VhH4Vet0oCgz6Ab9VriWcprJ2iy64RFRz6iq8ciZJiVtEnVnsnqA0sFmG6
         UB1JlqhayYgNPoMAFodhKTF+u6W9NgzTPyvmDngdJ6H176Boby8XSmJRmcZZbWvIbknc
         E0TQ==
X-Gm-Message-State: AIVw110wgDBjQaPSkrug6TDLZK1Zi3WV0Tc2c19sxcswmCPrDNMBfQ5l
        iqTwLucTcQYrZKMM/kVs1Q==
X-Received: by 10.99.116.26 with SMTP id p26mr14798276pgc.17.1499696276112;
        Mon, 10 Jul 2017 07:17:56 -0700 (PDT)
Received: from localhost.localdomain ([117.209.158.50])
        by smtp.gmail.com with ESMTPSA id t78sm25469923pfa.48.2017.07.10.07.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jul 2017 07:17:55 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 2/4] hook: name the positional variables
Date:   Mon, 10 Jul 2017 19:47:42 +0530
Message-Id: <20170710141744.8541-2-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.957.g457671ade
In-Reply-To: <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
References: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
 <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's always nice to have named variables instead of
positional variables as they communicate their purpose
well.

Appropriately name the positional variables of the hook
to make it easier to see what's going on.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 templates/hooks--prepare-commit-msg.sample | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index b8ba335cf..708f0e92c 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -19,14 +19,17 @@
 # The third example adds a Signed-off-by line to the message, that can
 # still be edited.  This is rarely a good idea.
 
+COMMIT_MSG_FILE=$1
+COMMIT_SOURCE=$2
+SHA1=$3
 
-# case "$2,$3" in
+# case "$COMMIT_SOURCE,$SHA1" in
 #  ,|template,)
 #    @PERL_PATH@ -i.bak -pe '
 #       print "\n" . `git diff --cached --name-status -r`
-# 	 if /^#/ && $first++ == 0' "$1" ;;
+# 	 if /^#/ && $first++ == 0' "$COMMIT_MSG_FILE" ;;
 #  *) ;;
 # esac
 
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
-# grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
+# grep -qs "^$SOB" "$COMMIT_MSG_FILE" || echo "$SOB" >> "$COMMIT_MSG_FILE"
-- 
2.13.2.957.g457671ade

