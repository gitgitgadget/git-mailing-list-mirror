Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E5BC433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 17:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379114AbiAURO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 12:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiAURO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 12:14:27 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6930C06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 09:14:26 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q22so881446wrc.5
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 09:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/vAhtmsnV0JAckOo2hx80pdsZ3glBFvNHyEKlxg+T8A=;
        b=mU8XSBEFjFv4R5hnID8b7sqQenW2gduN8upq1T/Q7jNTW4HHB8Qwxez4q2LGEr42TV
         SRVcLWKL/UpgyVewkpjFfJo7HfRGq+HmbM1+/HDkGv+6w5KXf7+Hy2Z6mN+nuqY5i+26
         NL8JEPSlRtfYMVSq96KXHVHnXz+8zaLi05IopfoiIA01nsOLrvllsWZ2SOn++VouGXDB
         UwQ1s8f/rpnojGGxanScGPqAUOnMqvy0hECgVdzIfjEATbntB5IZmLQUQXw+2JMWKJ5Z
         Yllk+DzJzmWVvjPTeO0iFYqxWe+X0Ubc0u4/AekkAjywxRXFlqhAExfh3ukaLHVIh+yK
         LKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/vAhtmsnV0JAckOo2hx80pdsZ3glBFvNHyEKlxg+T8A=;
        b=m+RoDaR6N90JW/HRnISyeaPsnWqoOy5Vs3Mx8f/qAiIuPar7D1TA1dH7JzG3bWZUfh
         gPnyxtjLjBE/hdfJX32EBVaWk3iY70MQST6zQsoYIn3pnp3K1kiPuufiEdtaj+cuM69e
         G2jczYmlh2cvT0hl+DGfXOLhTLPIRVsTlZpjGTWvrkKqmBRwEQIz3mC+mFXOVZ2RsDtY
         bTKiMYW8cZxE30liwoRiXeKGGhphz5XJKr2szYYlMiKSoMqVYPhpYIQ6pBreWjB/iHpL
         /j0aCv3ZcndUUpvm3R64CBiTWkxz0oB7/IPq8lOK3ewGXtbcfPzzTanPv4cfnQOW6ZcL
         J8yQ==
X-Gm-Message-State: AOAM530dEjb7acwHEi4UyVtO0YJhUVx8I7oLy8B64UbTy5+mX3rt44Y5
        n+q2rwu5uSC3YDG3E6l0qQ0=
X-Google-Smtp-Source: ABdhPJxXPGv3Ha+UzfxbYJskbP8yr2sS1DCrur/PVomXJAga4dEZGRBTW0ZFg/31knoCImDbw5lJjA==
X-Received: by 2002:adf:d08e:: with SMTP id y14mr2911911wrh.622.1642785265227;
        Fri, 21 Jan 2022 09:14:25 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id m187sm5499524wme.25.2022.01.21.09.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 09:14:24 -0800 (PST)
Message-ID: <4caf3c95-c19c-80c6-daea-84dcb3ec9663@gmail.com>
Date:   Fri, 21 Jan 2022 17:14:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] Makefile: replace most hardcoded object lists with
 $(wildcard)
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Paul Smith <paul@mad-scientist.net>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
 <patch-v2-3.3-cd62d8f92d1-20211101T191231Z-avarab@gmail.com>
 <24482f96-7d87-1570-a171-95ec182f6091@gmail.com>
 <211106.86tugpfikn.gmgdl@evledraar.gmail.com>
 <40dbf962-2ccd-b4d6-7110-31317eb35e34@gmail.com> <xmqqtugl102l.fsf@gitster.g>
 <220121.86o845jnvv.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220121.86o845jnvv.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 21/01/2022 12:01, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Nov 09 2021, Junio C Hamano wrote:
