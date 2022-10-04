Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE10DC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 07:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJDH7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 03:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJDH7n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 03:59:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2370562F9
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 00:59:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a13so17776539edj.0
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=BorzNDTu4wBucJiCANkg9jJmpDKL7VVOPBH3W5j6Psw=;
        b=hmzcXZDyRrpqhuaz9aWo25CTv4/UfB0Zq0x3DRQGx22RVNjzLPlyFabOrgy7dup1Nz
         6QahF3X3u4E2aMwAiu8ymCW8EqbqgkJBEQ6RJF8aIaOQkSMuM5cuGbxoam12RnN7F9CB
         V0qLTB5/86H3TgB/gvsaV3FfkeOExE6V/XCdM4Gy+zcipCSwC5BxM8Mjx9jq5VaADR0b
         4iUI4utV/AbDUyky8xz4dPyWBIaNB6gHxIgKNciuV44jFVVuATm2H6+S8tZvpwOzpOBr
         x9FHBeuTXfYHxTaGGzWBnjMcPa/5laRkOXv34z3/8F7qz9cn6WP2x63JkLQPisU4MxlA
         p7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=BorzNDTu4wBucJiCANkg9jJmpDKL7VVOPBH3W5j6Psw=;
        b=kDcwMk/h7alL9YlJJLWYx4cQfiYHGQeDTa1WUp5T9/6pS68UYdw+FHFGI+HwkjgxpR
         SGLRpp9eHEku3QQ+i2eoqimQL1fXXe08gPBoXdfpVheuvkhqchwJ3qeQJ5c4EiLSR3q6
         3Con4ViUJsWotFx0AQBculBTQKAPmkCqI4xdV4A9zZNCkOVyMptOm+PQWXZYI9X/+9RQ
         hVYoaJTktGRpjSDu1GDdf3TEKkXF0GqlMlcJotplv5arvLMwdRZBFQLz2F2f7gnfv10l
         8wbyJVL0Zd/9+CBZzKN/J1Ewb+/vQJlCkpKSUK2fMhzOwFh5HvSLRxcfDhtraMhkER3g
         D7gQ==
X-Gm-Message-State: ACrzQf3kI/5JptECHbH+pIH2pyQcCqLRVOuxCrpGjbWMmGPxwdDLWRBM
        6BvSeDOiDWrFa7OfOw12OVM=
X-Google-Smtp-Source: AMsMyM43eTUhOqzLEd9MTikqnuj0j4eOMsnIPxF2Rg2yLvl7jI2Wjh63bZHsNGP0dv1imR07XOtvxw==
X-Received: by 2002:a05:6402:1393:b0:457:ea9e:ba20 with SMTP id b19-20020a056402139300b00457ea9eba20mr22543232edv.109.1664870380477;
        Tue, 04 Oct 2022 00:59:40 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r10-20020a1709061baa00b00782539a02absm6583532ejg.194.2022.10.04.00.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 00:59:39 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ofcq2-0026dk-0B;
        Tue, 04 Oct 2022 09:59:38 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 22/36] doc txt & -h consistency: make "rerere"
 consistent
Date:   Tue, 04 Oct 2022 09:50:48 +0200
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
 <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
 <patch-v3-22.36-702eb747c0f-20220930T180415Z-avarab@gmail.com>
 <xmqqmtaf2xig.fsf@gitster.g> <221003.86sfk5tgrs.gmgdl@evledraar.gmail.com>
 <xmqqczb8yk8h.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqczb8yk8h.fsf@gitster.g>
Message-ID: <221004.86fsg4t3x2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 03 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Sat, Oct 01 2022, Junio C Hamano wrote:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>>
>>>> For "rerere" say "pathspec" consistently, and list the subcommands in
>>>> the order that they're discussed in the "COMMANDS" section of the
>>>> documentation.
>>>
>>> pathspec refers to the entire set of patterns, which consists of one
>>> or more "pathspec element"s, so there is no need for "..." there.
>>
>> Maybe I'm misreading this, but are you suggesting that whenever
>> "<pathspec>" appears in the text the user should understand it as
>> "<pathspec>...", i.e. as is the case with the special-case that is
>> "<options>".
>
> Not really.  A <pathspec> is a set of <pathspec element>s, so
> writing "<pathspec-element>..." and "<pathspec>" are equivalent.

So, "yes"? I.e. leaving aside "pathspec" or "pathspec-element"
"<pathspecs>" is redundant to "<pathspecs>..." in this intpreretation?
But for any given "<x>" the "<x>" is not the same as "<x>..."?

>> I'm not opposet do that, but I really wish we could avoid further
>> special-cases, there's no current user of "<pathspecs>" (with an "s" for
>> plural.
>
> Presumably just like range-diff compares two ranges (which in the
> normal command line syntax we would not have), some future commands
> may need to take two pathspecs (that is two sets of patterns to
> match paths) to do something interesting, but I do not think of
> anything that does so in the current command set, so it is very good
> that nobody claims to take <pathspecs> with an "s"for plural.
>
>> 	Documentation/git-clone.txt:--recurse-submodules[=3D<pathspec>]::
>>
>> Should be read as supporting:
>>
>> 	--recurse-submodules some/path some-other-path
>
> Yup, the option should support it, alternatively it could take
> <path>.  Or it could take multiple of these options in which case
> each of them is taking a pathspec element.

In bourne shell syntax we're talking about the distinction between:

	$ echo --opt {a,b}
	--opt a b

And:

	$ echo --opt=3D{a,b}
	--opt=3Da --opt=3Db

Which in the SYNOPSIS syntax are (asuming "a", and "b" are <byte>), respect=
ively:

	--opt <byte>...

And:

	[--opt <byte>]...

If we maintain that for a given "<label>" that it has an implicit "..."
after it I don't see how you can distingish these two by way of
explaining how the command works via the syntax. I.e. it's possible (and
we even have some obscure code in-tree that does this) to support e.g.:

	--opt a b c --opt d e f g h --opt i --opt j

Which, if (in my wordview) would be explained with this syntax:

	[--opt <byte>...]...

But that's really not what we mean most of the time, we *don't* want
that "..." on the argument to "--opt", because it only takes one
argument.
