Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6833C001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjHJVSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjHJVSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:18:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029732737
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:07 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe8242fc4dso4870175e9.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702285; x=1692307085;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqbymNwl5V4REVHu/vWP1mc5fgKe6eDtx9Vl/hSKJSU=;
        b=lvpVqJXFtLvUTzTLRlhWBUNhCPFDoggEqBUDfKdweLxRiylyJusw0IAZ1HmhTF3ouL
         Cvmg68XacGYsAA4FD9zWCJL95KEg0U6xgHrrrhHB+gwpfpG256fcDIFBP0XrJ9PSXIAD
         M1iGr4AMSpBBQg4n0ubl7L3NXiTDWUMuJUV30T/Ra6opzmt8ahMjFL5ZUE4OXVdXg4JN
         93H0rE6yGpDRsMp6+0NDJ1UAo1SI9lpUt02W8+fs6AkC4teahX3INJNer10Sl2e88tuN
         a+Idqqm4G1n7Jk1zwsWrGrAL1rHhauITYUUbwNP7yBV0wrGfjv4AgxwHHKJZXKzUWjau
         6lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702285; x=1692307085;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqbymNwl5V4REVHu/vWP1mc5fgKe6eDtx9Vl/hSKJSU=;
        b=cyxZJRpSkOwjX25r9hQ2l9Dq3waj9BlCBNQEMJMVA08xW2lCJ6i5VL0Jc0RgcomA+Y
         fKb2IMsCynw0Qb7y80cFW6HeuYBxgURlQFeaMNv+FhFqA7d4ntwk/JaFDxHm2eKbmOzx
         wtKDhT5hIwmgEFBev6xbCcjjOr/mGi/dxq6WHmJLRKQtm6DuyNtEKVPBz5/Z7w1kgtAo
         +S22R9uYkY8aAXxW7qRrCPdIu/E3ntL63t7ocrh/UtZZ20J6iDFwNQstnaWw5u9iJpa7
         wGMH0TSNPci4tw0/Z+s1pEoLQ8rK7Ir8HdQjnfBBRVH/n7vdvp8OKDtH3j9uIEWVktX0
         5ExA==
X-Gm-Message-State: AOJu0YzLO6RSAPllhQFSENT2dawjDt0NDXV8qBTMToT85qN3SidrB1XL
        K73VMmBZGH+5LS6Eg+VGchW5pvlhzeo=
X-Google-Smtp-Source: AGHT+IHZuhNm9DplZl5E3aWhkcAh4wtTbK59lXFvkNRn3SgGGTql+gpKMhhKTDr6KrfBC+UfJnjDTQ==
X-Received: by 2002:a05:600c:2295:b0:3fe:16c0:6b44 with SMTP id 21-20020a05600c229500b003fe16c06b44mr73671wmf.12.1691702284970;
        Thu, 10 Aug 2023 14:18:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18-20020a1ced12000000b003fc01f7a42dsm3198233wmh.8.2023.08.10.14.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:18:04 -0700 (PDT)
Message-ID: <1623dd000ddef40ffb6ca44cf7ce66d1c42b0d13.1691702283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
        <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 21:17:51 +0000
Subject: [PATCH v2 01/13] trailer tests: make test cases self-contained
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

By using "test_config" instead of "git config", we avoid leaking
configuration state across test cases. This in turn helps to make the
tests more self-contained, by explicitly capturing the configuration
setup. It then makes it easier to add tests anywhere in this 1500+ line
file, without worrying about what implicit state was set in some prior
test case defined earlier up in the script.

This commit was created mechanically as follows: we changed the first
occurrence of a particular "git config trailer.*" option, then ran the
tests repeatedly to see which ones broke, adding in the extra
"test_config" equivalents to make them pass again. In addition, in some
test cases we removed "git config --unset ..." lines because they were
no longer necessary (as the --unset was being used to clean up leaked
configuration state from earlier test cases).

The process described above was done repeatedly until there were no more
unbridled "git config" invocations. Some "git config" invocations still
do exist in the script, but they were already cleaned up properly with

    test_when_finished "git config --remove-section ..."

so they were left alone.

Note that these cleanups result in generally longer test case setups
because the previously hidden state is now being exposed. Although we
could then clean up the test cases' "expected" values to be less
verbose (the verbosity arising from the use of implicit state), we
choose not to do so here, to make sure that this cleanup does not change
any meanings behind the test cases.

