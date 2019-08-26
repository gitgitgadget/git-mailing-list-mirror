Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 716601F4B9
	for <e@80x24.org>; Mon, 26 Aug 2019 23:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfHZXwf (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 19:52:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42919 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfHZXwe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 19:52:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so11526258pgb.9
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 16:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4uYk/EQqaWr0WtOQi/ULHb8ikSHAg+0DYKBTD543h4Q=;
        b=tMdF2rg3Nav6JfmhwxSIrazoMCQDR2rVPMszDaynZqznlwJF7tWfGlQZvoD/Jx+Z0R
         tBwf0FoNONodc1AbDe4jVJ/NCa00m7YfpKnxs46662JE8wHE8Fru7PdK7virS1t11nCO
         4hAI9aQtzu0vVUz97PzS1sPNMQW3wTA6MdXcbWddGRtoSk1J6vZwL+pago/CVga5MWUg
         kaoWl7lwGuJgJ9OK/g5p0rROc5FpwU46QP2+0N1kC/+Ui3+eFwSFDUwWSY9FldnOvoO6
         qWLUppxCXDvVTa3M9CHTIu8U9jFxiq975EfdfH+rmJUDb0pR6HDf5Fj8XvuBAns5n3By
         TMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4uYk/EQqaWr0WtOQi/ULHb8ikSHAg+0DYKBTD543h4Q=;
        b=sIL5kyGEdo0VhT0iP46CzzrQzg2CpgaCfatYbVmvG8hMmhbIhJtd98L3pc6hlKV6Ux
         cFWdCRsyae9dj+O9/IulZw+9uBlw1kqZHskeu8mSfQHcXy6RsVmAnow3I5u32aW8M5QE
         XIg4c3yj0Xtkxv0q8Jmb0QUUpDueTTpEPbK2O0Iy3Pe61i1voP6FSLGPr1EKMx47Z9rO
         z1vwyXH7BGHunSllOrEHMmxsnjCIWmpTRSrlp2CUBBD+rHT9ZwuFpfoNs9zLSSPaHe/M
         Az03NcjVQ8EYC9h9YCapneLz+d6N1OwVAMz8RfH631aU3lo1VTc0v3O+I618YY2NUiTG
         h8EQ==
X-Gm-Message-State: APjAAAXL1AfXUxSIbqmUoQUOn0XxsEJKmIUgcPYgRoU6CIKR8e3hAcuJ
        zzi7DzX3SLatw1NcGbOWxHIPaxda
X-Google-Smtp-Source: APXvYqxej07y+uatk4DKdu7l5GcktCyYoPBI/PYRlVYkJPB+RNdIH/NY86uvOgLF5up17F2aEBR/XA==
X-Received: by 2002:a17:90a:3be5:: with SMTP id e92mr21161331pjc.86.1566863553424;
        Mon, 26 Aug 2019 16:52:33 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id 21sm5939047pfb.96.2019.08.26.16.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Aug 2019 16:52:32 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 1/5] t6006: simplify and optimize empty message test
Date:   Mon, 26 Aug 2019 16:52:22 -0700
Message-Id: <20190826235226.15386-2-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.5.g775ebaa2a0
In-Reply-To: <20190826235226.15386-1-newren@gmail.com>
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com>
 <20190826235226.15386-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test t6006.71 ("oneline with empty message") was creating two commits
with simple commit messages, and then running filter-branch to rewrite
the commit messages to be empty.  This test was written this way because
the --allow-empty-message option to git commit did not exist at the
time.  Simplify this test and avoid the need to invoke filter-branch by
just using --allow-empty-message when creating the commit.

Despite only being one piece of the 71st test and there being 73 tests
overall, this small change to just this one test speeds up the overall
execution time of t6006 (as measured by the best of 3 runs of `time
./t6006-rev-list-format.sh`) by about 11% on Linux and by 13% on
Mac.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6006-rev-list-format.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index da113d975b..d30e41c9f7 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -501,9 +501,8 @@ test_expect_success 'reflog identity' '
 '
 
 test_expect_success 'oneline with empty message' '
-	git commit -m "dummy" --allow-empty &&
-	git commit -m "dummy" --allow-empty &&
-	git filter-branch --msg-filter "sed -e s/dummy//" HEAD^^.. &&
+	git commit --allow-empty --allow-empty-message &&
+	git commit --allow-empty --allow-empty-message &&
 	git rev-list --oneline HEAD >test.txt &&
 	test_line_count = 5 test.txt &&
 	git rev-list --oneline --graph HEAD >testg.txt &&
-- 
2.23.0.5.g775ebaa2a0

