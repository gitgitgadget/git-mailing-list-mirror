Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B21EC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378325AbiBUOri (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:47:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378292AbiBUOr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:29 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2A75FC8
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:56 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so27475428wrg.11
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tD+tWBHdrxVz3ZpPKSudMeRDUxjZwZOPIB8MPEw0wuw=;
        b=SRIBjh0dLJdXLZbFfYchCK/UmEjxUqn4SKD7gwajMJ/111mGqnSs8FOs7HicD2Kde/
         VmeboNoslU+WjS23HKnwfKtwphkgzhcqiPuY7JjYOJKQMZMotrkoLH9DptKGWfX8VVO5
         gTAN2mMTi/PdLzIePZHLFRSmLM48s9n917sHl+eqMwVMryovJ+rIfT1uMkkXAq4lBOrB
         NfdSRP6P7jB96jew6s9mSvdZNeYUaPAe++pOxI8DZZSDQeH7ao581qGtvgHInCdLq7XK
         avuhlc3oX7XO5fIEnau/WFcfHqa9XuEkicpEH/TnNovC/crJ1i2GKxiducXRJYmPeujh
         092w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tD+tWBHdrxVz3ZpPKSudMeRDUxjZwZOPIB8MPEw0wuw=;
        b=rEBkWvx4uERU7J+N9QSPgJeXoe3Yxk9vPX1+Mp052n29FTQUCbVnRqJUaWJctyyx+9
         KMCryUb+Z9l0V3EC21bCfm+Qdy6vHSZ/Tum7cXP0HzDK6zUhlt7VIByKy6U883oCgRgS
         OySX0IigV1xO9k+hX6v7nIBrlQ9refizKi1mhTMz8Yvn25xxBw+m3kX7cLFzBRtUQpzR
         jbJVYsCY5toCsv+/bdnTprjstOBrEir9vPPWAhmFkEqQjiKnEbpymqwMypcRF/8ryxuh
         5FyvQZskQUt/s+dGPaGNksSHDE4zm40hu+Ag2ZoOKtzsl4if2SWroVPYgnhUtF/cU9y8
         1cvQ==
X-Gm-Message-State: AOAM531HTqC6Z34S+Cz9l6gXFg+Wfp4JNdOH1/CS2bmYXg0b5WcuIFD1
        qnyDCkpmzUhj2aQj0FSdAVEsueWz0Fggjg==
X-Google-Smtp-Source: ABdhPJyD69KzfW7syaZvlmTYSoPMu1+ywvYeb9SxLMIgvRCTRRRt2c3WvE1au9h0mqTIu6wVAHWiKw==
X-Received: by 2002:a5d:6145:0:b0:1e3:169c:197c with SMTP id y5-20020a5d6145000000b001e3169c197cmr15787064wrt.611.1645454814915;
        Mon, 21 Feb 2022 06:46:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:46:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/25] CI: have "static-analysis" run "check-builtins", not "documentation"
Date:   Mon, 21 Feb 2022 15:46:20 +0100
Message-Id: <patch-08.25-95cd496868e-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the "make check-builtins" check from the "documentation" job to
the "static-analysis" job.

The "check-builtins" target added in c74390e4a1d (cherry is built-in,
do not ship git-cherry.sh, 2006-11-05) is unrelated to the
documentation, so it's odd that b98712b9aa9 (travis-ci: build
documentation, 2016-05-04) added it to the "documentation" job.

Let's just move it to the "ci-static-analysis" target, and while we're
at it improve the output with $(QUIET_CHECK).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                 | 3 ++-
 ci/test-documentation.sh | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 02cd563e216..0c117d32f48 100644
--- a/Makefile
+++ b/Makefile
@@ -3424,7 +3424,7 @@ check-docs::
 ### Make sure built-ins do not have dups and listed in git.c
 #
 check-builtins::
-	./check-builtins.sh
+	$(QUIET_CHECK)./check-builtins.sh
 
 ### Test suite coverage testing
 #
@@ -3514,5 +3514,6 @@ ci-check-directional-formatting:
 
 .PHONY: ci-static-analysis
 ci-static-analysis: ci-check-directional-formatting
+ci-static-analysis: check-builtins
 ci-static-analysis: check-coccicheck
 ci-static-analysis: hdr-check
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 9e0652c30dd..41e2b126311 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -14,7 +14,6 @@ filter_log () {
 	    "$1"
 }
 
-make check-builtins
 make check-docs
 
 # Build docs with AsciiDoc
-- 
2.35.1.1132.ga1fe46f8690

