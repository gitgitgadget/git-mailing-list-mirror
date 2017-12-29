Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60D7C1F404
	for <e@80x24.org>; Fri, 29 Dec 2017 22:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750815AbdL2W7P (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 17:59:15 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42774 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdL2W7O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 17:59:14 -0500
Received: by mail-wr0-f195.google.com with SMTP id w107so16820080wrb.9
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 14:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BgE/l/MBoxYe0NjiFukNF0/LcEKI/WOY6yutSu6A7R8=;
        b=ZyJZg50OTYCIW2jHr8uB/GcKN9osZQnyjdil8HnZsmMuwwAInydqIyexPViyQQgElx
         DM4YsDvIEKioGge6JAubLqw7ANFqk1GRxs0gXMrhAwBjii001cPSuCOYtWr95FqVVLaw
         3+umylh2NAhaJyS3yTZQ9q03Sn0DPUYiiRbeynE2iP3QHHBTqOSPrfB57S8qukIq5m5B
         PqXu+gYh4SPLzoI4zjtl0LNVGdhCSUTup7TNXBoIQPSyu1ekZ4xgo9xgYYQWHM8QTPqk
         ucAK6polEKnI7j14rewNK80OfTlYDklXUtLQqv2Keunp0NerfFWA6r6z1fsMaZAOUx+e
         r0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BgE/l/MBoxYe0NjiFukNF0/LcEKI/WOY6yutSu6A7R8=;
        b=G8p8gzG5BgI36b2nOnIl3Sg0CY27++kFyUCmBdTOvzwsJEPgesaka9gVNw1tk9vPpe
         b2eLMAxE1XRrsMxlis2tMDySC3M5+i3h6GYo+UUeY7rKEZBKdeYM9T6Nlzrx+TNPYSp5
         GHoD8rhatFV+a1XBwE7Cq0o3EPdWzpH+BkAz805tesmNFD7bCvxj71BQmzcYDJzB7Y29
         FNPxymG24Ztzl5NBmSnW3mRQXoi4GJ04/DQiObB6BcDCBU25kFUe70gZQbMnDKqqiCRX
         xRGpYXB0r+8T87r+w5xUPgfAJYKvD88LaJjatrSCNiQzHImsm3DGfhqiAC4WjgCJgtEE
         Vqhw==
X-Gm-Message-State: AKGB3mKMq2FGP3v6X6wEqHa8xBizsqZgfJ+AvsiKpjn0ut/5uRGuekJ5
        ykiZ2mDqlu/YLmQCsoi2xNlukDp9
X-Google-Smtp-Source: ACJfBov6VkAibTp/dUhSd9U3n78+eGfPzgc2flhltA5gdG7OQD7EMUYPSBaO8FIsS+aZnwrc08BDYA==
X-Received: by 10.223.163.141 with SMTP id l13mr34822007wrb.136.1514588352510;
        Fri, 29 Dec 2017 14:59:12 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id x75sm16688458wme.44.2017.12.29.14.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Dec 2017 14:59:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] perf: amend the grep tests to test grep.threads
Date:   Fri, 29 Dec 2017 22:59:03 +0000
Message-Id: <20171229225903.19688-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since 5b594f457a ("Threaded grep", 2010-01-25) the number of
threads git-grep uses under PTHREADS has been hardcoded to 8, but
there's no performance test to check whether this is an optimal
setting.

Amend the existing tests for the grep engines to support a mode where
this can be tested, e.g.:

    GIT_PERF_GREP_THREADS='1 8 16' GIT_PERF_LARGE_REPO=~/g/linux ./run p782*

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This looks less scary under diff -w.

 t/perf/p7820-grep-engines.sh       | 52 ++++++++++++++++++++++++++++-------
 t/perf/p7821-grep-engines-fixed.sh | 55 ++++++++++++++++++++++++++++++--------
 2 files changed, 86 insertions(+), 21 deletions(-)

diff --git a/t/perf/p7820-grep-engines.sh b/t/perf/p7820-grep-engines.sh
index 62aba19e76..8b09c5bf32 100755
--- a/t/perf/p7820-grep-engines.sh
+++ b/t/perf/p7820-grep-engines.sh
@@ -12,6 +12,9 @@ e.g. GIT_PERF_7820_GREP_OPTS=' -i'. Some options to try:
 	-vi
 	-vw
 	-viw
+
+If GIT_PERF_GREP_THREADS is set to a list of threads (e.g. '1 4 8'
+etc.) we will test the patterns under those numbers of threads.
 "
 
 . ./perf-lib.sh
@@ -19,6 +22,11 @@ e.g. GIT_PERF_7820_GREP_OPTS=' -i'. Some options to try:
 test_perf_large_repo
 test_checkout_worktree
 
+if test -n "$GIT_PERF_GREP_THREADS"
+then
+	test_set_prereq PERF_GREP_ENGINES_THREADS
+fi
+
 for pattern in \
 	'how.to' \
 	'^how to' \
@@ -39,18 +47,42 @@ do
 		else
 			prereq=""
 		fi
