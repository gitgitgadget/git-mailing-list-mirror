Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783A01F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 11:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeCZL62 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 07:58:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35776 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbeCZL61 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 07:58:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id r82so15022955wme.0
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 04:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=htnEtmtpyv6kDj6BdhxvccwsQNh+PbbyZe6obtbECzQ=;
        b=UmjXSJeQhUx4MC7/W50JhCXGXUIFTmK9otXmd7a6AwcdJf/uXKJT+u14ItyysHczxI
         xOgba+Nk4gdvkl+0nXw/zHF4RY+Da1q4Fg48m+lmhFtXxAHFHpDwP97gZpWnF4uLOKMg
         8WU77pZDlBKfJrzpz1B7SI2mzmGF2XuILGsnJUR1U6VSn3o/J5nTOwKpFth2yk3bncBc
         6BdwriHkByHRc7Sf5vBZY/sqps/d4uhyfWTs601Kb6wAuJ74azbZKaYZOl7GVglnT9Iv
         0sm1eEC8HpuBD7g7cFR6/IrW7m4GD8OZYeCy78w/eP5u9OzfNiggejXHswwEHIVxl4km
         gCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=htnEtmtpyv6kDj6BdhxvccwsQNh+PbbyZe6obtbECzQ=;
        b=V3s22p7f6BtVbeT/QyxbmigXulzHig0Ftpn3AjXtnLgn3TwjTAxmpfYL2sMOtry3FH
         9RszV6lsgHj8a7/XdttTolRG5pTi0+yJhVzr02EPP1EvWIG9oRQAufp7QI+e0Wfu7gte
         0/ibGBUQOcf1vK+K2Bm65fuf4sjaDDeGwQ6deS9AO5wx0Oy9eINk6RUGxtbDr8gT/a/0
         xHHmwrb3GGUnS7b5HGvZGui68nVTxKVmLeqMYmuhGhtr0e/Z1MRpEAeE1mtFngtTTNK0
         MWMCCKm36sXm+5zCgPk40yAf9P/6fffw3zDJbEmDVH65LdmSTVr63iPeJd6JrCDIEsds
         xerQ==
X-Gm-Message-State: AElRT7Gke+kqfU9nNqRi0LSdnyAm8l+3/wq303sl/8Xeb7jfJfC88VHr
        w7zviTYe2MMpg5dQlfRoQrk=
X-Google-Smtp-Source: AG47ELtfXyNun9eaJ7kQ8jlNyFFQB0DsPveYJaCLxrOm4ISXXEb2p7nI+/EFN0pX0B+AKr8CYagptA==
X-Received: by 10.80.148.49 with SMTP id p46mr39695265eda.311.1522065506569;
        Mon, 26 Mar 2018 04:58:26 -0700 (PDT)
Received: from localhost.localdomain (x4db0d68c.dyn.telefonica.de. [77.176.214.140])
        by smtp.gmail.com with ESMTPSA id 4sm9644508edx.8.2018.03.26.04.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Mar 2018 04:58:25 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] test_must_be_empty: simplify file existence check
Date:   Mon, 26 Mar 2018 13:58:15 +0200
Message-Id: <20180326115815.10180-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.rc1.148.gc92dc354c5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit ea3c87d0b7 (test_must_be_empty: make sure the file exists, not
just empty, 2018-02-27) basically duplicated the 'test_path_is_file'
helper function in 'test_must_be_empty'.

Just call 'test_path_is_file' to avoid this code duplication.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib-functions.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index d2eaf5ab67..36ad8accdd 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -718,11 +718,8 @@ verbose () {
 # otherwise.
 
 test_must_be_empty () {
-	if ! test -f "$1"
-	then
-		echo "'$1' is missing"
-		return 1
-	elif test -s "$1"
+	test_path_is_file "$1" &&
+	if test -s "$1"
 	then
 		echo "'$1' is not empty, it contains:"
 		cat "$1"
-- 
2.17.0.rc1.145.gfac1bf9500

