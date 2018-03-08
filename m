Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981C61F404
	for <e@80x24.org>; Thu,  8 Mar 2018 22:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbeCHWpJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 17:45:09 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:53077 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeCHWpI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 17:45:08 -0500
Received: by mail-wm0-f47.google.com with SMTP id t3so725391wmc.2
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 14:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I7/4aS0s7hnA5ZmUlpOuMQy0PFVGoZf1lWFcGXwrERI=;
        b=qC3bqltpC6CfrS9VmeVwW6ilIHqvq1MLPduYbRVvL+MhIwotARN9Qk//g0BiR6sD+S
         fRTexIYMMy6JZwAai4/cuzNganW1r+E7YeuljE8h0QgECoeJzimznneuXOhTgdNB4p9X
         7RxCbdoWIF4tUB9bG3mXaOoKw5ljl4Z/PrvWeZoQoP+RONsIpRF8jrwWdqUbQaUbPZqb
         k4rE4ZX/oHXAgIWzji02nMw5RN5WxlAV6UaaD/FaNgrqGqo097P7kYaODhlyMQ4s2hkD
         hVcB2CXVrWE64rVQJarvZsM6ziQ9T47gCkfMMqk/MDBdc7v9529go//MM78l53V1QZTR
         pnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I7/4aS0s7hnA5ZmUlpOuMQy0PFVGoZf1lWFcGXwrERI=;
        b=MO89BDU89DkmcKSKMwvuGViQWX+xyfaVtSg51jpwh09PukeNK2icARepU9LZhvF3Ns
         Zm0bSEGkAoa5b3TQUV22zDniJX/xt8GU3CVPwcxxpQBR8ELW5VJOce9peQCTacl2ACzG
         xGJ1WQvHuwbDIFJ0cvAKvQAL6fnQP3JzBcqiqYb7SeuUqJHcYipffnmayWYCGHIkefiC
         MRJ6nmmDL3wZSpcuZOmDVVZQs2GILVwUpXMc3mBPbqk+YUQ4YNVyMskpODi5YfUFvmgg
         C6InmxqPYaP0SHeoK0tV9/wP98qUhj1mo/4SmtG3rJfpW+3bzPeQg//h3hksFBihtoWX
         T9zQ==
X-Gm-Message-State: AElRT7GGZCXQMfGhOPL546Zd1GWwPYdYjNUemLKTpjg96gJC98F3TYBy
        8Qs7M2o2OcvLGyu4WfsPprQ=
X-Google-Smtp-Source: AG47ELv4SRqsG8zh54gLjGEV05hxg5JjrGVRdQCc70DAU7zM/Tvn2PqbrjixBbmsNxqNluweNAYmMg==
X-Received: by 10.28.160.9 with SMTP id j9mr286264wme.103.1520549107317;
        Thu, 08 Mar 2018 14:45:07 -0800 (PST)
Received: from localhost.localdomain (x4db106d7.dyn.telefonica.de. [77.177.6.215])
        by smtp.gmail.com with ESMTPSA id n49sm23897941wrn.90.2018.03.08.14.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Mar 2018 14:45:06 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v1.1 1/2] t9400-git-cvsserver-server: don't rely on the output of 'test_cmp'
Date:   Thu,  8 Mar 2018 23:44:58 +0100
Message-Id: <20180308224458.5730-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.603.g180c1428f0
In-Reply-To: <CAPig+cRSDbFZ_C9opu3pr=m7HwFkeuoxUD_8Yqbd4XxX-W0cHg@mail.gmail.com>
References: <CAPig+cRSDbFZ_C9opu3pr=m7HwFkeuoxUD_8Yqbd4XxX-W0cHg@mail.gmail.com>
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

Stop relying on 'test_cmp's output and instead run 'test_cmp a b ||
return 1' in the for loop in order to make 'test_cmp's error code fail
the test.  Furthermore, add the missing && after the cvs command to
create a && chain in the loop's body.

After this change t9400 passes with '-x', even when running with
/bin/sh.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Changes:
Use Eric's suggestion and run 'test_cmp a b || return 1' in the for
loop to fail the test.

 t/t9400-git-cvsserver-server.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index c30660d606..5ff3789199 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -449,10 +449,9 @@ test_expect_success 'cvs update (-p)' '
     GIT_CONFIG="$git_config" cvs update &&
     rm -f failures &&
     for i in merge no-lf empty really-empty; do
-        GIT_CONFIG="$git_config" cvs update -p "$i" >$i.out
-	test_cmp $i.out ../$i >>failures 2>&1
-    done &&
-    test -z "$(cat failures)"
+	GIT_CONFIG="$git_config" cvs update -p "$i" >$i.out &&
+	test_cmp $i.out ../$i || return 1
+    done
 '
 
 cd "$WORKDIR"
-- 
2.16.2.603.g180c1428f0

