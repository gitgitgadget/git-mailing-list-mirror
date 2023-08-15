Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46384C001B0
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 09:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbjHOJmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 05:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbjHOJln (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 05:41:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6D8A6
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 02:41:41 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso8605346e87.2
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 02:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692092499; x=1692697299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O/YGXg6N+d7/H51Djx5ERaGs8GUyc5L6AfVzB1Aqpbg=;
        b=aE6+ay2uJS/atVVU4JGmU1kuUBOms0D2oIYnf6mAAi2ZyyoDLXGSYFwI18DmuCGXQb
         bHnZLWVbYu55dPSba4D54ONlg89EdxFt1TXhH+MlDH8bdXvtczrRgQm8H1746BvQCZ/7
         nG3SW4GuJYYUk2XF7hDPkXFnETEyWPOgAXfiQi7GCWMMWcNUE+46WHYbe3fLAX+0tfqi
         AxEGhebmkhKNRr5PObfoFOiyF1phyY39JxAZDgrD0KGVC5BjRVfUDTQRQXLP2sB3++Kg
         sG9OZL8NBG+RLCfoOLk3mm2NfZ+SY2Kht0T3eyzld+S1zu9xrzQ+u3uu3m/rJGpBkBrY
         DqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692092499; x=1692697299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/YGXg6N+d7/H51Djx5ERaGs8GUyc5L6AfVzB1Aqpbg=;
        b=ddg7TAz5p72HgrDw3lf6cw55Ccuy9LfHpYVACJotHUxIB8FSI0eFLOHCsKM+X3tEdU
         Km23/CFobcFw/t8kqwBcmcJc3kIKiFlZrKCFt+tes8kNGLFSqXNgUx88IRau+j9ov8uc
         F2EhTjf4uIlLpQTKQ5aB9jhqNMDz2Htcf2BfXLp7Fxw4ltYui4fgMBsC/99AK3PU7JdB
         sb1gNEMqBlm8xVX1QLe1IFYG0Qu75fkkbpAODC9lZpCw6eV6mqu753TmrR0A7q6QpIga
         M57VHOjnJ0cf6qBGMj5dtwA9ApL0z4iKEOf+R3Ke8f1c9LlCDMKstpJwytz8sHYjbODC
         CLaA==
X-Gm-Message-State: AOJu0Yy1dEDrx9vBN2h3EalcYWR/oUar39s7Yz8/KbXGEOoUhvF+t3yJ
        BSvQ58gmLPQpeHftUx/NKFU=
X-Google-Smtp-Source: AGHT+IHfaWbsZI7OhXpvhUOShBR33siN7ftl76uPT2tXy3t0G8pqZOKnIOs8/tTa2TRVoIG2pklqvQ==
X-Received: by 2002:a05:6512:36d3:b0:4fe:1d88:2c61 with SMTP id e19-20020a05651236d300b004fe1d882c61mr6745288lfs.32.1692092498831;
        Tue, 15 Aug 2023 02:41:38 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id u10-20020a05600c210a00b003fc02e8ea68sm19979947wml.13.2023.08.15.02.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 02:41:38 -0700 (PDT)
Message-ID: <a0f04bd7-3a1e-b303-fd52-eee2af4d38b3@gmail.com>
Date:   Tue, 15 Aug 2023 10:41:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 0/7] Introduce Git Standard Library
Content-Language: en-US
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     nasamuffin@google.com, chooglen@google.com,
        jonathantanmy@google.com, linusa@google.com, vdye@github.com
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230810163346.274132-1-calvinwan@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230810163346.274132-1-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 10/08/2023 17:33, Calvin Wan wrote:
> Original cover letter:
> https://lore.kernel.org/git/20230627195251.1973421-1-calvinwan@google.com/
> 
> In the initial RFC, I had a patch that removed the trace2 dependency
> from usage.c so that git-std-lib.a would not have dependencies outside
> of git-std-lib.a files. Consequently this meant that tracing would not
> be possible in git-std-lib.a files for other developers of Git, and it
> is not a good idea for the libification effort to close the door on
> tracing in certain files for future development (thanks Victoria for
> pointing this out). That patch has been removed and instead I introduce
> stubbed out versions of repository.[ch] and trace2.[ch] that are swapped
> in during compilation time (I'm no Makefile expert so any advice on how
> on I could do this better would be much appreciated). These stubbed out
> files contain no implementations and therefore do not have any
> additional dependencies, allowing git-std-lib.a to compile with only the
> stubs as additional dependencies.

I think stubbing out trace2 is a sensible approach. I don't think we
need separate headers when using the stub though, or a stub for
repository.c as we don't call any of the functions declared in that
header. I've appended a patch that shows a simplified stub. It also
removes the recursive make call as it no-longer needs to juggle the
header files.

