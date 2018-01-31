Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17C421F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbeAaLHX (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:07:23 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36186 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753700AbeAaLHW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:07:22 -0500
Received: by mail-pf0-f196.google.com with SMTP id 23so12248636pfp.3
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XfuRNVl/Hko60M8arTQAZjvObGkYIu5HSlEXuuYwrnM=;
        b=Hc471Gt6SB2gCpVDhl0IY++BOSJy7AtmVzmLQ7HWhlekCeXt/eVcUQ8GIiUgkB5ixK
         uCa8V+QJlCIu+QULUgS16TRcIpibBjVYlFxDQ4VTNlTcksH7QekFf3aqWfbmCJhK5wm3
         crtDVf+ycsIy7PyelTROK0MI012zWsXEU8iUtR0tSoBq1tyTkcVRI0T+UEZCHCJo1Z69
         xQQf94g3HbZauy+BrXL6lyQBbB64YPQskwefY7vTZ1TIUwx4kozVWKt8869K61OriRIa
         zmSLSgSzPnlfF8vCdqscS5Hz7ZAB7VJAJ0OZ3IEEfkCcje+RfM/Ujm1JhjZcSKNjoC7K
         dSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XfuRNVl/Hko60M8arTQAZjvObGkYIu5HSlEXuuYwrnM=;
        b=MNl0KDH7g0ujET4rm7fhFPRbJExvaBF2Ici5mDb0YKIRMpgKmrq9676IQ9sYRI1hm6
         q/J4XHtany2jCioTt3cwFObRXnysjU2Co3e9/iGjxBf8wPC+fXrVzBmL45tOiD47U4jv
         eFaYmVHJ2NMCozFo0/iId1Ah9xAnxVXKLOrp2ykE8z9EtPjfiL4TfMeDXQAap/xPI6jS
         AOIN2NnnDqsksZVgIpawpK8KF79d0w564KBXA1jemCO/E+ndrAy3xBlPlHkI3ugKf+IG
         ji3LGGmnH+o6E71+70JbRhOr6Sx4yot4b44qBqE4s56Ax1tCZn6pKLSnWo6fDx0EVaNx
         eg2w==
X-Gm-Message-State: AKwxyten0KFm6J9GGuX/K0x1tNzabQy+GMcnJ+sM2G9paOgt5l9CWLHh
        Qt/Y2lHBXyZ/7JafGbO1bTv6Ng==
X-Google-Smtp-Source: AH8x224RM9QkEwS0G3VK+srDnQtsQB3A/BtZ5/Lf0Q8aIrTj+N5U92S/H2yphoGitGDHekLLWzWn/w==
X-Received: by 10.99.140.18 with SMTP id m18mr26340294pgd.59.1517396841399;
        Wed, 31 Jan 2018 03:07:21 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id y1sm26492818pge.78.2018.01.31.03.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:07:20 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:07:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 18/41] completion: use __gitcomp_builtin in _git_fsck
Date:   Wed, 31 Jan 2018 18:05:24 +0700
Message-Id: <20180131110547.20577-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are:

--connectivity-only
--dangling
--progress
--reflogs

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 316dac84e0..4d25cfa047 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1485,10 +1485,7 @@ _git_fsck ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--tags --root --unreachable --cache --no-reflogs --full
-			--strict --verbose --lost-found --name-objects
-			"
+		__gitcomp_builtin fsck "--no-reflogs"
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

