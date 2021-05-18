Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE294C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6FF61261
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhEROmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 10:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbhEROmI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 10:42:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38297C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 07:40:49 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f1so11512115edt.4
        for <git@vger.kernel.org>; Tue, 18 May 2021 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:user-agent:message-id:mime-version;
        bh=ZoyfqtMF0tj5UA8zm55cxMNhRQSRlMj+ZMK1F4SE7EI=;
        b=BYZ8dK7A5v/Xwnu+wfmUxwupqr3FiW9By6yVe98Q1+uSMdO1vzQ2l8/AteoCffTyWM
         DMasXUho5FHXSp58WUn6UE+Idd7LtC6JJjbwoXNSzwt1VRd125gZX6uayFRTIe4avpyJ
         S9eOQXD7vVRAbpAyQ+b5XqxUDjMwHHxNbPiKeGlgvoDKJzNvUnG8+YwCLkOBoha9b7d0
         5xoW85x4F6vpoWtA2A6cqmfdfqFgpgSRF4UDd8OpFzN0s4vxaNLa/y64EAhkXdWAlsmZ
         rP6IWzbvXehbXfGauZ+j5sGzxL64GYXuCvP4/ldFXa6F7csqF6TA+jvC74FO1rwb7Ix6
         VkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:user-agent:message-id
         :mime-version;
        bh=ZoyfqtMF0tj5UA8zm55cxMNhRQSRlMj+ZMK1F4SE7EI=;
        b=L8jIn96IHbX8i+AoSuYykWZS/e8Lk6BSVmS4eZLxoL9CUvhKmO0NQD7+n5qk4r0Wcs
         l4uf69iV5HFm0StIqRLGMWt31MFltrk1X2Vgi9opGlzBXyG3G6Dsr/xM1Edkkk0J0nns
         /NWmPMjdImJEEG90A+LOOza3485ehq2CAyQLVhidGJ5ZAyMY7SfjTFMjVybMK2UXgiwa
         dDQpnZoFDgrMp6ZMo/STNos1CAmgaW2j1iTKxIEZfsuRnW92f0zLALDki+TI9BSBTX+Z
         nkedQQzhf94t/K0tpDHIitTCoIXveWeL2u1Fs4dp4u4fXSyzw8fP88lCAfE+ccYC/K10
         g+7w==
X-Gm-Message-State: AOAM532vOnXSsoxM50NUDSFKaxEMaSznbqMzvxncqJkyEieDcvGHXdeI
        0nSjEvl8Prnq9XKzPGrO58Q=
X-Google-Smtp-Source: ABdhPJw+zjuEKCG0r9SlJQRTASPmJVgp5dgwsnJnZ7nRXKl7W37DNyiKHnLBEEBSTdvNyLAxx5t1pg==
X-Received: by 2002:a05:6402:22a8:: with SMTP id cx8mr7562498edb.296.1621348847781;
        Tue, 18 May 2021 07:40:47 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gx23sm2357933ejb.125.2021.05.18.07.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:40:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        karthik nayak <karthik.188@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Options like hash-object --literally and cat-file --allow-unknown-type
Date:   Tue, 18 May 2021 16:08:18 +0200
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
Message-ID: <87r1i4qf4h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[Breaking the In-Reply-To chain per recent discussions on list, would
have been sent out with [1] if not. See
https://lore.kernel.org/git/xmqqo8eem5hr.fsf@gitster.g/ for the
replied-to message in context].

Skip to "Get to the point" for the "tl;dr".

On Fri, Apr 16 2021, Junio C Hamano wrote:

> Han-Wen Nienhuys <hanwen@google.com> writes:
>
>>> I would think that a better approach here would be to start with some
>>> (per-se unrelated) series to teach update-ref some mode like
>>> hash-object's --literally, i.e. "YOLO this ref update".
>>
>> I disagree.  I think this would be a job better suited to a
>> test-helper. Then we don't put tools into users' hands that
>> potentially corrupt the repository. I don't understand why hash-object
>> --literally is not a test helper either.
>
> As the person who invented the "--literally" option, I'd have to
> agree with this assessment.  It does make life a little bit easier
> for those who hack on Git codebase and reimplementations of it, but
> little practical value for those who use Git every day [*].
>
> If it were a tool to _dump_ the contents of a possibly corrupt
> object that the "--literally" option would have produced to make it
> easier to see by humans, I might be pursuaded to say that such a
> feature may be better in end-user accessible subcommands.  But the
> reason why we invented "--literally" was specifically to create
> corrupt objects in test repository to see end-user accessible tools
> behave, and in hindsight, such a use case shouldn't have been a good
> justification to add the option.
>
> I wasn't following the discussion of this particular patch closely,
> so I do not know what is being discussed is a tool on the diagnosis
> side (for which I may say it is OK to give to end-usres) or on the
> currupting side (for which I would regret to add to end-user tools),
> but hopefully the above would help guiding the decision between the
> two.
>
> Thanks.
>
>
> [Footnote]
>
> * ... for any purpose other than creating a corrupt repository,
>   asking somebody who is or claims to be a Git expert to figure out
>   what is wrong in his or her repository, and either waste expert's
>   time or have fun by watching the expert fail and gets embarrased,
>   that is ;-)