-		test_perf $prereq "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern'" "
-			git -c grep.patternType=$engine grep$GIT_PERF_7820_GREP_OPTS -- '$pattern' >'out.$engine' || :
-		"
-	done
-
-	test_expect_success "assert that all engines found the same for$GIT_PERF_7820_GREP_OPTS '$pattern'" '
-		test_cmp out.basic out.extended &&
-		if test_have_prereq PCRE
+		if ! test_have_prereq PERF_GREP_ENGINES_THREADS
 		then
-			test_cmp out.basic out.perl
+			test_perf $prereq "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern'" "
+				git -c grep.patternType=$engine grep$GIT_PERF_7820_GREP_OPTS -- '$pattern' >'out.$engine' || :
+			"
+		else
+			for threads in $GIT_PERF_GREP_THREADS
+			do
+				test_perf PTHREADS,$prereq "$engine grep$GIT_PERF_7820_GREP_OPTS '$pattern' with $threads threads" "
+					git -c grep.patternType=$engine -c grep.threads=$threads grep$GIT_PERF_7820_GREP_OPTS -- '$pattern' >'out.$engine.$threads' || :
+				"
+			done
 		fi
-	'
+	done
+
+	if ! test_have_prereq PERF_GREP_ENGINES_THREADS
+	then
+		test_expect_success "assert that all engines found the same for$GIT_PERF_7820_GREP_OPTS '$pattern'" '
+			test_cmp out.basic out.extended &&
+			if test_have_prereq PCRE
+			then
+				test_cmp out.basic out.perl
+			fi
+		'
+	else
+		for threads in $GIT_PERF_GREP_THREADS
+		do
+			test_expect_success PTHREADS "assert that all engines found the same for$GIT_PERF_7820_GREP_OPTS '$pattern' under threading" "
+				test_cmp out.basic.$threads out.extended.$threads &&
+				if test_have_prereq PCRE
+				then
+					test_cmp out.basic.$threads out.perl.$threads
+				fi
+			"
+		done
+	fi
 done
 
 test_done
diff --git a/t/perf/p7821-grep-engines-fixed.sh b/t/perf/p7821-grep-engines-fixed.sh
index c7ef1e198f..61e41b82cf 100755
--- a/t/perf/p7821-grep-engines-fixed.sh
+++ b/t/perf/p7821-grep-engines-fixed.sh
@@ -6,6 +6,9 @@ Set GIT_PERF_7821_GREP_OPTS in the environment to pass options to
 git-grep. Make sure to include a leading space,
 e.g. GIT_PERF_7821_GREP_OPTS=' -w'. See p7820-grep-engines.sh for more
 options to try.
+
+If GIT_PERF_7821_THREADS is set to a list of threads (e.g. '1 4 8'
+etc.) we will test the patterns under those numbers of threads.
 "
 
 . ./perf-lib.sh
@@ -13,6 +16,11 @@ options to try.
 test_perf_large_repo
 test_checkout_worktree
 
+if test -n "$GIT_PERF_GREP_THREADS"
+then
+	test_set_prereq PERF_GREP_ENGINES_THREADS
+fi
+
 for pattern in 'int' 'uncommon' 'æ'
 do
 	for engine in fixed basic extended perl
@@ -23,19 +31,44 @@ do
 		else
 			prereq=""
 		fi
-		test_perf $prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" "
-			git -c grep.patternType=$engine grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine' || :
-		"
-	done
-
-	test_expect_success "assert that all engines found the same for$GIT_PERF_7821_GREP_OPTS $pattern" '
-		test_cmp out.fixed out.basic &&
-		test_cmp out.fixed out.extended &&
-		if test_have_prereq PCRE
+		if ! test_have_prereq PERF_GREP_ENGINES_THREADS
 		then
-			test_cmp out.fixed out.perl
+			test_perf $prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern" "
+				git -c grep.patternType=$engine grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine' || :
+			"
+		else
+			for threads in $GIT_PERF_GREP_THREADS
+			do
+				test_perf PTHREADS,$prereq "$engine grep$GIT_PERF_7821_GREP_OPTS $pattern with $threads threads" "
+					git -c grep.patternType=$engine -c grep.threads=$threads grep$GIT_PERF_7821_GREP_OPTS $pattern >'out.$engine.$threads' || :
+				"
+			done
 		fi
-	'
+	done
+
+	if ! test_have_prereq PERF_GREP_ENGINES_THREADS
+	then
+		test_expect_success "assert that all engines found the same for$GIT_PERF_7821_GREP_OPTS $pattern" '
+			test_cmp out.fixed out.basic &&
+			test_cmp out.fixed out.extended &&
+			if test_have_prereq PCRE
+			then
+				test_cmp out.fixed out.perl
+			fi
+		'
+	else
+		for threads in $GIT_PERF_GREP_THREADS
+		do
+			test_expect_success PTHREADS "assert that all engines found the same for$GIT_PERF_7821_GREP_OPTS $pattern under threading" "
+				test_cmp out.fixed.$threads out.basic.$threads &&
+				test_cmp out.fixed.$threads out.extended.$threads &&
+				if test_have_prereq PCRE
+				then
+					test_cmp out.fixed.$threads out.perl.$threads
+				fi
+			"
+		done
+	fi
 done
 
 test_done
-- 
2.15.1.424.g9478a66081

