Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935511FF76
	for <e@80x24.org>; Wed, 14 Dec 2016 09:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755175AbcLNJ1x (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 04:27:53 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36111 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755020AbcLNJ1w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 04:27:52 -0500
Received: by mail-pf0-f195.google.com with SMTP id c4so893792pfb.3
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 01:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fQ2l6RUysEVZbm/9+HzInonTjdI0HTaK4halejf2o+I=;
        b=uEbq1e+aMGa80A84erHmHysuo0N/TcKJYsyXRRhw80tqnI6M9reiSi06k99I1YmDAZ
         qrs20LoOIO3zrqZYMCh0YocZ3YAuXLXXD5VkP93Cx3HgjtW7KUEn4Oloj3dzGnebMqrh
         U2vzAzSJZWhImXqBv/gQ3rLTiJlVcCHltsMjv7wu5pi4+e4KkOtbVbXh0spLSz7pcTxL
         9hDQsxnlK0bQvEZi5HIl1Nw2a/Sere/8WsR0VtJuMWHqdDgOZ3XEvyb1Rzeb/AaZSjl6
         g4AjC2vwC9R40CGk1Jtr0DN0ER6MNXIsTGMPh7wNjhSO3C/x2y9j1jff/gTBsFPP1Bvt
         tOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fQ2l6RUysEVZbm/9+HzInonTjdI0HTaK4halejf2o+I=;
        b=CqV0nskrB8IzMrX9n1WlfctHE6pq5HrQEYlN5HnLdnOO1r/haVb7cNh5bFvmp8WGLp
         c9N/vxm74uSOPPrRxKIwzAPUmqgD+K9NyGZLWIQ+bW8Dd7wPT+oCBC+ARfo+7uqrkYOA
         D5hdknoBpXNslxVoa68bgQx9l3kFqxTa9MhctDvlG5xyj9NotONLU1Fg5wOJlWaKQhfQ
         y72NuJgqEKvwgxxanaJg8Pi6HM4rtRs1EZS2uZyrBq5BrSNfvull8c99Vk5k0UqieSi0
         RtHosoiXrTXQyMSY+WVH4dxoyd6eedJSEnxqGTaiKL8qM/sS9VDigMjZg3GKiuPxNBih
         tPiw==
X-Gm-Message-State: AKaTC029A6Fo8pu3Jluj0DMLXuSpayZh0ON0xmjp3OGKG2eEr6fFh/ocbUncESpNjk7LIA==
X-Received: by 10.84.130.5 with SMTP id 5mr187752102plc.69.1481707664251;
        Wed, 14 Dec 2016 01:27:44 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:50cb:a0f2:6faa:ea3b])
        by smtp.gmail.com with ESMTPSA id s3sm85744387pfg.14.2016.12.14.01.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 01:27:43 -0800 (PST)
From:   Chris Packham <judge.packham@gmail.com>
To:     git@vger.kernel.org
Cc:     stefan.naewe@atlas-elektronik.com, peff@peff.net,
        gitter.spiros@gmail.com, Chris Packham <judge.packham@gmail.com>
Subject: [RFC/PATCHv2] Makefile: add cppcheck target
Date:   Wed, 14 Dec 2016 22:27:31 +1300
Message-Id: <20161214092731.29076-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.11.0.24.ge6920cf
In-Reply-To: <20161213092225.15299-1-judge.packham@gmail.com>
References: <20161213092225.15299-1-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add cppcheck target to Makefile. Cppcheck is a static
analysis tool for C/C++ code. Cppcheck primarily detects
the types of bugs that the compilers normally do not detect.
It is an useful target for doing QA analysis.

To run the default set of checks run

   make cppcheck

Additional checks can be enabled by specifying CPPCHECK_ADD. This is a
comma separated list which is passed to cppcheck's --enable option. To
enable style and warning checks run

  make cppcheck CPPCHECK_ADD=style,warning

Based-on-patch-by: Elia Pinto <gitter.spiros@gmail.com>
Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
Changes in v2:
- only run over actual git source files.
- omit any files in t/
- print cppcheck version to allow for better comparison between
  different build environments
- introduce CPPCHECK_FLAGS which can be overridden in the make command
  line. This also uses a GNU make-ism to allow CPPCHECK_ADD to specify
  additional checks to be enabled.

 Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index f53fcc90d..e5c86decf 100644
--- a/Makefile
+++ b/Makefile
@@ -2635,3 +2635,12 @@ cover_db: coverage-report
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
 
+.PHONY: cppcheck
+
+CPPCHECK_FLAGS = --force --quiet --inline-suppr $(if $(CPPCHECK_ADD),--enable=$(CPPCHECK_ADD))
+
+cppcheck:
+	@cppcheck --version
+	$(FIND_SOURCE_FILES) | \
+	grep -v '^t/t' | \
+	xargs cppcheck $(CPPCHECK_FLAGS)
-- 
2.11.0.24.ge6920cf

