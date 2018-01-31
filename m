Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC1D21F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753680AbeAaLHQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:07:16 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35252 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753656AbeAaLHN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:07:13 -0500
Received: by mail-pf0-f194.google.com with SMTP id t12so12249662pfg.2
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjxxBbXv7VNZnlr63lNoS8jbnbMBhKRBXZjV6Em5zOk=;
        b=MyNQwRoWWx32jutPq27PeV901jsU0SdrQ/cE2jlom+fVbD/z2BXT0ZYoJQqT4a55dq
         TukgoZPRYYSzdE7sBej+5M25XEUOLKsZokR1+zlbmASBQMLX8hZLzsH4NKNMGoz634FN
         cxtJBorArrXSmke/s1901ZMQawExzvY42Puk5I+1QphSfnLsVrEPqiFfVL7cylbTFBJY
         wr5YjEC5K4/CmdFh2zpMMWLJrBG6C7+NiefAMyn7Yy3zKdhB5sH7b66UiaPO1BkxaHeH
         +tIiZ/PllWcccxiSDFbjumNXLXBiH0unZq1AqctAJ5UTyWtHa1gNd7HSeRJYtOgCj81T
         Z7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjxxBbXv7VNZnlr63lNoS8jbnbMBhKRBXZjV6Em5zOk=;
        b=MW/xdnBqTrg2aV4Us4e8QXQk4MrBzW2oa1R4a80JmGi3u7DiYlDwDnU78Pa9YziApX
         btt7uDVhW0qXsHX+lOou2O65+C2Vvtt6h0zDlIScVjWj3Gb05qWSyyUQD/aVCrS79Owr
         0aG/n3h0PUdnAFVFNBIwnqfmpwks1q4sx43riTdcFnsuOzYU2+Cb0WEvXem6Nya1f2Kg
         Wy4M01VgPlQGakurr17ZlnjUjCygHImbstPlGPnFYgk3S7/4EnsefZdo2XeEnGxd49xc
         tWJFt7mEws1ikjyH8JAqRXCOBovqXjGa+7o8sbA2eoFjrguQUo3+zDE9OIzkYIqpJcmT
         g/Lg==
X-Gm-Message-State: AKwxytf/qqj5QfAguJUaqH3VLpfnQX3iwF3j4SPMxgLpjqEQiRQH9WjW
        hCKiCig4RCKo8tqyTLmRNc0qJA==
X-Google-Smtp-Source: AH8x224pfMXTth41iMcnqTqlCWvtauQO3TBKypXfLZw5iLh8MP5BBkIPxNjF2xBKMCADiue/0te3tQ==
X-Received: by 10.99.117.86 with SMTP id f22mr26135874pgn.330.1517396832471;
        Wed, 31 Jan 2018 03:07:12 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id k1sm25318290pfa.8.2018.01.31.03.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:07:11 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:07:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 16/41] completion: use __gitcomp_builtin in _git_difftool
Date:   Wed, 31 Jan 2018 18:05:22 +0700
Message-Id: <20180131110547.20577-17-pclouds@gmail.com>
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

Since we can't automatically extract diff options for completion yet,
difftool will take all options from $__git_diff_common_options. This
brings _a lot_ more completable options to difftool.

--ignore-submodules is added to $__git_diff_common_options to avoid
regression in difftool. But it's a good thing anyway even for other
diff commands.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 450d8e488e..255d60f12d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1380,7 +1380,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--dirstat --dirstat= --dirstat-by-file
 			--dirstat-by-file= --cumulative
 			--diff-algorithm=
-			--submodule --submodule=
+			--submodule --submodule= --ignore-submodules
 "
 
 _git_diff ()
@@ -1421,11 +1421,11 @@ _git_difftool ()
 		return
 		;;
 	--*)
-		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
-			--base --ours --theirs
-			--no-renames --diff-filter= --find-copies-harder
-			--relative --ignore-submodules
-			--tool="
+		__gitcomp_builtin difftool "$__git_diff_common_options
+					--base --cached --ours --theirs
+					--pickaxe-all --pickaxe-regex
+					--relative --staged
+					"
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

