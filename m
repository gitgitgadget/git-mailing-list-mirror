Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE0781F453
	for <e@80x24.org>; Thu,  4 Oct 2018 23:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeJEF51 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 01:57:27 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:44811 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeJEF50 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 01:57:26 -0400
Received: by mail-qk1-f202.google.com with SMTP id w126-v6so10023907qka.11
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 16:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q3vaXquMBRR1IKS411UnOKKvXcrNh0MtJBwabO6K+oA=;
        b=MU277sc1fxt8foWYBivxG+Ic2gVSBaCMbniVzNu/cxlYGawwc/71XHQRfaAILiEPLQ
         F1/gCWDoBod19pZRng8OQh5h/IbIZve/Y+u4V0/Kv8kkjyM3+V5DgpS2WttixZ98Uplj
         gWZXOPy29xrehULjiYD9sXLo0iu/d1FHNqEswUOcJBOdclb4bHsHSIpFzYKqhrmqldEU
         uQOzbeiNu1aj6GGqlhfwp3hiMNheo2MxZQ4ymsJ3GD5NcMQvg0fulEEiDj/uuXvGocgv
         hvwydn2mXAjNqMm4tITk4key7JL64bN/imgLUwcyKcbHGEGePFIRPCvvvva0bZNQU/t9
         7rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q3vaXquMBRR1IKS411UnOKKvXcrNh0MtJBwabO6K+oA=;
        b=X83JhJ//SN8n0MqCAGlxFTUj9+cr/LiB/hR3V8VRjLITtf7gUYQZowgEXxCbXBoW8F
         iiW1uYbCYL6Eb1HneCLBEFvsUE7PKYcYoQWXRGVT5owiPAfFW/jTOq+a4fxu++kcd/PC
         xVyzneqnlzBWa05duXEIguQb0KPazZRH/aGI8Le5vhLeOwYVZcE8DWQ3zwocoO39cVbf
         U4o192o1Z9mQiFk7NFqGM3/h15E9gTl1J8NXeoVj5W1o/Pbdx40oceMOYHHHvvFFtix5
         wYrva6laJVLlBSKlhgSoijYMUyVkAz4jW+lnpp9hMxUCKm0qV5IhksOq58l4etMfxX/u
         eaDw==
X-Gm-Message-State: ABuFfojtWM/9QpULGFZbDjTn6HlQo1kV09TKPpqZzUKaCosjLY+czM5F
        kzVRQQipW/MA6R3EysQV+WBNlQc28s3nzZfZK6HBD7Sue7OoKFiA6NuOybVP3mhXJGb/c8uedCJ
        wW7wPmhpwE6+dK3QWNttp5px+5vB2QU2AWdygwS3awUX26wtSeGpH/BBUMmhncUI=
X-Google-Smtp-Source: ACcGV622gJV2xKaPO3h+1SXpvHyZ//g7Idc8O+hgL0L/rVktAAhcK00rXIZxJ5Goqx1xUShdhbzenP03P/xemA==
X-Received: by 2002:ac8:160d:: with SMTP id p13-v6mr6213078qtj.62.1538694106424;
 Thu, 04 Oct 2018 16:01:46 -0700 (PDT)
Date:   Thu,  4 Oct 2018 16:01:28 -0700
In-Reply-To: <cover.1538693039.git.steadmon@google.com>
Message-Id: <bfe4f2f965528ca2a45864857051b9835970ff07.1538693039.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1538693039.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [RFC PATCH 1/2] fuzz: Add basic fuzz testing target.
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .gitignore          |  2 ++
 Makefile            | 30 +++++++++++++++++++++++++++++-
 fuzz-pack-headers.c | 14 ++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 fuzz-pack-headers.c

diff --git a/.gitignore b/.gitignore
index 9d1363a1eb..87a28b3115 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,5 @@
+/fuzz_corpora
+/fuzz-pack-headers
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
 /GIT-LDFLAGS
diff --git a/Makefile b/Makefile
index 13e1c52478..10bb82b115 100644
--- a/Makefile
+++ b/Makefile
@@ -590,6 +590,8 @@ XDIFF_OBJS =
 VCSSVN_OBJS =
 GENERATED_H =
 EXTRA_CPPFLAGS =
+FUZZ_OBJS =
+FUZZ_PROGRAMS =
 LIB_OBJS =
 PROGRAM_OBJS =
 PROGRAMS =
@@ -682,6 +684,10 @@ SCRIPTS = $(SCRIPT_SH_INS) \
 
 ETAGS_TARGET = TAGS
 
+FUZZ_OBJS += fuzz-pack-headers.o
+
+FUZZ_PROGRAMS += $(patsubst %.o,%,$(FUZZ_OBJS))
+
 # Empty...
 EXTRA_PROGRAMS =
 
@@ -2250,6 +2256,7 @@ TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST
 OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
 	$(XDIFF_OBJS) \
 	$(VCSSVN_OBJS) \
+	$(FUZZ_OBJS) \
 	common-main.o \
 	git.o
 ifndef NO_CURL
@@ -2931,7 +2938,7 @@ profile-clean:
 cocciclean:
 	$(RM) contrib/coccinelle/*.cocci.patch*
 
-clean: profile-clean coverage-clean cocciclean
+clean: profile-clean coverage-clean cocciclean fuzz-clean
 	$(RM) *.res
 	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
@@ -3061,3 +3068,24 @@ cover_db: coverage-report
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
 
+
+### Fuzz testing
+#
+.PHONY: fuzz-clean fuzz-objs fuzz-compile
+
+FUZZ_CFLAGS = $(CFLAGS) -fsanitize-coverage=trace-pc-guard -fsanitize=address
+FUZZ_LDFLAGS = $(FUZZ_CFLAGS)
+
+
+fuzz-clean:
+	$(RM) $(FUZZ_PROGRAMS) $(FUZZ_OBJS)
+
+fuzz-objs: $(FUZZ_OBJS)
+
+fuzz-compile:
+	$(MAKE) CC=clang LD=clang CFLAGS="$(FUZZ_CFLAGS)" \
+		LDFLAGS="$(FUZZ_LDFLAGS)" all fuzz-objs
+
+$(FUZZ_PROGRAMS): fuzz-compile
+	clang++ $(FUZZ_LDFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) $(XDIFF_OBJS) \
+		$(EXTLIBS) git.o $@.o /usr/lib/llvm-4.0/lib/libFuzzer.a -o $@
diff --git a/fuzz-pack-headers.c b/fuzz-pack-headers.c
new file mode 100644
index 0000000000..99da1d0fd3
--- /dev/null
+++ b/fuzz-pack-headers.c
@@ -0,0 +1,14 @@
+#include "packfile.h"
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	enum object_type type;
+	unsigned long len;
+
+	unpack_object_header_buffer((const unsigned char *)data,
+				    (unsigned long)size, &type, &len);
+
+	return 0;
+}
-- 
2.19.0.605.g01d371f741-goog

