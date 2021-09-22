Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8BBC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 16:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB536105A
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 16:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbhIVQ7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 12:59:52 -0400
Received: from avasout02.plus.net ([212.159.14.17]:58614 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhIVQ7u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 12:59:50 -0400
Received: from [10.0.2.15] ([217.32.115.204])
        by smtp with ESMTPA
        id T5ZYmN7PerasdT5ZZmNRF3; Wed, 22 Sep 2021 17:58:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1632329898; bh=K59Ullu2/VhEgm98twRZPr1baG3/GTpqh/u2GnxZZ54=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NJKUOdVHiEBU90gxyrYOW2eCsQOKpNnBpmkDFeU6OQ74/asQ7IjnJ0SNe7fkrJBwm
         XsYs9ZhOEYsHPG6iwnpgCvOeIghRH1exvGZpg7oQAOCjcXJ0kGjGhpsHuv/e6jxJOK
         cNDC7xjlTy6Lo5Io1VFltFHv20BBZLCuZAILLhoD/DOvwXtg1jpWSHibXKmDc5mCa/
         I/sWVLYX4jIz8Gtect043ax+GB4de8LuTZOe7c/PjdYSDCNqo5OhYofIQaqENgBRhz
         DAX6MVb+r9dEmaxYEJoEcYv7kiKcz3TV5nCRA+VPA3UoZL6rNpFbs2A5fFjU7DDR+n
         TZzuuSavEq9Nw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=dIE9ZNRb c=1 sm=1 tr=0
 a=SVJmvQqwCtcAfy+lhBggeQ==:117 a=SVJmvQqwCtcAfy+lhBggeQ==:17
 a=IkcTkHD0fZMA:10 a=FIB_ZjVnoVkjKK0TpOgA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 0/3] Makefile: make "sparse" and "hdr-check" non-.PHONY
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
 <YUqQzn5vFDpbF5dM@coredump.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <c13b050c-abb9-c669-b92c-930f2b43ce10@ramsayjones.plus.com>
Date:   Wed, 22 Sep 2021 17:58:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUqQzn5vFDpbF5dM@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNdqhepPhHoxOQU2yyF6a4PZ0nriKc26R5o575zxlhydn1IP9ArxalkDbr71K7x0LhQtxw6gunt18LnRfJ4NfACfWL5L4MZZOiVjmv+6oZdu8+I+rJxB
 NczLX/NXT2J9Mhy2aqUZJpJ7TUTBcSy5v1+YAqLwZOY2Se2qUl/wTCmAnm5MOKA+pOdeZ83MonGH6A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/09/2021 03:11, Jeff King wrote:
> On Wed, Sep 22, 2021 at 12:55:12AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
>> Now that my series to only build "TAGS" when we strictly need to has
>> landed in 1b8bd2243e7 (Merge branch 'ab/make-tags-cleanup',
>> 2021-09-20), let's do the same for the "sparse" and "hdr-check"
>> targets.
>>
>> For *.c files we'll now generate corresponding empty *.sp and *.hco
>> files when "sparse" and "hdr-check" are run, respectively. If either
>> of those errored on the *.c file we'd fail to refresh the
>> corresponding generated file.
> 
> All three seem pretty reasonable to me.

Heh, interesting. My initial reaction was completely negative! ;-P
(and not just mildly negative either, but 'you must be kidding').

However, I then thought 'I must be missing something, I'm being
stupid and about to embarrass myself in public!'. So, I have
been trying hard to understand what these patches are trying to
accomplish and just what it is I'm missing. But, I'm coming up
blank ...

At the heart of my unease is dependencies (or rather the lack) for
the 'synthetic object files' *.hco and *.sp. (Also, the addition
of even more 'shrapnel' to the build directories - I wrote a patch
to remove the useless *.hcc files just after commit b503a2d515e was
included, but didn't get around to submitting it).

So, lets try something:

  $ make hdr-check
  GIT_VERSION = 2.33.0.517.g53f5cfaf01
      HDR add-interactive.h
  ...
      HDR xdiff-interface.h
  $ 

OK, that seems to work.
  
  $ find . -iname '*.hcc' | wc -l
  208
  $ find . -iname '*.hco' | wc -l
  200
  $ 

Hmm, odd:
  
  $ find . -iname '*.hcc' | sed s/.hcc// | sort >zz
  $ find . -iname '*.hco' | sed s/.hco// | sort >xx
  $ diff zz xx
  90d89
  < ./merge-strategies
  137d135
  < ./reftable/slice
  152d149
  < ./sha1-lookup
  198,202d194
  < ./vcs-svn/fast_export
  < ./vcs-svn/line_buffer
  < ./vcs-svn/sliding_window
  < ./vcs-svn/svndiff
  < ./vcs-svn/svndump
  $ 

... just noticed in passing, I didn't investigate.

Now, by definition, every '*.hcc' file depends on git-compat-util.h, so
after changing that header an 'hdr-check' should check every header:

  $ touch git-compat-util.h
  $ make hdr-check
      HDR git-compat-util.h
  $ 

Hmm, disappointing! Similarly, if I change (say) 'cache.h', then all
the headers that '#include' that file, in addition to 'cache.h', should
also be checked:
  
  $ git grep -n 'include.*cache\.h' -- '*.h' | wc -l
  35
  $ touch cache.h
  $ make hdr-check
      HDR cache.h
  $ 

Hmm, not quite. So, the sparse target should have similar problems:
  
  $ make sparse
      * new build flags
      SP abspath.c
  ...
      SP remote-curl.c
  $ 

OK, that works.
  
  $ find . -iname '*.sp' | wc -l
  452
  $ 
  
  $ make sparse
  $ touch git-compat-util.h
  $ make sparse
  $ touch git.h
  $ make sparse
  $ touch git.c
  $ make sparse
      SP git.c
  $ 
  
  $ make clean
  ...
  rm -f GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-VARS
  $ find . -iname '*.sp' | wc -l
  452
  $ 
 
Ah, yes, you may want to add the removal of the 'synthetic objects' to the
make clean target!

As I said, I don't quite understand what these patches want to do, so I can't
offer any solutions. :( Well, you could *add* the necessary dependencies,
of course, but that could lead to a rabbit hole which I would not want to
go down!

ATB,
Ramsay Jones

 