Signed-off-by: Linus Arver <linusa@google.com>
---
 t/t7513-interpret-trailers.sh | 374 +++++++++++++++++++++++++++-------
 1 file changed, 300 insertions(+), 74 deletions(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 97f10905d23..5b31896070a 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -489,7 +489,7 @@ test_expect_success 'multiline field treated as atomic for neighbor check' '
 '
 
 test_expect_success 'with config setup' '
-	git config trailer.ack.key "Acked-by: " &&
+	test_config trailer.ack.key "Acked-by: " &&
 	cat >expected <<-\EOF &&
 
 		Acked-by: Peff
@@ -503,8 +503,8 @@ test_expect_success 'with config setup' '
 '
 
 test_expect_success 'with config setup and ":=" as separators' '
-	git config trailer.separators ":=" &&
-	git config trailer.ack.key "Acked-by= " &&
+	test_config trailer.separators ":=" &&
+	test_config trailer.ack.key "Acked-by= " &&
 	cat >expected <<-\EOF &&
 
 		Acked-by= Peff
@@ -518,7 +518,7 @@ test_expect_success 'with config setup and ":=" as separators' '
 '
 
 test_expect_success 'with config setup and "%" as separators' '
-	git config trailer.separators "%" &&
+	test_config trailer.separators "%" &&
 	cat >expected <<-\EOF &&
 
 		bug% 42
@@ -532,6 +532,7 @@ test_expect_success 'with config setup and "%" as separators' '
 '
 
 test_expect_success 'with "%" as separators and a message with trailers' '
+	test_config trailer.separators "%" &&
 	cat >special_message <<-\EOF &&
 		Special Message
 
@@ -553,8 +554,8 @@ test_expect_success 'with "%" as separators and a message with trailers' '
 '
 
 test_expect_success 'with config setup and ":=#" as separators' '
-	git config trailer.separators ":=#" &&
-	git config trailer.bug.key "Bug #" &&
+	test_config trailer.separators ":=#" &&
+	test_config trailer.bug.key "Bug #" &&
 	cat >expected <<-\EOF &&
 
 		Bug #42
@@ -581,6 +582,8 @@ test_expect_success 'with basic patch' '
 '
 
 test_expect_success 'with commit complex message as argument' '
+	test_config trailer.separators ":=" &&
+	test_config trailer.ack.key "Acked-by= " &&
 	cat complex_message_body complex_message_trailers >complex_message &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
@@ -594,6 +597,8 @@ test_expect_success 'with commit complex message as argument' '
 '
 
 test_expect_success 'with 2 files arguments' '
+	test_config trailer.separators ":=" &&
+	test_config trailer.ack.key "Acked-by= " &&
 	cat basic_message >>expected &&
 	echo >>expected &&
 	cat basic_patch >>expected &&
@@ -677,6 +682,9 @@ test_expect_success 'with message that has an old style conflict block' '
 '
 
 test_expect_success 'with commit complex message and trailer args' '
+	test_config trailer.separators ":=#" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.bug.key "Bug #" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Fixes: Z
@@ -692,6 +700,9 @@ test_expect_success 'with commit complex message and trailer args' '
 '
 
 test_expect_success 'with complex patch, args and --trim-empty' '
+	test_config trailer.separators ":=#" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.bug.key "Bug #" &&
 	cat complex_message >complex_patch &&
 	cat basic_patch >>complex_patch &&
 	cat complex_message_body >expected &&
@@ -746,7 +757,10 @@ test_expect_success POSIXPERM,SANITY "in-place editing doesn't clobber original
 '
 
 test_expect_success 'using "where = before"' '
-	git config trailer.bug.where "before" &&
+	test_config trailer.separators ":=#" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -762,7 +776,9 @@ test_expect_success 'using "where = before"' '
 '
 
 test_expect_success 'overriding configuration with "--where after"' '
-	git config trailer.ack.where "before" &&
+	test_config trailer.separators ":=" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "before" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Fixes: Z
@@ -777,6 +793,11 @@ test_expect_success 'overriding configuration with "--where after"' '
 '
 
 test_expect_success 'using "where = before" with "--no-where"' '
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "before" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -792,7 +813,11 @@ test_expect_success 'using "where = before" with "--no-where"' '
 '
 
 test_expect_success 'using "where = after"' '
-	git config trailer.ack.where "after" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -808,8 +833,11 @@ test_expect_success 'using "where = after"' '
 '
 
 test_expect_success 'using "where = end"' '
-	git config trailer.review.key "Reviewed-by" &&
-	git config trailer.review.where "end" &&
+	test_config trailer.review.key "Reviewed-by" &&
+	test_config trailer.review.where "end" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.separators ":=" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Fixes: Z
@@ -827,8 +855,11 @@ test_expect_success 'using "where = end"' '
 '
 
 test_expect_success 'using "where = start"' '
-	git config trailer.review.key "Reviewed-by" &&
-	git config trailer.review.where "start" &&
+	test_config trailer.review.key "Reviewed-by" &&
+	test_config trailer.review.where "start" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.separators ":=" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Reviewed-by: Johannes
@@ -846,8 +877,13 @@ test_expect_success 'using "where = start"' '
 '
 
 test_expect_success 'using "where = before" for a token in the middle of the message' '
-	git config trailer.review.key "Reviewed-by:" &&
-	git config trailer.review.where "before" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.review.where "before" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -864,6 +900,12 @@ test_expect_success 'using "where = before" for a token in the middle of the mes
 '
 
 test_expect_success 'using "where = before" and --trim-empty' '
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	cat >>expected <<-\EOF &&
 		Bug #46
@@ -878,6 +920,13 @@ test_expect_success 'using "where = before" and --trim-empty' '
 '
 
 test_expect_success 'the default is "ifExists = addIfDifferentNeighbor"' '
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.review.where "before" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -896,7 +945,13 @@ test_expect_success 'the default is "ifExists = addIfDifferentNeighbor"' '
 '
 
 test_expect_success 'default "ifExists" is now "addIfDifferent"' '
-	git config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -914,8 +969,14 @@ test_expect_success 'default "ifExists" is now "addIfDifferent"' '
 '
 
 test_expect_success 'using "ifExists = addIfDifferent" with "where = end"' '
-	git config trailer.ack.ifExists "addIfDifferent" &&
-	git config trailer.ack.where "end" &&
+	test_config trailer.ack.ifExists "addIfDifferent" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "end" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -932,8 +993,14 @@ test_expect_success 'using "ifExists = addIfDifferent" with "where = end"' '
 '
 
 test_expect_success 'using "ifExists = addIfDifferent" with "where = before"' '
-	git config trailer.ack.ifExists "addIfDifferent" &&
-	git config trailer.ack.where "before" &&
+	test_config trailer.ack.ifExists "addIfDifferent" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "before" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -950,8 +1017,14 @@ test_expect_success 'using "ifExists = addIfDifferent" with "where = before"' '
 '
 
 test_expect_success 'using "ifExists = addIfDifferentNeighbor" with "where = end"' '
-	git config trailer.ack.ifExists "addIfDifferentNeighbor" &&
-	git config trailer.ack.where "end" &&
+	test_config trailer.ack.ifExists "addIfDifferentNeighbor" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "end" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -973,8 +1046,14 @@ test_expect_success 'using "ifExists = addIfDifferentNeighbor" with "where = end
 '
 
 test_expect_success 'using "ifExists = addIfDifferentNeighbor"  with "where = after"' '
-	git config trailer.ack.ifExists "addIfDifferentNeighbor" &&
-	git config trailer.ack.where "after" &&
+	test_config trailer.ack.ifExists "addIfDifferentNeighbor" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -995,7 +1074,11 @@ test_expect_success 'using "ifExists = addIfDifferentNeighbor"  with "where = af
 '
 
 test_expect_success 'using "ifExists = addIfDifferentNeighbor" and --trim-empty' '
-	git config trailer.ack.ifExists "addIfDifferentNeighbor" &&
+	test_config trailer.ack.ifExists "addIfDifferentNeighbor" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	cat >>expected <<-\EOF &&
 		Bug #42
@@ -1011,8 +1094,14 @@ test_expect_success 'using "ifExists = addIfDifferentNeighbor" and --trim-empty'
 '
 
 test_expect_success 'using "ifExists = add" with "where = end"' '
-	git config trailer.ack.ifExists "add" &&
-	git config trailer.ack.where "end" &&
+	test_config trailer.ack.ifExists "add" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "end" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -1036,8 +1125,14 @@ test_expect_success 'using "ifExists = add" with "where = end"' '
 '
 
 test_expect_success 'using "ifExists = add" with "where = after"' '
-	git config trailer.ack.ifExists "add" &&
-	git config trailer.ack.where "after" &&
+	test_config trailer.ack.ifExists "add" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -1058,8 +1153,15 @@ test_expect_success 'using "ifExists = add" with "where = after"' '
 '
 
 test_expect_success 'overriding configuration with "--if-exists replace"' '
-	git config trailer.fix.key "Fixes: " &&
-	git config trailer.fix.ifExists "add" &&
+	test_config trailer.fix.key "Fixes: " &&
+	test_config trailer.fix.ifExists "add" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.review.where "before" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -1075,8 +1177,15 @@ test_expect_success 'overriding configuration with "--if-exists replace"' '
 '
 
 test_expect_success 'using "ifExists = replace"' '
-	git config trailer.fix.key "Fixes: " &&
-	git config trailer.fix.ifExists "replace" &&
+	test_config trailer.fix.key "Fixes: " &&
+	test_config trailer.fix.ifExists "replace" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -1095,7 +1204,16 @@ test_expect_success 'using "ifExists = replace"' '
 '
 
 test_expect_success 'using "ifExists = replace" with "where = after"' '
-	git config trailer.fix.where "after" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.fix.key "Fixes: " &&
+	test_config trailer.fix.ifExists "replace" &&
+	test_config trailer.fix.where "after" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -1114,7 +1232,15 @@ test_expect_success 'using "ifExists = replace" with "where = after"' '
 '
 
 test_expect_success 'using "ifExists = doNothing"' '
-	git config trailer.fix.ifExists "doNothing" &&
+	test_config trailer.fix.ifExists "doNothing" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.fix.key "Fixes: " &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -1133,8 +1259,17 @@ test_expect_success 'using "ifExists = doNothing"' '
 '
 
 test_expect_success 'the default is "ifMissing = add"' '
-	git config trailer.cc.key "Cc: " &&
-	git config trailer.cc.where "before" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.cc.key "Cc: " &&
+	test_config trailer.cc.where "before" &&
+	test_config trailer.fix.key "Fixes: " &&
+	test_config trailer.fix.ifExists "doNothing" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -1154,7 +1289,14 @@ test_expect_success 'the default is "ifMissing = add"' '
 '
 
 test_expect_success 'overriding configuration with "--if-missing doNothing"' '
-	git config trailer.ifmissing "add" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.fix.key "Fixes: " &&
+	test_config trailer.fix.ifExists "doNothing" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.ifmissing "add" &&
+	test_config trailer.separators ":=" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Fixes: Z
@@ -1173,7 +1315,13 @@ test_expect_success 'overriding configuration with "--if-missing doNothing"' '
 '
 
 test_expect_success 'when default "ifMissing" is "doNothing"' '
-	git config trailer.ifmissing "doNothing" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.fix.ifExists "doNothing" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.ifmissing "doNothing" &&
+	test_config trailer.separators ":=" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Fixes: Z
@@ -1187,14 +1335,21 @@ test_expect_success 'when default "ifMissing" is "doNothing"' '
 		--trailer "cc=Linus" --trailer "ack: Junio" \
 		--trailer "fix=22" --trailer "bug: 42" --trailer "ack: Peff" \
 		<complex_message >actual &&
-	test_cmp expected actual &&
-	git config trailer.ifmissing "add"
+	test_cmp expected actual
 '
 
 test_expect_success 'using "ifMissing = add" with "where = end"' '
-	git config trailer.cc.key "Cc: " &&
-	git config trailer.cc.where "end" &&
-	git config trailer.cc.ifMissing "add" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.cc.key "Cc: " &&
+	test_config trailer.cc.ifMissing "add" &&
+	test_config trailer.cc.where "end" &&
+	test_config trailer.fix.ifExists "doNothing" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -1214,9 +1369,17 @@ test_expect_success 'using "ifMissing = add" with "where = end"' '
 '
 
 test_expect_success 'using "ifMissing = add" with "where = before"' '
-	git config trailer.cc.key "Cc: " &&
-	git config trailer.cc.where "before" &&
-	git config trailer.cc.ifMissing "add" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.cc.key "Cc: " &&
+	test_config trailer.cc.ifMissing "add" &&
+	test_config trailer.cc.where "before" &&
+	test_config trailer.fix.ifExists "doNothing" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Cc: Linus
@@ -1236,7 +1399,15 @@ test_expect_success 'using "ifMissing = add" with "where = before"' '
 '
 
 test_expect_success 'using "ifMissing = doNothing"' '
-	git config trailer.cc.ifMissing "doNothing" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.cc.ifMissing "doNothing" &&
+	test_config trailer.fix.ifExists "doNothing" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -1256,7 +1427,15 @@ test_expect_success 'using "ifMissing = doNothing"' '
 
 test_expect_success 'default "where" is now "after"' '
 	git config trailer.where "after" &&
-	git config --unset trailer.ack.where &&
+	test_config trailer.ack.ifExists "add" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.ack.where "after" &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.bug.where "before" &&
+	test_config trailer.fix.ifExists "doNothing" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=#" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Bug #42
@@ -1280,10 +1459,15 @@ test_expect_success 'default "where" is now "after"' '
 '
 
 test_expect_success 'with simple command' '
-	git config trailer.sign.key "Signed-off-by: " &&
-	git config trailer.sign.where "after" &&
-	git config trailer.sign.ifExists "addIfDifferentNeighbor" &&
-	git config trailer.sign.command "echo \"A U Thor <author@example.com>\"" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.fix.ifExists "doNothing" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.sign.command "echo \"A U Thor <author@example.com>\"" &&
+	test_config trailer.sign.key "Signed-off-by: " &&
+	test_config trailer.sign.ifExists "addIfDifferentNeighbor" &&
+	test_config trailer.sign.where "after" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Fixes: Z
@@ -1298,8 +1482,14 @@ test_expect_success 'with simple command' '
 '
 
 test_expect_success 'with command using committer information' '
-	git config trailer.sign.ifExists "addIfDifferent" &&
-	git config trailer.sign.command "echo \"\$GIT_COMMITTER_NAME <\$GIT_COMMITTER_EMAIL>\"" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.fix.ifExists "doNothing" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.sign.command "echo \"\$GIT_COMMITTER_NAME <\$GIT_COMMITTER_EMAIL>\"" &&
+	test_config trailer.sign.key "Signed-off-by: " &&
+	test_config trailer.sign.ifExists "addIfDifferent" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Fixes: Z
@@ -1314,10 +1504,15 @@ test_expect_success 'with command using committer information' '
 '
 
 test_expect_success 'with command using author information' '
-	git config trailer.sign.key "Signed-off-by: " &&
-	git config trailer.sign.where "after" &&
-	git config trailer.sign.ifExists "addIfDifferentNeighbor" &&
-	git config trailer.sign.command "echo \"\$GIT_AUTHOR_NAME <\$GIT_AUTHOR_EMAIL>\"" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.fix.ifExists "doNothing" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.sign.command "echo \"\$GIT_AUTHOR_NAME <\$GIT_AUTHOR_EMAIL>\"" &&
+	test_config trailer.sign.key "Signed-off-by: " &&
+	test_config trailer.sign.ifExists "addIfDifferentNeighbor" &&
+	test_config trailer.sign.where "after" &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
 		Fixes: Z
@@ -1338,12 +1533,19 @@ test_expect_success 'setup a commit' '
 '
 
 test_expect_success 'cmd takes precedence over command' '
-	test_when_finished "git config --unset trailer.fix.cmd" &&
-	git config trailer.fix.ifExists "replace" &&
-	git config trailer.fix.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%aN)\" \
-	--abbrev-commit --abbrev=14 \"\$1\" || true" &&
-	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" \
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" \
 		--abbrev-commit --abbrev=14 \$ARG" &&
