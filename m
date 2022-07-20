Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C779C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 21:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiGTVWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiGTVWT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E555C34D
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bk26so27858424wrb.11
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e4eobxA9sPR5tQWe0XReWzQLvkWeuuc8MhTEbNK9l1E=;
        b=mMGi62QlLQ6U/lPV1cAa9UJxEqS2oJ2FaAIGTFXGvADLfitv/mMNGlsQd8Ks62RJ4M
         Gowr0FirwlTYYsM2b8+AQCNCjHk/uatEDqh0m8JL/leCemueewZRTxoy1ypiqNOz9l5k
         tnJw9l76yfhd/m42Kx2VBsp+NCzr9SlHUcPU2huA+8xOp+TZ+ydZBPvyOLO9ruypSvmK
         227+yNG/ucf0l5iWZgENHUkxxmGlaJ//JiOlqhVbp+7OqrkTz+ocjkYKKNfQd6OQKlmI
         KYWMv6THnyIMaC4Vb/8Yk9X9THS+HqtvyV4+bR82Fz7DlQzqkMhGUOhi1uhMW5CwWkn7
         bC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e4eobxA9sPR5tQWe0XReWzQLvkWeuuc8MhTEbNK9l1E=;
        b=OrLXNipwyS2918W17Mz5ChxiEFUKNuDMKyQlFKerQld7eHLgXsMl0wrUbKMLBiz5hx
         TzLPWhI32iJfpv/uVLufbfc906QMWDAXWaQl6LuNYvPHZ0YnjrkLwhZbBTAQFOBQSanG
         IMEsR0SwVQ2vj0byCahDh5GfGpHeUM/rBfiRzUyRFkq29mrQDsQq0FlKxAAsUNok5CXi
         tejt5hLM78H6ZtZxAtC7bB1BMkxwXpTKmZxMbPYmuxeqh5RWNjTY5MOuJx52BWUlZYJr
         FefCgfM772w8Fop/f7Gch5LFQ68PTXvdOrbWmt3S+w5j76KXGgYCBKK9TVop1zjadQYv
         cPaw==
X-Gm-Message-State: AJIora8D3ry7HwgmAPQEvtI9AVHg+r2MVR3yeC7Yse8ZF+ZXVK+gLoZr
        xmrU2uhH2/lnv4b90BLsuNnW37R6ahpqYQ==
X-Google-Smtp-Source: AGRyM1uylqokFHmjj7SY6xjDxrFFQCCyWzRF9l0Dsv+8533oj7vUtxMKiT0onee6HPXt54pFugc+lg==
X-Received: by 2002:a5d:6d8b:0:b0:21d:a6ac:b34b with SMTP id l11-20020a5d6d8b000000b0021da6acb34bmr32593120wrs.35.1658352133143;
        Wed, 20 Jul 2022 14:22:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a0375c4f73sm3605441wmj.44.2022.07.20.14.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:22:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/14] t/Makefile: don't remove test-results in "clean-except-prove-cache"
Date:   Wed, 20 Jul 2022 23:21:45 +0200
Message-Id: <patch-v2-07.14-0723e90df7b-20220720T211221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1064.gc96144cf387
In-Reply-To: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "make test" is run with the default of "DEFAULT_TEST_TARGET=test"
we'll leave the "test-results" directory in-place, but don't do so for
the "prove" target.

The reason for this is that when 28d836c8158 (test: allow running the
tests under "prove", 2010-10-14) allowed for running the tests under
"prove" there was no point in leaving the "test-results" in place.

The "prove" target provides its own summary, so we don't need to run
"aggregate-results", which is the reason we have "test-results" in the
first place. See 2d84e9fb6d2 (Modify test-lib.sh to output stats to
t/test-results/*, 2008-06-08).

But in a subsequent commit test-lib.sh will start emitting reports of
memory leaks in test-results/*, and it will be useful to analyze these
after the fact.

This wouldn't be a problem as failing tests will halt the removal of
the files (we'll never reach "clean-except-prove-cache" from the
"prove" target), but will be subsequently as we'll want to report a
successful run, but might still have e.g. logs of known memory leaks
in test-results/*.

So let's stop removing this, it's sufficient that "make clean" removes
it, and that "pre-clean" (which both "test" and "prove" depend on)
will remove it, i.e. we'll never have a stale "test-results" because
of this change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/scalar/t/Makefile  | 2 +-
 contrib/subtree/t/Makefile | 2 +-
 t/Makefile                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/scalar/t/Makefile b/contrib/scalar/t/Makefile
index 01e82e56d15..1ed174a8cf3 100644
--- a/contrib/scalar/t/Makefile
+++ b/contrib/scalar/t/Makefile
@@ -42,7 +42,7 @@ $(T):
 	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
 clean-except-prove-cache:
-	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
+	$(RM) -r 'trash directory'.*
 	$(RM) -r valgrind/bin
 
 clean: clean-except-prove-cache
diff --git a/contrib/subtree/t/Makefile b/contrib/subtree/t/Makefile
index 276898eb6bd..3d278bb0edb 100644
--- a/contrib/subtree/t/Makefile
+++ b/contrib/subtree/t/Makefile
@@ -47,7 +47,7 @@ pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 
 clean-except-prove-cache:
-	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
+	$(RM) -r 'trash directory'.*
 	$(RM) -r valgrind/bin
 
 clean: clean-except-prove-cache
diff --git a/t/Makefile b/t/Makefile
index 7f56e52f767..1c80c0c79a0 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -62,7 +62,7 @@ pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 
 clean-except-prove-cache: clean-chainlint
-	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
+	$(RM) -r 'trash directory'.*
 	$(RM) -r valgrind/bin
 
 clean: clean-except-prove-cache
-- 
2.37.1.1064.gc96144cf387

