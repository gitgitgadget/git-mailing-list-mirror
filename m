Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9FC91F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbeHMOfN (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:35:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41023 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbeHMOfN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:35:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id s24-v6so8079468edr.8
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WwPL2CpDO14+FZyRWK58c6XIdkPBo1mldt0A6/+vric=;
        b=tFsGjhlNWCFsMByhWg5PJjpr2WZKGup1LXPbfZlrQ2Z/mnf0vAWkQr45NToNerq36m
         gwD9Q5u76/3LlEcqZ1c7abLw+3XikSyuZiTXiXHSAho+6suW6aZhIoTNWSrDuJOxF3CR
         8PCEK+di9mJJt7G5crgewNX28xM1PGVlus8vpgjDiWRMwY6zgaIuyza/HkUByp57N2pw
         do+XQYqL6/vgwICsmRh/lZX8mTFZh6zCxlxXWCrhvK3oJpJllNoVhzuriEovrr+6PyO+
         ZjkfWIA/jUsk5ka2ohoAEHZfDWhnToat4SlIz3lVr2ReqvO99LIwFUR/pi9cPUIpEgwE
         NUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WwPL2CpDO14+FZyRWK58c6XIdkPBo1mldt0A6/+vric=;
        b=VRBihYbE7rWKO+JUu5xQpMdX7av8GdjOcYctEJWPe34KxZ/2ho1gar9uTi7Qh+70re
         EYDUSTgyWM7fR2BASY4hbh+Vksvdt/IKxkEVWnfDLleH949w+CCcydVXA/XgLo7yB8Gw
         HN0tdEWGQUgWaczK3zk2yon7doxglrxoZ4RRDmtkA8jRDdA0YmAPTMdNdIU1txdoZzkL
         P8ZBqmVzYCIn8xSIL3SR4tjwpy9/k7uNstbOoWJQ1nhmD9pNvZOm60MGI4G/h7ku7IQ3
         gnxfExAWlUMD1lwd/bXDT1I+LRF9QJz/3oSS5jjoQh+ryG7bcCo5HUse602ug1IPMWbA
         AHQQ==
X-Gm-Message-State: AOUpUlEJktmP6tlbv4+g9xjICYcvjyWDLHGA+TQTaE+77vWBBM644ZD9
        enQkxF5ixVtRvRz51t+3By0=
X-Google-Smtp-Source: AA+uWPypDKQr40M09bpTpYoLD3gfLRrwFQ2s296is993SOgFhS8wlHQA+rKINTBj2w2H+g2v3fojdw==
X-Received: by 2002:a50:8345:: with SMTP id 63-v6mr21373473edh.5.1534161195064;
        Mon, 13 Aug 2018 04:53:15 -0700 (PDT)
Received: from localhost.localdomain (x4db0576d.dyn.telefonica.de. [77.176.87.109])
        by smtp.gmail.com with ESMTPSA id h34-v6sm9904030eda.58.2018.08.13.04.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Aug 2018 04:53:14 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2] t5318: use 'test_cmp_bin' to compare commit-graph files
Date:   Mon, 13 Aug 2018 13:52:43 +0200
Message-Id: <20180813115243.28295-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
In-Reply-To: <CAM0VKjmhnMfND8HwAvLChgZ6iFYuHUpD=C=3sqjkF9GUsLjpVQ@mail.gmail.com>
References: <CAM0VKjmhnMfND8HwAvLChgZ6iFYuHUpD=C=3sqjkF9GUsLjpVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph files are binary files, so they should not be
compared with 'test_cmp', because that might cause issues like
crashing[1] or infinite loop[2] on Windows, where 'test_cmp' is a
shell function to deal with random LF-CRLF conversions[3].

Use 'test_cmp_bin' instead.

1 - b93e6e3663 (t5000, t5003: do not use test_cmp to compare binary
    files, 2014-06-04)
2 - f9f3851b4d (t9300: use test_cmp_bin instead of test_cmp to compare
    binary files, 2014-09-12)
3 - 4d715ac05c (Windows: a test_cmp that is agnostic to random LF <>
    CRLF conversions, 2013-10-26)

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Same diff, updated commit message, including Derrick's Reviewed-by.

 t/t5318-commit-graph.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4f17d7701e..1c148ebf21 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -254,9 +254,9 @@ test_expect_success 'check that gc computes commit-graph' '
 	git config gc.writeCommitGraph true &&
 	git gc &&
 	cp $objdir/info/commit-graph commit-graph-after-gc &&
-	! test_cmp commit-graph-before-gc commit-graph-after-gc &&
+	! test_cmp_bin commit-graph-before-gc commit-graph-after-gc &&
 	git commit-graph write --reachable &&
-	test_cmp commit-graph-after-gc $objdir/info/commit-graph
+	test_cmp_bin commit-graph-after-gc $objdir/info/commit-graph
 '
 
 # the verify tests below expect the commit-graph to contain
-- 
2.18.0.408.g42635c01bc

