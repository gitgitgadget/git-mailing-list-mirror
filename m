Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45B2F1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 19:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbeKOFqX (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 00:46:23 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:37110 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeKOFqX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 00:46:23 -0500
Received: by mail-it1-f202.google.com with SMTP id y86so2880134ita.2
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 11:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KDV0/pt5Wt3O6A9mzlV7MREASemtZELOiRY6eDhh1W4=;
        b=D5R9DIMK0bx0N2v5gxxBS07F4WgDh0WYeKFeChhbPbE0WmCtH++sLn49x4F+7kFBqn
         O6JLtmp3bWjX5XV5bUSbrJYbanMM/OZ5JePwUlLwLcPpdLg2UcFFsjcCnaJQPA+FDYG3
         1X+AXkkaaPciz7a/XLP59yQRvFIkyp7R48F14fpyATnYBrQuQ9oAzggu1RvjgdXWqshu
         CEyEw61xUYWl9d1oYQRSltm094ficDwk3vy27KE00mUGCF1kKXmE+CwQjMsVoChVe03s
         gkY7yT2KJvixLyE5KIs9Fxrz6zyUz5FZ+QSMhXVcVKWArGN/zWAxjuWxLh7QBZYQ4jku
         Y1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KDV0/pt5Wt3O6A9mzlV7MREASemtZELOiRY6eDhh1W4=;
        b=C3YcX6aPIlvZRy2SqaktgWhDsjFCb+MW0bpS+qgch+gR9K9B1KBBCfNgz7O+2SiLZ6
         rZ7yc7EAchMqD9iSHK6ZsSSbutQuasqx/zJ5k2Wq2c474TQQXOtFUJS9IYDmg2zSu1gv
         MaXErdJNr3IOhM/b5niX7eq7+4fqveJwO71fbrW1PG2CH81HsUVkD3wS2Yp8VZNtm+dU
         0w+8RCcc+96wC3txliTV6dLp1aitIwTttDkCh3ZOfvtLU41NZxJmEs//vUq9oX9Gye2F
         fZYCyY3A9UZR48volnxZkleDiMZhixhZ4pE8f8KUImMfPCWihiAwKeI0ctvPI5dQO5PB
         pE8Q==
X-Gm-Message-State: AGRZ1gJDorQ4AafUx2ngANFh0nVN3fRDEizLm8CfEGgTSl1dqX0g9+Zw
        fTPsLm2rRwdw2GdMBJlZgoQNEoZbA60btUqSVDJ6r5CVf44TDSwqTndfEUREU+ebfNpHLEQamQP
        h5bAwO3FFyk0c6L0XFoBy610Au6dua2Ihy5Ht4ayS+1pjB6p5jXv0yOQCYipfwyY=
X-Google-Smtp-Source: AFSGD/WfUtVbLGXLhYGBqGoLl3fUMht+r1nS3ntgqyeSMrww1ADZSFHjZYWs3M22Tlptn8hrBRfGkUH/XlwL3Q==
X-Received: by 2002:a24:9ec3:: with SMTP id p186-v6mr2552455itd.11.1542224510217;
 Wed, 14 Nov 2018 11:41:50 -0800 (PST)
Date:   Wed, 14 Nov 2018 11:41:47 -0800
In-Reply-To: <1630a93f8270ca090459be8cc7213221cc6250cf.1542060094.git.steadmon@google.com>
Message-Id: <6b3d6dd7f0ab9324fcdf1b9322ef7e35d8355964.1542224326.git.steadmon@google.com>
Mime-Version: 1.0
References: <1630a93f8270ca090459be8cc7213221cc6250cf.1542060094.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH v2] Makefile: use FUZZ_CXXFLAGS for linking fuzzers
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OSS-Fuzz requires C++-specific flags to link fuzzers. Passing these in
CFLAGS causes lots of build warnings. Using separate FUZZ_CXXFLAGS
avoids this.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
Since there's nothing else using CXXFLAGS, let's just make it explicit
that these apply to the fuzzers.


Range-diff against v1:
1:  1630a93f82 < -:  ---------- Makefile: use CXXFLAGS for linking fuzzers
-:  ---------- > 1:  6b3d6dd7f0 Makefile: use FUZZ_CXXFLAGS for linking fuzzers

 Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index bbfbb4292d..0c05896797 100644
--- a/Makefile
+++ b/Makefile
@@ -3098,14 +3098,16 @@ cover_db_html: cover_db
 # An example command to build against libFuzzer from LLVM 4.0.0:
 #
 # make CC=clang CXX=clang++ \
-#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
+#      FUZZ_CXXFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
 #      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
 #      fuzz-all
 #
+FUZZ_CXXFLAGS ?= $(CFLAGS)
+
 .PHONY: fuzz-all
 
 $(FUZZ_PROGRAMS): all
-	$(QUIET_LINK)$(CXX) $(CFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
+	$(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
 		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
 
 fuzz-all: $(FUZZ_PROGRAMS)
-- 
2.19.1.930.g4563a0d9d0-goog

