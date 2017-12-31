Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9131F404
	for <e@80x24.org>; Sun, 31 Dec 2017 10:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbdLaKMa (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 05:12:30 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44962 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbdLaKM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 05:12:29 -0500
Received: by mail-wr0-f195.google.com with SMTP id l41so32623335wre.11
        for <git@vger.kernel.org>; Sun, 31 Dec 2017 02:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KZvOMtHIb3F0Xgm2UAPmpzaEND3aQhxWiAzkAGXHV8A=;
        b=SzgHRUWnLUBoH02tZ5jOThIqu0MLQ8E5rEZBWDrYSGv+JdUbw/6qTIm1Q7rX+aNzXG
         Ipuvs6uAiJvfyxK8qPqmwSX8Z91Jp4x6ExUQtZv+6ZbAPLf/xrKh5tCFHoGF1ew6y+0D
         auhtBvvbBpzoTwl5APJYEAu/CykgT8CIOSXPu5EC/LlNqX5NOJwKJRScLXlelCVx6gOJ
         Y0uDed6bAvmLd24ENxfIMBS7CjDtI088bO84D9I9SW1P5wFK96Wa12RkYjeMFb618PR/
         WnfMGXTZwPKpUVbrrQrIvpR6WLGOH9ERttBwztg/ALXNQSLowSR8dxGJkJbT4eY8Ssof
         TBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZvOMtHIb3F0Xgm2UAPmpzaEND3aQhxWiAzkAGXHV8A=;
        b=K5LGzkoGDRPSMkttjEcTQiQluWNbJGTX/5u3H57eATPl1O+UjyOSyVUNASp7tef5hz
         AXw43pWUbjNTD8beRQgAzpdC+EYIBKrbgmKVnznLu/nueRUXeT5J70H+GmVI/SHi8UJT
         JnHYD3MsBy1eUWBiFmpmOvVj5eIJY+w3mzhOZaMu/Di/SbeImmVri3HjP6f/9uU+SSJ5
         iGQV1dmZSJHYuy6iC07oZuvHDLqQT8eKppHo4a7cjo2XKvZrpyOJ6zZ97ZMrEl8wgy3Q
         ndqpyT7zNdx95qgbWn5cPzpVH5Y1dfEXJmOrmGfTN+a12TIukoyHDAdfmoxIk1q9jX+V
         MIpg==
X-Gm-Message-State: AKGB3mJ0QYWtFP2if7wm1fIC55xHhwHpnZP6yLPUV5NLd7fAXnKiclmc
        XTB+NB69bgJu1wty6ucvMo8=
X-Google-Smtp-Source: ACJfBoucTHVChjVHjxteoyU7mcIdRqr4y9+fmwHmVAYXyeLDyfw1T6ZFqOAH8sJpXfQ1jZwVhPURmA==
X-Received: by 10.223.159.18 with SMTP id l18mr33558907wrf.156.1514715148285;
        Sun, 31 Dec 2017 02:12:28 -0800 (PST)
Received: from localhost.localdomain (94-21-23-100.pool.digikabel.hu. [94.21.23.100])
        by smtp.gmail.com with ESMTPSA id 11sm16357779wrx.73.2017.12.31.02.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Dec 2017 02:12:27 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 2/3] travis-ci: create the cache directory early in the build process
Date:   Sun, 31 Dec 2017 11:12:04 +0100
Message-Id: <20171231101205.7466-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.67.g3a46dbca7
In-Reply-To: <20171231101205.7466-1-szeder.dev@gmail.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com>
 <20171231101205.7466-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems that Travis CI creates the cache directory for us anyway,
even when a previous cache doesn't exist for the current build job.
Alas, this behavior is not explicitly documented, therefore we don't
rely on it and create the cache directory ourselves in those build
jobs that read/write cached data (currently only the prove state).

In the following commit we'll start to cache additional data in every
build job, and will access the cache much earlier in the build
process.

Therefore move creating the cache directory to 'ci/lib-travisci.sh' to
make sure that it exists at the very beginning of every build job.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib-travisci.sh | 2 ++
 ci/run-tests.sh    | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 9d379db8a..197aa14c1 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -27,6 +27,8 @@ skip_branch_tip_with_tag () {
 # and installing dependencies.
 set -ex
 
+mkdir -p "$HOME/travis-cache"
+
 skip_branch_tip_with_tag
 
 if test -z "$jobname"
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
2.16.0.rc0.67.g3a46dbca7

