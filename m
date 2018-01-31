Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8911F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbeAaLGx (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:06:53 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33041 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753538AbeAaLGv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:06:51 -0500
Received: by mail-pf0-f194.google.com with SMTP id t5so12252584pfi.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9esBVIReiuWzujE+FAJjIBaxo3B0hen5kh+q3ocQSxo=;
        b=L/uQMxBXmppTgdNV5il56Yskl4nvEB9vHsh12J2P2xXzPC05kUUH7tznoI3VGwCFJY
         ovU1l9NL5CLZ/ywibM1Jibk/LV9u/RCmdWUuYO8KNXsJQDqXf+L17csRFNQzETAShhaF
         xaxMIJB68wPWks4XW6k/txbVcCUEQQqJlvroNke0cNISwu29sUjIKhrC2YGHINO7Ct/L
         8my7Cf27y42pPrAuo0rakpdtejONZcaKXqlS6QiiyrxADz6PjqRi3PRNZsa71MJL5ias
         CXSJH9aRplgatUe7fWahc6+dKPDrcNP7cw9Mx8rkNT7DsurJFQuj/8Av/2qa6LPJG6Pb
         NFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9esBVIReiuWzujE+FAJjIBaxo3B0hen5kh+q3ocQSxo=;
        b=he/BhCCf+5XZHVRe933pdhKfo+PyxOjmwTtkpg1gw8/tbtDte3wKrMB7Sx7yfI088X
         TA261lLfx45UaTPVMZYr/CF9ef8uEjNUY2psL+0mgdW7RRLz1DSuJtAjovMPvAKxB73V
         0bZE8qHKVgt/Uo/U+mnIxNL8EuTrqPVn9aHyrtL3XCmd2yJ/n5F9oCXMVXVMBh4+/ndA
         5xYYeHAyQnyun7ReCw/tqDPgGGAMZOQqYgCGt/KIcwUrIhxKG6ilTAQdbZvoLU6t0iZf
         eSjj99oflzhIopQ/UO2jxzCdz6hnm8Ae9+20DXO46P3oz2V93FI6WE+0iSjQzcQqwvFB
         mgvA==
X-Gm-Message-State: AKwxyteh1F4LtlI7iZ2WxDnW3XEYpdggZtyjASF5wIFCLyn2XIjH1j53
        B9Ky2cG/CMia6AGHPvSJQYISWA==
X-Google-Smtp-Source: AH8x226nec2l3N9k/rsmNqa0AVv/u991H2+VeFw2Yqg0J5yc6IeKsUKsF5bmu0PJuZ4SM2Ua0C6mpg==
X-Received: by 10.98.41.68 with SMTP id p65mr11322740pfp.86.1517396810489;
        Wed, 31 Jan 2018 03:06:50 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id p25sm38517475pfj.29.2018.01.31.03.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:06:50 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:06:46 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 11/41] completion: use __gitcomp_builtin in _git_clean
Date:   Wed, 31 Jan 2018 18:05:17 +0700
Message-Id: <20180131110547.20577-12-pclouds@gmail.com>
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

The new completable options are --exclude and --interactive

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/clean.c                        | 2 +-
 contrib/completion/git-completion.bash | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 3c4ca9a2ff..fad533a0a7 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -909,7 +909,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
-		OPT__FORCE(&force, N_("force"), 0),
+		OPT__FORCE(&force, N_("force"), PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL('i', "interactive", &interactive, N_("interactive cleaning")),
 		OPT_BOOL('d', NULL, &remove_directories,
 				N_("remove whole directories")),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1b2e510cf6..c0f6f76c3c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1293,7 +1293,7 @@ _git_clean ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--dry-run --quiet"
+		__gitcomp_builtin clean
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

