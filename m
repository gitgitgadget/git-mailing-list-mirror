Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A38C71F576
	for <e@80x24.org>; Sun, 28 Jan 2018 11:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeA1LTL (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 06:19:11 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40296 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeA1LTK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 06:19:10 -0500
Received: by mail-wm0-f66.google.com with SMTP id v123so28537352wmd.5
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 03:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FojL1WIOakXw3MP0RwOHVvDBrfGy1xFALAm3JDybqms=;
        b=U1wOmUkbtjZWxZELmov0XC1nHmcevAfQA2wobiwTYJ3PeGq4o6/vHAQzJKtOE9TVXP
         lEPmeN/D5G/4drGSCvGjt+AFFQT7J4yNfPRhKI9RHUQu0kjagXsuorFcFGXmJfrQqVbL
         re9nDeYoGz+WQCT64xj+RDf9fp6GL4vKiSbitu+8M5SWEAAME2bFt39oexXsQd9x+soF
         J6Vqxuwy80gGtVQp+ER2tUKquECRXD0K+ziQyC+BBrIacI5n/4281vz0R/hNlkA+Mkuc
         W/TvozLfOJDEZH5cRU99T5meetn9oIo5AtgkVUOes1Knzvfj+LUlF6FbzFIAVT0IJ7tR
         GRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FojL1WIOakXw3MP0RwOHVvDBrfGy1xFALAm3JDybqms=;
        b=QEkFoaLJB5XwSlgEaZuMZ2H4TyWuBwxMWTCpdym/0+YSj0URblbc0gS36CWj8sEm1z
         lG0UqsW2TetLdCadg591dB0Bh1x0zlMBjmTKF4KHVhrpdHu8dfG+/65OrGe1t/CnQbt6
         spyHmv7G9chZ52NPs+vGHxL4pIK/Mb7MyfP2ja5HghO6Ra7kDQMARukHPsqUJwPbS9Kd
         XiaQoaU3gOB4/4kj6kGJ0WYThK05t9AgPI4hw2h7o49nTLiIt/qk46a3ZKFmcEMhaIr7
         /ARKcdeQkBnxIHi/41i61+l2un9lo3rM4zjOjDyWu4q7AHLcGxR/qbYIqohcd8mlrUrn
         C3cw==
X-Gm-Message-State: AKwxytchu46xZzJijuA74eGCQ1p0jCm1V/V0gsUOU3lXsv6+bExJXZMs
        WUOuOIdBDTjArhLbyyEbe4twFX2q
X-Google-Smtp-Source: AH8x2250uttFVBhbY9Jnnbvnk3u8o6eiVtou9viwV5zTLyvXgsasYY6/VSeEetEBkmT40uKMr4IofA==
X-Received: by 10.28.241.4 with SMTP id p4mr14029584wmh.103.1517138348510;
        Sun, 28 Jan 2018 03:19:08 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id 123sm8343306wmt.31.2018.01.28.03.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jan 2018 03:19:07 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 1/3] perf/aggregate: add --subsection option
Date:   Sun, 28 Jan 2018 12:18:41 +0100
Message-Id: <20180128111843.2690-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc2.45.g09a1bbd803
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easier to use the aggregate script
on the command line, to get results from
subsections.

Previously setting GIT_PERF_SUBSECTION was needed
for this purpose.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

This small patch series contains a few small Codespeed related
usability improvements of the perf/aggregate.perl script on top the
cc/codespeed patch series that was recently merged into master.

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 5c439f6bc2..bbf0f30898 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -36,7 +36,8 @@ sub format_times {
 	return $out;
 }
 
-my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests, $codespeed);
+my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
+    $codespeed, $subsection);
 while (scalar @ARGV) {
 	my $arg = $ARGV[0];
 	my $dir;
@@ -45,6 +46,15 @@ while (scalar @ARGV) {
 		shift @ARGV;
 		next;
 	}
+	if ($arg eq "--subsection") {
+		shift @ARGV;
+		$subsection = $ARGV[0];
+		shift @ARGV;
+		if (! $subsection) {
+			die "empty subsection";
+		}
+		next;
+	}
 	last if -f $arg or $arg eq "--";
 	if (! -d $arg) {
 		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
@@ -76,10 +86,15 @@ if (not @tests) {
 }
 
 my $resultsdir = "test-results";
-my $results_section = "";
-if (exists $ENV{GIT_PERF_SUBSECTION} and $ENV{GIT_PERF_SUBSECTION} ne "") {
-	$resultsdir .= "/" . $ENV{GIT_PERF_SUBSECTION};
-	$results_section = $ENV{GIT_PERF_SUBSECTION};
+
+if (! $subsection and
+    exists $ENV{GIT_PERF_SUBSECTION} and
+    $ENV{GIT_PERF_SUBSECTION} ne "") {
+	$subsection = $ENV{GIT_PERF_SUBSECTION};
+}
+
+if ($subsection) {
+	$resultsdir .= "/" . $subsection;
 }
 
 my @subtests;
@@ -183,15 +198,15 @@ sub print_default_results {
 }
 
 sub print_codespeed_results {
-	my ($results_section) = @_;
+	my ($subsection) = @_;
 
 	my $project = "Git";
 
 	my $executable = `uname -s -m`;
 	chomp $executable;
 
-	if ($results_section ne "") {
-		$executable .= ", " . $results_section;
+	if ($subsection) {
+		$executable .= ", " . $subsection;
 	}
 
 	my $environment;
@@ -233,7 +248,7 @@ sub print_codespeed_results {
 binmode STDOUT, ":utf8" or die "PANIC on binmode: $!";
 
 if ($codespeed) {
-	print_codespeed_results($results_section);
+	print_codespeed_results($subsection);
 } else {
 	print_default_results();
 }
-- 
2.16.0.rc2.45.g09a1bbd803

