Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A05E1FC44
	for <e@80x24.org>; Wed, 15 Feb 2017 11:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbdBOLRJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 06:17:09 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32927 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdBOLRI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 06:17:08 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so7643663wmv.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 03:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v2PKTEQZoRVeIhtUVw1ZjR9JMrqFdVlZNRSn3vBER9c=;
        b=EPCEMUl8NXrUhATu6u831r77ppbKHctLEHk0kYNg2L8/8SzQZdxjzFmN9XMyBVhaNO
         EPZIgR/Mw8h8PY/mRG0zcsmxqLpqVwzENgkZhebOHo7EIigiMjWmY8yFZb5x2HTM26FJ
         YytePtm1nwMH8zbAOg0/qIutP7ZDaJGNXFAyOB81jJJJ3nMKEeZRXft7tsgeOcF80u7X
         Cg7BiraZO0bIn1Cp11r/e7h52fBbbRfbQTuc7WCazJL2qT8f88qP2Cmw8NjPQ4mPeKjA
         i/WJTo79MsZgKw+0tu8BNlAjLZb1TG3o7PBSFctZDemKOAYn1wihKQ8a6RNEHFNvCSue
         6mzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v2PKTEQZoRVeIhtUVw1ZjR9JMrqFdVlZNRSn3vBER9c=;
        b=BRym2KMZAmRtIveEpl0BlWbmqwc3ruX0iseDBVwqkOjk6vJKfS3M60phb+nudEdHef
         UPA4V+kGjpJKaPeGzHiQu3kM2qdr+Tao1Q9LvPf7C2zX8/cWhg5afgVWk0ejXXad2JVV
         flrCtd0e/3/CDklzX/HG9yataMqN1nGR5itW83/bx4WaCgJzLbxetEazwkSDVkBfQILF
         uEaV4cTPt24UqS3mbSEa9yOcAsAxO3QXTA+ZsaQcfCLivZuvLFM80tcEsXsHf48pn1jJ
         sY85WKEY6Iqx3pVC+h5iyagfHL0TDnFhNuhiyQMpIQ5uB9PnkUPfKBP/J63BXzMkRQEf
         PLxQ==
X-Gm-Message-State: AMke39lo6qREl6+4+ev95yc/1hNwIhR4WvOyjZxp/n75WURO2RmXQlyXY4WIMkqiat7RdQ==
X-Received: by 10.28.65.132 with SMTP id o126mr7223208wma.14.1487157426873;
        Wed, 15 Feb 2017 03:17:06 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w207sm7120775wmw.29.2017.02.15.03.17.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 03:17:05 -0800 (PST)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com
Subject: [BUG] submodule config does not apply to upper case submodules?
Date:   Wed, 15 Feb 2017 12:17:04 +0100
Message-Id: <20170215111704.78320-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like as if submodule configs ("submodule.*") for submodules
with upper case names are ignored. The test cases shows that skipping
a submodule during a recursive clone seems not to work.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

I observed the bug on Windows, macOS, and Linux and at least on
v2.11.0 and v2.11.1:
https://travis-ci.org/larsxschneider/git/builds/201828672

Right now I have no time to fix it but I might be able to look into it
next week (if no one else tackles it before that).

Cheers,
Lars


Notes:
    Base Commit: 3b9e3c2ced (v2.11.1)
    Diff on Web: https://github.com/larsxschneider/git/commit/a122feaf9f
    Checkout:    git fetch https://github.com/larsxschneider/git submodule/uppercase-bug-v1 && git checkout a122feaf9f

 t/t7400-submodule-basic.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b77cce8e40..83b5c0d1e0 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1116,5 +1116,39 @@ test_expect_success 'submodule helper list is not confused by common prefixes' '
 	test_cmp expect actual
 '

+test_expect_success 'submodule config does not apply to upper case submodules' '
+	test_when_finished "rm -rf super lowersub clone-success clone-failure" &&
+	mkdir lowersub &&
+	(
+		cd lowersub &&
+		git init &&
+		>t &&
+		git add t &&
+		git commit -m "initial commit lowersub"
+	) &&
+	mkdir UPPERSUB &&
+	(
+		cd UPPERSUB &&
+		git init &&
+		>t &&
+		git add t &&
+		git commit -m "initial commit UPPERSUB"
+	) &&
+	mkdir super &&
+	(
+		cd super &&
+		git init &&
+		>t &&
+		git add t &&
+		git commit -m "initial commit super" &&
+		git submodule add ../lowersub &&
+		git submodule add ../UPPERSUB &&
+		git commit -m "add submodules"
+	) &&
+	git -c submodule.lowersub.update=none clone --recursive super clone-success 2>&1 |
+		grep "Skipping submodule" &&
+	git -c submodule.UPPERSUB.update=none clone --recursive super clone-failure 2>&1 |
+		grep "Skipping submodule"
+'

 test_done

base-commit: 3b9e3c2cede15057af3ff8076c45ad5f33829436
--
2.11.0

