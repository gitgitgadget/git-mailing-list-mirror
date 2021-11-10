Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DEFC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 13:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264FE61055
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 13:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhKJNo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 08:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhKJNo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 08:44:58 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CCFC061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 05:42:10 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f4so10600122edx.12
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 05:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=17ejpIlYjznGD4TGGXhUdq+NJlLdARh5xGRj9MGEZA0=;
        b=LSk2ZulmHwwZVO949dIkQJZpphBF8TV82xYWh+r/OXqAzkCdvtceY7q27bqc2NwTVx
         nyJmjsf15MVsbyb5HzF7doIn6nEjqObcpDGOFUh7tjq4y0FTbp7yhJylzeynThw+3s9x
         BuXp+6JDty0ZRy7OcOHVuyFSuzHwA/wVFRpMLmK5UI0tHOE1eE+CicLljbCPijVPlS82
         0BOTmA7TQI2og1vBSrZzjrp0F0JElxAWq8dTgmzzAcw6kvi4npBagwRMp1/KgBPLbRKy
         7Wy77Zdnb9u92Kqiagghw37bwkZldYu55rLpInbHo3qsxYy+IKkchZXyCHcMJnYjojRH
         UZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=17ejpIlYjznGD4TGGXhUdq+NJlLdARh5xGRj9MGEZA0=;
        b=JxXBGwgvCJXh0LSfv/TJuN+OAwmM02J/ph+Zy8KvXvYKh5gtSmlU2HHm0kXVanzL/M
         bBWPBrP30J8bGZnNhyNl2DC9kFgcTzIKFhpNOvPrl7mumZ0t54V78o1FX3bGbSphnh3e
         BNAmOfXMI7HvOvN3JdfahRv4nQjMLSp8vI7bpUj7WqDFk/q2clty+j+aoO7ulGoT2M1I
         89roMMeAgvE82kVDs+GOCKHsDL8CM2k4dyjJnY+DImKMmXllgqjL8e5ZI/48G52LacPU
         eiWX2cniRK2gM4i96Q32Mi1QZb+/aHxikaUIIAhRoi77NI2Ph+P6xIPPAIe9pyZBFXxH
         FFFw==
X-Gm-Message-State: AOAM531GUYZstDvWUll+Pi7ferdaZRND3aP2fj13iVDikvx6+rjj5deA
        g8n0H/5kUfDckhNZLRc+GjpPW5iaeHe1QA==
X-Google-Smtp-Source: ABdhPJxkncReb69Ld55BYTOVUz1U/sEFDBHxY31e40DgOI5cMELbRH0dZi92BrS9hMVGBdH4yfEhbg==
X-Received: by 2002:a17:907:c15:: with SMTP id ga21mr20571495ejc.349.1636551728901;
        Wed, 10 Nov 2021 05:42:08 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id go10sm9431119ejc.115.2021.11.10.05.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 05:42:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mknrb-000wtt-N4;
        Wed, 10 Nov 2021 14:42:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Paul Smith <paul@mad-scientist.net>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 3/3] Makefile: replace most hardcoded object lists
 with $(wildcard)
Date:   Wed, 10 Nov 2021 14:21:32 +0100
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
 <patch-v2-3.3-cd62d8f92d1-20211101T191231Z-avarab@gmail.com>
 <24482f96-7d87-1570-a171-95ec182f6091@gmail.com>
 <211106.86tugpfikn.gmgdl@evledraar.gmail.com>
 <40dbf962-2ccd-b4d6-7110-31317eb35e34@gmail.com>
 <xmqqtugl102l.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2111101332130.21127@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2111101332130.21127@tvgsbejvaqbjf.bet>
Message-ID: <211110.86h7cki0uo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 10 2021, Johannes Schindelin wrote:

> Hi Junio,
>
> On Tue, 9 Nov 2021, Junio C Hamano wrote:
>
>> Allowing to be sloppy while maintaining Makefile feels like a false
>> economy, and having to paper it over by adding exceptions and
>> forcing developers to learn such ad-hoc rules even more so.
>
> If you ever needed another opinion to back you up on this: I fully agree.

