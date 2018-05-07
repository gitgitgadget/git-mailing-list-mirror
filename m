Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED814200B9
	for <e@80x24.org>; Mon,  7 May 2018 12:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeEGMEM (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 08:04:12 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36503 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeEGMEL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 08:04:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id f2-v6so16672301wrm.3
        for <git@vger.kernel.org>; Mon, 07 May 2018 05:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3DtVBYBEdaldxOVXW/uNCiN+8tGppTCMO+iqOnc2tY=;
        b=qyeqI2szgnJMDi+OUldfav8S/MKE+J+u11teB/RtUj/5iOcjAKtHIA5TPF+wekltyn
         QuX4DeRcVK0tXsyVC3hwADKkV4VZtvMVTTGxLfkTOX3J/ACX0VWseYbEhLVr0A+CuL6e
         6vFbF3iywrXbk4NEU4SMUiQ8qhh51Mm2rT3MmBldH0z33plLdWC/x7wMKMpFZf2cP36W
         A+UW6Df6gMLQdNgQsag8DpJ2fMqlqMZwIVJnxs4Hrh9j/7NpNCdCW3hoyLRBYT0IKjqg
         jCpnDJcFR0ZkpqieE0XpB9Q/lJfYBRnPpziZlcYjF7JrdWan8BJ1q7z9JgKQX5Srw3Hn
         mK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3DtVBYBEdaldxOVXW/uNCiN+8tGppTCMO+iqOnc2tY=;
        b=WIKfhHqBiyVM+4Twx8l0CTvVw27kzfVaCV//fWJ8gYFny4XIqTQQdN1IWqrJ9za1u4
         SMz3YIZd8a9gZYQkAkq4vcQlQDz7ebigVlGRWz1V1Z/1VSCiTP+XJ8FP7g4U/8ufUFTp
         brt3oMf9J6jTK6gqSb7jPoRNzUG37Bb0gI1kPamyZp1pL/sqsIGi8q2SKZSLwIMd8ckR
         imK9c3XzgdzCe3mUymhpFxHEO4pNT3LBl6nv6DAq1BJ9khqBa5NtnbwoMkrFAlpNKzen
         SlHA40Zf0JGVzNm/xE28ZSKsdWCybYv4xq6CfrUK89SxMvcgBXDA2CVCzEJvOZTci2i3
         mghg==
X-Gm-Message-State: ALQs6tC95AkZoAu9uPN9d2Rj+0OOkKVGwWi5r944WDGal/0CQUcS87j+
        Ktw1llfPkSMIhf5E19kF3ZA=
X-Google-Smtp-Source: AB8JxZrgFa5mtp6C3AP2KX/3CIVFv/PtYGrALte+svks7uUZKZeF7DrI5kA8Q4IJTz8yJfcJHt5A7w==
X-Received: by 2002:adf:92c4:: with SMTP id 62-v6mr12223115wrn.226.1525694650078;
        Mon, 07 May 2018 05:04:10 -0700 (PDT)
Received: from localhost.localdomain (x590c55ee.dyn.telefonica.de. [89.12.85.238])
        by smtp.gmail.com with ESMTPSA id f6-v6sm17049667wrj.66.2018.05.07.05.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 May 2018 05:04:09 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t6050-replace: don't disable stdin for the whole test script
Date:   Mon,  7 May 2018 14:04:07 +0200
Message-Id: <20180507120407.4323-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.583.gcecc8b8e24
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test script 't6050-replace.sh' starts off with redirecting the
whole test script's stdin from /dev/null.  This redirection has been
there since the test script was introduced in a3e8267225
(replace_object: add a test case, 2009-01-23), but the commit message
doesn't explain why it was deemed necessary.  AFAICT, it has never
been necessary, and t6050 runs just fine and succeeds even without it,
not only the current version but past versions as well.

Besides being unnecessary, this redirection is also harmful, as it
prevents the test helper functions 'test_pause' and 'debug' from
working properly in t6050, because we can't enter any commands to the
shell and the debugger, respectively.

So let's remove that redirection.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t6050-replace.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c630aba657..199fbc78a3 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -4,8 +4,6 @@
 #
 test_description='Tests replace refs functionality'
 
-exec </dev/null
-
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
-- 
2.17.0.583.gcecc8b8e24