> This also has the added benefit of
> removing `#ifdef GIT_STD_LIB` macros in C files for specific library
> compilation rules. Libification shouldn't pollute C files with these
> macros. The boundaries for git-std-lib.a have also been updated to
> contain these stubbed out files.

Do you have any plans to support building with gettext support so we
can use git-std-lib.a as a dependency of libgit.a?
  
> I have also made some additional changes to the Makefile to piggy back
> off of our existing build rules for .c/.o targets and their
> dependencies. As I learn more about Makefiles, I am continuing to look
> for ways to improve these rules. Eventually I would like to be able to
> have a set of rules that future libraries can emulate and is scalable
> in the sense of not creating additional toil for developers that are not
> interested in libification.

I'm not sure reusing LIB_OBJS for different targets is a good idea.
Once libgit.a starts to depend on git-std-lib.a we'll want to build them
both with a single make invocation without resorting to recursive make
calls. I think we could perhaps make a template function to create the
compilation rules for each library - see the end of
https://wingolog.org/archives/2023/08/08/a-negative-result

Best Wishes

Phillip

---- >8 -----
 From 194403e42f116cc3c6ed8eb8b03d6933b24067e4 Mon Sep 17 00:00:00 2001
From: Phillip Wood <phillip.wood@dunelm.org.uk>
Date: Sat, 12 Aug 2023 17:27:23 +0100
Subject: [PATCH] git-std-lib: simplify sub implementation

The code in std-lib does not depend directly on the functions declared
in repository.h and so it does not need to provide stub
implementations of the functions declared in repository.h. There is a
transitive dependency on `struct repository` from the functions
declared in trace2.h but the stub implementation of those functions
can simply define its own stub for struct repository. There is also no
need to use different headers when compiling against the stub
implementation of trace2.

This means we can simplify the stub implementation by removing
stubs/{repository.[ch],trace2.h} and simplify the Makefile by removing
the code that replaces header files when compiling against the trace2
stub. git-std-lib.a can now be built by running

   make git-std-lib.a GIT_STD_LIB=YesPlease STUB_TRACE2=YesPlease

There is one other small fixup in this commit:

  - `wrapper.c` includes `repository.h` but does not use any of the
    declarations.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
  Makefile           | 29 +-------------------
  stubs/repository.c |  4 ---
  stubs/repository.h |  8 ------
  stubs/trace2.c     |  5 ++++
  stubs/trace2.h     | 68 ----------------------------------------------
  wrapper.c          |  1 -
  6 files changed, 6 insertions(+), 109 deletions(-)
  delete mode 100644 stubs/repository.c
  delete mode 100644 stubs/repository.h
  delete mode 100644 stubs/trace2.h

diff --git a/Makefile b/Makefile
index a821d73c9d0..8eff4021025 100644
--- a/Makefile
+++ b/Makefile
@@ -1209,10 +1209,6 @@ LIB_OBJS += usage.o
  LIB_OBJS += utf8.o
  LIB_OBJS += wrapper.o
  
-ifdef STUB_REPOSITORY
-STUB_OBJS += stubs/repository.o
-endif
-
  ifdef STUB_TRACE2
  STUB_OBJS += stubs/trace2.o
  endif
@@ -3866,31 +3862,8 @@ fuzz-all: $(FUZZ_PROGRAMS)
  ### Libified Git rules
  
  # git-std-lib
-# `make git-std-lib GIT_STD_LIB=YesPlease STUB_REPOSITORY=YesPlease STUB_TRACE2=YesPlease`
+# `make git-std-lib.a GIT_STD_LIB=YesPlease STUB_TRACE2=YesPlease`
  STD_LIB = git-std-lib.a
  
  $(STD_LIB): $(LIB_OBJS) $(COMPAT_OBJS) $(STUB_OBJS)
  	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
