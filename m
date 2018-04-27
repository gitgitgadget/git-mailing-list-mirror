Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9396E1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759237AbeD0Vk6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:40:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:44317 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759378AbeD0Vk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:40:56 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lv8hi-1eC006283O-010KK9; Fri, 27 Apr 2018 23:40:52 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v6 10/11] technical/shallow: describe why shallow cannot use replace refs
Date:   Fri, 27 Apr 2018 23:40:23 +0200
Message-Id: <2152d161b3a85ad90c151ed848d668d1e471b2b4.1524865158.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524865158.git.johannes.schindelin@gmx.de>
References: <cover.1524650028.git.johannes.schindelin@gmx.de> <cover.1524865158.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:/zwrKOFuOGBdpAvSWfT4XdhF52uqgm+jFmSegyEYv+G2Xw+SyTl
 ywLjLLgNw559U7OfdQlQ0ZvMzbpndra6Q5ulONIv30pglHIIIo2nRDEJDrHs1BU2TQtTZbD
 vhY6YEV6WEhqxF6IJvjdp2VvucDIg4aRlQPNRMdLZCMhW/oNEtMAwwVJ7qiID3VKCX6LZCZ
 Cf+OiX5dCy8NlLirM/klA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XvQyeazNc7Q=:9Suu9dx+pIECcgQl4a1EoG
 nSY9gGfGJQENQGenlu9O85k95l11oMOvBD0H4k6hzEOV8sENZ5omn8CereY/rx0JZClQUgxiQ
 JFyObZlNhZDPxUc+P8hplPSiHPOfQ7jLL3uLda+huI45D6W4Tse6ga5XzVdE9nxv1qZRp0m1D
 gSf97ttt9bzQr0Y733OMl4EPqJi5L2hMhDHi/QptPofH3CgKk2/zxtacO9nCdwFFksnM5QKms
 dkoEhS9rrl7PjnAad0bE7pjc27z9e8UG7uPP/M5ezGOnV7hv0HWg7nsjQOO7jQMeO4oQWMDos
 91QLZN5oRHcmVEyPb8SOpbl7gCuLD6nHnWGnK3E2W/s1yIqR7hw6GGmWuCSW3RyLHdh9Jxmq5
 83l09Om69bzwA5gfJlIpINEIjmFrDvakFuS5Ge48giPBfrSlZ4HBmbu5JIl06tiN/O6PY/hwL
 yypLNvOEcNEYoTSOZCpMQLuZRU+FLoYn3uEZmeEg+dOhOW4Fpx/4atZ6TdA4AXtgTHOWkHJpR
 9BKoY5ej6Sy9mcef2hMU56wskEzPKjIHO4wtpfuNZnDMQVTR94Cfj1pyHo5PTy9xVTXOBhyqw
 JslpmSPJOHu2/h+r+LbN8avGIxUvKpPcTOZl4hNTDOtOkPskoQ1oPgUkuk9LQ36UwqR7eQV24
 6HVXokW/5IJ+mgn7X6lK3g5K9D/7BOdNbIUIbIDmk9CEqA9oJLAtpiHcc41B2p/aoxnLCfjKg
 ntQyjB3tV88Pxfio//5R+tQuIdwy+iHXBgQJmUy4ADPl6leTMmqpcDZVzVClsLMlMqTG81dcU
 XPDoPjN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is tempting to do away with commit_graft altogether (in the long
haul), now that grafts are deprecated.

However, the shallow feature needs a couple of things that the replace
refs cannot fulfill. Let's point that out in the documentation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/shallow.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index 4ec721335d2..01dedfe9ffe 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -17,6 +17,13 @@ Each line contains exactly one SHA-1. When read, a commit_graft
 will be constructed, which has nr_parent < 0 to make it easier
 to discern from user provided grafts.
 
+Note that the shallow feature could not be changed easily to
+use replace refs: a commit containing a `mergetag` is not allowed
+to be replaced, not even by a root commit. Such a commit can be
+made shallow, though. Also, having a `shallow` file explicitly
+listing all the commits made shallow makes it a *lot* easier to
+do shallow-specific things such as to deepen the history.
+
 Since fsck-objects relies on the library to read the objects,
 it honours shallow commits automatically.
 
-- 
2.17.0.windows.1.33.gfcbb1fa0445


