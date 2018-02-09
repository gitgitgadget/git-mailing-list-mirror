Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C06EA1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 02:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeBICnA (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 21:43:00 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44024 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeBICm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 21:42:59 -0500
Received: by mail-wr0-f193.google.com with SMTP id b52so6727588wrd.10
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 18:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMrqT1bOb+MLC1iJ2qc5a3p0YploJtrxsshbHQdqtfw=;
        b=LbF8toMxvsQVkkLarMEDV1Woo3Pih0T511JoOSCZyFo+94BHymJjkpXL+6qNf2jpNk
         qVvLQjCov4JN6s7zcdvPsl/cPWmYIyuqbsesov8EhGmMQY3k/HFTXsWr4IhH+L+i+SrS
         mh4O0E+drbSAhL8K0fWkUOfSUlPY0a/48gnFxlYnUAMNur8wl2kL9LjiyKkmiC/XunS/
         jJ8PaQ/z+dWr1gDC1ajO7THrigI7bWu2DnLIswU0lVYUOmobkqPaSDibzaCTM3Lo52Fi
         iau6qFuu7Unoy7deyaRJX8RLqIFfUTvL93Nj+XN76gzr5v8apYYZWJXzGU0BTZ7eqqEm
         VJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMrqT1bOb+MLC1iJ2qc5a3p0YploJtrxsshbHQdqtfw=;
        b=avRqlAvU4hBvMjooYpwTvmicFea/Ntg62pOLhTzzAIqV2airhnbXfXNG1aK2nunwHP
         sUp8DS02R6f6t25FWOfzUILR3I20DB2pgg2coNm1lGoVRc2GOM6zLf0AgxWOb5WaWndQ
         TNvesMjfK+YQj6jcD572sH8yXETgn7kFxFKQfLPjfmU9CionwjrfYHwpDPkR9YaV40OD
         LS84qt3EHYkeAsVm79rlPPARBtgnBtOvz166MChaftXKY00X0o4C1QEvzRfCRyoGztqh
         rfh/yn1iot0vkWpzmm8QRANqLm4YZ5QAzZAOTcrkUO1vz1jFKdMW59SY2RDXFgI778Uc
         94FQ==
X-Gm-Message-State: APf1xPBgDmHqWBuPcqW7WDtEByPohs8UKubtD1iMx11hCJApK3DOth+l
        E5BW7/LRPouMgl27WpCtSREVgw==
X-Google-Smtp-Source: AH8x225zoCbAQY7T1uN4R4B2cad5OQfL9sXFTzeOWkGBMOXuZtsQrXvGfnC3z3qFnoJeeaS5uzAwww==
X-Received: by 10.223.209.80 with SMTP id b16mr992748wri.86.1518144178524;
        Thu, 08 Feb 2018 18:42:58 -0800 (PST)
Received: from localhost.localdomain (x4db2a6c8.dyn.telefonica.de. [77.178.166.200])
        by smtp.gmail.com with ESMTPSA id x18sm2226174wrg.82.2018.02.08.18.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 18:42:57 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/3] Teach 'test_must_fail' to save the command's stderr to a file
Date:   Fri,  9 Feb 2018 03:42:32 +0100
Message-Id: <20180209024235.3431-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.180.g07550b0b1b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To check that a git command fails with the expected error message, we 
usually execute a command like this:
        
  test_must_fail git command --option 2>output.err
	          
Alas, this command doesn't limit the redirection to the git command,
but it redirects the standard error of the 'test_must_fail' helper
function as well, causing various issues discussed in detail in the
second patch.  Therefore that patch introduces the 'test_must_fail
stderr=<file>' option to save the executed git command's standard
error to the given file.

The last patch converts one test script to use 'test_must_fail
stderr=<file>' to demonstrate its benefits: thereafter that script
will succeed with '-x'.  There are plenty more places to convert:

  $ git grep -E 'test_(must|might)_fail .* 2>' t/*.sh |wc -l
  430
  $ git grep --name-only -E 'test_(must|might)_fail .* 2>' t/*.sh |wc -l
  135

... and this doesn't even count commands spanning more lines, and
there are more in 'pu'.

I didn't convert more test scripts, because it's boring ;) but more
importantly because it could give us 135+ GSoC micro projects.

SZEDER Gábor (3):
  t: document 'test_must_fail ok=<signal-name>'
  t: teach 'test_must_fail' to save the command's stderr to a file
  t1404: use 'test_must_fail stderr=<file>'

 t/README                     | 20 +++++++++++++++++--
 t/t1404-update-ref-errors.sh | 46 ++++++++++++++++++++++----------------------
 t/test-lib-functions.sh      | 45 +++++++++++++++++++++++++++++++++----------
 3 files changed, 76 insertions(+), 35 deletions(-)

-- 
2.16.1.180.g07550b0b1b

