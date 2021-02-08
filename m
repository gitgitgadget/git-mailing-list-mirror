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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC0AC433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B85B64E92
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbhBHT26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbhBHT2p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:28:45 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8326C06178B
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:27:56 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cl8so149286pjb.0
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NwivfiCAPomv41vyCPNEJshsCwQ3WaLLCOEFACKUCYM=;
        b=ufEbjgnJ3FkOMcjtwamdbgSqCfAwWtc7vucT7AbF0MX/agdrLfqluSDmWsoOvsHj0e
         08vMWvlEVMdNBml+ETrBxAPpcSmfHA8s+XhlUADBZEj22CNkhVgE8C1UJCcLxmhRC200
         GBAq4p73EbbNTdf4ebpryEiw15O4dTH0TmtfBV/cWWdpUMabSaTBivDSweRy2TD5yPiw
         ymJwElZApq8+LNn73BN95ZqdR+o6Uy5dfbBqbtKgwAuZv9QZ54xwceXlTtQdhgUrbMgg
         rRMd05QjymP5qrKduKR2pKBZa2Jk4ceRznj5X3he+JM5EyiqbKMiPy8v7KsijWi3WRTs
         yezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwivfiCAPomv41vyCPNEJshsCwQ3WaLLCOEFACKUCYM=;
        b=Jf/Q/9aWTqLrcty6D4iRSsHK/umZrNp74ubh6DmRVbDOJs9XFu/5uzw22p214j/cRj
         4QbGTpYzmdSoj5UU565I1IDbAzLoAgs0o6fC8DZB8omIOQbSBkvXu3Q8xcFtslH9w6dq
         4jQnAKTTFqRR1HEQciBQe+JxEidqf7N2y0bnRE8dBbl+hjwTUmoRRz/4IQ3CHPUSiHln
         e11UzSw8j3SQimXg3GbSsTXf7pjGvd+WTkADG0UqrwWzWuHr3uy/MD6OT27NX9ejX3iy
         z7/yB9+odttRrq8COV2UYPYYMPd4A5g7h5vztCqs0ZyzbWgKeHsDn6yei/51Kvn+qsq4
         Mxrw==
X-Gm-Message-State: AOAM530Oz6KniKR3E3IyhlYDnIGgyKvczQ2qb0qdBgb6Z0oq+yWDRwkq
        hC78n+Ux3fCjChDNolrsOIykyrtFtIGrFw==
X-Google-Smtp-Source: ABdhPJxDE1PTmsX1MQUYUMDYNRx03vQW5vLNJGqTthTd1RfQVyKjjTBF4FKIJsSwtMJvaCHmkQvy6A==
X-Received: by 2002:a17:902:a383:b029:e0:10e6:6ed7 with SMTP id x3-20020a170902a383b02900e010e66ed7mr18123044pla.5.1612812476176;
        Mon, 08 Feb 2021 11:27:56 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:91c3:5a1c:9f2d:b1e6])
        by smtp.googlemail.com with ESMTPSA id a141sm19765444pfa.189.2021.02.08.11.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:27:55 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 05/11] t/t3437: fix indentation of the here-doc
Date:   Tue,  9 Feb 2021 00:55:24 +0530
Message-Id: <20210208192528.21399-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The most common way to format here-docs in Git test scripts is for the
body and EOF to be indented the same amount as the command which opened
the here-doc. Fix a few here-docs in this script to conform to that
standard.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t3437-rebase-fixup-options.sh | 62 ++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 36dee15c4b..3de899f68a 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -38,13 +38,13 @@ get_author () {
 
 test_expect_success 'setup' '
 	cat >message <<-EOF &&
-		amend! B
-		${EMPTY}
-		new subject
-		${EMPTY}
-		new
-		body
-		EOF
+	amend! B
+	${EMPTY}
+	new subject
+	${EMPTY}
+	new
+	body
+	EOF
 
 	sed "1,2d" message >expected-message &&
 
@@ -70,38 +70,38 @@ test_expect_success 'setup' '
 	git commit --fixup=HEAD -a &&
 	test_tick &&
 	git commit --allow-empty -F - <<-EOF &&
-		amend! B
-		${EMPTY}
-		B
-		${EMPTY}
-		edited 1
-		EOF
+	amend! B
+	${EMPTY}
+	B
+	${EMPTY}
+	edited 1
+	EOF
 	test_tick &&
 	git commit --allow-empty -F - <<-EOF &&
-		amend! amend! B
-		${EMPTY}
-		B
-		${EMPTY}
-		edited 1
-		${EMPTY}
-		edited 2
-		EOF
+	amend! amend! B
+	${EMPTY}
+	B
+	${EMPTY}
+	edited 1
+	${EMPTY}
+	edited 2
+	EOF
 	echo B2 >B &&
 	test_tick &&
 	FAKE_COMMIT_AMEND="edited squash" git commit --squash=HEAD -a &&
 	echo B3 >B &&
 	test_tick &&
 	git commit -a -F - <<-EOF &&
-		amend! amend! amend! B
-		${EMPTY}
-		B
-		${EMPTY}
-		edited 1
-		${EMPTY}
-		edited 2
-		${EMPTY}
-		edited 3
-		EOF
+	amend! amend! amend! B
+	${EMPTY}
+	B
+	${EMPTY}
+	edited 1
+	${EMPTY}
+	edited 2
+	${EMPTY}
+	edited 3
+	EOF
 
 	GIT_AUTHOR_NAME="Rebase Author" &&
 	GIT_AUTHOR_EMAIL="rebase.author@example.com" &&
-- 
2.29.0.rc1

