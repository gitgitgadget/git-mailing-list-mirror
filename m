Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B06DC433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0FB061929
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhC3NsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbhC3NsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:48:09 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC43C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:48:08 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bt4so7768924pjb.5
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LPnyDns0COHnuxZTaT+6wvZvDmVMobic/NSw7rTPh08=;
        b=lJwHl3PzgE5TQDcS3gNg8q0mKZv9akbzsb29vsxiFOrUUpaTMl67GVjNvsXdlNK7p6
         bgnJrYzQrT1I68haPlYNw+AOCPOMazdgZ+CQWe9WwbnBUcVvrXEDAc+og5rYKAaA6hAT
         k44jeJyPqp1MRp1aj/pCRe9Z8ujayIvvVzCU7SY0Term7Vq9Doa9WnIYZADSe38aYOwV
         1kizDY3PWLrAJZeClouWmgFfnlbVYhuUK9dE44RrZXpjnd4M8dOixEW4w5yZ/OQTUOSi
         QC4sgC/2inR4KvV+RfUy+uqsz2nyrpABIWnjjuzjo5XA+HMo8p/6usxF06CKxS3eaBaI
         tS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LPnyDns0COHnuxZTaT+6wvZvDmVMobic/NSw7rTPh08=;
        b=OZuLHJXlASrOldpZgU0GUQbJadrU3y+691mca2nzqBx1jJLs4aAOcvcXGRbV56huEQ
         yqkw69+K//FUHfU2Znh3W1CH8cDIJDV4oar+iDnaphnPIp7+S3IBlUS7RKVjUfCUeh3s
         yEzNFJSUbd5as4Tv9MepZEqDy5AeiWfLgWZiZl+0q5k60LTqOBRFWhA3bMWuBeLgtjZ6
         t/Exk8QAKvGYo4E3KcpryWe+4HOgo7aE251Qy/ptstC1L/zOBxqQs6yqDTkjD10Nt8Q/
         qgsaJPJu0Z0MvmN+qfkw3SqSg4km9DM9c7KPTMk+gy/pE69WqdsL9YgjFRNF1DE/8faD
         qAjg==
X-Gm-Message-State: AOAM530Q/pXT0mwCQ08PggEZ+zsXhbM6Ii+7NPSG9EHXTAKsFt0xQ6YB
        SkmqUIu5GfTX5/8ZKxdH/IXBIro7dFEVGraw
X-Google-Smtp-Source: ABdhPJyP+46Y6H9in4V9PO0r8fO16K4+cGzjLAq6yLQH/+zk6vz7GJu14xaQgk2ilOhWKVPxSP8JEQ==
X-Received: by 2002:a17:902:f54e:b029:e6:3d74:eb3 with SMTP id h14-20020a170902f54eb02900e63d740eb3mr33836146plf.14.1617112088209;
        Tue, 30 Mar 2021 06:48:08 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.20])
        by smtp.gmail.com with ESMTPSA id mr5sm2923493pjb.53.2021.03.30.06.48.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 06:48:07 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <874kgsn6kb.fsf@evledraar.gmail.com>
Date:   Tue, 30 Mar 2021 19:18:04 +0530
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <88DF47D5-F104-4677-A2E4-7B23FEFCF022@gmail.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <xmqq5z1cqki7.fsf@gitster.g> <xmqq1rc0qjn1.fsf@gitster.g>
 <87blb4nf2n.fsf@evledraar.gmail.com>
 <578FC14B-CB72-41CA-A8FD-1480EBCCB968@gmail.com>
 <62695830-2f9e-c3b5-856c-01b97eb2c3af@gmail.com>
 <59DFC82F-A3EA-4637-94AE-4042697448FF@gmail.com>
 <874kgsn6kb.fsf@evledraar.gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30-Mar-2021, at 18:26, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
