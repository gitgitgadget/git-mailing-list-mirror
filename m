Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5B7C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 20:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D586115B
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 20:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhINUhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 16:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbhINUhC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 16:37:02 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF54AC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 13:35:44 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id jo30so535054qvb.3
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 13:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NZHGe3qsrNoMsTtRC4we+UeLhf+DO0sIH8+QZGZuHzY=;
        b=Vq2hw3Cng7m3J+AeWgr5k8OeUkLPVqHqZYc/0ce/uT06o8Swpxu/A5n5++4uo8dtWi
         4eomr6b7a9cO7DZ2sOOgfycWXkAH+9jpngu3CF73TWgyD083ECVbBPQPIh8TozIcWRx9
         Pb6YKniZWWzgGNYQO49z2RkuPM7YRQiEBasdE52qB5FuIKiCXiw3/ApmWfLQrinmBL8W
         hk2kOjwLdWmrbHSRFv69uTakRuUP/TGUzgY3WBzDZCZzMrT2QEhAhFRwg0yyqhPB3y1T
         G6xQgK+hAGRAzMg66z5HFHntecmDsLGS1mVmGudF3Bv69p+VXngeqRgzVeJnCmIDF5KA
         /CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NZHGe3qsrNoMsTtRC4we+UeLhf+DO0sIH8+QZGZuHzY=;
        b=S7Eb0gJcNyIq3jFKgGfbSQ6qeCKvUnKRQYdFrnUTAKN9khQeGzKS6g9HNBtvzFaKnH
         qNUaxukFyY/KrmS5eO45N4ECP/ejfx5diE1XlSODSINKg0RDxHiVHjgjD06951xRmChW
         8HfQh7coUSvpcnVy1FWzLDjcRFeXaSESYTwd25EqI4KmsvEP+iu7rW0xj6eE+vDuQM3+
         lfeiARGHN69+upEWPwjcZts2Ecc+5dAZEOcTadv6aLbGS8boChtXo3KB9ARDDZ3gN49U
         DYc8M0QfTHVmNgQRYTWB2/OuRP568onwl/htUBJXWTHy49MyqFOidFlRu1jJHBv4N/YX
         OM0A==
X-Gm-Message-State: AOAM533rjCJ+rwce7HL1QW+yAkTupuYlSIi7cIOIQTOVA8l93ca6furG
        KcLq8vMUGe5ZN6zDHHjPvHZ0IyJw6iDpcg==
X-Google-Smtp-Source: ABdhPJzhhORYZWOsJxp9uYdC7KfGSAm+IsbYNgDkTthnNi+iTPqHJRyNJikBIzxgM1jpuxc2Ii2t/Q==
X-Received: by 2002:a05:6214:605:: with SMTP id z5mr7628112qvw.34.1631651743938;
        Tue, 14 Sep 2021 13:35:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:69b3:ffa7:def5:d604? ([2600:1700:e72:80a0:69b3:ffa7:def5:d604])
        by smtp.gmail.com with ESMTPSA id 69sm8963231qke.55.2021.09.14.13.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 13:35:43 -0700 (PDT)
Subject: Re: Train station analogy, was Re: [PATCH v3 00/15] [RFC] Upstreaming
 the Scalar command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
 <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
 <87r1dydp4m.fsf@evledraar.gmail.com> <87ilz44kdk.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2109131914080.55@tvgsbejvaqbjf.bet>
 <87mtofnzv1.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2109141432520.59@tvgsbejvaqbjf.bet>
 <xmqqilz32hhr.fsf@gitster.g> <87ilz3nhfg.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5ae0c3fe-52a4-49b2-32c2-17feab2dd2d5@gmail.com>
Date:   Tue, 14 Sep 2021 16:35:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87ilz3nhfg.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/14/2021 2:09 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Sep 14 2021, Junio C Hamano wrote:
> 
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> At least to me, how this Makefile for Scalar should interact with
>> the overall build process does not mesh well with the story about
>> hwo direction to and history of the station are unrelated.  If we
>> plan to start from contrib/ and eventually want to make it a part
>> of the core Git (i.e. "git scalar <subcmd> ..." becomes just like
>> "git bisect <subcmd> ..."), we would eventually need to see the
>> recipe needed for including "bisect" and "scalar" work the same
>> way, no?

We should definitely work to find a better way to describe our
vision for how _the ideas in Scalar_ can be adopted into Git proper.

Before this series, we were adding functionality to Git that allowed
Scalar to simplify to just a CLI that configures Git features. This
submission allows that CLI to be available via an opt-in compile flag.
This should allow more users to try out the ideas and perhaps we find
the things that really work for people (and almost more importantly,
the ideas that are _too_ opinionated).

But the way I see Scalar being fully incorporated into Git is not as
a "git scalar <foo>" command or even having "scalar" be included by
default. Instead, perhaps a new builtin would need to be created and
its CLI would need to be presented and reviewed with significant
attention to long-term support in the Git project. Having Scalar as
a testing ground for these ideas seems like a positive way forward.

This is a big reason why we think that contrib/ is a good place for
it to exist.

>> I am getting the impression that such a unified build process is
>> Ævar wants to see at the end, I am not even sure if you do from
>> the above "analogy".  Cool down a bit, perhaps?

