Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D9420248
	for <e@80x24.org>; Wed, 13 Mar 2019 12:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfCMMYv (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 08:24:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43992 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfCMMYu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 08:24:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id d17so1755635wre.10
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 05:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WtAL9jjPK0JUJxl23bJUJbEPSlSxiqByPE8ywcZV3DE=;
        b=p1eU5FnSaJcRW7qFdH2Yvx2xO7e1ZptMTNo5BarXJz22yS4hDifMIAb49DvpYXzt1n
         wP1BN4XTv0Idn8OK1/lyWmu2Q9SBifuyUrCZc9TMwG4Xn+TxtWmZDYkVf59ThVR8TjoL
         uyFJ/OkKFYxzplqUP7kQlIhBVBg5h/B3KuzDUamt4gCbWDZy93EiqYUuyc84JqfWe7AV
         zfpDbMU6PKIk9SGrc0uh4rnlchMFlbhH6qKPfr04ot/P2uxxYEzI6R0Vfojd9FoDFAap
         xnhz5+tLZrctC+BH60xmZkqI8UGLuBp/Q7+G6H2Urm9sybF0jCcO2BAEMxv2Zt9eajkP
         AfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WtAL9jjPK0JUJxl23bJUJbEPSlSxiqByPE8ywcZV3DE=;
        b=lnTQ3q3U5r29atI6HpXnBzMxC0FmZ5p3HbZlS3allbxzbArWgKI/Fu+X6nI2w9DKq+
         ttf2vt5QOVqE/3sdakf2vi7ju8dNFSzBNpHOjmTDRzy4onlOWy4nxJ2fbiUh8VsxsJh6
         icEsCXRFo2eovwxW7karnXz16Gzw3wsAfCM8D3zQR5cHYdY64EylteHAMM45FamkURgN
         nQvxqxf1JhgS5WEeXWesvCYeQMrbR1GbaCcSZPVrhSZ3aSxqzRHYdUBMrYxm1gxx62Rv
         1N1eBFiDoQUdsiefAucBauVgYYspLfkFkMtmgQgFEzgcyk0vS/Mo5Le7J8WYrzwC85Id
         77tA==
X-Gm-Message-State: APjAAAWsntNFqDEyDODp91UPEPgr/FuwNdyMPn3zmHV0fQbo5/7WNVYi
        WF2jlqUYkIX3sxt3F16gALeFvroH
X-Google-Smtp-Source: APXvYqzGRQaKHTDU78f8VWBN5Y/bNx5ujL8Ixbs3IpLaCVqbENHBlQIkUFvCkfFqJsj4zwXtqA71LA==
X-Received: by 2002:adf:fe85:: with SMTP id l5mr20307289wrr.0.1552479888153;
        Wed, 13 Mar 2019 05:24:48 -0700 (PDT)
Received: from localhost.localdomain (x4d0c2b66.dyn.telefonica.de. [77.12.43.102])
        by smtp.gmail.com with ESMTPSA id t2sm8348287wra.9.2019.03.13.05.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 05:24:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 06/11] t0301-credential-cache: use 'test_atexit' to stop the credentials helper
Date:   Wed, 13 Mar 2019 13:24:14 +0100
Message-Id: <20190313122419.2210-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.499.g4d310c7a8e.dirty
In-Reply-To: <20190313122419.2210-1-szeder.dev@gmail.com>
References: <20190313122419.2210-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use 'test_atexit' to run cleanup commands to stop the credentials
helper at the end of the test script or upon interrupt or failure, as
it is shorter, simpler, and more robust than registering such cleanup
commands in the trap on EXIT in the test scripts.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t0301-credential-cache.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index fd92533acf..ebd5fa5249 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -10,7 +10,7 @@ test -z "$NO_UNIX_SOCKETS" || {
 }
 
 # don't leave a stale daemon running
-trap 'code=$?; git credential-cache exit; (exit $code); die' EXIT
+test_atexit 'git credential-cache exit'
 
 # test that the daemon works with no special setup
 helper_test cache
@@ -108,9 +108,4 @@ test_expect_success SYMLINKS 'use user socket if user directory is a symlink to
 
 helper_test_timeout cache --timeout=1
 
-# we can't rely on our "trap" above working after test_done,
-# as test_done will delete the trash directory containing
-# our socket, leaving us with no way to access the daemon.
-git credential-cache exit
-
 test_done
-- 
2.21.0.499.g4d310c7a8e.dirty

