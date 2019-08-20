Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D971F461
	for <e@80x24.org>; Tue, 20 Aug 2019 20:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbfHTUaG (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 16:30:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54762 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730646AbfHTUaE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 16:30:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC16F7BB7D;
        Tue, 20 Aug 2019 16:30:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MaaIH3BwJCVTEHyGeed7qIILdFE=; b=uUgUpY
        5VW6HCy7ubC6W7ysdJp1ip8tCsb0FCsKb4JaiOsBIoVy8OOsMv2HC44PRFsFnUVd
        FW913wwIpNhLgg583PZzDbgEe23e7wu6Ni7tpbBUhz5I5kGlnY2+Oey66F+7P5Fa
        u42/0xWIzCYRKnvh/EaxTHETsp18tByYffnqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jvdLqMUdAn6XBRMrE09mcakVftEfdTzA
        aPMGxz97QGYo7q53OER5BP49PoJpqkWfhK+8RAS9ThHFrgBIvr467hsuk5JoYWNG
        K5gU4P/DuWAbgPcqxwSyxP0HI4AEHnuEMLqhSDOoPgNVg4t8eePCZZGs3S6P0weT
        RgFtllYa7cc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1B557BB7C;
        Tue, 20 Aug 2019 16:30:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C356F7BB77;
        Tue, 20 Aug 2019 16:29:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, garimasigit@gmail.com, jeffhost@microsoft.com,
        stolee@gmail.com, Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH 1/1] quote: handle null and empty strings in sq_quote_buf_pretty()
References: <pull.314.git.gitgitgadget@gmail.com>
        <9d2685bdb2e193986bec8cad88795963977d41fe.1566329700.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Aug 2019 13:29:57 -0700
In-Reply-To: <9d2685bdb2e193986bec8cad88795963977d41fe.1566329700.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Tue, 20 Aug 2019 12:35:01
        -0700 (PDT)")
Message-ID: <xmqqtvabtwai.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 480B754A-C389-11E9-80B0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Garima Singh <garima.singh@microsoft.com>
>
> In [1], Junio described a potential bug in sq_quote_buf_pretty() when the arg
> is a zero length string. It should emit quote-quote rather than nothing.
> This commit teaches sq_quote_buf_pretty to emit '' for null and empty strings.
>
> [1] https://public-inbox.org/git/pull.298.git.gitgitgadget@gmail.com/T/#m9e33936067ec2066f675aa63133a2486efd415fd

It would be more helpful to omit "Junio described a bug" and say
what the bug is.  As written, people still need to go back the list
archive to read what I said in order to understand what bug was
noticed by me, but you can save their time by describing the bug
directly in the log message.  For example:

    The sq_quote_buf_pretty() function does not emit anything when
    the incoming string is empty, but the function is to accumulate
    command line arguments, properly quoted as necessary, and the
    right way to add an argument that is an empty string is to show
    it quoted, i.e. ''.

or something like that.  The credit to discoverer, if you must, can
be given with

    Reported-by: ...

before your sign-off, but I do not think it is worth the trouble
this time.

>  create mode 100644 t/helper/test-quote.c
>  create mode 100755 t/t0091-quote.sh

I do not appreciate these two new files only to test this corner
case.  That feels overly inefficient and unwieldy.  It also hides
the potential impact of the bug from readers to run *only* a unit
test by using the function directly from an invented, non-real-world
caller that is a program in t/helper/.  It sometimes cannot be
helped as some codepath is harder to trigger from the actual
codepath in Git that matters in the real-world and is OK to resort
to t/helper/ program, but in this particular case, with a little
effort, we can find a codepath that can be used to feed an empty
string to the function quite easily.

Here is what I did for example.

 $ git grep sq_quote_buf_pretty

tells me that sq_quote_quote_argv_pretty() calls it.

 $ git grep sq_quote_argv_pretty

then tells me that trace_run_command() makes a call to it.  This is
perfect, as we can have "git" run a command with arbitrary command
line args and have trace print what it did.

So...

 $ GIT_TRACE=1 git -c "alias.foo=frotz foo '' bar" foo
 13:19:51.999614 git.c:703               trace: exec: git-foo
 13:19:51.999695 run-command.c:663       trace: run_command: git-foo
 13:19:51.999963 git.c:384               trace: alias expansion: foo => frotz foo  bar
 13:19:52.000327 git.c:703               trace: exec: git-frotz foo  bar
 13:19:52.000348 run-command.c:663       trace: run_command: git-frotz foo  bar
 expansion of alias 'foo' failed; 'frotz' is not a git command

With the bug fixed, 

 $ GIT_TRACE=1 ./git -c "alias.foo=frotz foo '' bar" foo
 13:22:16.777692 git.c:670               trace: exec: git-foo
 13:22:16.777806 run-command.c:643       trace: run_command: git-foo
 13:22:16.778084 git.c:366               trace: alias expansion: foo => frotz foo '' bar
 13:22:16.778315 git.c:670               trace: exec: git-frotz foo '' bar
 13:22:16.778329 run-command.c:643       trace: run_command: git-frotz foo '' bar
 expansion of alias 'foo' failed; 'frotz' is not a git command

we can see that the second arg to git-frotz is prettily shown.
