Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBFEA1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbeAaLHg (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:07:36 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37055 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753710AbeAaLHf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:07:35 -0500
Received: by mail-pf0-f195.google.com with SMTP id p1so12246015pfh.4
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkQ9c7OgJ0+WZYnHPBcysjHpudHEbY6ruQs1c3V/93g=;
        b=EFhCFsuR8xH7JlFrG9a92YpxW/HBgHbIPRvMe5c+tPGy/qsFLsjPsjiYezmD6PTGHn
         7w/pn8N0TaKEjckLsU+X7WG1bQLZTpLhe+lJQ3uM2h3UN19C8QJelfd6iaEWBv6hCOof
         suCc0K300LFxa+it/zVoTARGKsdQNLAOfqk77ltIchPxddvcY7ndogAs9oZk9v4M7Y6l
         ZUdKKcx9Ht4q37frxGPOHmblWAfsH/+EIAXms4/FreIqTazrpVIffix+NgtbV+wjh6IL
         GvFkzEmj4FXJWG08q+cUMX7xoatX+I0t8m+5fNPtKhPNymbfIbvkXHQeazKGfUWHXeS/
         0vxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkQ9c7OgJ0+WZYnHPBcysjHpudHEbY6ruQs1c3V/93g=;
        b=calpbgV61uTQKq8+iaMrFCndg13AL2f5vh84E70ipBotCM7zHbwtByXxzWi0kr5xmw
         4AFP3rSUvTEz3p11bwU9lrKUUReNNdnFm7MLXEevjWMGv46pm6uVPkxpzFgx/tAr8A8l
         v0StpabVXUyvbPlcXJiprcaIWLnAT4T6G4rjRWDly6OiHGzat/Cr7ILjrDULzm5R1a8r
         2hD4jtIX5Ke8BPikvOk8WrPpWpZo/0HCkL68EFLyxh/d0/Lkpa7/iDC4I3S9lJQ1awGs
         mN3aXKNK8Lx7EjwgVFydAw1sCPtIvXDCBTb8rJIjxyQ9xhUyTdSx437Cg85dU91NJeLe
         NH8w==
X-Gm-Message-State: AKwxyte5l6XvpCL5+W7idydsuu+SRQVPWdHz4iku5lHOEpX5/bVPkx42
        OTpHq0RA4F/OFHaZM9zNyY6TEA==
X-Google-Smtp-Source: AH8x225YEQ0d6Eo1/WNTR07YInx7vLlt3bJiS+uzjXOE77zismivVwgZOenxJv1/0f4VR65P748ihA==
X-Received: by 10.98.194.8 with SMTP id l8mr33493944pfg.26.1517396854426;
        Wed, 31 Jan 2018 03:07:34 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id k14sm18414171pfb.15.2018.01.31.03.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:07:33 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:07:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 21/41] completion: use __gitcomp_builtin in _git_help
Date:   Wed, 31 Jan 2018 18:05:27 +0700
Message-Id: <20180131110547.20577-22-pclouds@gmail.com>
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

No new completable options!

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6e78737a13..1e3cb39fde 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1569,7 +1569,7 @@ _git_help ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--all --guides --info --man --web"
+		__gitcomp_builtin help
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

