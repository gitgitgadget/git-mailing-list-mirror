Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 398011F404
	for <e@80x24.org>; Mon, 17 Sep 2018 19:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeIRAqy (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 20:46:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33998 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRAqx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 20:46:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id g33-v6so18497554wrd.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 12:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uYqL4pjcdswnFwrk5XcepE91FNFiHEMjt9MX5gvNWQ8=;
        b=N0SBZxEz43zlJECn7mMpPIIVyLKdZCRLz0ZNUnzW7quZmiy9ivkMjHQp4f+BdOZzKv
         dnOrXJLpa5uODc+K8LRu3okcsOgtgPnTbd56gWWix1VKyj1wtiaoNvKklFxoT6V++I86
         y0nPqaYRNtEQTpIKN8hjC5EY9/wKCFixK2LYwD879BRlM/a0voEhGoeg0wnfWB7DC+7U
         uId/B5vNfK8ZOF4omRiEJgB1tdw4ZfaNFndl2RFY8wpk1NK9ypGgQR4ggXcGbaycEB03
         7Kyi/CeetHckkCoZOgvbvQIGeVAtgStdYzk8S50JP6h8W+AABKnlDxMTBBfkxeMH7Wu/
         xPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uYqL4pjcdswnFwrk5XcepE91FNFiHEMjt9MX5gvNWQ8=;
        b=NdMc8LR9CXf0dGK9bHl4Qhks29vjq0d1V5Hy+WpU+fwDwypOOAoUDqtmrDME7DSUAW
         p5Tek5rScuyO5Nzqa2+vJAINHeiH9LeOkatZ2mENNqPllBOh1nWF7oMYajHZWepHJZnW
         PkPlxDFJmxoHyMYpCUNrfwIXIYZqbQ462WxfRnDqMdOF32074TPz1vtGiuRv2RHST3vi
         /OA2WsfA81guqT0ImP9h+C3LvrSKYPt7/tEJgf/3KR+gW83+LbAKcPp9iSftDeINZ0c0
         wmu5ygSZTkTzhWOJYCdpcqa+/a37ESJ4MbD0li3VTY7GIjXMs5FyLadPXC3D1l72V4rU
         3c3w==
X-Gm-Message-State: APzg51Br447Fxqn3HNi37Qf/MgiP7Gx6OOWcUWfp+7BzlI519yTMMOl5
        xwrzGfUNj/xLdXzSzqV0ycGDhzB6
X-Google-Smtp-Source: ANB0VdYnQsLaouLmrmwGamdvtNfMOgJFHsWCQ+BSi6HEBqh96DPSOLLUOZ8nmLE4883zzsNTr0xFcQ==
X-Received: by 2002:adf:9543:: with SMTP id 61-v6mr19409062wrs.25.1537211890512;
        Mon, 17 Sep 2018 12:18:10 -0700 (PDT)
Received: from localhost ([2.28.194.193])
        by smtp.gmail.com with ESMTPSA id g2-v6sm32647wme.20.2018.09.17.12.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 12:18:09 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] t5551: compare sorted cookies files
Date:   Mon, 17 Sep 2018 20:18:06 +0100
Message-Id: <20180917191806.19958-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t5551 we check that we save cookies correctly to a file when
http.cookiefile and http.savecookies are set.  To do so we create an
expect file that expects the cookies in a certain order.

However after e2ef8d6fa ("cookies: support creation-time attribute for
cookies", 2018-08-28) in curl.git (released in curl 7.61.1) that order
changed.

We document the file format as "Netscape/Mozilla cookie file
format (see curl(1))", so any format produced by libcurl should be
fine here.  Sort the files, to be agnostic to the order of the
cookies, and make the test pass with both curl versions > 7.61.1 and
earlier curl versions.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t5551-http-fetch-smart.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 771f36f9ff..d13b993201 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -206,7 +206,7 @@ test_expect_success 'dumb clone via http-backend respects namespace' '
 cat >cookies.txt <<EOF
 127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
 EOF
-cat >expect_cookies.txt <<EOF
+cat <<EOF | sort >expect_cookies.txt
 
 127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
 127.0.0.1	FALSE	/smart_cookies/repo.git/info/	FALSE	0	name	value
@@ -215,7 +215,7 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 	git config http.cookiefile cookies.txt &&
 	git config http.savecookies true &&
 	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
-	tail -3 cookies.txt >cookies_tail.txt &&
+	tail -3 cookies.txt | sort >cookies_tail.txt &&
 	test_cmp expect_cookies.txt cookies_tail.txt
 '
 
-- 
2.19.0.444.g18242da7ef

