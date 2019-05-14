Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2CD1F461
	for <e@80x24.org>; Tue, 14 May 2019 18:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfENSsN (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:48:13 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36118 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfENSsL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:48:11 -0400
Received: by mail-yb1-f195.google.com with SMTP id m10so48253ybk.3
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xOCUZ94x/1qoVIO+uvPKWNBVbcVLSLgCya5+r0aWF3Q=;
        b=p/JDMbTF+k/aWepe5LNG+Kt+TKgqO3MFFf9YCv7CzPc+TI4ItaqPLPHNVNkN4G8BTN
         P4tSKtE+IjUwdWM4vXtnzwUfCuMl+ayC4eULC2LcLgfv+dp3rLaUG18o18rLUl4j7CYH
         NyAL7QzxIgCns9tFFfnCehey+Nv6SJvKy+uejJ3tihpD09b94ESZOpPDIzZCCGCOXe6c
         RtTx6lkOw9F9GGjsQodyeSEI33GxIu1V4sVObFq7iSYnpydGKtPIOtmW9tCVU0YaEVc4
         a2jhMLR/SjInsEMO2pcmyqmpjRRCKxB+Nz74dvocOBECxLw2xDDNzJc0RiWXArgnjnmb
         Yynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xOCUZ94x/1qoVIO+uvPKWNBVbcVLSLgCya5+r0aWF3Q=;
        b=jFWVKZcFAZANj/ZWwBOmayW9bPlD0hDcfYUqID3JjsLC899a9wF5NwW1GO+LN7YSYI
         DgkPQe3DVkP9hq1KlKdtQFXhIpmyIu1ofijvn2KoygOvcjAw32AnKxGNE836ce3Ld1Db
         jW47zBPL73gGo2SD4IROgOOZ+YEgz1ebbU92UBz5OiQCMn3lh0wBJNnvxY3iHFMyPqPB
         RHy9VnmGmVYb/J782Al3DUwEVNQV50cQ8yEHOLNDRk0nIamuwMr2NibjcInWE1N6QMdv
         ghyJOIgo7g3aIRt7xckhuvwtmChJh9CNpKe81DRvNKeaGf2eP9YLhkYX56RZQHuTWTwN
         VGAQ==
X-Gm-Message-State: APjAAAUG2rFPekVXy1scB0FHG6vG+2KHI+IPvEG2T1l9Ha7cjh7z0r+1
        J/mYxGJqOMbjQsBUQtwAtEl1hrGWQmA=
X-Google-Smtp-Source: APXvYqwR5Q3cjFr2+PKegOJgbfn9clfIG5iVFOVGlMmL9amY1Oh68XmUeGYTJ1xTdYFo9k0H2jRfcw==
X-Received: by 2002:a25:db45:: with SMTP id g66mr19216895ybf.509.1557859690231;
        Tue, 14 May 2019 11:48:10 -0700 (PDT)
Received: from linux.mshome.net ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u17sm3438627ywu.94.2019.05.14.11.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:48:09 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v6 11/11] t5319-multi-pack-index.sh: test batch size zero
Date:   Tue, 14 May 2019 18:47:54 +0000
Message-Id: <20190514184754.3196-12-dstolee@microsoft.com>
X-Mailer: git-send-email 2.22.0.rc0
In-Reply-To: <20190514184754.3196-1-dstolee@microsoft.com>
References: <20190424151428.170316-1-dstolee@microsoft.com>
 <20190514184754.3196-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'git multi-pack-index repack' command can take a batch size of
zero, which creates a new pack-file containing all objects in the
multi-pack-index. The first 'repack' command will create one new
pack-file, and an 'expire' command after that will delete the old
pack-files, as they no longer contain any referenced objects in the
multi-pack-index.

We must remove the .keep file that was added in the previous test
in order to expire that pack-file.

Also test that a 'repack' will do nothing if there is only one
pack-file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index c288901401..79bfaeafa9 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -527,5 +527,24 @@ test_expect_success 'expire respects .keep files' '
 	)
 '
 
+test_expect_success 'repack --batch-size=0 repacks everything' '
+	(
+		cd dup &&
+		rm .git/objects/pack/*.keep &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 2 idx-list &&
+		git multi-pack-index repack --batch-size=0 &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 3 idx-list &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 3 midx-list &&
+		git multi-pack-index expire &&
+		ls -al .git/objects/pack/*idx >idx-list &&
+		test_line_count = 1 idx-list &&
+		git multi-pack-index repack --batch-size=0 &&
+		ls -al .git/objects/pack/*idx >new-idx-list &&
+		test_cmp idx-list new-idx-list
+	)
+'
 
 test_done
-- 
2.22.0.rc0

