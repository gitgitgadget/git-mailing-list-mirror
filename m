Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE6DC433FE
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 12:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380248AbiAUMEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 07:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380283AbiAUMEj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 07:04:39 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B08BC061574
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 04:04:39 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id p12so42154062edq.9
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 04:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=l0QFFQl2Cb+rdSTeF4HK7GcTValW0ngpTETOA2ikvnA=;
        b=eNxfsdzIDMGXRl7AD5okxQjQlBxqpsa+D6kM+N9aUDXv1+z4MPnsntAdCV7GEMma3W
         CLSeTmtrMhqTb4eOg2fab+AEXw1Xd7dN4SLMj48M7Zpm1gBn9mwccCH3nwZoWLk+73ju
         vGVbz4eDs/8hi5zyeHM71zs4AJSc1hT0GcpH+mmrx5hxQ1QaSj4F82/4oQAUeCs7yQyI
         Rn5XhmsH36y/GwnIkybIaOTR38/I6S6sA3kLzMR66QOMLJkhP7399+WB3o/5rE8MaPwl
         hOHzWgos9iToICEHcVcWD5PlkD0YVN/afKyyJzryz/6pdnQQmIcnet5sRRgjJcmEye7b
         go4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=l0QFFQl2Cb+rdSTeF4HK7GcTValW0ngpTETOA2ikvnA=;
        b=jpx7A/QX2BYj4oIlN8UPrHpklTtd35yC95A6hmMB4c3I8NUjhYByhDj81nzEXpjwOI
         f/ADDzaCNrqQd6QjSoLze848xqhyqQSbLW4KLRNM+arF8+qO/oxpo1/8Vb0nt2dkzAFv
         ROOik7QgwLLKebQMlzeJ49vb9sewF3FRxfrmA+RkgeoUyCczdosVsKOb+s0Z5O7hPntP
         m7fEK6ViX6tjCxMBORN0qaAJ0TRKkmrZ14xdQicEdb2FYS7LwbzHivc/h5W4fNW8EXtl
         iLU5TuAppXlHnO7542V3AjT9DIWNH6tbUe5RS64FqZvYuzLsycW7+umHxNen4Ta+tr8E
         vrjA==
X-Gm-Message-State: AOAM530pZthHzwnL9XPPomK4grnl2yHhF5njCq1CeVfpmKkbASZd6p4a
        6O4TNQrYH46/8MZRyVZgxms=
X-Google-Smtp-Source: ABdhPJyBou4qHcX17MlNShT8QZt8IKMVZy8KQrEIq6DNfVXHVByZNvw7P8PgtNJmzPq6mtJplFu1Ow==
X-Received: by 2002:a17:906:175b:: with SMTP id d27mr3196551eje.476.1642766677506;
        Fri, 21 Jan 2022 04:04:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s12sm1997249ejx.184.2022.01.21.04.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 04:04:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAsei-0027yL-CL;
        Fri, 21 Jan 2022 13:04:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Paul Smith <paul@mad-scientist.net>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 3/3] Makefile: replace most hardcoded object lists
 with $(wildcard)
Date:   Fri, 21 Jan 2022 13:01:40 +0100
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
 <patch-v2-3.3-cd62d8f92d1-20211101T191231Z-avarab@gmail.com>
 <24482f96-7d87-1570-a171-95ec182f6091@gmail.com>
 <211106.86tugpfikn.gmgdl@evledraar.gmail.com>
 <40dbf962-2ccd-b4d6-7110-31317eb35e34@gmail.com>
 <xmqqtugl102l.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqtugl102l.fsf@gitster.g>
