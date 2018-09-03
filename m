Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A23821F404
	for <e@80x24.org>; Mon,  3 Sep 2018 21:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeIDBck (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 21:32:40 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:36180 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeIDBck (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 21:32:40 -0400
Received: by mail-pg1-f178.google.com with SMTP id d1-v6so614929pgo.3
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I/yaPmmyPlJJPDeiTzLcjWFuVH6ef30aUpHECtjDGLQ=;
        b=m9frsShauvBiaq25cuifY9cwLUNqjduIFLykBCWCByxa6xHwm8O+fh7YBVnhfiK+bY
         fxEbXyUvyQRHZIUooAK7DFS37+RAvPpYdLJJG6aQDUjMt5JoP/ruKURGmkRcHvV6kSA9
         66tKUPdiSk/wWBNiHn0kpt93WkyleWqE3Yid9xsMKDsE8dFk6wQ/tei/EsJyIa04y5ud
         W7uOqw17o0AnI/AJHAc2xi2h/GwRM2x/gCLDhauPirjaYQgil4m4hexIltOqyIsb9fSy
         tsmU1uVHLTEN0ds2uhNxg4A81j46OcE9rv7LZkOb2ZCcTaFgm4eTP8ShlJ0IlY3XmG65
         wQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I/yaPmmyPlJJPDeiTzLcjWFuVH6ef30aUpHECtjDGLQ=;
        b=IrWoYWIwwn0FbRogzfsbvN2Vq2EGFJtT495QzW7ElGas/dDv4hXIsbUSJu1ADfQiIA
         S3s1p5Sjwp2eMQdnYCmT8qdlqGQ6bc9toiqw5E+YtYWKZXgBPjX421nuz0NwH/WpuM/V
         ZrvvetFErqoy2cpGq8jBqbqS4MWh36nBpwVAfjiO+Sg+VNbW2Mm3o0XMqOEemk/9gxT6
         ry1WE1Rus1HzafvSiPJSOodCWbFwlRM1Q1fsySpABXN7oyKIGVXZ94sy+CxOU/tL0QBe
         siz7FOV3uW3YMxNLEhH4DqF2CYciQzzeEad3/WhFZoN2qG94U/13dhd2YwWmjoor1WIV
         X/Sw==
X-Gm-Message-State: APzg51C3ty5fEyCgtLQbF1qmA2Y+g1ikvNT+eiM2LUPkEDL3Ps/IhN8u
        JOf684HPupKh8rxLgS36GadLxjqk
X-Google-Smtp-Source: ANB0VdYpE++/B3agbnsUE3OfTgRf2mviCCBTeolGGsh/wYXoYTEILun3hhGtVvDPaBFsX0bV/C7ZOA==
X-Received: by 2002:a65:4849:: with SMTP id i9-v6mr27239168pgs.350.1536009039469;
        Mon, 03 Sep 2018 14:10:39 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id 8-v6sm20984267pgu.10.2018.09.03.14.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 14:10:38 -0700 (PDT)
Date:   Mon, 03 Sep 2018 14:10:38 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Sep 2018 21:10:24 GMT
Message-Id: <942bf423a461a3b44e2ff254c90907a539d7abbe.1536009027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 7/9] tests: include detailed trace logs with --write-junit-xml
 upon failure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The JUnit XML format lends itself to be presented in a powerful UI,
where you can drill down to the information you are interested in very
quickly.

For test failures, this usually means that you want to see the detailed
trace of the failing tests.

With Travis CI, we passed the `--verbose-log` option to get those
traces. However, that seems excessive, as we do not need/use the logs in
almost all of those cases: only when a test fails do we have a way to
include the trace.

So let's do something different in VSTS: let's run all the tests with
`--quiet` first, and only if a failure is encountered, try to trace the
commands as they are executed.

Of course, we cannot turn on `--verbose-log` after the fact. So let's
just re-run the test with all the same options, adding `--verbose-log`.
And then munging the output file into the JUnit XML on the fly.

Note: there is an off chance that re-running the test in verbose mode
"fixes" the failures (and this does happen from time to time!). That is
a possibility we should be able to live with. Ideally, we would label
this as "Passed upon rerun", and that outcome even exists on VSTS, but
it is not available when using the JUnit XML format for now:
https://github.com/Microsoft/vsts-agent/blob/master/src/Agent.Worker/TestResults/JunitResultReader.cs

This patch contains a slightly inelegant workaround for the p4 and
git-daemon tests: when we try to re-run the p4/git-daemon tests after
the daemon has been started already, we need to kill said daemon. We do
this by detecting the presence of the `kill_p4d` and `stop_git_daemon`
shell functions and calling them if available.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 50a65a600e..ea4ed250cc 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -85,6 +85,13 @@ done,*)
 	test "$(cat "$BASE.exit")" = 0
 	exit
 	;;
+*' --write-junit-xml '*)
+	# record how to call this script *with* --verbose-log, in case
+	# we encounter a breakage
+	junit_rerun_options_sq="$(printf '%s\n' "$0" --verbose-log -x "$@" |
+		sed -e "s/'/'\\\\''/g" -e "s/^/'/" -e "s/\$/'/" |
+		tr '\012' ' ')"
+	;;
 esac
 
 # For repeatability, reset the environment to known value.
@@ -445,10 +452,37 @@ test_ok_ () {
 test_failure_ () {
 	if test -n "$write_junit_xml"
 	then
+		if test -z "$GIT_TEST_TEE_OUTPUT_FILE"
+		then
+			case "$(type kill_p4d 2>/dev/null | head -n 1)" in
+			*function*) kill_p4d;;
+			esac
+
+			case "$(type stop_git_daemon 2>/dev/null |
+				head -n 1)" in
+			*function*) stop_git_daemon;;
+			esac
+
+			# re-run with --verbose-log
+			echo "# Re-running: $junit_rerun_options_sq" >&2
+
+			cd "$TEST_DIRECTORY" &&
+			eval "${TEST_SHELL_PATH}" "$junit_rerun_options_sq" \
+				>/dev/null 2>&1
+			status=$?
+
+			say_color "" "$(test 0 = $status ||
+				echo "not ")ok $test_count - (re-ran with trace)"
+			say "1..$test_count"
+			GIT_EXIT_OK=t
+			exit $status
+		fi
+
 		junit_insert="<failure message=\"not ok $test_count -"
 		junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
 		junit_insert="$junit_insert $(xml_attr_encode \
-			"$(printf '%s\n' "$@" | sed 1d)")"
+			"$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")"
+		>"$GIT_TEST_TEE_OUTPUT_FILE"
 		junit_insert="$junit_insert</failure>"
 		write_junit_xml_testcase "$1" "      $junit_insert"
 	fi
@@ -733,6 +767,10 @@ test_start_ () {
 	if test -n "$write_junit_xml"
 	then
 		junit_start=$(test-tool date getnanos)
+
+		# truncate output
+		test -z "$GIT_TEST_TEE_OUTPUT_FILE" ||
+		>"$GIT_TEST_TEE_OUTPUT_FILE"
 	fi
 }
 
-- 
gitgitgadget

