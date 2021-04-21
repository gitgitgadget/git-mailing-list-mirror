Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AC3C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A946144E
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243440AbhDUOS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 10:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbhDUOSw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 10:18:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E00C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:18:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u17so63804013ejk.2
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hbx78ArOS8mBJ56vlS6F2/22FK35yVT/scPH0aPqwUM=;
        b=g3pIV3TLam9hgx9n6cxFJUfVzQ8oaEdMK8F5alAUbBlPQo3TAER2a6l29lsI6zBa2g
         RetmtwuMOUJcg6QOG4vkGCzJcy4BCezlSjxOMT0Zf5GcdeSkAu1MWey5uX0xTLc40eG6
         0VjNsra4T2wjxdagzqNSlWYTyvFAARpU5jYn+8swEWyHu7PJyF+WSh7ZiTXooRsiULb8
         EZ5qGHTY5VSe/HxkPDm7uhuZsziKqeXwxxredk+rl7g7N7w+1h1GdRmsa8puln7WrMHn
         Wso4Q6hP+9N3B2KvT6LdEgvfeq2Kc5lj+1kGM9eU52cicdbneZlm4Ux3HPsaOMppfELC
         Cqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=hbx78ArOS8mBJ56vlS6F2/22FK35yVT/scPH0aPqwUM=;
        b=mVXuYXBc6FUqkfhI7yv3RY63MdahE3ray7Ht0b4NjB1CB56+RUhLnWDf2g9pwShf9l
         8gZK1nKKOStSAVbZ+HGOpfA/ei/zUC4GbYSx+1ZfuehVDLJggcOraK8i+fAQToJoNZuL
         dlv8MI9I3Jo0ddtYWi0ccLXa/eyrlFGqBXwWp7rBtct3hoeW/jXM9U5JFAeb17ZiRgUg
         maL+Fce2u6ZrhQvmjpyS87Io/qntu8mBqskTyRpng3NqKqjOjNzTIJtu079qLwLdu2Bf
         kqT7EcHmEKIq5hq1f1gfqbLVTEg5Y9TmZ+1mm6m7CzRWs0egOMycBZW+ckyZuCY7J0cQ
         n/iA==
X-Gm-Message-State: AOAM533fjxmqLL3KNd2A+KMzZYMJprQ/TL4bVVo/pZYoWOx50J2USzKa
        HjnHE9VgolCESd5qGwI8gndCaSIcmahpVw==
X-Google-Smtp-Source: ABdhPJxF+0aqTkY7BVQvRNaGJhP88AN/FQgbXRE2bKACw1cMfg1/6dc+uoN9SW6z5sdANejLGh8TPw==
X-Received: by 2002:a17:906:2746:: with SMTP id a6mr18619326ejd.265.1619014694216;
        Wed, 21 Apr 2021 07:18:14 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g11sm3567199edt.35.2021.04.21.07.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 07:18:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 01/12] check-non-portable-shell: check for "test
 <cond> -a/-o <cond>"
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
 <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
 <patch-01.12-a8b483bc77-20210420T121833Z-avarab@gmail.com>
 <xmqqwnsw3872.fsf@gitster.g> <87r1j42ffz.fsf@evledraar.gmail.com>
 <YIAAzJTG1UitiWyu@danh.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YIAAzJTG1UitiWyu@danh.dev>
Date:   Wed, 21 Apr 2021 16:18:11 +0200
Message-ID: <87czun3en0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 21 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2021-04-21 10:46:08+0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>>=20
>> On Wed, Apr 21 2021, Junio C Hamano wrote:
>>=20
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>> >
>> >> These will only match the simplistic forms of `test -X blah` (where
>> >> "-X" is some single letter option), but will miss expressions such as
>> >> `test "$foo" =3D bar`. We stop at "&" or "|" to try not to overmatch
>> >> things like:
>> >>
>> >>     test whatever && ls -a foo
>> >>     test whatever && foo -o outfile
>> >
>> > I still do not understand why you have to insist on dashed operator
>> > as the first thing given to "test", like this:
>> >
>> >> +	/\btest\s+-[a-z]\s+[^&|]+\s+-a\s+/ and err '"test A && test B" ...
>> >> +	/\btest\s+-[a-z]\s+[^&|]+\s+-o\s+/ and err '"test A || test B" ...
>> >
>> > IOW, what over-matching would we get if we simplified the condition
>> > like so?
>> >
>> >     /\btest\s+[^&|]+\s+-a\s/
>> >     /\btest\s+[^&|]+\s+-o\s/
>> >
>> > The one in the patch would miss things like
>> >
>> > 	test "$a" =3D "$b" -o "$a" -lt "$b"
>> > 	test "$n" -a "$n" -lt 4
>> >
>> > but the only thing that we care about is that a command that started
>> > with "test " has "-a" or "-o" before we see "&" or "|", no?
>>=20
>> Applying your suggestion results in these false positives:
>>=20=09
>> 	t4038-diff-combined.sh:135: error: "test A && test B" preferred to "tes=
t A -a B": git commit -m "test space change" -a &&
>> 	t4038-diff-combined.sh:147: error: "test A && test B" preferred to "tes=
t A -a B": git commit -m "test other space changes" -a &&
>> 	t6400-merge-df.sh:89: error: "test A || test B" preferred to "test A -o=
 B": test 0 -eq $(git ls-files -o | wc -l)
>> 	t6400-merge-df.sh:91: error: "test A || test B" preferred to "test A -o=
 B": test 1 -eq $(git ls-files -o | wc -l)
>> 	t6400-merge-df.sh:110: error: "test A || test B" preferred to "test A -=
o B": test 0 -eq $(git ls-files -o | wc -l)
>> 	t6400-merge-df.sh:112: error: "test A || test B" preferred to "test A -=
o B": test 1 -eq $(git ls-files -o | wc -l)
>> 	t6402-merge-rename.sh:639: error: "test A || test B" preferred to "test=
 A -o B": test 0 -eq "$(git ls-files -o | wc -l)"
>> 	t6402-merge-rename.sh:646: error: "test A || test B" preferred to "test=
 A -o B": test 2 -eq "$(git ls-files -o | wc -l)"
>> 	t6402-merge-rename.sh:686: error: "test A || test B" preferred to "test=
 A -o B": test 0 -eq "$(git ls-files -o | wc -l)" &&
>> 	t6402-merge-rename.sh:865: error: "test A || test B" preferred to "test=
 A -o B": test 0 -eq $(git ls-files -o | wc -l) &&
>
> With: 7dbe8c8003, (check-non-portable-shell.pl: `wc -l` may have
> leading WS, 2017-12-21)
> Unless the situation has been changed, since.
> I think those tests with quoted "$(.. | wc -l)" has been deemed
> unportable and should be replaced with test_line_count anyway?
> Does "test -eq" strip spaces from integer strings?
>
> And I think we're working on moving "git" command to its own commmand
> instead of put it in the left of a pipe.
>
> 2 followed patch will clean them out

I think those patches are good in their own right, i.e. replacing things
with more incremental helpers and test_cmp-like functions.

But I believe the code you're changing is not non-portable. It was using
the output of "wc -l" with the "=3D" operator that wasn't portable.

These ones are all occurances that use "-eq".

And:

    test "0" -eq " 0"

etc., is true, which is why these pass on OSX and beyond.

