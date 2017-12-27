Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C642A1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 16:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbdL0Q64 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 11:58:56 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:42639 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753020AbdL0QtO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 11:49:14 -0500
Received: by mail-wm0-f65.google.com with SMTP id b199so40489216wme.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 08:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yWH7a/kuHwNH6CTOAXDbs2TA94XkP/4P2RTNK9Er+hQ=;
        b=JGP6XjmueRrS3CdDbnQvCmVzCzQJM+v0GLCu49+Xouq2T6OcvHwXcUfoevHt0xq2m7
         ed1CbDMGzXam7JN5DuqPuPIsDd65NS0VQvnu7RHiqyYozcu1+PNVq1xoBKzia24DM6te
         wEGReoXor9oi/cgquTjrJioaIvtTQm6cbQnXgKf1hyCicMpfL5MKv1BkGhR7WxR+gfyO
         SNo7y3VBquMgwlNtRHOXvqR6FSHbjE91pYJMt2k6js5pSXQw6wdc1NfeXy312BZ/BAvV
         JxSlUs9VhE8Rjir2CzA3AtinLCpbf6yAm3Om2xCx/OYzxs8P7wS44jbvwASPrrzaDLVN
         a3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yWH7a/kuHwNH6CTOAXDbs2TA94XkP/4P2RTNK9Er+hQ=;
        b=ugh1PZvM0HJzY0jmxzKOXlvZLkvXXYUNRHwJlY4/I33FsiCDBzECK+X8do/H4U4IMI
         /rrIg+Id1tN2c7yUqIRV55MMt189+KX6ZMQ4cJzaHAzrPNofBGnprbwmnlTHHNs7IO4m
         mNeJYG6eiCC6NCeQ4BkGrn94ZZPETn9YVR4+X3EykekEiXhx9GgPHZrGKhgl3Osg9b07
         ry5u/APECYkGtM+wWIHlKWB+M7CqivumECjmYsbEr4aLVZV+sRgIs2BmE+0JJ/3uKuXK
         qodwUPtjgYVmLSjV09061SGU2Tui7KlE0YE+tGxQKvXRFS3TKZAA0H8gd5rEug16YElu
         JBcg==
X-Gm-Message-State: AKGB3mIEPmbD3imorKk9RG87Ml5wYnjqEYxeGArSw33hv7xxbbfPy9C5
        NjSjl41pv3dMHxaSE7xT3Nw=
X-Google-Smtp-Source: ACJfBov6NrsUf84ZsEd8wpkEI+4vGPjnO8Lg23TNUNK+3rQfJGOd7FIq4pJyhGPA8P2GYfCL0hAmEw==
X-Received: by 10.28.247.15 with SMTP id v15mr22636939wmh.152.1514393353143;
        Wed, 27 Dec 2017 08:49:13 -0800 (PST)
Received: from localhost.localdomain (62-165-236-58.pool.digikabel.hu. [62.165.236.58])
        by smtp.gmail.com with ESMTPSA id f132sm10948305wmf.17.2017.12.27.08.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Dec 2017 08:49:12 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] travis-ci: don't try to create the cache directory unnecessarily
Date:   Wed, 27 Dec 2017 17:49:04 +0100
Message-Id: <20171227164905.13872-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.500.g54ea76cc4
In-Reply-To: <20171227164905.13872-1-szeder.dev@gmail.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Travis CI creates that directory for us anyway, even when a previous
cache doesn't exist for the current build job.

In itself it doesn't hurt to try, of course, but the following patch
will access the Travis CI cache much earlier in the build process, and
then creating the cache directory this late might cause confusion.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/run-tests.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ci/run-tests.sh b/ci/run-tests.sh
index f0c743de9..ccdfc2b9d 100755
--- a/ci/run-tests.sh
+++ b/ci/run-tests.sh
@@ -5,6 +5,5 @@
 
 . ${0%/*}/lib-travisci.sh
 
-mkdir -p $HOME/travis-cache
 ln -s $HOME/travis-cache/.prove t/.prove
 make --quiet test
-- 
2.15.1.500.g54ea76cc4

