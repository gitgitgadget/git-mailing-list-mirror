Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E82CCCA481
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 03:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbiFHDgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 23:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiFHDfN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 23:35:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D58222AE48
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 14:32:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n10so37778610ejk.5
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7hCbTDPpzeq36YuCfI3MbGVPwiYPka4G5/58yWphV4s=;
        b=p59KDT1OryBcYbgLjtZ/EGrU0TSdzlmgalSinPNgr+YCHz7Bf2+cASE6QLuNHGA4C/
         E2quQhEX21M2Z6jNalFe0INjesXKqsg0v3wtU7SU2uooKYCcSF/cL3lF++iUnI96VXf4
         SYH9ZIZo8NkcywN0OzFVkPB36mYZ5x0RoYR6rlayyu5C+YCGNZ0NqEw2cJnLew6Vh3dS
         rPqjBAHBlyoA3kVaSlI2Z55ebLLrs7TAwY6ETTDf6oDJv/mQndCXu0twkOoVzFs2sTyZ
         5Uj1xcYc5CFvX/iQDLJPTvOq6LgDC85htqqnVsRt+q889rRZBLeoiJ3FJK2jU1PynIdE
         Le1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=7hCbTDPpzeq36YuCfI3MbGVPwiYPka4G5/58yWphV4s=;
        b=wAzg/Ef0lbk9nn/3SyiItjwF8WrRCTJ69Kfk9Zmw62D+L2wDzHZKKWMylpK5mHKaah
         acqM46llkg+Hd/jtEqvpgc9UN7yVIAfoDhTMwnZEDF9OIt8zwNgrfKfzgiEulhwlSrk/
         EWAoOxW6l7G1w+2kde9PzQeicDV7xLqcnoOxi2WVlEyGJ70wEnSsUt38Sa5PVGI90FCO
         63PDNUbgDPm9XjaKj9RUo4Q8UJ9QyJMvi3PWCz8eCUWlExHIhs54PBh0nU6ThI9B6QL5
         /A4tI7Uo6qlLOuansl5lRbBXmbq+PnrcmdlqnKITz4zMiFdiKO4RQiljkrSy8Zg7+eAl
         qOmQ==
X-Gm-Message-State: AOAM532xiokqC0YZwL6JYJTQq8o1jK0zAu7B2UryX9DniNhVihSpkAn5
        EtuTqFJIWQxgPrrGGU+IlAs=
X-Google-Smtp-Source: ABdhPJw5uLPfVa4SwOQ026ba7mNms51DjpAiH162JE0e6XOH0xeKjcj80U6S9TzRy156IcS4I0z6bg==
X-Received: by 2002:a17:907:7b95:b0:6f4:ff03:981a with SMTP id ne21-20020a1709077b9500b006f4ff03981amr28807093ejc.653.1654637525196;
        Tue, 07 Jun 2022 14:32:05 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g15-20020aa7dc4f000000b0042defe37a42sm10807443edu.16.2022.06.07.14.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 14:32:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nygnz-002fft-Pb;
        Tue, 07 Jun 2022 23:32:03 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com
Subject: Re: [PATCH 2/2] builtin/show-ref.c: limit output with `--count`
Date:   Tue, 07 Jun 2022 23:31:28 +0200
References: <cover.1654552560.git.me@ttaylorr.com>
 <3fcf1f555715e925385d37712ffe880bb869741e.1654552560.git.me@ttaylorr.com>
 <220607.86r140vqc4.gmgdl@evledraar.gmail.com>
 <Yp+/eXNg4tjiCn5a@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yp+/eXNg4tjiCn5a@nand.local>
Message-ID: <220607.86y1y8tb1o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 07 2022, Taylor Blau wrote:

