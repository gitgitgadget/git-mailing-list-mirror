Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1B4420248
	for <e@80x24.org>; Wed, 20 Mar 2019 10:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfCTK3O (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 06:29:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37855 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCTK3O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 06:29:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id q206so1500344pgq.4
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 03:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oTVBuXdvVKYBBykIgrHvs6bjfncjniRujXYZfONtSiI=;
        b=jOxg60c2qI/DxrY+cYj0SEXXv9bqEpIn19WuAT9nTc+QPR7rLHHM1lf2zRPkUfxWcw
         1nLenDIi1+mvACo6Mm705otwE6Z7cVlseTpHNfHEx7S0tcwqD1tyypcIBWmMFpJNRGLW
         3T36EiNAXAFI7obngxRdmXFIXMvHZGj8E2F1FuMWYFmk6rUbosODkyR+imP4400neD2n
         CmH0vS8I4HPfC/udKIai8uhel5v+6W7wVMk6wfsqlL2rctkL7lwTftJTJJ6hWsBCbZ9H
         uqVY1GP2XyR71y6R4M5iQBgEY9KqEA2XIm4qIs4BFBnb0Ux/ok8BQeUY9MAEiHJX9rNO
         mjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oTVBuXdvVKYBBykIgrHvs6bjfncjniRujXYZfONtSiI=;
        b=c+bJb2dd3PqP2obSioL2p3x1c6keXWUvVLR0iCjzORVdsXgds46VT8qNuSPSzirz5q
         rdCUGyrs9rQ/KMLJdviSFxGHbqjCOcwp78NLm1hWX31QhRX+EzLynswcLmbWu+JlDD+G
         vyn455A3xJWVbyS7vxAR7UHWoZflTo4rlUIw7QBWfC7i3vTjaLV/4rM7eNqJfct0WFI9
         aJKDb/056dpibb4fLtFmV//zm9ltnu/XN1Xom8eZHyJO+zkniNaSg7QQD1qcsgWNFiAe
         wcT3HU34sC0HM2ZVtiiOWZMLuxFGKpNuA02pOi8J/nMlA1vnbn9ELieecisOh7IfymOs
         q3Ow==
X-Gm-Message-State: APjAAAUgCXXVdYdwfrVsqI+WF71J0gFY71tEj+sS+++fBH3O+MBhyHAW
        BWuQMqReoSHRMXRPE/pSxwJ3ld6f
X-Google-Smtp-Source: APXvYqwhOaF2YYdhHD9UskUeC8hBkdJDZ36xpRzOnWmer+Tx2PmKc+JMPo+l7tJMTPPWF8EoB6BTVA==
X-Received: by 2002:a63:e80d:: with SMTP id s13mr6636745pgh.379.1553077753851;
        Wed, 20 Mar 2019 03:29:13 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id f2sm6109420pgn.43.2019.03.20.03.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 03:29:13 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 17:29:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] commit: improve error message in "-a <paths>" case
Date:   Wed, 20 Mar 2019 17:29:06 +0700
Message-Id: <20190320102906.12917-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I did something stupid today and got

    $ git commit -a --fixup= @^
    fatal: Paths with -a does not make sense.

which didn't make any sense (at least for the first few seconds).

Include the first path(spec) in the error message to help spot the
problem quicker. Now it shows

    fatal: paths '@^ ...' with -a does not make sense

which should ring some bell because @^ should clearly not be considered
a path.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/commit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index f17537474a..7f9aa032b6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1194,7 +1194,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	handle_untracked_files_arg(s);
 
 	if (all && argc > 0)
-		die(_("Paths with -a does not make sense."));
+		die(_("paths '%s ...' with -a does not make sense"),
+		    argv[0]);
 
 	if (status_format != STATUS_FORMAT_NONE)
 		dry_run = 1;
-- 
2.21.0.548.gd3c7d92dc2

