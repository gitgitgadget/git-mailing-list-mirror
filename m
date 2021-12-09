Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACCEC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhLIFPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhLIFPr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:47 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35883C0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:12 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id c3so5334315iob.6
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9vPYVVlzR0kpakY3lcmMZUNzOGN4MsAQ7a2V3dbcLCs=;
        b=grJm5foJhOYw/M0daI2dTqEsfqa+bl3uVD4N8mHZTPfLjqjFNOYNmJr2068wel1t1C
         DG9jozSqS0LDYKmCQGIOKoRJtEgVUZNa8w1H283qYCJ+p5Bdmm31Fm15pO6gMNg5Sys0
         XkJcWy85n8dJadLkiZ8CpdLxsqnVzJsHpMQSIorubOt8HE08G5dMLwG0pPCQTjmpwAuh
         b5T6UbxmMojGZgnKUgNucWeRMxblxJQRYX3L26j+mSvotyYuekczmyJefnHO5QuLpJs4
         yyi/+wYCR6JkisxJZfxf2O9pQf4PwUaZZi+xlSUDID5S7GZDmqQc2kpzlllEJZ1eHoUP
         gCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9vPYVVlzR0kpakY3lcmMZUNzOGN4MsAQ7a2V3dbcLCs=;
        b=A3/TlANPRUviQMdZpMF7LAt99v/ubx/yUzZ/aJmu/AE1nFkv0DR+dGyPthhKvMSXxo
         BPBdVCqv5yO0nin/GPzpwnq164OpVSJT6+9G4CpPkjzcrs7Jlf904hQUFrf5OFWAggG/
         F0psXnFfzu615B+GWNUAdQsDkKAXG+b7226BZ4QLbKEBa5pRePj9WmhllDG5vhOf/Slh
         j3+BByUeYI+qsL3bldedJOTuGuC9wflNxkR3Rs0ihXvxA46iPCALTpJx4Zcbv5orce6a
         hTMvrklCeIBFsjHCKPQbtlC4UfTpYfrliDhBSXj8btCi9AVNagdyRKNUWCYHl7gmF77g
         BZHg==
X-Gm-Message-State: AOAM530gI7r3nBCuEjH/poe1YMXg3KbocdwZj4j0eN9zkfmn0wTjREzk
        rAPxYsLxJIe1ZEpJ7tLi+TkDYibidvgSGQ==
X-Google-Smtp-Source: ABdhPJybwbYlbGqZ39vZfGKYE8VUijl5CEaJter7ow+YZ4ImS7B2GnWOIC3hw5RtZwa3hdjUbGQ46A==
X-Received: by 2002:a05:6638:3899:: with SMTP id b25mr6446683jav.39.1639026731272;
        Wed, 08 Dec 2021 21:12:11 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:11 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 04/19] t4202: clarify intent by creating expected content less cleverly
Date:   Thu,  9 Dec 2021 00:11:00 -0500
Message-Id: <20211209051115.52629-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several tests assign the output of `$(...)` command substitution to an
"expect" variable, taking advantage of the fact that `$(...)` folds out
the final line terminator while leaving internal line terminators
intact. They do this because the "actual" string with which "expect"
will be compared is shaped the same way. However, this intent (having
internal line terminators, but no final line terminator) is not
necessarily obvious at first glance and may confuse casual readers. The
intent can be made more obvious by using `printf` instead, with which
line termination is stated clearly:

    printf "sixth\nthird"

In fact, many other tests in this script already use `printf` for
precisely this purpose, thus it is an established pattern. Therefore,
convert these tests to employ `printf`, as well.

While at it, modernize the tests to use test_cmp() to compare the
expected and actual output rather than using the semi-deprecated
`verbose test "$x" = "$y"`.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4202-log.sh | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 7884e3d46b..c2cfbc69f7 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -120,48 +120,48 @@ test_expect_success 'diff-filter=A' '
 
 test_expect_success 'diff-filter=M' '
 
-	actual=$(git log --pretty="format:%s" --diff-filter=M HEAD) &&
-	expect=$(echo second) &&
-	verbose test "$actual" = "$expect"
+	git log --pretty="format:%s" --diff-filter=M HEAD >actual &&
+	printf "second" >expect &&
+	test_cmp expect actual
 
 '
 
 test_expect_success 'diff-filter=D' '
 
-	actual=$(git log --no-renames --pretty="format:%s" --diff-filter=D HEAD) &&
-	expect=$(echo sixth ; echo third) &&
-	verbose test "$actual" = "$expect"
+	git log --no-renames --pretty="format:%s" --diff-filter=D HEAD >actual &&
+	printf "sixth\nthird" >expect &&
+	test_cmp expect actual
 
 '
 
 test_expect_success 'diff-filter=R' '
 
-	actual=$(git log -M --pretty="format:%s" --diff-filter=R HEAD) &&
-	expect=$(echo third) &&
-	verbose test "$actual" = "$expect"
+	git log -M --pretty="format:%s" --diff-filter=R HEAD >actual &&
+	printf "third" >expect &&
+	test_cmp expect actual
 
 '
 
 test_expect_success 'diff-filter=C' '
 
-	actual=$(git log -C -C --pretty="format:%s" --diff-filter=C HEAD) &&
-	expect=$(echo fourth) &&
-	verbose test "$actual" = "$expect"
+	git log -C -C --pretty="format:%s" --diff-filter=C HEAD >actual &&
+	printf "fourth" >expect &&
+	test_cmp expect actual
 
 '
 
 test_expect_success 'git log --follow' '
 
-	actual=$(git log --follow --pretty="format:%s" ichi) &&
-	expect=$(echo third ; echo second ; echo initial) &&
-	verbose test "$actual" = "$expect"
+	git log --follow --pretty="format:%s" ichi >actual &&
+	printf "third\nsecond\ninitial" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git config log.follow works like --follow' '
 	test_config log.follow true &&
-	actual=$(git log --pretty="format:%s" ichi) &&
-	expect=$(echo third ; echo second ; echo initial) &&
-	verbose test "$actual" = "$expect"
+	git log --pretty="format:%s" ichi >actual &&
+	printf "third\nsecond\ninitial" >expect &&
+	test_cmp expect actual
 '
 
 test_expect_success 'git config log.follow does not die with multiple paths' '
@@ -176,9 +176,9 @@ test_expect_success 'git config log.follow does not die with no paths' '
 
 test_expect_success 'git config log.follow is overridden by --no-follow' '
 	test_config log.follow true &&
-	actual=$(git log --no-follow --pretty="format:%s" ichi) &&
-	expect="third" &&
-	verbose test "$actual" = "$expect"
+	git log --no-follow --pretty="format:%s" ichi >actual &&
+	printf "third" >expect &&
+	test_cmp expect actual
 '
 
 # Note that these commits are intentionally listed out of order.
-- 
2.34.1.307.g9b7440fafd

