Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D25C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 11:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159BA61159
	for <git@archiver.kernel.org>; Wed,  5 May 2021 11:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhEEL7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 07:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhEEL7f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 07:59:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D0EC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 04:58:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i24so1669460edy.8
        for <git@vger.kernel.org>; Wed, 05 May 2021 04:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5G4xKkeiikbIizACaCWkRb6Yo4DC3lJHJJ+NqcQau3c=;
        b=IbAaiUt0vmE0Q/1AA+L0+GVmmopuEu3mD7LYotiBUgUDZTvLnOjguAygOyaSvfnSCJ
         kke8hrLCqkTXnARkwKNVkrOso+KWmfBtH9RrqF/ui6k8xl0i37fT1mATIlUWPj1Dytzz
         qv2nWN1lFvv6fiUoSC4wppyQzcOiZ2eNLpZILdorhC3iEfWK0xxifsKyJx9aiFJmXnRG
         ESf/wDhpcpJOlbVfwf/ueTtdmchhtxAhsR+w4uJHGC+IXHJQBTWDSKbzjLlpi5hKKlyZ
         SnSM6mG+Q5R2aZ5aMyk4fD7FuTrd7zubAP2jgPaSlUkg7AWbIXjOwcdDgD/a+qx57bY+
         I6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5G4xKkeiikbIizACaCWkRb6Yo4DC3lJHJJ+NqcQau3c=;
        b=Nv1jYx7+Riqz85bGNWO/1VqTeiCwAi9ZSBz3vfGrErMx8c7+EkCIm6o+mkMpcJ5tBi
         heGtmI49CA2tiiERSwYl85tVmSDgfC6VAwqkQpGBchYX96wfxniHkMhVNf1k/ArYCadw
         5AqbzUbdDiE0Lz2CGGOOfghkbDp7Z/wCc9t0mdpeyw9RM+TKC4iY2qAY1FMwC7YOtzOu
         Xal2j7CTMgavC5wHlM7LPZ6Abwk+pMRtgGGzOD7r0PMlQkix33ctfYCUcYXUWglQbr3m
         i421Cs02Q5KIJ12x8JEAPJvN+fTzi12v8N7AMGCW+VIQlFaQj16b3aN825K81UorAocF
         gUEw==
X-Gm-Message-State: AOAM531mw3Dy5Zg8PfFhXFI61UxvnIvfPl83ps7J+hxek6V2dq6my8nI
        GRy9TvBhG3sJtFHZMnnEFaY=
X-Google-Smtp-Source: ABdhPJwdZhTzTWTi0PFpBaURfDr4G2rTnaPvo+zgqbI5pHnkIwWt8GKxDtKDE0Qses5IDPRL2lzkjA==
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr31730322edj.178.1620215917272;
        Wed, 05 May 2021 04:58:37 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t20sm2765828ejc.61.2021.05.05.04.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 04:58:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org, Yiyuan guo <yguoaz@gmail.com>
Subject: Re: [PATCH 3/5] pack-objects: clamp negative window size to 0
Date:   Wed, 05 May 2021 13:53:06 +0200
References: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
 <YI1fubjvQQlrPz9D@coredump.intra.peff.net>
 <3d77d70b-2cc5-4ca9-8753-fa9af5111842@gmail.com>
 <YJAOzTIXkO2lhxSs@coredump.intra.peff.net>
 <02a66bfb-aac0-c05e-dab3-366bc312d900@web.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <02a66bfb-aac0-c05e-dab3-366bc312d900@web.de>
Message-ID: <874kfhwfwz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 04 2021, Ren=C3=A9 Scharfe wrote:

> Am 03.05.21 um 16:55 schrieb Jeff King:
>> On Mon, May 03, 2021 at 08:10:24AM -0400, Derrick Stolee wrote:
>>
>>> On 5/1/2021 10:03 AM, Jeff King wrote:
>>>> A negative window size makes no sense, and the code in find_deltas() is
>>>> not prepared to handle it. If you pass "-1", for example, we end up
>>>> generate a 0-length array of "struct unpacked", but our loop assumes it
>>>> has at least one entry in it (and we end up reading garbage memory).
>>>>
>>>> We could complain to the user about this, but it's more forgiving to
>>>> just clamp it to 0, which means "do not find any deltas at all". The
>>>> 0-case is already tested earlier in the script, so we'll make sure this
>>>> does the same thing.
>>>
>>> This seems like a reasonable approach. It takes existing "undefined"
>>> behavior and turns it into well-understood, "defined" behavior.
>>
>> I was on the fence on doing that, or just:
>>
>>   if (window < 0)
>> 	die("sorry dude, negative windows are nonsense");
>>
>> So if anybody has a strong preference, I could be easily persuaded. Part
>> of what led me to being forgiving was that we similarly clamp too-large
>> depth values (with a warning; I didn't think it was really necessary
>> here, though).
>
> There's another option: Mapping -1 or all negative values to the
> maximum:
>
> 	if (window < 0)
> 		window =3D INT_MAX;
> 	if (depth < 0)
> 		depth =3D (1 << OE_DEPTH_BITS) - 1;
>
> That's allows saying "gimme all you got" without knowing or being
> willing to type out the exact maximum value, which may change between
> versions.  Not all that useful for --window, I guess.  That convention
> has been used elsewhere I'm sure, but can't point out a concrete
> example.  $arr[-1] get the last item of the array $arr in PowerShell,
> though, which is kind of similar.
>
> Sure, you get the same effect in both cases by typing 2147483647, but
> -1 is more convenient.
>
> Not a strong preference, but I thought it was at least worth
> mentioning that particular bike shed color. :)

That seems sensible to expose, but I think should really be
--window=3Dmax, not --window=3D-1. The latter feels way too much like
assuming that a user might know about C's "set all bits" semantics.

The one example of such a variable I could think of is core.abbrev=3Dno,
which could arguably benefit from a core.abbrev=3Dmax synonym.

Another one is *.threads, e.g. grep.threads, index.threads. We currently
say that "auto" is like "max, but I can see how we'd eventually benefit
from splitting those up. I sometimes run git on machines where that
"auto" is 48 or whatever (I haven't benchmarked, but that's surely
counter-productive). Having max !=3D auto in that case (but still having a
"max") would be nice.

