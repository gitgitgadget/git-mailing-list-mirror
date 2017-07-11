Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A378202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 14:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932763AbdGKOLd (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 10:11:33 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34974 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755627AbdGKOLc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 10:11:32 -0400
Received: by mail-pg0-f46.google.com with SMTP id j186so372845pge.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y2/MHI68B9z4fqE+B2dWru+opLowOas+tO8vAgD2L38=;
        b=EWlDGPv71dcWU9wpen2GtOGmeZ1Qb0B6ccoaE2xYmi09xS1HjIRkZFLlZa9JF1BG16
         d2zRlDz3WoEOSkRoh7K2c0tXujku2X7NinOr+4cWAIp4NkHfQJlqmlsy1XpMKMXIiOs/
         kvG3WC8qyxV9lDX1U83IgCn0lhh6QyFonEYtJ2++IKSOnuL4Zsg42qv7fvzo5lVgMQKj
         K+AwKeGF+VST+cf8rtnfLaPa53WJFqQm1tDksUDdI0VAlj3OJvpvSk3JLTQVrMgGAzf5
         jLZhw4fCqav0csg3M98KpCWeK/2Ux8IpRoKxFLTc89jQURceFJogOo5nk0xYKHHZxKSn
         lrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y2/MHI68B9z4fqE+B2dWru+opLowOas+tO8vAgD2L38=;
        b=khE7ys1ITWiDGSzeCfEtF11UswFICQ0UQ7Oc+q6IrMSctK6ZvL1/sYjGh/YQmvgVMR
         VTJ5SidHiEit35kNwaM0M4D0Xh4UoqpbH2t1SYdJ4HNZ6HEdG5AZLqhos31ozDKTX0HD
         rnRizg3kjZ8zgwusUAr06K4JrxaJFtIHIda8D+sZ/eWMenJiEiXbfBYNtPaegBeSn6Yd
         ZOZ71SmkzqYAMPAreQt9q0uLsQCZnVEIgb6+0rIcPOjqHM42p1Qio6PoiIBBGiIYypTm
         VQeqU2uYeWz3unNS+gywSkERM+0Mt9bhcl0M5mGHh75JoHKr3A2rTvBN4iwgKn0hI2zu
         b6AQ==
X-Gm-Message-State: AIVw110GYK/Vqjp04CN/ZwSr12NboVDWpUQO7SnNs/T+tFKpsxx2Jzyp
        8qCEvi4CJ6s58w==
X-Received: by 10.99.0.138 with SMTP id 132mr142112pga.30.1499782286714;
        Tue, 11 Jul 2017 07:11:26 -0700 (PDT)
Received: from localhost.localdomain ([117.249.129.113])
        by smtp.gmail.com with ESMTPSA id i19sm98579pfj.78.2017.07.11.07.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jul 2017 07:11:26 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH 2/4] hook: name the positional variables
Date:   Tue, 11 Jul 2017 19:41:09 +0530
Message-Id: <20170711141111.7538-2-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.13.2.957.g457671ade
In-Reply-To: <20170711141111.7538-1-kaarticsivaraam91196@gmail.com>
References: <xmqqfue45asd.fsf@gitster.mtv.corp.google.com>
 <20170711141111.7538-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's always nice to have named variables instead of
positional variables as they communicate their purpose
well.

Appropriately name the positional variables of the hook
to make it easier to see what's going on.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 templates/hooks--prepare-commit-msg.sample | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks--prepare-commit-msg.sample
index 279ddc1a7..eb5912163 100755
--- a/templates/hooks--prepare-commit-msg.sample
+++ b/templates/hooks--prepare-commit-msg.sample
@@ -19,14 +19,17 @@
 # The second example adds a Signed-off-by line to the message, that can
 # still be edited.  This is rarely a good idea.
 
+COMMIT_MSG_FILE=$1
+COMMIT_SOURCE=$2
+SHA1=$3
 
-# case "$2,$3" in
+# case "$COMMIT_SOURCE,$SHA1" in
 #  ,|template,)
 #    @PERL_PATH@ -i.bak -pe '
 #       print "\n" . `git diff --cached --name-status -r`
-# 	 if /^#/ && $first++ == 0' "$1" ;;
+# 	 if /^#/ && $first++ == 0' "$COMMIT_MSG_FILE" ;;
 #  *) ;;
 # esac
 
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
-# grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
+# grep -qs "^$SOB" "$COMMIT_MSG_FILE" || echo "$SOB" >> "$COMMIT_MSG_FILE"
-- 
2.13.2.957.g457671ade

