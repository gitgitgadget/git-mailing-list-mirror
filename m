Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5938D215F4
	for <e@80x24.org>; Tue,  1 May 2018 16:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756058AbeEAQ7r (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 12:59:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35769 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755905AbeEAQ7o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 12:59:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id j5so9511968pfh.2
        for <git@vger.kernel.org>; Tue, 01 May 2018 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=THC+3XD0mI5WUk90vmDwFAQviUijA/R5wZ7Zwqlo3aY=;
        b=MoI7KR+4UojKrH7Ov+eJeMGDR71Q30Zu9cBmF1+0ZN7RdoHl+Y33WX40nRKEXpyIoU
         /wNpG52bNYyp/D8m409YESnv5gjegOVkweIW7C/2Kcp19y89uSYJOv9ZN4U/PDTXiW99
         jCzZJoAcgUI3wmjPLEPMj/XZu5+r3v6qqE9m5Zi0YwAfMwuIuYqNJX9uB0E70SZtGe+p
         aK9/zrl/ZH94FJTbE1Ha1tdgrMLGGl9+z/YwCp8U//oFhWQLaLaz2XOV62V4Ba+kk68S
         rN3KDpB6Jhcy7BW5n7AB5tiUYXleMGm8u8KUnQO/SF0V88eQ82INdh9b2StBqK5lHB0h
         ea7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=THC+3XD0mI5WUk90vmDwFAQviUijA/R5wZ7Zwqlo3aY=;
        b=F/yOXUPgpcg116QIlW1NGObGqEuZNyDHmXXCjSmRR/1CqtUOXO25dwHo1AkMJDxcBR
         v09SiiIR6eVt61pgBXKoogK5iE7K0lbC0XSkBaPUjDpIwLIiMICa+i/JCXRFGK5/7CNB
         /pq8cDhc/d3zrucydJBFLcWF43M4j4/l2OSHFVo2HLXRCXy6N+h2V6AUQ6Wt0GknLFCK
         sk/aIP3sPiuPuNLuiWoS6OS8BLO5PwFCpxS3uMU+wTayrTcZQb6SIZvhfmogYmCW3MZM
         dCqgBg1ObeLgAmidVSVlTlAN1rQUA5WWWNVjCaBl5p2cwDccl3GcjIP1vh6gkHIDFv2B
         EYEQ==
X-Gm-Message-State: ALQs6tCnJ40rMb/I7LlmjCvugyUuob7wxD5TzBolQT5eMuKPCVF433JE
        o9ehDZHC5mnR3rA2kTpCq1XKaDQg2tI=
X-Google-Smtp-Source: AB8JxZpZuwB2+priIFuWxFlt+h03UjmuNwc+tpV9wBtQHlfAzxCV9IUQQkj+W3pLunZEZ5FXtS0e5w==
X-Received: by 2002:a17:902:b591:: with SMTP id a17-v6mr16767109pls.211.1525193982985;
        Tue, 01 May 2018 09:59:42 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:6e43::93dc])
        by smtp.gmail.com with ESMTPSA id r81sm22313311pfj.79.2018.05.01.09.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 09:59:41 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, gitster@pobox.com
Subject: [RFC PATCH v4 3/3] Test git remote add -f --remote-tags
Date:   Tue,  1 May 2018 09:59:31 -0700
Message-Id: <20180501165931.25515-4-wink@saville.com>
X-Mailer: git-send-email 2.17.0.393.g4573f5e134
In-Reply-To: <20180501165931.25515-1-wink@saville.com>
References: <20180501165931.25515-1-wink@saville.com>
In-Reply-To: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
References: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test adds and fetches a remote repository and then lists the
imported remote-tags verifying the correct values.

Signed-off-by: Wink Saville <wink@saville.com>
---
 t/t5505-remote.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index a6c0178f3a..cb30ed5cf2 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -573,6 +573,26 @@ test_expect_success 'add --tags' '
 	test_cmp test/expect test/output
 '
 
+cat >test/expect <<\EOF
+origin/some-tag
+origin/foobar-tag
+--remote-tags
+EOF
+
+test_expect_success 'add --remote-tags' '
+	rm -rf add-tags &&
+	(
+		mkdir add-tags &&
+		cd add-tags &&
+		git init &&
+		git remote add -f --remote-tags origin ../one &&
+		git tag -l origin/some-tag >../test/output &&
+		git tag -l origin/foobar-tag >>../test/output &&
+		git config remote.origin.tagopt >>../test/output
+	) &&
+	test_cmp test/expect test/output
+'
+
 cat >test/expect <<\EOF
 --no-tags
 EOF
-- 
2.17.0.393.g4573f5e134

