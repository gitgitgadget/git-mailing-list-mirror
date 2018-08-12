Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD5A11F404
	for <e@80x24.org>; Sun, 12 Aug 2018 04:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbeHLGnw (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 02:43:52 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39692 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeHLGnw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 02:43:52 -0400
Received: by mail-pl0-f66.google.com with SMTP id w14-v6so5580652plp.6
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 21:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/BEFFztf2W83n6Qs+GWa0mUjDJ5rLGjr9aEbuPBNuo=;
        b=Fofx3raw/SFd/1YIxGHvQxkxExWfaNLAXbi8BWJjHzCBw7SRFvAX+7yIj4/wHARiv/
         vDaeIlt8wkS92hEt/hcL4qK80bkOyyDM5bZp5ycdnOOGYpaqSxSyJOX8rrmzSe9Hci0g
         ZB2CY8xlh/yVBGdyx+S1avCutlFpj2JVCIsxWc47IWxcUzA5Oxg4AOJs6sOMuOkWNPwG
         htCFaLgaHE+pOinMMifV3S+WGHGG5Rxx2tp3n1dkB3Fy5XdxBt5EZmNMKmaguAxKxlv5
         Un5eR0obtqcqfoG/1CnqCI8tXvSPTIcoOy6vXDSbjDSt5o3L+tUrh26BtAMNEUWLkrSt
         0vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/BEFFztf2W83n6Qs+GWa0mUjDJ5rLGjr9aEbuPBNuo=;
        b=ljSzxA3gFSAKG8d4Mo71UbewA0708eD65LJtm7gTdM8jZm3rgEkEnSpZdwe8bqSbjK
         4czbpKFIPtPebGdH5O/j9Cv4tu1/QHOby550DjAQX52AJPFUhGvElnCuAP1OmFzmrOtK
         4tKojoxidXenEnI1A9FB/3teXdQqOMZSHofLo2MnjO2LzTQAbLDe3i6vhwTGUJCh5aco
         Xxe3uAyCtQ8yPfLDYO/PulSV6O3BooDTupjrnQhM32xVzrrZNXxgL0ti5w8uatDfOtdU
         eNUi/oJT9vHmLTeu+A9cmIRgH+Wvv8+fPimcLCSj40vYz9LkFWechYPJCwB+5gCfYmBe
         rHGA==
X-Gm-Message-State: AOUpUlGQopT3hYOk2fis2Z6Nk3A2VBOvJjcMnJsDYJwGg4+qc8xwnl8d
        L7MNyjZCmt8mVmZWV3COpL3GBqgG
X-Google-Smtp-Source: AA+uWPwlQ7BE+sep3QZ9H8pnUL8YC24J2OrDgnpq3XQdAE5GZFkza/VcK7b/QlyY5yqWox5u68qjgw==
X-Received: by 2002:a17:902:bf06:: with SMTP id bi6-v6mr11975748plb.76.1534046841893;
        Sat, 11 Aug 2018 21:07:21 -0700 (PDT)
Received: from wchargin-t440s.attlocal.net (99-4-123-58.lightspeed.sntcca.sbcglobal.net. [99.4.123.58])
        by smtp.gmail.com with ESMTPSA id p19-v6sm23261723pgh.60.2018.08.11.21.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Aug 2018 21:07:21 -0700 (PDT)
From:   William Chargin <wchargin@gmail.com>
To:     git@vger.kernel.org, jrnieder@gmail.com
Cc:     William Chargin <wchargin@gmail.com>, sunshine@sunshineco.com,
        peff@peff.net
Subject: [PATCH v3] test_dir_is_empty: properly detect files with newline in name
Date:   Sat, 11 Aug 2018 21:06:20 -0700
Message-Id: <20180812040620.15298-1-wchargin@gmail.com>
X-Mailer: git-send-email 2.18.0.549.gdbffb67bf
In-Reply-To: <CAPig+cQK7JSosa0hNhgw7xoSui2f0m6yfRLWytsg_Zow3bN5bg@mail.gmail.com>
References: <CAPig+cQK7JSosa0hNhgw7xoSui2f0m6yfRLWytsg_Zow3bN5bg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the `test_dir_is_empty` function appears correct in most normal
use cases, it can fail when filenames contain newlines. This patch
changes the implementation to check that the output of `ls -a` has at
most two lines (for `.` and `..`), which should be better behaved.

The newly added unit test fails before this change and passes after it.

Signed-off-by: William Chargin <wchargin@gmail.com>
---
This patch depends on "t: factor out FUNNYNAMES as shared lazy prereq"
(2018-08-06), available from `wc/make-funnynames-shared-lazy-prereq`.
The code will work on master, but the test will not run due to a missing
prereq.

I originally wrote this patch for the standalone Sharness library, but
that library advises that such patches be sent to the Git mailing list
first.

 t/t0000-basic.sh        | 31 +++++++++++++++++++++++++++++++
 t/test-lib-functions.sh |  2 +-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 34859fe4a..60134d7ab 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -821,6 +821,37 @@ test_expect_success 'tests clean up even on failures' "
 	EOF
 "
 
+test_expect_success FUNNYNAMES \
+	'test_dir_is_empty behaves even in pathological cases' "
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
+		touch \"pathological_dir/.
+	.\" &&
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
index 2b2181dca..f0241992b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -568,7 +568,7 @@ test_path_is_dir () {
 # Check if the directory exists and is empty as expected, barf otherwise.
 test_dir_is_empty () {
 	test_path_is_dir "$1" &&
-	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
+	if test "$(ls -a1 "$1" | wc -l)" -gt 2
 	then
 		echo "Directory '$1' is not empty, it contains:"
 		ls -la "$1"
-- 
2.18.0.548.g101af7bd4

