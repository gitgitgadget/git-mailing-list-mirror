Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1384ECAAD5
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiIAAau (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiIAAaW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B4732D88
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w5so4093098wrn.12
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=bDLQc4w7rxzNO22p/rRmIVIciPKBABfTRvM2eAKkfP0=;
        b=TEECpXSc/HKkcOLcqTYT3XH6iaSMDWeh1EgIrLhGXkFZtDMnDmeVx3I2ruuSXl6M1P
         fnaCKK0Z0aLyRhmP7yOONBqhs69fMk7xUv4JxH8EulBEEU55zzuw/IpCLVvi2jqhFUKU
         2ITTke6ribdpZZeKCyx0xsJc4RxV5nNmkl3vF+9xPZsVautLjHVdfiJWWmQAB6EnPKF9
         QRG4d8whodF+7DOXdTlPAS/WbOp/hczmqP5PXUbtP4S8+udlrqDROcdSh/ZWUqX87n/Y
         cBmNF8fHy6ege1yLCB9NR82/vuBRMb/BlMrtAyZKqmJoPpcfcywD5oeKqsUwsFUTL29x
         b7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=bDLQc4w7rxzNO22p/rRmIVIciPKBABfTRvM2eAKkfP0=;
        b=H7O8QaluwNDUvZFmSUg6vr0momrn7ZyjBA5kxILYr4o1+7g8ddkGbRqh2mxU3M08wL
         6h3j8KA5xgrLwKE1VG6H+mxwG6TV8HQAlKQ3Ni4HsDg+ss7RxVENt6a6Qjpir/8XVgeU
         m7vz+gamY3PYdutVczBsEpgwY12kwez6WY7MS8x6Tl9Piyd4blvdsibmrPgvn2yEV6Pg
         ES3MwFgEnfWdI20FzV32ooBhpArPK+XQMgVzcYDpMjYv9fYjN4XIFKuWHHAkT3rz3W3j
         v170TpDEBOxs4lukyrktYSpPg28HuC4BbryQEJqUGdaHCbJCzdB7bxbK3sgJIgJJoGQw
         dPSw==
X-Gm-Message-State: ACgBeo3pTKa1Sz0I6HvNm08nXPX4wUYTXrzvy+myZtRwKMshy/I+4z5n
        18ABTgR+yuacY0hFmVPiDGVlI4CpwDU=
X-Google-Smtp-Source: AA6agR4k3BrMQpowgrD7KxYFpshTsnKh/pjEI9532X1ONKzG//6jqTToQLEKQbuu4dAie4J2wTRKVw==
X-Received: by 2002:a05:6000:381:b0:221:7542:61bb with SMTP id u1-20020a056000038100b00221754261bbmr12986950wrf.305.1661992217316;
        Wed, 31 Aug 2022 17:30:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6-20020a1cf606000000b003a5fa79007fsm3429183wmc.7.2022.08.31.17.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:16 -0700 (PDT)
Message-Id: <9589f2a6e495034cc4f45bd0bce80dedfcd30f16.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:54 +0000
Subject: [PATCH 16/18] test-lib: replace chainlint.sed with chainlint.pl
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

By automatically invoking chainlint.sed upon each test it runs,
`test_run_` in test-lib.sh ensures that broken &&-chains will be
detected early as tests are modified or new are tests created since it
is typical to run a test script manually (i.e. `./t1234-test-script.sh`)
during test development. Now that the implementation of chainlint.pl is
complete, modify test-lib.sh to invoke it automatically instead of
chainlint.sed each time a test script is run.

This change reduces the number of "linter" invocations from 26800+ (once
per test run) down to 1050+ (once per test script), however, a
subsequent change will drop the number of invocations to 1 per `make
test`, thus fully realizing the benefit of the new linter.

Note that the "magic exit code 117" &&-chain checker added by bb79af9d09
(t/test-lib: introduce --chain-lint option, 2015-03-20) which is built
into t/test-lib.sh is retained since it has near zero-cost and
(theoretically) may catch a broken &&-chain not caught by chainlint.pl.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 contrib/buildsystems/CMakeLists.txt | 2 +-
 t/test-lib.sh                       | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 2237109b57f..ca358a21a5f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1076,7 +1076,7 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
 		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
 		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
 	#misc copies
-	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)
+	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.pl DESTINATION ${CMAKE_BINARY_DIR}/t/)
 	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
 	file(COPY ${CMAKE_SOURCE_DIR}/mergetools/tkdiff DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
 	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-prompt.sh DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
diff --git a/t/test-lib.sh b/t/test-lib.sh
index dc0d0591095..a65df2fd220 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1091,8 +1091,7 @@ test_run_ () {
 		trace=
 		# 117 is magic because it is unlikely to match the exit
 		# code of other programs
-		if $(printf '%s\n' "$1" | sed -f "$GIT_BUILD_DIR/t/chainlint.sed" | grep -q '?![A-Z][A-Z]*?!') ||
-			test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
+		if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
 		then
 			BUG "broken &&-chain or run-away HERE-DOC: $1"
 		fi
@@ -1588,6 +1587,12 @@ then
 	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_SANITIZE_LEAK_LOG=true"
 fi
 
+if test "${GIT_TEST_CHAIN_LINT:-1}" != 0
+then
+	"$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$0" ||
+		BUG "lint error (see '?!...!? annotations above)"
+fi
+
 # Last-minute variable setup
 USER_HOME="$HOME"
 HOME="$TRASH_DIRECTORY"
-- 
gitgitgadget

