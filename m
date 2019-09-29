Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DFA01F463
	for <e@80x24.org>; Sun, 29 Sep 2019 00:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfI2A5G (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 20:57:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39866 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfI2A5G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 20:57:06 -0400
Received: by mail-io1-f66.google.com with SMTP id a1so27957086ioc.6
        for <git@vger.kernel.org>; Sat, 28 Sep 2019 17:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f527cBm5hHiU3TB11TmtQ2zXDSWB9HMJsiTHUHhZwpY=;
        b=VqCwOX9amNuoV4eApnUtJBv95D1M0zxXfvCtjRSgpwBXSqdomAluiMnTRHXmLmQzI3
         Qfgi/y7HjOn1SGcOylwsw/3MgebtlJK2iF+fFL495SkF3DSOJV0NgqiDvZEbywIjOFBn
         dObC4+rJ7H2nWTG5MgNdmeYqDTsyLCLfol77976/lB7v4TJ/P3USPPQJC5BT2wgEcatT
         XwoasD7wWFsKKVGZUq5eCbJrTQtsWQ1EolL8dvaLIG5GaLy8l9qfNRIM0zCRluE+pckO
         /xK4Vy7D0y8zSooQyTXsyyvTkn/d0F4ueCbskXdLMt52d+Po8AMkzQ4284N3cK0hWbm2
         GEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f527cBm5hHiU3TB11TmtQ2zXDSWB9HMJsiTHUHhZwpY=;
        b=teQAwonGWeodexAfK8mDtb2lfNdHlKzmgj2admeIFKlYDWcuiwwANcOo0QLRmK+j5s
         ED9yDfd0kEda5E6Sn7NJNvmS3Fgzjw5wFKN+GvfCnfW4Q5l1lmsNL94lsrdwXSJL2NPP
         dXUJZ2RwSwVHovR3y508I1tmIvZVEBd5OszXBU+F+FWVZ+kbZ5SvzbKn1Hq55E6A8g5z
         CUo3zKjEkwZLVwIJ63wOhY5H4xrx27Mbm05ScuQSRENZVcwTrmNDwnVlsho+HrZx/kRI
         g06Z2/jXZMdfo4M5kVoeL1gTfk6A168dhkgBb5OppTOliXQ4XZozBIF2okDWnI3/S5bE
         Elvg==
X-Gm-Message-State: APjAAAVZi0K4amraPTdkTzhdwT/tdntYecp77bwIcg5OcpJiqWCapmx4
        en/yKTttGD+/9+9JcTDBQ/E/y2xCA0k=
X-Google-Smtp-Source: APXvYqw4rJAoKgD/dBOs9v04yW9zupT3wK/qNtRhzyefSSt1qUOGtTR2WsrqO83zuqbkhd5RjnUDWA==
X-Received: by 2002:a6b:4f0c:: with SMTP id d12mr6977348iob.214.1569718624879;
        Sat, 28 Sep 2019 17:57:04 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:3837:c90c:13fa:5c01])
        by smtp.gmail.com with ESMTPSA id j6sm3096427ilr.2.2019.09.28.17.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2019 17:57:04 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, dstolee@microsoft.com,
        Johannes.Schindelin@gmx.de, peff@peff.net, davvid@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3] wrapper: use a loop instead of repetitive statements
Date:   Sat, 28 Sep 2019 18:57:01 -0600
Message-Id: <20190929005701.734095-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A check into the history of this code revealed no particular reason for
the code to be written in this way. All popular compilers are capable of
unrolling loops if it benefits performance, and once this code is
replaced with a loop, the magic number 6 used in multiple places in this
function can be replaced with a named constant.

Reviewed-by: Derrick Stolee <stolee@gmail.com>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 wrapper.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index c55d7722d7..c23ac6adcd 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -469,13 +469,12 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 	filename_template = &pattern[len - 6 - suffix_len];
 	for (count = 0; count < TMP_MAX; ++count) {
 		uint64_t v = value;
+		int i;
 		/* Fill in the random bits. */
-		filename_template[0] = letters[v % num_letters]; v /= num_letters;
-		filename_template[1] = letters[v % num_letters]; v /= num_letters;
-		filename_template[2] = letters[v % num_letters]; v /= num_letters;
-		filename_template[3] = letters[v % num_letters]; v /= num_letters;
-		filename_template[4] = letters[v % num_letters]; v /= num_letters;
-		filename_template[5] = letters[v % num_letters]; v /= num_letters;
+		for (i = 0; i < 6; i++) {
+			filename_template[i] = letters[v % num_letters];
+			v /= num_letters;
+		}
 
 		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
 		if (fd >= 0)
-- 
2.23.0

