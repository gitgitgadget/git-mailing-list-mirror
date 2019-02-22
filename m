Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEC4F20248
	for <e@80x24.org>; Fri, 22 Feb 2019 20:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfBVULU (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 15:11:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33030 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfBVULT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 15:11:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id h22so9629444wmb.0
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 12:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZNDxXppE7nH0fWCErNbMZhZ1yF5puIu3VXNpVSWJHrQ=;
        b=KdCAV/ziBJC0otZCAjytpwgkltEFWP8jLAPdyO8MDSwDnJTL9wRkZ6x8qj9lPQWKBl
         esbBFp8COPz5oyq2p2iHIPo6a5fpypG6yA/QrPBURvVv0Uz8xMVb8pfe7KW94xTPRlG5
         KyBpAiq9Xhyw7E/XYKKD7M2u6KlrqbcgsIbw6u8ljahffBQTfPnKcqs7s0woMbQkTjfM
         QJwcjX7o3AI9diN+iyMxpKTEVGn6YCm88n/LlwDUr+Oyv8t9nLEKh+CDJb9C5fY2ncob
         sRFelk+yU09SKGwbEkykQKI/1QIn9cS3uH7arSW1W7FUvABKg5BeNMD2XQyuXk/N8pFO
         DCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZNDxXppE7nH0fWCErNbMZhZ1yF5puIu3VXNpVSWJHrQ=;
        b=EKBPUHaLKRlsEnuPMN/Z2nEdmsT2CBIgbTXWVMxJK/A+iF2b0DYHb42v64oGbVeOz+
         dL1pmYiQ3ZYnq9l6WQonFlHoFTLazxsRgJqhiP/Wm80Ta3cI4XAQsQVOJA3a/RrAPNyY
         nNJNB2VpeaQEJl2SBbR5KdyDcJ+2zFf6MdRy7C34l72LFcziHIXvX3y7hwhoD1/O8AjB
         TbjeOGlULW8FMETiFt2Fx488XZyk80ms/C/GjLBRZh6I7jLhBI4W6y+1Ni57DdgijIZ5
         36bEziw+N4b4XUSaRWSBLXcQwhOHemux6Ny3Ddzg5DYiQzOsRrB6SQipeEzgmTN2n9Xg
         TFfw==
X-Gm-Message-State: AHQUAuYI3h/YuU6ieGvlGWE3fLJ4dNTtCwSGmlyZ/JSw2d5LCj2BY02s
        eIC+TmBYKbWKyocOWK/Y2yF0fMJF
X-Google-Smtp-Source: AHgI3IY22O8rHVNuZ9q/UnJdUEpulNAsoi8snUser7rRxcPyNb9kvpIKQ8p7H4yhTY+vNjOv/t/Kvw==
X-Received: by 2002:a1c:e701:: with SMTP id e1mr3456416wmh.1.1550866277191;
        Fri, 22 Feb 2019 12:11:17 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c8sm1312116wrx.6.2019.02.22.12.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:11:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] format-patch: notice failure to open cover letter for writing
Date:   Fri, 22 Feb 2019 12:11:10 -0800
Message-Id: <20190222201111.98196-3-gitster@pobox.com>
X-Mailer: git-send-email 2.21.0-rc2
In-Reply-To: <20190222201111.98196-1-gitster@pobox.com>
References: <20190222201111.98196-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The make_cover_letter() function is supposed to open a new file for
writing, and let the caller write into it via FILE *rev->diffopt.file
but because the function does not return anything, the caller does not
bother checking the return value.

Make sure it dies, instead of keep going with a NULL output
filestream and relying on it to cause a crash, when it fails to
open the file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c           | 2 +-
 t/t4014-format-patch.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index f2d1fbf18a..ca86611efe 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1050,7 +1050,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	if (!use_stdout &&
 	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
-		return;
+		die(_("failed to create cover-letter file"));
 
 	log_write_email_headers(rev, head, &pp.after_subject, &need_8bit_cte, 0);
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 909c743c13..b6e2fdbc44 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -589,6 +589,12 @@ test_expect_success 'excessive subject' '
 	ls patches/0004-This-is-an-excessively-long-subject-line-for-a-messa.patch
 '
 
+test_expect_success 'failure to write cover-letter aborts gracefully' '
+	test_when_finished "rmdir 0000-cover-letter.patch" &&
+	mkdir 0000-cover-letter.patch &&
+	test_must_fail git format-patch --no-renames --cover-letter -1
+'
+
 test_expect_success 'cover-letter inherits diff options' '
 	git mv file foo &&
 	git commit -m foo &&
-- 
2.21.0-rc2

