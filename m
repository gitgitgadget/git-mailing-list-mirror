Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34745C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 18:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13A1238E6
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 18:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="E4IeDYm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgKQSq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 13:46:28 -0500
Received: from mout.web.de ([212.227.17.12]:39939 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgKQSq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 13:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605638772;
        bh=61Oxo3uZ02cl+C6A9Ex5xR3AQLbmGX7ZlWkfxRUKwKM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=E4IeDYm/tGqkMm3kHyUdPajt4LcS+bg7kWs3wFA/VdvojvyvQhxbWsP6wCyOqir+v
         kfuWDvQqOciNniCxgz7rPXintO1zAGKuaqQ5MDrr4/lj7B/QmGwluwEyqfOLbxc6nY
         41xmOBAsSZ+V9SCcyVY0KVnNx0Bo9sCRZNiJQsrY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgOCo-1krnYA35gk-00NmZV; Tue, 17
 Nov 2020 19:46:12 +0100
Subject: Re: [PATCH] chdir-notify: UNLEAK registrated callback entries
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
References: <8a9cf9ba-f615-3ff5-8d35-c24c22d5d859@web.de>
 <20201117002435.GA13516@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <202c4b1a-efb7-ee70-a287-567e651ff25e@web.de>
Date:   Tue, 17 Nov 2020 19:45:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201117002435.GA13516@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:28yheVdoYTexiuZxg9BDv0+qFcnqLoX+Ug4A3fMGZRz+dePi1nS
 z5bgEm8ajXgWKVvt5b+OIZYEyrJMC9lXuar94WJHCDsgWTAbgy7QAuAtUjuwnGCaCQ+MLCH
 YVL/tphYnSD6FRjGepvQgXsY8inMJ3yAznwqatLXMs8DpGghwGYBKiGe3/I0a8IvRDwcV1m
 nR6BeqwxalMbXaG8bgTWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6/nFduNawsM=:e4AvozeHNOrTBwAqnxONYr
 VzpQgQQDQLB+GXTZYI7wq5/LMEdHKE9KTlyf74lmNVUi2bBiBrkBulCESUoOMG1gcI81UNDu3
 QQEWZJNwPRsLNNPL9Lctvlg1zm8206HU7ObnoCG9Veu7QEdMDBbi09WkN+6iZoHcr8myusMyo
 EC4VgN34U1dQHkbpXmHDWy8F85LjPCSsa5Dz91S3vHnVLhvYrupSShPfxFTT3cKC/bF2U2mMK
 dT91M9NiDDKN1OYBq1iFZ0rCZBF8eE4br5+v+W7e9C9sHDEuShHA3xE1x2eBJo6pdbpokGR2+
 VlZGtm7e3+B8cqL5fRkVslwmUpI7/X7U8Skjgt8ZPd2S94tgFFJ+H49wiMNvNszASBRj5cjm5
 h0gb67TZcWpVBvqtNom98rv7G6TLkFSMsXzZLnRzrmfBYZWvz8PlMVlo8kHkUwiXw4cx7I2w5
 +Isxk/+5tf2Vuh5pjFoa97c56Z0W4WvNwJlAJpoqTsUdClEL3s5ALW6d5kORXsADGM8QW7UV4
 97jOB1YHIK+8Vud27E6wJdyHeKH8x0uqXbuKAb9OlYQnQ+wf96gOjskwMl2UgbKhCbDcPSYQd
 6kk1ZrLFqL4MWRIE3LYETkq/AoHH3G0dTM0OE+66wqhXKbcrh2acMAuuYx2U1/wflxJ2XCZBr
 1xp2YzX8NyMNLSY2jwTEZAa5I94z4g/AhFvNNRbWjKeC/w8WNyIyqzK+B8Az3oMDLUd3ELIHr
 OiAVxQndQeccFdFYwMQXkeqU0niooSdwC3v4LBNBxD2pkQKCUt1obTFmpaLPR/jAQd3bPgibQ
 T0TjKV8FpORLO4LZX6y9kVXninX+0xsM2lAztz9MqkoFzSgYMytEvnjJV0+B1qtT6PDYV8QDd
 C5kN7juvMQYdVydX1m3w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.11.20 um 01:24 schrieb Jeff King:
> On Sat, Nov 14, 2020 at 10:40:01PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> chdir_notify_register() allows registering functions to notify when
>> chdir() is called.  There is no way to unsubscribe or shut this
>> mechanism down, so these entries are present until the program ends.
>>
>> Valgrind reports allocations for these registrations as "possibly lost"=
,
>> probably because it doesn't see through list.h's offsetof tricks.
>> Annotate them using UNLEAK, which causes Valgrind to report them as
>> "still reachable" instead.
>
> I can't say I'm excited to see UNLEAK used here. It was really intended
> for items going out of scope that weren't worth cleaning up. But here
> we're papering over a failure in the memory checking tool for something
> that _is_ in scope.

Right, though I'd consider every use of UNLEAK as "papering over".  And
not being able to distinguish with certainty between pointer trickery
and accidents is more of a missing (or impossible) feature than a
failure in my book.

> I guess I'm not too surprised that valgrind has trouble with list.h. We
> have pointers into a heap-allocated block, but not the start of it.
> Curiously, ASan/LSan get this case right. So my first instinct is: use
> those tools, they're better. :)

Does Leak Sanitizer get it right or is it just as unsure, but reports
its findings more cautiously?

> If we did want to paper over this case for valgrind, I think this is a
> better way to do so:
>
> diff --git a/chdir-notify.c b/chdir-notify.c
> index 5f7f2c2ac2..ddfe703b1a 100644
> --- a/chdir-notify.c
> +++ b/chdir-notify.c
> @@ -4,10 +4,10 @@
>  #include "strbuf.h"
>
>  struct chdir_notify_entry {
> +	struct list_head list;
>  	const char *name;
>  	chdir_notify_callback cb;
>  	void *data;
> -	struct list_head list;
>  };
>  static LIST_HEAD(chdir_notify_entries);

A trick to hide the trick -- I like it.

> I also wonder if valgrind _is_ aware of the distinction, and that's why
> these show up as only "possibly lost". And indeed, the faq[1] says:
>
>  - "possibly lost" means your program is leaking memory, unless you're
>    doing unusual things with pointers that could cause them to point
>    into the middle of an allocated block; see the user manual for some
>    possible causes. Use --show-possibly-lost=3Dno if you don't want to s=
ee
>    these reports.
>
> and the user manual[2] has a more elaborate example that calls these
> "interior pointers". So I think that's exactly what is going on here.
>
> But then I'm not sure why we'd want this patch. List pointers (and now
> hashmap entries, which also contain a linked-list chain) are used in
> lots of data structures. Fixing this one case manually is not that
> interesting. If we're going to use valgrind, we probably need to accept
> that its "possibly lost" distinction is not useful for our code and turn
> it off.

That would probably disregard real issues as well -- but it's hard to
know how many without finding and classifying them.

Lists (and hashmaps) have cleanup methods that we could call, as Elijah
noted.  We can skip that in main() functions for production builds, but
cutting out the noise when SUPPRESS_ANNOTATED_LEAKS is set would surely
make finding real leaks easier.

Ren=C3=A9
