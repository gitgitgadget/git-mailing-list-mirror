Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17C681F453
	for <e@80x24.org>; Wed,  6 Feb 2019 15:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfBFPM7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 10:12:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33943 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfBFPM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 10:12:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id z15so5919547wrn.1
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 07:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q7ZVd27eUqaja+D1PEZ0O9LDSQUNJ0YIy516bW9MI5U=;
        b=TV15NXLzG83gg6dCrOsYsTN+JWWSvdx61udt5w9FseOEveNO2+re4THeWusLa1W9dm
         xQeoerAHHqTUMySazUEd7UdvHq8x+QCp2FXjwA8+GcRNU2QFQvJ8eBb3F+XQvJyJq4Cx
         5uxfA5I+QHLisq+pmmZtRDSqLi3S8Ls3GmZyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q7ZVd27eUqaja+D1PEZ0O9LDSQUNJ0YIy516bW9MI5U=;
        b=hFT1JghcwnJm5f9W8ciZ7ngPCgjjeXZkOCxIkn6iCk8aPWp3Ssdy5/w/2VH5L3S8SU
         XOSrz8SANSe3SLTNDuuo1yZpWU6F2genpisrD8cIUaLaXfhNQIsKc5ZpFfozU2Y5nlfq
         GuVLpwu5rQd9swj77eBPwA966Tk7aTCpR2mooG/bT/megkl7Yevivs7B1TKJu/7RG2D9
         rdS6N3+akgRO5AXkvzJYQwRQZXBVe6yb/Qx+XQ1Hes76/cjvfApCnmTaPrlLy+rsGBHA
         7QiMh+YTTeXQrk+F0LQJ+azaXgaGyCwBZeBjzaNhYRHqazJY2q4Bpo+2MhubM1USaTMN
         tSVw==
X-Gm-Message-State: AHQUAubhOPu5fPxQrNzs7zhCq1rvZ5PHicjKCDt2dqTIbROH1YV65RCs
        qMoOHNxFWbi7+8JNlNn9IWujQA==
X-Google-Smtp-Source: AHgI3Ia/EioB15agqzr1vSr1WYkTATdc2v44oGh8rVNWfD53v/yl0h5HhKVYP3EOnMKaPln4DzCVhw==
X-Received: by 2002:adf:ec50:: with SMTP id w16mr8518798wrn.171.1549465976763;
        Wed, 06 Feb 2019 07:12:56 -0800 (PST)
Received: from barracuda.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id f187sm18429932wma.4.2019.02.06.07.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 07:12:55 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: remove ticket expiry test
Date:   Wed,  6 Feb 2019 15:11:53 +0000
Message-Id: <20190206151153.20813-2-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1
In-Reply-To: <20190206151153.20813-1-luke@diamand.org>
References: <20190206151153.20813-1-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-p4 login ticket expiry test causes unreliable test
runs. Since the handling of ticket expiry in git-p4 is far
from polished anyway, let's remove it for now.

A better way to actually run the test is to create a python
"fake" version of "p4" which returns whatever expiry results
the test requires.

Ideally git-p4 would look at the expiry time before starting
any long operations, and cleanup gracefully if there is not
enough time left. But that's quite hard to do.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9833-errors.sh | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/t/t9833-errors.sh b/t/t9833-errors.sh
index 277d347012..47b312e1c9 100755
--- a/t/t9833-errors.sh
+++ b/t/t9833-errors.sh
@@ -45,33 +45,6 @@ test_expect_success 'ticket logged out' '
 	)
 '
 
-test_expect_success 'create group with short ticket expiry' '
-	P4TICKETS="$cli/tickets" &&
-	echo "newpassword" | p4 login &&
-	p4_add_user short_expiry_user &&
-	p4 -u short_expiry_user passwd -P password &&
-	p4 group -i <<-EOF &&
-	Group: testgroup
-	Timeout: 3
-	Users: short_expiry_user
-	EOF
-
-	p4 users | grep short_expiry_user
-'
-
-test_expect_success 'git operation with expired ticket' '
-	P4TICKETS="$cli/tickets" &&
-	P4USER=short_expiry_user &&
-	echo "password" | p4 login &&
-	(
-		cd "$git" &&
-		git p4 sync &&
-		sleep 5 &&
-		test_must_fail git p4 sync 2>errmsg &&
-		grep "failure accessing depot" errmsg
-	)
-'
-
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
2.20.1.611.gfbb209baf1

