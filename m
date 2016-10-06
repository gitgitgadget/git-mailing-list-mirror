Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9057920986
	for <e@80x24.org>; Thu,  6 Oct 2016 11:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755626AbcJFLlr (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 07:41:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33623 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbcJFLlq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 07:41:46 -0400
Received: by mail-pf0-f193.google.com with SMTP id i85so1050511pfa.0
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 04:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1NovFCbIY6nSZPRa2YRFe1iMu9sS9IlhGD36+yxAYhg=;
        b=NSSGynEZ4vhWWlin53RMV28xXDHCgck2EFsM7Aul1vQWGDiVFbu7HBM+psBsTppRID
         bWbm0bV5+I3aXy0rAnuckvkwNeOhe70FqseZllfGfQQLzIfmPGnqcgNtBMZZYxGdl60Y
         OZCzdeSmO2YD5FAcqanoM5KObDUDhHO9FTpaoYzz+BBjHIVJBMR5ny0MZNN8H1/rG/Qs
         kQoMayNRF19pxUcQ+xSsj2/JyGAh7uvoLpNLcYbY5lraQ17OKXsE1p78UigBEyUXfmla
         lXONO7QRrGCT6L6hZWvov3v3y5f32nwqD8+IjyYjVSalMYjes7jDiqWRpAw87Tiot4ez
         vVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1NovFCbIY6nSZPRa2YRFe1iMu9sS9IlhGD36+yxAYhg=;
        b=Bv0SYZVRDnHURpdaCwcUsLaUOEqEl+mm0xYG5TiYmD6EAnIEYozEJ9d22sra2UGhG+
         ICH8/ILzG25/bLHYDDYJf3DRvz/PaWu8mPZdNudIhRgQXfd/SxZZLm6OAv2glsboEyOw
         KHzvp7cTX1JfMEGuuShKAf+//vfsia7jAiQlImL/f7/qpOATaKzuyresV7NXcixq5smk
         dfTdWt/lc1EdS6mkRwu/n/2mWpKWbK+yS208XBlwukwbbjaRyKWcHsJ7azfTzaetsZiq
         FCK63p8K0SNO7kZxy22vWU3ZB+hdpjLNAST+M5QrgCBGmtgieAHJj91i/0nMZV+uoaYW
         StwA==
X-Gm-Message-State: AA6/9RleZEsBA/VIEOBtZoMd2OcuHEtDDiai1XeGvsAxjqtfvhBNfKS68G1kpEyOR1H1iQ==
X-Received: by 10.98.83.130 with SMTP id h124mr17480150pfb.154.1475754105207;
        Thu, 06 Oct 2016 04:41:45 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id id6sm22057085pad.28.2016.10.06.04.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Oct 2016 04:41:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 06 Oct 2016 18:41:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
Date:   Thu,  6 Oct 2016 18:41:24 +0700
Message-Id: <20161006114124.4966-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Throwing something at the mailing list to see if anybody is
interested.

Current '!' aliases move cwd to $GIT_WORK_TREE first, which could make
handling path arguments hard because they are relative to the original
cwd. We set GIT_PREFIX to work around it, but I still think it's more
natural to keep cwd where it is.

We have a way to do that now after 441981b (git: simplify environment
save/restore logic - 2016-01-26). It's just a matter of choosing the
right syntax. I'm going with '!!'. I'm not very happy with it. But I
do like this type of alias.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 git.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git.c b/git.c
index 296857a..4c1dcf4 100644
--- a/git.c
+++ b/git.c
@@ -252,6 +252,10 @@ static int handle_alias(int *argcp, const char ***argv)
 
 			alias_string++;
 			commit_pager_choice();
+			if (*alias_string == '!') {
+				keep_cwd = 0;
+				alias_string++;
+			}
 			restore_env(keep_cwd);
 
 			child.use_shell = 1;
-- 
2.8.2.524.g6ff3d78

