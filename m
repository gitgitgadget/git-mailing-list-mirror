Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BAEE20964
	for <e@80x24.org>; Sun,  2 Apr 2017 04:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750844AbdDBEf4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 00:35:56 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35264 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbdDBEfz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 00:35:55 -0400
Received: by mail-qk0-f195.google.com with SMTP id k139so3993612qke.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 21:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=rJwYTYXuvJTIUzTHMsu0EveycGZM5jHLJxc/h+FDtUA3ghEAnNHU3Jz1L4lJQoEenI
         vN0gaq+7sXh8HmUVNUB7waE/GX6OMKphzzMLaFvLCHNnH/tOCYzWiMg18zBY6cJ0C4S+
         Qyau3eTGJEVHRgLUWA9z92/cQQIAx7Uz5MGsQmIj7YHga8K3Ef6usjL5VC2pA4tpRWp/
         9o451PaZ0ftlA1XQTJjbJTg5pyEYqLvBZwmL+4G1EwF4vAhYPnAbEf+ignvCrtW5sZJr
         iVV2hv3ETdAV5wWsDLh++zy1w14Jxv24nSGXsHSP8ST2EDIcSsuZw278u8Sz9geLp9LQ
         v0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=jvl1LSj3XRAAYc1cgvrCjPzwzDoCnvUusWOvAYnNZFEUHqAbcRdi2qlVk4JS4xpJQi
         fH8+sCqgSofMV3Tw2OgbnRUc0qbYIKdi7D67I/30ZYNduD33mzeM/fQie51L7Bn5n5za
         4Hsz37Q/PStbDOoPD5MZiHgJODxFIKoNYWhVvFmcOrKERb6Y+6M9G+QoHf86/mQH7KLt
         MZHCpTAf0NKprcvyZdkwBcBMtjZvrDuiPZITXIAW3px1mktiefUjNhmE3NSmuUOXHLHf
         rFGdbodgVJzVab6Tbmjui/zBGUgG4iHelBNND71aVxaHxRz+2ipgW4T/H+hR06lOaYfQ
         GsmQ==
X-Gm-Message-State: AFeK/H0Jr3RvToGfzfJ0bzC9C7ec7CINtuWD0gyWYG7npy6KqxNK1CC335/a/VkfwrZzBw==
X-Received: by 10.55.9.144 with SMTP id 138mr10193124qkj.173.1491107754441;
        Sat, 01 Apr 2017 21:35:54 -0700 (PDT)
Received: from localhost.localdomain ([189.103.231.223])
        by smtp.gmail.com with ESMTPSA id t23sm6907383qka.37.2017.04.01.21.35.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Apr 2017 21:35:53 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, peff@peff.net,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v6 2/5] remove_subtree(): test removing nested directories
Date:   Sun,  2 Apr 2017 01:35:23 -0300
Message-Id: <1491107726-21504-3-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1491107726-21504-1-git-send-email-bnmvco@gmail.com>
References: <1491107726-21504-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test removing a nested directory when an attempt is made to restore the
index to a state where it does not exist. A similar test could be found
previously in t/t2000-checkout-cache-clash.sh, but it did not check for
nested directories, which could allow a faulty implementation of
remove_subtree() pass the tests.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 t/t2000-checkout-cache-clash.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t2000-checkout-cache-clash.sh b/t/t2000-checkout-cache-clash.sh
index de3edb5..ac10ba3 100755
--- a/t/t2000-checkout-cache-clash.sh
+++ b/t/t2000-checkout-cache-clash.sh
@@ -57,4 +57,15 @@ test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
 	git checkout-index -a -f --prefix=there/
 '

+test_expect_success 'git checkout-index -f should remove nested subtrees' '
+	echo content >path &&
+	git update-index --add path &&
+	rm path &&
+	mkdir -p path/with/nested/paths &&
+	echo content >path/file1 &&
+	echo content >path/with/nested/paths/file2 &&
+	git checkout-index -f -a &&
+	test ! -d path
+'
+
 test_done
--
2.7.4 (Apple Git-66)

