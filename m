Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3451F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 23:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408048AbfJWXch (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 19:32:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38722 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408036AbfJWXch (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 19:32:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so10869595plq.5
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 16:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IOeTVmmZVJQe3kVFopFCYfHEb9Ewsc1QeqbX8kcg12c=;
        b=h4Miqp5uC2tmScBfFsJXYphzg3zrWtBedzJqJfjNdWFwxR9W8wNmQfihfNXtdNLKVF
         2bwwU7IRMy+y3hCfOxJ/3uJ4NsnV4GKQFPjj5FiVYX/nJws1nZOXB5ua1108EulIPmlo
         m2rwyc7nsFcl/QCH78de4O3hBIBkOVe6PFF2Ap1rqsy3EMxkJHQE9JM0qeT+F7fXd/Pz
         wgtuENL6NK0ABLpw8orEjedcjl5WAfTBnB0X/rES3RNiWfoyYa8fGcGmgT1Hp1fIEAf5
         kkH3DMNmC4gTLEKkqZFo2FLF0QamS0Pd1WZNyWKp5kBCPMTWyBGWu0XyaR819VZKrMMo
         odLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IOeTVmmZVJQe3kVFopFCYfHEb9Ewsc1QeqbX8kcg12c=;
        b=EKpUPpR1/aaBux1B2QSQrndBw8FJ6vWjSDQr8yCGOeROCN0rJxTQu9PmbbvOCIPZOC
         ABqmYusyF7hwPFPbPvQSOVj9QsMoOPexR+1MVUyagKlcPBbSCMACli5Mnse2a2Tgz+Cf
         4EKHBdQeTWMqg42N0YIgwAbxcV+8aC23A3WiK1lUpltQTye3ESXoe2xHiwyAelte+Mo2
         lgxoIk1b7uCDwswUrs9CN27jnllb54GYFftr7k/rgnopkY8+RUf9oPyHGEff/Ada7JUZ
         etHVEdWZbW1nSJvlYSArNrYFtJSskyf/+CIB0QxmTJyuvHxCg/HZeE7iWjNlcNuy8VCf
         cgcQ==
X-Gm-Message-State: APjAAAWnkCnivVaYcltMipBTrFmm1gM6UNqftBrdUTHUrNQbaWkhteRQ
        DMVqVvWdP5VePxYh0pXGaUZeMMf8
X-Google-Smtp-Source: APXvYqzoDGel2nuAl7PqFP8809bPZRvTp9Vi+3qCo4D+Lci4CxBqx7EwFjipoFyOvhI77+dBYova/A==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr1134454plo.247.1571873556425;
        Wed, 23 Oct 2019 16:32:36 -0700 (PDT)
Received: from generichostname ([204.14.239.55])
        by smtp.gmail.com with ESMTPSA id w29sm6128611pgc.10.2019.10.23.16.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:32:35 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:32:33 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/5] t4108: use `test_config` instead of `git config`
Message-ID: <43c42b299eb8a4e3a1cc529f1b799ed0edb3e720.1571873435.git.liu.denton@gmail.com>
References: <cover.1571832176.git.liu.denton@gmail.com>
 <cover.1571873435.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571873435.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since `git config` leaves the configurations set even after the test
case completes, use `test_config` instead so that the configurations are
reset once the test case finishes.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4108-apply-threeway.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index 3c0ddacddf..7f96ae9101 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -70,7 +70,7 @@ test_expect_success 'apply with --3way' '
 '
 
 test_expect_success 'apply with --3way with rerere enabled' '
-	git config rerere.enabled true &&
+	test_config rerere.enabled true &&
 
 	# Merging side should be similar to applying this patch
 	git diff ...side >P.diff &&
-- 
2.24.0.rc0.197.g0926ab8072

