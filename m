Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 408931F45F
	for <e@80x24.org>; Tue,  7 May 2019 10:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfEGKyz (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 06:54:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39070 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfEGKyw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 06:54:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so19338541wmk.4
        for <git@vger.kernel.org>; Tue, 07 May 2019 03:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hwa5xJQ16DY1uw/atMN39+S60AY43cJIKB68B+mCnwg=;
        b=lYluDBN8gGpBcmgb8S5feFNYnPzC+UC1bEXbkze2I41R51aj3725zMiGPps7akCSqA
         bbFPudDW9Z4NIDRLocacAMhOTN//Zxkn9J5FVvewO9QWyR7mUhAu7TQjLGhjqX/KsUA6
         gnKuZufmhX37m71NQu/yZYYOlyrspYupg9buRHqUsjC+rj/VvH7oxX2xl4A+vqH5h9k3
         SKvdTinXhhfsBPIF99kHLjMbOpoCL21gZGBV2l82UGK7OMkJjs1hh0W8ttVCH6iPS1ax
         bi4iA5187HhcTmZKfG+fEplick85uFMpzPg4rsnQx/nguP5xwGQy8+EjLNgfJ1lOWSSK
         4Ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hwa5xJQ16DY1uw/atMN39+S60AY43cJIKB68B+mCnwg=;
        b=Vd5UYd4rr/OWIrgd4YutQG7MJGxeB+6l0ND/Y55EKX1Kl4983PeF+MXBa3v2Nr5ya+
         0adylfGj1rXSv53u6Eq9Rr5RYVlJKs8mniZfuDpypDjmGWAG10G5WgZleW4FydbH2yQY
         16daDHL/dtcyuJ5U6asTc4YQdXH9EnBrIMuF8ze74rPwrS/M2jLDDHBmhB7wUaq7niAh
         /TPaIcq7OlWr8gmcieYSGONQCEBbRj95YfF9f7BGfdFrwAFptwufey2/kZkLBpkv05+w
         toueyqOuI15kDAnkXf7RZSxhy5ta5QIHXCbiKu2IwEgE+/zJ+5VLzC4xA/3YqH15fSDO
         mwKg==
X-Gm-Message-State: APjAAAXi9M0nsFa3QmVIz3QoRltV8Lg1TlBt7VgyLhWZK9O2ZZAEiNfw
        DSaZEiy6IKsx43KVPuf4lbQlkKz3EEY=
X-Google-Smtp-Source: APXvYqweh529ZNaF8j10p0ezURiT7GFe67Kzygx+hVagL1wyQKwpjprI7gKAH+W7td6Xap7xVa2k3A==
X-Received: by 2002:a1c:2e88:: with SMTP id u130mr13106575wmu.54.1557226490242;
        Tue, 07 May 2019 03:54:50 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm11029573wmb.12.2019.05.07.03.54.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 03:54:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/6] perf-lib.sh: remove GIT_TEST_INSTALLED from perf-lib.sh
Date:   Tue,  7 May 2019 12:54:32 +0200
Message-Id: <20190507105434.9600-5-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190506232309.28538-1-avarab@gmail.com>
References: <20190506232309.28538-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up my preceding change which fixed the immediate "./run
<revisions>" regression in 0baf78e7bc ("perf-lib.sh: rely on
test-lib.sh for --tee handling", 2019-03-15) and entirely get rid of
GIT_TEST_INSTALLED from perf-lib.sh (and aggregate.perl).

As noted in that change the dance we're doing with GIT_TEST_INSTALLED
perf-lib.sh isn't necessary, but there I was doing the most minimal
set of changes to quickly fix a regression.

But it's much simpler to never deal with the "GIT_TEST_INSTALLED" we
were setting in perf-lib.sh at all. Instead the run_dirs_helper() sets
the previously inferred $PERF_RESULTS_PREFIX directly.

Setting this at the callsite that's already best positioned to
exhaustively know about all the different cases we need to handle
where PERF_RESULTS_PREFIX isn't what we want already (the empty
string) makes the most sense. In one-off cases like:

    ./run ./p0000-perf-lib-sanity.sh
    ./p0000-perf-lib-sanity.sh

We'll just do the right thing because PERF_RESULTS_PREFIX will be
empty, and test-lib.sh takes care of finding where our git is.

Any refactoring of this code needs to change both the shell code and
the Perl code in aggregate.perl, because when running e.g.:

    ./run ../../ -- <test>

The "../../" path to a relative bindir needs to be munged to a
filename containing the results, and critically aggregate.perl does
not get passed the path to those aggregations, just "../..".

Let's fix cases where aggregate.perl would print e.g. ".." in its
report output for this, and "git" for "/home/avar/g/git", i.e. it
would always pick the last element. Now'll always print the full path
instead.

This also makes the code sturdier, e.g. you can feed "../.."  to
"./run" and then an absolute path to the aggregate.perl script, as
long as the absolute path and "../.." resolved to the same directory
printing the aggregation will work.

Also simplify the "[_*]" on the RHS of "tr -c", we're trimming
everything to "_", so we don't need that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/aggregate.perl | 10 ++++++----
 t/perf/perf-lib.sh    | 15 +--------------
 t/perf/run            | 45 +++++++++++++++++++++++++++++--------------
 3 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index f6518339dc..c8f4a78903 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -6,6 +6,7 @@
 use JSON;
 use Getopt::Long;
 use Git;
