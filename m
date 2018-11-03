Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3F6F1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeKCR7m (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:59:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37264 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeKCR7l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:59:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id c4-v6so3738330lja.4
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mEvviRJvKR2A2kQsNmxIWhLTy4AD0vSBWn5dZRTicao=;
        b=uUh1IqD0+iYKMs28e3GSnFtNrFME+p62ifrw2rfmLzjC62FOVGwQIjcW5aceAWpTIr
         F5WwnhdZvbXXctZBm6bXmkDkRzDmnXda3id3KNWXRc1TPZ9OHcnvyxs1Cql7xAMOjvZH
         JBWENmPLjwJEz5nrqJG1ibhkEwroXud+RbnKka3CovhT5vxWd1Kry51FD/0x3EmuL+wJ
         GgWxOrP1Hx/fcKRyLk2q+pVdyYmeNakU/IEd6tLiRjuWfHaB+dvYbiCug9FbFSfnIzX7
         5tljrx7wrbBLCDt8wKvFUfViFyCADrt+68vd1SatAlvfYQTgdVrYcQ2u9ZZsaBAcJDZn
         +I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mEvviRJvKR2A2kQsNmxIWhLTy4AD0vSBWn5dZRTicao=;
        b=OKhVY0J3rGcX7t8LE3kmRscNxcn2HmSXctB8RVE7ACKpCsC3PwMW0iyp/ZuVbHR5d4
         Ay7xPawrRH56CktwHNJgL68BeMnHV3vpsF5NrPfMU8XEGj8AoCCkoOtbPfGXX0RpEvuT
         U6yT7YTJHxLn4ONZaq9cziU+j1TMqSErsLK/2xg4aF5VJnxMlgAVzFKG+xg0mPUX+Lop
         hzDRz2p/8P5TA74pCuDXiwpsWmUq4su/yD8ws6mrAPVCvxH8e0tNKx6a4xGf8cyBP4FQ
         tV6P0+gBXHeOejX2CIZbwLElN/tdsTvxzOav20tCw/0UXYniZroxUB6oslDFjfV6uG4b
         KgGA==
X-Gm-Message-State: AGRZ1gIDeKDts7oIhtwpAPfJ6MbWApuMY3Us4z5PrUuba2CJGZ+LPmYU
        yJqPMszbCV7zfmrTCzjJfgA=
X-Google-Smtp-Source: AJdET5e1vpLKaeXWbgKF5Ir/5zgd8VcUC8BNmmT6tjAT0xOpYjhGQEHPc9kmRERSncYL3k5PCil92w==
X-Received: by 2002:a2e:7217:: with SMTP id n23-v6mr8316220ljc.71.1541234943694;
        Sat, 03 Nov 2018 01:49:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s191-v6sm657373lfe.17.2018.11.03.01.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 01:49:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v3 02/14] run-command.h: include thread-utils.h instead of pthread.h
Date:   Sat,  3 Nov 2018 09:48:38 +0100
Message-Id: <20181103084850.9584-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181103084850.9584-1-pclouds@gmail.com>
References: <20181027173008.18852-1-pclouds@gmail.com>
 <20181103084850.9584-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

run-command.c may use threads for its async support. But instead of
including pthread.h directly, let's include thread-utils.h.

run-command.c probably never needs the dummy bits in thread-utils.h
when NO_PTHREADS is defined. But this makes sure we have consistent
HAVE_THREADS behavior everywhere. From now on outside compat/,
thread-utils.h is the only place that includes pthread.h

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 run-command.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/run-command.h b/run-command.h
index 3932420ec8..9b7f38202c 100644
--- a/run-command.h
+++ b/run-command.h
@@ -1,9 +1,7 @@
 #ifndef RUN_COMMAND_H
 #define RUN_COMMAND_H
 
-#ifndef NO_PTHREADS
-#include <pthread.h>
-#endif
+#include "thread-utils.h"
 
 #include "argv-array.h"
 
-- 
2.19.1.1005.gac84295441

