Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B0A20282
	for <e@80x24.org>; Fri, 23 Jun 2017 15:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754478AbdFWPQ7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 11:16:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34243 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754413AbdFWPQz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 11:16:55 -0400
Received: by mail-wr0-f196.google.com with SMTP id k67so13225201wrc.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 08:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IWno4OEvfBOPA894p/3VeSO/tbmw2vRT3mw1k4aJVL0=;
        b=ibRWie+tbOxmwfOXJ9+ScQotM6dR01KpgmtuRnVunmpG7ZzOJpUTEeoa4y5TlWsiok
         KQqBaGL+58ncRzFdVIh7C+1HNJx/aVo0iHKIVTe0lNVzH3bZEuvD5xX2OPBMd40eOkWc
         9JZyJGIRnlW2V8ltrw6aRssA+Ks/ovmClL89BiCW1NjtIJwvCxv7GBLWwEOISUIEs7gs
         viZRrr9HocEEF9w79dwBWJ/MhkkNC2megbMwOdfhg9hkfC3J425MGEa3bx0PJvFEz9gC
         VgKAaHu7DcYZ3d4nLZ/Wq6hX1M0/a52vZrFYEZIKNBZsgS1wUpGTI60AOj5ZSTY3xTYv
         g9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IWno4OEvfBOPA894p/3VeSO/tbmw2vRT3mw1k4aJVL0=;
        b=fZ6lIup7c2Eg8N4xGU3/OQaLJl7EF57GTN9G2+8KyYgtc10n3AVeBnYV3OITEuccDX
         W3kLvffX0diEaVNZ/H6YOrOpSMP5lfpReaVJpJ0e9Ks+hPE9KrYD4RnAR+tNSWIRj4p5
         IWDG6hLjFHkK5mnBwISEG7Cqh3Sr5lV2befrTaOM852gG0jrCv0m/0ELIJI9pUiY/hxy
         aW03mS4wa3YYUrqonHGn2SZ4sBShfGm34ICTRuJw0BGDdaGxMkjs4cyCmxHoENdGHtzl
         vDmh0wVwtqE3r1Ce0/w+vwLG+X8FvP73LBcUAymHxLIxXpihzja8XnlcO7YcnLyCJbh6
         keRA==
X-Gm-Message-State: AKS2vOzwe9iZ2kIR11LGzIfIuvNjgVO/EDsHS89vHKokm5KeEOWV4Hht
        D76Uoc+ob5xFUCJs
X-Received: by 10.223.129.47 with SMTP id 44mr5985917wrm.179.1498231013880;
        Fri, 23 Jun 2017 08:16:53 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id z75sm4405186wmz.8.2017.06.23.08.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 08:16:53 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/3] t1700: make sure split-index respects core.sharedrepository
Date:   Fri, 23 Jun 2017 17:16:40 +0200
Message-Id: <20170623151640.24082-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.519.g0a0746bea4
In-Reply-To: <20170623151640.24082-1-chriscool@tuxfamily.org>
References: <20170623151640.24082-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a few tests to check that both the split-index file and the
shared-index file are created using the right permissions when
core.sharedrepository is set.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index af3ec0da5a..2c5be732e4 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -370,4 +370,21 @@ test_expect_success 'check splitIndex.sharedIndexExpire set to "never" and "now"
 	test $(ls .git/sharedindex.* | wc -l) -le 2
 '
 
+while read -r mode modebits filename; do
+	test_expect_success POSIXPERM "split index respects core.sharedrepository $mode" '
+		git config core.sharedrepository "$mode" &&
+		: >"$filename" &&
+		git update-index --add "$filename" &&
+		echo "$modebits" >expect &&
+		test_modebits .git/index >actual &&
+		test_cmp expect actual &&
+		newest_shared_index=$(ls -t .git/sharedindex.* | head -1) &&
+		test_modebits "$newest_shared_index" >actual &&
+		test_cmp expect actual
+	'
+done <<\EOF
+0666 -rw-rw-rw- seventeen
+0642 -rw-r---w- eightteen
+EOF
+
 test_done
-- 
2.13.1.519.g0a0746bea4

