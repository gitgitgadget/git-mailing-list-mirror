Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC0C211B5
	for <e@80x24.org>; Sun,  3 Feb 2019 06:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfBCGAu (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Feb 2019 01:00:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39270 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfBCGAu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Feb 2019 01:00:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so10042186wmi.4
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 22:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LLRhkGVy+gusSlz9dFdWvfk9KemXvycidFWKm93qR3M=;
        b=dP48gMorEuoylZNcTDsoDvxhHLyEBBnJrk7xC69gmmNnxvafRiua5oTJ1EKc/6gDrO
         oyk7GxDgnwY0hTYWJ/EIBZvf0xkp7X+C0zsRmyYRxK1eaLI79Lkei1feWTTuEEZqc4td
         fnDnai+Ds+IVot3pSIsFaR0n1kADc/MAP4DCntFz6hdix7HFq4P1Dzvgwa2J1vXy7KIW
         AykyLYVSKCTrkORqJwvBxR5nycwe06VBDOLEVdsAqMjvx8ilO5LPG5Suwm6dT3z9Y6p2
         LSkF48ymACBv4xos7lpftHjITM51KyIwlteZ6KnQuMogESIR6VEmuj/rQuIyR4VTAKoa
         tuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LLRhkGVy+gusSlz9dFdWvfk9KemXvycidFWKm93qR3M=;
        b=aFNXx8XARIQ3nFOPMm8KfXhkzOADhx0T/P9qdn4uKRc9IzEEJHGrJQETMamBK+6aYw
         NS/2jzyCKRmpW30z4ld/YRvYEYd2NXvC8hsxBJMLdOpVl0ZEwFL0f4H8beriF4+9Gc+P
         oiy12oGHsJR3BrlrRDDl5lJxcuz0p9Y/YMG5o5aNza+PAAxnsI0ZLOg7c8vYxHguEA8z
         rb0gMsndzWIc5AMHudqMCqH32+xn0Qb1y1ghkjcGx2BRUdt08DtDGjhAsoEyQnN10qW3
         ucETie4YqfCYVjgRdz74EjjvWQW4h+YlJOKR7n5ODZLMhZlnzK6LqhGveM/Umiai2NdG
         axeg==
X-Gm-Message-State: AHQUAuZf2rK2OCD9maIvDPIq1mgoQDiOAPfxOBIAPnP8aQh9uEAKzAlu
        0Iqk6+Aa7Hab10BAopwlgeggKur6quI=
X-Google-Smtp-Source: AHgI3IarBH47xAVmWE6LedUah5lSkgyB+bnshu+gNudkpECQrg0ImS8JoYCHr75a+CnsBRngSo7adA==
X-Received: by 2002:a1c:e488:: with SMTP id b130mr8621235wmh.124.1549173648251;
        Sat, 02 Feb 2019 22:00:48 -0800 (PST)
Received: from localhost.localdomain (ip5b43d796.dynamic.kabel-deutschland.de. [91.67.215.150])
        by smtp.gmail.com with ESMTPSA id c202sm15146179wmd.40.2019.02.02.22.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Feb 2019 22:00:47 -0800 (PST)
From:   Sebastian Staudt <koraktor@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>
Subject: [PATCH v5 2/2] t6120: test for describe with a bare repository
Date:   Sun,  3 Feb 2019 07:00:25 +0100
Message-Id: <20190203060025.7486-2-koraktor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203060025.7486-1-koraktor@gmail.com>
References: <20190203060025.7486-1-koraktor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This ensures that nothing breaks the basic functionality of describe for
bare repositories. Please note that --broken and --dirty need a working
tree.

Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
---
 t/t6120-describe.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index a9e3bf0ce0..ee5b03ee18 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -143,6 +143,12 @@ test_expect_success 'rename tag Q back to A' '
 test_expect_success 'pack tag refs' 'git pack-refs'
 check_describe A-* HEAD
 
+test_expect_success 'describe works from outside repo using --git-dir' '
+	git clone --bare "$TRASH_DIRECTORY" "$TRASH_DIRECTORY/bare" &&
+	git --git-dir "$TRASH_DIRECTORY/bare" describe >out &&
+	grep "^A-[1-9][0-9]\?-g[0-9a-f]\+$" out
+'
+
 check_describe "A-*[0-9a-f]" --dirty
 
 test_expect_success 'describe --dirty with --work-tree' '
-- 
2.20.1