I could go either way on that, but in terms of Makefile maintenance it
does suck a lot less to pick one or the other.

A (I realize, unstated) eventual goal I had was to move these wildcard
declarations to some common list you can include from various Makefiles,
currently we've got dependency bugs in e.g. Makefile &
Documentation/Makefile interaction.

If we're not OK with $(wildcard) as a pattern that would mean changing
all of these to hardcoded (in some cases quite big) lists somewhere:
    
    $ git -P grep -E '^[^~]+\$\(wildcard.+\*' ':!git-gui' ':!gitk-git' ':!contrib'
    Documentation/Makefile:         $(wildcard git-*.txt))
    Documentation/Makefile:HOWTO_TXT += $(wildcard howto/*.txt)
    Documentation/Makefile:DOC_DEP_TXT += $(wildcard *.txt)
    Documentation/Makefile:DOC_DEP_TXT += $(wildcard config/*.txt)
    Documentation/Makefile:API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
    Documentation/Makefile:mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
    Documentation/Makefile:%.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
    Makefile:command-list.h: $(wildcard Documentation/git*.txt)
    Makefile:POFILES := $(wildcard po/*.po)
    Makefile:LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
    Makefile:LIB_CPAN := $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
    Makefile:coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/coccinelle/*.cocci)))
    Makefile:coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pending.cocci))
    t/Makefile:T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
    t/Makefile:TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
    t/Makefile:THELPERS = $(sort $(filter-out $(T),$(wildcard *.sh)))
    t/Makefile:TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
    t/Makefile:CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
    t/interop/Makefile:T = $(sort $(wildcard i[0-9][0-9][0-9][0-9]-*.sh))

What do you & Junio think about that?

I don't really mind either way, as long as I stop running into
occasional bugs where I need to run "git clean -dxf" because the
Makeefile was too stupid to properly manage its dependencies.

>> If we could use "git ls-files" consistently, that may make it
>> somewhat safer; you'd at least need to "git add" a new file before
>> it gets into the picture.  But it would be impossible, because we
>> need to be able to bootstrap Git from a tarball extract.
>
> Indeed, the ability to build from a `.tar` extract is important. That's
> why we were careful to use `ls-files` in `LIB_H` and in
> `FIND_SOURCE_FILE`, falling back on using `find` if the `ls-files` call
> failed.

Why would you need any of that to *build* from a .tar extract? I think
we should remove that LIB_H thing entirely.

Its only purpose is to support someone who:

 1. Wants to do an *incremental* build, not a "build from tar". I.e. you
    build already, changed a header, and now you want to not over-build
    again.

    Your compiler is perfectly capable of locating headers in an -I dir
    for you.

 2. Doesn't have gcc or clang installed. Note "installed", not to
    build.

    Well, currently we require you to build with those to use .depends &
    COMPUTE_HEADER_DEPENDENCIES, but that's an easily fixable
    implementation detail.

    We can easily make the .depend files with gcc/clang and build with
    another compiler. I had a 5-10 line local change at some point to do
    that.

 3. Doesn't find it acceptable to have a fallback of just a glob like
    "**.h" for that "depends" target.

    I.e. we'd over-rebuild if you dropped in a new *.h we're not
    actually using into your extracted tarball, but really, who cares?

 4. Wants to run "make hdr-check" or "make pot", both of which I think
    are OK to say "you need to run this on a box that has .depends (or
    in the case of *.pot, we can use a greedier glob).

> And to be honest, even `LIB_H` and `FIND_SOURCE_FILE` would quite
> potentially better be hard-coded (with a CI check to ensure that they're
> up to date).

That would be a bug, just because I don't build on Windows doesn't mean
that I wouldn't like "make TAGS coccicheck" to find compat/win32/ at
all.

It doesn't do that now for a different reason, but that's a bug that
should be fixed.
