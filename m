Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F31021F404
	for <e@80x24.org>; Mon,  1 Jan 2018 22:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeAAWy6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jan 2018 17:54:58 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:39700 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbeAAWyz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jan 2018 17:54:55 -0500
Received: by mail-wm0-f47.google.com with SMTP id i11so58290113wmf.4
        for <git@vger.kernel.org>; Mon, 01 Jan 2018 14:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2CPY/fTLXKK6chtqZ5QXZisYYZMkt1oq+sd5lSmySk8=;
        b=mUTNudWiGIV8GExdTmjp+ucvpzP1CD/TO1CQ/OBarj5ZHeoUozvFIrFgi6eypyJCG6
         T1sZ6diQyNyuyIxf95xdtIXfYYILPpxJfM+9rMHQIXRmaokRwfO81lGCypkfyRdIkTY0
         Npupaf/Vx8OMpdpV51K5pKewfMNJtdpcp0DCdVbn8ANzKKtcj7FcEzMnsAlrMk8mdrY7
         bl80grf4VBybWJd7KN2EtWtcCfh2NvaILn5fDzdow0k3G91T4UNIL47ImBT+rWMMyzun
         BIYXcuevt+zQRVFWL1NoR271GJ8VEOnWljO0/6W28O43ZdY93jZ1ghO7l2QnzAfuh/ww
         LEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2CPY/fTLXKK6chtqZ5QXZisYYZMkt1oq+sd5lSmySk8=;
        b=LpcJt4rFEtVgEonOf+m5yd+0x7Lfauk7ZL4caVgaM3KaSQvO+2QMLRxAuyV6aJ34D3
         GCbnHxtVZ/+yZ+zwdqJZ1UvndeTjNQNXopz/1ctOt1objID22RcVgfw1IvzAnyNfiRHH
         9Qu1D7ASvIJ22Tz12F1rwgTdx1VRGja+sk/aJ7tfaFF2FgCVMyxA/GFb9VbB7hLnjvCm
         3Ds5BEIGumo6hD6dTGw4CB1xm1G2JhLJ9NRcFCoIp0mbqqe2z8F1szfyl2LEnJnIZIiv
         lVwUhFUTMbxND0VZwBInbfL6N5kHYu1Sn/Jr3X6QP9s3YaihcJ/CzEgEs4UkKjb5nvWB
         vkoQ==
X-Gm-Message-State: AKGB3mKybxZo+Xqchh5llLpppwSxDBXOkP4LLCP/bmtFDsAG/ewYhY2q
        0oVABRpJ7MLdfUkASSfdrMc=
X-Google-Smtp-Source: ACJfBosxfrwCtAUsg+h2JZROVb3xeS+I2pZ/+eqobzWnqGe3fX7FD9M56OuIN6FGaWGc6Vw3IzpZwA==
X-Received: by 10.28.132.72 with SMTP id g69mr15106654wmd.22.1514847294337;
        Mon, 01 Jan 2018 14:54:54 -0800 (PST)
Received: from localhost.localdomain (94-21-23-100.pool.digikabel.hu. [94.21.23.100])
        by smtp.gmail.com with ESMTPSA id d7sm54186061wrd.54.2018.01.01.14.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jan 2018 14:54:53 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/4] t3200: restore branch after "unborn --edit-description" test
Date:   Mon,  1 Jan 2018 23:54:47 +0100
Message-Id: <20180101225448.2561-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.67.g3a46dbca7
In-Reply-To: <20180101225448.2561-1-szeder.dev@gmail.com>
References: <20180101225448.2561-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test 'refuse --edit-description on unborn branch for now' switches
to an orphan branch and leaves the test repository in that state.
This might badly influence the subsequent test expecting 'git branch
--merged' to error out, by hiding a potential regression with an error
triggered by the unborn branch.  Furthermore, a new test that will be
added later in this series failed first because of this.

Use test_when_finished to switch back to the master branch at the end
of the test in question.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t3200-branch.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e9f55ac04..427ad490d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1234,6 +1234,7 @@ test_expect_success 'refuse --edit-description on unborn branch for now' '
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
 	EOF
+	test_when_finished git checkout master &&
 	git checkout --orphan unborn &&
 	test_must_fail env EDITOR=./editor git branch --edit-description
 '
-- 
2.16.0.rc0.67.g3a46dbca7

