Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81F961F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 01:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfAQB3f (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 20:29:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34578 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfAQB3f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 20:29:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so9203928wrw.1
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 17:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ximD/csfx6YRMLDlIHRvsaiixGwvfbeFiPVD6dcTua4=;
        b=kSgjKLvRD+Sser/Co+ZrrlQLmel+zJVWfGFZ23Mgfd6BOJ7ks1GejNhPge02bWfD8h
         +f+J+bodNwcjzKvkNrkeUxIXrvftk7wuI0cwVdWYwWeTjF9H7UuJUyNsw53CgvxCuDoU
         nql+eQyrLUCEbBs79ZJn+eNrooberkQWvasK3tkrE9aM4qw2NmTvX0ewSgbSHTB/c8xN
         JHUV9F/OOrkywJKpVyTzGb8OXgD3lYmVDEpHFKHYvHmE3u2Bv7QuMtYEExNUfr8sOZgO
         /MmbBb5PbWpFmsaCniir7mFxnIEfiOMkualqk+yTxuDZZI8VIT4mCHgBNhA8kSTrOeln
         zhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ximD/csfx6YRMLDlIHRvsaiixGwvfbeFiPVD6dcTua4=;
        b=evokzywBg024+a8oAlkUrscvuzU+XvBYQ7yckChvWJ+GNSkiU8fZ2Y7t1jh5wxPWhx
         rGxauOSh6G43553l0tB0cKviK3iqR97m4rsetKP20Sefl9yTzi4Pi6HpRQpG33p4IT7U
         7b7ZkesERW25H8qP/Gd3Nzp8mS767GysRuIAaeEP9J1KlSI8c/qtpy4t+uDcRexqOHtI
         EXrflvJAgQ+jaZ5VMxYz1uNEJ0tpsaoW/gWvbznyUyhXYhWGS4JPFUMoWvvwQsg727dK
         xS7xE8RQP14kYLlNetgAndllGl8e6q4D5gbLJE/XYQ2fTVFArl8CH1EvWDrp/RZgip/y
         4WEw==
X-Gm-Message-State: AJcUukdA1J0IWjWf6In8EI4WK2F0CHzqyCfJyZZRvxkoK65gMqStt4ko
        wIgia9STOpqlxcfsq/OcDP0=
X-Google-Smtp-Source: ALg8bN5jinOaVXEnwONcNQde/PumjevVTdm00IA4FYG1YasyPE5Y2qEDT+0CTivE7IWe4D4EiJHBBQ==
X-Received: by 2002:adf:b307:: with SMTP id j7mr10352162wrd.46.1547688572159;
        Wed, 16 Jan 2019 17:29:32 -0800 (PST)
Received: from localhost.localdomain (x4db4a994.dyn.telefonica.de. [77.180.169.148])
        by smtp.gmail.com with ESMTPSA id y13sm36818272wme.2.2019.01.16.17.29.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 17:29:31 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/5] travis-ci: build with the right compiler
Date:   Thu, 17 Jan 2019 02:29:08 +0100
Message-Id: <20190117012913.30562-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.499.gf60de1223c
In-Reply-To: <20181220162452.17732-1-szeder.dev@gmail.com>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Ever since we started using Travis CI, some of our Travis CI build
jobs don't use the compiler they are supposed to.  The last patch
explains what's going on and fixes this issue.  The first four patches
are necessary cleanups/fixes to make the fix work.

Changes since v1:

  - In patch 1, renamed the fields in the unions holding those
    function pointers to match how gnulib's obstack calls them

    http://git.savannah.gnu.org/cgit/gnulib.git/commit?id=127ed6a3ea9c46452f079dee50382dc1f70ea796

  - Clarified the commit messages of patches 1 and 5.

v1: https://public-inbox.org/git/20181220162452.17732-1-szeder.dev@gmail.com/T/#u


