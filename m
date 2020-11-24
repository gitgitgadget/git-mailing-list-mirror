Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A771C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BF92076E
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 11:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BneCxsVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbgKXLzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbgKXLy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 06:54:59 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024AEC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:54:58 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p19so1875850wmg.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 03:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ABmeidf08iWr6uFSAbrqyV8fC2Efm5ECbHbKk7e25QA=;
        b=BneCxsVSKdDHjFIPPVIE+6joNmCzxCmMNML+kj1ZKR1WcbTtbAtrZKJPWcj360kRYh
         12Zl5wWQDpSs8g072lv0hV4lp32uDhuo8/l5OIG6SCY0TOzfMylnS1bO32/CFOsVZuBJ
         2UOzMfaEdR+mqHnQHm6XnmJgJeqWs8fjh8CnInk52e1Nbfdt9mPT1sNCC03shakg8o2i
         QOEyMCKf4aa/keAif6Cn/WJrI9BuHUbQw1UmwPPviydHV7FgTgrWKY2SZrMrkTUVj6YR
         +uU+pUKsm4wyjQZtgCZFWB31UPZCoZyg3RrSJ8ZeWLbbeEMKlKQUqWQKa8OxNWF2PKFA
         U9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ABmeidf08iWr6uFSAbrqyV8fC2Efm5ECbHbKk7e25QA=;
        b=FjaTZK7haSbjTida+GTQZUeZcNMSy/lyRq9XMOgpmXZsGU31JQK+URcUWshxyIf/Kc
         8Lf0mm8fcLtaYFTdaxPx89BTL6eSkRsqIhPyKre7yw94Ja3MXju414czP+gD8D+tBQzK
         P3vyFykqV8W/JNRpc7t1Xbk/ZS5S+IlOP+qV/ZSXQPaO4RaU6Pzl2I5lLwArLKOzjBEl
         blnyR9qGwBXcUwZTrDKV98XfyxuXMnL0r9i6lNzku09w9F4VXJmTnp6PMbUc5IqNmeU3
         XlpWDzA2OFIUfcYiA9nqd/MSTpi41ZydUBpI4+O2O96T90A1TfJnpFZeiKIaD/C08uM+
         pgtw==
X-Gm-Message-State: AOAM531QDMPEpB26pkzLLrD9p55OwDbkyWT8hDJJifzG0NRFVH9yrR6h
        7dhCTSkxF2gzX0+cX4EPbsZkchxXRcc=
X-Google-Smtp-Source: ABdhPJysRNJHaI4n77BiFuZir1IesBaqMgrSAvOwtj4rNEEfvIFTYP+WV35JBc4apfujhMYwDn90oQ==
X-Received: by 2002:a05:600c:2311:: with SMTP id 17mr4144515wmo.40.1606218896547;
        Tue, 24 Nov 2020 03:54:56 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-307-224.w86-199.abo.wanadoo.fr. [86.199.90.224])
        by smtp.googlemail.com with ESMTPSA id l13sm25893227wrm.24.2020.11.24.03.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 03:54:56 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 01/13] t6407: modernise tests
Date:   Tue, 24 Nov 2020 12:53:03 +0100
Message-Id: <20201124115315.13311-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124115315.13311-1-alban.gruin@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests in t6407 uses a if/then/else to check if a command failed or
not, but we have the `test_must_fail' function to do it correctly for us
nowadays.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/t6407-merge-binary.sh | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
index 4e6c7cb77e..071d3f7343 100755
--- a/t/t6407-merge-binary.sh
+++ b/t/t6407-merge-binary.sh
@@ -5,7 +5,6 @@ test_description='ask merge-recursive to merge binary files'
 . ./test-lib.sh
 
 test_expect_success setup '
-
 	cat "$TEST_DIRECTORY"/test-binary-1.png >m &&
 	git add m &&
 	git ls-files -s | sed -e "s/ 0	/ 1	/" >E1 &&
@@ -35,33 +34,19 @@ test_expect_success setup '
 '
 
 test_expect_success resolve '
-
 	rm -f a* m* &&
 	git reset --hard anchor &&
-
-	if git merge -s resolve master
-	then
-		echo Oops, should not have succeeded
-		false
-	else
-		git ls-files -s >current
-		test_cmp expect current
-	fi
+	test_must_fail git merge -s resolve master &&
+	git ls-files -s >current &&
+	test_cmp expect current
 '
 
 test_expect_success recursive '
-
 	rm -f a* m* &&
 	git reset --hard anchor &&
-
-	if git merge -s recursive master
-	then
-		echo Oops, should not have succeeded
-		false
-	else
-		git ls-files -s >current
-		test_cmp expect current
-	fi
+	test_must_fail git merge -s recursive master &&
+	git ls-files -s >current &&
+	test_cmp expect current
 '
 
 test_done
-- 
2.29.2.260.ge31aba42fb

