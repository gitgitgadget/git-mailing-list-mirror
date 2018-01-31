Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3ADB1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932091AbeAaLIv (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:08:51 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44119 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932066AbeAaLIs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:08:48 -0500
Received: by mail-pf0-f195.google.com with SMTP id 17so10802482pfw.11
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iiJO4GiBwUGY7QJwMjquce4LxhZ7uH+vUeIYRZGAZ8w=;
        b=IP9UrfYnTH2PNFIaNBfYuMcQqJD0i1UUJtixTSFD88RGKtZOav2D7xzb7/74FF2gMB
         Zq6N5bB6WbJIuCManOihgJvzd03HH0glqhqGomAINvqYtb4s4kSBlkYN3kY/CHOAY8Oe
         Wa0cm9sMHlZDk1QSjpEO6E7dVReFNM30RYthzuBbBEK0hGk4upfT5KK65G3DzldD4DoD
         oIpMArbBIzJYDeVxJ56G0p03J3vdfsq6mTafWVKhLuoJhtGtklMQOX+Fep4XvDKkwQJw
         UR4EUtc+V1vpMO2wLjo04y/MuyXtA6Kvjfli5PI+ynoTbdcBGNO2h5sEF3MgdurH82cq
         u/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iiJO4GiBwUGY7QJwMjquce4LxhZ7uH+vUeIYRZGAZ8w=;
        b=GXdh8ycTcOUpZiubuek6V4TMOPboBRwMxcGFBizE2EWBHfu/9ugaL0wt10kVT/R//3
         9zh45z14IAHclqhNiVmcc2esMxiwQe/gVXEecArJ4dBtYl1lFd2xV3gXcQTmG7nANeAp
         iWlyd2PwPMIsVyn0Jhr3fWP5ByjldI6ZPcD6K7dyKAOPHKhfQvyALAQlX2ZMc96OBi/h
         A+Hn9DF1K1oHBlmAUuSfoEa0EmOvoJhJt1Sx8AXp7yRnI8d57qrGjtvJpuUTZ2/X4Fak
         PhZHhN27PAkdQaqy+oh048fcFlea8tyJuMCE/cDxWCsFGoc/nBbDNdW2SOk40nIYB24v
         +rIw==
X-Gm-Message-State: AKwxytcyki32EtIjFZjWQ8mRfokTqvQ/emcMFyurFVmcCG8NjYHs6uHF
        ImXVoSvAoLaEkKclpyiqUc5oeQ==
X-Google-Smtp-Source: AH8x227jbQe6+LYJCG3iiyadOLVIrkegOBPPNm8WfdqgtG/dOjomLnCJoAnQEJ87wp1WBJwtsocGww==
X-Received: by 10.98.166.22 with SMTP id t22mr32795875pfe.80.1517396927782;
        Wed, 31 Jan 2018 03:08:47 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id j13sm38344504pfk.112.2018.01.31.03.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:08:47 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:08:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 38/41] completion: use __gitcomp_builtin in _git_show_branch
Date:   Wed, 31 Jan 2018 18:05:44 +0700
Message-Id: <20180131110547.20577-39-pclouds@gmail.com>
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
 contrib/completion/git-completion.bash | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e5a9f7f9b4..3722c6444a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2756,12 +2756,7 @@ _git_show_branch ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--all --remotes --topo-order --date-order --current --more=
-			--list --independent --merge-base --no-name
-			--color --no-color
-			--sha1-name --sparse --topics --reflog
-			"
+		__gitcomp_builtin show-branch "--no-color"
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