SZEDER Gábor (5):
  compat/obstack: fix -Wcast-function-type warnings
  .gitignore: ignore external debug symbols from GCC on macOS
  travis-ci: don't be '--quiet' when running the tests
  travis-ci: switch to Xcode 10.1 macOS image
  travis-ci: build with the right compiler

 .gitignore                 |  1 +
 .travis.yml                |  2 ++
 ci/install-dependencies.sh |  5 +++++
 ci/lib-travisci.sh         | 15 ++++++++++++---
 ci/run-build-and-tests.sh  |  4 ++--
 ci/run-linux32-build.sh    |  2 +-
 compat/obstack.c           | 17 +++++++++--------
 compat/obstack.h           | 18 +++++++++++-------
 8 files changed, 43 insertions(+), 21 deletions(-)

Range-diff:
1:  da8f709650 ! 1:  be132420c0 compat/obstack: fix -Wcast-function-type warnings
    @@ -2,9 +2,11 @@
     
         compat/obstack: fix -Wcast-function-type warnings
     
    -    When building Git with GCC 8.2.0 (at least from Homebrew on macOS,
    -    DEVELOPER flags enabled) one is greeted with a screenful of compiler
    -    errors:
    +    GCC 8 introduced the new -Wcast-function-type warning, which is
    +    implied by -Wextra (which, in turn is enabled in our DEVELOPER flags).
    +    When building Git with GCC 8 and this warning enabled on a non-glibc
    +    platform [1], one is greeted with a screenful of compiler
    +    warnings/errors:
     
           compat/obstack.c: In function '_obstack_begin':
           compat/obstack.c:162:17: error: cast between incompatible function types from 'void * (*)(long int)' to 'struct _obstack_chunk * (*)(void *, long int)' [-Werror=cast-function-type]
    @@ -24,9 +26,9 @@
         'struct obstack' stores pointers to two functions to allocate and free
         "chunks", and depending on how obstack is used, these functions take
         either one parameter (like standard malloc() and free() do; this is
    -    how we use it) or two parameters.  Presumably to reduce memory
    -    footprint, a single field is used to store the function pointer for
    -    both signatures, and then it's casted to the appropriate signature
    +    how we use it in 'kwset.c') or two parameters.  Presumably to reduce
    +    memory footprint, a single field is used to store the function pointer
    +    for both signatures, and then it's casted to the appropriate signature
         when the function pointer is accessed.  These casts between function
         pointers with different number of parameters are what trigger those
         compiler errors.
    @@ -37,6 +39,10 @@
         eliminates the need for those casts, and thus avoids this compiler
         error.
     
    +    [1] Compiling 'compat/obstack.c' on a platform with glibc is sort of
    +        a noop, see the comment before '#  define ELIDE_CODE', so this is
    +        not an issue on common Linux distros.
    +
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
      diff --git a/compat/obstack.c b/compat/obstack.c
    @@ -48,17 +54,17 @@
        (((h) -> use_extra_arg) \
     -   ? (*(h)->chunkfun) ((h)->extra_arg, (size)) \
     -   : (*(struct _obstack_chunk *(*) (long)) (h)->chunkfun) ((size)))
    -+   ? (*(h)->chunkfun.fn_extra_arg) ((h)->extra_arg, (size)) \
    -+   : (*(h)->chunkfun.fn) ((size)))
    ++   ? (*(h)->chunkfun.extra) ((h)->extra_arg, (size)) \
    ++   : (*(h)->chunkfun.plain) ((size)))
      
      # define CALL_FREEFUN(h, old_chunk) \
        do { \
          if ((h) -> use_extra_arg) \
     -      (*(h)->freefun) ((h)->extra_arg, (old_chunk)); \
    -+      (*(h)->freefun.fn_extra_arg) ((h)->extra_arg, (old_chunk)); \
    ++      (*(h)->freefun.extra) ((h)->extra_arg, (old_chunk)); \
          else \
     -      (*(void (*) (void *)) (h)->freefun) ((old_chunk)); \
    -+      (*(h)->freefun.fn) ((old_chunk)); \
    ++      (*(h)->freefun.plain) ((old_chunk)); \
        } while (0)
      
      
    @@ -68,8 +74,8 @@
      
     -  h->chunkfun = (struct _obstack_chunk * (*)(void *, long)) chunkfun;
     -  h->freefun = (void (*) (void *, struct _obstack_chunk *)) freefun;
    -+  h->chunkfun.fn = chunkfun;
    -+  h->freefun.fn = freefun;
    ++  h->chunkfun.plain = chunkfun;
    ++  h->freefun.plain = freefun;
        h->chunk_size = size;
        h->alignment_mask = alignment - 1;
        h->use_extra_arg = 0;
    @@ -79,8 +85,8 @@
      
     -  h->chunkfun = (struct _obstack_chunk * (*)(void *,long)) chunkfun;
     -  h->freefun = (void (*) (void *, struct _obstack_chunk *)) freefun;
    -+  h->chunkfun.fn_extra_arg = (struct _obstack_chunk * (*)(void *,long)) chunkfun;
    -+  h->freefun.fn_extra_arg = (void (*) (void *, struct _obstack_chunk *)) freefun;
    ++  h->chunkfun.extra = (struct _obstack_chunk * (*)(void *,long)) chunkfun;
    ++  h->freefun.extra = (void (*) (void *, struct _obstack_chunk *)) freefun;
     +
        h->chunk_size = size;
        h->alignment_mask = alignment - 1;
    @@ -100,12 +106,12 @@
     -  void (*freefun) (void *, struct _obstack_chunk *);
     +  /* These prototypes vary based on `use_extra_arg'. */
     +  union {
    -+    struct _obstack_chunk *(*fn_extra_arg) (void *, long);
    -+    void *(*fn) (long);
    ++    void *(*plain) (long);
    ++    struct _obstack_chunk *(*extra) (void *, long);
     +  } chunkfun;
     +  union {
    -+    void (*fn_extra_arg) (void *, struct _obstack_chunk *);
    -+    void (*fn) (void *);
    ++    void (*plain) (void *);
    ++    void (*extra) (void *, struct _obstack_chunk *);
     +  } freefun;
        void *extra_arg;		/* first arg for chunk alloc/dealloc funcs */
        unsigned use_extra_arg:1;	/* chunk alloc/dealloc funcs take extra arg */
    @@ -115,11 +121,11 @@
      
      #define obstack_chunkfun(h, newchunkfun) \
     -  ((h) -> chunkfun = (struct _obstack_chunk *(*)(void *, long)) (newchunkfun))
    -+  ((h)->chunkfun.fn_extra_arg = (struct _obstack_chunk *(*)(void *, long)) (newchunkfun))
    ++  ((h)->chunkfun.extra = (struct _obstack_chunk *(*)(void *, long)) (newchunkfun))
      
      #define obstack_freefun(h, newfreefun) \
     -  ((h) -> freefun = (void (*)(void *, struct _obstack_chunk *)) (newfreefun))
    -+  ((h)->freefun.fn_extra_arg = (void (*)(void *, struct _obstack_chunk *)) (newfreefun))
    ++  ((h)->freefun.extra = (void (*)(void *, struct _obstack_chunk *)) (newfreefun))
      
      #define obstack_1grow_fast(h,achar) (*((h)->next_free)++ = (achar))
      
