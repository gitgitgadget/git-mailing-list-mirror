Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05B3C433E0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 18:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6868B64F78
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 18:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhCJSv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 13:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbhCJSu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 13:50:58 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF540C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 10:50:58 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso5486399pjb.4
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 10:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=E5I3eybp10QBOARB2B3zftjKU2qmNCsTa3FttP5x/HI=;
        b=ogOOGD+VBnnkiddQeNDlkwnsQLiuMB7PgCn/tQZUEuan999lv5vLF72DJ8w725sOup
         6DofPHeoH+xFnZ9seLvUpgjEihLAKYpWFUvhiJ5YlnYrifpoMjn7I91XU7COUqKAhZi7
         GV3ck1pZo3dAuj2uHnMQgdh8Los8LcxIKc/qEw+MXz4iqm4mGJY9+Go9woOqTcViSsR6
         ZhINIqJwShb+tHtUEJagL9BN2jYruck8r/OQ5/TYM8rxE7IMaXWiW8beWnx0LSBd5Lgo
         BoweMH0B1kyKBrZdiGW0/nJWc6Alt21KEwF4fSb4eNrkFgilGtOusoINXn/mmSEoI+DH
         2Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=E5I3eybp10QBOARB2B3zftjKU2qmNCsTa3FttP5x/HI=;
        b=U3lP1CvqsInAxeOqSDWLubGIBVizHEC8WR0jBvgvTTLIh1BW60wgbFsfIjhrdMYtz1
         ZI0A9oyB7eRZ22N60A1VDjcUjo2M9VWeZxh058dOwzYE9fqVdONsZxeG5zMsdqaWhTIE
         CRjgdgj7U33Ib8NBsD5r0FaCqljYMDqcZ2P77tPg0sAziWZt2QghM/PwhcEvEwmFocVa
         +rH2ZqXGyZbRRkD9ZSJ8EIILjAFnQLKsMh6i0lsxcNUAeAXqcxv/gThY7wpQQAASEzSc
         LO9ZWDCjmjnH4aWLULOW/o0YdxuMNks77WyU0Sp0k88nnVF4ZizrPbMdMML0c/5qIXov
         KFiw==
X-Gm-Message-State: AOAM532pjKi8rJ5FBj0wI3eFZ4zbNKy7s84QuoS+DjklZwOHVcSO6PFh
        9iyaC2qqFaDp6D5pj47SD9e4TyVupKtJpA==
X-Google-Smtp-Source: ABdhPJwpjjlnvZNUB3SOSPTnYaqEhWn/4FCtJZgQX7a/t+FNEC2KZHoB0rEd1RPjA4z9EUdueACNRQ==
X-Received: by 2002:a17:902:cb0b:b029:e5:b670:d905 with SMTP id c11-20020a170902cb0bb02900e5b670d905mr4369643ply.18.1615402257573;
        Wed, 10 Mar 2021 10:50:57 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:c4cf:5d59:92e7:3736])
        by smtp.gmail.com with ESMTPSA id 82sm254321pfv.19.2021.03.10.10.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 10:50:56 -0800 (PST)
Date:   Wed, 10 Mar 2021 10:50:49 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH v2] Update 'make fuzz-all' docs to reflect modern clang
Message-ID: <YEkVCRtVimEct0D8@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
References: <pull.889.git.1614514959347.gitgitgadget@gmail.com>
 <pull.889.v2.git.1614871707845.gitgitgadget@gmail.com>
 <xmqqlfb2cz8c.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfb2cz8c.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.03.04 14:48, Junio C Hamano wrote:
> "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Andrzej Hunt <ajrhunt@google.com>
> 
> > Subject: Re: [PATCH v2] Update 'make fuzz-all' docs to reflect modern clang
> 
> I'd retitte it to
> 
>     Makefile: update 'make fuzz-all' docs to reflect modern clang
> 
> > Clang no longer produces a libFuzzer.a, instead you can include
> > libFuzzer by using -fsanitize=fuzzer.
> 
> Do we see two sentences here?  IOW, s/, instead/. Instead/ is needed?
> 
> > Therefore we should use
> > that in the example command for building fuzzers.
> >
> > We also add -fsanitize=fuzzer-no-link to ensure that all the required
> > instrumentation is added when compiling git [1], and remove
> >  -fsanitize-coverage=trace-pc-guard as it is deprecated.
> 
> Without something like s/add/add to CFLAGS/, I found this a bit
> cryptic and failed to read what it wanted to do without looking at
> the patch text itself.
> 
> > I happen to have tested with LLVM 11 - however -fsanitize=fuzzer appears to
> > work in a wide range of reasonably modern clangs.
> >
> > (On my system: what used to be libFuzzer.a now lives under the following path,
> >  which is tricky albeit not impossible for a novice such as myself to find:
> > /usr/lib64/clang/11.0.0/lib/linux/libclang_rt.fuzzer-x86_64.a )
> 
> All nice things to have in the log message.
> 
> >  Makefile | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index dd08b4ced01c..c7248ac6057b 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -3292,11 +3292,11 @@ cover_db_html: cover_db
> >  # are not necessarily appropriate for general builds, and that vary greatly
> >  # depending on the compiler version used.
> >  #
> > -# An example command to build against libFuzzer from LLVM 4.0.0:
> > +# An example command to build against libFuzzer from LLVM 11.0.0:
> >  #
> >  # make CC=clang CXX=clang++ \
> > -#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
> > -#      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
> > +#      CFLAGS="-fsanitize=fuzzer-no-link,address" \
> > +#      LIB_FUZZING_ENGINE="-fsanitize=fuzzer" \
> >  #      fuzz-all
> >  #
> >  FUZZ_CXXFLAGS ?= $(CFLAGS)
> 
> LIB_FUZZING_ENGINE is used this way in the Makefile:
> 
>     $(FUZZ_PROGRAMS): all
>             $(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
>                     $(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
> 
> and it is somewhat annoying to see a compiler/linker option that
> late on the command line, where readers would expect an object file
> or a library archive would appear.

Yes, it appears that clang has changed how the fuzzing engine is
selected, as this used to be just a library path (as you see in the
diff). We might as well move this option up with the rest of the flags.

> It makes me wonder if we should
> instead be doing something along the following line:
> 
>  - empty LIB_FUZZING_ENGINE by default
>  - add -fsanitize=fuzzer names to FUZZ_CXXFLAGS
> 
> i.e.
> 
> diff --git c/Makefile w/Makefile
> index 4128b457e1..b5df76b33b 100644
> --- c/Makefile
> +++ w/Makefile
> @@ -3306,14 +3306,15 @@ cover_db_html: cover_db
>  # are not necessarily appropriate for general builds, and that vary greatly
>  # depending on the compiler version used.
>  #
> -# An example command to build against libFuzzer from LLVM 4.0.0:
> +# An example command to build against libFuzzer from LLVM 11.0.0:
>  #
>  # make CC=clang CXX=clang++ \
> -#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
> -#      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
> +#      CFLAGS="-fsanitize=fuzzer-no-link,address" \
>  #      fuzz-all
>  #
>  FUZZ_CXXFLAGS ?= $(CFLAGS)
> +FUZZ_CXXFLAGS += -fsanitize=fuzzer
> +LIB_FUZZING_ENGINE =

I don't think we want to mess with FUZZ_CXXFLAGS, as oss-fuzz may be
adding conflicting -fsanitize args here. Having LIB_FUZZING_ENGINE
default to empty should be fine though.

>  
>  .PHONY: fuzz-all
>  
> 
> In the meantime, I'll queue the version you sent as-is (modulo the
> retitling).
> 
> Thanks.
> 
> 
