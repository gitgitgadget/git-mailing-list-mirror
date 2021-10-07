Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB12DC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 12:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B733F6124A
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 12:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbhJGMVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 08:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241169AbhJGMVB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 08:21:01 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B197C061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 05:19:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a25so6689141edx.8
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=kMjJG89S8ly094hht/A0LuTU279qL53x0SvDECr0O6E=;
        b=DY+VQdmCrhKPjRPlF7f5M9alLL6QCitWFqZwexWGBzVfJgzMiDWRkQUNX0QIE9kVSV
         jI+EMyg0GwErs88lt02Ka8r6gBjhABaRflxSFjA/RYGTIjdOJF+HDtPYSyH45GUnTqtd
         W/r2dZXrmgcqpd2ONXRNkKX3M72jJPZat3fgsxdPmBlQZpZ6z4AdU5x/a67rCNAUrkdz
         klk47K7gpvnFNwATmG42ayofVNOZv9vfYAbFT4ulGwihpMuALHEMd5elNU7HRy1VV4pk
         vqk9Xsa80Zigaci5JFUoJn532GzRd6AbzN9wACYRBIwbruInjQ+T5MU7Y29D/+W1i0jp
         FeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=kMjJG89S8ly094hht/A0LuTU279qL53x0SvDECr0O6E=;
        b=hQi+uSeqFKGskO/rnjiBcPHR3d9pYS4ncqWJIdih7jFH/JCqU1j87n+dkhyKaM3z2H
         /idPdwLACgxXXTmYDlxKtcRO3h5puYYTqJFAlDYNmPeTTrwsLAZ1MDw/r7oOeL65muut
         u5P5yDM8m2LHHB3tJ+wt+uFJoClGj5OvTHibzRn2TYlPN/iWqVUaSYv5VBLHtgLVnSxf
         A6kT4chzNvnGjozNpsvLdhf84DjYrF+MfCmJdkmLyrPO130cLAPFzRDxsfTtDdfLf8r1
         NAfoKz+3iA97V1UoyH60hIvmR/25NjyRSk3j+FftAnU+YKBGDHjesEAGponDs40DKElI
         T58w==
X-Gm-Message-State: AOAM533whEFI4TqpGnm6g4eIaQf7BYY9rSH1vtL0ITuzy+TY3dpzz+g7
        F+fdh2puXokgQaUeJHqL3Mfuq3gFIGYMIQ==
X-Google-Smtp-Source: ABdhPJzse2SiCvoBUs7OWJwrhsATA6aL3kbnG5NQf5uJtD5P+QYJCUDg8ScZ9PjfNtzcWz/r+Azwgw==
X-Received: by 2002:a17:906:4cc1:: with SMTP id q1mr5072006ejt.415.1633609146359;
        Thu, 07 Oct 2021 05:19:06 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d6sm6419963ejd.116.2021.10.07.05.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:19:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 00/15] Upstreaming the Scalar command
Date:   Thu, 07 Oct 2021 13:28:07 +0200
References: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
 <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
Message-ID: <87fstdgh8m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 07 2021, Johannes Schindelin via GitGitGadget wrote:

>  * The OBJECTS list in the Makefile will now include Scalar.

So that looks like a partial fix for what I brought up in [1] [...]

> Range-diff vs v4:
>
>   1:  852ec003109 !  1:  7119a8efc21 scalar: create a rudimentary executable
>      @@ Commit message
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>       
>        ## Makefile ##
>      -@@ Makefile: endif
>      - .PHONY: objects
>      - objects: $(OBJECTS)
>      - 
>      +@@ Makefile: OBJECTS += $(FUZZ_OBJS)
>      + ifndef NO_CURL
>      + 	OBJECTS += http.o http-walker.o remote-curl.o
>      + endif
>      ++
>       +SCALAR_SOURCES := contrib/scalar/scalar.c
>       +SCALAR_OBJECTS := $(SCALAR_SOURCES:c=o)
>       +OBJECTS += $(SCALAR_OBJECTS)
>       +
>      - dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
>      - dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
>      + .PHONY: objects
>      + objects: $(OBJECTS)

Except that this & contrib/scalar/Makefile is still broken in multiple
ways. We now have two Makefiles that can build contrib/scalar/scalar:

    touch advice.h; make -j8 contrib/scalar/scalar

But try:

    $ touch advice.h; (cd contrib/scalar 2>/dev/null && make scalar)
    make: 'scalar' is up to date.

I.e. (I'm presuming in response to what I brought up in [1]) the
depenency graph in the top-level Makefile is correct in this specific
area. But it understands the ".depends" files (depending on
COMPUTE_HEADER_DEPENDENCIES), your sub-Makefile doesn't.

There's similar whack-a-mole issues in other areas, e.g.:

    make -C contrib/scalar/ test

Will break or not depending on whether you've built the top-level
git.

I noticed at least one other subtle breakage (first thing I checked
after those two).

I'm happy to send you a working patch to integrate that fixes all these
issues, it also integrates with "make install", this series leaves us
with a "scalar" binary, but no way to install it, if we just piggy-back
on the existing installation procedure.

The side-thread on the v3[3] that you most recently replied to is
conflating some suggestion of shipping this as a built-in, with the
purely build-system implementation details I'm suggesting here.

I did mention using it as a built-in in [4], but for the semi-related
issue of scalar.c copy/pasting less code from git.c. But that was in the
context of such a thing being purely a non-visible implementation
detail. I.e. it would still be "scalar", not "git scalar".

*That* suggestion is just a side-musing about whether it would be easier
to teach git.c to inspects its argv and have a special-case for
dispatching to cmd_scalar(), a user would never know the difference. I
think that might also be worthwhile, but I care *way* less about that
than making maintaining the Makefile a hassle, and it's an entirely
orthogonal suggestion.

1. https://lore.kernel.org/git/875yu9iolf.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/87mtofnzv1.fsf@evledraar.gmail.com/
3. https://lore.kernel.org/git/xmqq1r5qzv35.fsf@gitster.g
4. https://lore.kernel.org/git/87k0jhn0p9.fsf@evledraar.gmail.com/