I totally get where you're coming from. We're talking about handing
users a loaded shotgun without the safety pin with --literally.

Having had some time to think about it though (and encountering various
code around it) since this E-Mail I think that on balance we're better
off with it than without it, and should extend it to update-ref et al.

I'm very much cognitively biased on the topic since 100% of my
interaction with these --literally objects is in hacking on git.git
itself, which if anything should serve as an argument not to have this
sort of thing in public tooling.

But I think one thing that makes git great is that we don't have opaque
magic at any level. Sure, we've got complexity, but you can always
devolve thing down to "simple" manipulation of the object store in cases
such as writing refs / loose objects.

So if for nothing else having a tool like hash-object take your raw
input is good for the educational value, even if it does (and should) do
sanity checking by default.

I actually think that like "mktag" it should do even more sanity
checking, I just think there should always be a way to turn that sort of
thing off. At the very lowest level our plumbing shouldn't be caring
about object validation at all. That also neatly allows us to
e.g. support creating an OBJ_NEW with a git version that doesn't
understand such a thing. We're unlikely to add new object types, but I
don't see why it shouldn't be supported.

In any case, to get to the point what prompted me to write this E-Mail
is that I'm annoyed that "cat-file --allow-unknown-type" exists at all,
i.e. I don't see the need for something like a "--literally" (originally
it was "cat-file --literally", see [2]) if we're talking about *reading*
objects, not writing them (hash-object without -w not withstanding).

In re-rolling my fsck fixes for what it does on unknown types[3] I've
ended up with sillyness like replacing the current bad error message
cat-file emits:

    $ git cat-file -t 7a52aafca353d2fd9f3faca575e9fe4fd48619d4
    fatal: invalid object type

With:

    $ ~/g/git/git cat-file -t 7a52aafca353d2fd9f3faca575e9fe4fd48619d4
    fatal: object 7a52aafca353d2fd9f3faca575e9fe4fd48619d4 is of unknown type 'bogus', refusing to emit it without --allow-unknown-type

I.e. now the guts of the object-file.c code don't have a way to ferry
that information up. Now it does via a "struct object_info", but (for
compatibility with documented behavior) it still refuses to "really"
print the type without --allow-unknown-type.

I think it should just print it unconditionally, perhaps with a
--no-allow-unknown-type "strict" mode.

We also currently don't support:

    $ git cat-file -p 7a52aafca353d2fd9f3faca575e9fe4fd48619d4
    fatal: invalid object type

But I've added support for that, we don't need to know about the type
itself to dump the raw content after the header, which is more useful,
and means you can roundtrip hash-object --literally and cat-file.

But most annoying is:

    $ echo 7a52aafca353d2fd9f3faca575e9fe4fd48619d4 | git cat-file --batch
    fatal: invalid object type

Now, looking at the implementation that's really a bug. We document:

    objecttype: The type of the object (the same as cat-file -t reports).

So you might expect it to accept an --allow-unknown-type, but it
doesn't. I could add support for that, but I think it would be stupid.

Why should you need to restart a "cat-file --batch" just because you
encounter a bad object? Just .. print it, we can do that safely. I
really don't see the point of having --allow-unknown-type at all. Ditto
for the --batch-check mode.

I mean, having read all the code I think I know why it's there. I think
It's because there was no way to ferry the information up from
object-file.c before my yet-to-be-submitted patches, so the solution was
to pass down a flag saying "please don't die()".

But is it something that anyone thinks is a good idea in the abstract? I
don't see why I shouldn't just document something like:

    Older versions of "cat-file" used to require an --allow-unknown-type
    flag to emit information about objects of unknown types. This is no
    longer required or the default. If you'd like to die on anything
    except known types (e.g. to die instead of bothering with parsing a
    "bad" type that possibly has spaces in it in the --batch output)
    supply --no-allow-unknown-type.

What do you think?

1.

    > In-reply-to: <xmqqo8eem5hr.fsf@gitster.g>

    > References:
    > <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
    > <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
    > <2dc73bf2ec96acae12a17c719083d11401775bc3.1618255553.git.gitgitgadget@gmail.com>
    > <87im4qejpk.fsf@evledraar.gmail.com>
    > <CAFQ2z_OSbeciLQnoognG+Hh5S1tZTHO6WUviC9h5YMer766k6g@mail.gmail.com>
    > <xmqqo8eem5hr.fsf@gitster.g>

2. https://lore.kernel.org/git/CAPig+cTcAq_p3QXqcG+o1saWZyvDHCW=_JWYn6s7B1L4X5X1cQ@mail.gmail.com/

3. https://lore.kernel.org/git/87im493yos.fsf@evledraar.gmail.com/
