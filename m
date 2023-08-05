Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5FDEB64DD
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 04:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjHEEp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 00:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHEEpp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 00:45:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AF64EDA
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 21:45:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso2335439f8f.0
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 21:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691210741; x=1691815541;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKPl42RSzL8yMZqcs2H0g2o3zU7uxqKAob5ypQKsfWM=;
        b=NnjzRRN9W1LF6lQmNzYfoEGBu5moVtjEBFDaBx+slv1Z3Ze9EvNINCJt7DsFTVTglA
         9ZEO0G5ZYT4EtkckwHEKbTuhSgHwb3DbS2xnTW5MeTmSOyOnkxf9YehzLK0nKGIXP7+2
         NR+nYj9/bb+AozNv6A1KZdwS1Hp8atTWGHrrUYJ0N7xHeFK0asZLmD0lacl4qu7mSj6C
         olFa0WYl2MNSqGy5bKUxGCznS+IIZQn26Nfwk0U+EkP2dwiveqxatFPMXYMBttwF7UKR
         BVflnc6Rg/mz77jEOtQqu+y6FAKjtQZBld+89gn6mMtwF/fYeC9BVlC2OyNBBfqNFxnr
         Rd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691210741; x=1691815541;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKPl42RSzL8yMZqcs2H0g2o3zU7uxqKAob5ypQKsfWM=;
        b=PClJOn8t2IHQklLvud/91XfsmoIQpVd9jWI40D5W5K0w6/abl+zLjzBGmLOIrlTyBp
         QMrSPOdg2e1flo2cWJ/1v0Y33TiLRHbeh2h68eZgKrIBgZyFNyYCHtvjlKBPtssZwRWv
         wzrSd63HcIcHtdGS3tQCA24ASlz0K7/DzNyC/0rb13eIIBnRtmROyzj1doez5GBD7t6x
         GAKkDCrbeseOlzFcPjyx5voTtjbxSXIgt6JfyYiDHAidNwzCdhaQIngm3JJMslFnBQYp
         IhZY8AYGW3s8mM+dqxfY28ezTee2ul5TxFP3v+k6YeJWI3kXJktGoP/mCwXr0VLW6CfE
         i15Q==
X-Gm-Message-State: AOJu0YwXE9qxjDTSOUTP+y+9QeINWlC+0yadwUj0mF/VN/Rh+MB7srET
        BX7BXQGXbVh3bCHDzN0XxWPNC/EbX7w=
X-Google-Smtp-Source: AGHT+IGvcHZRbfSbk+gqviOBCOfcL3pkS8sJhRRzQkGs6QdS+SXL2BkFs92tF0qHcRg6MjkScFeyRQ==
X-Received: by 2002:adf:dd10:0:b0:314:415:cbf5 with SMTP id a16-20020adfdd10000000b003140415cbf5mr2364077wrm.51.1691210740971;
        Fri, 04 Aug 2023 21:45:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3-20020a5d5943000000b00317ac0642b0sm4088870wri.27.2023.08.04.21.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 21:45:40 -0700 (PDT)
Message-ID: <6b427b4b1e82b1f01640f1f49fe8d1c2fd02111e.1691210737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Aug 2023 04:45:35 +0000
Subject: [PATCH 3/5] trailer: add tests to check defaulting behavior with
 --no-* flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

While the "--no-where" flag is tested, the "--no-if-exists" and
"--no-if-missing" flags are not, so add tests for them. But also add
tests for all "--no-*" flags to check their effects, both when (1) there
are relevant configuration variables set, and (2) they are not set.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt |  14 ++-
 t/t7513-interpret-trailers.sh            | 130 +++++++++++++++++++++++
 2 files changed, 140 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 55d89614661..91a4dbc9a72 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -114,8 +114,10 @@ OPTIONS
 	Specify where all new trailers will be added.  A setting
 	provided with '--where' overrides all configuration variables
 	and applies to all '--trailer' options until the next occurrence of
-	'--where' or '--no-where'. Possible values are `after`, `before`,
-	`end` or `start`.
+	'--where' or '--no-where'. Upon encountering '--no-where', clear the
+	effect of any previous use of '--where', such that the relevant configuration
+	variables are no longer overridden. Possible values are `after`,
+	`before`, `end` or `start`.
 
 --if-exists <action>::
 --no-if-exists::
@@ -123,7 +125,9 @@ OPTIONS
 	least one trailer with the same <token> in the input.  A setting
 	provided with '--if-exists' overrides all configuration variables
 	and applies to all '--trailer' options until the next occurrence of
-	'--if-exists' or '--no-if-exists'. Possible actions are `addIfDifferent`,
+	'--if-exists' or '--no-if-exists'. Upon encountering '--no-if-exists, clear the
+	effect of any previous use of '--if-exists, such that the relevant configuration
+	variables are no longer overridden. Possible actions are `addIfDifferent`,
 	`addIfDifferentNeighbor`, `add`, `replace` and `doNothing`.
 
 --if-missing <action>::
@@ -132,7 +136,9 @@ OPTIONS
 	trailer with the same <token> in the input.  A setting
 	provided with '--if-missing' overrides all configuration variables
 	and applies to all '--trailer' options until the next occurrence of
-	'--if-missing' or '--no-if-missing'. Possible actions are `doNothing`
+	'--if-missing' or '--no-if-missing'. Upon encountering '--no-if-missing,
+	clear the effect of any previous use of '--if-missing, such that the relevant
+	configuration variables are no longer overridden. Possible actions are `doNothing`
 	or `add`.
 
 --only-trailers::
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index ed0fc04bd95..832aff06167 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -812,6 +812,53 @@ test_expect_success 'using "--where after" with "--no-where"' '
 	test_cmp expected actual
 '
 
