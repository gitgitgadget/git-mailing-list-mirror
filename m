Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C445C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 13:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0082120754
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 13:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG1dF/NX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCTNJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:09:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46906 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCTNJV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 09:09:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id c19so3189311pfo.13
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4aidziF31TrdeCaNrPWgAtlgpK7W5N/bHTar4sbR24=;
        b=LG1dF/NXKQUvrJFKxq8ox7uDS3ecATnhgT4hGDPM7KC+KE2Q2RPX8NM19HynCABxnX
         XA2WlwXIYyULS21qStY3TkiGYYtyFqrbfVge8Li2mfFeNXkXjzwfI9sia9VWekT9/8w+
         jjYhIbWxQ8B/6EWhvDW3yPmC+PhqXdHKIKwd3Q27gKgR341ys2z8f38nH7n94XMUb4Js
         8+YzlGeOa8ZXXu0+x2IqUQtcxe6aIszH5jjOIOyeclYD2jk8r2/I+TX46DH/MWJUjNcv
         vJzoA9bjQHSMPGcFw46PTy8irqxZKu1t7QVCR1DXSJjWaJlrO1Fc+ujokUBXUAA/gdT1
         doAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4aidziF31TrdeCaNrPWgAtlgpK7W5N/bHTar4sbR24=;
        b=qInVZ5kC3m7OwBlemlK1ELkElSpiYxHlxl8RFZv0wCEv2Kk5DxXDrn9uJKIpr9lS/E
         LNGwH6Pr1+lBqOkjjp/K5gOwpLjXJRE+kvXXzaGFUVtQMUpqyT+zYzQwSO9rjcZsXQMk
         l/9ZPv5T9LCi6pWk/itDhdKj4j7R8t+cfvqtaLYe6vEsaUwg7VvQooQLewqTf/7TLvAx
         V4FT6tjPznrsUpY9uEBxIVuFo2XHUVHMhGPODVakD3nlpKKEADeZim8oIH+uP+iVT1+L
         HDRglhKp4u9ukG7GiN07XL9UwKeA8LF9+8B/r5XRU8p5rfneoaWar22kVqODt0IWS2Kj
         MMqA==
X-Gm-Message-State: ANhLgQ3Ou8jNjW3zUO9WEF9etWJ+HyV09IWHOylh9VJ/GSyOrwrF2Dxs
        CG4AaRp4DY9FwXO7P7Doiz8=
X-Google-Smtp-Source: ADFU+vsKcytZ+1jLLzoD7k/TGUMOJkxAa0VZmkjQy2us1flUbYQkigkSnOLv7soc3MgYodvpMJHhHQ==
X-Received: by 2002:a63:e551:: with SMTP id z17mr8476945pgj.21.1584709758747;
        Fri, 20 Mar 2020 06:09:18 -0700 (PDT)
Received: from localhost.localdomain ([2409:4052:817:5e21:ec32:affe:2929:752d])
        by smtp.gmail.com with ESMTPSA id l7sm5433176pff.204.2020.03.20.06.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Mar 2020 06:09:17 -0700 (PDT)
From:   Harshit Jain <harshitjain1371999@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, harshitjain1371999@gmail.com,
        shouryashukla.oo@gmail.com
Subject: [PATCH 1/2] t4131: modernize style
Date:   Fri, 20 Mar 2020 18:38:44 +0530
Message-Id: <20200320130845.23257-2-harshitjain1371999@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200320130845.23257-1-harshitjain1371999@gmail.com>
References: <xmqq1rpodn25.fsf@gitster.c.googlers.com>
 <20200320130845.23257-1-harshitjain1371999@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests in t4131 leave a space character between the redirection operator
and the file i.e. the redirection target which does not conform to the
modern coding style.

Fix them.

Signed-off-by: Harshit Jain <harshitjain1371999@gmail.com>
---
 t/t4131-apply-fake-ancestor.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4131-apply-fake-ancestor.sh b/t/t4131-apply-fake-ancestor.sh
index b1361ce546..828d1a355b 100755
--- a/t/t4131-apply-fake-ancestor.sh
+++ b/t/t4131-apply-fake-ancestor.sh
@@ -17,8 +17,8 @@ test_expect_success 'setup' '
 
 test_expect_success 'apply --build-fake-ancestor' '
 	git checkout 2 &&
-	echo "A" > 1.t &&
-	git diff > 1.patch &&
+	echo "A" >1.t &&
+	git diff >1.patch &&
 	git reset --hard &&
 	git checkout 1 &&
 	git apply --build-fake-ancestor 1.ancestor 1.patch
@@ -26,8 +26,8 @@ test_expect_success 'apply --build-fake-ancestor' '
 
 test_expect_success 'apply --build-fake-ancestor in a subdirectory' '
 	git checkout 3 &&
-	echo "C" > sub/3.t &&
-	git diff > 3.patch &&
+	echo "C" >sub/3.t &&
+	git diff >3.patch &&
 	git reset --hard &&
 	git checkout 4 &&
 	(
-- 
2.26.0.rc2