>=20
> On Tue, Mar 30 2021, Atharva Raykar wrote:
>=20
>> On 29-Mar-2021, at 15:38, Phillip Wood <phillip.wood123@gmail.com> =
wrote:
>>> On 28/03/2021 13:40, Atharva Raykar wrote:
>>>> On 28-Mar-2021, at 08:46, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>>>>> The "define-?.*" can be simplified to just "define.*", but looking =
at
>>>>> the tests is that the intent? =46rom the tests it looks like =
"define[- ]"
>>>>> is what the author wants, unless this is meant to also match
>>>>> "(definements".
>>>> Yes, you captured my intent correctly. Will fix it.
>>>>> Has this been tested on some real-world scheme code? E.g. I have =
guile
>>>>> installed locally, and it has really large top-level eval-when
>>>>> blocks. These rules would jump over those to whatever the function =
above
>>>>> them is.
>>>> I do not have a large scheme codebase on my own, I usually use =
Racket,
>>>> which is a much larger language with many more forms. Other Schemes =
like
>>>> Guile also extend the language a lot, like in your example, =
eval-when is
>>>> an extension provided by Guile (and Chicken and Chez), but not a =
part of
>>>> the R6RS document when I searched its index.
>>>> So the 'define' forms are the only one that I know would reliably =
be present
>>>> across all schemes. But one can also make a case where some of =
these non-standard
>>>> forms may be common enough that they are worth adding in. In that =
case which
>>>> forms to include? Should we consider everything in the SRFI's[1]? =
Should the
>>>> various module definitions of Racket be included? It's a little =
tricky to know
>>>> where to stop.
>>>=20
>>> If there are some common forms such as eval-when then it would be =
good to include them, otherwise we end up needing a different rule for =
each scheme implementation as they all seem to tweak something. Gerbil =
uses 'def...' e.g def, defsyntax, defstruct, defrules rather than =
define, define-syntax, define-record etc. I'm not user if we want to =
accommodate that or not.
>>=20
>> Yes, this is the part that is hard for me to figure out. I am going =
by
>> two heuristics: what Scheme communities in other places would =
generally
>> prefer, and what patterns I see happen more often in scheme code.
>>=20
>> The former is tricky to do. I posted to a few mailing lists about =
this,
>> but they don't seem active enough to garner any responses.
>>=20
>> The latter is a little easier to measure quickly. I did a GitHub =
search,
>> where I filtered results to only consider Scheme files =
(language:scheme).
>>=20
>> Some armchair stats, just for a broad understanding:
>>=20
>>  Total number of scheme files: 529,339
>>  No. of times a construct is used in those files:
>>    define and its variants : 431,090 (81.4%)
>>    def and its variants    :  18,466 ( 3.5%)
>>    eval-when               :   3,375 ( 0.6%)
>>=20
>> There was no way for me to quickly know which of these uses are at =
the top
>> level, but either way of the more structural forms that do show up in =
Scheme
>> code, define and its variants seem like a clear winner. I am not sure =
if
>> it's worth adding more rules to check for def and its variants, given =
that
>> they are not nearly as common.
>=20
> In those cases we should veer on the side of inclusion. The only =
problem
> we'll have is if "eval-when" is a "setq"-like function top-level form =
in
> some other scheme dialect, so we'll have a conflict.
>=20
> Otherwise it's fine, programs that only use "define" won't be bothered
> by an eval-when rule.

I would like some clarification, since my knowledge of Common Lisp's =
setq
and Guile's/Other's eval-when is pretty surface level.

> The only problem we'll have is if "eval-when" is a "setq"-like =
function
> top-level form in some other scheme dialect, so we'll have a conflict.

I am not sure what you mean when you say if "eval-when" is a "setq"-like
top level form, and exactly what kind of problem it may cause.

I also realized from my understanding of the Guile Documentation[1],
that "eval-when" is used to tell the compiler which expressions should =
be
made available during the expansion phase.

It does not seem to have anything that may help identify the location of =
the
hunk, which I understand is the primary purpose of these hunk headers.
All uses of "eval-when" would be some variation of:

	(eval-when (expand load eval) ; no identifier in this form
	  ...)

unlike a "define" which will always name the nearest function, which =
helps as
a landmark.

Would that be a valid reason to exclude "eval-when"?

