Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5FA51F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeBFAHx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:07:53 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37116 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbeBFAHw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:07:52 -0500
Received: by mail-pg0-f65.google.com with SMTP id o1so138560pgn.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ap3E8P62/sM+8sa6SQHs4/QZWfuOL1Re+b8vpNNYz68=;
        b=F1FiIHIHV+8ezA3OJFKJFe4WuN3nJbyH49eQSE5aEWCn5muJPgGJN0KNHIA1jt77Kx
         gbx2yoLxZMeCV6rELRIPaLAa68vl0CkJ1LedskA7OaM7BxFdm59/juL90dBCbqXmXF4O
         BsxgRALGtBtW7RfsMBPGSqT3hPpwlMHfFRSp0hzDgGKua2WUqmrLNXNTrHTb227Y9BHu
         gJRAz1eg7bYAxVOCHqftWUcJQOtPzQOHgWGlpUKIAKyWE4TACJbzRYcGuX8MDICFEj8+
         2H/yhJcjIhfn0njXmU2+oiKRfDpVBqrQCUH88WZlDVH7cG9XemulkclU+rjsixFqKuUl
         MeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ap3E8P62/sM+8sa6SQHs4/QZWfuOL1Re+b8vpNNYz68=;
        b=p4aNJevqS3lZMYQhm7u5SmEJlMCbMPEimW/QClZgkGqpb+/q8zNHPG1Sb/V34hpAa5
         qWE9tLTgCqfV4k5M49U0Hrblu7YDuY7KKOvOOHZD1MLhurbsvbG9weAxwYXAK68+O3wu
         xdBjwVGI6prMi+xxLVQXaZHvWpCnT3ikVGRJdJ1eNpdgUxfh3VBiO8kYHYBw0ZIMTJtM
         2cd2LIawofJHBSLZ1irZyOHeh/R+V7U02wuI/eqAuQp2Cwp1gBt3k4eV/jASua7G/8yF
         Ru8EswMwXOa7++JaoTZwZO48dA1IlHsD9FvvZdj1v+RrP6kXqp7zgGYc1siZJL7epkkV
         Q4Ww==
X-Gm-Message-State: APf1xPA/SNeushEi5av0C7v95SirzJsxtGLuiBG3FpLlpLvqfJu1WuPn
        cwsUc95wPx0KzSsjBWsnC1y2w5YSg3A=
X-Google-Smtp-Source: AH8x224wVmgq2FUnNaaE4QxDKlb2hZPYJIF7e6QSwtBpIvrePMH/KJSsSyYjdpzlH4wOcJHzXe4i1w==
X-Received: by 10.99.107.201 with SMTP id g192mr396732pgc.295.1517875671118;
        Mon, 05 Feb 2018 16:07:51 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id q87sm223256pfk.71.2018.02.05.16.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:07:50 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH] Documentation/git-send-email.txt: improve batching help
Date:   Mon,  5 Feb 2018 16:07:43 -0800
Message-Id: <20180206000743.217503-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This clarifies that the relogin delay *must* be used in combination of
`--batch-size` as there is no default for batch size, if the batch size
is not given, we ignore the relogin delay argument.
While at it, fix a typo in the batch size help.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-send-email.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 8060ea35c5..887a38a608 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -250,7 +250,7 @@ must be used for each option.
 
 --batch-size=<num>::
 	Some email servers (e.g. smtp.163.com) limit the number emails to be
-	sent per session (connection) and this will lead to a faliure when
+	sent per session (connection) and this will lead to a failure when
 	sending many messages.  With this option, send-email will disconnect after
 	sending $<num> messages and wait for a few seconds (see --relogin-delay)
 	and reconnect, to work around such a limit.  You may want to
@@ -259,9 +259,9 @@ must be used for each option.
 	`sendemail.smtpBatchSize` configuration variable.
 
 --relogin-delay=<int>::
-	Waiting $<int> seconds before reconnecting to SMTP server. Used together
-	with --batch-size option.  Defaults to the `sendemail.smtpReloginDelay`
-	configuration variable.
+	Waiting $<int> seconds before reconnecting to SMTP server. Must be
+	used together with --batch-size option.  Defaults to the
+	`sendemail.smtpReloginDelay` configuration variable.
 
 Automating
 ~~~~~~~~~~
-- 
2.16.0.rc1.238.g530d649a79-goog

