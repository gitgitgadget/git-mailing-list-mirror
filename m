Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617191F404
	for <e@80x24.org>; Mon, 29 Jan 2018 17:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeA2RRd (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 12:17:33 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55563 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeA2RRa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 12:17:30 -0500
Received: by mail-wm0-f68.google.com with SMTP id 143so15760422wma.5
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 09:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fUkSYvwMwFeKoo0oQ88hzrHCZO4vMtLcf+qsjncD0+o=;
        b=no22CJ+Pww7m9PZidLAA3GzSciAwdFHSwnmkTNzfBumkp5qLft+yT3WFlKt1siOdrj
         W5m4MQ24UyQJLEUimTBbKxEOsx5O+gR4mthnqz36pZhhCO//5XSA/AStKUh2s8Zk1k6g
         lq3Cy7jFYE1MQjasmR118P4cYZB3hZyDW2MaziljYT34M88iZrec9/ItGoKFwqPN6Cvo
         Uo8e/G/f2K7EpP4heJMV/57DMEi5H3qHP/TjmfHsSQA+MKSs9/s3ERlkvd1FdCiXrMmf
         W2GkN5nAFlWdWsXEUT3Po8euJVwMN3M80emF+jic/vwmpyC9Leh4rCC0tN0H9uOGj0yB
         CdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fUkSYvwMwFeKoo0oQ88hzrHCZO4vMtLcf+qsjncD0+o=;
        b=RaBTZtOM2YxDHFmti6e1m5xpvZIOzfN0HdNXxCldOBVKguGgW8i4DA8r23ZpgqILTJ
         ltO+TapyYxBPV6LLpQKb6YGOACa1ZwFfZj9kpyIIeopfKqIKVTdV0IXIiSdXyepvrifz
         5aEfLWsCAvQw87vdQOY+7bK+9B2xdKv5s9sqMhoFHkOXcvrx4DpWSHY/IngPYJFQdNwC
         v34g9kGgwhs7GzfTIbo7t0oeZK52Q4yVJ4rha57GH4Ulc+ILdJYodB/y1EnRh4PCUtwT
         UVkXA8wWjuOK3mJegY/OQtjXX1Wu3V2q1fKBSTeC5tlGQNW9CTcTZo7UdrSvyKKepQ2E
         Vq+g==
X-Gm-Message-State: AKwxytfDnDhcsDNFYmpjwn7MTLVW5g9e82sSzh60BGMs0VaBIPObPQo6
        LWlhfIp0mGZDmImGkW1BqvLGCQ==
X-Google-Smtp-Source: AH8x224lMyuogfhcdCc0QBpJrAm6+0+81t4+gE/BQ/WpKtYx4kRoFQ04SZNoZmr/o+OUFhaLlf1ktQ==
X-Received: by 10.28.99.137 with SMTP id x131mr17411037wmb.12.1517246249495;
        Mon, 29 Jan 2018 09:17:29 -0800 (PST)
Received: from localhost.localdomain (x590c5617.dyn.telefonica.de. [89.12.86.23])
        by smtp.gmail.com with ESMTPSA id p21sm4050876wmc.28.2018.01.29.09.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jan 2018 09:17:28 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 5/5] travis-ci: don't fail if user already exists on 32 bit Linux build job
Date:   Mon, 29 Jan 2018 18:17:13 +0100
Message-Id: <20180129171713.17471-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <20180129171713.17471-1-szeder.dev@gmail.com>
References: <20180129171713.17471-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 32 bit Linux build job runs in a Docker container, which lends
itself to running and debugging locally, too.  Especially during
debugging one usually doesn't want to start with a fresh container
every time, to save time spent on installing a bunch of dependencies.
However, that doesn't work quite smootly, because the script running
in the container always creates a new user, which then must be removed
every time before subsequent executions, or the build script fails.

Make this process more convenient and don't try to create that user if
it already exists and has the right user ID in the container, so
developers don't have to bother with running a 'userdel' each time
before they run the build script.

The build job on Travis CI always starts with a fresh Docker
container, so this change doesn't make a difference there.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/run-linux32-build.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index 8c1b500e6..2c60d2e70 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -33,7 +33,13 @@ then
 	CI_USER=root
 else
 	CI_USER=ci
-	useradd -u $HOST_UID $CI_USER
+	if test "$(id -u $CI_USER 2>/dev/null)" = $HOST_UID
+	then
+		echo "user '$CI_USER' already exists with the requested ID $HOST_UID"
+	else
+		useradd -u $HOST_UID $CI_USER
+	fi
+
 	# Due to a bug the test suite was run as root in the past, so
 	# a prove state file created back then is only accessible by
 	# root.  Now that bug is fixed, the test suite is run as a
-- 
2.16.1.158.ge6451079d