> 
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>>> We can also have some DEVOPTS knob so we'll prune out files found if
>>>> a
>>>> $(shell)-out to "git status" tells us they're untracked. I wouldn't mind
>>>> that (and could implement it) if it was optional.
>>>> Also note that you've got some of this already, e.g. we'll pick up
>>>> *.h
>>>> files via a glob for "make TAGS", the dependency graph etc.
>>>
>>> I'd be happier using 'git ls-files' with a glob if we need to move
>>> away from listing the files explicitly rather than having to pass some
>>> exclude list when running make. Having seen your comments below about
>>> ls-files/find I had a look at the Makefile and they always seem to be
>>> used together as "git ls-files ... || find ...". Doing that would mean
>>> we wouldn't try to build any untracked files but still find everything
>>> in a tarball.
>>
>> I've been quiet on this topic because honestly I do not find the
>> pros-and-cons favourable for more use of wildcards [*].  Tools like
>> git (especially .gitignore) and Makefile are to help users to be
>> safely sloppy by ensuring that random crufts the users may create in
>> the working tree for their convenience are not picked up by default
>> unless the project to consciously expresses the desire to use them.
>>
>> Allowing to be sloppy while maintaining Makefile feels like a false
>> economy, and having to paper it over by adding exceptions and
>> forcing developers to learn such ad-hoc rules even more so.
>>
>>      Side note: TAGS generation and some other minor things may use
>>      $(wildcard) and can throw tokens in cruft files in the output,
>>      which is not ideal, but the damage is local.  We cannot treat
>>      that the same as building binaries and tarballs.
>>
>> If we could use "git ls-files" consistently, that may make it
>> somewhat safer; you'd at least need to "git add" a new file before
>> it gets into the picture.  But it would be impossible, because we
>> need to be able to bootstrap Git from a tarball extract.
>>
>>>>>> We could make this simpler still for the Makefile by moving
>>>>>> "unix-socket.c" etc. to e.g. a "conditional-src/" directory, likewise
>>>>>> for $(PROGRAM_OBJS) to e.g. "programs/". If we did that we would not
>>>>>> need the "$(filter-out)" for LIB_OBJS. I don't think that's worth it,
>>>>>> e.g. due to "git log -- <path>" on the files now needing a "--follow".
>>
>> And it is not quite clear to me why we want to even more pile
>> workaround like this on top.  This also is to paper over the mistake
>> of being sloppy and using $(wildcard), which makes it unable to
>> distinguish, among the ones that match a pattern, between FOO_OBJS
>> and BAR_OBJS, no?  Moving files around in the working tree to group
>> related things together is a good thing, and it has been a good move
>> to separate built-ins and library-ish parts into different
>> directories.  But the above does not sound like it.
>>
>> Other than "these source files may or may not be compiled
>> depending", what trait do files in conditional-src/ share, other
>> than "dividing them into a separate category makes it simpler to
>> write Makefile using $(wildcard)"?  I do not think of a good one.
>>
>> The only time I found that the large list of files in Makefile was
>> problematic was *NOT* when multiple topics added, renamed or removed
>> the files (it is pretty much bog standard merge conflicts that do
>> not happen very often to begin with).  It is when this kind of
>> "large scale refactoring" for the sake of refactoring happens.
>>
>>> I'm not so worried about those other targets, but being able to
>>> reliably build and test git with some cruft lying around is useful
>>> though. I'm still not entirely sure what the motivation for this
>>> change is (adding new files is not that common) but I think using the
>>> established "git ls-files || find" pattern would be a good way of
>>> globbing without picking up rubbish if there is a compelling reason to
>>> drop the lists.
>>
>> Yes.
> 
> Reviewing the reftable coverity topic I was reminded of this
> patch. I.e. in it we have this fix:
> https://lore.kernel.org/git/xmqqtugl102l.fsf@gitster.g/
> 
> Which shows another advantage of using this sort of $(wildcard) pattern,
> i.e. if we had this:
> 	
> 	diff --git a/Makefile b/Makefile
> 	index 5580859afdb..48ea18afa53 100644
> 	--- a/Makefile
> 	+++ b/Makefile
> 	@@ -2443,33 +2443,9 @@ XDIFF_OBJS += xdiff/xutils.o
> 	 .PHONY: xdiff-objs
> 	 xdiff-objs: $(XDIFF_OBJS)
> 	
> 	-REFTABLE_OBJS += reftable/basics.o
> 	-REFTABLE_OBJS += reftable/error.o
> 	-REFTABLE_OBJS += reftable/block.o
> 	-REFTABLE_OBJS += reftable/blocksource.o
> 	-REFTABLE_OBJS += reftable/iter.o
> 	-REFTABLE_OBJS += reftable/publicbasics.o
> 	-REFTABLE_OBJS += reftable/merged.o
> 	-REFTABLE_OBJS += reftable/pq.o
> 	-REFTABLE_OBJS += reftable/reader.o
> 	-REFTABLE_OBJS += reftable/record.o
> 	-REFTABLE_OBJS += reftable/refname.o
> 	-REFTABLE_OBJS += reftable/generic.o
> 	-REFTABLE_OBJS += reftable/stack.o
> 	-REFTABLE_OBJS += reftable/tree.o
> 	-REFTABLE_OBJS += reftable/writer.o
> 	-
> 	-REFTABLE_TEST_OBJS += reftable/basics_test.o
> 	-REFTABLE_TEST_OBJS += reftable/block_test.o
> 	-REFTABLE_TEST_OBJS += reftable/dump.o
> 	-REFTABLE_TEST_OBJS += reftable/merged_test.o
> 	-REFTABLE_TEST_OBJS += reftable/pq_test.o
> 	-REFTABLE_TEST_OBJS += reftable/record_test.o
> 	-REFTABLE_TEST_OBJS += reftable/readwrite_test.o
> 	-REFTABLE_TEST_OBJS += reftable/refname_test.o
> 	-REFTABLE_TEST_OBJS += reftable/stack_test.o
> 	-REFTABLE_TEST_OBJS += reftable/test_framework.o
> 	-REFTABLE_TEST_OBJS += reftable/tree_test.o
> 	+REFTABLE_SOURCES = $(wildcard reftable/*.c)
> 	+REFTABLE_OBJS += $(filter-out test,$(REFTABLE_SOURCES:%.c=%.o))
> 	+REFTABLE_TEST_OBJS += $(filter test,$(REFTABLE_SOURCES:%.c=%.o))
> 	
> 	 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
> 
> We'd have a shorter Makefile, not need to manually maintain the list,
> and we'd have been getting linker errors all along on the dead code
> (just showing one of many here):
> 
> 	$ make
> 	[...]
> 	/usr/bin/ld: reftable/libreftable.a(generic.o): in function `reftable_table_seek_ref':
> 	/home/avar/g/git/reftable/generic.c:17: multiple definition of `reftable_table_seek_ref'; reftable/libreftable.a(reftable.o):/home/avar/g/git/reftable/reftable.c:17: first defined here
> 	[...]
> 	clang: error: linker command failed with exit code 1 (use -v to see invocation)
> 	make: *** [Makefile:2925: t/helper/test-tool] Error 1
> 	make: Target 'all' not remade because of errors.

Random cruft breaking the build was the reason I objected to this 
change, just because the cruft was being tracked by git in this case 
does not change that.

Best Wishes

Phillip
