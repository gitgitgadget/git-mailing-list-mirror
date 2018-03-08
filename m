Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A031F404
	for <e@80x24.org>; Thu,  8 Mar 2018 12:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755009AbeCHMiy (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 07:38:54 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33104 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751652AbeCHMix (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 07:38:53 -0500
Received: by mail-wr0-f177.google.com with SMTP id v18so5533658wrv.0
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 04:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04VxVOs5s9z1A4wRubUYMs35jM5l4AhHvqdzoeG1QqQ=;
        b=c3vXr0ar9vJyiYkKBnrQZcrEz6AN6t7y3pcyDYIuqhRW3ZgXXTDRz9jAzfjAdK8aMn
         lGHqmhYzmXsSsyqMav9eYK5I+R+8YU8Dcq2mL8l8+BCTuYdUEYQrTGZGZuw6Pewu1S0b
         7qDZ+pgz+UmeE7Ar9rnMjKPmmSQI5USh9miG4PXH6MQ7bGAc0Sit0cjna4xbi2f1nb7x
         dLbt5wEhlfuA6on3AE+L93/Sx9nEWVDwOBuCYXASW7NZMv+2Od9CXYiOnvtpCWecCpFU
         +vgGP97daKZi9ME8RuY0tk3mJPSn1BtxOFpqSfcxXCozvy3QzLIDDDNeRTIqqezmI1Su
         8TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04VxVOs5s9z1A4wRubUYMs35jM5l4AhHvqdzoeG1QqQ=;
        b=aHDVU3E+U4/EivB2jSe9v1ORAj2ZuSAZH3zgnG0as7JxTKYj8/gD/t8kbC6EQlwccH
         ndpcdOmplCjw/XKWoDqrXoG6HCtjVpelTdctJpNeGPTltw4dS+QpnRM1ZwGspNKPP/Ji
         ditr6y6qSX5tnoIxOsZt/+jjUbG0EPSzzn2l2d2pVZ3CtsD9MPjvYBwx+IFAxltMx72c
         I4XGvB4SBojlsFomjXY6i2qi8ZwyRNwKi/PMkGWi6ZF/e5vQoWn7DqXiilOrJmKKJdfH
         qfu3GjKLiIBw1WbL8Qvyet0PUT8OX0P+bvhSeKMndv3z7N+6koK7tisyMAA+vlzkj/bb
         3Fdw==
X-Gm-Message-State: APf1xPBHF4UCXu+bZku7+OSEkWOavqHvrmKgzXUAJFSJUyUEroSqY3kF
        a2L54ccuGzPuDKZJxDa5qs0=
X-Google-Smtp-Source: AG47ELtMOOScd1h4l+2DgHGU6Tb0a3W/vvieGxCuguyi0yTCZr/b/D+qmAcNmEeo4VX3spOGaJYyPA==
X-Received: by 10.223.161.194 with SMTP id v2mr21584993wrv.48.1520512731792;
        Thu, 08 Mar 2018 04:38:51 -0800 (PST)
Received: from localhost.localdomain (x4db106d7.dyn.telefonica.de. [77.177.6.215])
        by smtp.gmail.com with ESMTPSA id l11sm16721809wrg.71.2018.03.08.04.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Mar 2018 04:38:51 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] t9400-git-cvsserver-server: don't rely on the output of 'test_cmp'
Date:   Thu,  8 Mar 2018 13:38:43 +0100
Message-Id: <20180308123844.15163-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.603.g180c1428f0
In-Reply-To: <20180308123844.15163-1-szeder.dev@gmail.com>
References: <20180308123844.15163-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test 'cvs update (-p)' redirects and checks 'test_cmp's stdout and
even its stderr.  The commit introducing this test in 6e8937a084
(cvsserver: Add test for update -p, 2008-03-27) doesn't discuss why,
in fact its log message only consists of that subject line.  Anyway,
weird as it is, it kind of made sense due to the way that test was
structured:

After a bit of preparation, this test updates four files via CVS and
checks their contents using 'test_cmp', but it does so in a for loop
iterating over the names of those four files.  Now, the exit status of
a for loop is the exit status of the last command executed in the
loop, meaning that the test can't simply rely on the exit code of
'test_cmp' in the loop's body.  Instead, the test works it around by
relying on the stdout of 'test_cmp' being silent on success and
showing the diff on failure, as it appends the stdout of all four
'test_cmp' invocations to a single file and checks that file's
emptiness after the loop (with 'test -z "$(cat ...)"', no less; there
was no 'test_must_be_empty' back then).  Furthermore, the test
redirects the stderr of those 'test_cmp' invocations to this file,
too: while 'test_cmp' itself doesn't output anything to stderr, the
invoked 'diff' or 'cmp' commands do send their error messages there,
e.g. if they can't open a file because its name was misspelled.

This also makes this test fail when the test script is run with '-x'
tracing (and using a shell other than a Bash version supporting
BASH_XTRACEFD), because 'test_cmp's stderr contains the trace of the
'diff' command executed inside the helper function, throwing off the
subsequent emptiness check.

Unroll that for loop, so we can check the files' contents the usual
way and rely on 'test_cmp's exit code failing the && chain.  Extract
updating a file via CVS and verifying its contents using 'test_cmp'
into a helper function requiring the file's name as parameter to avoid
much of the repetition resulting from unrolling the loop.

After this change t9400 passes with '-x', even when running with
/bin/sh.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9400-git-cvsserver-server.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index c30660d606..1f67d2822f 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -437,6 +437,11 @@ test_expect_success 'cvs update (merge no-op)' \
     GIT_CONFIG="$git_config" cvs -Q update &&
     test_cmp merge ../merge'
 
+check_cvs_update_p () {
+    GIT_CONFIG="$git_config" cvs update -p "$1" >"$1".out &&
+    test_cmp "$1".out ../"$1"
+}
+
 cd "$WORKDIR"
 test_expect_success 'cvs update (-p)' '
     touch really-empty &&
@@ -447,12 +452,10 @@ test_expect_success 'cvs update (-p)' '
     git push gitcvs.git >/dev/null &&
     cd cvswork &&
     GIT_CONFIG="$git_config" cvs update &&
-    rm -f failures &&
-    for i in merge no-lf empty really-empty; do
-        GIT_CONFIG="$git_config" cvs update -p "$i" >$i.out
-	test_cmp $i.out ../$i >>failures 2>&1
-    done &&
-    test -z "$(cat failures)"
+    check_cvs_update_p merge &&
+    check_cvs_update_p no-lf &&
+    check_cvs_update_p empty &&
+    check_cvs_update_p really-empty
 '
 
 cd "$WORKDIR"
-- 
2.16.2.603.g180c1428f0

