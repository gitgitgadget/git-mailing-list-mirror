Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BDCC4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 14:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDEB161222
	for <git@archiver.kernel.org>; Sat, 29 May 2021 14:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhE2Oz2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhE2Oz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 10:55:27 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33766C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 07:53:49 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id y76so7389146oia.6
        for <git@vger.kernel.org>; Sat, 29 May 2021 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=GY9C/ynHRSv+gpgoOkmKZ58m7Eh7MCIEH1ez986f6u0=;
        b=BlOWCzePwqCF9Xny1XiVb+y76esCg8WhXEvxuDfCq3pvhSXkOFZUEp8bGcagsmAdTH
         IQxpX9YahlRLfIrKOx8BStOjtySrdDb61Qjraiwu1z1vb0PVnvs1A1x4g5YFiOROYG7g
         jGxBTrNtnX2O7IzMoj1Fq8FDfqf+kPJMEKCjNzxd4QRN9xgIkxpFcff8eWKNzqdXWMLI
         JOb8Osdnqy9CwHcYehTECVypp/OflqQ3BaTsMEQ0r92W8izDdH6SsDgNG3od65NisGVQ
         g7RFgNDq9VB/Gvc2afsic/vtXaWf92Nd7/DTfanUglQY/oX+as8vU2YPq6l0LTRElh3r
         ZzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=GY9C/ynHRSv+gpgoOkmKZ58m7Eh7MCIEH1ez986f6u0=;
        b=rVD7i2PbdArSBiWVHmQ5WiXKv15BUsKcOxm6czot7Q53C6loKiDjB3gyU71QG4ePH9
         HDHp4GR0nj3VDAmUZuZs+kX6Qyye23oX3hpUgXhkQ8HpH3dy+dfzXaszvBjmIK212/X0
         rFA+bUIqui+s1OyFvhb1++xtx7uDOuj2NBYYm9tRoyqD83+NVU7hRTmNeK9vEm1Qje0G
         h1g5IV4eLidAe4ffT5WxX7EXxlArMYRN9cxVmDqj6XaUDfiYhrKam0z0dXXlMe+74nLo
         XuH16nOztGL/i0Foh60mzTAL1VioHcGU78NQGPOu1EadhPvrup8NtCNhAZOqX4Z+++qY
         1qtg==
X-Gm-Message-State: AOAM533/nLfOQAhrOZHDRGgubFNPWjJqDjTBRFTROVuqM1uexAGBN4PO
        Y3xht4q1x0dcMCSmYhQ1fKg=
X-Google-Smtp-Source: ABdhPJwtkOMsY8xDYPAMhQlqS4PLWa9HVkSsQ4WW29IA5MRGdea0M70c6mmqwxUtaxC1frlMIkbpAQ==
X-Received: by 2002:aca:f2c1:: with SMTP id q184mr12275265oih.29.1622300029036;
        Sat, 29 May 2021 07:53:49 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id s76sm1709562oie.50.2021.05.29.07.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 07:53:48 -0700 (PDT)
Date:   Sat, 29 May 2021 09:53:47 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Gregory Anders <greg@gpanders.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Message-ID: <60b2557b5c7da_2650882084e@natae.notmuch>
In-Reply-To: <87czta2b47.fsf@evledraar.gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
 <YKYdeom6SgAHqojm@coredump.intra.peff.net>
 <xmqqv97drmge.fsf@gitster.g>
 <875yzcpo52.fsf@evledraar.gmail.com>
 <60b11101e5288_50514208b4@natae.notmuch>
 <87czta2b47.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v2 00/10] send-email: various optimizations to speed up by
 >2x
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Fri, May 28 2021, Felipe Contreras wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> Returning a flattened list is idiomatic in Perl, it means that a cal=
ler
> >> can do any of:
> >> =

> >>     # I only care about the last value for a key, or only about
> >>     # existence checks
> >>     my %hash =3D func();
> >
> > I was staying on the sideline because I don't know what's idiomatic i=
n
> > Perl, but Perl and Ruby share a lot in common (one could say Perl is =
the
> > grandfather of Ruby), and I do know very well what's idiomatic in Rub=
y.
> >
> > In perl you can do $ENV{'USER'}, and:
> >
> >   while (my ($k, $v) =3D each %ENV) {
> >     print "$k =3D $v\n";
> >   }
> >
> > Obviously it's idiomatic to use hashes this way [1].
> =

> For what it's worth idiomatic/good idea and "has an example in the perl=

> documentation" unfortunately aren't always aligned. A lot of experience=
d
> Perl programmers avoid each() like the plague:
> http://blogs.perl.org/users/rurban/2014/04/do-not-use-each.html

