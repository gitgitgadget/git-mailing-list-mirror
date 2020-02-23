Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9155FC35670
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 08:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693FB206E0
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 08:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PewGxcyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgBWItU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 03:49:20 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38455 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWItU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 03:49:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id r14so4626060lfm.5
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 00:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UyJAb2XyzDZ3CHrcQAvhhtgibOLmrDHOgERzOvKk8A8=;
        b=PewGxcygPv3iU4rjHJpkFvJ0ZzwcCyqHAyPPPzif5i8BUpxrnCg58O9jLxu303WfLO
         xbhun7LUCQ0BgxTH1qVmjv3fmA9gwQadOXjE2gf1ys1SOgpwZGcW3Z25ruQJxZh1EtHZ
         /qF9gli5rHYzwyw+9bB4flrjUEwa/aiIqqZYlrTqUtnPfkARW6mp/ek9ttTORA3I5Nqb
         M99A9tCmXQhUg94VjDKkS9qQhiDqeh1x7nmMdO2ZiSTFszZH10CMhdbAfAmfTePtn7uH
         WZWMG7WQpUDxcchATz+rv2g9+rLnUD/udBxR5P5A6izx+JoyCrnp4NTdFF1Y5Xu5aNqh
         U0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UyJAb2XyzDZ3CHrcQAvhhtgibOLmrDHOgERzOvKk8A8=;
        b=blWlFVYNdW2Ia4fC51FUQrWFe0Er89fBGnfv+8m5YZuGVqEV3y3fSsw1m9adEo+CHZ
         6Lda5xfTEVsVzkvNV5A1qaCVmtd7wxaj86Gjyk/GH2AZJFFe42NGIbo+oxiRgM2mqHRV
         FND2YcwTEsYIkVwRZzW4SaTIBAnQHVL6zUG+5tdeHcjw7kS4INwirwWJ8ESsTJuX3Dle
         0poWnmnkKULXtxS6MLpvS+E2+QaRqG1AeH4WI/OxsjUQG8ccredBWazRC2twoUff2hDM
         GDM18jSE210sXfElcG0kQvxmakTRFa6gou/QVzPNhl4Ea12mFRwew4feoU6nzzbCAt9n
         hPOQ==
X-Gm-Message-State: APjAAAXru9qVqnejO3rZe/I8AmKCfsHDSIpeka7WIah8syZxexXuVk8i
        6fcoZ017Fk+QvcYwiTqfzw5dd/by
X-Google-Smtp-Source: APXvYqxEtc4zugDKSPtQ7+RR0cjAMkEn9i4hNTwQIJkRVeiC0zFmlED9RPV6OqyLP1Qf3drnMgSmqQ==
X-Received: by 2002:ac2:59dc:: with SMTP id x28mr24486915lfn.38.1582447758154;
        Sun, 23 Feb 2020 00:49:18 -0800 (PST)
Received: from localhost.localdomain (c83-248-175-94.bredband.comhem.se. [83.248.175.94])
        by smtp.gmail.com with ESMTPSA id t29sm4108692lfg.84.2020.02.23.00.49.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 00:49:17 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] t9810: drop debug `cat` call
Date:   Sun, 23 Feb 2020 09:48:35 +0100
Message-Id: <ef45c9cabe7fe3f31d63edb872ba946ffbd951fe.1582447606.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <dde0f85e5e3dd99a61b83df1b6eb572be8a3ff51.1582447606.git.martin.agren@gmail.com>
References: <dde0f85e5e3dd99a61b83df1b6eb572be8a3ff51.1582447606.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We `cat` kwdelfile.c, but don't inspect or grab the contents in any way.
This looks like a remnant from a debug session. Similar to the previous
commit, one could argue that `cat`-ing the file verifies that it didn't
disappear somehow. But because the very next thing we do after `cat`-ing
the file is to `grep` in it, we can safely drop the call to `cat`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t9810-git-p4-rcs.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index 57b533dc6f..e3836888ec 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -294,7 +294,6 @@ test_expect_success 'cope with rcs keyword file deletion' '
 		echo "\$Revision\$" >kwdelfile.c &&
 		p4 add -t ktext kwdelfile.c &&
 		p4 submit -d "Add file to be deleted" &&
-		cat kwdelfile.c &&
 		grep 1 kwdelfile.c
 	) &&
 	git p4 clone --dest="$git" //depot &&
-- 
2.25.0