-
-TEMP_HEADERS = temp_headers/
-
-git-std-lib:
-# Move headers to temporary folder and replace them with stubbed headers.
-# After building, move headers and stubbed headers back.
-ifneq ($(STUB_OBJS),)
-	mkdir -p $(TEMP_HEADERS); \
-	for d in $(STUB_OBJS); do \
-		BASE=$${d%.*}; \
-		mv $${BASE##*/}.h $(TEMP_HEADERS)$${BASE##*/}.h; \
-		mv $${BASE}.h $${BASE##*/}.h; \
-	done; \
-	$(MAKE) $(STD_LIB); \
-	for d in $(STUB_OBJS); do \
-		BASE=$${d%.*}; \
-		mv $${BASE##*/}.h $${BASE}.h; \
-		mv $(TEMP_HEADERS)$${BASE##*/}.h $${BASE##*/}.h; \
-	done; \
-	rm -rf temp_headers
-else
-	$(MAKE) $(STD_LIB)
-endif
diff --git a/stubs/repository.c b/stubs/repository.c
deleted file mode 100644
index f81520d083a..00000000000
--- a/stubs/repository.c
+++ /dev/null
@@ -1,4 +0,0 @@
-#include "git-compat-util.h"
-#include "repository.h"
-
-struct repository *the_repository;
diff --git a/stubs/repository.h b/stubs/repository.h
deleted file mode 100644
index 18262d748e5..00000000000
--- a/stubs/repository.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef REPOSITORY_H
-#define REPOSITORY_H
-
-struct repository { int stub; };
-
-extern struct repository *the_repository;
-
-#endif /* REPOSITORY_H */
diff --git a/stubs/trace2.c b/stubs/trace2.c
index efc3f9c1f39..7d894822288 100644
--- a/stubs/trace2.c
+++ b/stubs/trace2.c
@@ -1,6 +1,10 @@
  #include "git-compat-util.h"
  #include "trace2.h"
  
+struct child_process { int stub; };
+struct repository { int stub; };
+struct json_writer { int stub; };
+
  void trace2_region_enter_fl(const char *file, int line, const char *category,
  			    const char *label, const struct repository *repo, ...) { }
  void trace2_region_leave_fl(const char *file, int line, const char *category,
@@ -19,4 +23,5 @@ void trace2_data_intmax_fl(const char *file, int line, const char *category,
  			   const struct repository *repo, const char *key,
  			   intmax_t value) { }
  int trace2_is_enabled(void) { return 0; }
+void trace2_counter_add(enum trace2_counter_id cid, uint64_t value) { }
  void trace2_collect_process_info(enum trace2_process_info_reason reason) { }
diff --git a/stubs/trace2.h b/stubs/trace2.h
deleted file mode 100644
index 836a14797cc..00000000000
--- a/stubs/trace2.h
+++ /dev/null
@@ -1,68 +0,0 @@
-#ifndef TRACE2_H
-#define TRACE2_H
-
-struct child_process { int stub; };
-struct repository;
-struct json_writer { int stub; };
-
-void trace2_region_enter_fl(const char *file, int line, const char *category,
-			    const char *label, const struct repository *repo, ...);
-
-#define trace2_region_enter(category, label, repo) \
-	trace2_region_enter_fl(__FILE__, __LINE__, (category), (label), (repo))
-
-void trace2_region_leave_fl(const char *file, int line, const char *category,
-			    const char *label, const struct repository *repo, ...);
-
-#define trace2_region_leave(category, label, repo) \
-	trace2_region_leave_fl(__FILE__, __LINE__, (category), (label), (repo))
-
-void trace2_data_string_fl(const char *file, int line, const char *category,
-			   const struct repository *repo, const char *key,
-			   const char *value);
-
-#define trace2_data_string(category, repo, key, value)                       \
-	trace2_data_string_fl(__FILE__, __LINE__, (category), (repo), (key), \
-			      (value))
-
-void trace2_cmd_ancestry_fl(const char *file, int line, const char **parent_names);
-
-#define trace2_cmd_ancestry(v) trace2_cmd_ancestry_fl(__FILE__, __LINE__, (v))
-
-void trace2_cmd_error_va_fl(const char *file, int line, const char *fmt,
-			    va_list ap);
-
-#define trace2_cmd_error_va(fmt, ap) \
-	trace2_cmd_error_va_fl(__FILE__, __LINE__, (fmt), (ap))
-
-
-void trace2_cmd_name_fl(const char *file, int line, const char *name);
-
-#define trace2_cmd_name(v) trace2_cmd_name_fl(__FILE__, __LINE__, (v))
-
-void trace2_thread_start_fl(const char *file, int line,
-			    const char *thread_base_name);
-
-#define trace2_thread_start(thread_base_name) \
-	trace2_thread_start_fl(__FILE__, __LINE__, (thread_base_name))
-
-void trace2_thread_exit_fl(const char *file, int line);
-
-#define trace2_thread_exit() trace2_thread_exit_fl(__FILE__, __LINE__)
-
-void trace2_data_intmax_fl(const char *file, int line, const char *category,
-			   const struct repository *repo, const char *key,
-			   intmax_t value);
-
-#define trace2_data_intmax(category, repo, key, value)                       \
-	trace2_data_intmax_fl(__FILE__, __LINE__, (category), (repo), (key), \
-			      (value))
-
-enum trace2_process_info_reason {
-	TRACE2_PROCESS_INFO_STARTUP,
-	TRACE2_PROCESS_INFO_EXIT,
-};
-int trace2_is_enabled(void);
-void trace2_collect_process_info(enum trace2_process_info_reason reason);
-
-#endif /* TRACE2_H */
diff --git a/wrapper.c b/wrapper.c
index 9eae4a8b3a0..e6facc5ff0c 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -5,7 +5,6 @@
  #include "abspath.h"
  #include "parse.h"
  #include "gettext.h"
-#include "repository.h"
  #include "strbuf.h"
  #include "trace2.h"
  
-- 
2.40.1.850.ge5e148ffb7d