I agree that the temperature of this thread has gotten a bit
heated. I think there is something valuable to be gained from
each perspective, but not in a way that either has presented it.

>> The following assumes that you share the goal of making "git
>> scalar" just like "git bisect"---another first class citizen of
>> Git toolbox, the user can choose to use it or the user may not
>> have a need to interact with it, but it exists there by default
>> and is not an opt-in add-on component.
>>
>> I would understand it if your plan is to convert to a unified
>> build procedure at the very end of the upstreaming process, and
>> not while you populate contrib/ with more and more scalar stuff,
>> because the Makefile bits for the entire scalar, while not yet
>> upstreamed, has already been written as a separate procedure and
>> having to convert the whole thing upfront before you can start
>> trickle parts would mean you need to (re)start the process.  And
>> I would even be sympathetic if you felt it like a distraction.
>>
>> But at least I view it as a step that needs to happen sometime
>> between now and at the end.  I do not yet have an opinion on
>> which one is more pleasant, between (1) having to deal with a
>> single Makefile that needs to be aware of two different locations
>> *.[ch] lives in, and (2) having to deal with two Makefiles that
>> duplicates definitions and risks them needlessly diverging.

Since we already need to modify the root Makefile, I think having
the root Makefile add the files from contrib/scalar from an
optional flag is a great way to reduce duplication across multiple
Makefiles while also maintaining the Scalar is compiled optionally.

One big goal is to minimize how often we need to update Scalar. I
can see things like adjusting the recommended config once per
release cycle based on which new features are available. I don't
really want to be spending time updating the Makefile to match a
contribution that was already carefully reviewed and tested. I
also don't want to put the burden of updating contrib/scalar upon
those contributors.

> For what it's worth what I had on top of this is not (1) or (2), but a
> (0): I.e. there isn't a contrib/scalar anymore, I moved:
> 
>     contrib/scalar/scalar.c -> scalar>     contrib/scalar/scalar.txt -> Documentation/scalar.txt
>     contrib/scalar/t9099-scalar.sh -> t/t9099-scalar.sh
> 
> We build, test, and otherwise check (e.g. "make check-docs") it by
> default, what we don't do is install it unless you ask. You need to run:
> 
>     # Or any other install* target
>     make install install-doc INSTALL_SCALAR=YesPlease
> 
> It could be be kept in contrib/scalar/ even with that sort of approach,
> and it would still be simpler than the two-Makefile approach.

I think keeping it in contrib/scalar is best for now. But I do
agree that a single Makefile has benefits.

One early suggestion from a while back was to modify git.c to
handle the "scalar" executable as well as the "git" executable,
specifically to reduce duplication handling options such as

  -c config.key=value
  -C worktree
  --exec-path

and similar commands. While our duplication of the "-c" option
does add similar code in a second place, these other options
are less critical for Scalar, especially in its current version.
I think refactoring the code in git.c to cater to the "scalar"
executable is at least premature. If we want to pursue these
other options in the future, then that refactoring could happen
as a separate discussion after the rest of the build system and
CLI have been figured out.

_Perhaps_ Johannes still had that level of integration in his
head when responding to the single-Makefile recommendations.

> But just moving the code, tests and documentation where everything else
> lives cuts down an all sorts of special cases, file globs in various
> places (e.g. doc lints) will just work and won't need adjustment.
> 
>> I also would understand it if the reason why you want to keep the
>> top-level Makefile as intact as possible because you sense a high
>> probability that scalar will stay in contrib/ and even turn out
>> to be a failure.  Keeping the build procedure separated certainly
>> will keep it easier to yank it out later.  But I do not think
>> such a case is quite likely.
> 
> For what it's worth the WIP patch(es) I have on top of it will probably
> make such a thing even easier, not that removing it from the tree would
> be much of a problem in either case. It's mostly a few lines added to
> lists in various places in the Makfile.

Do you have a version of these patches available for adaptation
into this series? I'd like to take a look and see what it would
look like to squash them into this series. Forgive me if I just
missed the link. (I see the diff you posted earlier in this thread.)

> If I were to clean this up properly most of the changes would be
> teaching the Makefile that it can build N number of named top-level
> "special" commands that get dropped into bin/, not just the "git" we
> hardcode now.

This is an interesting idea for revamping how adjacent tools are
compiled and shipped with Git from contrib/ (or possibly elsewhere
if we decided to start including more things as "blessed helpers".

As a complete aside: I'm interested in using the sparse-checkout
feature as I work on the Git codebase, just to make sure I hit
pain points before any other user.

This is the best that I could do for my purposes:

$ git sparse-checkout list
.github
Documentation
builtin
compat
contrib/scalar
ewah
git-gui
gitk-git
gitk-gui
gitweb
mergetools
negotiator
perl
po
refs
sha1dc
sha256
t
templates
trace2
xdiff

And 'git status' reports that this includes 97% of the tracked
files. Perhaps there are ways to make this be smaller by having
make skip building things like git-gui if the directory doesn't
exist. Another idea would be to skip any logic around translating
messages if the 'po' directory is missing.

The reason I bring this up is that I'm interested in finding
ways to make our build system be streamlined a bit using the
presence of directories as a way to opt in/out of certain build
outputs. Since Scalar is being added as a new component, this is
a good opportunity to establish a pattern that works for this
effort, too.

Thanks,
-Stolee

