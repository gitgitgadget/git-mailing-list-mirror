Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D08CCFA0A
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 22:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjIGWUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 18:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjIGWUV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 18:20:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3E31BC6
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 15:20:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31aec0a1a8bso936571f8f.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 15:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694125214; x=1694730014; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKPl42RSzL8yMZqcs2H0g2o3zU7uxqKAob5ypQKsfWM=;
        b=HRakSchlvdd5N49C4oOW89lHSnD3h8le/PsCetDbuJ2l3zJ7+mAJYf2UjjFsg1kQFI
         j6rAb4A1DC+DHF+BLW/8C5SD5cdvGJSus+MoaXxdmQKlNkDbTSusdvnYOT4UgUyOJ3Do
         9TNFZ8RXOFp7Pqep2M2mK5QyzmAxxkU9oyGiRdmdNa2dBNElhKhm80Bsdis9IC86JM1g
         waSfBGHgX8htCdQeuHtcu0UuibAyg50Q9mx2b3+R1y/6zkbs6cfkIZynaMTxKS4oic+H
         01lraAFZeW1qfOkosLweoWci0+hLYb2yk7q+W0i/C+gP3wLZsLO6ruNAyDaLkicy8s4z
         xgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694125214; x=1694730014;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKPl42RSzL8yMZqcs2H0g2o3zU7uxqKAob5ypQKsfWM=;
        b=b1zaAAM4QocYk19SZIcr8aa920lh5z64ryY+DNPwbPQ8gHiGXdgm0Um0HeCb6LOGxp
         5F6WPCl2yN7zYq7Y8dZarsBJisz4UTDKtmlOrG8weqdJJrL1ewjBtD7hR09XQ6r95YNH
         Ubm5R3j1KKRh5yoj8d6PP+0u31JShPRWhUk/i2LbhPJqh+Gf4YUGEy9lRONwVsWybzH/
         g9SG2Th4BFdHwGyOc5lU8VUwOjMi/GSPoGCcyTQZ+2eHvcpXLTcDlI9d+5AnqtBnACCE
         Lh+bvzfXUbbcAuAF9CkhFkN14CPXFvGdlUYx2uXuZsWhzON+7mle87sdSz5CXkGgafLb
         WmFg==
X-Gm-Message-State: AOJu0YyeDTC/PjYQ+ZM59INyhPEx7KAc5RLEXkSC2nQkKwgtORjRR9Ib
        gOV9m6dmwShWpWTuv/MN0khaMxxXiJ4=
X-Google-Smtp-Source: AGHT+IHK+ZJumksFso5zp2TnCRDDXzbX2APOu1OR14EvFiANYSf+3vqYpEPTzNE54igOPBAl+hfTxA==
X-Received: by 2002:a5d:4241:0:b0:317:5efa:c46a with SMTP id s1-20020a5d4241000000b003175efac46amr467261wrr.27.1694125214055;
        Thu, 07 Sep 2023 15:20:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d65cf000000b0030647449730sm433063wrw.74.2023.09.07.15.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 15:20:13 -0700 (PDT)
Message-ID: <4b5c458ef436c2d208e6d6d0a1f99c65e9a11125.1694125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
References: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
        <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 22:19:59 +0000
Subject: [PATCH v3 03/13] trailer: add tests to check defaulting behavior with
 --no-* flags
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

