Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D58CC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 21:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJNVqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 17:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJNVqg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 17:46:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580D19AC30
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:45:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j7so9571679wrr.3
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibpglQJIFgP9j6z8KDbCVZ6yZW73BVoxIeYg4BhjscE=;
        b=YL1F9OoxXsjG1+q8THV8o9N/a7K2PRceTDZLHkAjMtp6YT8wIAfchmNjgLmb6gMq8E
         EQ72ZZHf1x5GpYHtJaDl7lZmWIkWBEIy4q3XGjpd6rBCta9tSFE9WKemBIqINeb+qvDI
         5IXdvrSwSxPLunZP0hrct9HdJnSj+U5jOJi4rwidvI81n9o81ONC5PzLwwKKeWD2DVu1
         dld1a2eEqsrNkKdie98z0OpVqhOG8CCtW44h+GgxFQl2zraKAhYIzPrUXrMA5V8vpeTc
         4Tomwcwn+QiEVFjWTnYV+DsKuM0PBor6myVRfQ7/MNw9MSsjuZqykFYrGK7odC4V9h7G
         pFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibpglQJIFgP9j6z8KDbCVZ6yZW73BVoxIeYg4BhjscE=;
        b=hfwC6JDMKejRWyn1yE9yAHGI3Quv9kpFLm1ihyOjCw+6155NUkPioHYfmPMoS8MMg2
         pzl4q+Ls7dk7oFA5daCBxziKXi3sb6ZWptwxBppWQpCNfZ06oHQ0FRD2fpl7ZXjeCtQF
         RFO/ju2Snk49d64oCEcKcmp8EFSiAyEzLbMRlYim0oAr6wRwyEr9FMAcHiiU++AFmoQk
         k2TKiFfEiZJlEphkiWGymAun3mSNo1oUeXQiMudTMq+kIzDHhkoKKrPI2hIMj5RJR5XW
         PKVKqCdu522rMzhjLPk+1GzDE3PQuxhMJNHe90r8VR9c3NjgRvAgRlmicAw3ACMwqqcG
         Tz6g==
X-Gm-Message-State: ACrzQf10rMhQPLtZN1MF2FqT6i7vNWW9uvD2Eqi/9le4wtsD1lQzT0Tg
        hxsLSyUNKnkFD+9ES7+/cI7GOT3NBQ8=
X-Google-Smtp-Source: AMsMyM6xV7p0PreDSDgoZJEwVCSaYnDowJaOcPddwxhdvKuXrsIOBcq3Y/THZgRhtk+FLGM0YdL5AA==
X-Received: by 2002:a5d:5988:0:b0:22e:58fe:28cf with SMTP id n8-20020a5d5988000000b0022e58fe28cfmr4605355wri.440.1665783959125;
        Fri, 14 Oct 2022 14:45:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003b49bd61b19sm7684368wmm.15.2022.10.14.14.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:45:58 -0700 (PDT)
Message-Id: <6682938fff8a3bc7c0c4b08fdfd20effc4b2fc66.1665783945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 21:45:43 +0000
Subject: [PATCH v2 11/12] fsmonitor: test updates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

t7527-builtin-fsmonitor was leaking fsmonitor--daemon processes in some
cases.

Accomodate slight difference in the number of events generated on Linux.

On lower-powered systems, spin a little to give the daemon time
to respond to and log filesystem events.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 t/t7527-builtin-fsmonitor.sh | 72 +++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 1746d30cf6a..d27bd3662a7 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -13,7 +13,7 @@ fi
 stop_daemon_delete_repo () {
 	r=$1 &&
 	test_might_fail git -C $r fsmonitor--daemon stop &&
-	rm -rf $1
+	rm -rf $r
 }
 
 start_daemon () {
@@ -72,6 +72,32 @@ start_daemon () {
 	)
 }
 
+IMPLICIT_TIMEOUT=5
+
+wait_for_update () {
+	func=$1 &&
+	file=$2 &&
+	sz=$(wc -c < "$file") &&
+	last=0 &&
+	$func &&
+	k=0 &&
+	while test "$k" -lt $IMPLICIT_TIMEOUT
+	do
+		nsz=$(wc -c < "$file")
+		if test "$nsz" -gt "$sz"
+		then
+			if test "$last" -eq "$nsz"
+			then
+				return 0
+			fi
+			last=$nsz
+		fi
+		sleep 1
+		k=$(( $k + 1 ))
+	done &&
+	return 0
+}
+
 # Is a Trace2 data event present with the given catetory and key?
 # We do not care what the value is.
 #
