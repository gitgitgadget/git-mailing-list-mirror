Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76001F597
	for <e@80x24.org>; Fri,  3 Aug 2018 22:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbeHDAiB (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 20:38:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41780 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731689AbeHDAiB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 20:38:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so6118767ljy.8
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 15:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yZByIzAQJH7NdAI80GIgKNK6bj6WCSsp6puofvKYwY4=;
        b=uVkyM8TNcKE/ehpY5Z14ZL+tf8EQthFqWF/xOaQqW8VuBJjS0XcF3/SwnCfhISMUHd
         QAaMZDaYUf3c9wdUyc3/XzmUes0HPqUM8jAy4S4zv/obsruDqJ9v/vwKePwP+KD473UA
         XemEnyoaKkH2NawU5FQbXyjJpKysSe0GuWJYNfXr/TlHzsJHZFU9TeAENBZT2bqQyaSc
         oNZSH0fm2kj8YPW3sgJ69+WkEvQ6+vf9Sbdfti+t5ew80UgpRlUz7iLYUBl0JtPDR81f
         CwxQJBj8QD2jVq8vO9VBG9mesnGl7frzpwoJoW/FkxkEfxd6TMvyFZ39oiHtPLzXNQKj
         Muog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yZByIzAQJH7NdAI80GIgKNK6bj6WCSsp6puofvKYwY4=;
        b=q//311/JO4LZv3bgmp8s6ELtkG+LQTPvukv9cRb7FQ7RhcaoHQSzuVHKjij7bKVtzP
         DNbEIESuHnTQS+4fJs/z7EX52dCRzs+L+seyV72jfRbh4DiqgHdriHB06tP6IbjjWz5h
         MUaBLvZxVG9BedFl6UB3s1Gk3xWw/7BS+72c6mdNcldOq/Wz9NA64F1271cELlj5cFa2
         HCG7poFE9Nh7eyF6117DFSUFhCsxMWOdf1UJHCxc34jdyzFdhQ5ML60Kz32+0A1iSO9M
         Co8WvioSi8tm4PMEDJFj5/69FBJkdhZRJ6nNRJYzb7+b4E/frb/ye+/RpTXsB7Pc/6vn
         MH8w==
X-Gm-Message-State: AOUpUlHVZNbTigi0DKZza67oKz90hj8qz23zAkW0Tf7YLvxtQxSFymBB
        +cPpkh59AtIHbGoktKgnFSY=
X-Google-Smtp-Source: AAOMgpfPkawChkqrojSL6V12/HagoNyMZKMd6ict5sV5ofHTQuevQyIpa61yhBHy/lg03sw+ZuRLlg==
X-Received: by 2002:a2e:9883:: with SMTP id b3-v6mr3544299ljj.80.1533335983527;
        Fri, 03 Aug 2018 15:39:43 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id k68-v6sm908413lfg.22.2018.08.03.15.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 15:39:42 -0700 (PDT)
Subject: [PATCH] t4150: fix broken test for am --scissors
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Paul Tan <pyokagan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <f91c7393-4f1b-1cf5-b870-f42e9bd18d64@gmail.com>
Message-ID: <8f69d82b-0f35-754f-0096-853d6b463db7@gmail.com>
Date:   Sat, 4 Aug 2018 00:39:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f91c7393-4f1b-1cf5-b870-f42e9bd18d64@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests for "git am --[no-]scissors" [1] work in the following way:

 1. Create files with commit messages
 2. Use these files to create expected commits
 3. Generate eml file with patch from expected commits
 4. Create commits using git am with these eml files
 5. Compare these commits with expected

The test for "git am --scissors" is supposed to take a message with a
scissors line above commit message and demonstrate that only the text
below the scissors line is included in the commit created by invocation
of "git am --scissors".  However, the setup of the test uses commits
without the scissors line in the commit message, therefore creating an
eml file without scissors line.

This can be checked by intentionally breaking is_scissors_line function
in mailinfo.c. Test t4150-am.sh should fail, but does not.

Fix broken test by generating only one eml file--with scissors line, and
by using it both for --scissors and --no-scissors. To clarify the
intention of the test, give files and tags more explicit names.

[1]: introduced in bf72ac17d (t4150: tests for am --[no-]scissors,
     2015-07-19)

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

Applies on top of 980a3d3dd (Merge branch 'pt/am-tests', 2015-08-03).
This patch is also available at

  https://github.com/rybak/git fix-am-scissors-test


 t/t4150-am.sh | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index e9b6f8158..23e3b0e91 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -67,17 +67,18 @@ test_expect_success 'setup: messages' '
 
 	EOF
 
-	cat >scissors-msg <<-\EOF &&
-	Test git-am with scissors line
+	cat >msg-without-scissors-line <<-\EOF &&
+	Test that git-am --scissors cuts at the scissors line
 
 	This line should be included in the commit message.
 	EOF
 
-	cat - scissors-msg >no-scissors-msg <<-\EOF &&
+	printf "Subject: " >subject-prefix &&
+
+	cat - subject-prefix msg-without-scissors-line >msg-with-scissors-line <<-\EOF &&
 	This line should not be included in the commit message with --scissors enabled.
 
 	 - - >8 - - remove everything above this line - - >8 - -
-
 	EOF
 
 	signoff="Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
@@ -150,18 +151,17 @@ test_expect_success setup '
 	} >patch1-hg.eml &&
 
 
-	echo scissors-file >scissors-file &&
-	git add scissors-file &&
-	git commit -F scissors-msg &&
-	git tag scissors &&
-	git format-patch --stdout scissors^ >scissors-patch.eml &&
+	echo file >file &&
+	git add file &&
+	git commit -F msg-without-scissors-line &&
+	git tag scissors-used &&
 	git reset --hard HEAD^ &&
 
-	echo no-scissors-file >no-scissors-file &&
-	git add no-scissors-file &&
-	git commit -F no-scissors-msg &&
-	git tag no-scissors &&
-	git format-patch --stdout no-scissors^ >no-scissors-patch.eml &&
+	echo file >file &&
+	git add file &&
+	git commit -F msg-with-scissors-line &&
+	git tag scissors-not-used &&
+	git format-patch --stdout scissors-not-used^ >patch-with-scissors-line.eml &&
 	git reset --hard HEAD^ &&
 
 	sed -n -e "3,\$p" msg >file &&
@@ -418,10 +418,10 @@ test_expect_success 'am --scissors cuts the message at the scissors line' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout second &&
-	git am --scissors scissors-patch.eml &&
+	git am --scissors patch-with-scissors-line.eml &&
 	test_path_is_missing .git/rebase-apply &&
-	git diff --exit-code scissors &&
-	test_cmp_rev scissors HEAD
+	git diff --exit-code scissors-used &&
+	test_cmp_rev scissors-used HEAD
 '
 
 test_expect_success 'am --no-scissors overrides mailinfo.scissors' '
@@ -429,10 +429,10 @@ test_expect_success 'am --no-scissors overrides mailinfo.scissors' '
 	git reset --hard &&
 	git checkout second &&
 	test_config mailinfo.scissors true &&
-	git am --no-scissors no-scissors-patch.eml &&
+	git am --no-scissors patch-with-scissors-line.eml &&
 	test_path_is_missing .git/rebase-apply &&
-	git diff --exit-code no-scissors &&
-	test_cmp_rev no-scissors HEAD
+	git diff --exit-code scissors-not-used &&
+	test_cmp_rev scissors-not-used HEAD
 '
 
 test_expect_success 'setup: new author and committer' '
-- 
2.18.0


