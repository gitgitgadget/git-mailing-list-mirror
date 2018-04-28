Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8871F428
	for <e@80x24.org>; Sat, 28 Apr 2018 22:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeD1Wp2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 18:45:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:46285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752695AbeD1Wp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 18:45:26 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M7Y9j-1ePfPB0nw7-00xNq9; Sun, 29 Apr 2018 00:45:22 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v7 11/12] technical/shallow: describe why shallow cannot use replace refs
Date:   Sun, 29 Apr 2018 00:45:21 +0200
Message-Id: <196c4ec85feb602ce9a89ced5e0ee008a86a1028.1524955439.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
MIME-Version: 1.0
In-Reply-To: <cover.1524955439.git.johannes.schindelin@gmx.de>
References: <cover.1524865158.git.johannes.schindelin@gmx.de> <cover.1524955439.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:GwALHzLr9fZOw6FRmlGzO76WJbCRWIx0+1LGuROFJYh5Q7waLGW
 F1D2QVFmIFDV7jEgg30aYxtensmj4wiiJmqT3gg90+W/6sk2Jk3qh8hIKlXMpcNgpGQMaxZ
 JDEh/AFhH2gDHEs0KWk6nHNqXs1yRXpdZdFxMREX3Uc4c/Kwq8ewPuOi9f4XFvORrOSX4Ld
 /ozsDlWCpWDQ05ph0Ywhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EuLIdE68AOA=:k5qN5VR+LpKPJklqLRcFsf
 MAN3yqomLMzBf8Y1ROAmj6JdqTUQBwffc260iqEamj6JdH/cvWZFKo5LUEw+oT79SKjh3UzZx
 KsAmaZfKQOk6EgVtCh1DemVRZXVAOH7vho5OeGWhisP5CCqTkksXWGwHswoWmMPTz1hkI4J60
 YM5yEopAlws8vgoLuogeAH4+j+6NA8MObsEr/v9M2hXgXNiC6JHt3ITTJ4rZowb1yCRdcix3o
 ER+pGJpqia7K9XFEUKLwl9Jvka9Gzzdfb9Fy1ULN6JahbSPG9ay2pyd+nMhC1v1bZtF+vOiqS
 R+anC8Fam3I3QzQl4yLyKxMHFx6NcD0ZU2f26o6RVqXUc/ds88cvmI6dKEhzfO1bFqIyKQA1Y
 OprqvyIYsMlpFI7mV2h++Ih49EPx56A8GI4irK91tAwd/a/2ifJcDoMqlVRf5VMI20a8ns+Cg
 INsdHe4m9A5O8MRo0AHLX3o07BXLe+WQeWXov8KxZZI7uYGBgrEXifLPv8tWBdALBO4Hr6fqt
 om5oRx9m4dm98fzor7d8iQ95JMTSmgQc0KFYtKCDec0bCcZgoxTU/L40u2v5AEAskmsWBDjYv
 iNKR5NZL93C18MizuYEUfsojmgnw9thVpvUOOgbHIc5S3PNJ6wrD/CSmuT1TjdZcCE+MQI4e+
 Jl4BuXH1JCHAqLIoZGopm2Rcjs6Bo21ZoW5tA72p1cspglf24UXvdvyQ9phKiWYzY0XGms98C
 9zEods7iACndJrP/yvsaXMgAM8Rd0I7mPmeJghRLnMAAaJWFixCGwfk69AFnIlV+dbGNZ3S8B
 t0PkDT4
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
2.17.0.windows.1.36.gdf4ca5fb72a


