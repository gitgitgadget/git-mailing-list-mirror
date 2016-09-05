Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD74F1F6BF
	for <e@80x24.org>; Mon,  5 Sep 2016 10:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933370AbcIEKY6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 06:24:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35500 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933242AbcIEKYw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 06:24:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id a6so1324477wmc.2
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 03:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nhFkQvjuVNLODerRgDXA2MHrNtCxyjLmTK6uYemAGIk=;
        b=hsR9HbU7xjQ4+qGdgDXxZH9EG0kG+YYEDdKDQZqV62E6BjAK548wv9McIp7wyIYsrE
         9Q6ThkJlrbrp8dPQHcJLXWXUnJ2XykrUQG0nY4MEwAdm70RBDJtYAQzy5pyNCgLdYeHG
         bwYViSiW0O5IQkl+kZgS3ClY71WGurHuRM4Bd8ZS+PrZ6Y1DaEs9TFvEwi0ebcQvhvpW
         0HFC7NvqxBZgWky8fmAylvFQX+Vvtwv7ZEfKiVju4G7WyOq0FU4SeoZ9mMjj+lYKJXpi
         zsp3LXcAj56S/co0xinmliSDCml3Rjtwo6TndWEn8SzkDn1zVgJ8veAk2zaVi9G7POt6
         rthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nhFkQvjuVNLODerRgDXA2MHrNtCxyjLmTK6uYemAGIk=;
        b=Vp2s2fqLWuwnBEUXvs36BLVemljuyqlpZryl4K42sXIYgtKged13kfK/waO/TgLlJ4
         zutVgNw6QKop/ogEMrQ+UyGHGG82Cokp0U1iwZnpvNAXAxk/BItTWKCFLT0QYM7HRYye
         /HLTZh/XGjJtaukpLdbT343sRZnJJuxZn+eJ4hFQaurWjZWP1uBZIdZ62Qos54dzR6Ik
         vN7fgqr/exaqE+synB47aaGFVmFwQDWiryhXs7LCoRA3lbp1Tmek6cIr4VV/86bbaloe
         od2zx5USudx975tnicPFY/aQtC3tfQkwnislGh7otP6oMXGBPFw+S57uqt5Jc1WoSH7r
         hJMw==
X-Gm-Message-State: AE9vXwObKtXn+221N81yYFrmXTbrpJdF55y6kgMfrstTJOOStt1bsfuO0c7AehjmXX3Yqw==
X-Received: by 10.194.172.229 with SMTP id bf5mr22324032wjc.37.1473071091212;
        Mon, 05 Sep 2016 03:24:51 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id gg10sm27001666wjd.4.2016.09.05.03.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Sep 2016 03:24:50 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 3/4] t5550-http-fetch-dumb.sh: use the GIT_TRACE_CURL environment var
Date:   Mon,  5 Sep 2016 10:24:43 +0000
Message-Id: <20160905102444.3586-4-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.10.0.308.gf73994d
In-Reply-To: <20160905102444.3586-1-gitter.spiros@gmail.com>
References: <20160905102444.3586-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the new GIT_TRACE_CURL environment variable instead
of the deprecated GIT_CURL_VERBOSE.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t5550-http-fetch-dumb.sh | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 3484b6f..75694ad 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -263,15 +263,18 @@ check_language () {
 		>expect
 		;;
 	?*)
-		echo "Accept-Language: $1" >expect
+		echo "=> Send header: Accept-Language: $1" >expect
 		;;
 	esac &&
-	GIT_CURL_VERBOSE=1 \
+	GIT_TRACE_CURL=true \
 	LANGUAGE=$2 \
 	git ls-remote "$HTTPD_URL/dumb/repo.git" >output 2>&1 &&
 	tr -d '\015' <output |
 	sort -u |
-	sed -ne '/^Accept-Language:/ p' >actual &&
+	sed -ne '/^=> Send header: Accept-Language:/ p' >actual &&
+	cp expect expect.$$ &&
+	cp actual actual.$$ &&
+	cp output output.$$ &&
 	test_cmp expect actual
 }
 
@@ -295,8 +298,8 @@ ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.91, *;q=0.90" \
 '
 
 test_expect_success 'git client does not send an empty Accept-Language' '
-	GIT_CURL_VERBOSE=1 LANGUAGE= git ls-remote "$HTTPD_URL/dumb/repo.git" 2>stderr &&
-	! grep "^Accept-Language:" stderr
+	GIT_TRACE_CURL=true LANGUAGE= git ls-remote "$HTTPD_URL/dumb/repo.git" 2>stderr &&
+	! grep "^=> Send header: Accept-Language:" stderr
 '
 
 stop_httpd
-- 
2.10.0.308.gf73994d

