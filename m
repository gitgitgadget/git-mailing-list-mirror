Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBADC433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8392089D
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ryKbbWN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgFZVyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZVyO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 17:54:14 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606C7C03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 14:54:14 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 145so7698886qke.9
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 14:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0zA6la3Hi+pBKfuagH7+RQGbXyM1mf6OeKnot6BAIj4=;
        b=ryKbbWN5o6B78xRQCiYFDwJof0ABc74wh1DMvvdOLgtxFZsZjxPhLl57XSTtVYTIOp
         Myrk1ow/+ZjAu74Ds/4eMzuwXiRK3LBtA+z/ON914qmunNA5grI3Fy0kOqjT2oSTdN5q
         sT1VWcrR+82roooRr0UUqCX6gil7ht7D0Mp57E4cmqmvXkeEmYeXYCnia9vLrQoU736y
         3VMJlMV3aQ0cZ5jGEfXJkQq4IZeZUFkw1b4asJ9YdhCaMmbk+xnftNwuQsWCwsean7P2
         EnAN1/MRZalQ+r0vKWZ14ClMkPgaZo9Z2fJ1zZJzz6vx3VlMuPRBy9Ndy2Qgep5JLOS9
         AdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0zA6la3Hi+pBKfuagH7+RQGbXyM1mf6OeKnot6BAIj4=;
        b=bf5kdhhnYAeEY/miK5UNOlsJIbUnQ61RCpupHLhdYRMlNtjtbNHPSlTyukMizX9suo
         IbY7KjighxuCceaRmaBFpKe6zu+0+ztF0yk1OxO8ikSYrML9JCNlUSjDvvIEaoydTSif
         UTE4N/MeKaCeBvPzLlHDxV6FQ8gdZ18yHtP67ow7Zc3/tyH/JD8anOMyxS1UJ/A9nhIz
         9ixNNNYXzXJJ0JQH8HS9KFhwyGTRVFvAr6nUOhmjhsf/un7PNC2GkIpaTQb2AaJMFYO2
         vPjZQmninOKq2GIORA1U3yCO4AhMjDFqMb9ntNEDO9Y0s/q4FJHXM4upjLydnBOi3tB8
         V+mA==
X-Gm-Message-State: AOAM530YzhiNUF1A2pZsZNsXz31Il8LWkRexloygs1kRr9Kfyp7uQiOL
        LxjhVyvDxhprjMhAkIoRIEREXVAxboQ=
X-Google-Smtp-Source: ABdhPJycEdsk5Mnq0Ia9AFsTr28J+1AfmDs4w6VCv1BBiLUsy4Sux0Z1jo5MaE/+PJNgz7Qn2byIzg==
X-Received: by 2002:a37:8283:: with SMTP id e125mr4708853qkd.175.1593208452957;
        Fri, 26 Jun 2020 14:54:12 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::2])
        by smtp.gmail.com with ESMTPSA id c27sm9473475qka.23.2020.06.26.14.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:54:12 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, j6t@kdbg.org,
        jonathantanmy@google.com, peff@peff.net,
        Johannes.Schindelin@gmx.de, christian.couder@gmail.com
Subject: [PATCH v2 0/2] Make oid_to_hex() thread-safe
Date:   Fri, 26 Jun 2020 18:54:01 -0300
Message-Id: <cover.1593208411.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593115455.git.matheus.bernardino@usp.br>
References: <cover.1593115455.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some thread-unsafe functions of our codebase appear very down in the
call stack, which can be hard to notice (or avoid). Thus they are
sometimes used in threaded code unsafely. In this series we add
pthread_once() to compat/win32/ and use it in conjunction with
pthread_key to make a subset of the said functions thread-safe.

Changes since v1:

Patch 1:
- Fixed style problems.
- Wrote a more descriptive commit message, with motivation and info
  about where the code was ported from (including commit, license and
  modifications made).
- Corrected usage of InitOnceComplete() in pthread_once(). It was
  previously being called unconditionally, which lead to errors in
  subsequent calls to pthread_once(), after the initialization had
  already succeded.

Patch 2:
- Used the correct pthread_[get|set]specific() functions in hex.c, as
  Brian pointed out.
- Imported thread_utils.h to hex.c (providing the HAVE_THREADS macro)
- Added Fredrik's S-o-B
- Fixed spelling error
- Added the static identifier to init_hexbuf_array_key() in hex.c
- Provided an example in the commit message where oid_to_hex() was being
  used unsafelly.

Matheus Tavares (2):
  compat/win32/pthread: add pthread_once()
  hex: make hash_to_hex_algop() and friends thread-safe

 compat/win32/pthread.c | 18 +++++++++++++++++
 compat/win32/pthread.h |  5 +++++
 hex.c                  | 46 ++++++++++++++++++++++++++++++++++++++----
 thread-utils.c         | 11 ++++++++++
 thread-utils.h         |  7 +++++++
 5 files changed, 83 insertions(+), 4 deletions(-)