+	test_config trailer.fix.cmd "test -n \"\$1\" && git log -1 --oneline --format=\"%h (%aN)\" \
+	--abbrev-commit --abbrev=14 \"\$1\" || true" &&
+	test_config trailer.fix.key "Fixes: " &&
+	test_config trailer.fix.ifExists "replace" &&
+	test_config trailer.fix.where "after" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.sign.command "echo \"\$GIT_AUTHOR_NAME <\$GIT_AUTHOR_EMAIL>\"" &&
+	test_config trailer.sign.key "Signed-off-by: " &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=" &&
 	FIXED=$(git log -1 --oneline --format="%h (%aN)" --abbrev-commit --abbrev=14 HEAD) &&
 	cat complex_message_body >expected2 &&
 	sed -e "s/ Z\$/ /" >>expected2 <<-EOF &&
@@ -1359,8 +1561,16 @@ test_expect_success 'cmd takes precedence over command' '
 '
 
 test_expect_success 'with command using $ARG' '
-	git config trailer.fix.ifExists "replace" &&
-	git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG" &&
+	test_config trailer.fix.key "Fixes: " &&
+	test_config trailer.fix.ifExists "replace" &&
+	test_config trailer.fix.where "after" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.sign.command "echo \"\$GIT_AUTHOR_NAME <\$GIT_AUTHOR_EMAIL>\"" &&
+	test_config trailer.sign.key "Signed-off-by: " &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=" &&
 	FIXED=$(git log -1 --oneline --format="%h (%s)" --abbrev-commit --abbrev=14 HEAD) &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-EOF &&
