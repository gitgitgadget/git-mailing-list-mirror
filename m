Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1081C433EF
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 00:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiAOAZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 19:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbiAOAZf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 19:25:35 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732A1C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 16:25:35 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o6so39898801edc.4
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 16:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Wht1tkSYOFuhjM4/ofHI3YPYJesoBS1ohVBoSLM8Mig=;
        b=Zujx7HtFc4t+YHfU/U8fbCKQV5Jj/W+W2uqxHMb4kWY603BB9qp19cxnk5Lqd5qWtf
         1a6aqP08Xz8buNh7I/vnKi3LVtJZwyLKqPRv3BtqR41Dwn2YSvExQmOsmAQl1x39tjDs
         Y5mMEr5xx8fKbVtHcCC3Afb3ERB4iv2XQTe2QeR5UY0ZBu574WSDnJnYpym5MR69LqDa
         495V6nEX4BP/HPeAy2cGfD6qCenAW43lqXKF3L4Vhb5dRbBfTb5+1i7mABglFmwUwuht
         FMHalXZdFJoWlxRxaBGAdQdGSBx1A0DNh40P7ZwrI9uuY2htiFEROSLamEFwdKs8i9a2
         Bj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Wht1tkSYOFuhjM4/ofHI3YPYJesoBS1ohVBoSLM8Mig=;
        b=NKUs42k1+DplrCE/lECtRXolzLBm7hhqWXj/Q4Fbx1+2eDnuEf/QUMk+s69FA9CW7S
         vJkpJMe5FTVAsvVVFCc/EJCvmdoGhm2+rB1/RF/+waHrUQ2JWFV3tNXGlbTNfKkP1wbd
         bcpakG+KAUzsdqgIV8VvOT3L/nqXJ5YzYT12LORhjaoBilz5YHiNApa5VMlAwTZU7vQ1
         hIFpmQDTE24tJDTOqbJVAAFSB3HUVTO7nJsAwvUVwy/8nACkFhycIaFkIqeyGJgbpoQH
         aM9cxYUnvSq3oycZXOgVjRjXF3O34Y+dPgPYTDdwDNcMAF2jG8sMwVqKvmczpLZovjcH
         f8IA==
X-Gm-Message-State: AOAM5320qpwOcccUBcRPPLlsqU04WoNoAnBOpllreX6F4XWjqktG/RFg
        zZjSHQQ23M/5DW6fMdWnKX9BpWIeEzvJ8A==
X-Google-Smtp-Source: ABdhPJx1FeXzvXPA7QwvdUUOXfy7WCydbxaRwQHEPWZmtF96i42T5xnjwTGE3jEqSY79LVwhZ7QL7w==
X-Received: by 2002:a50:da8f:: with SMTP id q15mr11471856edj.0.1642206333909;
        Fri, 14 Jan 2022 16:25:33 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ne35sm2226496ejc.48.2022.01.14.16.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 16:25:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8Wsu-001Hi8-5g;
        Sat, 15 Jan 2022 01:25:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
Date:   Sat, 15 Jan 2022 01:13:48 +0100
References: <cover.1642129840.git.dyroneteng@gmail.com>
 <xmqqfspqeun5.fsf@gitster.g> <220114.867db2rs0n.gmgdl@evledraar.gmail.com>
 <YeHnT1BcisbVvQHB@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YeHnT1BcisbVvQHB@camp.crustytoothpaste.net>
