Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808D7C433E0
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A3864E11
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhAaUiE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhAaUhv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 15:37:51 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2158C061574
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 12:37:10 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p20so1783995ejb.6
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 12:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=O4hSsh8qwsuRClf16DoO4Yfkhy/gvM91rhXZ+ulW7Pk=;
        b=nZvqDNC8Day9u0+Gwy/Ibof5Wt1FWJwrvrIwnsTqO7TJuDG6vfz/Jc2/8YFSWN6aBL
         4r7pXj9RuZcK7/s/Vp6JdYM75jaS/Bxd8rSoWu+DqBcgni8ahB35MyJO1IEtOFYumbOL
         CL51bh76USfXRYPQlYi9+tO4rXo5AtrLgE1Gou9aeWsxLDgWExShBhKTRjxFjZAjdTcP
         SDJZISINMR/FVxQRo3CcPt6F1FuOOBgalR868HqrVRbLCCuQ0jguRG4GAJcDmyZcfUAI
         YikYtlQN4zF1NsWd025M+v0pnt4VeMNV85+Qtt5vpO40/7X32f41vOQ2FKYlzsaR0G2u
         3ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=O4hSsh8qwsuRClf16DoO4Yfkhy/gvM91rhXZ+ulW7Pk=;
        b=YJtdHPmca9NBJMgeV6VEhVlWEibwb19GfdcK/8ohMBxepMPIVI5fbL9baxzoLvqE7D
         xmuod7PdW2ycdk5KXFbEhi0WXaAVbRAxsIRi9iCr9b0PDZiHGVWS9dzJ5orYKzDkx4uW
         cJ6XBRw80sjY+aDHxCilIj1J3JE5Vrh/Peb9hZFIYH8wyIMnPviej3QGk6DnfHHxWV3f
         V9xro5Aep467+bmgWxGoxjUWRfV+o0jT/Ipyupn3gRlrSc9GzrYulZIq2tNcZOVlhekv
         IUFHKshfydXcPxXof+UtNvpekefzjzRnYhNIPTlKbJgTcU3AmQgWnrY3R9l6/rb7aaFH
         TrMA==
X-Gm-Message-State: AOAM533duwM3H4VBxp+ptteHQ9Q4yaWh/freI2p0VbgsmXv8946MJDse
        3/d1/4LAArkRGj2Wk7LmAEk=
X-Google-Smtp-Source: ABdhPJwnmC8Po66AElsOMz+50FgYrHCazz1uzU+6hban62lG0aytdRf82xpahepiHqBPz70/TcHt/A==
X-Received: by 2002:a17:906:ad86:: with SMTP id la6mr14400743ejb.47.1612125429384;
        Sun, 31 Jan 2021 12:37:09 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id e6sm7371521edv.46.2021.01.31.12.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 12:37:08 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Ackermann via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Ackermann <th.acker@arcor.de>
Subject: Re: [PATCH 5/6] doc hash-function-transition: move rationale upwards
References: <pull.858.git.1612093734.gitgitgadget@gmail.com>
 <2cdb0f8e2edc4416c5dfb88722aa05be35afba7d.1612093734.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <2cdb0f8e2edc4416c5dfb88722aa05be35afba7d.1612093734.git.gitgitgadget@gmail.com>
Date:   Sun, 31 Jan 2021 21:37:07 +0100
Message-ID: <87r1m0onbg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 31 2021, Thomas Ackermann via GitGitGadget wrote:

> diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
> index dc0c4976a62..c9b57a125e2 100644
> --- a/Documentation/technical/hash-function-transition.txt
> +++ b/Documentation/technical/hash-function-transition.txt
> @@ -27,13 +27,17 @@ advantages:
>    methods have a short reliable string that can be used to reliably
>    address stored content.
>  
> -Over time some flaws in SHA-1 have been discovered by security
> -researchers. On 23 February 2017 the SHAttered attack
> +Over time some flaws in SHA-1 have been discovered by security researchers.
> +In early 2005, around the time that Git was written, Xiaoyun Wang,
> +Yiqun Lisa Yin, and Hongbo Yu announced an attack finding SHA-1
> +collisions in 2^69 operations. In August they published details.
> +Luckily, no practical demonstrations of a collision in full SHA-1 were
> +published until 10 years later: on 23 February 2017 the SHAttered attack
>  (https://shattered.io) demonstrated a practical SHA-1 hash collision.
>  
>  Git v2.13.0 and later subsequently moved to a hardened SHA-1
> -implementation by default, which isn't vulnerable to the SHAttered
> -attack.
> +implementation by default that mitigates the SHAttered attack, but
> +SHA-1 is still believed to be weak.
>  
>  Thus Git has in effect already migrated to a new hash that isn't SHA-1
>  and doesn't share its vulnerabilities, its new hash function just
> @@ -57,6 +61,29 @@ SHA-1 still possesses the other properties such as fast object lookup
>  and safe error checking, but other hash functions are equally suitable
>  that are believed to be cryptographically secure.

I don't think this is an improvement, why does someone trying to learn
about Git's SHA-256 transition care about early SHA-1 flaws that didn't
prompt the transition.

I'm probably biased since the current intro is mine from 5988eb631a3
(doc hash-function-transition: clarify what SHAttered means,
2018-03-26), but this really feels too much like going into the weeds.

I think the document would be improved by just removing the whole
mention of early 2005 and mentioning several researchers by name. I
think the current prose of "Over time some flaws in SHA-1 have been
discovered by security researchers" suffices, if people are curious
about SHA-1's vulnerability history there's plenty of good easily found
sources for that.

> +Choice of Hash
> +--------------
> +The hash to replace the hardened SHA-1 should be stronger than SHA-1
> +was: we would like it to be trustworthy and useful in practice for at
> +least 10 years.
> +
> +Some other relevant properties:
> +
> +1. A 256-bit hash (long enough to match common security practice; not
> +   excessively long to hurt performance and disk usage).
> +
> +2. High quality implementations should be widely available (e.g., in
> +   OpenSSL and Apple CommonCrypto).
> +
> +3. The hash function's properties should match Git's needs (e.g. Git
> +   requires collision and 2nd preimage resistance and does not require
> +   length extension resistance).
> +
> +4. As a tiebreaker, the hash should be fast to compute (fortunately
> +   many contenders are faster than SHA-1).
> +
> +We choose SHA-256.
> +
>  Goals
>  -----
>  1. The transition to SHA-256 can be done one local repository at a time.
> @@ -601,39 +628,6 @@ example:
>  
>      git --output-format=sha1 log abac87a^{sha1}..f787cac^{sha256}
>  
> -Choice of Hash
> ---------------
> -In early 2005, around the time that Git was written, Xiaoyun Wang,
> -Yiqun Lisa Yin, and Hongbo Yu announced an attack finding SHA-1
> -collisions in 2^69 operations. In August they published details.
> -Luckily, no practical demonstrations of a collision in full SHA-1 were
> -published until 10 years later, in 2017.
> -
> -Git v2.13.0 and later subsequently moved to a hardened SHA-1
> -implementation by default that mitigates the SHAttered attack, but
> -SHA-1 is still believed to be weak.
> -
> -The hash to replace this hardened SHA-1 should be stronger than SHA-1
> -was: we would like it to be trustworthy and useful in practice for at
> -least 10 years.
> -
> -Some other relevant properties:
> -
> -1. A 256-bit hash (long enough to match common security practice; not
> -   excessively long to hurt performance and disk usage).
> -
> -2. High quality implementations should be widely available (e.g., in
> -   OpenSSL and Apple CommonCrypto).
> -
> -3. The hash function's properties should match Git's needs (e.g. Git
> -   requires collision and 2nd preimage resistance and does not require
> -   length extension resistance).
> -
> -4. As a tiebreaker, the hash should be fast to compute (fortunately
> -   many contenders are faster than SHA-1).
> -
> -We choose SHA-256.
> -

Same here. We're going into the weeds about what hashes we didn't pick
before talking about what we're going to do with SHA-256? Much of that
wording is just historical, and pre-dates the SHA-256 pick. I think
something like this would be much better at this point:
    
    diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
    index 6fd20ebbc25..a4222eb0a6c 100644
    --- a/Documentation/technical/hash-function-transition.txt
    +++ b/Documentation/technical/hash-function-transition.txt
    @@ -602,36 +602,17 @@ git --output-format=sha1 log abac87a^{sha1}..f787cac^{sha256}
     
     Choice of Hash
     --------------
    -In early 2005, around the time that Git was written, Xiaoyun Wang,
    -Yiqun Lisa Yin, and Hongbo Yu announced an attack finding SHA-1
    -collisions in 2^69 operations. In August they published details.
    -Luckily, no practical demonstrations of a collision in full SHA-1 were
    -published until 10 years later, in 2017.
     
    -Git v2.13.0 and later subsequently moved to a hardened SHA-1
    -implementation by default that mitigates the SHAttered attack, but
    -SHA-1 is still believed to be weak.
    -
    -The hash to replace this hardened SHA-1 should be stronger than SHA-1
    -was: we would like it to be trustworthy and useful in practice for at
    -least 10 years.
    -
    -Some other relevant properties:
    -
    -1. A 256-bit hash (long enough to match common security practice; not
    -   excessively long to hurt performance and disk usage).
    -
    -2. High quality implementations should be widely available (e.g., in
    -   OpenSSL and Apple CommonCrypto).
    -
    -3. The hash function's properties should match Git's needs (e.g. Git
    -   requires collision and 2nd preimage resistance and does not require
    -   length extension resistance).
    +There were several contenders for a successor hash to SHA-1, including
    +SHA-256, SHA-512/256, SHA-256x16, K12, and BLAKE2bp-256.
     
    -4. As a tiebreaker, the hash should be fast to compute (fortunately
    -   many contenders are faster than SHA-1).
    +In late 2018 the project picked SHA-256 as its successor hash.
     
    -We choose SHA-256.
    +See 0ed8d8da374 (doc hash-function-transition: pick SHA-256 as
    +NewHash, 2018-08-04) and numerous mailing list threads at the time,
    +particularly the one starting at
    +https://lore.kernel.org/git/20180609224913.GC38834@genre.crustytoothpaste.net/
    +for more information.
     
     Transition plan
     ---------------
