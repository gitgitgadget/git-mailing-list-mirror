Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C42A7207FF
	for <e@80x24.org>; Fri,  5 May 2017 14:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbdEEO52 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 10:57:28 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35631 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752851AbdEEO51 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 10:57:27 -0400
Received: by mail-wr0-f193.google.com with SMTP id g12so952354wrg.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H/wIo8djJglY32vSaJ+WMId2Hbtd3wGw9uWSxsCdeYI=;
        b=OB/SGvlbz5y5M94l/eIbBJoYfX5T2KzUqlRORby6aWeZYF8um3RVR327teRIpv6QPr
         Ss28LfAM/vxDmyJD7YHxXFFE0HHAZLKuoNSAaPz2VmZMR+U+HuFyT0RAZnRO5ESpwkvB
         2zZ+SE5N+U/alPjZk3mMTiUjUZH2YWlOKgnc5l58AeFPnsTYxGDoITcFIIqMbf477zBo
         wU7xB9pMhY44KbeRr9n+pm4sO7dnXbuMglghjhIQVK0qUWldhCgho9ySt//Tyn9hpiu8
         lm5JE1ciSTEXTvi+ikXlbkhbcOWdqRTFcwvWSzyVqCDpo9bM5g0GVGUDUbqcbC1t0+Gh
         ehTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H/wIo8djJglY32vSaJ+WMId2Hbtd3wGw9uWSxsCdeYI=;
        b=AnpEQmaXowkXi4bOjbExdLI7bgtkpNc2OA03d9sR5cblX/otQkKvGmdCZ5nohv41KW
         EnWKdOuC4JyYyLZvT/HweFGk8z8we7vjMXPHmIMvaxEpr+pn2NdUp/IBcaU++bRaJHp3
         BhDIldeGURimPEarZPRcIDoN+0dZPMUQKx9TRrq8uA473wdL0wDEx0w+GQl+XmecKCzP
         97Dt+j1ZtVm7CNbEC0RvjiDFOoPUKEBGrzlbcyXuOV7qzchmtiuM9zjpJUie4u80apWO
         LzsAf4+HwWFmwYJL1z6+AKUT+VEsOFoWelAwRahqocLQrNTxSKo0AXtH/ETDLpb2k+sc
         eJUw==
X-Gm-Message-State: AN3rC/5Q51z+46I4a/dygFC3v5reEyW7QChXn78dJbzJSoyxGwGrewyC
        3c+6+Tk5Fq8dvw==
X-Received: by 10.223.171.208 with SMTP id s74mr33046446wrc.39.1493996245947;
        Fri, 05 May 2017 07:57:25 -0700 (PDT)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id k4sm1994431wmf.12.2017.05.05.07.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 07:57:25 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] p3400: add perf tests for rebasing many changes
Date:   Fri,  5 May 2017 16:57:13 +0200
Message-Id: <20170505145713.8837-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.0.rc1.83.g83955d3ecd.dirty
In-Reply-To: <20170505145713.8837-1-chriscool@tuxfamily.org>
References: <20170505145713.8837-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rebasing onto many changes is interesting, but it's also
interesting to see what happens when rebasing many changes.

And while at it, let's also look at the impact of using a
split index.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/p3400-rebase.sh | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
index b3e7d525d2..ce271ca4c1 100755
--- a/t/perf/p3400-rebase.sh
+++ b/t/perf/p3400-rebase.sh
@@ -5,7 +5,7 @@ test_description='Tests rebase performance'
 
 test_perf_default_repo
 
-test_expect_success 'setup' '
+test_expect_success 'setup rebasing on top of a lot of changes' '
 	git checkout -f -b base &&
 	git checkout -b to-rebase &&
 	git checkout -b upstream &&
@@ -33,4 +33,24 @@ test_perf 'rebase on top of a lot of unrelated changes' '
 	git rebase --onto base HEAD^
 '
 
+test_expect_success 'setup rebasing many changes without split-index' '
+	git config core.splitIndex false &&
+	git checkout -b upstream2 to-rebase &&
+	git checkout -b to-rebase2 upstream
+'
+
+test_perf 'rebase a lot of unrelated changes without split-index' '
+	git rebase --onto upstream2 base &&
+	git rebase --onto base upstream2
+'
+
+test_expect_success 'setup rebasing many changes with split-index' '
+	git config core.splitIndex true
+'
+
+test_perf 'rebase a lot of unrelated changes with split-index' '
+	git rebase --onto upstream2 base &&
+	git rebase --onto base upstream2
+'
+
 test_done
-- 
2.13.0.rc1.83.g83955d3ecd.dirty

