Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CAB51F404
	for <e@80x24.org>; Mon, 29 Jan 2018 17:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeA2RR1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 12:17:27 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46432 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeA2RRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 12:17:25 -0500
Received: by mail-wr0-f196.google.com with SMTP id g21so8058076wrb.13
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 09:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P0HibLSGf+1+HulX1IFdMZY+qbpCoXfcXty5Retnrio=;
        b=tVqcfpKCE669QAPfnU01OPkJXszPV20JF6Y3qi/MJSbbXMY32wwR+zZSfsJ37WyyBM
         sYDkGYfRnrYEuSFUOd5r7TIzGZFMf9zZdt8rd49Mw7HOC6INoMTFwYqepUE52GjFWY59
         IW8r6fvaKL40GVkI5JvBDhPtOxF/5q3jkykQrxA0Wi9tzDoK876jSsFikAZaX6dk8oyh
         1wHzHu+WUIATiCNETeS8bOfI/YIxzJOdSAi88/HN03rnAT4+LQVAMzTHgwRdTHATTW5V
         QvQgXiL8wFOoz/+OlPWGeQf/do3YVNulQ0qhvqu0gAkYj5SXXSmNJYQlfjzBHX8yhRqf
         BF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P0HibLSGf+1+HulX1IFdMZY+qbpCoXfcXty5Retnrio=;
        b=QylOvFp8ZZZU74ETakPqebEQsuOYdHnjJwkQ6E8AyJ6QshBlZXaH5DRsB6tnD7P3Fl
         AsUbtqcBrLqb62CVJ0gxBYWggfx6fzB9WhAv7QKPcBtdfj9k0ZlUkR9pQc/5BQNfUxNt
         Cs9+Wr6EOFWYwuuh2RdqcVbXt45d0HNjPqlOTTDAGJTvxlfo6+m23qeBXZCrdh1vsoZr
         YFINpevPPlKbtxbp979uhUVdl5YE0lvgHI5En4IJd0A6TaPcayGGtJMkW+ps+TeB1bm6
         YvA18tacxNMOT4rAOAwq7bakn3WKZsdklDRJXSOOKmMdopq+4AAxxSLfX4/phV+UJoCr
         1hig==
X-Gm-Message-State: AKwxytdRB5P9jk2dPrsWSKWoLJbhd3bq0S3EZj7D8j2JD776BVVDJ+Z0
        PIqqI6mV0CyqUPN/LYniw9k=
X-Google-Smtp-Source: AH8x2272HmqdgfkIyNsRJF4uaYB2lZFig/WVwIaiY7PjydLgT4hy7XCHVPPmpVxtf1bNj+KFW0CiSw==
X-Received: by 10.223.145.198 with SMTP id 64mr20839196wri.53.1517246244447;
        Mon, 29 Jan 2018 09:17:24 -0800 (PST)
Received: from localhost.localdomain (x590c5617.dyn.telefonica.de. [89.12.86.23])
        by smtp.gmail.com with ESMTPSA id p21sm4050876wmc.28.2018.01.29.09.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jan 2018 09:17:24 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 1/5] travis-ci: use 'set -x' for the commands under 'su' in the 32 bit Linux build
Date:   Mon, 29 Jan 2018 18:17:09 +0100
Message-Id: <20180129171713.17471-2-szeder.dev@gmail.com>
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

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/run-linux32-build.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index c19c50c1c..5a36a8d7c 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -26,6 +26,7 @@ test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER) &&
 
 # Build and test
 linux32 --32bit i386 su -m -l $CI_USER -c '
+    set -x &&
     cd /usr/src/git &&
     ln -s /tmp/travis-cache/.prove t/.prove &&
     make --jobs=2 &&
-- 
2.16.1.158.ge6451079d

