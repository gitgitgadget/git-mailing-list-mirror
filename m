Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E286F1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 13:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeHCPeb (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 11:34:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45744 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbeHCPeb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 11:34:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id j143-v6so4062716lfj.12
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 06:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1ZKUwMP+Q1ED1xOQpUS4x7mRcWpB6cdUpAcJ4/zeTRQ=;
        b=m8yCRY6enkeBNvsvUivLaxX74IrPg+IH6HjvjfL3SI3+d2ulxauVBTy4CY4ALFXMMS
         dtU+EkDKwXkr7kQUhdoeYYLdzcquSvx+GPsmejj8s6AljBua0/A18e6uUZdQufE53WvO
         d5GVmUTqfFKNv8Bo1Tl6LEj3D9MwI7pzO6dQrF0whrQVyfLkiYQfZj/S7rMBJMmpij/p
         3dDEH4a7rgAYrbpEdmhYIGIg8FU/GCI7dP9MYiP6PfgcFPSXzWyrhnpuX9dnKEPs2u3Z
         K9jUEI7RFrnNgRECy4BGNmO98BcBy2GcgtPyHBzP+UAqDdiJC71wjQ1vpUsLHbAIrvbi
         Wd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1ZKUwMP+Q1ED1xOQpUS4x7mRcWpB6cdUpAcJ4/zeTRQ=;
        b=BYNaJx/jeozxwt9LguVSLRhf39uPcfrcrsp4MOE0n6aOG4zqyOllVwPH8jyqMNh/hX
         TfXCF8w9h3DpW1xFFruZbNov+3/xTPwed5ZPypz+0M9/8cq5NKPtQIETQ8aJk0jumbwP
         nZK1BbGKyKxDzx+1eAPsI24V+uARZajM8esOq3Ac7NaHV9B68s5lN1BKCPhnJvYhXXbA
         mR2j0e+A1cBUb/JX8W5zK77Baalv5XCBIJ3lg/AeHw5R8SASXqLmKEAAodavQ4IRNeyY
         JR37vZRjz4i2CFzWj0chkWV9taxMiAr3C3HI6vC8YVS60CdoRsFxmylutuVB0Y+iujrD
         xHZA==
X-Gm-Message-State: AOUpUlERHoezmF1FzoIKRq/u7zATEyfPuIJ6c1/eSrclIs0J9GXxRxzo
        mBQQQKYlc8YcHijQ/9JUKtM=
X-Google-Smtp-Source: AAOMgpfPd8v/1AreohETuKo32p3P+8z2/B2N9UoIyAYabmqNg/b6j9ziX/kuKm/o5O+beELYa8mwaQ==
X-Received: by 2002:a19:fc3:: with SMTP id 64-v6mr4875271lfp.46.1533303485291;
        Fri, 03 Aug 2018 06:38:05 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id u19-v6sm911889lje.51.2018.08.03.06.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 06:38:04 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: [RFC] broken test for git am --scissors
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Paul Tan <pyokagan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <f91c7393-4f1b-1cf5-b870-f42e9bd18d64@gmail.com>
Date:   Fri, 3 Aug 2018 15:38:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was tweaking is_scissors_line function in mailinfo.c and tried writing
some tests for it.  And discovered that existing test for git am option
--scissors is broken.  I then confirmed that by intentionally breaking
is_scissors_line, like this:

--- 8< ---
Subject: [PATCH 1/2] mailinfo.c: intentionally break is_scissors_line

It seems that tests for "git am" don't actually test the --scissor
option logic.  Break is_scissors_line function by using bogus symbols to
be able to check the tests.

Note that test suite does not pass with this patch applied.  The
expected failure does not happen.
---
 mailinfo.c    | 4 ++--
 t/t4150-am.sh | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 3281a37d5..7938d85e3 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -682,8 +682,8 @@ static int is_scissors_line(const char *line)
 			perforation++;
 			continue;
 		}
-		if ((!memcmp(c, ">8", 2) || !memcmp(c, "8<", 2) ||
-		     !memcmp(c, ">%", 2) || !memcmp(c, "%<", 2))) {
+		if ((!memcmp(c, ">o", 2) || !memcmp(c, "o<", 2) ||
+		     !memcmp(c, ">/", 2) || !memcmp(c, "/<", 2))) {
 			in_perforation = 1;
 			perforation += 2;
 			scissors += 2;
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 1ebc587f8..59bcb5afd 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -412,7 +412,8 @@ test_expect_success 'am with failing post-applypatch hook' '
 	test_cmp head.expected head.actual
 '
 
-test_expect_success 'am --scissors cuts the message at the scissors line' '
+# Test should fail, but succeeds
+test_expect_failure 'am --scissors cuts the message at the scissors line' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout second &&

--- >8 ---

Here's a proof-of-concept patch for the test, to make it actually fail
when is_scissors_line is broken.  It is the easiest way to do so, that I
could come up with, it is not ready to be applied.  I think the two
tests for --scissors should be rewritten pretty much from scratch, with
more obvious naming of files used.

(I made the changes to files in both tests the same just to be able to
re-use file "no-scissors-patch.eml", it's not relevant to the scissor
line in the commit messages.)

--- 8< ---
Subject: [PATCH 2/2] t4150-am.sh: fix test for --scissors

Test for option --scissors should check that the eml file with a scissor
line inside will be cut up and only the part under the cut will be
turned into commit.

However, the test for --scissors generates eml file without such line.
Fix the test for --scissors option.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t4150-am.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 59bcb5afd..5ad71fe05 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -69,17 +69,22 @@ test_expect_success 'setup: messages' '
 
 	EOF
 
+	cat >new-scissors-msg <<-\EOF &&
+	Subject: Test git-am with scissors line
+
+	This line should be included in the commit message.
+	EOF
+
 	cat >scissors-msg <<-\EOF &&
 	Test git-am with scissors line
 
 	This line should be included in the commit message.
 	EOF
 
-	cat - scissors-msg >no-scissors-msg <<-\EOF &&
+	cat - new-scissors-msg >no-scissors-msg <<-\EOF &&
 	This line should not be included in the commit message with --scissors enabled.
 
 	 - - >8 - - remove everything above this line - - >8 - -
-
 	EOF
 
 	signoff="Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
@@ -148,15 +153,15 @@ test_expect_success setup '
 	} >patch1-hg.eml &&
 
 
-	echo scissors-file >scissors-file &&
-	git add scissors-file &&
+	echo file >file &&
+	git add file &&
 	git commit -F scissors-msg &&
 	git tag scissors &&
 	git format-patch --stdout scissors^ >scissors-patch.eml &&
 	git reset --hard HEAD^ &&
 
-	echo no-scissors-file >no-scissors-file &&
-	git add no-scissors-file &&
+	echo file >file &&
+	git add file &&
 	git commit -F no-scissors-msg &&
 	git tag no-scissors &&
 	git format-patch --stdout no-scissors^ >no-scissors-patch.eml &&
@@ -417,7 +422,7 @@ test_expect_failure 'am --scissors cuts the message at the scissors line' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout second &&
-	git am --scissors scissors-patch.eml &&
+	git am --scissors no-scissors-patch.eml &&
 	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code scissors &&
 	test_cmp_rev scissors HEAD
--

--- >8 ---

Relevant old threads:

1. https://public-inbox.org/git/1435861000-25278-11-git-send-email-pyokagan@gmail.com
2. https://public-inbox.org/git/1436278114-28057-11-git-send-email-pyokagan@gmail.com
