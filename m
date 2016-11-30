Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA8A41FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 22:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759361AbcK3WDP (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 17:03:15 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35443 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759356AbcK3WDM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 17:03:12 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so31502054wme.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 14:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OWLD7Uae20GPbwZbmDNdsXA3j9RjfFZh9NS2YJR14M8=;
        b=inFOH3cF6ZGmDReF6qPmYL7TOdnDYJuAwO2/vsU0Nk+yVz6NTFD9jRpXJ9uqHdUguA
         io9tUJGdm2VcSksOFSiP2M/N4jL239tYcTFyqM9t0W1f9YsoMQ8bPmDZRCKZ1ahN7xMB
         huIp86RmZy3zrYfnaFZuOg6kVQZgYUSNEbCom3MhC3PJgyGuwGfdFVZf2/X0pgy4a5fg
         o7Bd+UgvZZCeSIIJP5t5ZebBSpmS86xrpBQgBLvYXWiMRpIj8W5XDZ0lJJKNdB/2vaxI
         4Ryf9vB1D+IcYVKS53LC8rBeOAKiIBmvQAPTZyDmqXOy/xBqar/7MB96mPoY9EMSH52B
         ExXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OWLD7Uae20GPbwZbmDNdsXA3j9RjfFZh9NS2YJR14M8=;
        b=K1zGbzHUOfYY59ddDf+rfLK+FZWp/Uq7RiHbnVIzLkF4HXuV6gWlJXGY2K3PWqgLBf
         +BNi8Zz1PJke7jqOmVpa0+f4ZK7NGReVN+k1H02UZBnwhU1siPE5zjQcHYZJ8EBjksXU
         DIOBdOjm0n/DFHgn8Z9yUPMxyNL6zQopxKu1KspdTeUzhKaD8D4DxBkDYn/ShzXfX69J
         mYvwDZyS38FRlOJJepw4RhYgfoAzvS+rnqqdRfHTe+Vtdz2eUZpeIGNzKDbrkjyTPwBM
         zy8b4G9sXDiyd61C9enmTedf9vJplHf8wNjg5can3pn92e/6oji4PZuFXGKHca/miI3X
         R/MQ==
X-Gm-Message-State: AKaTC02HNEbIrky4OI2laL4pE3C1f6rRnniQh2YcL1KClBcD6JI0rhGd6OfSw6FG61PIJw==
X-Received: by 10.28.95.85 with SMTP id t82mr28076437wmb.56.1480539890419;
        Wed, 30 Nov 2016 13:04:50 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:04:49 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 03/16] t0400: use --batch-all-objects to get all objects
Date:   Wed, 30 Nov 2016 22:04:07 +0100
Message-Id: <20161130210420.15982-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 2b016173a0..fe85413725 100755
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
2.11.0.rc2.37.geb49ca6

