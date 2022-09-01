Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D24DECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 16:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiIAQjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiIAQjS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 12:39:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D406E8A4
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 09:39:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m16so23082189wru.9
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=T+jofh88kIqKVev8J88Kgl1OcayLIUsiJEWKMvBLYR4=;
        b=mAvl7lZNf/Sc2+2UR0SUhCwvSFrdW8ANisaZvHb3J46oG+AquY65iYeRsldMsNTd1Q
         UDr0sN+0e/yr0g4mYwCGAa6lJZ60L/Pw9UOkSnmq7iCbeAarrUjgeyprTLtTuCxlimKe
         5Ynq2nZCPDAVeRHCN2Jo5akzvO4A3Nbppdgn0ERL/zKqiQ4+2yJfdkaQgBN0yUHPApWk
         MAHB/rLDSNFM0TnIiyw4+iWXjQNmkhw244MjRF5EbkvYxEhJBUxZFuCECAjObUcOCtwt
         QkTJYJdcjGV3IHJ6YdifcGFcj7igDvem/JPGrzRIUHKgOkrweFwPbwY36Oz3dpccMqbD
         iR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=T+jofh88kIqKVev8J88Kgl1OcayLIUsiJEWKMvBLYR4=;
        b=7SxY8H9gdtpyargGQPU0oYryQJuHkNTCv07SJ9T8aDlwpd3SXFeAOcj12J0+6/5pDW
         QQ21LZWg3/9V9W4cJDjTtfhEaZN7vOBZZI1xei4yQqUyMu+gTbh0Q9NkOGI8GDvrRWLt
         EREyDriB8szNtt1p9BfOY+/JcSSuHZDFE8j/Q/d62wHHA8/pAsWwY52+IwcuRedpfjdz
         7i3tqJh9e5Mq0SE1xwG7wmApBFA8yT1RSU8GWr4c0KRmojhpEqHkmZMtlGXWBhQmaVdB
         o8xxJolS9bqMBH+uqV+HX6n7uMFBWvHM18gS+ws3O/rQ7QDCwuDfJVPFfRJGF2xDegdS
         A8LA==
X-Gm-Message-State: ACgBeo3daWZH6UWf78VE63/oNrjLHDYF7imx95DRqPwLuVA7wWnRBBJ7
        COLXLy90SkpzGcYV+oo/kcs=
X-Google-Smtp-Source: AA6agR6mTXHdogy0zgIB/X3hb6R/Fre5DRSuvSjftyITpGKUKx28YvPGUU9ltxW5UqGI2yhjU+fFfg==
X-Received: by 2002:adf:db04:0:b0:223:654e:6fd with SMTP id s4-20020adfdb04000000b00223654e06fdmr15461310wri.627.1662050354717;
        Thu, 01 Sep 2022 09:39:14 -0700 (PDT)
Received: from localhost (62-165-236-110.pool.digikabel.hu. [62.165.236.110])
        by smtp.gmail.com with ESMTPSA id t8-20020adfdc08000000b002258413c310sm15258756wri.88.2022.09.01.09.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 09:39:13 -0700 (PDT)
Date:   Thu, 1 Sep 2022 18:38:59 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 7/9] cocci: make "coccicheck" rule incremental
Message-ID: <20220901163859.GA122568@szeder.dev>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
 <patch-v2-7.9-120607b5da6-20220831T205130Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-7.9-120607b5da6-20220831T205130Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2022 at 10:57:54PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Optimize the very slow "coccicheck" target to take advantage of
> incremental rebuilding, and fix outstanding dependency problems with
> the existing rule.
> 
> The rule is now faster both on the initial run as we can make better
> use of GNU make's parallelism than the old ad-hoc combination of
> make's parallelism combined with $(SPATCH_BATCH_SIZE) and/or the
> "--jobs" argument to "spatch(1)".

On my machine a "from scratch" 'make -j4 coccicheck' without the
inacceptably slow 'unused.cocci' takes 9m28s, with
SPATCH_BATCH_SIZE=32 it takes 6m39s.  If we invoke 'spatch' like in
the patch below and let one 'spatch' invocation process all source
files one by one (i.e. unlike the batched invocations) and using its
'--jobs' option then it takes 4m56s.

This patch series is slower than any of the above, as it takes 10m3s.

>  * Before this change running "make coccicheck" would by default end
>    up pegging just one CPU at the very end for a while, usually as
>    we'd finish whichever *.cocci rule was the most expensive.
> 
>    This could be mitigated by combining "make -jN" with
>    SPATCH_BATCH_SIZE, see 960154b9c17 (coccicheck: optionally batch
>    spatch invocations, 2019-05-06). But doing so required careful
>    juggling, as e.g. setting both to 4 would yield 16 workers.

As pointed out previously, this is not the case.


  ---  >8  ---

diff --git a/Makefile b/Makefile
index e8adeb09f1..b93b1b62e1 100644
--- a/Makefile
+++ b/Makefile
@@ -1290,11 +1290,9 @@ SP_EXTRA_FLAGS = -Wno-universal-initializer
 SANITIZE_LEAK =
 SANITIZE_ADDRESS =
 
-# For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
-# usually result in less CPU usage at the cost of higher peak memory.
-# Setting it to 0 will feed all files in a single spatch invocation.
+# For the 'coccicheck' target
 SPATCH_FLAGS = --all-includes
-SPATCH_BATCH_SIZE = 1
+SPATCH_JOBS = 1
 
 include config.mak.uname
 -include config.mak.autogen
@@ -3139,19 +3137,17 @@ COCCI_TEST_RES = $(wildcard contrib/coccinelle/tests/*.res)
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	$(QUIET_SPATCH) \
-	if test $(SPATCH_BATCH_SIZE) = 0; then \
-		limit=; \
-	else \
-		limit='-n $(SPATCH_BATCH_SIZE)'; \
-	fi; \
-	if ! echo $(COCCI_SOURCES) | xargs $$limit \
-		$(SPATCH) $(SPATCH_FLAGS) \
-		--sp-file $< --patch . \
+	filelist=$@.filelist; \
+	: Blank lines between filenames are necessary to put each file in separate group ; \
+	printf "%s\\n\\n" $(COCCI_SOURCES) >$$filelist && \
+	if ! $(SPATCH) $(SPATCH_FLAGS) --jobs $(SPATCH_JOBS) \
+		--sp-file $< --patch . --file-groups $$filelist \
 		>$@+ 2>$@.log; \
 	then \
 		cat $@.log; \
 		exit 1; \
 	fi; \
+	rm -f $$filelist; \
 	mv $@+ $@; \
 	if test -s $@; \
 	then \
