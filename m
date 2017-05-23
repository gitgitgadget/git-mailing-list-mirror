Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9E1720281
	for <e@80x24.org>; Tue, 23 May 2017 19:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764900AbdEWTcH (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:32:07 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36822 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764886AbdEWTcG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:32:06 -0400
Received: by mail-qk0-f196.google.com with SMTP id y128so24069704qka.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=k8IZu30aN5XyKOp64tpL4By2wtxxwgQeuZDZTW0IEbI=;
        b=BwkT9ao/H+hiPdYnHb67vG46kJOPGo9U5jGwr7WtwOJB09ZzfNVrGK6ZjEp2XVHDpO
         tKgh1kdcoauPKEsPF9CrUJzP45uLfDPRnkWBPsc6ECWnQJWPPoYKPkAA0HpXHkRMlKKi
         8Q3jbWZBE50tBkM6IibV3AlRuAZBctdlI+bgdSwqojHwrRF4NZvSlmqrxWCHVuAc8KTu
         cZytY9ii7rWgImy+g/806ePjdCZYFA7GGtDSpz5JK+rk6fz7csygmBBk3YSpUCeTRJOX
         5H//LM1OW7EeU3RFln9OR4Ms6PpNMrcFuLKIISTS9BACGQMB8sn0mNu6iNvglWBfnxyt
         HvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=k8IZu30aN5XyKOp64tpL4By2wtxxwgQeuZDZTW0IEbI=;
        b=ZkIuERZ8rjKB/C1QBQa2zOCBND5zsw7kJvna2fgXInU/wHE/FZ6/ubeTBrk550N722
         NkmPzwL8iqRZ6k4sRouzWKglVbSFFldIfxGb4sZseBUD6maE+EVSFj/6YYOziShHf4eA
         z7k0eZ7/gdnprvFMY2Wj2j6/YjOHz9tmLfobddmVFQcIawDZ/Gycm1QeINwwyYyFq2r0
         KwLsDyfQ+PPu6YKqhFJ5w3YHI9+CZVsCu6Ux1NR9hQAQswOZkCy7UO9VZwTbuIWiJoYl
         AN9eauPtmZGwZKmxratQLJIMR7owOD7C621Jik1uszxdN7lSMZy/0DyXj6PeJdvm7WvA
         7Fpw==
X-Gm-Message-State: AODbwcAobVWTf9Zb5/CG8Cg31Pvh71NA+NsAHMHLT+RFg7OdVK1+yD0l
        zUlvUn4BGXstEw==
X-Received: by 10.55.160.88 with SMTP id j85mr30344337qke.200.1495567925580;
        Tue, 23 May 2017 12:32:05 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id f94sm1058506qtb.16.2017.05.23.12.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 12:32:05 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v6 2/6] t7061: status --ignored should search untracked dirs
Date:   Tue, 23 May 2017 06:09:33 -0400
Message-Id: <20170523100937.8752-3-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523100937.8752-1-sxlijin@gmail.com>
References: <20170523100937.8752-1-sxlijin@gmail.com>
In-Reply-To: <20170523091829.1746-1-sxlijin@gmail.com>
References: <20170523091829.1746-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per eb8c5b87, `status --ignored` by design does not list ignored files
if they are in a directory which contains only ignored and untracked
files (which is itself considered to be untracked) without `-uall`. This
does not make sense for `--ignored`, which claims to "Show ignored files
as well."

Thus we revisit eb8c5b87 and decide that for such directories, `status
--ignored` will list the directory as untracked *and* list all ignored
files within said directory even without `-uall`.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7061-wtstatus-ignore.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index cdc0747bf..15e7592b6 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -9,9 +9,10 @@ cat >expected <<\EOF
 ?? actual
 ?? expected
 ?? untracked/
+!! untracked/ignored
 EOF
 
-test_expect_success 'status untracked directory with --ignored' '
+test_expect_failure 'status untracked directory with --ignored' '
 	echo "ignored" >.gitignore &&
 	mkdir untracked &&
 	: >untracked/ignored &&
@@ -20,7 +21,7 @@ test_expect_success 'status untracked directory with --ignored' '
 	test_cmp expected actual
 '
 
-test_expect_success 'same with gitignore starting with BOM' '
+test_expect_failure 'same with gitignore starting with BOM' '
 	printf "\357\273\277ignored\n" >.gitignore &&
 	mkdir -p untracked &&
 	: >untracked/ignored &&
-- 
2.13.0

