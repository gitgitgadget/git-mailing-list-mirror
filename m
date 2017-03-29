Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288DC1FAFB
	for <e@80x24.org>; Wed, 29 Mar 2017 00:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932855AbdC2AeZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 20:34:25 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35909 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932751AbdC2AdB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 20:33:01 -0400
Received: by mail-qk0-f196.google.com with SMTP id r142so117020qke.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 17:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=PBRYCmmr+VSbRNCqu1nfgO3zp33cfOiYUGqbuvemXgEcJXFXmONmHQqX8HOiGxT6vH
         ZEsGstOFZAALtt0xnWmpRdNMSt6ttz7AJLgiYONyCB/sCggDnHtMXOpjQULs+ysSqQaw
         nYdWEjs0hmIZ0RNEOmB9dSxx/nw66zD2Hmmx+IisXwa1NXwV/+IdnfJEDsbd+sqnNGgP
         anmuwHj4/ZnHJ84ONbgTfZjcpGSYg34yuDu6iq5sfke93csgUQ4Rmr4dwsl16SzFPJK5
         FfjAZYhPrwAsOi89J6yJ8lyfPN+DyNd6iSbCrLUKpgtveGuWiF4SbVyXx7ubzkjhe/kV
         qkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pzFsU7KRWPNtGJQ7O+VFQO5PVBaIluekPP1yjXO8mQw=;
        b=PIGFKIlx3ao/cchuGHtQGqnYyaXvyxlxabKN2U5UI9rx3xegesZSYftdWVo10nDWEi
         2Oo1Ou0Sjvwy1avQYBIiaIBo8sXueOuW5X16ubKfbfu/fE5SnQsalJBfZs6KTQOokmR6
         wFdjDN3qY0FNzXsIzuNspMi7q9JNir/XNQcGx/e1xa5TnpCy4e+zTlbYhE1WCyOMfII0
         hk64oLViHVRwlqtKJSxhzP13NsypgB/bz2OIODh67nl9iJo4NWEiFK7eTkV7MCUO3T0M
         kLuowM5KCTMHgLyLjGY9O+R0gZtvDLQF84hXLJv1erhpCLpS1zrCMqoZybeIN5vpmEnt
         7gCg==
X-Gm-Message-State: AFeK/H2icVyWxRohFmf9cwdSdPu67FMD0ZI0RzJumC8jEB63RBx4ChZ+rGxSyyfwhav9Vw==
X-Received: by 10.55.7.148 with SMTP id 142mr30116560qkh.181.1490747565348;
        Tue, 28 Mar 2017 17:32:45 -0700 (PDT)
Received: from Daniels-MacBook-Pro.local.net ([187.11.121.49])
        by smtp.gmail.com with ESMTPSA id x26sm3819420qtx.47.2017.03.28.17.32.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 28 Mar 2017 17:32:44 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v4 4/5] remove_subtree(): test removing nested directories
Date:   Tue, 28 Mar 2017 21:32:12 -0300
Message-Id: <1490747533-89143-5-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
References: <1490747533-89143-1-git-send-email-bnmvco@gmail.com>
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

