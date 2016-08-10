Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1031FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S940887AbcHJTGh (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:06:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35094 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbcHJTGe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:06:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so11389175wmg.2
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:06:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2lWFUB6lhidZLqPEiYQMNpegC0uNapS79QC2OCGSHuA=;
        b=oiUu1lZgGQ8op96MPZ7yPEj0IhFzESZHcLaLdcauaThZGmV/6p25t4VhTvS2ldsSFE
         4Cd3nzr7yH784s9KqiK4kskmrJ6q8HVbrqjKf5qbWOcpi7ZpIuSt+97GCs30yceLYSKE
         HM8FUp1RzOaLtuxmRoNFLMyASROeMrK/yQ28zPgZXBUhgSZ1Wc+daRvfwUuKVyeM8CBx
         T49Omn1ydDhVij258oUTgedQzYO72KNW+gTmPBLJfpE1Ixpj0W4R1gQLfvsG/ho0uyxI
         AuPEiAaw+YUKkZD0yFZJaj3YLGBxt75NL2NIm8fPKb2QaU3ZZeL4p9DH5OAHgmBMB08u
         nfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2lWFUB6lhidZLqPEiYQMNpegC0uNapS79QC2OCGSHuA=;
        b=F5NOiIUqKs47Yc07sVY2PJbqq2088fPj4fitgtLtfhp1peBmKgovr6Eb9csZYibetJ
         YCZMLttOJg22OQuJXdfrhImfinmJRaII2b16tqtxIh/mfyKnkt3XCt6ZHTXP/lzBlki4
         aA8urBDOKtrgyFr9/RZtWNDFRy6KD8KrJEjPdp1I7Cd3KwNenkhi4/VjEr+DmEcQ+2XN
         3XmN72eUasNuOtMJ6bo+JMzTIzI9aMFg0T1WRk0ZZqonfVjAyMi3LYSstIyY2w4T/aO5
         oSAImIjyLBoC+GRjghA2KQMgmXkPUiFyrby8zgmOEGZ1bBUjFvwbMRMMIJiGoCWUQ3iG
         P2PQ==
X-Gm-Message-State: AEkoouuG8QmS90et5cTK7zgsQ2Wju8u23Wo1EqDjPCYQ5h55EqHKFUgcRPjB1ybEXcxN2PjeIOkTvci469uTiw==
X-Received: by 10.194.87.101 with SMTP id w5mr5861109wjz.94.1470847958923;
 Wed, 10 Aug 2016 09:52:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Wed, 10 Aug 2016 09:52:38 -0700 (PDT)
In-Reply-To: <xmqq60raewod.fsf@gitster.mtv.corp.google.com>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
 <20160808210337.5038-34-chriscool@tuxfamily.org> <xmqq60raewod.fsf@gitster.mtv.corp.google.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Wed, 10 Aug 2016 18:52:38 +0200
Message-ID: <CAP8UFD2ZAdUjQnO-4qnum2_AK84SfBN2_yO=py+Jj+pkV8pk-w@mail.gmail.com>
Subject: Re: [PATCH v10 33/40] environment: add set_index_file()
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 12:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Now if someone really needs to use this new function, it should be
>> used like this:
>>
>>     /* Save current index file */
>>     old_index_file = get_index_file();
>>     set_index_file((char *)tmp_index_file);
>>
>>     /* Do stuff that will use tmp_index_file as the index file */
>>     ...
>>
>>     /* When finished reset the index file */
>>     set_index_file(old_index_file);
>>
>> It is intended to be used by builtins commands, in fact only `git am`,
>> to temporarily change the index file used by libified code.
>>
>> This is useful when libified code uses the global index, but a builtin
>> command wants another index file to be used instead.
>
> That is OK, but I do not think NO_THE_INDEX_COMPATIBILITY_MACROS has
> much to do with this hack.  Even if you stop using the_index and
> have the caller pass its own temporary index_state, that structure
> does *not* know which file to read the (temporary) index from, or
> which file to write the (temporary) index to.  In fact, apply.c
> already does this in build_fake_ancestor():
>
>     static int build_fake_ancestor(struct patch *list, const char *filename)
>     {
>             ...
>             hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
>             res = write_locked_index(&result, &lock, COMMIT_LOCK);
>             ...
>     }
>
> As you can see, this function works with a non-standard/default
> index file _without_ having to use non-default index_state.  What
> the set_index_file() hack allows you to do is to use interface that
> does *NOT* pass "filename" like the caller does to this function.
>
> Isn't the mention on NO_THE_INDEX_COMPATIBILITY_MACROS in the added
> comments (there are two) pure red-herring?

Yeah, true.

So do you want me to refactor the code to use
hold_lock_file_for_update() instead of hold_locked_index() and to
avoid the set_index_file() hack?

Or would the set_index_file() hack be ok with a commit message like
the following:

---
Introduce set_index_file() to be able to temporarily change the
index file.

Yeah, this is a short cut and this new function should not be used
by other code.

It adds a small technical debt, that could perhaps be avoided with a
refactoring and by using hold_lock_file_for_update() instead of
hold_locked_index() to pass the filename where the index should be
written.

Now if someone really needs to use this new function, it should be
used like this:

    /* Save current index file */
    old_index_file = get_index_file();
    set_index_file((char *)tmp_index_file);

    /* Do stuff that will use tmp_index_file as the index file */
    ...

    /* When finished reset the index file */
    set_index_file(old_index_file);

It is intended to be used by builtins commands, in fact only `git am`,
to temporarily change the index file used by libified code.

This is useful when libified code uses the global index, but a builtin
command wants another index file to be used instead.
---

And with comments like this on top of set_index_file() definition and
declaration:

/*
 * Hack to temporarily change the index.
 * Yeah, the libification of 'apply' took a short-circuit by adding
 * this technical debt.
 * Please set the filename using for example hold_lock_file_for_update(),
 * instead of this function.
 * If you really need to use this function, please save the current
 * index file using get_index_file() before changing the index
 * file. And when finished, reset it to the saved value.
 */

?
