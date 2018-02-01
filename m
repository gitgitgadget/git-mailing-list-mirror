Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459591F576
	for <e@80x24.org>; Thu,  1 Feb 2018 10:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBAKPR (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 05:15:17 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41131 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeBAKPH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 05:15:07 -0500
Received: by mail-wr0-f194.google.com with SMTP id v15so18289317wrb.8
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 02:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=So35UbupxFzygiOtATiXmMmyhIOxAZcjPXA4Owol6dY=;
        b=E/sZW0l7FAn6K+Yb8wCZWDR3cxZWGTptic6FXWOQehXHZxDn/oIdGjnGt8G8on0XCk
         aetDgGLS/AuQrMLTLHfK0nYD3X8mEX0XGMgyZJud2Mwid6OMOrnwnFYgP1lznkdX8qvU
         do3hsLNAXSr6JxJ+qyxQPlTH/IaC2mSQOpVOWT+zXETRwdpvacv9M40dUVgAYEja9KCe
         hotWaMAaHR8i+PWSSinajDNXv/ZMHWMHJIezeW0urVWYJ8RqMM8cWrd0TjajB7zuQOc5
         Mjmhr/OPh8tsqN0xe+Jrb8el0BvaSesxJPlH7nNj1In3md4cuThTUgpuw6KnAEkAkZ5c
         leXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=So35UbupxFzygiOtATiXmMmyhIOxAZcjPXA4Owol6dY=;
        b=uRNjCIMQz0Im4427YWlBU8tjPZkdRR43AbW63Opbs3JVTnsAcSgBxJ5MpLIdxlL0QZ
         Ex6ftSSpyJYGFyyHW5q9TiHRE9H0MFTD0T2kR5Nonde7877RvOx4V/n+b9TDh92CW8/f
         Jr5QOOKfXAdq/Z+ZwgX4ucj2UPrrHvqE66GJda4KwrK93fZ1oSlvLshYpNUIGDb36u2b
         C31HPz2c+Rdz0cwOn4naKDlU2SvHjspE9HDsI54dccoKD4ubMUW6Tt11ZJzfcE/kMail
         cUozgxoSH/uMucCnppF0uNeruINvZ3EzBfefI/1Bk1UX7b4KG3mfC5xPJPB9NyscATOG
         GUiA==
X-Gm-Message-State: AKwxytcdu4MD0MgIzVggK/pYxW7VXlMvhZhn0ykwmhBuFonprvk+akap
        ovMm0PThleTQn5W5By8Vqxrdlws1
X-Google-Smtp-Source: AH8x225SCYUmXKbgMiuTLr0I44ege2Q+PqDkRdDKuwJIkV9c8LOC3uu8GkQw5NYGqO0YLLt21YbVQA==
X-Received: by 10.223.131.230 with SMTP id 93mr7793516wre.59.1517480105405;
        Thu, 01 Feb 2018 02:15:05 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id e16sm21203466wre.5.2018.02.01.02.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2018 02:15:01 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 2/3] perf/aggregate: add --reponame option
Date:   Thu,  1 Feb 2018 11:14:33 +0100
Message-Id: <20180201101434.5383-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc2.45.g09a1bbd803
In-Reply-To: <20180201101434.5383-1-chriscool@tuxfamily.org>
References: <20180201101434.5383-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easier to use the aggregate script
on the command line when one wants to get the
"environment" fields set in the codespeed output.

Previously setting GIT_REPO_NAME was needed
for this purpose.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/aggregate.perl | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

The only change compared to v1 is a logical change suggested by Eric
in the 'if ... elsif ... else ...' sequence that sets $environment.

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index bbf0f30898..a609292491 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -37,7 +37,7 @@ sub format_times {
 }
 
 my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
-    $codespeed, $subsection);
+    $codespeed, $subsection, $reponame);
 while (scalar @ARGV) {
 	my $arg = $ARGV[0];
 	my $dir;
@@ -55,6 +55,15 @@ while (scalar @ARGV) {
 		}
 		next;
 	}
+	if ($arg eq "--reponame") {
+		shift @ARGV;
+		$reponame = $ARGV[0];
+		shift @ARGV;
+		if (! $reponame) {
+			die "empty reponame";
+		}
+		next;
+	}
 	last if -f $arg or $arg eq "--";
 	if (! -d $arg) {
 		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg);
@@ -210,7 +219,9 @@ sub print_codespeed_results {
 	}
 
 	my $environment;
-	if (exists $ENV{GIT_PERF_REPO_NAME} and $ENV{GIT_PERF_REPO_NAME} ne "") {
+	if ($reponame) {
+		$environment = $reponame;
+	} elsif (exists $ENV{GIT_PERF_REPO_NAME} and $ENV{GIT_PERF_REPO_NAME} ne "") {
 		$environment = $ENV{GIT_PERF_REPO_NAME};
 	} elsif (exists $ENV{GIT_TEST_INSTALLED} and $ENV{GIT_TEST_INSTALLED} ne "") {
 		$environment = $ENV{GIT_TEST_INSTALLED};
-- 
2.16.0.rc2.45.g09a1bbd803