@@ -137,7 +163,6 @@ test_expect_success 'implicit daemon start' '
 # machines (where it might take a moment to wake and reschedule the
 # daemon process) to avoid false alarms during test runs.)
 #
-IMPLICIT_TIMEOUT=5
 
 verify_implicit_shutdown () {
 	r=$1 &&
@@ -373,6 +398,10 @@ create_files () {
 	echo 3 >dir2/new
 }
 
+rename_directory () {
+	mv dirtorename dirrenamed
+}
+
 rename_files () {
 	mv rename renamed &&
 	mv dir1/rename dir1/renamed &&
@@ -427,10 +456,12 @@ test_expect_success 'edit some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	edit_files &&
+	wait_for_update edit_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dir1/modified$"  .git/trace &&
 	grep "^event: dir2/modified$"  .git/trace &&
 	grep "^event: modified$"       .git/trace &&
@@ -442,10 +473,12 @@ test_expect_success 'create some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	create_files &&
+	wait_for_update create_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dir1/new$" .git/trace &&
 	grep "^event: dir2/new$" .git/trace &&
 	grep "^event: new$"      .git/trace
@@ -456,10 +489,12 @@ test_expect_success 'delete some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	delete_files &&
+	wait_for_update delete_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dir1/delete$" .git/trace &&
 	grep "^event: dir2/delete$" .git/trace &&
 	grep "^event: delete$"      .git/trace
@@ -470,10 +505,12 @@ test_expect_success 'rename some files' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	rename_files &&
+	wait_for_update rename_files "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dir1/rename$"  .git/trace &&
 	grep "^event: dir2/rename$"  .git/trace &&
 	grep "^event: rename$"       .git/trace &&
@@ -487,10 +524,12 @@ test_expect_success 'rename directory' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	mv dirtorename dirrenamed &&
+	wait_for_update rename_directory "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dirtorename/*$" .git/trace &&
 	grep "^event: dirrenamed/*$"  .git/trace
 '
@@ -500,10 +539,12 @@ test_expect_success 'file changes to directory' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	file_to_directory &&
+	wait_for_update file_to_directory "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: delete$"     .git/trace &&
 	grep "^event: delete/new$" .git/trace
 '
@@ -513,10 +554,12 @@ test_expect_success 'directory changes to a file' '
 
 	start_daemon --tf "$PWD/.git/trace" &&
 
-	directory_to_file &&
+	wait_for_update directory_to_file "$PWD/.git/trace" &&
 
 	test-tool fsmonitor-client query --token 0 &&
 
+	test_might_fail git fsmonitor--daemon stop &&
+
 	grep "^event: dir1$" .git/trace
 '
 
@@ -561,7 +604,7 @@ test_expect_success 'flush cached data' '
 	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_2 &&
 	nul_to_q <actual_2 >actual_q2 &&
 
-	grep "^builtin:test_00000002:0Q$" actual_q2 &&
+	grep "^builtin:test_00000002:[0-1]Q$" actual_q2 &&
 
 	>test_flush/file_3 &&
 
@@ -732,7 +775,8 @@ u_values="$u1 $u2"
 for u in $u_values
 do
 	test_expect_success "unicode in repo root path: $u" '
-		test_when_finished "stop_daemon_delete_repo $u" &&
+		test_when_finished \
+		"stop_daemon_delete_repo `echo "$u" | sed 's:x:\\\\\\\\\\\\\\x:g'`" &&
 
 		git init "$u" &&
 		echo 1 >"$u"/file1 &&
@@ -814,8 +858,7 @@ my_match_and_clean () {
 }
 
 test_expect_success 'submodule always visited' '
-	test_when_finished "git -C super fsmonitor--daemon stop; \
-			    rm -rf super; \
+	test_when_finished "rm -rf super; \
 			    rm -rf sub" &&
 
 	create_super super &&
@@ -883,7 +926,8 @@ have_t2_error_event () {
 }
 
 test_expect_success "stray submodule super-prefix warning" '
-	test_when_finished "rm -rf super; \
+	test_when_finished "git -C super/dir_1/dir_2/sub fsmonitor--daemon stop; \
+			    rm -rf super; \
 			    rm -rf sub;   \
 			    rm super-sub.trace" &&
 
-- 
gitgitgadget

