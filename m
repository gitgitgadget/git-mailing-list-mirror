Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED4E72018B
	for <e@80x24.org>; Tue, 28 Jun 2016 18:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbcF1SUI (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:20:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34050 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbcF1SUF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 14:20:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id 187so7972943wmz.1
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 11:19:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZChAf0JUMBwZj33iLeJJwMM7nrWQP77kJpbV6CVC3Lo=;
        b=qgK9d0bW2LWhXJOSKDYJn5zTZ5dyMk5zaYbR0+tF/oxcd/O2PDHoJP3wQaXgJC6B0i
         Uxj/ln3XoQGlI7BPSf5WYbCB9Ap///9a0PYQRXpBOIL/CO2l7thggipesM8Vgs1VFsNg
         RMeKcW5pwTYkhi/ZpbTl/bOdI0fWoo2vK5hgmsReul5+0+mL7TqQ5utjVuZ+Kk++GH/4
         LWxKsh4oCIzmUc08VQuWpUZ4olsmXPMS1EGHIYmGB5VKUVEDenWeRD/nW3wflW+7Xn8W
         3Ek7xN5beKT+UmytCMvbQfPB7yLxOrsCB1XCF4xfNw6FIHR3pVMuV44Q2UYWDpLyHQTY
         0t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZChAf0JUMBwZj33iLeJJwMM7nrWQP77kJpbV6CVC3Lo=;
        b=LPqq0enLiBP33VMYO4b+Ak1v6iWyHBIvleJoykWq98w8L2OCD/y15PcW7+3xAXQFjV
         4ST1LIXYNJ9+f2qMCTBeuoRqb6r4JlKZfJGErIYgtf42P6LnORzVrHvO3uSqG2OVeUw1
         54sUzszKrNLeBxawqo3FMrpMKtGbrdJzpkNLnlJqFWxNOpM+cWop4QOW+Mk38q+n19cW
         YIWPco7gFU5k7GhmKhq4geT5P/FvTcNFei9D8iNBIub0TGGrJ3FXqVltTvVE++x7fuD5
         rDlVbkcn+JhJuovhFcoAv2iP+6yVbwqZ/979lCC5XDFwFwWmgff/p8EA4F/jXNgRCQb0
         IkYA==
X-Gm-Message-State: ALyK8tKavLXYB9pNu09dRrRkL3R3U4DXHSKPip0jQp2HGnsmon56+2Yrma4mbn60cpkLLw==
X-Received: by 10.28.73.212 with SMTP id w203mr4980908wma.98.1467137991172;
        Tue, 28 Jun 2016 11:19:51 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id yr4sm2061048wjc.18.2016.06.28.11.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 11:19:50 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v2 03/10] t0400: use --batch-all-objects to get all objects
Date:	Tue, 28 Jun 2016 20:19:26 +0200
Message-Id: <20160628181933.24620-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.11.g990c140
In-Reply-To: <20160628181933.24620-1-chriscool@tuxfamily.org>
References: <20160628181933.24620-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 2b01617..fe85413 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -10,9 +10,7 @@ write_script odb-helper <<\EOF
 GIT_DIR=$ALT_SOURCE; export GIT_DIR
 case "$1" in
 have)
-	git rev-list --all --objects |
-	cut -d' ' -f1 |
-	git cat-file --batch-check |
+	git cat-file --batch-check --batch-all-objects |
 	awk '{print $1 " " $3 " " $2}'
 	;;
 get)
-- 
2.9.0.rc2.11.g990c140

