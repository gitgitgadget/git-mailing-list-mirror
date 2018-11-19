Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 616391F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 13:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeKSXwG (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 18:52:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39412 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729214AbeKSXwG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 18:52:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id u13-v6so5253357wmc.4
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 05:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0kCLLvOewLohTe7l/vXkGs6ysOluM9YId60aosSj3M=;
        b=RNhJoN74LzstoPUaGMIufPCHQdzPujaTOcF0wdUA0sRzfGWYUwOOFa9E2HiDb2vY2x
         vLoSWNTAY/mQR5c+jCTenPSD4z6bJgrfK8DJJ6wwgB135QOr/cGU2hlPvXt8IdqC1es0
         mu9Aspqka12J2qzd4jAvkyiUy+/TnBTVVJ6i11LeCligqdWOUXJPkuhJPqySb3KOjpV1
         NAiGXRmNlho7Qvu+TJd3LAgNtfWYBqng8+EzSZy5WV2yNgz3jKPRZxzvU6nTn0AoHOig
         CAB5jQ2FsSZ0wHXOE2+ZS4HL0zEXrxHFi1iC+asIWbjuFZqI7CmTV9r4Cem4pCbpDpyg
         XufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0kCLLvOewLohTe7l/vXkGs6ysOluM9YId60aosSj3M=;
        b=qprqFydRRS5o0j8vfQu7WhiBDjverC8Qd2F6fT+gPv4JpR4Un1UyY+gc9ZFHvaQNnk
         9Lk2sI3sirrKFpnoTrIjmFBZWT4vBxFjaeiYg9TH92b6n3Hkl6NYGD51NKu4dO8vz6SA
         kxtAK3ucrsrxlLZXnowHZYfEX9JjeefvRsDZlNwALLAnS/PMyETgZyHWutN2YOLCsGze
         czTmkFoFnq+OBtxc8EUXOsFstM7M1vqVzP96XpwezCF2P6a6edxbcpluFwYDMCb/xZ7A
         tjcdW/bL295p9+5z8G7jeCgLfzZKISfv/jyZzYKcFzuQnlCeoP3f4yn/l06lYaJPzKzl
         vsIQ==
X-Gm-Message-State: AGRZ1gLSQIqkdy1S7tWqBZWdDOO/U7M442vljy9R4ivnWKwruoEQ34Zf
        vtub/MMpUe1KzmSXB6lqgZo=
X-Google-Smtp-Source: AFSGD/UczmLNidqmq0F+Yx0Sc2kTPvHoAraITfAI6QJLi0ittUnWhRV3Dr3NX35hARJ00bRqvWy+1Q==
X-Received: by 2002:a1c:8a09:: with SMTP id m9mr4138010wmd.27.1542634106551;
        Mon, 19 Nov 2018 05:28:26 -0800 (PST)
Received: from localhost.localdomain (x4db04f16.dyn.telefonica.de. [77.176.79.22])
        by smtp.gmail.com with ESMTPSA id i9sm10489065wrs.34.2018.11.19.05.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 05:28:25 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] test-lib-functions: make 'test_cmp_rev' more informative on failure
Date:   Mon, 19 Nov 2018 14:28:18 +0100
Message-Id: <20181119132818.3116-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.134.gf0022f8e60
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'test_cmp_rev' helper is merely a wrapper around 'test_cmp'
checking the output of two 'git rev-parse' commands, which means that
its output on failure is not particularly informative, as it's
basically two OIDs with a bit of extra clutter of the diff header, but
without any indication of which two revisions have caused the failure:

  --- expect.rev  2018-11-17 14:02:11.569747033 +0000
  +++ actual.rev  2018-11-17 14:02:11.569747033 +0000
  @@ -1 +1 @@
  -d79ce1670bdcb76e6d1da2ae095e890ccb326ae9
  +139b20d8e6c5b496de61f033f642d0e3dbff528d

It also pollutes the test repo with these two intermediate files,
though that doesn't seem to cause any complications in our current
tests (meaning that I couldn't find any tests that have to work around
the presence of these files by explicitly removing or ignoring them).

Enhance 'test_cmp_rev' to provide a more useful output on failure with
less clutter:

  error: two revisions point to different objects:
    'HEAD^': d79ce1670bdcb76e6d1da2ae095e890ccb326ae9
    'extra': 139b20d8e6c5b496de61f033f642d0e3dbff528d

Doing so is more convenient when storing the OIDs outputted by 'git
rev-parse' in a local variable each, which, as a bonus, won't pollute
the repository with intermediate files.

While at it, also ensure that 'test_cmp_rev' is invoked with the right
number of parameters, namely two.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib-functions.sh | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index d158c8d0bf..fc84db67a1 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -854,9 +854,23 @@ test_must_be_empty () {
 
 # Tests that its two parameters refer to the same revision
 test_cmp_rev () {
-	git rev-parse --verify "$1" >expect.rev &&
-	git rev-parse --verify "$2" >actual.rev &&
-	test_cmp expect.rev actual.rev
+	if test $# != 2
+	then
+		error "bug in the test script: test_cmp_rev requires two revisions, but got $#"
+	else
+		local r1 r2
+		r1=$(git rev-parse --verify "$1") &&
+		r2=$(git rev-parse --verify "$2") &&
+		if test "$r1" != "$r2"
+		then
+			cat >&4 <<-EOF
+			error: two revisions point to different objects:
+			  '$1': $r1
+			  '$2': $r2
+			EOF
+			return 1
+		fi
+	fi
 }
 
 # Print a sequence of integers in increasing order, either with
-- 
2.20.0.rc0.134.gf0022f8e60

