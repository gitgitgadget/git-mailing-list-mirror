Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DEA31F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753855AbeAaLIz (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:08:55 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40914 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752345AbeAaLIx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:08:53 -0500
Received: by mail-pf0-f196.google.com with SMTP id i66so12241914pfd.7
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8m06EY8uRuO09ayDrvHN4goY2znRL9l1WU+0ieBDF/c=;
        b=lNZx1Z5RL7E35YD9nLPaMHHvMtdQRO0zzGQAY8Syv243c0GRzidjjghLz3jKeZ6fZ0
         mJVvwK06AgqmwYyEMuYzA7kbQwyzvl9HqaMqlF+fbOLGTF632hDix8VA0YLKBwLy6+9+
         8x8nTfJQZljHbduj/Cq55CEUM00Mx+RJMM4cSME99dS6EWkDhxsnjuBe6Nfust2uaOL/
         qyYmaA59t5dZ44pBbHY+q0vSKRcHA5lVXU1wHyipEPZrk5kEo3iop7t1O7y70F9O8D5n
         IcBNZod+ZJlUvebKn+ddwb6FNr6FNZz03CyNp/tgcN9RAqaB5IIzdtsYdOu89NNl9IwO
         CmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8m06EY8uRuO09ayDrvHN4goY2znRL9l1WU+0ieBDF/c=;
        b=k4VRRPt32MHd90Ka9bsjwCV2X/7BR2xIsEVNWXAWvjF6gaBf4doAhJIsuNiU2asNcH
         /Kbqcn0xK27smn4Yi8hGqwRavZLGAwhu61HzFSzFw3iJ22P2xQa0G1y0+xTgiG04+aD2
         PkEsMAYOr6vIp6X/vbRzjTnBgcvLQUG8VojP0eJo8v73F9G3MpGn37KYuKFfAEkOO2Hp
         3RSC0n5R82VVdm8Qk34qvF1QLxprZLo8A6aMS2F3xrM88zxgydyzizKTJ4JuZsi5aJVs
         +Uht76TreW2qLx2c6AJIdLklK9idT6kV79ujzIhn28Zp16vr7a6i1/+aJGdQAL3DGumi
         9w+A==
X-Gm-Message-State: AKwxytfSJWFXFmudmzmh1e5f++pO2dKzD8qzDzXNRRPz20KyzTUG1/VS
        SZfjt/5GufPc+8s0z2s8YD9njA==
X-Google-Smtp-Source: AH8x225KXZxlIOxb9+Q1Kqo39+0awlU2DWS1YSHBLEygYNBJGHO1r6P5sDajq+im2DvaUcDFKM2isA==
X-Received: by 10.99.61.205 with SMTP id k196mr24920839pga.370.1517396932476;
        Wed, 31 Jan 2018 03:08:52 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id d4sm18679723pgc.58.2018.01.31.03.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:08:51 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:08:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 39/41] completion: use __gitcomp_builtin in _git_status
Date:   Wed, 31 Jan 2018 18:05:45 +0700
Message-Id: <20180131110547.20577-40-pclouds@gmail.com>
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

The new completable options are --null and --show-stash.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3722c6444a..ba9438e437 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2052,11 +2052,7 @@ _git_status ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--short --branch --porcelain --long --verbose
-			--untracked-files= --ignore-submodules= --ignored
-			--column= --no-column
-			"
+		__gitcomp_builtin status "--no-column"
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

