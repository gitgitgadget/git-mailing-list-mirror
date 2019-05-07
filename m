Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C92431F45F
	for <e@80x24.org>; Tue,  7 May 2019 10:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfEGKy7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 06:54:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44229 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfEGKyx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 06:54:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so21649376wrs.11
        for <git@vger.kernel.org>; Tue, 07 May 2019 03:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s4Mfykpi87xB+OQ/fi3V5JFSPZTyfCWOqBf+58w4I0w=;
        b=a66fH3r+pPtTrSEDQSXgV777uZCQZT0aQCgg/ThO7hu/3izD/z2HJr8MlTmtN46plK
         5aCky9OwLyqhgxS1FuYVykDnBbduB/Y1kNRTA+pBRoGp/hIxlfZsN9EiqrkUMT95xWMN
         azsvLVxOfJgamitnU7nMcW1t2sxKNRpRBE1iF5iCg7RJFUU6WfZ4BTAsQvitZhxufNNn
         XoGBWXQlIH1UKRpYYhxaiIC0cI31MJh1dZ+Q6+z7dpGFIcdNXrhH+MgggsZfd0fIukt5
         ahHG/eCsVtqtKDF+SzQlnBKV0f7EqhivPO3ECq+le13lzUIZDxsXx4b/NOYvqT15WlSr
         1jDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s4Mfykpi87xB+OQ/fi3V5JFSPZTyfCWOqBf+58w4I0w=;
        b=aH/dA7KDHBgDCka5V47l9t5oWOehw4ep/EVN6n7Ad7K7+vKyOXvLboMfKgjw+7I1J3
         Gydiz1kaQKJU8hz0YHVPu92QF71VtRY9JTPBAhyvcCecvpD56zupYKNduvJ4CcuDuLUn
         w5trH7Mh3PomFi5FCW4inGaSmpp7k8rfMdJ5YkzIiI/ZCUa65PLmW8Zw9dyfh/qSkJnX
         lvgDrc0yxgKcfInYFJRqkIHdJN1u9cjhpZYW6PkL+BNWDLd6QfIDqUpLdr5OX8bpDY7Q
         a6WP0ZtZ1NR8wmQTBNOEU/PLGmOtl/GiAGduJGpgyL33vtWrRHfPOdy8i9UVN1auEqYN
         O2pw==
X-Gm-Message-State: APjAAAUaeh67O2TUmi++2D9K5f7s0vQeNjISGoPC8xGRh8umDkO6tOIJ
        ldJbQKYcVnSbGyTrpR0m5DkjsFjRFD0=
X-Google-Smtp-Source: APXvYqxgGJJ4kGKW9hEiGUH0yA4FaNs/BFrz6cCoghxcge20E7SBtWUvxese9EOqtZ87uofQCcUqgA==
X-Received: by 2002:adf:e883:: with SMTP id d3mr17957925wrm.232.1557226491930;
        Tue, 07 May 2019 03:54:51 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm11029573wmb.12.2019.05.07.03.54.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 03:54:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/6] perf tests: add "bindir" prefix to git tree test results
Date:   Tue,  7 May 2019 12:54:33 +0200
Message-Id: <20190507105434.9600-6-avarab@gmail.com>
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

Change the output file names in test-results/ to be
"test-results/bindir_<munged dir>" rather than just
"test-results/<munged dir>".

This is for consistency with the "build_" directories we have for
built revisions, i.e. "test-results/build_<SHA-1>".

There's no user-visible functional changes here, it just makes it
easier to see at a glance what "test-results" files are of what "type"
as they're all explicitly grouped together now, and to grep this code
to find both the run_dirs_helper() implementation and its
corresponding aggregate.perl code.

Note that we already guarantee that the rest of the
PERF_RESULTS_PREFIX is an absolute path, and since it'll start with
e.g. "/" which we munge to "_" we'll up with a readable string like
"bindir_home_avar[...]".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/aggregate.perl | 4 +++-
 t/perf/run            | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index c8f4a78903..b951747e08 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -100,6 +100,7 @@ sub format_size {
 while (scalar @ARGV) {
 	my $arg = $ARGV[0];
 	my $dir;
+	my $prefix = '';
 	last if -f $arg or $arg eq "--";
 	if (! -d $arg) {
 		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
@@ -109,10 +110,11 @@ sub format_size {
 	} else {
 		$dir = realpath($arg);
 		$dirnames{$dir} = $dir;
+		$prefix .= 'bindir';
 	}
 	push @dirs, $dir;
 	$dirnames{$dir} ||= $arg;
-	my $prefix = $dir;
+	$prefix .= $dir;
 	$prefix =~ tr/^a-zA-Z0-9/_/c;
 	$prefixes{$dir} = $prefix . '.';
 	shift @ARGV;
diff --git a/t/perf/run b/t/perf/run
index 85b7bd31d5..cd3882b117 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -102,7 +102,7 @@ run_dirs_helper () {
 		unset GIT_TEST_INSTALLED
 	elif test -d "$mydir"
 	then
-		PERF_RESULTS_PREFIX=$(cd $mydir && printf "%s" "$(pwd)" | tr -c "[a-zA-Z0-9]" "_").
+		PERF_RESULTS_PREFIX=bindir$(cd $mydir && printf "%s" "$(pwd)" | tr -c "[a-zA-Z0-9]" "_").
 		set_git_test_installed "$mydir"
 	else
 		rev=$(git rev-parse --verify "$mydir" 2>/dev/null) ||
-- 
2.21.0.593.g511ec345e18