@@ -1376,8 +1586,16 @@ test_expect_success 'with command using $ARG' '
 '
 
 test_expect_success 'with failing command using $ARG' '
-	git config trailer.fix.ifExists "replace" &&
-	git config trailer.fix.command "false \$ARG" &&
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.fix.command "false \$ARG" &&
+	test_config trailer.fix.key "Fixes: " &&
+	test_config trailer.fix.ifExists "replace" &&
+	test_config trailer.fix.where "after" &&
+	test_config trailer.review.key "Reviewed-by:" &&
+	test_config trailer.sign.command "echo \"\$GIT_AUTHOR_NAME <\$GIT_AUTHOR_EMAIL>\"" &&
+	test_config trailer.sign.key "Signed-off-by: " &&
+	test_config trailer.ifexists "addIfDifferent" &&
+	test_config trailer.separators ":=" &&
 	cat complex_message_body >expected &&
 	sed -e "s/ Z\$/ /" >>expected <<-EOF &&
 		Fixes: Z
@@ -1392,7 +1610,9 @@ test_expect_success 'with failing command using $ARG' '
 '
 
 test_expect_success 'with empty tokens' '
-	git config --unset trailer.fix.command &&
+	test_config trailer.sign.command "echo \"\$GIT_AUTHOR_NAME <\$GIT_AUTHOR_EMAIL>\"" &&
+	test_config trailer.sign.key "Signed-off-by: " &&
+	test_config trailer.ifexists "addIfDifferent" &&
 	cat >expected <<-EOF &&
 
 		Signed-off-by: A U Thor <author@example.com>
