Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89646E7E638
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 14:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjIZOXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjIZOXv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 10:23:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6997BCE
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 07:23:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32167a4adaaso8645610f8f.1
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695738223; x=1696343023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fUioupghc4P1XQsToufSCZKrjOoK4B1LYBpOzPIq0Tc=;
        b=Rhxw6rj+GbVbP1DfaqUdA1tatCCia+pDIZRrhaMabcTaEz/g1zhd1AgquJ6w8uJGOa
         rc0HM+k4zp443k336erungQHEFP3EmuINhnPZITXVQUOVvCg4ZBQxfAiEgAX/TevWYOo
         Vh64SdMo215eqMggLIjKEnsk9/4EBEGASYLiKf4amscHHy3ZMaEWufJruEKJG392c6X2
         cM7MB94y/YQOj0mMzGQxGg00vMqmzqytDyxYM2Qc3yfhBYaKHlRAbAB2a1UD1MYmIdJ4
         NfRoWZRyXNbZvK3zprzLdO3ISaZXA3crTeA/Z0MuvB2O4a3wvHazftDJBL7cuS4QJNPV
         uOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695738223; x=1696343023;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUioupghc4P1XQsToufSCZKrjOoK4B1LYBpOzPIq0Tc=;
        b=WxH9TTim8nDzFmHWuNVXY2pY5NNR6sFbRGkX7F6JYAhl/v0kssHCvVEngw9hsr1P+U
         Yu4uPzM4+fY+EPkF5tsImZixR84PqalTzpGK5nLI51fVyrG3ILQ9Fvl+GDAsrq+/pLWs
         n+2Bv/HMlx9X6Z64Womm0ps6XgszLhhDg+vMb1Yn1cnUzVx+3irAgplKc4lOW5gVsm4y
         zWVMVYApxzAJd8gho+kG3cynas0mKCSutv0Bxl2ht+rvOBbKsPMtMFhI6SSYHgoV7Zsw
         gEKuH+2gN9B0S7h6pFlTSoTuxncPNtRMcYF/SU0DnrIv16sbAdtu2mAmVyGeREcB4Bhy
         90eg==
X-Gm-Message-State: AOJu0YxU5fTUcvEi7apIvjpALWbG2/ZoHpgw78WrOn6VP/s2R+bEmxpK
        USmXduPXAohH2YK9aHMV8NA=
X-Google-Smtp-Source: AGHT+IGyxRpkPUs3mXj6lDwP93smc5z7Kb4gFvaBlcp2UxWCFQb6403H6J5O+rkgDNEFo8FwJJvm/Q==
X-Received: by 2002:a5d:63c5:0:b0:317:e5ec:8767 with SMTP id c5-20020a5d63c5000000b00317e5ec8767mr7939875wrw.21.1695738222547;
        Tue, 26 Sep 2023 07:23:42 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d610b000000b0031435731dfasm14793918wrt.35.2023.09.26.07.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 07:23:42 -0700 (PDT)
Message-ID: <bd88d3ab-b7fd-4a77-851a-d012fec08523@gmail.com>
Date:   Tue, 26 Sep 2023 15:23:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/6] git-std-lib: introduce git standard library
Content-Language: en-US
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     nasamuffin@google.com, jonathantanmy@google.com, linusa@google.com,
        vdye@github.com
References: <20230908174134.1026823-1-calvinwan@google.com>
 <20230908174443.1027716-5-calvinwan@google.com>
In-Reply-To: <20230908174443.1027716-5-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 08/09/2023 18:44, Calvin Wan wrote:
> The Git Standard Library intends to serve as the foundational library
> and root dependency that other libraries in Git will be built off of.
> That is to say, suppose we have libraries X and Y; a user that wants to
> use X and Y would need to include X, Y, and this Git Standard Library.
> 
> Add Documentation/technical/git-std-lib.txt to further explain the
> design and rationale.
> 
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> ---
>   Documentation/technical/git-std-lib.txt | 191 ++++++++++++++++++++++++

I need the following diff to build the html documentation.

Best Wishes

Phillip

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3f2383a12c..f1dc673838 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -110,6 +110,7 @@ TECH_DOCS += SubmittingPatches
  TECH_DOCS += ToolsForGit
  TECH_DOCS += technical/bitmap-format
  TECH_DOCS += technical/bundle-uri
+TECH_DOCS += technical/git-std-lib
  TECH_DOCS += technical/hash-function-transition
  TECH_DOCS += technical/long-running-process-protocol
  TECH_DOCS += technical/multi-pack-index
