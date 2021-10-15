Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B71C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE7526109E
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbhJOMmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238950AbhJOMlg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 08:41:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8C4C06176C
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:39:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e12so26298673wra.4
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yj1xoPoZLbU6MI6lSmqKh5gcjx9to9DH0nufRlyP5mo=;
        b=p1hATu7mVJiwpyBQPX0qOl8lZ4wMY+1pbD8rjPGPy52w/fMz1oylAKOADJ/kX3SQwU
         ulR8vPM9A74RSKRkS9w05RjmNoBhjxfC9KiwItzrkrBP5bxMYe781mXYH98q9OWG4Chr
         1nxXxLABtEqZEjJxVIGLPZgp03vOKo2CK+tvpIR88iL5IF15JePA3YlfZRUVkErvsYX0
         DmYxgTpx8XwdzrRCAeOeHxqHKuR8VvZUqdvoOxHBvrFHhHoBJHjXd1calPu+5fG39GN5
         WY36YT/HaGYeBFFt1Nm5w4df4CPZHOxcJX3Cs6B+0r2bhSt1IvX+fSO3Am1hlcZbXD2W
         3MlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yj1xoPoZLbU6MI6lSmqKh5gcjx9to9DH0nufRlyP5mo=;
        b=YlR0ezgyunE3Rz29cbqVBpAT/kn4+HEo11jvY6sFV+RLUhwRkH1PX2O5h2f8fRaYSC
         8R3MTWvmdcdDA2Enk138BCmtSqfS/2z3ncWiJsAM5dxOSOPU97LZ2X/PehJEdLqSq5+Q
         NoVDgItGBnhFNSf/Y3a53TKBdkOSDkF/dCq8CcAwBq+/SPBCJnBtC15UeEj5KfpsaP5d
         OBFIK5HAz/gkeilqdCyXCYPwiSdAcNGFLpSCIie2L0x1HEJKIRAxM8neR5SLw3a6CH6B
         FTaScOhtIffSYWWyz83uC40ot2bR2abqdjx/vUsMoVed6utd0YvOsjETez+5NbObiYVf
         hasw==
X-Gm-Message-State: AOAM530hufIlYFxbHB8xs/Mq+pImB3Eteqt6bturHViro2JrkzJlijvT
        JkPn/NIuRirxIGYmFfIahCFDR/w0b/gyEQ==
X-Google-Smtp-Source: ABdhPJygtOffLWZtvPB+xoKLzSk1vITaT2TuopYwuGodxj9rsu7BPRUk4vxC3lokqgQMRdrRpXZ2yg==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr2458794wro.298.1634301558789;
        Fri, 15 Oct 2021 05:39:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d1sm5388824wrr.72.2021.10.15.05.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:39:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] doc build: speed up "make lint-docs"
Date:   Fri, 15 Oct 2021 14:39:13 +0200
Message-Id: <patch-3.4-a02a668ebb3-20211015T123619Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.4-00000000000-20211015T123619Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20211015T123619Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the trick we use to speed up the "clean" target to also extend
to the "lint-docs" target. See 54df87555b1 (Documentation/Makefile:
conditionally include doc.dep, 2020-12-08) for the "clean"
implementation.

The "doc-lint" target only depends on *.txt files, so we don't need to
generate GIT-VERSION-FILE etc. if that's all we're doing. This makes
the "make lint-docs" target more than 2x as fast:

$ git show HEAD~:Documentation/Makefile >Makefile.old
$ hyperfine -L f ",.old" 'make -f Makefile{f} lint-docs'
Benchmark #1: make -f Makefile lint-docs
  Time (mean ± σ):     100.2 ms ±   1.3 ms    [User: 93.7 ms, System: 6.7 ms]
  Range (min … max):    98.4 ms … 103.1 ms    29 runs

Benchmark #2: make -f Makefile.old lint-docs
  Time (mean ± σ):     220.0 ms ±  20.0 ms    [User: 206.0 ms, System: 18.0 ms]
  Range (min … max):   206.6 ms … 267.5 ms    11 runs

Summary
  'make -f Makefile lint-docs' ran
    2.19 ± 0.20 times faster than 'make -f Makefile.old lint-docs'

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 78324934d9f..e8e54e053a6 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -284,7 +284,7 @@ install-html: html
 ../GIT-VERSION-FILE: FORCE
 	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
 
-ifneq ($(MAKECMDGOALS),clean)
+ifneq ($(filter-out lint-docs clean,$(MAKECMDGOALS)),)
 -include ../GIT-VERSION-FILE
 endif
 
-- 
2.33.1.1338.g20da966911a

