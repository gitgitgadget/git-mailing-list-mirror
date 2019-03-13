Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7067620248
	for <e@80x24.org>; Wed, 13 Mar 2019 18:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfCMS0g (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 14:26:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40234 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCMS0g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 14:26:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id t5so3105998wri.7
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 11:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=NIcfkaNBiRHR4be75oeKPp016U9aQBv75cXHRoemeHY=;
        b=b276+n9A422HcLMtfVde6rzPYCCMJ5fUvlgAAixyEf7tzJw7ovYdIUxWT2faD59+/P
         x211od7LhK//vBQDhFp/dOctirDHVElggpeO2Va8F3SlwkHZi33USICL8elCIbGCOAGl
         aHX2nmselgSxrh/QIQkmCx+QBFqPV9UHdrvb1Ctx38Lrdmw1eOtZeHStAguR8YK3NHdT
         wZaDacd1mQ0AO6lTM1FzhmV+Snbh9sdFvm8TstWE1UD3cFrytVk/c44WIsBYAvYn4i/e
         qVjgqgi6n7jjW4wRpnBwXspx7/jaPESak4F8h1CxFtOVYPfw0LrR8AIZM+ufgmmwIo/m
         oSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=NIcfkaNBiRHR4be75oeKPp016U9aQBv75cXHRoemeHY=;
        b=Ss9KRENCQFrAVyIUTAuOZp7u7XddeLjcx4T+g9QNaBCat5QkCjzznpfafF/z3WSZMk
         NduimDgCr+81W4jdWbn9b3HBskJqgxVPPTRAhMgfaY9YRXgETTbCDg/T0QeBoqbY+jlx
         Y6KDdPPPr+KW/sm+sCPE0xjWYAmGnO+uZCoESAwpNMJzVQ2ahCSc+1k3YC7MPen+sLbb
         Wiiloby16PWO/n4SeXYqM254UfxmmQ/fFRoc3fhRaayUD24yhtkC2ojWK+fCmAn0sD8J
         eCr6zxBrNhHaAx9DuNMrsdATzFlpsHnz4xxNKOCwC899Vekvl9rQOMpGM/CuPjThNCH6
         VEUg==
X-Gm-Message-State: APjAAAUCexlLUyw4wMJMaCStT9W5X7rCrx3lFep8aIlphM757rqJY5Z4
        gpYJ5OrVpkb62AiEIJpzI2gffjywUJNKZg==
X-Google-Smtp-Source: APXvYqxfOiUd0ynMdBleCxz/GO/eOfTumtZ3V4NbgokN3CJQKgq8rzgvPrdYp0rRL3U6+SKrImSp2w==
X-Received: by 2002:adf:e5d2:: with SMTP id a18mr14044256wrn.34.1552501594087;
        Wed, 13 Mar 2019 11:26:34 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.gmail.com with ESMTPSA id i62sm2753807wmg.17.2019.03.13.11.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:26:33 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/3] cherry-pick: demonstrate option amnesia
Date:   Wed, 13 Mar 2019 18:26:14 +0000
Message-Id: <20190313182615.7351-2-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313182615.7351-1-phillip.wood123@gmail.com>
References: <20190313182615.7351-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When cherry-pick stops for a conflict resolution it forgets
--allow-empty --allow-empty-message and --keep-redundant-commits.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3507-cherry-pick-conflict.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 0db166152a..79e994cffa 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -25,6 +25,11 @@ test_expect_success setup '
 	test_commit base foo b &&
 	test_commit picked foo c &&
 	test_commit --signoff picked-signed foo d &&
+	git checkout -b topic initial &&
+	test_commit redundant-pick foo c redundant &&
+	git commit --allow-empty --allow-empty-message &&
+	git tag empty &&
+	git checkout master &&
 	git config advice.detachedhead false
 
 '
@@ -405,4 +410,23 @@ test_expect_success 'cherry-pick preserves sparse-checkout' '
 	test_i18ngrep ! "Changes not staged for commit:" actual
 '
 
+test_expect_failure 'cherry-pick --continue remembers --keep-redundant-commits' '
+	test_when_finished "git cherry-pick --abort || :" &&
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --keep-redundant-commits picked redundant &&
+	echo c >foo &&
+	git add foo &&
+	git cherry-pick --continue
+'
+
+test_expect_failure 'cherry-pick --continue remembers --allow-empty and --allow-empty-message' '
+	test_when_finished "git cherry-pick --abort || :" &&
+	pristine_detach initial &&
+	test_must_fail git cherry-pick --allow-empty --allow-empty-message \
+				       picked empty &&
+	echo c >foo &&
+	git add foo &&
+	git cherry-pick --continue
+'
+
 test_done
-- 
2.21.0

