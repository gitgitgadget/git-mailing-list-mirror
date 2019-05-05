Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 079D01F45F
	for <e@80x24.org>; Sun,  5 May 2019 02:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfEECja (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 May 2019 22:39:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36997 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfEECj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 May 2019 22:39:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id z8so4612478pln.4
        for <git@vger.kernel.org>; Sat, 04 May 2019 19:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Bp9R/UiJXcaI6bcaRe6zl3rUTOhIr2xaoi90O2lKcs=;
        b=JcNCzm2+V0jgrqqJjVy2oV8QlLXJMS6j7Fg63YfBFm3xjvSY9FTGbN/L6CJW4nK44A
         qoUqK/9hvcGiq1214DmoRA/1eLF/38DFER2V46Q8i87rFPZ/9SjYsR+yj3at7oC1mIWp
         JVl5JpJIYO21vRXeigoxT7vdtRw3Oe+Txz73eVyfH56pqWW8oiSj/1wfVSfUORPcRPB6
         vBf0udb3OC/aX7zzzJW+8LRt8ij5YDkgq+SEF5k876zhFiWfjvL00a4QSRNkEI93ZJWS
         3dzgdYqg3ke/Hbzn4+DGlwmw5/6M1ZTL4g1KAD1BQXbA0qzdc7M2qxwh+7k5EivAb7B1
         0fZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Bp9R/UiJXcaI6bcaRe6zl3rUTOhIr2xaoi90O2lKcs=;
        b=lmpgPWst/fog8GBs/C1Pdob0cmFU9qvkN/BWyVRwcMuaMJ4+IG75xD1vPW0YRg9/xx
         dxiD4xYsQqlreISQZifF+brA1z8TRREM7USgSuBedfcuuOzBefNf1AJkjbanQvwhi0Qt
         TOwv3E4HBsFQ682GwurtlsceNZhSCEFzHJ/6xRbjDdicEJSodXGVThbwLxYzxLfi5R9o
         m6B36e7ov/JiLfvL5aZeQ436bMVufChO4N0R0CPGHs7qDIaTQNew841naT0PTJ6Q6Evo
         5Ejw13jL8a5F1cC7u4cz+f30brTgkSy4Y+W8/Dy/UHmKnNowDkfZdX3aTFvcB32PNaCt
         q/xA==
X-Gm-Message-State: APjAAAWAsgcJc+i/yvvellEieP3BKYCqugurY1zCB7dYuMZJpTZSwG9+
        Uk0J1UD0eX3IBNtqEnHQtncR8cstTqA=
X-Google-Smtp-Source: APXvYqzBbmhIasi+Cz/dK+w6w70Rr0T/tOnSMuDvB7Xc17L0FX6WpE7D4SMvvVfEQlS8TedU4LJCug==
X-Received: by 2002:a17:902:100a:: with SMTP id b10mr17764495pla.239.1557023968963;
        Sat, 04 May 2019 19:39:28 -0700 (PDT)
Received: from MBP.local.hk ([202.189.108.96])
        by smtp.gmail.com with ESMTPSA id 15sm7944278pfy.88.2019.05.04.19.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 May 2019 19:39:28 -0700 (PDT)
From:   Boxuan Li <liboxuan@connect.hku.hk>
To:     git@vger.kernel.org
Cc:     Boxuan Li <liboxuan@connect.hku.hk>
Subject: [PATCH] t4253-am-keep-cr-dos: avoid using pipes
Date:   Sun,  5 May 2019 10:38:52 +0800
Message-Id: <20190505023852.33986-1-liboxuan@connect.hku.hk>
X-Mailer: git-send-email 2.21.0.777.g83232e3864
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exit code of the upstream in a pipe is ignored thus we should avoid
using it. By writing out the output of the git command to a file, we can
test the exit codes of both the commands.

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
---
 t/t4253-am-keep-cr-dos.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t4253-am-keep-cr-dos.sh b/t/t4253-am-keep-cr-dos.sh
index 553fe3e88e..5408c23dca 100755
--- a/t/t4253-am-keep-cr-dos.sh
+++ b/t/t4253-am-keep-cr-dos.sh
@@ -51,14 +51,16 @@ test_expect_success 'am with dos files without --keep-cr' '
 
 test_expect_success 'am with dos files with --keep-cr' '
 	git checkout -b dosfiles-keep-cr initial &&
-	git format-patch -k --stdout initial..master | git am --keep-cr -k -3 &&
+	git format-patch -k --stdout initial..master > actual &&
+	git am --keep-cr -k -3 actual &&
 	git diff --exit-code master
 '
 
 test_expect_success 'am with dos files config am.keepcr' '
 	git config am.keepcr 1 &&
 	git checkout -b dosfiles-conf-keepcr initial &&
-	git format-patch -k --stdout initial..master | git am -k -3 &&
+	git format-patch -k --stdout initial..master > actual &&
+	git am -k -3 actual &&
 	git diff --exit-code master
 '
 
-- 
2.21.0.777.g83232e3864

