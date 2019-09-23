Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9311F463
	for <e@80x24.org>; Mon, 23 Sep 2019 18:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfIWSe5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 14:34:57 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:40042 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfIWSe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 14:34:56 -0400
Received: by mail-pf1-f181.google.com with SMTP id x127so9628702pfb.7
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wnJ6d45d2cIFdPiHFRiCK2XCleSgfPofzXGr9EgXkwE=;
        b=YgP3BfDcd+VjeUhera1N7/uB63c9DFEPaDPzTrCG/+7wrQYEl4GgRp2M/gcTtJ8upI
         GvS/pDzzgmsA6Sq8lArUoaYTwwAFS97WD6fGGTF028nWcqxV7kmwWD0cLff2vGk/eTKF
         iW6Sdg546USMgtGVZjGg5Jl9RF1Gbx0fey6Ay5Fy6Rr48YQCV0TAp2bP+9672LjEUw3F
         0bmtLpTtoveWUUp76A8Bj8JPsl/76ggiJzZ8PqLSGjetdzrMo9kdXAY7Bey1Gw7RJQwV
         5RBT7JDFleqC1dJ6iao7zLbj/8aBBA0xaUt+Km4SBBX4brXFIfXatYXoenX3BMOQCw1k
         a5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wnJ6d45d2cIFdPiHFRiCK2XCleSgfPofzXGr9EgXkwE=;
        b=kX65OGlnpH5DCQyf+rbRPjy6NXUuCfC4/9UI/NQa1Hu9HFGXmD6UG2lRLSI/nGtqcv
         n9j69DITH7w/yNEZEfzplWaP04pNCMmgotazeabvIWNg0dVYRT8RFQjAC1eRsrKDTQi9
         gaMaeQZ6Elk5ro9QvLdTYImZmpjBhX0BG3BN1UQU8Otphot8zMoP8XQ74ytoPO2GmYLF
         EsF+RrrXfv4Eh1rof9APGKNAaadh987+70nm3RuFaETMoYqrvWTlhYkivX8gb/4arnrO
         6hAQUwGc70qsB/8nNZM7yA9J56ddS66StEcWRouOppWiAGf3LaFyrRqbK9+f58qnlCN0
         8meA==
X-Gm-Message-State: APjAAAW9Pv6o716aLOF+OcFd5tCptC3aTTnAzF4YY9UqjY8Guzjeg5Hx
        kQqzyzAQemkA0ZrzoI3ygeXGvM2r
X-Google-Smtp-Source: APXvYqzzsa/r4p5wZmKd+6DioNavTUi3ywFYkaeqCVRV3ocJIuo3z7PCIFeXSeN5F7Gyf0Z48EhZcQ==
X-Received: by 2002:aa7:8e4b:: with SMTP id d11mr994733pfr.219.1569263695717;
        Mon, 23 Sep 2019 11:34:55 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id s1sm24221152pjs.31.2019.09.23.11.34.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:34:55 -0700 (PDT)
Date:   Mon, 23 Sep 2019 11:34:53 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] Makefile: use $(ALL_CFLAGS) in $(HCO) target
Message-ID: <0336d1345abfef563d9228e250316cc58a01f2b3.1569263631.git.liu.denton@gmail.com>
References: <cover.1569263631.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569263631.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On platforms that can run `make hdr-check` but require custom flags,
this target was failing because none of them were being passed to the
compiler. For example, on MacOS, the NO_OPENSSL flag was being set but
it was not being passed into compiler so the check was failing.

Pass $(ALL_CFLAGS) into the compiler for the $(HCO) target so that these
custom flags can be used.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f879697ea3..d8df4e316b 100644
--- a/Makefile
+++ b/Makefile
@@ -2773,7 +2773,7 @@ CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
 HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
 
 $(HCO): %.hco: %.h FORCE
-	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
+	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $(ALL_CFLAGS) $<
 
 .PHONY: hdr-check $(HCO)
 hdr-check: $(HCO)
-- 
2.23.0.565.g1cc52d20df