> On Tue, Jun 07, 2022 at 10:07:32AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Mon, Jun 06 2022, Taylor Blau wrote:
>>
>> > diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-r=
ef.txt
>> > index ab4d271925..28256c04dd 100644
>> > --- a/Documentation/git-show-ref.txt
>> > +++ b/Documentation/git-show-ref.txt
>> > @@ -10,7 +10,7 @@ SYNOPSIS
>> >  [verse]
>> >  'git show-ref' [-q|--quiet] [--verify] [--head] [-d|--dereference]
>> >  	     [-s|--hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]
>> > -	     [--heads] [--] [<pattern>...]
>> > +	     [--heads] [--count=3D<n>] [--] [<pattern>...]
>>
>> In addition to what Junio noted, the SYNOPSIS is now inaccurate per your
>> documentation. I.e. if this option is incompatible with --verify and
>> --exclude-existing we should use "|" to indicate that, e.g.:
>>
>> 	[ [--verify] [--exclude-existing] | --count=3D<n> ]
>
> Good catch. Should this be squashed into the first example in the
> SYNOPSIS, the second, or a new one?

Personally I really don't care if the end-state is good :)

>> > +	if (max_count) {
>> > +		int compatible =3D 0;
>> > +
>> > +		if (max_count < 0)
>> > +			error(_("invalid --count argument: (`%d' < 0)"),
>> > +			      max_count);
>> > +		else if (verify)
>> > +			error(_("--count is incompatible with %s"), "--verify");
>> > +		else if (exclude_arg)
>> > +			error(_("--count is incompatible with %s"),
>> > +			      "--exclude-existing");
>> > +		else
>> > +			compatible =3D 1;
>> > +
>> > +		if (!compatible)
>> > +			usage_with_options(show_ref_usage, show_ref_options);
>>
>> Instead of this "int compatible" and if/else-if" just use usage_msg_optf=
().
>>
>> That or die_for_incompatible_opt4(), at least the new _() messages
>> should make use of the same translations. I.e. we recently made these
>> parameterized.
>
> Good catch again. I wasn't aware of usage_msg_optf(), but it's exactly
> what I'm looking for here. It does mean that we'd only print one warning
> at a time, but I think that's a fair tradeoff, and unlikely to matter in
> practice anyways.

Yeah, I think that should be OK. We do that in other cases.

> And I must have dropped the parameterized msgids on the floor when
> preparing this patch, since I definitely have it locally. Oops, fixed.

*nod*

>> > +	}
>> > +
>> >  	if (exclude_arg)
>> >  		return exclude_existing(exclude_existing_arg);
>> >
>> > diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
>> > index 9252a581ab..b79e114c1e 100755
>> > --- a/t/t1403-show-ref.sh
>> > +++ b/t/t1403-show-ref.sh
>> > @@ -196,4 +196,25 @@ test_expect_success 'show-ref --verify with dangl=
ing ref' '
>> >  	)
>> >  '
>> >
>> > +test_expect_success 'show-ref --count limits relevant output' '
>> > +	git show-ref --heads --count=3D1 >out &&
>> > +	test_line_count =3D 1 out
>> > +'
>> > +
>> > +test_expect_success 'show-ref --count rejects invalid input' '
>> > +	test_must_fail git show-ref --count=3D-1 2>err &&
>> > +	grep "invalid ..count argument: (.-1. < 0)" err
>>
>> The use of .. here seems odd...
>>
>> > +'
>> > +
>> > +test_expect_success 'show-ref --count incompatible with --verify' '
>> > +	test_must_fail git show-ref --count=3D1 --verify HEAD 2>err &&
>> > +	grep "..count is incompatible with ..verify" err
>>
>> ...i.e. this looks like a way to avoid "--" at the beginning, but then
>> why use it in the middle of the regex?
>
> Muscle memory ;).
>
>> > +test_expect_success 'show-ref --count incompatible with --exclude-exi=
sting' '
>> > +	echo "refs/heads/main" >in &&
>> > +	test_must_fail git show-ref --count=3D1 --exclude-existing <in 2>err=
 &&
>> > +	grep "..count is incompatible with ..exclude.existing" err
>>
>> Seems like you could avoid it entirely by escaping it, e.g. "[-]-" at
>> the beginning, or in this case I think "test_expect_code 129" would be
>> more than sufficient, we use that to test "had usage spewed at us"
>> elsewhere.
>
> I like having the extra test to ensure the error we got made sense, but
> I agree either would work. I modified the grep expressions to replace
> leading "."'s with "[-]", and "."'s in the middle of the expression with
> "-".

Yeah, fair enough, thanks!