Message-ID: <220121.86o845jnvv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 09 2021, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>>> We can also have some DEVOPTS knob so we'll prune out files found if
>>> a
>>> $(shell)-out to "git status" tells us they're untracked. I wouldn't mind
>>> that (and could implement it) if it was optional.
>>> Also note that you've got some of this already, e.g. we'll pick up
>>> *.h
>>> files via a glob for "make TAGS", the dependency graph etc.
>>
>> I'd be happier using 'git ls-files' with a glob if we need to move
>> away from listing the files explicitly rather than having to pass some 
>> exclude list when running make. Having seen your comments below about
>> ls-files/find I had a look at the Makefile and they always seem to be 
>> used together as "git ls-files ... || find ...". Doing that would mean
>> we wouldn't try to build any untracked files but still find everything 
>> in a tarball.
>
> I've been quiet on this topic because honestly I do not find the
> pros-and-cons favourable for more use of wildcards [*].  Tools like
> git (especially .gitignore) and Makefile are to help users to be
> safely sloppy by ensuring that random crufts the users may create in
> the working tree for their convenience are not picked up by default
> unless the project to consciously expresses the desire to use them.
>
> Allowing to be sloppy while maintaining Makefile feels like a false
> economy, and having to paper it over by adding exceptions and
> forcing developers to learn such ad-hoc rules even more so.
>
>     Side note: TAGS generation and some other minor things may use
>     $(wildcard) and can throw tokens in cruft files in the output,
>     which is not ideal, but the damage is local.  We cannot treat
>     that the same as building binaries and tarballs.
>
> If we could use "git ls-files" consistently, that may make it
> somewhat safer; you'd at least need to "git add" a new file before
> it gets into the picture.  But it would be impossible, because we
> need to be able to bootstrap Git from a tarball extract.
>
>>>>> We could make this simpler still for the Makefile by moving
>>>>> "unix-socket.c" etc. to e.g. a "conditional-src/" directory, likewise
>>>>> for $(PROGRAM_OBJS) to e.g. "programs/". If we did that we would not
>>>>> need the "$(filter-out)" for LIB_OBJS. I don't think that's worth it,
>>>>> e.g. due to "git log -- <path>" on the files now needing a "--follow".
>
> And it is not quite clear to me why we want to even more pile
> workaround like this on top.  This also is to paper over the mistake
> of being sloppy and using $(wildcard), which makes it unable to
> distinguish, among the ones that match a pattern, between FOO_OBJS
> and BAR_OBJS, no?  Moving files around in the working tree to group
> related things together is a good thing, and it has been a good move
> to separate built-ins and library-ish parts into different
> directories.  But the above does not sound like it.
>
> Other than "these source files may or may not be compiled
> depending", what trait do files in conditional-src/ share, other
> than "dividing them into a separate category makes it simpler to
> write Makefile using $(wildcard)"?  I do not think of a good one.
>
> The only time I found that the large list of files in Makefile was
> problematic was *NOT* when multiple topics added, renamed or removed
> the files (it is pretty much bog standard merge conflicts that do
> not happen very often to begin with).  It is when this kind of
> "large scale refactoring" for the sake of refactoring happens.
>
>> I'm not so worried about those other targets, but being able to
>> reliably build and test git with some cruft lying around is useful
>> though. I'm still not entirely sure what the motivation for this
>> change is (adding new files is not that common) but I think using the
>> established "git ls-files || find" pattern would be a good way of
>> globbing without picking up rubbish if there is a compelling reason to
>> drop the lists.
>
> Yes.

Reviewing the reftable coverity topic I was reminded of this
patch. I.e. in it we have this fix:
https://lore.kernel.org/git/xmqqtugl102l.fsf@gitster.g/

Which shows another advantage of using this sort of $(wildcard) pattern,
i.e. if we had this:
	
	diff --git a/Makefile b/Makefile
	index 5580859afdb..48ea18afa53 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -2443,33 +2443,9 @@ XDIFF_OBJS += xdiff/xutils.o
	 .PHONY: xdiff-objs
	 xdiff-objs: $(XDIFF_OBJS)
	 
	-REFTABLE_OBJS += reftable/basics.o
	-REFTABLE_OBJS += reftable/error.o
	-REFTABLE_OBJS += reftable/block.o
	-REFTABLE_OBJS += reftable/blocksource.o
	-REFTABLE_OBJS += reftable/iter.o
	-REFTABLE_OBJS += reftable/publicbasics.o
	-REFTABLE_OBJS += reftable/merged.o
	-REFTABLE_OBJS += reftable/pq.o
	-REFTABLE_OBJS += reftable/reader.o
	-REFTABLE_OBJS += reftable/record.o
	-REFTABLE_OBJS += reftable/refname.o
	-REFTABLE_OBJS += reftable/generic.o
	-REFTABLE_OBJS += reftable/stack.o
	-REFTABLE_OBJS += reftable/tree.o
	-REFTABLE_OBJS += reftable/writer.o
	-
	-REFTABLE_TEST_OBJS += reftable/basics_test.o
	-REFTABLE_TEST_OBJS += reftable/block_test.o
	-REFTABLE_TEST_OBJS += reftable/dump.o
	-REFTABLE_TEST_OBJS += reftable/merged_test.o
	-REFTABLE_TEST_OBJS += reftable/pq_test.o
	-REFTABLE_TEST_OBJS += reftable/record_test.o
	-REFTABLE_TEST_OBJS += reftable/readwrite_test.o
	-REFTABLE_TEST_OBJS += reftable/refname_test.o
	-REFTABLE_TEST_OBJS += reftable/stack_test.o
	-REFTABLE_TEST_OBJS += reftable/test_framework.o
	-REFTABLE_TEST_OBJS += reftable/tree_test.o
	+REFTABLE_SOURCES = $(wildcard reftable/*.c)
	+REFTABLE_OBJS += $(filter-out test,$(REFTABLE_SOURCES:%.c=%.o))
	+REFTABLE_TEST_OBJS += $(filter test,$(REFTABLE_SOURCES:%.c=%.o))
	 
	 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))

We'd have a shorter Makefile, not need to manually maintain the list,
and we'd have been getting linker errors all along on the dead code
(just showing one of many here):

	$ make
	[...]
	/usr/bin/ld: reftable/libreftable.a(generic.o): in function `reftable_table_seek_ref':
	/home/avar/g/git/reftable/generic.c:17: multiple definition of `reftable_table_seek_ref'; reftable/libreftable.a(reftable.o):/home/avar/g/git/reftable/reftable.c:17: first defined here
	[...]
	clang: error: linker command failed with exit code 1 (use -v to see invocation)
	make: *** [Makefile:2925: t/helper/test-tool] Error 1
	make: Target 'all' not remade because of errors.
