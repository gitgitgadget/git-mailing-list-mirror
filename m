Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8901FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 16:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763294AbdJQQU7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 12:20:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56216 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759325AbdJQQU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 12:20:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id u138so5092657wmu.4
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WKSTThXrzbHI9xJqbUUZxhQY3mSTfroRsHfHs30RMa4=;
        b=KRl7PA6kDucX1BdNHh3iKqdOlANp3TH2GQx4Mdga5qA4tzMssvhvI44WhU8E/k0Gwo
         DzzON8LBnqe064jmW5iFaobbBn7QGMIpj45osfmPgKX5klHiXQoY9nM+PC+0ThaGhOI6
         KqOxaQT0f29hyAjNR97xOsJES1h7jo2vkGjekho9J6mgjyieIYfy8m0cJV0H2Ds4hBZP
         vvj/Q8Mle5iUXUqkZysZyTkdFf1Ld/IR0mlrm1esgZ3DbCU5LTUIgPVsSvUXQ+z1+oyD
         qEwCIu8DHu8ESOjIPG/5W3UloDw/bl4A3igGfjAp/kPrmfu7lQ9U93Nm/t75IBia+IrK
         mjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WKSTThXrzbHI9xJqbUUZxhQY3mSTfroRsHfHs30RMa4=;
        b=tTGiBz0CzJh2qFNuQdL/z7nkz08kfqgx2um7zjEcOcPjL822J0Hxyv4sqCCYCa4Dld
         duAWFb93+1+tE3m1b6esfXFrkfiOjq+Fxu7SQ05WPbHQbxusPTt5xM/3yPQ6h9uRnbux
         uMmlv3ajcI4UyCToM5jG19Wr75lY+H9Pu9bNaSX9D4isz4ix8r1XPJq3848Kf6j1MkEK
         ZIMA0NLXsEBjVGTs9N+IuY14rQOUfsPTOcTm/vHdf5ugjtvDZVSZxfKdy/yKAGaN1trd
         nEe8Z3k0WiAt+icA7j+SAouPccOY+QbhtAvTqyX+bVpaeApSmwhJhmO2Fk1JdTqDR5QR
         /pmQ==
X-Gm-Message-State: AMCzsaWOAWeomiPuZgTYYU9gHRbbHim8+MXjTJmtLKCYdwX3Zt8bzAmq
        ao6VjyQxLQnyDChxAfQXL7N9NXc4
X-Google-Smtp-Source: AOwi7QBJLHcU0QL2NjeomlSuGzmHebql3ZCCmFlV4bF1McaCLJRHdE7QGmcPiUWY5AECOzt3vOZipA==
X-Received: by 10.80.146.46 with SMTP id i43mr18423826eda.198.1508257257152;
        Tue, 17 Oct 2017 09:20:57 -0700 (PDT)
Received: from localhost (cable-94-139-29-181.cust.telecolumbus.net. [94.139.29.181])
        by smtp.gmail.com with ESMTPSA id o64sm6563619edb.14.2017.10.17.09.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Oct 2017 09:20:56 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] sequencer.c: unify an error message
Date:   Tue, 17 Oct 2017 18:20:50 +0200
Message-Id: <20171017162050.21525-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.15.0.rc1.299.gda03b47c3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an error message in sequencer.c for the case that
we could not write to a file to match other instances.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 75f5356f6..f2a10cc4f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2948,7 +2948,7 @@ int rearrange_squash(void)
 		if (fd < 0)
 			res = error_errno(_("could not open '%s'"), todo_file);
 		else if (write(fd, buf.buf, buf.len) < 0)
-			res = error_errno(_("could not write '%s'"), todo_file);
+			res = error_errno(_("could not write to '%s'"), todo_file);
 		else if (ftruncate(fd, buf.len) < 0)
 			res = error_errno(_("could not truncate '%s'"),
 					   todo_file);
-- 
2.15.0.rc1.299.gda03b47c3

