Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE22B1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 22:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbeHAAiz (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 20:38:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40343 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732379AbeHAAiz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 20:38:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so5942904edq.7
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 15:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tYNbop8BQXrKhEHXXOwnOL1BjDHVsFE2jB2iiB5uAfM=;
        b=Ns7I73bcTzDBp2DG6BXZVE+yj2d7VI4cAs3RBGJJHEse+66V81obqs1CYphQHTK92d
         Zzp3U/7/uAPejTgljorzWPkiNJW5Lp1gGOYqOsEwS7CBtkPHAJl0ryp5hmkDg8/FeELb
         HwEV3QGbMTEdM54Opp3Ad7OXPjK1K+O6Etv4hy4fT6nCbEkxFzUpQbDAdI5ktaofo7ac
         Mw9aH6/7PITQyxT5pMA9eP3T6cCUtH/3x4PLUkvPypOHPRRNPHTmUkV9eFsoYLuDZBmc
         OYmTCkSHjpJ44+DGDZAFxUzp/t4B7D+ZoE8YSNaGdNX3EVWrf498JIFn28/Qx8X8XFjd
         wxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tYNbop8BQXrKhEHXXOwnOL1BjDHVsFE2jB2iiB5uAfM=;
        b=eU9FIrON7W/mjCuO91kzGXLPOWEPmb6ZffcP+r+pG8ck1UeSDtDs0o3nhzCfxWWND5
         hdL39Y0sh0lX75NP5J0nTSAxBNwFcBrqHsb4kUaHmo7Hc+OlpWn+107kh91BLAh0Ph5B
         0b0TH1z8JiDKOYzgve67Zrekl5OzSfX27ZsZFUcheJJrzPfegE2EYfotI8FYd6L88QUG
         Z5tVb4E2ftG2rN4iPKYF8cdGo4sO1b3uvquW0XWFeXoRDxuleCUKyAXZR9pe7GjVAD7c
         zoYAwcnakPPVkTsO77V9wpgTKwkMndDLr+38An5Zo7Js0k7nNbfAPl5I2AcyAJdElO9b
         QjDQ==
X-Gm-Message-State: AOUpUlEAVzxfPwx04u0CwPhxdMVLOGN2c8JqY//kQY0zFJXaWvKe9ETq
        9n6vr8lPSvwJQVyqFuJpZSM=
X-Google-Smtp-Source: AAOMgpdGCouzzRb1Os/VWeNnGf51nF/CXu67I5p+LYqYDZ2kv0DjueEsWlB7un5gyRE0khL2j3Sl7g==
X-Received: by 2002:a50:b003:: with SMTP id i3-v6mr1378877edd.120.1533077779028;
        Tue, 31 Jul 2018 15:56:19 -0700 (PDT)
Received: from localhost.localdomain (x590cfeaf.dyn.telefonica.de. [89.12.254.175])
        by smtp.gmail.com with ESMTPSA id c34-v6sm9255452edc.71.2018.07.31.15.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 15:56:17 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] travis-ci: include the trash directories of failed tests in the trace log
Date:   Wed,  1 Aug 2018 00:56:12 +0200
Message-Id: <20180731225612.24075-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.408.g42635c01bc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The trash directory of a failed test might contain invaluable
information about the cause of the failure, but we have no access to
the trash directories of Travis CI build jobs.  The only feedback we
get from there is the build job's trace log, so...

Modify 'ci/print-test-failures.sh' to create a tar.gz archive of the
trash directory of each failed test, encode that archive with base64,
and print the resulting block of ASCII text, so it gets embedded in
the trace log.  Furthermore, run tests with '--immediate' to
faithfully preserve the failed state.

Extracting the trash directories from the trace log turned out to be a
bit of a hassle, partly because of the size of these logs (usually
resulting in several hundreds or even thousands of lines of
base64-encoded text), and partly because these logs have CRLF, CRCRLF
and occasionally even CRCRCRLF line endings, which cause 'base64 -d'
from coreutils to complain about "invalid input".  For convenience add
a small script 'ci/util/extract-trash-dirs.sh', which will extract and
unpack all base64-encoded trash directories embedded in the log fed to
its standard input, and include an example command to be copy-pasted
into a terminal to do it all at the end of the failure report.

A few of our tests create sizeable trash directories, so limit the
size of each included base64-encoded block, let's say, to 1MB.  And
just in case something fundamental gets broken and a lot of tests fail
at once, don't include trash directories when the combined size of the
included base64-encoded blocks would exceed 1MB.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Notes:
    This is an improved version of the PoC mentioned some months ago at:
    
      https://public-inbox.org/git/20180122182717.21539-1-szeder.dev@gmail.com/
    
    I'm still not sure whether this is too clever or too ugly, or both,
    but it did actually prove to be useful since then: it's very likely
    that we wouldn't have 2f3cbcd8c5 (tests: make forging GPG signed
    commits and tags more robust, 2018-06-04) without it.
    
    The output looks like this; with this patch on top of yesterday's
    'pu' (6f49f36eba), which happens to have multiple test failures:
    
      https://travis-ci.org/szeder/git/jobs/410471312#L3010
    
    (Note: the Travis CI webpage will likely fold up the failure output
    before you could take a closer look at it; then click on the line
    containing '$ ci/print-test-failures.sh' and scroll down for a while.)

 ci/lib-travisci.sh            |  2 +-
 ci/print-test-failures.sh     | 55 +++++++++++++++++++++++++++++++++--
 ci/util/extract-trash-dirs.sh | 50 +++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 3 deletions(-)
 create mode 100755 ci/util/extract-trash-dirs.sh

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index ceecc889ca..06970f7213 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -97,7 +97,7 @@ fi
 export DEVELOPER=1
 export DEFAULT_TEST_TARGET=prove
 export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
