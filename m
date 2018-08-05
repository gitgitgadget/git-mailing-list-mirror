Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59D72208E9
	for <e@80x24.org>; Sun,  5 Aug 2018 02:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbeHEEXv (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 00:23:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36229 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeHEEXu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 00:23:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so5153826pfo.3
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 19:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMGgmywJrUEpAe8FiktAe+MMCLtel5AJKHiOi0ROhGs=;
        b=XoXz3LTUtQmS1RjaZYHACgOMn5r33dk2/s+hLspW0FKjSnmIDNwNVVc8fLb+WSEw1A
         fP8/MXqcaKnxZL4bpTHcCs3G8LX+y70ONUbmN+d7bxjYT8Nfd2/1fyA5AQ0Pgyzpyuo4
         PzvcVt/Qwkq6tLxrLYS3Wv6DXFLxCEKv1eUosaf8h8ppLPzKQju9kMTFtZuWeG2TtpRA
         AsXYAh4QSNdd9Yu9/vIrfqwG2tXaCjlhhQHX0qdUI3gY/dftvk75X3L5HeTxlEoa2vQT
         QtKVeWGqakP5Dsb8v3Ewf1ZGXUSLZMkPXcfpgLZtx16IpArkWrKG9JyKGB/bWn++wQJN
         TfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMGgmywJrUEpAe8FiktAe+MMCLtel5AJKHiOi0ROhGs=;
        b=PYR2h6ltmf8sCok7F/LiQX+IvUN478pACFNnPEyfkz7cCzBk9LQx/liOMUP1YasYI2
         3v4Im1EhMA4tcaU0F0WDjhle7BiVUGUEtpiWUFhRNmZRpn0tELIYVXzdM8djSif+u1E8
         1ObmEIzD4mGvYZDJFRSQy9cr15Vwy4tXj5PNRkniovMpg7J6DMAcTJ9gRDY1KShXFSL7
         gD4ORMZnNt/JCjFkMW6K18soQOo0vy0nGDvdkRv7zuhwfZRSbyEg0Zf0Y6A2ES+Ca/Fe
         +NFR106CkRWm8sfgjIEsytwdDbiKW3fNnFR+nqsnrtQVGUPMUwNpzxsTkaEUnCHm6TVt
         j0ug==
X-Gm-Message-State: AOUpUlEaMuXEi5fLJgWI+gSOJeEsUghh8TySBGmwkQzzBGO2ewzSBlVJ
        H2jAvqwqaT/6CmaXwRpEImIPshAh
X-Google-Smtp-Source: AAOMgpet5965NMRyNl4MwV9T4+LKjwZZ8Dz+t+7SfZ652fIUEzInJb0X6wm5OomQTLxglFsgDXrgtA==
X-Received: by 2002:a63:f751:: with SMTP id f17-v6mr9684101pgk.410.1533435660925;
        Sat, 04 Aug 2018 19:21:00 -0700 (PDT)
Received: from wchargin-t440s.attlocal.net (99-4-123-58.lightspeed.sntcca.sbcglobal.net. [99.4.123.58])
        by smtp.gmail.com with ESMTPSA id m15-v6sm19238289pfj.171.2018.08.04.19.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Aug 2018 19:21:00 -0700 (PDT)
From:   William Chargin <wchargin@gmail.com>
To:     git@vger.kernel.org
Cc:     William Chargin <wchargin@gmail.com>
Subject: [PATCH 1/1] t/test-lib: make `test_dir_is_empty` more robust
Date:   Sat,  4 Aug 2018 19:20:02 -0700
Message-Id: <20180805022002.28907-2-wchargin@gmail.com>
X-Mailer: git-send-email 2.18.0.548.g79b975644
In-Reply-To: <20180805022002.28907-1-wchargin@gmail.com>
References: <20180805022002.28907-1-wchargin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous behavior could incorrectly pass given a directory with a
filename containing a newline. This patch changes the implementation to
use `ls -A`, which is specified by POSIX. The output should be empty
exactly if the directory is empty.

The newly added unit test fails before this change and passes after it.

Signed-off-by: William Chargin <wchargin@gmail.com>
---
 t/t0000-basic.sh        | 29 +++++++++++++++++++++++++++++
 t/test-lib-functions.sh |  2 +-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 34859fe4a..3885b26f9 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -821,6 +821,35 @@ test_expect_success 'tests clean up even on failures' "
 	EOF
 "
 
+test_expect_success 'test_dir_is_empty behaves even in pathological cases' "
+	run_sub_test_lib_test \
+		dir-empty 'behavior of test_dir_is_empty' <<-\\EOF &&
+	test_expect_success 'should pass with actually empty directory' '
+		mkdir empty_dir &&
+		test_dir_is_empty empty_dir
+	'
+	test_expect_success 'should fail with a normal filename' '
+		mkdir nonempty_dir &&
+		touch nonempty_dir/some_file &&
+		test_must_fail test_dir_is_empty nonempty_dir
+	'
+	test_expect_success 'should fail with dot-newline-dot filename' '
+		mkdir pathological_dir &&
+		printf \"pathological_dir/.\\\\n.\\\\0\" | xargs -0 touch &&
+		test_must_fail test_dir_is_empty pathological_dir
+	'
+	test_done
+	EOF
+	check_sub_test_lib_test dir-empty <<-\\EOF
+	> ok 1 - should pass with actually empty directory
+	> ok 2 - should fail with a normal filename
+	> ok 3 - should fail with dot-newline-dot filename
+	> # passed all 3 test(s)
+	> 1..3
+	EOF
+"
+
+
 ################################################################
 # Basics of the basics
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2b2181dca..f7ff28ef6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -568,7 +568,7 @@ test_path_is_dir () {
 # Check if the directory exists and is empty as expected, barf otherwise.
 test_dir_is_empty () {
 	test_path_is_dir "$1" &&
-	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
+	if test "$(ls -A1 "$1" | wc -c)" != 0
 	then
 		echo "Directory '$1' is not empty, it contains:"
 		ls -la "$1"
-- 
2.18.0.548.g79b975644

