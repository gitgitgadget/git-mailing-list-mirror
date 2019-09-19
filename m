Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D87C1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 17:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391982AbfISRfX (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 13:35:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55485 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388951AbfISRfX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 13:35:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so5591492wma.5
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 10:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kXz4MtSJ/w6DGclW3VxoRN1lDaDq9Ry6lerzD9p9kbs=;
        b=rFWpvUZr46pJ/GdPgSPxAPtQUtGuqe05AI+einZGfZbUsqJe6tlRp+WDvH/+yb5RLV
         UisIRcC2Teg2Ie7iC8fVnXT6y9WVKrfExhQsQVc3OSeNpXQe1uDJznzl8OGl1XBNVo6k
         gmzkZuHFkXuRt8eXBKR6ZOSZDxnvJyHEUevZewpZ7xVezX6t9NOebpdCImXOUyEmvQEj
         GR0VZBy5OGzbD4YyblJjHawFpKCXmjNB4/vNLHdgAHEfLs2kn76ahAbnkapHbhbqdU2a
         m6OgvKVE5kDiId2c/XEzNT+i8CVpZ+cbN+emvY0lvCp1jhblbDT3atbFmIjdKs7HIWhv
         dfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kXz4MtSJ/w6DGclW3VxoRN1lDaDq9Ry6lerzD9p9kbs=;
        b=g3ErKzWdgox60CBVRLG8qsJLwgJTEvTUiLSKnDBNx/XYjYHyhmCSRb9mW+1E98OUmh
         NuCeLVkABezFrIk4lAZAEhY4nGhDWoGG+kiXbXc9aukNsUmFPTnivRTQ9G0tN22OTLCD
         q5dMg3wvIhlUIw/wmsc9CjUk38sk+SmKdTSA3eRrPRZbJ6sDpu/bJLmQcxVnRF8kNbGk
         9lng4G/iC+1aW23xARcT2pMcyAcj6uukicFu9GZEIOItZ0hxM1p6rM5hf0B+UB5kQO0B
         G/WyI1vg2LGIsl6JxKDSvpl7TS8AkScP50RoNeseSBqyMek1OXsI2ge6jA6R9NIQvfZk
         4/ag==
X-Gm-Message-State: APjAAAWWr/7UsX1td+qJN9MbqXtHsgg8YkVSPbbgYAbZUANU9rLKpIQs
        cPfM934BL+XSEJBTRofxzbY=
X-Google-Smtp-Source: APXvYqzUDsbj5pvixasscWAZvqmxT3GV1IAM1anybma+aNjCNpxd97a3JgDO1AbX/459pTeikHSfig==
X-Received: by 2002:a05:600c:22c9:: with SMTP id 9mr3926022wmg.133.1568914521805;
        Thu, 19 Sep 2019 10:35:21 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id l18sm9268601wrc.18.2019.09.19.10.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 10:35:21 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] travis-ci: ignore already tested trees in debug mode
Date:   Thu, 19 Sep 2019 19:35:14 +0200
Message-Id: <20190919173514.24074-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Travis CI offers shell access to its virtual machine environment
running the build jobs, called "debug mode" [1].  After restarting a
build job in debug mode and logging in, the first thing I usually do
is to install dependencies, i.e. run './ci/install-dependencies.sh'.
This works just fine when I restarted a failed build job in debug
mode.  However, after restarting a successful build job in debug mode
our CI scripts get all clever, and exit without doing anything useful,
claiming that "This commit's tree has already been built and tested
successfully" [2].  Our CI scripts are right, and we do want to skip
building and testing already known good trees in "regular" CI builds.
In debug mode, however, this is a nuisiance, because one has to delete
the cache (or at least the 'good-trees' file in the cache) to proceed.

Let's update our CI scripts, in particular the common 'ci/lib.sh', to
ignore previously successfully built and tested trees in debug mode,
so all those scripts will do what there were supposed to do even when
a successful build job was restarted in debug mode.

[1] https://docs.travis-ci.com/user/running-build-in-debug-mode/
[2] 9cc2c76f5e (travis-ci: record and skip successfully built trees,
    2017-12-31)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 44db2d5cbb..1a09ac4b34 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -34,6 +34,11 @@ save_good_tree () {
 # successfully before (e.g. because the branch got rebased, changing only
 # the commit messages).
 skip_good_tree () {
+	if test "$TRAVIS_DEBUG_MODE" = true
+	then
+		return
+	fi
+
 	if ! good_tree_info="$(grep "^$(git rev-parse $CI_COMMIT^{tree}) " "$good_trees_file")"
 	then
 		# Haven't seen this tree yet, or no cached good trees file yet.
-- 
2.23.0.331.g4e51dcdf11

