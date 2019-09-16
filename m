Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF3331F463
	for <e@80x24.org>; Mon, 16 Sep 2019 19:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390911AbfIPTXW (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 15:23:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40962 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbfIPTXV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 15:23:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so539162pgg.8
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a6mdw715zbkrug9qdj7YugtP7I03Drgh8SObChSlNNs=;
        b=GFA9LcPTds2k/+PL+5sh+zYGIlX9wRPbIdXTImeY17sM4Ee/TM1wcFNuAIatvbJ9dQ
         usn6dAe7yfVmnf7r5XYMBfXTlPoUCwGwjwPdCm9iUEHsi+qaFWPMbnGnPsDh8Fx403N+
         /CLlRgG/ha+flsUMZj6qhMdhU0zLctn1lw0H2thihLehnZAd83tFxuGnFwIzpzAlacGc
         4ghrDaqsF6pp+lZnBltLXNfKRxPdx2eWjacnuAxZFy5csVZ1cCgg+Qsr+Yx/0HRnPvw6
         pWtUGZ9di+i4kjLPkZ/yiD60IR4sfWpt4KU9ckDvP7dwVc3IYBeRIMXQGj2Qx3wchFBh
         JlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a6mdw715zbkrug9qdj7YugtP7I03Drgh8SObChSlNNs=;
        b=IsqDIs86oYgHJ1B9IX92z3P7SJ93jrjnY715VM79xZ3RO26JZyNf1X2+0VHrqmWm1B
         v72uJhB9dkQUT0vsG8U/KqewPjGOBMyeC9OLdLFqYwRFwDa1SIpKvoazz/r16pquIqB0
         A5XKim/iQ5YglEMQpAnrTYCNQyCCGiiRlG2cnxaXqKT7wD3baYZeHqGCaKVmrk3QtzgL
         QGb+1PdQcrjsyAQzCp3d1O21oAay2fVQOveBUau+Qi8Isf8l4UVhSkEV3sqU0acv5zCO
         Iy7QsTAoumI0JarO/UKcDNdcciLNfnQ6kgtQwWsHuHlV1lHH7Ht3/+bDY24Iz7CoWwaZ
         zl1Q==
X-Gm-Message-State: APjAAAUa753/sqsRwLGmP/tgT3yQq0vVSFnChs1/PD8s3hPu1owQZL+3
        EFQzx7eL1vnJqP2WhXy6joXlNXI44f0=
X-Google-Smtp-Source: APXvYqzIkW9KNH+KMwcc0ZD2wQAPYOQbZ9GP98tZcu2KyJ5s3n+FgdftXIro57Di5fNc+9bbLVMVWg==
X-Received: by 2002:a63:c842:: with SMTP id l2mr737981pgi.4.1568661799123;
        Mon, 16 Sep 2019 12:23:19 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id q88sm333411pjq.9.2019.09.16.12.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 12:23:18 -0700 (PDT)
Date:   Mon, 16 Sep 2019 12:23:16 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/4] Makefile: run coccicheck on more source files
Message-ID: <0ecfcd8858f1734ca079cb260f0d27d43f1e1cc5.1568661443.git.liu.denton@gmail.com>
References: <cover.1568309119.git.liu.denton@gmail.com>
 <cover.1568661443.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568661443.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, when running the "coccicheck" target, only the source files
which were being compiled would have been checked by Coccinelle.
However, just because we aren't compiling a source file doesn't mean we
have to exclude it from analysis. This will allow us to catch more
mistakes, in particular ones that affect Windows-only sources since
Coccinelle currently runs only on Linux.

Make the "coccicheck" target run on all C sources except for those that
are taken from some third-party source. We don't want to patch these
files since we want them to be as close to upstream as possible so that
it'll be easier to pull in upstream updates.

When running a build on Arch Linux with no additional flags provided,
after applying this patch, the following sources are now checked:

* block-sha1/sha1.c
* compat/access.c
* compat/basename.c
* compat/fileno.c
* compat/gmtime.c
* compat/hstrerror.c
* compat/memmem.c
* compat/mingw.c
* compat/mkdir.c
* compat/mkdtemp.c
* compat/mmap.c
* compat/msvc.c
* compat/pread.c
* compat/precompose_utf8.c
* compat/qsort.c
* compat/setenv.c
* compat/sha1-chunked.c
* compat/snprintf.c
* compat/stat.c
* compat/strcasestr.c
* compat/strdup.c
* compat/strtoimax.c
* compat/strtoumax.c
* compat/unsetenv.c
* compat/win32/dirent.c
* compat/win32/path-utils.c
* compat/win32/pthread.c
* compat/win32/syslog.c
* compat/win32/trace2_win32_process_info.c
* compat/win32mmap.c
* compat/winansi.c
* ppc/sha1.c

This also results in the following source now being excluded:

* compat/obstack.c

Instead of generating $(FOUND_C_SOURCES) from a
`$(shell $(FIND_SOURCE_FILES))` invocation, an alternative design was
considered which involved converting $(FIND_SOURCE_FILES) into
$(SOURCE_FILES) which would hold a list of filenames from the
$(FIND_SOURCE_FILES) invocation. We would simply filter `%.c` files into
$(ALL_C_SOURCES). $(SOURCE_FILES) would then be passed directly to the
etags, ctags and cscope commands. We can see from the following
invocation

	$ git ls-files '*.[hcS]' '*.sh' ':!*[tp][0-9][0-9][0-9][0-9]*' ':!contrib' | wc -c
	   12779

that the number of characters in this list would pose a problem on
platforms with short command-line length limits (such as CMD which has a
max of 8191 characters). As a result, we don't perform this change.

However, we can see that the same issue may apply when running
Coccinelle since $(COCCI_SOURCES) is also a list of filenames:

	if ! echo $(COCCI_SOURCES) | xargs $$limit \
		$(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
		>$@+ 2>$@.log; \

This is justified since platforms that support Coccinelle generally have
reasonably long command-line length limits and so we are safe for the
foreseeable future.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 20eb5c5c42..522342a46c 100644
--- a/Makefile
+++ b/Makefile
@@ -2805,12 +2805,8 @@ check: command-list.h
 		exit 1; \
 	fi
 
-C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
-ifdef DC_SHA1_SUBMODULE
-COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
-else
-COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
-endif
+FOUND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
+COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	@echo '    ' SPATCH $<; \
-- 
2.23.0

