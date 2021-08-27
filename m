Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B559EC432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 00:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97F2660FE6
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 00:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhH1ADp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 20:03:45 -0400
Received: from avasout03.plus.net ([84.93.230.244]:37138 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhH1ADo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 20:03:44 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Aug 2021 20:03:26 EDT
Received: from [10.0.2.15] ([195.213.6.54])
        by smtp with ESMTPA
        id JllJmWj4Es9JuJllKmcZIZ; Sat, 28 Aug 2021 00:59:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1630108794; bh=c+Wu04IKYV8czj4+C8nneM9TEsRBDOGVOP6Nw+UmHi8=;
        h=To:Cc:From:Subject:Date;
        b=KR0I1CBmt+HmjcFQLWt3o2BlKdjZXxQqOCjKFdTJDs2K1vHaW+zfma03vi4mxlAOK
         XhMQJRbmT6y+teTKNlEykLg1K4xYJqb4ZmdlAnnRDn/c8kaMgMzQnqI+0JUWkv4jjk
         bLO41ttCDEidspH7BZAi0IXTykRk+zq5kH705FPlFJkBwPJ08Lt8Axb1BWpsSRAOtj
         IW1r8bgq7Xml4AlTJzE/WGKeVX57ULNcUXJe3jklmsltjeQvoLPGhY4/wpyxeC7e7y
         oBtYMOV3bmUYpKjdv/QjjwPuZBP4Wi008cF4P3g3IOX30CchKfV51PwL6GgYDughmp
         yuWWh6XEDvN1w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=S85CPLkP c=1 sm=1 tr=0
 a=thHlcjYJ4SvUC+rIXd59ow==:117 a=thHlcjYJ4SvUC+rIXd59ow==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=fsC2SpR7_gnM44IGqmEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] t7900: add '--scheduler=launchctl' parameter to fix test
Message-ID: <17313607-7ae8-c37a-7931-7712c7bfdb88@ramsayjones.plus.com>
Date:   Sat, 28 Aug 2021 00:59:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLx7K6TdXEcFvWIH3BAnElaryNgGt2ZC1RLb+mJjtyqC9FKJNwvJGg+as9T4KKcNh+4dGOG380o55Jz/I/TgdAWagtwDDVUh421BYlhpA8xRdpJuFWo5
 RA+X2SavB7r7DnmITaqhg8mJoNWmHdhdca6C6N1HekQc7r+2hiK6svyJo6VVUkhqk7uFONPXbF/+Zg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Lénaïc,

As I said, I had a test failure from your previous series (Linux Mint)
which was solved with this patch.

ATB,
Ramsay Jones

 t/t7900-maintenance.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 8955aea9c8..36a4218745 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -609,11 +609,11 @@ test_expect_success 'start and stop macOS maintenance' '
 
 test_expect_success 'use launchctl list to prevent extra work' '
 	# ensure we are registered
-	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start &&
+	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start --scheduler=launchctl &&
 
 	# do it again on a fresh args file
 	rm -f args &&
-	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start &&
+	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start --scheduler=launchctl &&
 
 	ls "$HOME/Library/LaunchAgents" >actual &&
 	cat >expect <<-\EOF &&
-- 
2.33.0