Perl is an old language, and each() was introduced in 2010, it's
expected that some old-timers would not adapt to the new idioms.

BTW, Ruby borrowed a lot from Perl, but I'm pretty sure Perl borrowed
each() from Ruby.

Untilmately it doesn't matter what you use to traverse %ENV, my point is
that it's a hash.

> > It was a waste for Git::config_regexp to not do the sensible thing he=
re.
> =

> FWIW we're commenting on a v2 of a series that's at v5 now, and doesn't=

> use config_regexp() at all, the relevant code is inlined in
> git-send-email.perl now.

I know, I've been following the threads. I'm trying to say it's a shame
Git::config_regexp does not do the sensible thing.

> > You can do exactly the same in Ruby: ENV['USER']
> >
> >   ENV.each { |k, v| print "#{k} =3D #{v}\n" }
> >
> > And the way I would parse these configurations in Ruby is something l=
ike:
> =

> >   c =3D `git config -l -z`.split("\0").map { |e| e.split("\n") }.to_h=

> >   c['sendemail.smtpserver']
> >
> > And this just gave me an idea...
> =

> I'd probably do it that way in Ruby, but not in Perl.
> =

> Things that superficially look the same in two languages can have
> completely different behaviors, a "hash" isn't a single type of data
> structure in these programming languages.
> =

> In particular Ruby doesn't have hshes in the Perl sense of the word, it=

> has an ordered key-value pair structure (IIRC under the hood they're
> hashes + a double linked list).
> =

> Thus you can use it for things like parsing a key=3D>value text file wh=
ere
> the key is unique and the order is important.
> =

> In Perl hashes are only meant for key-value lookup, they are not
> ordered, and are actually actively randomly ordered for security
> reasons. In any modern version inserting a new key will have an avalanc=
e
> effect of completely changing the order. It's not even stable across
> invocations:
>     =

>     $ perl -wE 'my %h; for ("a".."z") { $h{$_} =3D $_; say keys %h }'
>     a
>     ab
>     bca
>     dcba
>     daebc
>     cbaedf
>     aecbfdg
>     dgfcbaeh
>     [...]

This used to be the case in Ruby too. The order of hashes was not
guaranteed.

The situation is more complicated because not only do you have different
versions, but you have different implementations. AFAIK the Ruby
language specification doesn't say anything about ordering, although
basically all implementations do order.

> The other important distinction (but I'm not so sure about Ruby here) i=
s
> that Perl doesn't have any way to pass a hash or any other structure to=

> another function, everything is flattened and pushed onto the stack.
> =

> To pass a "hash" you're not passing the hash, but a "flattened" pointer=

> to it on the stack.
> =

> Thus passing and making use of these flattened values is idiomatic in
> Perl in a way that doesn't exist in a lot of other languages. In some
> other languages a function has to choose whether it's returning an arra=
y
> or a hash, in Perl you can just push the "flattened" items that make up=

> the array on the stack, and have the caller decide if they're pushing
> those stack items into an array, or to a hash if they expect it to be
> meaningful as key-value pairs.

Yeah, that's something that wasn't borrowed. In Ruby everything is an
object.

> In the context of Git's config format doing that is the perfect fit for=

> config values, our config values *are* ordered, but they are also
> sort-of hashes, but whether it's "all values" or "last value wins" (or
> anything else, that's just the common ones) depends on the key/user.
> =

> So by having a list of key-value pairs on the stack you can choose to
> put it into an array if you don't want to lose information, or put it
> into a hash if all you care about is "last key wins", or "I'm going to
> check for key existence".
> =

> I think that in many other languages that wouldn't make any sense, and
> you'd always return a structure like:
> =

>     [
>          key =3D> [zero or more values],
>         [...]
>     ]
> =

> Or whatever, the caller can also unambiguously interpret those, but
> unlike Perl you'd need to write something to explicitly iterate the
> returned value (or a helper) to get it into a hash or a "flattened"
> array. In Perl it's trivial due to the "everything is on the stack"
> semantics.

Indeed, but my point is that it's a hash for all intents and purposes:

  my %hash =3D func();

And it makes sense for it to be a hash, just like %ENV.

And although the internals are different something very close would
happen in Ruby:

  hash =3D func().to_h

> Anyway, all that being said the part we're talking about as a trivial
> part of this larger series. I'd much prefer to have it just land as
> "good enough" at this point. It works, we can always tweak it further
> later if there's a need to do that.

Indeed, as I said, the entire patch series looks good to me.

Cheers.

-- =

Felipe Contreras=
