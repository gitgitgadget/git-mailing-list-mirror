Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F30FC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 14:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiG1OBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 10:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiG1OBw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 10:01:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052EB65D9
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 07:01:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a11so1007831wmq.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+jY/fkWX2ZDv+Bg3Gjj+HErX+D5w4tR1NOZyA0fyx4A=;
        b=lYOfAVVAO74MBnSk6ILijbEnecsc2xxsFJgLnND2TiWYWqXEotjWYodHRtQLX2WX1Z
         taweTd3nAjz6pQw8BSl5DbyGJdwT/s84oPcof9zXoKStgsJHEM/AT7DUzJniBvGeyaLV
         ji7bOF32GNk50JkjrBHh2la/TXoR7mhIE5FCJ0A3s/ON/gteaWxTFhW5lCvdP/tr4IGY
         Y3P5554VCF8pLGYRM4cK8kcbpfdZPsj1NrMoIdM+/kbrRg4o8l+KepBfDfs85pYc6xpB
         vtddPxkCx6kkjkPTxbUx0hzQJ/cjUIgmzGVi/gZEBTGeTB1+TKArO/oW/Wyu1ZrBZLEE
         BeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+jY/fkWX2ZDv+Bg3Gjj+HErX+D5w4tR1NOZyA0fyx4A=;
        b=hQ6WUOM1Xl6Qvn/u449a0jSABE1xpiroXzvwjAGul8vBCevJ95+Ry3ToEjr8HdOOXF
         SYfDm34ykvDet/EI0ad1XVSNhml0gq0oR8tfe/5Fh+qynipJzVCUHjDuAwzbp/hKedWP
         CptYeoSYgDptGUhYJ4Br3fTEnYTlZ7QSFysBDnoN83QnL+KqjbTtuH1rtW1bW0ttz7dQ
         DQHpbxuXyRFDczVD+F6ncKZQvbOcA3xTW+LCb4CqqyI92i14V1SQZem/Vq5c43vG/Lwg
         ms0k7JcjPbW5lRIISMaD4b/PlGY9uLNTrg66jT+YfI/TIiSePqMBOL56ea4Q28DoE0kq
         HDDg==
X-Gm-Message-State: AJIora+PG9Ywj2ZhPPgoNiGRJja3LJK9rWZncc1V3kkQtzQsWA2bjMtU
        C+7VdT0xAlYYZbDf3Jce/LJWpikAEts=
X-Google-Smtp-Source: AGRyM1vyfAxFvjeMyINK31Dkpnf2g9Dqj9+0mAabEEhcx/xGdF9SLUrYOCy0WDjYCmaRoa5NrzNBuQ==
X-Received: by 2002:a05:600c:4e4b:b0:3a3:19bf:35e1 with SMTP id e11-20020a05600c4e4b00b003a319bf35e1mr6839627wmq.74.1659016908137;
        Thu, 28 Jul 2022 07:01:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b003a319bd3278sm7867223wmp.40.2022.07.28.07.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 07:01:47 -0700 (PDT)
Message-Id: <pull.1306.git.1659016906707.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Jul 2022 14:01:46 +0000
Subject: [PATCH] mingw: include the Python parts in the build
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

While Git for Windows does not _ship_ Python (in order to save on
bandwidth), MSYS2 provides very fine Python interpreters that users can
easily take advantage of, by using Git for Windows within its SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    mingw: include the Python parts in the build
    
    I've actually had this patch in Git for Windows ever since February
    2015.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1306%2Fdscho%2Fmsys2-python-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1306/dscho/msys2-python-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1306

 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index ce83cad47a2..7fc924d0364 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -722,6 +722,7 @@ else
 		USE_LIBPCRE = YesPlease
 		NO_CURL =
 		USE_NED_ALLOCATOR = YesPlease
+		NO_PYTHON =
 		ifeq (/mingw64,$(subst 32,64,$(prefix)))
 			# Move system config into top-level /etc/
 			ETC_GITCONFIG = ../etc/gitconfig

base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
-- 
gitgitgadget
