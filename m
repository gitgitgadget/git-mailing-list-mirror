Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07A661F404
	for <e@80x24.org>; Tue, 28 Aug 2018 14:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeH1SVS (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 14:21:18 -0400
Received: from mout.web.de ([212.227.17.12]:48759 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbeH1SVS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 14:21:18 -0400
Received: from [192.168.178.36] ([91.20.48.192]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M7KR8-1fgxea43SY-00x2ds; Tue, 28
 Aug 2018 16:29:11 +0200
Subject: Re: [PATCH v3 6/7] fsck: use oidset for skiplist
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <20180827194323.17055-1-avarab@gmail.com>
 <20180827194323.17055-7-avarab@gmail.com>
 <87lg8refcr.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c356f239-f3f4-242b-fb75-95a4ccbe374b@web.de>
Date:   Tue, 28 Aug 2018 16:29:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87lg8refcr.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SEjBKOfq/AVpSqgCArqE22qTGs6BZOVtcjpRBf0q5QRq0h/fXEO
 H6oXwzi77HEhzGHHqMTmp5zq53+LqfX5bH44cLc/8rFEAo2SVc1RBIZm2xUzG0pDGzMQPYw
 xVw9qwLmkTARmCy5HNbmQ1i36LMQQzw8bKbxxKl71wBqS75UgdEzg3pUnWUA7MyGi1hhrTt
 jEO/HaYK+L4llYZozqG7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F961b1GFFeE=:M2BCCgEUSYHQsJtlJrK9f8
 SEsLIW/w5FfKyLM4a7fEet94VkbWwx++FhfKj7lJLYvdFSAULLYayG3nzbD5sIJSY2Qzyj64p
 MKWmZtK3hHWjqjln6XjAChsopY/Z3lBm9MDxJMTBDkr1AMyuPwWEcodqdKzp0dKtXfQsO5WTr
 jbXzDgtfcRKpf0Ol/D5qRWyDFD5TrvO388WUZDgEb9mrQEfEJSmC0PFRmEBNg6y4ZDhhS3TSP
 vLOkdyDA/soIKfvS3l+amEsZauQdB4f/Lq4Weql19ktJjU5BTBdLOVPnS+EmoM6qy364293bD
 TVGJXEPkBHOqqDiLN9R8R7NT47S+ivQ57QC5F7Fa82NlchKsnqLJSAqWadY1StfQ4AxHfL7fh
 f0nLq0vcfV805tUsgZ87wDCgaVbqcAnQ3pGcpoowDc/TkBPABGwQjuGCTboYDlxflDF3OsF3E
 fbjGw9MPiYE5sXoHrRemFldb125t2+7DQUrd/ri7VHxeRjrU2zlOOrP1cJHRgEy28adUQwgzn
 q5o11lfBGkApxBJ561qGrlsrJsYCju3b4IIaXVPGVGjsxDnhpBWsWZvBYC50bgIyM7rK/5yAa
 vJjGysBkcyUYpUy5OJqEQk5Hm7e936wveLBxgAsHX34H+Af8Eyk3mVRU36mvw5uKZPEvRkF1W
 WQD/c/OMNmHlXgjrf/3dYEHS5zQniJ3aFOWlF8T+LeGT0dGBuKRdCu6+iNmb8tB6hHA9+6ghp
 Xps+jzGKSiLHFnS687ElMSKvYiit2ULaYUJjMKn6ruGL+2TceIEGLLNVCWbpke8znK1JHiVoP
 z4rDSTZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.08.2018 um 22:15 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Mon, Aug 27 2018, Ævar Arnfjörð Bjarmason wrote:
> 
>> From: René Scharfe <l.s.r@web.de>
>>
>> Object IDs to skip are stored in a shared static oid_array.  Lookups do
>> a binary search on the sorted array.  The code checks if the object IDs
>> are already in the correct order while loading and skips sorting in that
>> case.  Lookups are done before reporting a (non-fatal) corruption and
>> before checking .gitmodules files.
>>
>> Simplify the code by using an oidset instead.  Memory usage is a bit
>> higher, but we don't need to worry about any sort order anymore.  Embed
>> the oidset into struct fsck_options to make its ownership clear (no
>> hidden sharing) and avoid unnecessary pointer indirection.
>>
>> Performance on repositories with a low number of reported issues and
>> .gitmodules files (i.e. the usual case) won't be affected much.  The
>> oidset should be a bit quicker with higher numbers of bad objects in
>> the skipList.
> 
> I didn't change this commit message at all, but FWIW this still has me
> somewhat confused. What is the interaction with .gitmodules being
> described here? You also mentioned it in
> https://public-inbox.org/git/113aa2d7-6f66-8d03-dda4-7337cda9b2df@web.de/
> (but I don't get that either)

The skipList is consulted before checking .gitmodules blobs, since
fb16287719 (fsck: check skiplist for object in fsck_blob()).

> Does that just mean that when cloning with --recursive with
> transfer.fsckObjects=true we'll re-read the file for each "clone"
> invocation, both for the main project and everything listed in
> .gitmodules?

That is probably true, but I didn't mean that.  I was only talking
about when an object is looked up in the skiplist (oid_array/oidset).

> If so, I think something like this commit message would be clearer:
> 
>     fsck: use oidset instead of oid_array for skipList
> 
>     Change the implementation of the skipList feature to use oidset
>     instead of oid_array to store SHA-1s for later lookup.
> 
>     This list is parsed once on startup by fsck, fetch-pack or
>     receive-pack depending on the *.skipList config in use, so for fetch
>     it's currently re-parsed for each submodule fetch.

OK; the patch doesn't change that, though.  Mentioning it sound like
a good idea if the load takes a significant amount of time -- I
didn't measure this separately, so perhaps this needs to be explored
further if people use big skipLists.

>     Memory usage is a bit higher, but we don't need to keep track of the
>     sort order anymore. Embed the oidset into struct fsck_options to
>     make its ownership clear (no hidden sharing) and avoid unnecessary
>     pointer indirection.
> 
> Then let's just attach the test program you wrote in
> https://public-inbox.org/git/113aa2d7-6f66-8d03-dda4-7337cda9b2df@web.de/
> and note the results and let them speak for themselves.

I was surprised that such a big repo can be mocked up relatively
quickly, but the numbers are a bit underwhelming -- there is not a
lot of change.  The script is not too expensive, so I don't mind
adding it.

> I can do all that if that seems fine to you. I also notice that the test
> case only sets up a case where all the items on the skip list are bad
> commits in the repo, it would be interesting to test with a few needles
> in a large haystack (I can modify it to do that...).

I tried something like this first, and its results are even more
boring.  Since skipList lookups are done only for bad objects (and
.gitmodules) you won't see  any difference at all.  Having only bad
objects is the edge case, this test being designed to highlight the
performance of the skipList implementation.

René
