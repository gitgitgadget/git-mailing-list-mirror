Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8E7C35243
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050D5207E0
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SziP+MYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgAPGOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32838 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730126AbgAPGOl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so17914690wrq.0
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3muzs1s8jPipA1T8GQk7Xh/VUjMuS5qZYkTINqYuvjk=;
        b=SziP+MYi8panhSY6+JS7RDWgi/mF+5WpW6j7bp7KAXA249HCMUu+LXLdvbaCRvqFcQ
         w+pEMDqSkNULtlC/eXoMCyBmSZ+NCUBDNu59AuBECU3wxPaZeJvfbFBiLLxlf4Ek+nOM
         5vwF31Zd+CCEo2bCh+MLigRqHSykFU258LnNGr/3bugyQrQEMl0JKRdv4DkiJX9ruSrn
         URgwMBQH6n7clYkf3nV3cqE71xyRSm8r5GFuBv0RYklXNW1S2SP4jKU6nQ0Y1D89mzFd
         UmvUVpe5WLLuIX61ikoTjjuzS1rCmS/vwhZ8yQn760STrUpS/T1enT1iSdda5Xqvjn0L
         CA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3muzs1s8jPipA1T8GQk7Xh/VUjMuS5qZYkTINqYuvjk=;
        b=R8oh3cCXIb73zYYcplHTcLAvAPQYkXpUTR6b+Q5IgijX5TN0fMQINZizCeQAqeJ6tT
         R3/WJubS1pBNgg3h5Ae9tqBLU+hoSQMCEviQH3QyyatgApx7YJHlhgX1npFTbExnrogq
         /htwKVpJebIOvsQzw27C8bvwaaCgbyMRkPT9aZVyBjpXG7kE8zylfXA+lLv9oyWR/kaw
         hsvyVnB7touYQ5uYh90gYHesJM3+K6Hqn3qMK8VrdGQiQkCzyWa4vj75Ilto4LPY5lNq
         TO0HSXVWRhZoq8rFa5mFPuqAJb7t00Pa4btS2xHS9PY5Z+cOby0uaQn0+/62Rb5YikFh
         BCDQ==
X-Gm-Message-State: APjAAAWRUES9vOn69skAOGkkqqYfT4x6Uarmye75yZtNRzZYaX6d6fO3
        uOeOeSZZyZySdRLNYEOofqaHye0g
X-Google-Smtp-Source: APXvYqx0LToeZmXjmowKHD1ll9D1zp0THIp6nNibK8CiUXzXd+laA7DjbIhNGavEiOWiO/9wWwgRFQ==
X-Received: by 2002:adf:fbc9:: with SMTP id d9mr1375022wrs.20.1579155279304;
        Wed, 15 Jan 2020 22:14:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm28456699wrp.93.2020.01.15.22.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:38 -0800 (PST)
Message-Id: <9f66229d5cc6713bb237602f04fecbb33ade1160.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:19 +0000
Subject: [PATCH v4 05/19] t3406: simplify an already simple test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When the merge backend was re-implemented on top of the interactive
backend, the output of rebase --merge changed a little.  This change
allowed this test to be simplified, though it wasn't noticed until now.
Simplify the testcase a little.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3406-rebase-message.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index b393e1e9fe..0c2c569f95 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -18,11 +18,8 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'rebase -m' '
-	git rebase -m master >report &&
-	>expect &&
-	sed -n -e "/^Already applied: /p" \
-		-e "/^Committed: /p" report >actual &&
-	test_cmp expect actual
+	git rebase -m master >actual &&
+	test_must_be_empty actual
 '
 
 test_expect_success 'rebase against master twice' '
-- 
gitgitgadget

