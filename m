Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CABE20323
	for <e@80x24.org>; Thu, 16 Mar 2017 22:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754604AbdCPWhk (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:37:40 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36353 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdCPWhi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:37:38 -0400
Received: by mail-pf0-f172.google.com with SMTP id o126so30689001pfb.3
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 15:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W3gGLRnSG8ooSNd0/KA5/CS+ifjvdfjx3Ep0x+xdyFA=;
        b=FYakcyrKA5NCggpQnWcrYChR+wNlO1LEnZF5TTX0SYoFu3EEf3Mx7GlS97GoCN197B
         bkWNL5QFj2D9wAdNXuX1JRZ571AYiiWSuBzZsBJnPa86c+mLPuS9k55rRcMa6ifMkuzQ
         W7x4V9IiFnvQ+s8UbMpiUlXkncXMHpnJC+wFviGwkRMmUrlxixtUOM+s598BwRj+2FDf
         ipETwpnU+mpP21jRkVKYHoqfv9TEPBwA6tOprnHwdGx/Sv5/AX1mym3HdDQH01U/m2fy
         N/ErKJVjjiPBihkQ5ft4vAEWJq8QsUDQ7K41U5/tW4NWYf+TdpPzPWfxaCxSojIlsU0J
         21sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W3gGLRnSG8ooSNd0/KA5/CS+ifjvdfjx3Ep0x+xdyFA=;
        b=YtlTpMc+ZS4ed42O9YLuH3mXMqu5vg2D+LiaMhckOOwEV9bsqTl4jbHDGrpiEJZeNE
         /52SX3NMXa3jE3ts+ydtc7YTMHbu1gD6rdbfleySBs1BIRmDIkFOGs5ynKkQ0ltfuCWt
         isNWE5y1tzZPCaWk3lPKvIv+imFOd49Q1by+OJJDiHuhJhMKsHHJy5k2Fr9tcAkvpOv2
         Xcbkq8CmyQ+c8sTZr5jOgxUDVNUAMKXbKuAKiYmJ6stHa7rfRR/liHt3lml3JXzLWPsw
         ElSeGHE4ar61IOK/n189dRlzymRGAW28zSbj/1Sywx/D4CkbuhiudU7epw93DJMKeK/h
         jzfQ==
X-Gm-Message-State: AFeK/H0tZIkXHY2+aL1AaORLnkZtB3/aI6eqc6xP3j/E1po/BTr5cWGnIFRwaQjSCY6NzeS6
X-Received: by 10.99.167.74 with SMTP id w10mr12671649pgo.2.1489703401968;
        Thu, 16 Mar 2017 15:30:01 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id t5sm12520946pgb.36.2017.03.16.15.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 15:30:00 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v4 02/10] submodule status: use submodule--helper is-active
Date:   Thu, 16 Mar 2017 15:29:44 -0700
Message-Id: <20170316222952.53801-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170316222952.53801-1-bmwill@google.com>
References: <20170313214341.172676-1-bmwill@google.com>
 <20170316222952.53801-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 git-submodule.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 136e26a2c..ab233712d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1010,14 +1010,13 @@ cmd_status()
 	do
 		die_if_unmatched "$mode" "$sha1"
 		name=$(git submodule--helper name "$sm_path") || exit
-		url=$(git config submodule."$name".url)
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 		if test "$stage" = U
 		then
 			say "U$sha1 $displaypath"
 			continue
 		fi
-		if test -z "$url" ||
+		if ! git submodule--helper is-active "$sm_path" ||
 		{
 			! test -d "$sm_path"/.git &&
 			! test -f "$sm_path"/.git
-- 
2.12.0.367.g23dc2f6d3c-goog

