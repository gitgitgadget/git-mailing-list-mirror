Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D1F208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 18:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732948AbeHFUps (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 16:45:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47044 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeHFUps (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 16:45:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so7250815pfn.13
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSA23xICPtRMHs3tEY5oQv2uPCdSoZgKntR+y57Ew4E=;
        b=rUS4slVmmaamIls3PQ+eUJZaxxxcUCnfSfKerabYufOSjpwXWTz3jxQAuHkF9epEak
         KEZvJEwUGrvsPBx5xJaDkAcecVKa3m2H9CUluG6sLvl6W7ZaVINdrSQqBmfuN0sR+gXz
         Xr6+SFxi2ynotSvo3bs0GLZ6ZpJG7B4W81YkiNDnE32o4JqmTL8vcWGUT1Xa7qof0DgO
         jH5th+6GSVEgMpDlvftoufP+zvE4eCzyMQzajk2QIFKzm8S5wSwGsT/wRzpYhLJ4o+RG
         Rxf7EY3SESzjN24rYzj3t4+VM42yORKRSq8hMO1Pn6IaFVDThkz3/zMfhUMSdPI22Drm
         WzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSA23xICPtRMHs3tEY5oQv2uPCdSoZgKntR+y57Ew4E=;
        b=oi6PrFyPGvFIL1k2bcsZAAE+HOZfOEg+LMmNmbl28nRy1rjcieP599aRqtm/WVrlMU
         1/8ZLZT9dFEHQsbsrQkh73mc8fO4JVhUCLCTgCtWasnuNqBndD6h99hzu7guzqTqNPF8
         AO52konorcn7gTjolbm9Hn83Ivj5nqdAKqr27CPEOWhb0Isaz4GuUPNqGjZdgw2VSvNT
         Y3WOQ25K0qaix9ow6jac+AnipQLdGVdp+uciFhwGcWuiTDCkfIBRKePaEENBYryNRsjW
         yjrjUqpyZVmdOiu+WuB0mwmRAZjybCxHNsyAGrjakmGWxVz1vjUDJLpcUpPOjoLXSxnJ
         nBVA==
X-Gm-Message-State: AOUpUlEeu4Qo3eQyBOAkxTnqcXTCieBbqZ3XaVqEaGAW+mmMngwyrnVT
        ppXAFuV/9jjIlO0ghXCbiEIXvEgS
X-Google-Smtp-Source: AAOMgpcGooMm94+ph+HToJusmUUlNF65v9eKgd09n3RnU+PiIzcn2rqSxdIl8X8ywjsZs7IOGQ32ZA==
X-Received: by 2002:a62:e00a:: with SMTP id f10-v6mr18526094pfh.208.1533580526889;
        Mon, 06 Aug 2018 11:35:26 -0700 (PDT)
Received: from localhost.localdomain (c-76-102-118-240.hsd1.ca.comcast.net. [76.102.118.240])
        by smtp.gmail.com with ESMTPSA id h18-v6sm15940333pfa.173.2018.08.06.11.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Aug 2018 11:35:26 -0700 (PDT)
From:   William Chargin <wchargin@gmail.com>
To:     git@vger.kernel.org
Cc:     William Chargin <wchargin@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] t: factor out FUNNYNAMES as shared lazy prereq
Date:   Mon,  6 Aug 2018 11:35:08 -0700
Message-Id: <20180806183508.15711-1-wchargin@gmail.com>
X-Mailer: git-send-email 2.18.0.548.g101af7bd4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A fair number of tests need to check that the filesystem supports file
names including "funny" characters, like newline, tab, and double-quote.
Jonathan Nieder suggested that this be extracted into a lazy prereq in
the top-level `test-lib.sh`. This patch effects that change.

The FUNNYNAMES prereq now uniformly requires support for newlines, tabs,
and double-quotes in filenames. This very slightly decreases the power
of some tests, which might have run previously on a system that supports
(e.g.) newlines and tabs but not double-quotes, but now will not. This
seems to me like an acceptable tradeoff for consistency.

One test (`t/t9902-completion.sh`) defined FUNNYNAMES to further require
the separators \034 through \037, the test for which was implemented
using the Bash-specific $'\034' syntax. I've elected to leave this one
as is, renaming it to FUNNIERNAMES.

After this patch, `git grep 'test_\(set\|lazy\)_prereq.*FUNNYNAMES'` has
only one result.

Signed-off-by: William Chargin <wchargin@gmail.com>
---
Note: I've tested this only on an Ubuntu-like system, where FUNNYNAMES
and FUNNIERNAMES are both naturally satisfied. I've verified that the
tests correctly skip when the prereqs are stubbed out to fail by
prepending `false &&`, but I haven't verified that the actual logic for
testing the prereq has the correct behavior on non-FUNNYNAMES systems.

 t/t3600-rm.sh                    |  8 +++-----
 t/t4135-apply-weird-filenames.sh | 10 +---------
 t/t9902-completion.sh            |  6 +++---
 t/t9903-bash-prompt.sh           | 13 +++++--------
 t/test-lib.sh                    | 14 ++++++++++++++
 5 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b8fbdefcd..5829dfd12 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -14,15 +14,13 @@ test_expect_success \
      git add -- foo bar baz 'space embedded' -q &&
      git commit -m 'add normal files'"
 
-if test_have_prereq !MINGW && touch -- 'tab	embedded' 'newline
-embedded' 2>/dev/null
-then
-	test_set_prereq FUNNYNAMES
-else
+if test_have_prereq !FUNNYNAMES; then
 	say 'Your filesystem does not allow tabs in filenames.'
 fi
 
 test_expect_success FUNNYNAMES 'add files with funny names' "
+     touch -- 'tab	embedded' 'newline
+embedded' &&
      git add -- 'tab	embedded' 'newline
 embedded' &&
      git commit -m 'add files with tabs and newlines'
diff --git a/t/t4135-apply-weird-filenames.sh b/t/t4135-apply-weird-filenames.sh
index c7c688fcc..6bc3fb97a 100755
--- a/t/t4135-apply-weird-filenames.sh
+++ b/t/t4135-apply-weird-filenames.sh
@@ -15,15 +15,7 @@ test_expect_success 'setup' '
 		git checkout -f preimage^0 &&
 		git read-tree -u --reset HEAD &&
 		git update-index --refresh
-	} &&
-
-	test_when_finished "rm -f \"tab	embedded.txt\"" &&
-	test_when_finished "rm -f '\''\"quoteembedded\".txt'\''" &&
-	if test_have_prereq !MINGW &&
-		touch -- "tab	embedded.txt" '\''"quoteembedded".txt'\''
-	then
-		test_set_prereq FUNNYNAMES
-	fi
+	}
 '
 
 try_filename() {
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5ff43b9cb..175f83d70 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1278,7 +1278,7 @@ test_expect_success 'setup for path completion tests' '
 	   touch BS\\dir/DQ\"file \
 		 '$'separators\034in\035dir/sep\036in\037file''
 	then
-		test_set_prereq FUNNYNAMES
+		test_set_prereq FUNNIERNAMES
 	else
 		rm -rf BS\\dir '$'separators\034in\035dir''
 	fi
@@ -1320,7 +1320,7 @@ test_expect_success '__git_complete_index_file - UTF-8 in ls-files output' '
 	test_path_completion árvíztűrő/С "árvíztűrő/Сайн яваарай"
 '
 
-test_expect_success FUNNYNAMES \
+test_expect_success FUNNIERNAMES \
     '__git_complete_index_file - C-style escapes in ls-files output' '
 	test_path_completion BS \
 			     BS\\dir &&
@@ -1332,7 +1332,7 @@ test_expect_success FUNNYNAMES \
 			     BS\\dir/DQ\"file
 '
 
-test_expect_success FUNNYNAMES \
+test_expect_success FUNNIERNAMES \
     '__git_complete_index_file - \nnn-escaped characters in ls-files output' '
 	test_path_completion sep '$'separators\034in\035dir'' &&
 	test_path_completion '$'separators\034i'' \
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 04440685a..ab890d3d4 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -63,18 +63,15 @@ test_expect_success 'prompt - unborn branch' '
 	test_cmp expected "$actual"
 '
 
-repo_with_newline='repo
-with
-newline'
-
-if test_have_prereq !MINGW && mkdir "$repo_with_newline" 2>/dev/null
-then
-	test_set_prereq FUNNYNAMES
-else
+if test_have_prereq !FUNNYNAMES; then
 	say 'Your filesystem does not allow newlines in filenames.'
 fi
 
 test_expect_success FUNNYNAMES 'prompt - with newline in path' '
+    repo_with_newline="repo
+with
+newline" &&
+	mkdir "$repo_with_newline" &&
 	printf " (master)" >expected &&
 	git init "$repo_with_newline" &&
 	test_when_finished "rm -rf \"$repo_with_newline\"" &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 78f709774..8bb0f4348 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1104,6 +1104,20 @@ test_lazy_prereq CASE_INSENSITIVE_FS '
 	test "$(cat CamelCase)" != good
 '
 
+test_lazy_prereq FUNNYNAMES '
+	test_have_prereq !MINGW &&
+	touch -- \
+		"FUNNYNAMES tab	embedded" \
+		"FUNNYNAMES \"quote embedded\"" \
+		"FUNNYNAMES newline
+embedded" 2>/dev/null &&
+	rm -- \
+		"FUNNYNAMES tab	embedded" \
+		"FUNNYNAMES \"quote embedded\"" \
+		"FUNNYNAMES newline
+embedded" 2>/dev/null
+'
+
 test_lazy_prereq UTF8_NFD_TO_NFC '
 	# check whether FS converts nfd unicode to nfc
 	auml=$(printf "\303\244")
-- 
2.18.0.548.g101af7bd4

