Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEF7D1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 23:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdLKXfZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 18:35:25 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:44503 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdLKXfW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 18:35:22 -0500
Received: by mail-wr0-f179.google.com with SMTP id l22so19298088wrc.11
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 15:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m/q0bvu66xG+mITIY6uI+/kriQckulpApnqS3PVbOzo=;
        b=mc75BpDjpkv2dJ4e3wAe7o5XLWrt5FxdTn+JplBvuZUM1S8kaIzB8uhOplQ2jTac+l
         KmBpuLrRsUGbkSjF6iYdJYcfmkgnJwSd4CTBXwozqb+wxzAIk1VXuz2uuvOxgaqf9C2H
         cidQdUZTzv3E3Pyod56s0uoRY8Ooc+M0Yx1KFySKQIefMaGw2H9XCv+Ims1BaTfhYx2V
         nKEf80WXmV9GQlubdyWMXUw1oIF8qhm2sIXZ1+GZx1/XN6CfYSmwAMT0hI4cipgtLLQQ
         uqwLKRrtRnBLQOPeE9RmmuL7J5HoP6zT1RzzaLORTvywr5NAn+4ZlBqRqQ6CDffpgVru
         BuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/q0bvu66xG+mITIY6uI+/kriQckulpApnqS3PVbOzo=;
        b=cg18r65ZOa84UV+s/7S2Ww1J4oEv9+tQAkhvcgfbPyFv+KJI1iTFdTT2lcbb8LkGfZ
         BGtPzk20tzN6QwlxlfJsHwl5TpSfdke8qAwpU/eRLv8uxGGlPDjfPJ1l6XKcWgxtdbRb
         ih0LWa5c3/LFwJgM2qaF39FGLOF08nj4VdwBdPKslygF0cZcbtTcFE1Vg4zeW4p8mSdI
         +f+AYZltZqc4iE5f5UP4APD+Up9qgHeA0049l1jUGKJbKzGEcbmgbsvShLnpIHdjKeoz
         XG9eov+CFp2PZXDM77Jfkq1rFkccFvGhCMtGXzSP6fn+6aXlymasN1bSGlZWDuGiAwa2
         K88w==
X-Gm-Message-State: AKGB3mI/ynV28crQOjELJgYzJwu3IUYdVYh+DmJ++MXlCvydS2fuOymi
        iVSRMztWcjZZRiQMQRy09KnWmg==
X-Google-Smtp-Source: ACJfBovj1sV4Si70Ip75aP1YeqGNm+wjYrrd1eCAAEJEAQyJHAaPgtmwlK2II23pkPGomkWgdao2dw==
X-Received: by 10.223.191.13 with SMTP id p13mr2016337wrh.69.1513035321515;
        Mon, 11 Dec 2017 15:35:21 -0800 (PST)
Received: from localhost.localdomain (x590d9245.dyn.telefonica.de. [89.13.146.69])
        by smtp.gmail.com with ESMTPSA id h12sm15408811wre.52.2017.12.11.15.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 15:35:21 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/4] travis-ci: use 'set -x' in 'ci/*' scripts for extra tracing output
Date:   Tue, 12 Dec 2017 00:34:43 +0100
Message-Id: <20171211233446.10596-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.421.gc469ca1de
In-Reply-To: <20171211233446.10596-1-szeder.dev@gmail.com>
References: <20171101115535.15074-1-szeder.dev@gmail.com>
 <20171211233446.10596-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the build logic was embedded in our '.travis.yml', Travis CI
used to produce a nice trace log including all commands executed in
those embedded scriptlets.  Since 657343a60 (travis-ci: move Travis CI
code into dedicated scripts, 2017-09-10), however, we only see the
name of the dedicated scripts, but not what those scripts are actually
doing, resulting in a less useful trace log.  A patch later in this
series will move setting environment variables from '.travis.yml' to
the 'ci/*' scripts, so not even those will be included in the trace
log.

Use 'set -x' in 'ci/lib-travisci.sh', which is sourced in most other
'ci/*' scripts, so we get trace log about the commands executed in all
of those scripts.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib-travisci.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index ac05f1f46..a0c8ae03f 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -23,7 +23,7 @@ skip_branch_tip_with_tag () {
 
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong
-set -e
+set -ex
 
 skip_branch_tip_with_tag
 
-- 
2.15.1.421.gc469ca1de

