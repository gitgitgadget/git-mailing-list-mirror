Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB912047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbdHCJWg (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:22:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37939 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbdHCJTq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:19:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id y206so1406670wmd.5
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dw6aQ+DoLtbJm3LB5g2ceP8kq/RK06pAR17rknUE4Yk=;
        b=p8eGlORFWyVZ5vERoNdeszL+RZZVnA0uy0Q5eZOwyj2V20dy3I7nYplCdLfFZdMs92
         ECEaz6to0e+pgsn4WMDW/OxPbAMFyc57XC2E8aEgNPbi7j83RFWp7V2OiI4kYlo7D+69
         KoPriJmxeq/l6/jMPF9KvVYZDapMLKnFgiBb1QMYleSWcEX5mL6VVmMIXywqXaST8acb
         4H7FlsH9S6pkozwjD9JdGmmWoPFkpR+09WmXant5EojPNLv/+cvKK5hnvQazv7AqiLi5
         h26LBdmJJzAMp91pxr2G7pn99NTWLmzj6eHOFH+uaC4ALC9NY9JLjLL6/sUO/LIWu83K
         ++ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dw6aQ+DoLtbJm3LB5g2ceP8kq/RK06pAR17rknUE4Yk=;
        b=mmIc7HdtwOlEkLS4MOW6yYPq77QDc0cdi9yLhafhnCzzkmMOG0nQP/7wuZMyQLHw8D
         u4YYRyMgnOfhPyc3SQj5c6Utzna98Ojb96LOsHONIejc+dYfjITrFgD+DvhRQKA/+3EI
         QPJ9kV/WHERc/SwUra8PYPxYcTUjoCHZY+pivsEi4sADY4N2uIDfwv0h+JcqQqjsCwDA
         csWvZHjUZfp5Dz2brq0ONu6rdHvjaCiOp+yS85YptYON9zsXnwfnw9prd7neTGh0RW2g
         pV+WWD4mUFrq+TFNCPgZrpwFO8c2vVVCqhiP/tL6YIXbtv/gPxQyBas6qWuE99SkkIlC
         Uo4Q==
X-Gm-Message-State: AIVw112QEOAeZBU8ErHDKUA9GQkDxRh7fnqhOMPAlgwNCVP0QFslaeIE
        j7OtxJJC6mGOW6VK
X-Received: by 10.28.156.210 with SMTP id f201mr734654wme.50.1501751985247;
        Thu, 03 Aug 2017 02:19:45 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:19:44 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 06/40] Git/Packet.pm: improve error message
Date:   Thu,  3 Aug 2017 11:18:52 +0200
Message-Id: <20170803091926.1755-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Try to give a bit more information when we die()
because there is no new line at the end of something
we receive.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 perl/Git/Packet.pm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
index aaffecbe2a..2ad6b00d6c 100644
--- a/perl/Git/Packet.pm
+++ b/perl/Git/Packet.pm
@@ -49,7 +49,8 @@ sub packet_bin_read {
 sub packet_txt_read {
 	my ( $res, $buf ) = packet_bin_read();
 	unless ( $res == -1 || $buf =~ s/\n$// ) {
-		die "A non-binary line MUST be terminated by an LF.";
+		die "A non-binary line MUST be terminated by an LF.\n"
+		    . "Received: '$buf'";
 	}
 	return ( $res, $buf );
 }
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

