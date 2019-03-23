Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BE2A20248
	for <e@80x24.org>; Sat, 23 Mar 2019 17:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfCWRAz (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 13:00:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54370 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfCWRAy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 13:00:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so4976974wmj.4
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CP5lXWr6S5vL5+IXGf9Zc4A2A0RUE/5TywTGbu0BcGg=;
        b=Ekb9LhYDpLz8LptjJ/ybdvkdaoV2kfh2tsTBagRrnegyyby7z5qoJDJY7KkT1BG8Wr
         ner76HlEkfLl4vHiJ3g7+1x1IDvrvVGUm5r64XRJq1YNwb9ZDNGbhf1xQD4sIICWW2ki
         Sm40NxgVu3ioVw4U6zNZTfndqG9sgdEqjWgkBHyCJ1AFBO7DK/dLP0XeWE+pRwwmzBQE
         C5DDq9DeK54EwDDkNyuNMAADQFwK3XKPr4iCY+z4RXJFIcyd8JmTn4QxhRoj47z6IMeb
         UvumIfChQhhhM1hOxWgMFTm3RdTJqPMe0KXpDHgAPfH2YuX7WhSBRvhfdHu33WxyXOaz
         Gg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CP5lXWr6S5vL5+IXGf9Zc4A2A0RUE/5TywTGbu0BcGg=;
        b=P9FCOUmuDlbw6jxpO2PljY2/BXvjSCdvsZrl4n/VxHfbjIi/wsZhLXqaBUFIwXZ6mW
         JPh3BH8INFI7VhNNfzLxH1hLDI5PV6OUBbFhxya+ZseN/H8sGzY8kGAZp1yiUZN1Q/1r
         3It0vNrwtXrahaVyEGQ293mbx+QTt8SsL90zCg+BjfrrDXU37DRpWpNnMRKHrYUbmyvu
         JQ1VxwtINbLaLg446uUuLeyycOXUXzKt+QTHQnAj2x/TFdS4RDgUtDE3xRX/D9uMCPUQ
         R0Ao+/MioX8o5D4QpWUlNZ7cxixCl2bNnkXKiqQD153yX25JJiMCxGCtKcQCT5h4Y+ma
         YUsQ==
X-Gm-Message-State: APjAAAX8T8PUml3BsP1ZGx8TlEKgHmEfxcb63EiWEwMlQAIUUMCCLd/3
        UlIPAX4/f4BVeVQuxyvnRL5INd/V
X-Google-Smtp-Source: APXvYqzqJD6c0rFDaaB6obF8nv00Td2bZCDodtn+YxD0VGUe0gcQbG+sHIrgV9kkBn+Pv8Ymbtpc6A==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr485231wmj.62.1553360452516;
        Sat, 23 Mar 2019 10:00:52 -0700 (PDT)
Received: from xps13.fritz.box (2-230-197-194.ip203.fastwebnet.it. [2.230.197.194])
        by smtp.gmail.com with ESMTPSA id y125sm8016525wmc.39.2019.03.23.10.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 10:00:51 -0700 (PDT)
From:   Gabriele Mazzotta <gabriele.mzt@gmail.com>
To:     git@vger.kernel.org
Cc:     paulus@ozlabs.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] gitk: Do not mistake unchanged lines with submodule changes
Date:   Sat, 23 Mar 2019 18:00:36 +0100
Message-Id: <20190323170036.21533-1-gabriele.mzt@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unchanged lines are prefixed with a white-space, thus unchanged lines
starting with either " <" or " >" are mistaken for submodule changes.
Check if a line starts with either "  <" or "  >" only if we listing
the changes of a submodule.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index a14d7a1..dd4bbbf 100755
--- a/gitk
+++ b/gitk
@@ -8191,11 +8191,11 @@ proc parseblobdiffline {ids line} {
 	} else {
 	    $ctext insert end "$line\n" filesep
 	}
-    } elseif {![string compare -length 3 "  >" $line]} {
+    } elseif {$currdiffsubmod != "" && ![string compare -length 3 "  >" $line]} {
 	set $currdiffsubmod ""
 	set line [encoding convertfrom $diffencoding $line]
 	$ctext insert end "$line\n" dresult
-    } elseif {![string compare -length 3 "  <" $line]} {
+    } elseif {$currdiffsubmod != "" && ![string compare -length 3 "  <" $line]} {
 	set $currdiffsubmod ""
 	set line [encoding convertfrom $diffencoding $line]
 	$ctext insert end "$line\n" d0
-- 
2.20.1

