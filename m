Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD79120437
	for <e@80x24.org>; Fri, 13 Oct 2017 17:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbdJMRwE (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 13:52:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54319 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdJMRwC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 13:52:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id i124so23226358wmf.3
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IQl58CWLZDI3YfD6OHW1l5LdBCV9lCTsGpe5/VhMA0w=;
        b=ue52hHmxAu/cWhgIZdsFMFse6i9lJShNTr6eluRDi+D81lkmOOmi7U8eGF59Vy+TNV
         wXax384ZgW8sbGxS48BrNIIgUIqK7L28YtR4LGIbrTLobBvxxZmCDYDMU148zJd5eDAk
         Hn6KMH+qjG7kJw7UN8Wez5JURjToHNp+hLb7yNgOfaPGOdgixcM4nuc9SJG+wFwBlRe+
         ikXxPM/ZfZGpsb9EcA3iFm2imI2zkpsMbTZ1HAHxGWHcSCJDTqWUvJmfHNbf5k5hg5qm
         9flbtAr1SOsxtxge6SKo2aalz0h1ztoiHiuhKV8vZFgCSu8664Si7jbzD2eqRUybsiLW
         a3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IQl58CWLZDI3YfD6OHW1l5LdBCV9lCTsGpe5/VhMA0w=;
        b=BDwW/oiQRE8etUIxkpWkbPuYGBDPOZQ+kb7aquelT1IcrbATSLR71yp6UphqYKRHju
         4A3heTsfg+IAPnkHi70BzZIcM0up7xcJtDVcAwggtcq6j4/wL+QmN+5o8aD9YGWcr6/+
         GcdDAtCdukGIOo+f3bQ7wzBEtokR5JMR62eta+Bzs4Tz6+K8YxOrXM0fYQthZIPchEAJ
         MqvU/qkFRqHREFoX3BKqhpFqTbjCOukTA1UqYChfzxDSRYo1f4YlXV2WA6AKW8X7yyTo
         c93RVTuB1bKGLCngLgt/88qFcohLDWXAKa0yj/+mDvFB7sAGszEqaWQDNiz774W7ukdr
         MOnw==
X-Gm-Message-State: AMCzsaXRUNJBbjbxhsZKsc/QYBq/yotJTTv1Lj8cAjM6BM/P/g2XLbJQ
        J3dCenFvs6IVsRbji5dWoWfVWA==
X-Google-Smtp-Source: AOwi7QDOJSp0qLB8w6GPZeeznmBAbNWE7rjG+SZzY5GiNuyKLHTI144RIWsmRDg1JpSOa5M14DFVdA==
X-Received: by 10.80.167.193 with SMTP id i59mr3255861edc.173.1507917121177;
        Fri, 13 Oct 2017 10:52:01 -0700 (PDT)
Received: from localhost (cable-86-56-48-175.cust.telecolumbus.net. [86.56.48.175])
        by smtp.gmail.com with ESMTPSA id k51sm1359644ede.42.2017.10.13.10.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Oct 2017 10:52:00 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] sequencer.c: unify error messages
Date:   Fri, 13 Oct 2017 19:51:57 +0200
Message-Id: <20171013175157.13634-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0.296.g7b26d72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When ftruncate() in rearrange_squash() fails, we write
that we couldn't finish the operation on the todo file.
It is more accurate to write that we couldn't truncate
as we do in other calls of ftruncate().

While at there, remove a full stop in another error message.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e258bb646..b0e6459a5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2948,9 +2948,9 @@ int rearrange_squash(void)
 		if (fd < 0)
 			res = error_errno(_("could not open '%s'"), todo_file);
 		else if (write(fd, buf.buf, buf.len) < 0)
-			res = error_errno(_("could not read '%s'."), todo_file);
+			res = error_errno(_("could not read '%s'"), todo_file);
 		else if (ftruncate(fd, buf.len) < 0)
-			res = error_errno(_("could not finish '%s'"),
+			res = error_errno(_("could not truncate '%s'"),
 					   todo_file);
 		close(fd);
 		strbuf_release(&buf);
-- 
2.15.0.rc0.296.g7b26d72

