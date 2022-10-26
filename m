Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176FEC38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 16:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiJZQrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 12:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiJZQru (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 12:47:50 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A30EDCEB6
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 09:47:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id e129so15386053pgc.9
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 09:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxnmMkuSNNd5WjhmQn0aDn6wteauKJmWwtIGac9qTgg=;
        b=Getqvusl5BEcntfvoRs46nbU4SIT0CU80/Lwz3KickzCmuDMF5WJpMqtRceYS6P9Ro
         PaFxFq3hvJBeft+ayXcaA8XC1PptAFODyL02EJUC581nQdnQygQn1Hhm12njM8eyiEB6
         xlGvdyIKeWJ4CAhhh2zrpRH4/L/6hkVSqfgy11H91pua8A52uQi/mc0a9GoFZ56RCDSG
         w25phXR3YrUTW9qR3af1gGBpCeibWrYoF4WhOh30LOBc8yYKbCWs5H1bZun1yjmBsP4K
         AtsbknmqjUi8YJ4aKaKpzJBZooljzNmtWzK70hY+6qvH3c3bZds85TgIiS2M1uCg7JCV
         kg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxnmMkuSNNd5WjhmQn0aDn6wteauKJmWwtIGac9qTgg=;
        b=2wmVwByFfQCK746IYYUUFIa7xwkstEz4vNUA3vq53dqQ6yMcasOPaOluhkcY08Y/Fu
         Nv2zqy/EPt/MF6IcMqWhKbGqjNDg5Q3xmenQNK/j97Ogqz7zvJZNA/KhD3fccTWfcvfZ
         9QYdo2UNQxWsOKkNvQ4HnGouq2tEZkG4eht8vFfFo/6DfeSvIICVLXXF/E/hY+9g9WoZ
         HW2S111vmXsW3iGoLTbAtHVByeNA/Fs09bEavKY5yMegVMFItX6YpyKw3077sb6RXMGy
         T6xJw2nJBmAQ98Rsj5BSmUUzzLDDK3XrPzOJsBLSb83V1z7GZD31V7qckrWL6lSgahZt
         Xkcw==
X-Gm-Message-State: ACrzQf1bzQf1U7Nm2rd5g7ECknL4cwPt5n9XiZrlpM+f6vMomGdTkZFg
        lvHP4SVYP24tXjsgCsoI6KI=
X-Google-Smtp-Source: AMsMyM503rA/PV7Tn7gPGzU2TS/TcqLzuUdzR9c8ghuOyACdJptkv5KZwNo7bld3RMewY5l06ARwKg==
X-Received: by 2002:a63:fb53:0:b0:46e:e210:f026 with SMTP id w19-20020a63fb53000000b0046ee210f026mr19128490pgj.29.1666802867943;
        Wed, 26 Oct 2022 09:47:47 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id cw15-20020a056a00450f00b00562019b961asm3176599pfb.188.2022.10.26.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 09:47:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/3] Makefile: define "TEST_{PROGRAM,OBJS}" variables
 earlier
References: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
        <patch-v2-2.3-6dcb49f25c4-20221026T143534Z-avarab@gmail.com>
Date:   Wed, 26 Oct 2022 09:47:47 -0700
Message-ID: <xmqqsfjailak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Define the variables that make up TEST_OBJS earlier, and don't go back
> & forth in their definition. Before we'd first append $X to
> $(TEST_PROGRAMS), and then substitute $X back out of it to define
> $(TEST_OBJS). Let's instead add a new $(TEST_PROGRAM_OBJS) variable,
> which avoids this needless back & forth substitution.

Makes sense, I guess.  So TEST_OBJS is no longer used?

>  TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
> +all:: $(TEST_PROGRAMS)

This change is not necessary to achieve the stated goal of this
step, though.  It is one of those "while at it" distraction that
consumes our already constrained reviewer bandwidth, no?

Having said that, "all::" being able to be built up with independent
pieces shine here in this split from the original.  It probably is
easier to reason about while seeing this isolated area of Makefile
what is being done to TEST_PROGRAMS.

The rest of the patch is quite straight-forward renaming of
TEST_OBJS to TEST_PROGRAM_OBJS and an improvement of how the
elements on the list are computed from the source-of-truth list that
is TEST_PROGRAMS_NEED_X that looks correct.

> +TEST_PROGRAM_OBJS += $(patsubst %,t/helper/%.o,$(TEST_PROGRAMS_NEED_X))
> +.PRECIOUS: $(TEST_PROGRAM_OBJS)

>  # List built-in command $C whose implementation cmd_$C() is not in
>  # builtin/$C.o but is linked in as part of some other command.
> @@ -2543,10 +2548,8 @@ REFTABLE_TEST_OBJS += reftable/stack_test.o
>  REFTABLE_TEST_OBJS += reftable/test_framework.o
>  REFTABLE_TEST_OBJS += reftable/tree_test.o
>  
> -TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
> -
>  .PHONY: test-objs
> -test-objs: $(TEST_OBJS)
> +test-objs: $(TEST_PROGRAM_OBJS)
>  
>  GIT_OBJS += $(LIB_OBJS)
>  GIT_OBJS += $(BUILTIN_OBJS)
> @@ -2562,7 +2565,7 @@ scalar-objs: $(SCALAR_OBJS)
>  OBJECTS += $(GIT_OBJS)
>  OBJECTS += $(SCALAR_OBJS)
>  OBJECTS += $(PROGRAM_OBJS)
> -OBJECTS += $(TEST_OBJS)
> +OBJECTS += $(TEST_PROGRAM_OBJS)
>  OBJECTS += $(XDIFF_OBJS)
>  OBJECTS += $(FUZZ_OBJS)
>  OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
> @@ -3061,7 +3064,7 @@ endif
>  
>  test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
>  
> -all:: $(TEST_PROGRAMS) $(test_bindir_programs)
> +all:: $(test_bindir_programs)
>  
>  bin-wrappers/%: wrap-for-bin.sh
>  	$(call mkdir_p_parent_template)
> @@ -3087,8 +3090,6 @@ perf: all
>  
>  .PHONY: test perf
>  
> -.PRECIOUS: $(TEST_OBJS)
> -
>  t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
>  
>  t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
