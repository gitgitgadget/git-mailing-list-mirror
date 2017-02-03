Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354E81FAF4
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbdBCCtV (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:21 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33262 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbdBCCtR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:17 -0500
Received: by mail-wm0-f66.google.com with SMTP id v77so1189146wmv.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gZkC7RLyH4zToUYP3HP4njvChSYpdypAzrc+yHL4CCU=;
        b=dyeOjdVVgeX047I5r4qKihxGpPKMMN61/W5hOyE5rvmbTutaEluYc1X4z5tYpc46Qk
         hY1T28R2ewImwUM27kD8Z1Nt7Hr8hnXkBnm14cPZ1o2vISbwemzx34iNxfSHk3MlT5iX
         PNejj/fSlXTe/DK9ZQuV+/3paoC2RQm4nYHYs1HgmIuhfFCvRvY0E/utNX9VonDk88Rm
         UivUiHL0mp+OXaaTB+k0Rjlk9lUTNo/tIKDw11G/ibsxeLc+Ugms66cEeNQ99Gcpf1yQ
         cFPk8Hn2yGKDS2Q9gN4NME2yHAECnp3tWRWDZv8YKjFGZAXTOJi0hdlMwX5CIxUCZDKL
         rTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gZkC7RLyH4zToUYP3HP4njvChSYpdypAzrc+yHL4CCU=;
        b=Tqih5LsgJ7ZlLy4/yrfPHvxYLSodDbyE8ZrDmqEU6cjyYb3oOU2n55JB8HRD4aiKsq
         ujgL7oGTKhJkWZCV/lTJGiB3dPwWnCJmaw89AkBELjff1YQqjFtTEljO9gy/JYU9LgoS
         kDWxQfUKashyXhx1Kx7o5LIncdtQYBxMO6x/w9HnJYClreZ4M/sbcblFmU7P8CICQY5r
         MbITsCNJ/8ComCQCAIaXhWM8PVPd/fNiW6kUil5MbN0bwtbVmhzNgCWW7mW7w4APvZGx
         zqlwPFspER16+VYxmvPzqwdPevCgFSKdN0DGFXnZC3+EwIXyh/kmxmx4+JqbiRssrhQd
         O0sA==
X-Gm-Message-State: AMke39n/7gxlnUHdhkOLq8oK8zEuvhixxhBImDsApMUXQzqPUMZd1E2D0vXyKgO9Ul6oMA==
X-Received: by 10.28.67.69 with SMTP id q66mr408610wma.129.1486090156521;
        Thu, 02 Feb 2017 18:49:16 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:15 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 03/21] completion tests: make the $cur variable local to the test helper functions
Date:   Fri,  3 Feb 2017 03:48:11 +0100
Message-Id: <20170203024829.8071-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test helper functions test_gitcomp() and test_gitcomp_nl() leak
the $cur variable into the test environment.  Since this variable has
a special role in the Bash completion script (it holds the word
currently being completed) it influences the behavior of most
completion functions and thus this leakage could interfere with
subsequent tests.  Although there are no such issues in the current
tests, early versions of the new tests that will be added later in
this series suffered because of this.

It's better to play safe and declare $cur local in those test helper
functions.  'local' is bashism, of course, but the tests of the Bash
completion script are run under Bash anyway, and there are already
other variables declared local in this test script.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9902-completion.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f490c1d05..294a08cfe 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -98,7 +98,7 @@ test_gitcomp ()
 {
 	local -a COMPREPLY &&
 	sed -e 's/Z$//' >expected &&
-	cur="$1" &&
+	local cur="$1" &&
 	shift &&
 	__gitcomp "$@" &&
 	print_comp &&
@@ -113,7 +113,7 @@ test_gitcomp_nl ()
 {
 	local -a COMPREPLY &&
 	sed -e 's/Z$//' >expected &&
-	cur="$1" &&
+	local cur="$1" &&
 	shift &&
 	__gitcomp_nl "$@" &&
 	print_comp &&
-- 
2.11.0.555.g967c1bcb3

