Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFC8320A10
	for <e@80x24.org>; Mon,  2 Oct 2017 00:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbdJBAdO (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 20:33:14 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:56926 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdJBAdM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 20:33:12 -0400
Received: by mail-pf0-f181.google.com with SMTP id g65so2126090pfe.13
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 17:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CzQaJqa5X96wm+8XIbvcj4u4AYRt7ySHPDeSn5r0FJM=;
        b=p7FHGeZmzxYb9Ke4ITxZfSbiE1srU6lxB6hzFz0cA3tvXS0Of5iFPVXx3mKIWENPuh
         PQYgSVAT7LJOg5yRIWyPsGeWmQIohQ/U724d+ppJGJd0CZcDBcvN86UlRb5onILUC2uM
         xL0gpMuGLQzYWQGzweB67eZH+yrgMjE8I/Mcca2nqa/uEDKJuCX6RcBQJRtIV+4w3lFp
         9UXMIi5Gxu+SQhYaAMyfftaSaLdqGvPzoMzPnqhGEByspaXyLLJ1c3eR9ft3thLRMHoT
         VquR3UJdZjviqinWIITMbq+9Zhvyk6mfUep9qHy7vdUBxjBJrddaOHpE34bUFvGd4+LK
         dgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CzQaJqa5X96wm+8XIbvcj4u4AYRt7ySHPDeSn5r0FJM=;
        b=UUXejpxXlJrdHyA525dztjlI00F697XJC6Y9+M7yvxxXci5aMptEpX5sXO3+Lh1vhg
         BOU6OkJF1YXfHcLtuIVZWoZMJwuMBrIWZaMbGKF0JEn/pbUZlZa78//MFmqamy5LQxu7
         oJLsUz2nE/TAsjPTir7G9iUEeCNF6WiB5GiD4eWfCR5FAIWMiajX9qxyD9L87IyJ/UKi
         cWfL4oJwv75B32MaKZyym8c4dUtoBxitrUeljdXSswCze2ez7BF4lEYLWGTWZQFVadv0
         +DhV+eiFyv48Je2YG2j6lwlcvLNb5s27M+f/WCNtYb4Nhqlz+F/wRP7S4dvM6OCuXVMb
         SIpw==
X-Gm-Message-State: AHPjjUg1k6+spQvm6ROXmUBzPlTpml9uugCFxYNjKjlSe82K/qUhkRPZ
        GHkPwdw3Ar+mcbI5rWFWxMEZRVuMY8o=
X-Google-Smtp-Source: AOwi7QB6oFO2Aju0YsQj9fwONQJy57DYTD/hPsJpTgMosiXHxvLxX/MFDFbvK0YPMXANHrhDujkipA==
X-Received: by 10.84.238.15 with SMTP id u15mr12979432plk.217.1506904391530;
        Sun, 01 Oct 2017 17:33:11 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id n68sm13062123pga.39.2017.10.01.17.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 17:33:10 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v5 2/6] t6300: refactor %(trailers) tests
Date:   Sun,  1 Oct 2017 17:33:00 -0700
Message-Id: <20171002003304.77514-2-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20171002003304.77514-1-me@ttaylorr.com>
References: <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
 <20171002003304.77514-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently have one test for %(trailers) in `git-for-each-ref(1)`,
through "%(contents:trailers)". In preparation for more, let's add a few
things:

  - Move the commit creation step to its own test so that it can be
  re-used.

  - Add a non-trailer to the commit's trailers to test that non-trailers
  aren't shown using "%(trailers:only)".

  - Add a multi-line trailer to ensure that trailers are unfolded
  correctly using "%(trailers:unfold)".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t6300-for-each-ref.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2274a4b73..39431908d 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -605,18 +605,25 @@ test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
 cat >trailers <<EOF
 Reviewed-by: A U Thor <author@example.com>
 Signed-off-by: A U Thor <author@example.com>
+[ v2 updated patch description ]
+Acked-by: A U Thor
+  <author@example.com>
 EOF
 
-test_expect_success 'basic atom: head contents:trailers' '
+
+test_expect_success 'set up trailers for next test' '
 	echo "Some contents" > two &&
 	git add two &&
-	git commit -F - <<-EOF &&
+	git commit -F - <<-EOF
 	trailers: this commit message has trailers
 
 	Some message contents
 
 	$(cat trailers)
 	EOF
+'
+
+test_expect_success 'basic atom: head contents:trailers' '
 	git for-each-ref --format="%(contents:trailers)" refs/heads/master >actual &&
 	sanitize_pgp <actual >actual.clean &&
 	# git for-each-ref ends with a blank line
-- 
2.14.1.145.gb3622a4ee