@@ -1403,7 +1623,8 @@ test_expect_success 'with empty tokens' '
 '
 
 test_expect_success 'with command but no key' '
-	git config --unset trailer.sign.key &&
+	test_config trailer.sign.command "echo \"\$GIT_AUTHOR_NAME <\$GIT_AUTHOR_EMAIL>\"" &&
+	test_config trailer.ifexists "addIfDifferent" &&
 	cat >expected <<-EOF &&
 
 		sign: A U Thor <author@example.com>
@@ -1414,7 +1635,9 @@ test_expect_success 'with command but no key' '
 '
 
 test_expect_success 'with no command and no key' '
-	git config --unset trailer.review.key &&
+	test_config trailer.review.where "before" &&
+	test_config trailer.sign.command "echo \"\$GIT_AUTHOR_NAME <\$GIT_AUTHOR_EMAIL>\"" &&
+	test_config trailer.ifexists "addIfDifferent" &&
 	cat >expected <<-EOF &&
 
 		review: Junio
@@ -1426,6 +1649,8 @@ test_expect_success 'with no command and no key' '
 '
 
 test_expect_success 'with cut line' '
+	test_config trailer.review.where "before" &&
+	test_config trailer.sign.command "echo \"\$GIT_AUTHOR_NAME <\$GIT_AUTHOR_EMAIL>\"" &&
 	cat >expected <<-\EOF &&
 		my subject
 
@@ -1443,7 +1668,8 @@ test_expect_success 'with cut line' '
 '
 
 test_expect_success 'only trailers' '
-	git config trailer.sign.command "echo config-value" &&
+	test_config trailer.sign.command "echo config-value" &&
+	test_config trailer.ifexists "addIfDifferent" &&
 	cat >expected <<-\EOF &&
 		existing: existing-value
 		sign: config-value
@@ -1462,7 +1688,7 @@ test_expect_success 'only trailers' '
 '
 
 test_expect_success 'only-trailers omits non-trailer in middle of block' '
-	git config trailer.sign.command "echo config-value" &&
+	test_config trailer.sign.command "echo config-value" &&
 	cat >expected <<-\EOF &&
 		Signed-off-by: nobody <nobody@nowhere>
 		Signed-off-by: somebody <somebody@somewhere>
@@ -1482,7 +1708,7 @@ test_expect_success 'only-trailers omits non-trailer in middle of block' '
 '
 
 test_expect_success 'only input' '
-	git config trailer.sign.command "echo config-value" &&
+	test_config trailer.sign.command "echo config-value" &&
 	cat >expected <<-\EOF &&
 		existing: existing-value
 	EOF
-- 
gitgitgadget

