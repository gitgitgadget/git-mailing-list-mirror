Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40DFD20248
	for <e@80x24.org>; Wed, 10 Apr 2019 12:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbfDJM4u (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 08:56:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41134 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729520AbfDJM4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 08:56:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id u2so1930002eds.8
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 05:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wEmxjtW6g40ipAxo/fxU0rOOz5H/4GSYS7LTAY4wrxA=;
        b=HTpD0MsA/5agJmFgHlA2UqqF7YUiYst54ZOEcop9XX41tE5hLt15sIurL12dOPhWXg
         sCFm8u7ltvZTcelMyj18cfyVipbbt6JJtiMx4NVOmmEfmxrJf1nHwMBdQinwDkOcdse1
         oQ9UgdZFG76+bfM5B0eNvMsCrms3E2ACYNkU0F6ZS9AtCqR/QzmeAe/qyHBjD5kHjzzs
         w38A7F84qwozgsWPNT3VwsUg8q+KZgTsFbJgDxipn/foyuIVHX5pUPlX41qJdjDb9yqY
         CxIhByOg7SXeqD9IJl4pcHGhr57Z7Aina5eDrz5ekGLI64BFw8srAKb8ig6zLn+5rICn
         x5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wEmxjtW6g40ipAxo/fxU0rOOz5H/4GSYS7LTAY4wrxA=;
        b=Ep8ppSKuNEnDy2himdbTEFs4zFuvpHEZmOzNcuX3wVo3SRTdSntWjqgn0mhS7eBec9
         4ZwBZD1rpgxir5zN0VN8jynpOC3eqZEYezNCvF03aBHZReABqxqYWGesC1jGLF1i5T6x
         Ct9a1hx1AqJIITVCCHwFJi/7aebw+0yhERvMghZurlV0ZXwqBKQ1NIJhAJDb7ihlalOh
         Ww3+ARJn0X8wDCKpIkhnhGQUUB6ZweviHzv4w69dtzilW3isOCWbTTyPoCMR78C95ZEW
         E2CaGiyutZm+bmFKvFNDUSU0/bo9HiUE2Qc94ZQnSRxme/nK22kEeoGezq0mWMoF9sSK
         iroQ==
X-Gm-Message-State: APjAAAWTiiURkWDEdkRxDMQfNonlyIaEbGHpfKov8OxoSPRyWxbRU3AP
        fqWKT45ne2+lhg6Xric6XxxFW8xB
X-Google-Smtp-Source: APXvYqzPxU5+qk4mGISKNcobUUIXweC4hkv6XbQjz5U3iOey3ZMRq5gBXnWAUvy/LAkhPJCVPzOLUQ==
X-Received: by 2002:a50:b244:: with SMTP id o62mr27548310edd.224.1554901008634;
        Wed, 10 Apr 2019 05:56:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm4025588ejx.81.2019.04.10.05.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 05:56:48 -0700 (PDT)
Date:   Wed, 10 Apr 2019 05:56:48 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Apr 2019 12:56:46 GMT
Message-Id: <a7f75cefb682546862be4dd8b48f91c4034c5d5a.1554901006.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.178.git.gitgitgadget@gmail.com>
References: <pull.178.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] untracked cache: fix off-by-one
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In f9e6c649589e (untracked cache: load from UNTR index extension,
2015-03-08), code was added to read back the untracked cache from an
index extension.

Probably in the endeavor to avoid the `calloc()` implied by
`FLEX_ALLOC_STR()` (it is hard to know why exactly, the commit message
of that commit is a bit parsimonious with information), it calls
`malloc()` manually and then `memcpy()`s the bits and pieces into place.

It allocates the size of `struct untracked_cache_dir` plus the string
length of the untracked file name, then copies the information in two
steps: first the fixed-size metadata, then the name. And here lies the
rub: it includes the trailing NUL byte in the name.

If `FLEX_ARRAY` is defined as 0, this results in a buffer overrun.

To fix this, let's just add 1, for the trailing NUL byte. Technically,
this overallocates on platforms where `FLEX_ARRAY` is 1, but it should
not matter much in reality, as `malloc()` usually overallocates anyway,
unless the size to allocate aligns exactly with some internal chunk size
(see below for more on that).

The real strange thing is that neither valgrind nor DrMemory catches
this bug. In this developer's tests, a `memcpy()` (but not a
`memset()`!) could write up to 4 bytes after the allocated memory range
before valgrind would start reporting an issue.

However, when running Git built with nedmalloc as allocator, under rare
conditions (and inconsistently at that), this bug triggered an `abort()`
because nedmalloc rounds up the size to be `malloc()`ed to a multiple of
a certain chunk size, then adds a few bytes to be used for storing some
internal state. If there is no rounding up to do (because the size is
already a multiple of that chunk size), and if the buffer is overrun as
in the code patched in this commit, the internal state is corrupted.

The scenario that triggered this here bug fix entailed a git.git
checkout with an extra copy of the source code in an untracked
subdirectory, meaning that there was an untracked subdirectory called
"thunderbird-patch-inline" whose name's length is exactly 24 bytes,
which, added to the size of above-mentioned `struct untracked_cache_dir`
that weighs in with 104 bytes on a 64-bit system, amounts to 128,
aligning perfectly with nedmalloc's chunk size.

As there is no obvious way to trigger this bug reliably, on all
platforms supported by Git, and as the bug is obvious enough, this patch
comes without a regression test.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index b2cabadf25..f5293a6536 100644
--- a/dir.c
+++ b/dir.c
@@ -2760,7 +2760,7 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 	next = data + len + 1;
 	if (next > rd->end)
 		return -1;
-	*untracked_ = untracked = xmalloc(st_add(sizeof(*untracked), len));
+	*untracked_ = untracked = xmalloc(st_add3(sizeof(*untracked), len, 1));
 	memcpy(untracked, &ud, sizeof(ud));
 	memcpy(untracked->name, data, len + 1);
 	data = next;
-- 
gitgitgadget