+use Cwd qw(realpath);
 
 sub get_times {
 	my $name = shift;
@@ -103,13 +104,14 @@ sub format_size {
 	if (! -d $arg) {
 		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
 		$dir = "build/".$rev;
+	} elsif ($arg eq '.') {
+		$dir = '.';
 	} else {
-		$arg =~ s{/*$}{};
-		$dir = $arg;
-		$dirabbrevs{$dir} = $dir;
+		$dir = realpath($arg);
+		$dirnames{$dir} = $dir;
 	}
 	push @dirs, $dir;
-	$dirnames{$dir} = $arg;
+	$dirnames{$dir} ||= $arg;
 	my $prefix = $dir;
 	$prefix =~ tr/^a-zA-Z0-9/_/c;
 	$prefixes{$dir} = $prefix . '.';
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index b15ee1d262..9cdccba222 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -21,25 +21,12 @@
 # because it will change our working directory.
 TEST_DIRECTORY=$(pwd)/..
 TEST_OUTPUT_DIRECTORY=$(pwd)
-ABSOLUTE_GIT_TEST_INSTALLED=$(
-	test -n "$GIT_TEST_INSTALLED" && cd "$GIT_TEST_INSTALLED" && pwd)
 
 TEST_NO_CREATE_REPO=t
 TEST_NO_MALLOC_CHECK=t
 
 . ../test-lib.sh
 
-if test -z "$GIT_TEST_INSTALLED"; then
-	perf_results_prefix=
-else
-	if test -n "$GIT_PERF_DIR_MYDIR_REL"
-	then
-		GIT_TEST_INSTALLED=$GIT_PERF_DIR_MYDIR_REL
-	fi
-	perf_results_prefix=$(printf "%s" "${GIT_TEST_INSTALLED%/bin-wrappers}" | tr -c "[a-zA-Z0-9]" "[_*]")"."
-	GIT_TEST_INSTALLED=$ABSOLUTE_GIT_TEST_INSTALLED
-fi
-
 # Variables from test-lib that are normally internal to the tests; we
 # need to export them for test_perf subshells
 export TEST_DIRECTORY TRASH_DIRECTORY GIT_BUILD_DIR GIT_TEST_CMP
@@ -183,7 +170,7 @@ test_wrapper_ () {
 		base=$(basename "$0" .sh)
 		echo "$test_count" >>"$perf_results_dir"/$base.subtests
 		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
-		base="$perf_results_dir"/"$perf_results_prefix$(basename "$0" .sh)"."$test_count"
+		base="$perf_results_dir"/"$PERF_RESULTS_PREFIX$(basename "$0" .sh)"."$test_count"
 		"$test_wrapper_func_" "$@"
 	fi
 
diff --git a/t/perf/run b/t/perf/run
index 0a7c8744ab..85b7bd31d5 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -70,6 +70,22 @@ build_git_rev () {
 	) || die "failed to build revision '$mydir'"
 }
 
+set_git_test_installed () {
+	mydir=$1
+
+	mydir_abs=$(cd $mydir && pwd)
+	mydir_abs_wrappers="$mydir_abs_wrappers/bin-wrappers"
+	if test -d "$mydir_abs_wrappers"
+	then
+		GIT_TEST_INSTALLED=$mydir_abs_wrappers
+	else
+		# Older versions of git lacked bin-wrappers;
+		# fallback to the files in the root.
+		GIT_TEST_INSTALLED=$mydir_abs
+	fi
+	export GIT_TEST_INSTALLED
+}
+
 run_dirs_helper () {
 	mydir=${1%/}
 	shift
@@ -79,7 +95,16 @@ run_dirs_helper () {
 	if test $# -gt 0 -a "$1" = --; then
 		shift
 	fi
-	if [ ! -d "$mydir" ]; then
+
+	PERF_RESULTS_PREFIX=
+	if test "$mydir" = "."
+	then
+		unset GIT_TEST_INSTALLED
+	elif test -d "$mydir"
+	then
+		PERF_RESULTS_PREFIX=$(cd $mydir && printf "%s" "$(pwd)" | tr -c "[a-zA-Z0-9]" "_").
+		set_git_test_installed "$mydir"
+	else
 		rev=$(git rev-parse --verify "$mydir" 2>/dev/null) ||
 		die "'$mydir' is neither a directory nor a valid revision"
 		if [ ! -d build/$rev ]; then
@@ -87,20 +112,12 @@ run_dirs_helper () {
 		fi
 		build_git_rev $rev "$mydir"
 		mydir=build/$rev
+
+		PERF_RESULTS_PREFIX=build_$rev.
+		set_git_test_installed "$mydir"
 	fi
-	if test "$mydir" = .; then
-		unset GIT_TEST_INSTALLED
-	else
-		GIT_PERF_DIR_MYDIR_REL=$mydir
-		GIT_PERF_DIR_MYDIR_ABS=$(cd $mydir && pwd)
-		export GIT_PERF_DIR_MYDIR_REL GIT_PERF_DIR_MYDIR_ABS
-
-		GIT_TEST_INSTALLED="$GIT_PERF_DIR_MYDIR_ABS/bin-wrappers"
-		# Older versions of git lacked bin-wrappers; fallback to the
-		# files in the root.
-		test -d "$GIT_TEST_INSTALLED" || GIT_TEST_INSTALLED=$GIT_PERF_DIR_MYDIR_ABS
-		export GIT_TEST_INSTALLED
-	fi
+	export PERF_RESULTS_PREFIX
+
 	run_one_dir "$@"
 }
 
-- 
2.21.0.593.g511ec345e18