Range-diff against v1:
1:  e5a10d3f21 ! 1:  783fcddf8d compat/win32/pthread: add pthread_once()
    @@ Metadata
      ## Commit message ##
         compat/win32/pthread: add pthread_once()
     
    +    Add pthread_once() emulation for Windows. This function provides an easy
    +    way to do thread-safe one-time initializations in multithreaded code. It
    +    will be used in the next commit to make hash_to_hex_algop()
    +    thread-safe.
    +
    +    The pthread_once() implementation added comes from libav
    +    (https://git.libav.org/?p=libav.git), commit b22693b ("w32pthreads: Add
    +    pthread_once emulation", 2015-10-07). The code is licensed under
    +    LGPLv2.1 which is compatible with GPLv2. Only the section for support on
    +    Windows Vista+ has been ported, as that's the minimum version required
    +    to build Git for Windows.  Also, the code was modified to (1) check and
    +    return error codes; and (2) do not call InitOnceComplete() again after a
    +    successful initialization, as that results in an error.
    +
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## compat/win32/pthread.c ##
    @@ compat/win32/pthread.c: pthread_t pthread_self(void)
     +	BOOL pending = FALSE;
     +	int ret = 0;
     +
    -+	if(!InitOnceBeginInitialize(once_control, 0, &pending, NULL)) {
    ++	if (!InitOnceBeginInitialize(once_control, 0, &pending, NULL)) {
     +		ret = err_win_to_posix(GetLastError());
    -+		goto out;
    -+	}
    -+
    -+	if (pending)
    ++	} else if (pending) {
     +		init_routine();
    ++		if (!InitOnceComplete(once_control, 0, NULL))
    ++			ret = err_win_to_posix(GetLastError());
    ++	}
     +
    -+	if(!InitOnceComplete(once_control, 0, NULL))
    -+		ret = err_win_to_posix(GetLastError());
    -+
    -+out:
     +	/* POSIX doesn't allow pthread_once() to return EINTR */
     +	return ret == EINTR ? EIO : ret;
     +}
    @@ thread-utils.h: int dummy_pthread_join(pthread_t pthread, void **retval);
      int dummy_pthread_init(void *);
      
     +#define PTHREAD_ONCE_INIT 0
    ++#define pthread_once(once, routine) nothreads_pthread_once(once, routine)
    ++
     +int nothreads_pthread_once(pthread_once_t *once_control,
     +			   void (*init_routine)(void));
    -+#define pthread_once(once, routine) nothreads_pthread_once(once, routine)
     +
      #endif
      
2:  0104cd9c76 ! 2:  b47445fa1c hex: make hash_to_hex_algop() and friends thread-safe
    @@ Commit message
         in threaded code, but they are sometimes too deep in the call stack to
         be noticed or even avoided.
     
    -    For example, we can take a look at the number of oid_to_hex() calls,
    -    which calls hash_to_hex_algop():
    +    grep.c:grep_source_load_oid(), for example, uses the thread-unsafe
    +    oid_to_hex() (on errors) despite being called in threaded code. And
    +    oid_to_hex() -- which calls hash_to_hex_algop() -- is used in many other
    +    places, as well:
     
         $ git grep 'oid_to_hex(' | wc -l
         818
     
    -    Although these functions don't seem to be causing problems out there for
    -    now (at least not reported), making them thread-safe makes the codebase
    -    more robust against race conditions. We can easily do that replicating
    -    the static buffer in each thread's local storage.
    +    Although hash_to_hex_algop() and its wrappers don't seem to be causing
    +    problems out there for now (at least not reported), making them
    +    thread-safe makes the codebase more robust against race conditions. We
    +    can easily do that by replicating the static buffer in each thread's
    +    local storage.
     
         Original-patch-by: Fredrik Kuivinen <frekui@gmail.com>
    +    Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## hex.c ##
    +@@
    + #include "cache.h"
    ++#include "thread-utils.h"
    + 
    + const signed char hexval_table[256] = {
    + 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* 00-07 */
     @@ hex.c: char *oid_to_hex_r(char *buffer, const struct object_id *oid)
      	return hash_to_hex_algop_r(buffer, oid->hash, the_hash_algo);
      }
    @@ hex.c: char *oid_to_hex_r(char *buffer, const struct object_id *oid)
     +static pthread_key_t hexbuf_array_key;
     +static pthread_once_t hexbuf_array_once = PTHREAD_ONCE_INIT;
     +
    -+void init_hexbuf_array_key(void)
    ++static void init_hexbuf_array_key(void)
     +{
     +	if (pthread_key_create(&hexbuf_array_key, free))
     +		die(_("failed to initialize threads' key for hash to hex conversion"));
    @@ hex.c: char *oid_to_hex_r(char *buffer, const struct object_id *oid)
     +	if (pthread_once(&hexbuf_array_once, init_hexbuf_array_key))
     +		die(_("failed to initialize threads' key for hash to hex conversion"));
     +
    -+	value = pthread_key_getspecific(&hexbuf_array_key);
    ++	value = pthread_getspecific(hexbuf_array_key);
     +	if (value) {
     +		ha = (struct hexbuf_array *) value;
     +	} else {
     +		ha = xmalloc(sizeof(*ha));
    -+		if (pthread_key_setspecific(&hexbuf_array_key, (void *)ha))
    ++		if (pthread_setspecific(hexbuf_array_key, (void *)ha))
     +			die(_("failed to set thread buffer for hash to hex conversion"));
     +	}
     +#else
-- 
2.26.2