Message-ID: <220115.86pmotrgjo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2022-01-14 at 19:57:17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Thu, Jan 13 2022, Junio C Hamano wrote:
>>=20
>> > Teng Long <dyroneteng@gmail.com> writes:
>> >
>> >> +test_must_fail 'Exchange the order of "--heads" and <remote>' '
>> >> +    git --version &&
>> >> +    git init "test.git" &&
>> >> +    test_commit -C "test.git" one &&
>> >> +    git -C "test.git" ls-remote --heads ./. > result.1 &&
>> >> +    git -C "test.git" ls-remote ./. --heads > result.2 &&
>> >
>> > I would say that this is working exactly as designed.  As with the
>> > unix tradition, after the command name, first come options
>> > (e.g. "--heads", "-v", etc. that begin with a dash or two dashes),
>> > then arguments like "origin", "master", "." that are not dashed
>> > options/flags.
>> >
>> > Then among the arguments, we generally take revs first and then
>> > pathspecs.  "git help cli" explicitly mentions this, because it is
>> > specific to "git" command suite, but it does not mention "dashed
>> > options/flags first and then args", primarily because, at least back
>> > when the documentation was written, this was taken as granted, iow,
>> > those who wrote the "gitcli" documentation thought it was a common
>> > knowledge among users that did not need to be spelled out.
>> >
>> > Apparently, it is not a common knowledge at least for you (and
>> > probably others).  Perhaps we should add a paragraph to the cli help
>> > and explicitly mention "options first and then args", before we go
>> > on to say "among args, revs first and then pathspecs".
>>=20
>> I don't think this summary is accurate.
>>=20
>> We have multiple commands that are in GNU-fashion loose about whether
>> you provide options first before no-option args, or after. E.g. we
>> accept both of:
>>=20
>>     git push --dry-run <remote> <ref>
>>=20
>> And:
>>=20
>>     git push <remote> <ref> --dry-run
>>=20
>> The "tradition" you're referring to accurately summarizes how POSIX
>> specifies that things should work.
>>
>> But when GNU came around its option parser was generally happy to accept
>> options and args in either order. E.g. these both work with GNU
>> coreutils, but the latter will fail on FreeBSD and various other
>> capital-U UNIX-es:
>>=20
>>     touch foo; rm -v foo
>>     touch foo; rm foo -v
>
> Yes, POSIX specifies this is how it should work because it avoids
> ambiguity.  According to POSIX, -v is a file, and that's a valid name on
> Unix.  If GNU rm fails to delete that file or provide a diagnostic about
> why it didn't, that's a bug.

It's not a bug that its default behavior isn't to slavishly follow
POSIX, but if you'd like you can turn it on:
=20=20=20=20
    $ touch -- file -v; rm -v file -v
    removed 'file'
    $ touch -- file -v; POSIXLY_CORRECT=3D1 rm -v file -v
    removed 'file'
    removed '-v'

There's a good reason for this departure in behavior: If you have a
single file called '-v' POSIX doesn't provide any way to remove it other
than something like:

    rm ./-v

Which can be painful when scripting things. I.e. you'll need to munge
the name itself, v.s. consistently supporting "--":

    rm -- -v

> In some cases, we do allow the GNU behavior of providing options
> anywhere on the command line, but we don't when it causes ambiguity,
> like in this case.  I think we should document the current behavior, but
> I also think it's a given when working on Unix because many tools don't
> work that way.  For example, test and find don't permit arbitrary
> location of options and arguments and they are found on all Unix
> systems.  You can't write "test foo -f".

Yes, *nix systems are all over the place with this. And then e.g. "dd"
and the like accept arguments whose syntax pre-dates "-"-prefixed
arguments.

I'm only talking about how our command collection should behave, and how
we should explain its behavior, or what behavior we might prefer.

> And to prove that this is ambiguous, I provide you the following
> example:
>
> $ git update-ref refs/heads/--symref HEAD
> $ git ls-remote . --symref
> 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2        refs/heads/--symref
>
> That prints something very different if I write "git ls-remote --symref
> .".  And it is actually the case that people write this kind of syntax
> in scripts relying on the current behavior and then those scripts get
> used in a variety of situations with arbitrary ref names, so this should
> continue to work this way.  I believe a former employer may have these
> kinds of scripts, for example.
>
> I'm not opposed to us building new tools which support the GNU behavior,
> but I don't think we should change tools where we have the existing
> behavior because it does lead to breakage in some scripting situations.

Yes, my claim that it's "not ambiguous" in
<220114.867db2rs0n.gmgdl@evledraar.gmail.com> isn't correct, as you
point out.

I suspect those cases are probably too obscure to worry about in
practice, but yes, we might not want to convert any existing command due
to those.

But we should really be recommending use of -- or --end-of-options
whenever possible, as it can be hard to know in Git's CLI whether
options after args are accepted or not.