-export GIT_TEST_OPTS="--verbose-log -x"
+export GIT_TEST_OPTS="--verbose-log -x --immediate"
 export GIT_TEST_CLONE_2GB=YesPlease
 if [ "$jobname" = linux-gcc ]; then
 	export CC=gcc-8
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 4f261ddc01..d55460a212 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -8,13 +8,24 @@
 # Tracing executed commands would produce too much noise in the loop below.
 set +x
 
-if ! ls t/test-results/*.exit >/dev/null 2>/dev/null
+cd t/
+
+if ! ls test-results/*.exit >/dev/null 2>/dev/null
 then
 	echo "Build job failed before the tests could have been run"
 	exit
 fi
 
-for TEST_EXIT in t/test-results/*.exit
+case "$jobname" in
+osx-clang|osx-gcc)
+	# base64 in OSX doesn't wrap its output at 76 columns by
+	# default, but prints a single, very long line.
+	base64_opts="-b 76"
+	;;
+esac
+
+combined_trash_size=0
+for TEST_EXIT in test-results/*.exit
 do
 	if [ "$(cat "$TEST_EXIT")" != "0" ]
 	then
@@ -23,5 +34,45 @@ do
 		echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
 		echo "------------------------------------------------------------------------"
 		cat "${TEST_OUT}"
+
+		test_name="${TEST_EXIT%.exit}"
+		test_name="${test_name##*/}"
+		trash_dir="trash directory.$test_name"
+		trash_tgz_b64="trash.$test_name.base64"
+		if [ -d "$trash_dir" ]
+		then
+			tar czp "$trash_dir" |base64 $base64_opts >"$trash_tgz_b64"
+
+			trash_size=$(wc -c <"$trash_tgz_b64")
+			if [ $trash_size -gt 1048576 ]
+			then
+				# larger than 1MB
+				echo "$(tput setaf 1)Didn't include the trash directory of '$test_name' in the trace log, it's too big$(tput sgr0)"
+				continue
+			fi
+
+			new_combined_trash_size=$(($combined_trash_size + $trash_size))
+			if [ $new_combined_trash_size -gt 1048576 ]
+			then
+				echo "$(tput setaf 1)Didn't include the trash directory of '$test_name' in the trace log, there is plenty of trash in there already.$(tput sgr0)"
+				continue
+			fi
+			combined_trash_size=$new_combined_trash_size
+
+			# DO NOT modify these two 'echo'-ed strings below
+			# without updating 'ci/util/extract-trash-dirs.sh'
+			# as well.
+			echo "$(tput setaf 1)Start of trash directory of '$test_name':$(tput sgr0)"
+			cat "$trash_tgz_b64"
+			echo "$(tput setaf 1)End of trash directory of '$test_name'$(tput sgr0)"
+		fi
 	fi
 done
+
+if [ $combined_trash_size -gt 0 ]
+then
+	echo "------------------------------------------------------------------------"
+	echo "Trash directories embedded in this log can be extracted by running:"
+	echo
+	echo "  curl https://api.travis-ci.org/v3/job/$TRAVIS_JOB_ID/log.txt |./ci/util/extract-trash-dirs.sh"
+fi
diff --git a/ci/util/extract-trash-dirs.sh b/ci/util/extract-trash-dirs.sh
new file mode 100755
index 0000000000..8e67bec21a
--- /dev/null
+++ b/ci/util/extract-trash-dirs.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+error () {
+	echo >&2 "error: $@"
+	exit 1
+}
+
+find_embedded_trash () {
+	while read -r line
+	do
+		case "$line" in
+		*Start\ of\ trash\ directory\ of\ \'t[0-9][0-9][0-9][0-9]-*\':*)
+			test_name="${line#*\'}"
+			test_name="${test_name%\'*}"
+
+			return 0
+		esac
+	done
+
+	return 1
+}
+
+extract_embedded_trash () {
+	while read -r line
+	do
+		case "$line" in
+		*End\ of\ trash\ directory\ of\ \'$test_name\'*)
+			return
+			;;
+		*)
+			printf '%s\n' "$line"
+			;;
+		esac
+	done
+
+	error "unexpected end of input"
+}
+
+# Raw logs from Linux build jobs have CRLF line endings, while OSX
+# build jobs mostly have CRCRLF, except an odd line every now and
+# then that has CRCRCRLF.  'base64 -d' from 'coreutils' doesn't like
+# CRs and complains about "invalid input", so remove all CRs at the
+# end of lines.
+sed -e 's/\r*$//' | \
+while find_embedded_trash
+do
+	echo "Extracting trash directory of '$test_name'"
+
+	extract_embedded_trash |base64 -d |tar xzp
+done
-- 
2.18.0.408.g42635c01bc

