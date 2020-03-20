Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5AEC4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD50B20709
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg289qDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgCTP6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:58:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40327 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgCTP6g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 11:58:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so2660318plk.7
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rb90CEL7GnK/biLzkp/7BYx18kNqWygy/aYZ+8q25iY=;
        b=cg289qDOibQuBNoF1bR9RN5Ng1AqWgSjLhdIWgUbs3EPdELXWvbNWR1A2rWHpz57eE
         1TBZGBc9dmTG0EM9kGHkIpY6DoPo7em8EYuceCSmtYnpvlKVj+r0g5MvwFtb7RnYPStZ
         NAMBmwRl9MFBObVxH3gyZVB93hHzlaAJedfKiMN790cneKl9iFKT/H6aK4N0bhBR01GE
         IrZr9UTfAQV1MkqSqx7NA3EQJg2IvoMDBYWVOh1gYlHdc0cvssPE2DkBuNR7If5M7bDY
         Lo7AvoeP6wVhSIjaQiDhtxZqnuaDoTD5SCnCi8Nyy4L3i4accb07fJljOoUJj2wSGYyI
         JJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rb90CEL7GnK/biLzkp/7BYx18kNqWygy/aYZ+8q25iY=;
        b=jC9+/qQN0fdbY/qx9VtSMkt/Ub+BSTt6YPle0l0QROBgohQCce6ZbNKH0B9KKu22Su
         yabueBNr987KZ9yamnPZolu4KKLNQ450bFMjGGA60+wruETgUF/S3DvJkcXBKQ0VZeFu
         CSyeZNWyJ4RPQ9W0GdUHIby1SxFeJgqGu7oLnh1PhTa27C7+skcdwk283QQAt+ZDgZBZ
         arpbhvS/E3ALnPTwWAti905ZFkF5XD0fqWwPalhlMy8FNnl8fN7LYg68AomJF3wpS4A5
         4y/GN8GLs6CMO5xGfnOwLcvb8p/1roPWMUQou7acl5ulXPyS413a7aZNNkcsyoSD/8zu
         cz9A==
X-Gm-Message-State: ANhLgQ3q/b+YM1XNFQ8JWOaw3gAcDt83QvKpc5zr0UonQg/+5TvBYiSg
        ZTwAEwG4CVeFaLFMED04ASMusBJEasP8Gw==
X-Google-Smtp-Source: ADFU+vt7Jg5r0mWvu1VX1AUx3pI9xBUyLuCvESOgxJEY5btYneGVJEP14VhPDzYk/OnwdUgOsNcNqQ==
X-Received: by 2002:a17:90a:e7c8:: with SMTP id kb8mr10057265pjb.79.1584719915008;
        Fri, 20 Mar 2020 08:58:35 -0700 (PDT)
Received: from localhost.localdomain ([36.77.94.225])
        by smtp.gmail.com with ESMTPSA id i187sm5879792pfg.33.2020.03.20.08.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 08:58:34 -0700 (PDT)
From:   Adrian Wijaya <adrianwijaya100@gmail.com>
To:     git@vger.kernel.org
Cc:     Adrian Wijaya <adrianwijaya100@gmail.com>
Subject: [GSOC][PATCH v2] t1300: convert "test -f" with "test_path_is_file"
Date:   Fri, 20 Mar 2020 22:56:51 +0700
Message-Id: <20200320155651.14796-1-adrianwijaya100@gmail.com>
X-Mailer: git-send-email 2.26.0.rc1.11.g30e9940356
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert "test -f" with "test_path_is_file" to give more verbose
test output on failure.

Signed-off-by: Adrian Wijaya <adrianwijaya100@gmail.com>
---
 t/t1300-config.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 97ebfe1f9d..d74554fc09 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1020,11 +1020,11 @@ test_expect_success SYMLINKS 'symlinked configuration' '
 	ln -s notyet myconfig &&
 	git config --file=myconfig test.frotz nitfol &&
 	test -h myconfig &&
-	test -f notyet &&
+	test_path_is_file notyet &&
 	test "z$(git config --file=notyet test.frotz)" = znitfol &&
 	git config --file=myconfig test.xyzzy rezrov &&
 	test -h myconfig &&
-	test -f notyet &&
+	test_path_is_file notyet &&
 	cat >expect <<-\EOF &&
 	nitfol
 	rezrov
-- 
2.26.0.rc1.11.g30e9940356

