Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75D1C1F731
	for <e@80x24.org>; Sun,  4 Aug 2019 21:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfHDVPf (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Aug 2019 17:15:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38463 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfHDVPe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Aug 2019 17:15:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id z14so1362617pga.5
        for <git@vger.kernel.org>; Sun, 04 Aug 2019 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5JRF6kz7oYfcyh/BdB755p5NafgD2bqv/JctPcrazss=;
        b=Ks5s1MBEXFo8bMU/Gj1WwlBHQ6Y1J73gM2p4VWJ+6VmQVJXBTzR8Tsci4VuE0BMoO/
         ydBu7THLCSNGKziI3CMPyjXCd/5qCN51o9BmYLIBBjMy9lY5ypNzVvXilMaie4pNEAKT
         TLoIIzTEK8l/15BFUL1tLFEIBZGkGycn9W1/WobAhY2GXEtT2xrRdQFfn6w7W/44jeYV
         E4MwUWAKpKCW5B3BIJIQMQH1o8LRmp9Fv6pHkHLx7HlzMeNHkqHFzALwfMGEtrSf4uPt
         kybGCjyxJ3nMB+9otY8cT4DA7EEveVlWJMYdpyRxNI/NhPXDd4xwDZKmwezRN1gOkA/q
         9cbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JRF6kz7oYfcyh/BdB755p5NafgD2bqv/JctPcrazss=;
        b=NsH/0S3DfHrphhb5jbH0UL2nTjlXQJW3j8nQy25soAffANab9ouSXJ1n/zgc+k80VK
         wGuD95G2yV/Qy04hrw5ch+oKIovXdUPOzo87byPAfR5zu3kbb955IZi0tZXM928kvShb
         6YWKiX5D1vfQEVSEhDFqIBYm2oqdA1dipcx7VgqGB6fUiKSYaPyGtGuYRfUVzcmhHmfU
         NFjs65Zy/VxbJ5zJ8d2PHEu/G2FmKjM0Nyc0AliiS0he8jGQZVUhNbhlQKpHuLpDXN68
         pJHPEajy3WRQdM9AWpDB2PFWC5k6V1zFOA9RAaf7M5zUg8YtAEBdpMK9DNYze3pr7x1c
         fCWQ==
X-Gm-Message-State: APjAAAUCu83xkTobE5VVuERtdmdoBEHQdVXOkyQ3+zNMEejlLJDlWjYt
        SFNxE5d1Hol9+llc6/xKIDvlmgO41L8PYA==
X-Google-Smtp-Source: APXvYqxCtevAWJRE1TTJHUrNY8QjYyHH+M1O3obdbGoVzX60S2XcVxSbStStoUNBb95OMHaQff861g==
X-Received: by 2002:a17:90a:9488:: with SMTP id s8mr15403874pjo.2.1564953333947;
        Sun, 04 Aug 2019 14:15:33 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id o130sm139031138pfg.171.2019.08.04.14.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Aug 2019 14:15:33 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     frekui@gmail.com, michael.osipov@siemens.com,
        ibrahim.vanak@hpe.com, matheus.bernardino@usp.br,
        vleschuk@accesssoftek.com
Subject: [RFC PATCH 1/2] p7810: add more grep performance relevant cases
Date:   Sun,  4 Aug 2019 14:15:08 -0700
Message-Id: <20190804211509.39229-2-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190804211509.39229-1-carenas@gmail.com>
References: <20190804211509.39229-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a baseline for a matching regex and make clear the distinction
between fixed (now using kwset) and a real simple expression.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/perf/p7810-grep.sh | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/t/perf/p7810-grep.sh b/t/perf/p7810-grep.sh
index 9f4ade639f..9a4e335659 100755
--- a/t/perf/p7810-grep.sh
+++ b/t/perf/p7810-grep.sh
@@ -7,13 +7,34 @@ test_description="git-grep performance in various modes"
 test_perf_large_repo
 test_checkout_worktree
 
-test_perf 'grep worktree, cheap regex' '
+test_perf 'grep worktree, fixed regex (no match)' '
 	git grep some_nonexistent_string || :
 '
+test_perf 'grep worktree, fixed regex (common)' '
+	git grep void || :
+'
+test_perf 'grep -I, fixed non binary regex (common)' '
+	git grep -i void || :
+'
+test_perf 'grep -i, fixed caseless regex (common)' '
+	git grep -i void || :
+'
+test_perf 'grep --no-index, fixed regex (common)' '
+	git grep --no-index void || :
+'
+test_perf 'grep worktree, simple regex (common)' '
+	git grep "void|int" || :
+'
+test_perf 'grep -I, simple non binary regex (common)' '
+	git grep -I "void|int" || :
+'
+test_perf 'grep -i, simple caseless regex (common)' '
+	git grep -i "void|int" || :
+'
 test_perf 'grep worktree, expensive regex' '
 	git grep "^.* *some_nonexistent_string$" || :
 '
-test_perf 'grep --cached, cheap regex' '
+test_perf 'grep --cached, fixed regex' '
 	git grep --cached some_nonexistent_string || :
 '
 test_perf 'grep --cached, expensive regex' '
-- 
2.23.0.rc1

