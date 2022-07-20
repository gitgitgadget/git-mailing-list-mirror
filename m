Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABDBC433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 21:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiGTVWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiGTVWS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4AC54CAF
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bv24so3988122wrb.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tLSOXM+9L0SG8qSCFYD0FnNhRBorS6UmHCIzJAK7nCE=;
        b=ZQzxhgR0IAV1HRjj5lkwwFoQcT4XpeOQA8nVi65ro4leP1N5fJoMXaBNHRe6WhhDNn
         MsP95A8+W+4PiEtfBFgwBvqD7TngDUEU2cUTl7SOE4ttW0tHA0XrQnB5To8MxeUX66Km
         7IPAX9KqOZZSsW/DYiCHFAOASV0OsEfSgxB/JHXbp5rzZOhGWt7myrybZbjyvjgW1L/1
         6eQFH5Hfv512jN2Cwq9jANke5zP7y/VduLrqEJ4t5hK+gsQJQRdKASoB8igEoG2rc9ef
         wNN366wUiKujux/Iy1c9bYMzZkeRG8WHoLCiOqwv+owSD4zIWoZosL5hwJrFO06Rhtel
         2YHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tLSOXM+9L0SG8qSCFYD0FnNhRBorS6UmHCIzJAK7nCE=;
        b=vUO4ibXQ/JzoanlH1ENIJrq80XyGGNk8DmL5/Ijf3bpgB3yGjb4GvlvPAfq1b3o/Y2
         w1MYSoD7iZh7X9oqwJXKm+xioP+p93kLgH1zsf0egnS5P+C5vTUidtdMTwL1CNaU+5gc
         d1oP9HOCwGlgEf8P8qhOhNgYCptuIBDnftVjo2Y8RifgoaX5DDqtt0qzG+KOAQes6eYQ
         s6AmQTYsEENNEZRn4PC72QCQeZ+LEUc0h5hW0laI9ENkRFr2CzkLQ2fGze5CwTJ26k8g
         4ZzfVDOzSOuPXJJgUD8+Wxtj09rL8ql6gravqeSAFLSa0DIa/DK+6Je9CaoERm1zCGSm
         PMLA==
X-Gm-Message-State: AJIora9mbnnF9OGhFfpLzIDVHclS9gLtWmt+ODPlDbhTo0UgI8bXNzNd
        aA4ZMdwZGDkD2Q2ucJxNWCCTh3kdMHQMPQ==
X-Google-Smtp-Source: AGRyM1tAMT1TjUfhlqHV78mn793tY143u3MwQ0nWbWSo7ohJuF9/CFLw6xUV0Z7wkYu2j7MX0Rv8QQ==
X-Received: by 2002:a05:6000:114f:b0:21d:6e51:6e55 with SMTP id d15-20020a056000114f00b0021d6e516e55mr31648377wrx.132.1658352130500;
        Wed, 20 Jul 2022 14:22:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a0375c4f73sm3605441wmj.44.2022.07.20.14.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:22:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/14] test-lib: add a SANITIZE=leak logging mode
Date:   Wed, 20 Jul 2022 23:21:44 +0200
Message-Id: <patch-v2-06.14-f1acf762899-20220720T211221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1064.gc96144cf387
In-Reply-To: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to run the test suite under a new
"GIT_TEST_SANITIZE_LEAK_LOG=true" mode, when true we'll log the leaks
we find an a new "test-results/<test-name>.leak" directory.

That new path is consistent with the existing
"test-results/<test-name>.<type>" results, except that those are all
files, not directories.

We also set "log_exe_name=1" to include the name of the executable in
the filename. This gives us files like "trace.git.<pid>" instead of
the default of "trace.<pid>". I.e. we'll be able to distinguish "git"
leaks from "test-tool", "git-daemon" etc.

We then set "dedup_token_length" to non-zero ("0" is the default) to
succinctly log a token we can de-duplicate these stacktraces on. The
string is simply a one-line stack-trace with only function names up to
N frames, which we limit at "9999" as a shorthand for
"infinite" (there appears to be no way to say "no limit").

