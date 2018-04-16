Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75DEF1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeDPWlc (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:41:32 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46727 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeDPWla (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:41:30 -0400
Received: by mail-wr0-f195.google.com with SMTP id d1so30254611wrj.13
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1f0cTom7s2LM80kNzY/sCwoXMAcZ+nJviU+mi9SngoI=;
        b=XFQCEDuq9Tva+Dom9UVcaISaoMC4k0DL3c1xLiuauP8RLsf0wZsOi94WIKlU3O48vy
         v9qFO2v8BknaiRnlfxmXba2C+9lhjwHIOoYZfcFC4dkg1E/IbZksfmoaFpoXpB6Yg2ek
         3bpcUoRQBHp0B5xYiFZlePyp0RL6nGej/PT466JIlM8ipK7xVNa1I+n/M+kzLPtGgS3a
         lEIac5ppy6IXUUw4qJhcGMMob5alY5wwX/URrJ9fSQtfynvN5VLWklR3F05kFEwBg7Jj
         sqTk70Sau9ejgiFADOfwvJsYUCqzxP5v2yR0JLpFcn0UHdXACLUqJGp4gl4PI+OdQwKW
         Iehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1f0cTom7s2LM80kNzY/sCwoXMAcZ+nJviU+mi9SngoI=;
        b=fYABTzcgPfytHkbjSiOnfDuUxjDjBd3yG9TLOBA9/7rE3NNt54cwG0gJ3Vz4wVwEo+
         aScv53podK/sEEooqmAT7syfgydxhvoFlBtyIklqy5iBTmcqvxftpZypUS4PwwZEa/WB
         jSLqjFL2DSDuskq967cLyHjLk7kWbbIJ2OzPUkL3N6V32LMIBBO0KfJ0HDKLX/JNlSKU
         SwMQWDGMcgw0RAzD06q0NDDzC3KuMjCdey58paltezlOuT5bsfzisBEZ23fJLO4ysfJZ
         oJc/P3AlW5S6XT0Xi+7XXCK3kuXz/K69YEG7ZfqGOJ46e4l9L0hzrzTbq25o3NmsNZYW
         MEqw==
X-Gm-Message-State: ALQs6tBZNsPWCi5EcifKlJaiMYXM2L4eZSb4Ck0AmDZaN7WTl42pfiBg
        MwwXBvdxDBjLLrEJNO+U7NN30g==
X-Google-Smtp-Source: AIpwx486mZA5KSWUpvt0i+aXDeQKawpgfa3SMdVskSV+gAcQT2nZ95+RiDerPaifLV54gDiBeMbeqQ==
X-Received: by 10.28.237.11 with SMTP id l11mr73557wmh.124.1523918488790;
        Mon, 16 Apr 2018 15:41:28 -0700 (PDT)
Received: from localhost.localdomain (x590d89db.dyn.telefonica.de. [89.13.137.219])
        by smtp.gmail.com with ESMTPSA id p128sm14977788wmd.45.2018.04.16.15.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Apr 2018 15:41:28 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 08/11] t9902-completion: ignore COMPREPLY element order in some tests
Date:   Tue, 17 Apr 2018 00:41:12 +0200
Message-Id: <20180416224113.16993-9-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.gbe216a3084
In-Reply-To: <20180416224113.16993-1-szeder.dev@gmail.com>
References: <20180318012618.32691-1-szeder.dev@gmail.com>
 <20180416224113.16993-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The order or possible completion words in the COMPREPLY array doesn't
actually matter, as long as all the right words are in there, because
Bash will sort them anyway.  Yet, our tests looking at the elements of
COMPREPLY always expect them to be in a specific order.

Now, this hasn't been an issue before, but the next patch is about to
optimize a bit more our git-aware path completion, and as a harmless
side effect the order of elements in COMPREPLY will change.  Worse,
the order will be downright undefined, because after the next patch
path components will come directly from iterating through an
associative array in 'awk', and the order of iteration over the
elements in those arrays is undefined, and indeed different 'awk'
implementations produce different order.  Consequently, we can't get
away with simply adjusting the expected results in the affected tests.

Modify the 'test_completion' helper function to sort both the expected
and the actual results, i.e. the elements in COMPREPLY, before
comparing them, so the tests using this helper function will work
regardless of the order of elements.

Note that this change still leaves a bunch of tests depending on the
order of elements in COMPREPLY, tests that focus on a specific helper
function and therefore don't use the 'test_completion' helper.  I
would rather deal with those later, when (if ever) the need actually
arises, than create unnecessary code churn now.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9902-completion.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f7a9dd446d..a747998d6c 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -84,10 +84,11 @@ test_completion ()
 	then
 		printf '%s\n' "$2" >expected
 	else
-		sed -e 's/Z$//' >expected
+		sed -e 's/Z$//' |sort >expected
 	fi &&
 	run_completion "$1" &&
-	test_cmp expected out
+	sort out >out_sorted &&
+	test_cmp expected out_sorted
 }
 
 # Test __gitcomp.
@@ -1405,6 +1406,7 @@ test_expect_success 'complete files' '
 
 	echo "expected" > .gitignore &&
 	echo "out" >> .gitignore &&
+	echo "out_sorted" >> .gitignore &&
 
 	git add .gitignore &&
 	test_completion "git commit " ".gitignore" &&
-- 
2.17.0.366.gbe216a3084