+# Check whether using "--no-where" clears out only the "--where after", such
+# that we still use the configuration in trailer.where (which is different from
+# the hardcoded default (in WHERE_END) assuming the absence of .gitconfig).
+# Here, the "start" setting of trailer.where is respected, so the new "Acked-by"
+# and "Bug" trailers are placed at the beginning, and not at the end which is
+# the harcoded default.
+test_expect_success 'using "--where after" with "--no-where" defaults to configuration' '
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.separators ":=#" &&
+	test_config trailer.where "start" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Bug #42
+		Acked-by= Peff
+		Fixes: Z
+		Acked-by= Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --where after --no-where --trailer "ack: Peff" \
+		--trailer "bug: 42" complex_message >actual &&
+	test_cmp expected actual
+'
+
+# The "--where after" will only get respected for the trailer that came
+# immediately after it. For the next trailer (Bug #42), we default to using the
+# hardcoded WHERE_END because we don't have any "trailer.where" or
+# "trailer.bug.where" configured.
+test_expect_success 'using "--no-where" defaults to harcoded default if nothing configured' '
+	test_config trailer.ack.key "Acked-by= " &&
+	test_config trailer.bug.key "Bug #" &&
+	test_config trailer.separators ":=#" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by= Z
+		Acked-by= Peff
+		Reviewed-by: Z
+		Signed-off-by: Z
+		Bug #42
+	EOF
+	git interpret-trailers --where after --trailer "ack: Peff" --no-where \
+		--trailer "bug: 42" complex_message >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'using "where = after"' '
 	test_config trailer.ack.key "Acked-by= " &&
 	test_config trailer.ack.where "after" &&
@@ -1176,6 +1223,56 @@ test_expect_success 'overriding configuration with "--if-exists replace"' '
 	test_cmp expected actual
 '
 
+# "trailer.ifexists" is set to "doNothing", so using "--no-if-exists" defaults
+# to this "doNothing" behavior. So the "Fixes: 53" trailer does not get added.
+test_expect_success 'using "--if-exists replace" with "--no-if-exists" defaults to configuration' '
+	test_config trailer.ifexists "doNothing" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Fixes: Z
+		Acked-by: Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+	EOF
+	git interpret-trailers --if-exists replace --no-if-exists --trailer "Fixes: 53" \
+		<complex_message >actual &&
+	test_cmp expected actual
+'
+
+# No "ifexists" configuration is set, so using "--no-if-exists" makes it default
+# to addIfDifferentNeighbor. Because we do have a different neighbor "Fixes: 53"
+# (because it got added by overriding with "--if-exists replace" earlier in the
+# arguments list), we add "Signed-off-by: addme".
+test_expect_success 'using "--no-if-exists" defaults to hardcoded default if nothing configured' '
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Acked-by: Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+		Fixes: 53
+		Signed-off-by: addme
+	EOF
+	git interpret-trailers --if-exists replace --trailer "Fixes: 53" --no-if-exists \
+		--trailer "Signed-off-by: addme" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+# The second "Fixes: 53" trailer is discarded, because the "--no-if-exists" here
+# makes us default to addIfDifferentNeighbor, and we already added the "Fixes:
+# 53" trailer earlier in the argument list.
+test_expect_success 'using "--no-if-exists" defaults to hardcoded default if nothing configured (no addition)' '
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+		Acked-by: Z
+		Reviewed-by: Z
+		Signed-off-by: Z
+		Fixes: 53
+	EOF
+	git interpret-trailers --if-exists replace --trailer "Fixes: 53" --no-if-exists \
+		--trailer "Fixes: 53" <complex_message >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'using "ifExists = replace"' '
 	test_config trailer.fix.key "Fixes: " &&
 	test_config trailer.fix.ifExists "replace" &&
@@ -1425,6 +1522,39 @@ test_expect_success 'using "ifMissing = doNothing"' '
 	test_cmp expected actual
 '
 
+# Ignore the "IgnoredTrailer" because of "--if-missing doNothing", but also
+# ignore the "StillIgnoredTrailer" because we set "trailer.ifMissing" to
+# "doNothing" in configuration.
+test_expect_success 'using "--no-if-missing" defaults to configuration' '
+	test_config trailer.ifMissing "doNothing" &&
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+			Fixes: Z
+			Acked-by: Z
+			Reviewed-by: Z
+			Signed-off-by: Z
+	EOF
+	git interpret-trailers --if-missing doNothing --trailer "IgnoredTrailer: ignoreme" --no-if-missing \
+			--trailer "StillIgnoredTrailer: ignoreme" <complex_message >actual &&
+	test_cmp expected actual
+'
+
+# Add the "AddedTrailer" because the "--no-if-missing" clears the "--if-missing
+# doNothing" from earlier in the argument list.
+test_expect_success 'using "--no-if-missing" defaults to hardcoded default if nothing configured' '
+	cat complex_message_body >expected &&
+	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
+			Fixes: Z
+			Acked-by: Z
+			Reviewed-by: Z
+			Signed-off-by: Z
+			AddedTrailer: addme
+	EOF
+	git interpret-trailers --if-missing doNothing --trailer "IgnoredTrailer: ignoreme" --no-if-missing \
+			--trailer "AddedTrailer: addme" <complex_message >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'default "where" is now "after"' '
 	git config trailer.where "after" &&
 	test_config trailer.ack.ifExists "add" &&
-- 
gitgitgadget