diff --git a/Documentation/technical/git-std-lib.txt b/Documentation/technical/git-std-lib.txt
index d03b8565b4..28e6cdac2a 100644
--- a/Documentation/technical/git-std-lib.txt
+++ b/Documentation/technical/git-std-lib.txt
@@ -1,5 +1,4 @@
-Git Standard Library
-================
+= Git Standard Library
  
  The Git Standard Library intends to serve as the foundational library
  and root dependency that other libraries in Git will be built off of.
@@ -9,8 +8,7 @@ This does not mean that the Git Standard Library will be the only
  possible root dependency in the future, but rather the most significant
  and widely used one.
  
-Dependency graph in libified Git
-================
+== Dependency graph in libified Git
  
  If you look in the Git Makefile, all of the objects defined in the Git
  library are compiled and archived into a singular file, libgit.a, which
@@ -57,8 +55,7 @@ if someone wanted their own custom build of Git with their own custom
  implementation of the object store, they would only have to swap out
  object-store.a rather than do a hard fork of Git.
  
-Rationale behind Git Standard Library
-================
+== Rationale behind Git Standard Library
  
  The rationale behind what's in and what's not in the Git Standard
  Library essentially is the result of two observations within the Git
@@ -67,8 +64,7 @@ in a couple of different files, and wrapper.c + usage.c have
  difficult-to-separate circular dependencies with each other and other
  files.
  
-Ubiquity of git-compat-util.h and circular dependencies
-========
+=== Ubiquity of git-compat-util.h and circular dependencies
  
  Every file in the Git codebase includes git-compat-util.h. It serves as
  "a compatibility aid that isolates the knowledge of platform specific
@@ -79,10 +75,9 @@ for wrapper.c and usage.c to be a part of the root library. They have
  difficult to separate circular dependencies with each other so they
  can't be independent libraries. Wrapper.c has dependencies on parse.c,
  abspath.c, strbuf.c, which in turn also have dependencies on usage.c and
-wrapper.c -- more circular dependencies.
+wrapper.c - more circular dependencies.
  
-Tradeoff between swappability and refactoring
-========
+=== Tradeoff between swappability and refactoring
  
  From the above dependency graph, we can see that git-std-lib.a could be
  many smaller libraries rather than a singular library. So why choose a
@@ -99,8 +94,7 @@ and change the API for the library if there becomes enough of a reason
  to do so (remember we are avoiding promising stability of the interfaces
  of those libraries).
  
-Reuse of compatibility functions in git-compat-util.h
-========
+=== Reuse of compatibility functions in git-compat-util.h
  
  Most functions defined in git-compat-util.h are implemented in compat/
  and have dependencies limited to strbuf.h and wrapper.h so they can be
@@ -110,8 +104,7 @@ compat/. The rest of the functions defined in git-compat-util.h are
  implemented in top level files and are hidden behind
  an #ifdef if their implementation is not in git-std-lib.a.
  
-Rationale summary
-========
+=== Rationale summary
  
  The Git Standard Library allows us to get the libification ball rolling
  with other libraries in Git. By not spending many
@@ -123,8 +116,7 @@ the code cleanups that have happened so far have been minor and
  beneficial for the codebase. It is probable that making large movements
  would negatively affect code clarity.
  
-Git Standard Library boundary
-================
+== Git Standard Library boundary
  
  While I have described above some useful heuristics for identifying
  potential candidates for git-std-lib.a, a standard library should not
@@ -150,8 +142,7 @@ to be able to trace functions in those files and other files in git-std-lib.a.
  In order for git-std-lib.a to compile with those dependencies, stubbed out
  versions of those files are implemented and swapped in during compilation time.
  
-Files inside of Git Standard Library
-================
+== Files inside of Git Standard Library
  
  The initial set of files in git-std-lib.a are:
  abspath.c
@@ -171,21 +162,19 @@ complete library:
  stubs/pager.c
  stubs/trace2.c
  
-Pitfalls
-================
+== Pitfalls
  
  There are a small amount of files under compat/* that have dependencies
  not inside of git-std-lib.a. While those functions are not called on
  Linux, other OSes might call those problematic functions. I don't see
  this as a major problem, just moreso an observation that libification in
  general may also require some minor compatibility work in the future.
  
-Testing
-================
+== Testing
  
  Unit tests should catch any breakages caused by changes to files in
  git-std-lib.a (i.e. introduction of a out of scope dependency) and new
  functions introduced to git-std-lib.a will require unit tests written
  for them.
  
-[1] https://lore.kernel.org/git/xmqqwn17sydw.fsf@gitster.g/
\ No newline at end of file
+[1] https://lore.kernel.org/git/xmqqwn17sydw.fsf@gitster.g/
