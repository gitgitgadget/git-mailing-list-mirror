Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91041F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbeAaLGs (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:06:48 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41374 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeAaLGr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:06:47 -0500
Received: by mail-pf0-f193.google.com with SMTP id c6so12240203pfi.8
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bWzxoulP/5C35Y/ZQepwP58pjjRpjGPo8XOw4MhIVg8=;
        b=O4XxDcBJ6MS9DKo3gbNEK9f7DQr5hUTAYszjeQU6mdlXm2xVtrOWuWfgKhb0R37TxE
         4/0vKGxBDkf9K2dHHzSY19769mgoXe9rA0eMVKYirrME+BX+FJwAH0MXVCG1H78nnbVF
         m/xd1Uhck2yPBTK6LKbHrnzGjYZjzUu7LoMMPursRTlZt0C1kHYbjXY/RGkIsbN2/Caa
         4nIssGOVq3D+zzFrliZ02pTGRW60gMmuvosi+ctxU5Vr1q2QoohNa2OYUQaZiGzO+xgb
         5juQ8BS2xbey5ySKXW4JT5muVsyegiI9a6yEyaY7asUHTbD2yY7CrD5MrBVCs/SGrYBs
         VFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWzxoulP/5C35Y/ZQepwP58pjjRpjGPo8XOw4MhIVg8=;
        b=LSl4PNBT1Pr0KNb2VsxIAjgsjfFiWWP023swlaNuwkqQqhm/DOvxT4NqyHAs8SqCfX
         aCx2MJe4C0ijaX9BW3k9z2etIZalJiATPrM11vfgIqkNL0KbYaK1YpbvQFjZ0b6/tAGM
         oNoYXEqYDaN4eKCjehC1K5sw4J9s4ZrD1Sl6fOdul1DLUL0ZZyyC5+c4almPBy5YykOk
         cv/2MsSVYQTdkvpdJ5nRtQgSOeSSPyasbVE1nT9E3WtVtn0+emmMU+5cSYvdWD4ku7sG
         RxK5NMUH4T7rDC7grWYdeW6vXUGebxRAxSyzd96enCf5jEj5JcUkxhBRcp4OskmIsfuC
         JiKA==
X-Gm-Message-State: AKwxytcuWTMU514dqcDoIBoZK3Lgrg3J9rYqFvAvwet3+gqiMKU9BzaC
        tkd31+XaYxPQFlAs722YA8n5ew==
X-Google-Smtp-Source: AH8x2254Yp/Qq6puerg1Y+ggQ/h6tmAsb4OFc0HnUrGFIGoBDkhM7dAxLiXd8YNgKfp6eR3hdfXxKg==
X-Received: by 10.99.123.8 with SMTP id w8mr26114882pgc.201.1517396806261;
        Wed, 31 Jan 2018 03:06:46 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id m24sm44414651pfj.184.2018.01.31.03.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:06:45 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:06:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 10/41] completion: use __gitcomp_builtin in _git_cherry_pick
Date:   Wed, 31 Jan 2018 18:05:16 +0700
Message-Id: <20180131110547.20577-11-pclouds@gmail.com>
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

--allow-empty
--allow-empty-message
--ff
--gpg-sign
--keep-redundant-commits
--strategy-option

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 61880275ed..1b2e510cf6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1281,7 +1281,7 @@ _git_cherry_pick ()
 	fi
 	case "$cur" in
 	--*)
-		__gitcomp "--edit --no-commit --signoff --strategy= --mainline"
+		__gitcomp_builtin cherry-pick
 		;;
 	*)
 		__git_complete_refs
-- 
2.16.1.205.g271f633410