2:  1f6be06841 = 2:  983e5a4107 .gitignore: ignore external debug symbols from GCC on macOS
3:  6f6ece8872 = 3:  cc3eb12441 travis-ci: don't be '--quiet' when running the tests
4:  a4179caeba = 4:  2155876a85 travis-ci: switch to Xcode 10.1 macOS image
5:  36323a7c8a ! 5:  c91a5bc7ee travis-ci: build with the right compiler
    @@ -3,10 +3,10 @@
         travis-ci: build with the right compiler
     
         Our 'Makefile' hardcodes the compiler to build Git as 'CC = cc'.  This
    -    can be overridden from the command line, i.e. 'make CC=gcc-X.Y' will
    -    build with that particular GCC version, but not from the environment,
    -    i.e. 'CC=gcc-X.Y make' will still build with whatever 'cc' happens to
    -    be on the platform.
    +    CC variable can be overridden from the command line, i.e. 'make
    +    CC=gcc-X.Y' will build with that particular GCC version, but not from
    +    the environment, i.e. 'CC=gcc-X.Y make' will still build with whatever
    +    'cc' happens to be on the platform.
     
         Our build jobs on Travis CI are badly affected by this.  In the build
         matrix we have dedicated build jobs to build Git with GCC and Clang
-- 
2.20.1.499.gf60de1223c

