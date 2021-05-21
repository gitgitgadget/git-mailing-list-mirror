Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655CFC43460
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C8D613C4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbhEUJ1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 05:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhEUJ1E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 05:27:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C69C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 02:24:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so29427048ejc.10
        for <git@vger.kernel.org>; Fri, 21 May 2021 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xZyNZYH5WKo8nCV64Z6/zIQ6P7MRr07Stlu0JchHxog=;
        b=sqUCzNAGbU5kHc1rMaMy3zXYZDsHJm715ji54LyHeLG0z+z6b154NyWJeFl66dpOWR
         Hg8JxRacxFeKWdeZNyhZal0d1lMRViMnbL5Htser1mMBg9GD2S3JF0NZWR7SsC0TD3TG
         H7JjzjsMByM5ULZz3J9W1QemnETCRGIMTfCh/MQIhMEJxkhstDpivaP8bVTt/AaJja7j
         cqZjLqcgs3+PABWtHUlknS21KdhVv9DaLkyKdCGECgppSmew5jBG9Hz7ExRThvq+TJz4
         cmLG1LemXHlKxhtCPde6oPnRRce5lNYq81UMJi5TO2094Nzfl5q6D7R1yskzGqmt+J5X
         Ebvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xZyNZYH5WKo8nCV64Z6/zIQ6P7MRr07Stlu0JchHxog=;
        b=PwhypsDCX5sPyEOiCBhGdWbdUroP28WhDGVbKCtHAS3e9Pr67tjNYBKYZ9mFqi0FHB
         +nSvCHqGVOPB0lJsBzXXcrqLCKNEJwTFkcJIJ6LJLERPZaePGQvtODEzj+Vg5Zn4qsGY
         Ifczp82PgQQZW0+XapZxSwXIyQKHi4y8sOIU/FAx6wigeM2JlePysuYgO+nvMe/GSrYD
         T6BpPe9gFKvABnpTXwNZ/5+H97eqylYBMQ6fT8ilu0vPed1JoTs/R0jWqNsXiGwQPJ4b
         POpv8uwDV9naoyBC4dCJq7B4EERYuyLY7Kp4YPVHWuz27irz/04OGvlioYwEXgvCDlW9
         Hbhw==
X-Gm-Message-State: AOAM531LAEABrcDAin6benvQ/sJiqBNcUZl8wDaZqSJraZLFYK8Uxlm6
        R7IvZD7/NLVLYV4D4YfqASw=
X-Google-Smtp-Source: ABdhPJybxKir4SQgZisi7T1ZJ3uGqRTypd+mWJdrlvylnnMjen6rTkiMVIHIju+Sx/xVN2JTjm5OxQ==
X-Received: by 2002:a17:906:8a53:: with SMTP id gx19mr9276432ejc.372.1621589091252;
        Fri, 21 May 2021 02:24:51 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id i5sm3125377ejv.120.2021.05.21.02.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 02:24:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 00/10] send-email: various optimizations to speed up
 by >2x
Date:   Fri, 21 May 2021 11:24:00 +0200
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
 <YKYdeom6SgAHqojm@coredump.intra.peff.net> <xmqqv97drmge.fsf@gitster.g>
 <875yzcpo52.fsf@evledraar.gmail.com>
 <YKd5xSw1bZbQXaAe@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YKd5xSw1bZbQXaAe@coredump.intra.peff.net>
Message-ID: <8735ugphge.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 21 2021, Jeff King wrote:

> On Fri, May 21, 2021 at 08:23:15AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> The "performant" really doesn't matter here, we're comparing shelling
>> out to getting a small number of config keys back. So I wasn't trying to
>> optimize this.
>>=20
>> Returning a flattened list is idiomatic in Perl, it means that a caller
>> can do any of:
>>=20
>>     # I only care about the last value for a key, or only about
>>     # existence checks
>>     my %hash =3D func();
>>=20
>> Or:
>>=20
>>     # I want all key-values to iterate over
>>     my @kv =3D func();
>>=20
>> Returning touples like this makes that less convenient for both, who'll
>> need to do more work to unpack them.
>>=20
>> For what it's worth In Perl "return a list" means "flattened list", the
>> term "flattened list" I think comes from other languages. You'd call
>> what you're suggesting a list of arrays, or (if a top-level reference)
>> an array of arrays, AoA for short, AoH for array (ref) of hashes etc.
>
> Yeah, I think that is reasonable. But it made me wonder how we handle
> value-less booleans, and I think there's indeed a bug.
>
> Try a config like this:
>
>   $ cat >foo <<\EOF
>   [foo]
>   key-with-value =3D string
>   key-with-empty =3D
>   just-bool
>   another-key-with-value =3D another
>   EOF
>
> A regular config --list looks like:
>
>   $ git config --file=3Dfoo --list
>   foo.key-with-value=3Dstring
>   foo.key-with-empty=3D
>   foo.just-bool
>   foo.another-key-with-value=3Danother
>
> Note how "just-bool" drops the "=3D" to distinguish it from the empty
> string. With "-z", it looks like this:
>
>   $ git config --file=3Dfoo --list -z
>   foo.key-with-value
>   string^@foo.key-with-empty
>   ^@foo.just-bool^@foo.another-key-with-value
>   another^@
>
> The NULs separate keys, but keys are separated from their values by a
> newline. And again, just-bool omits the newline.
>
> Your parser splits on newline, so for that entry we'll get only one
> string returned in the list (the key), rather than two (the key and
> value). In a flattened list, that becomes ambiguous. E.g., adapting your
> parser into a stand-alone script:
>
>   $ git config --file=3Dfoo --list -z |
>     perl -e '
>       local $/;
>       my $data =3D <STDIN>;
>       my (@kv) =3D map { split /\n/, $_, 2 } split /\0/, $data;
>
>       while (@kv) {
>         my $k =3D shift @kv;
> 	print "key: $k\n";
> 	my $v =3D shift @kv;
> 	print "  value: ", (defined $v ? $v : "undef"), "\n";
>       }
>     '
>   key: foo.key-with-value
>     value: string
>   key: foo.key-with-empty
>     value:=20
>   key: foo.just-bool
>     value: foo.another-key-with-value
>   key: another
>     value: undef
>
> We end up misinterpreting a key as a value, and vice versa.
>
> Using a non-flattened structure would have prevented this (we'd sensibly
> get undef when trying to access the missing second element of the
> array). But I do agree the flattened structure is more perl-ish.
> Probably you'd want to insert an explicit "undef" into the list. The
> most perl-ish I could come up with is:
>
>   my (@kv) =3D map { my ($k, $v) =3D split /\n/, $_, 2;
>                    ($k, $v)
>                  } split /\0/, $data;
>
> I notice that $known_keys then becomes a non-flat representation. You'd
> either want to turn that back into a zero-length array there, or store
> the "undef" and handle it appropriately (it can be a synonym for "true",
> though that is just an optimization at this point).
>
> -Peff

Ah yes, that's indeed a bug. I'd forgetten about the empty value case.

For what it's worth you can slightly golf that as (split /\n/, $_,
2)[0,1], but I think in this case your version is better than that, it's
more obvious what we're trying to do in always returning the $v.