With these combined we can now easily get e.g. the top 10 leaks in the
test suite grouped by full stacktrace:

    grep -o -P -h '(?<=DEDUP_TOKEN: ).*' test-results/*.leak/trace.git.* | sort | uniq -c | sort -nr | head -n 10

Or add "grep -E -o '[^-]+'" to that to group by functions instead of
stack traces:

    grep -o -P -h '(?<=DEDUP_TOKEN: ).*' test-results/*.leak/trace.git.* | grep -E -o '[^-]+' | sort | uniq -c | sort -nr | head -n 20

This new mode requires git to be compiled with SANITIZE=leak, rather
than explaining that in the documentation let's make it
self-documenting by bailing out if the user asks for this without git
having been compiled with SANITIZE=leak, as we do with
GIT_TEST_PASSING_SANITIZE_LEAK=true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README      |  5 +++++
 t/test-lib.sh | 30 +++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 7f409392537..0664aee7ed9 100644
--- a/t/README
+++ b/t/README
@@ -371,6 +371,11 @@ declared themselves as leak-free by setting
 "TEST_PASSES_SANITIZE_LEAK=true" before sourcing "test-lib.sh". This
 test mode is used by the "linux-leaks" CI target.
 
+GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
+"test-results/$TEST_NAME.leak/trace.*" files. The logs include a
+"dedup_token" (see +"ASAN_OPTIONS=help=1 ./git") and other options to
+make logs +machine-readable.
+
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 31213b5f95b..f5150400c14 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -305,6 +305,10 @@ TEST_NUMBER="${TEST_NAME%%-*}"
 TEST_NUMBER="${TEST_NUMBER#t}"
 TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
 TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME$TEST_STRESS_JOB_SFX"
+TEST_RESULTS_SAN_FILE_PFX=trace
+TEST_RESULTS_SAN_DIR_SFX=leak
+TEST_RESULTS_SAN_FILE=
+TEST_RESULTS_SAN_DIR="$TEST_RESULTS_DIR/$TEST_NAME.$TEST_RESULTS_SAN_DIR_SFX"
 TRASH_DIRECTORY="trash directory.$TEST_NAME$TEST_STRESS_JOB_SFX"
 test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
 case "$TRASH_DIRECTORY" in
@@ -1447,6 +1451,10 @@ then
 	test_done
 fi
 
+BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK () {
+	BAIL_OUT "$1 has no effect except when compiled with SANITIZE=leak"
+}
+
 # skip non-whitelisted tests when compiled with SANITIZE=leak
 if test -n "$SANITIZE_LEAK"
 then
@@ -1462,9 +1470,29 @@ then
 			test_done
 		fi
 	fi
+
+	if test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
+	then
+		if ! mkdir -p "$TEST_RESULTS_SAN_DIR"
+		then
+			BAIL_OUT "cannot create $TEST_RESULTS_SAN_DIR"
+		fi &&
+		TEST_RESULTS_SAN_FILE="$TEST_RESULTS_SAN_DIR/$TEST_RESULTS_SAN_FILE_PFX"
+
+		# Don't litter *.leak dirs if there was nothing to report
+		test_atexit "rmdir \"$TEST_RESULTS_SAN_DIR\" 2>/dev/null || :"
+
+		prepend_var LSAN_OPTIONS : dedup_token_length=9999
+		prepend_var LSAN_OPTIONS : log_exe_name=1
+		prepend_var LSAN_OPTIONS : log_path=\"$TEST_RESULTS_SAN_FILE\"
+		export LSAN_OPTIONS
+	fi
 elif test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
 then
-	BAIL_OUT "GIT_TEST_PASSING_SANITIZE_LEAK=true has no effect except when compiled with SANITIZE=leak"
+	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_PASSING_SANITIZE_LEAK=true"
+elif test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
+then
+	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_SANITIZE_LEAK_LOG=true"
 fi
 
 # Last-minute variable setup
-- 
2.37.1.1064.gc96144cf387

