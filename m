Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAC9C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 12:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbiCWMew (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 08:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCWMev (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 08:34:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D2A5FF1
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 05:33:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a17so1640319edm.9
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ehNccpKLz5XjffjtWjIFb7rjZ2VBcouPoQumApuFavw=;
        b=NJ1H9nDdc9dzZLBRmzAuPHUDXZxeRCdk1wX6iZuXaYX5U1EOIecWrt6ZW7C17drZ1R
         uhDFVfZGKfN51z3Y0AQfWMN9s3Y9WQLKpXFnnFWtGDEX7TzHjwzJErdp1iUIJrcr04Hx
         gdFNuZDTIn+bgokigkoqxF19lqruC5z8EyfoeM1FP/r1a8+lSzzK6CVfaS5soVuLX9HI
         ZqXOKNrJxJNxXb9lETQANSbIBF9tGMboVOGU/SxoH4e8bVyTMf4oAMocOd+uD6Sc8rdW
         M8OaqctkteQ2TMsB61Cq6S5XzyzjrbtnKSYJYYTqyFbF04vF98ryKy22C6ohO33rzefD
         7ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ehNccpKLz5XjffjtWjIFb7rjZ2VBcouPoQumApuFavw=;
        b=Pa/BAJfnN2hDBCfF9t0FDdi96XW5wOKsVFQjQ5FKJOW6FeW7kN2INPxbtd62NVMd/G
         YC2/2VtVRDW2vb2kWd/EiTUUNUN2C3r9Wgd/AV8WUhlqekwpaD1T3Uted6+Rdxc3A9iW
         SPLjsSAo0eI/JU2JtJJ1ayYzp2u00yaqszUnOnZ4h/zCN0ZQ2NiyJ+r/7mKyDoCTYTGy
         46QxYcOwQhUHJ4NOHwHQ5HyngrUcPPttxMofeylWxYwa0Qciw8f26ekPMfwXiId7UUsa
         ousoh6hN0nwqobMHU9y6a0hSFDl9yo/Br42qsoqTLEpqgN6IRgikRlSz+Ef5OJvGd/cr
         C5Ug==
X-Gm-Message-State: AOAM532MU4JtSupf1jVLV5RMjWWuN09kHd37zoSrSY13AHwcUESsyoAq
        Sobei3lYeeTMRK3LE/o8ZXQ=
X-Google-Smtp-Source: ABdhPJxJ5WcD6I0Q5j1oATrn4+9kqffcW+BDrxPj3eKiPQ3bRDtLis2awK/orpNW8y7cR7reQF95Sw==
X-Received: by 2002:a05:6402:270b:b0:419:3383:7a9f with SMTP id y11-20020a056402270b00b0041933837a9fmr18529867edd.191.1648038797766;
        Wed, 23 Mar 2022 05:33:17 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id kw5-20020a170907770500b006db075e5358sm9723782ejc.66.2022.03.23.05.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 05:33:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nX0Au-000ljT-Ck;
        Wed, 23 Mar 2022 13:33:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: How to determine the number of unique recent committers on a
 branch?
Date:   Wed, 23 Mar 2022 13:30:50 +0100
References: <CAHGBnuPavzr_gq0ake6bOQETmHBnU2XOWdDz-UtkBP_+rRdYfA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <CAHGBnuPavzr_gq0ake6bOQETmHBnU2XOWdDz-UtkBP_+rRdYfA@mail.gmail.com>
Message-ID: <220323.86o81wonlf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 23 2022, Sebastian Schuberth wrote:

> Hi,
>
> I'm trying to determine the number of unique committers who have
> recently committed to a branch. "Recently" should be configurable, but
> for my example I'll use a period of 3 months.
>
> At first, I thought the [<refname>]@{<date>} syntax [1] in conjunction
> with git "shortlog -s" could be helpful here, like
>
> $ git shortlog -s main@{3.months.ago} | wc -l
>
> But then I realized that just like with the --since option, the <date>
> counts relative to the current date, not relative to the date of the
> last commit on the given branch. To me, that's rather counterintuitive
> for the [<refname>]@{<date>} syntax.
>
> So, what would be a good way to achieve what I want with only
> Git-means (and maybe `wc`), but without any awk / Perl scripting
> magic?
>
> Thanks in advance!
>
> [1]: http://git-scm.com/docs/gitrevisions#Documentation/gitrevisions.txt-=
emltrefnamegtltdategtemegemmasteryesterdayememHEAD5minutesagoem

The ref@{} syntax will give you ref*log* times, which is probably not
what you want.

I think --since to "rev-list" combined with e.g. "shortlog" is what you
want here, e.g. on git.git:
=09
	$ git -P shortlog --since=3D2.weeks.ago -sn origin/master=20
	    36  Junio C Hamano
	    12  Derrick Stolee
	     2  Shubham Mishra
	     1  Michael J Gruber
	     1  =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason

Maybe there's a way to get it to spew that out without the numeric
summary, but I can't recall one offhand. I.e. you'd still need awk/cut,
but at least not uniq anymore..
