Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CDBC433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 12:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3FA619BC
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 12:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhC3M5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 08:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhC3M4j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 08:56:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDCAC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 05:56:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jy13so24712588ejc.2
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 05:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zsz0K7pYeQy+0Cb3rd3QFHqQtZICW7WoX1BZNyTVHp4=;
        b=WAi/jZgzgsM36OlkXNHRzxbXr4iTgOqYKw882Q0DVhJHKqM7r5qBe3OB7B0PtGEy13
         S1uwvdc0FBsfAKUiarC4Mpp+cuVIdlW7G0rKAdMPVUQiqTHZmICLBISka41+hC8zrs4d
         QSZCunRSumFseswhZYQ1dsy1PS4WqMbkP/E4Yg++qGeckVzHRyzQkWhG5L+BeiK63AwZ
         KxPxy6WrfYP9eoXKy7l86Q7FckDhgdelG25gYjn1M7TSUESdmvZxS7NfkvFoBsehJTwG
         2fRx1a40Yubnmsfe3ediVOWPhxJhq/2RXlc9ZU2QNx5AY5gKvbOESWbSdPAuGChgXgoV
         rhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=zsz0K7pYeQy+0Cb3rd3QFHqQtZICW7WoX1BZNyTVHp4=;
        b=GJYGP50vFpXhLyJj1SYIL/WLxsg4c9hLIbSh7C4aZ5duC/tl3LrxFsXdnL7MFIc3KF
         ANl5DaBsGEhmrwgh87f+84ZLe2gl9tECTPw9HQx03iqE3X5lOrPIjlH8hF73JTZUMU/V
         wGr4bNUTcFN/3MaO0LNjkHObzLkw4024fv8WAZUPKqvwKcdMKGGx2lLYxRyBOEohvQV0
         4C4+WGbdGAQhc64uufwxaDRDHEEGIHJNn3kCxSPN2MFMIh4yDujQR15QRCbZJWh4PIiB
         edgyR2Rjae5ewlYz6hQxEr1RKa5apiESik4lPVnp4Mr2nqjy2QZ/k30souc4LPt8Q2AH
         J8TA==
X-Gm-Message-State: AOAM532GQUb4fW5t4aknkeqjXDG2Q2aNQaRxIYxvU86i6sJWN1owuzfL
        UGj1tyTYXtazxlddsWkHG+U=
X-Google-Smtp-Source: ABdhPJwu4IrjCynoBLxHDcPVjwGLtTPcuqA/EC+K7NGXVOHQngs1SHiHZPvNdNWUnbIb2AnRny0NTA==
X-Received: by 2002:a17:906:1985:: with SMTP id g5mr32774369ejd.285.1617108997610;
        Tue, 30 Mar 2021 05:56:37 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t6sm10879700edq.48.2021.03.30.05.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 05:56:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <xmqq5z1cqki7.fsf@gitster.g> <xmqq1rc0qjn1.fsf@gitster.g>
 <87blb4nf2n.fsf@evledraar.gmail.com>
 <578FC14B-CB72-41CA-A8FD-1480EBCCB968@gmail.com>
 <62695830-2f9e-c3b5-856c-01b97eb2c3af@gmail.com>
 <59DFC82F-A3EA-4637-94AE-4042697448FF@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <59DFC82F-A3EA-4637-94AE-4042697448FF@gmail.com>
Date:   Tue, 30 Mar 2021 14:56:36 +0200
Message-ID: <874kgsn6kb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 30 2021, Atharva Raykar wrote:

> On 29-Mar-2021, at 15:38, Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 28/03/2021 13:40, Atharva Raykar wrote:
>>> On 28-Mar-2021, at 08:46, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
>>>> The "define-?.*" can be simplified to just "define.*", but looking at
>>>> the tests is that the intent? From the tests it looks like "define[- ]"
>>>> is what the author wants, unless this is meant to also match
>>>> "(definements".
>>> Yes, you captured my intent correctly. Will fix it.
>>>> Has this been tested on some real-world scheme code? E.g. I have guile
>>>> installed locally, and it has really large top-level eval-when
>>>> blocks. These rules would jump over those to whatever the function abo=
ve
>>>> them is.
>>> I do not have a large scheme codebase on my own, I usually use Racket,
>>> which is a much larger language with many more forms. Other Schemes like
>>> Guile also extend the language a lot, like in your example, eval-when is
>>> an extension provided by Guile (and Chicken and Chez), but not a part of
>>> the R6RS document when I searched its index.
>>> So the 'define' forms are the only one that I know would reliably be pr=
esent
>>> across all schemes. But one can also make a case where some of these no=
n-standard
>>> forms may be common enough that they are worth adding in. In that case =
which
>>> forms to include? Should we consider everything in the SRFI's[1]? Shoul=
d the
>>> various module definitions of Racket be included? It's a little tricky =
to know
>>> where to stop.
>>=20
>> If there are some common forms such as eval-when then it would be good t=
o include them, otherwise we end up needing a different rule for each schem=
e implementation as they all seem to tweak something. Gerbil uses 'def...' =
e.g def, defsyntax, defstruct, defrules rather than define, define-syntax, =
define-record etc. I'm not user if we want to accommodate that or not.
>
> Yes, this is the part that is hard for me to figure out. I am going by
> two heuristics: what Scheme communities in other places would generally
> prefer, and what patterns I see happen more often in scheme code.
>
> The former is tricky to do. I posted to a few mailing lists about this,
> but they don't seem active enough to garner any responses.
>
> The latter is a little easier to measure quickly. I did a GitHub search,
> where I filtered results to only consider Scheme files (language:scheme).
>
> Some armchair stats, just for a broad understanding:
>
>   Total number of scheme files: 529,339
>   No. of times a construct is used in those files:
>     define and its variants : 431,090 (81.4%)
>     def and its variants    :  18,466 ( 3.5%)
>     eval-when               :   3,375 ( 0.6%)
>
> There was no way for me to quickly know which of these uses are at the top
> level, but either way of the more structural forms that do show up in Sch=
eme
> code, define and its variants seem like a clear winner. I am not sure if
> it's worth adding more rules to check for def and its variants, given that
> they are not nearly as common.

In those cases we should veer on the side of inclusion. The only problem
we'll have is if "eval-when" is a "setq"-like function top-level form in
some other scheme dialect, so we'll have a conflict.

Otherwise it's fine, programs that only use "define" won't be bothered
by an eval-when rule.
