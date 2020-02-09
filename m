Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA814C2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 22:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D8B20838
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 22:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCpYkJUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgBIWgV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 17:36:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39762 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgBIWgV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 17:36:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so5230958wrt.6
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 14:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Npf1w49e0aOdtf2ehLve2L81qcDxnsJO6emY0cD7OPE=;
        b=MCpYkJUDnVqrB8vEBPyfcj8J0kEp1KkOnx33tfTD0f1n0tq7KD5uQZ+uny6V4BCX/5
         vCe/JCMQCkuSxx6gYCyc0+kXrSWsGxrB0Hq/kSv0oeQNkyUqixgKeeE5ZFwDjv7gzMlD
         sb2Oxia3tV8pt/4+mw6SiPn3YSnTBEkqolRRt/w1Tknyp4+ONnQSURpzuj7xAJEyWdNK
         uyS5I5Db/RoxfjEG82cVzQwXIESdNZ0bmoMuui8ct+W0vtPXyFYyh+BhtTI0aSxqu9FD
         DYcaYpiMs3aOUqL6yF7TyMCXu035VW384LZFMD240i1DWvW85U3tgX8WgJqdSFbIBuNI
         Yevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Npf1w49e0aOdtf2ehLve2L81qcDxnsJO6emY0cD7OPE=;
        b=g3jddVWaIBfv7PbDvVMO/YTgz3G7Ejoext/Lh0rWP3r0AOnmXNNPBvcBFhPcgG9H6Q
         /CaGhmc6I49wxYdlXym02adu7NGRVLWLHnDIfRd0sanIthwWq4yqypEMtqjx3WQXPkI6
         teKj3WCTfc6cqGoB8CPFww/HgY1cFW97LGFqNlIdcV2jAMhwJqQW8rwycFUteSo4Qtot
         xl9ovxf98bX8FdojZkCBxYqlBfqKlfjgAC7d3rKbjTquK09H5tHACMftItA4AA+DdukQ
         pzv1BYOWXRt+XibGzK/7R7MQgkKrr33kcnMvcc13sCkpz4nYFKccS1k6JlH8u7RFZdDA
         gJRw==
X-Gm-Message-State: APjAAAWhY3h/qy0DCHEMgtnB6sT+kjdcRxDns8clFY9LVE1KdUeVOio5
        CGcGwJ5fgSGDU/N5/fSNjPFsts1E
X-Google-Smtp-Source: APXvYqyWq1zjsOvfcapuE8tOd6j3WR21GWpdq3W9CmFvpePg9VvyzuHPtNC8SGJEnOrmw6xGVdSvFg==
X-Received: by 2002:adf:e943:: with SMTP id m3mr12657640wrn.397.1581287777837;
        Sun, 09 Feb 2020 14:36:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i16sm12964475wrr.71.2020.02.09.14.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:36:17 -0800 (PST)
Message-Id: <pull.707.git.git.1581287776574.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Feb 2020 22:36:16 +0000
Subject: [PATCH] ci: ignore rubygems warning in the "Documentation" job
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A recent update in the Linux VM images used by Azure Pipelines surfaced
a new problem in the "Documentation" job. Apparently, this warning
appears 396 times on `stderr` when running `make doc`:

/usr/lib/ruby/vendor_ruby/rubygems/defaults/operating_system.rb:10: warning: constant Gem::ConfigMap is deprecated

This problem was already reported to the `rubygems` project via
https://github.com/rubygems/rubygems/issues/3068.

As there is nothing Git can do about this warning, and as the
"Documentation" job reports this warning as a failure, let's just
silence it and move on.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix CI/PR failures in the "Documentation" job
    
    It would probably make sense to apply this to maint, too, as it will
    cause CI failures even if there is nothing actionable to be done to 
    really fix this on Git's side.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-707%2Fdscho%2Fworkaround-for-rubygems-using-deprecated-component-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-707/dscho/workaround-for-rubygems-using-deprecated-component-v1
Pull-Request: https://github.com/git/git/pull/707

 ci/test-documentation.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index b3e76ef863..de41888430 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -7,6 +7,7 @@
 
 filter_log () {
 	sed -e '/^GIT_VERSION = /d' \
+	    -e "/constant Gem::ConfigMap is deprecated/d" \
 	    -e '/^    \* new asciidoc flags$/d' \
 	    -e '/stripped namespace before processing/d' \
 	    -e '/Attributed.*IDs for element/d' \

base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
-- 
gitgitgadget
