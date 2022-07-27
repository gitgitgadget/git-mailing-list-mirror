Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B25C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 20:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiG0UyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 16:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiG0UyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 16:54:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6FF5141F
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 13:54:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p5so11937604edi.12
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=O0b7ySa5bKznApimBz3g/x7mUhRO20iyIhDZk2TUorE=;
        b=JpgKS9coOtl6swBxBxR/TgqcFgNRW9hKZn+sw9OY4ZHCR12YpyJOuFiSRYj9S7/Te3
         ITi6lZ3F8TqQiKqICRT/eD2aVcDEK5Omn4D3zFXRkE87a3wO3KKmqmxe6QgHsDmzmF3P
         +L/PRK+UewZU/UAHAwdgoAp+TDbHxvSUIqR7XTvtHE3Z8azuFOndSpmT7Ns73wS+39Do
         wOs0vt6Lk4+GE062GWxUBh2Be3Z+rbFcHuepxhM5gqLRnB4Z1d0+26rK+giBNqO7TIq3
         9Ij75DjkVW8wjcjsqkuIp+PHS1B+xNAZR6zBkWd1v54YPl4HwW5NkW7pgAaT7eIxQIb4
         dDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=O0b7ySa5bKznApimBz3g/x7mUhRO20iyIhDZk2TUorE=;
        b=acvbhYtwY+uq/RB/Jgaqva/deI3aPp9Ejy6fysWLvmjZbwZWwMyVJehbgChDaypPN1
         2cbEltBlNrtrdfZLE3UGdcKAw+TYeOk+fhzEOV0sgKrXUymt/VA4/PxZVyDM5utCyfh6
         ZlEv56JpqFBonpKYi0TLi2kNQIBhjPdJn2w565DgeOSqwuNVvKweew8zx6JshgUPXFce
         Uz6+eiLdKxipWaFzuTR1pGqypNAKlpQJa7vqTWicdIpzaRrCDQ4W7LKg2xW05kor+dFj
         qOu5zKiagQDxS3qLi9tflH6WxNnOLG3x1MQ5/XcvC1ndP6qE7QjSIQ0PB+Vno7OikYCR
         5+/Q==
X-Gm-Message-State: AJIora/rcKK08lxx4Yc9yT1J7RUYbzB2IBPPc1mrSl6Pet6HZH2LhQyg
        lDiLd4uQNvfUqYFH71uNkAM=
X-Google-Smtp-Source: AGRyM1vj3ImCiiLQwOU84Ey0XaHsTxX1KCmtbaxwqUsnQ5X1PVGrcEdk8usNct8DtLPyz++wIKWlwQ==
X-Received: by 2002:aa7:c14f:0:b0:43b:c2f1:4020 with SMTP id r15-20020aa7c14f000000b0043bc2f14020mr24610359edp.159.1658955246702;
        Wed, 27 Jul 2022 13:54:06 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k19-20020a1709062a5300b0072af3deb944sm7902214eje.223.2022.07.27.13.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 13:54:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGo2f-006ryd-BN;
        Wed, 27 Jul 2022 22:54:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com
Subject: Re: [PATCH 0/3] log: create tighter default decoration filter
Date:   Wed, 27 Jul 2022 22:40:21 +0200
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <220726.86tu73ncf8.gmgdl@evledraar.gmail.com>
 <c3b14045-01a1-e207-a60d-2e3290ab8001@github.com>
 <220726.868rofn23f.gmgdl@evledraar.gmail.com>
 <69684d1e-ffda-367c-f0ae-2d4a3560be74@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <69684d1e-ffda-367c-f0ae-2d4a3560be74@github.com>
Message-ID: <220727.86edy6l1jm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 27 2022, Derrick Stolee wrote:

> On 7/26/22 2:19 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Jul 26 2022, Derrick Stolee wrote:
>>=20
>>> On 7/26/2022 10:44 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>>> But I think this change is going about it the wrong way, let's have a
>>>> list of refs that Git knows about as magical, instead of assuming that
>>>> we can ignore everything that's not on a small list of things we're
>>>> including.
>>>>
>>>> Wouldn't that give you what you want, and not exclude these sorts of
>>>> custom refs unexpectedly for users?
>>>
>>> Instead of keeping track of an ever-growing list of exclusions, instead
>>> making a clear list of "this is what most users will want for their
>>> decorations" is a better approach.
>>>
>>> Users who know how to create custom refs outside of this space have the
>>> capability to figure out how to show their special refs. My general ide=
as
>>> for designing these kinds of features is to have a default that is focu=
sed
>>> on the typical user while giving config options for experts to tweak th=
ose
>>> defaults.
>>>
>>> You're right that this series perhaps leaves something to be desired in
>>> that second part, since there isn't an easy _config-based_ way to enable
>>> all decorations (or a small additional subset).
>>=20
>> Yes, but this is just side-stepping the issue. Your X-Y problem is that
>> you want to exclude certain refs that we're specifically creating.
>>=20
>> I think that's fair enough, but I don't see why we're not specifically
>> excluding just those then.
>
> I'm advocating that we make a one-time change to have a set of "known
> useful refs"

You can't know the set of known-useful refs. Unless we explicitly lay
claim to something in the namespace it's the user's.

This series seems to have started out by observing that "git log" is
showing certain "useless" refs added in another topic, since they're
owned by git, and "internal-only", which is fair enough.

But I don't see how we can or should make the leap to things that are
not on a limited "not-useless" list git knows about should be the only
thing we should display.

Wouldn't carrying a list of what to exclude achive the same goal (but
see below...).

> as showing up in the decorations. Perhaps some users (like yourself)
> need to react to that change, but it happens _once_.

It's long-established behavior, we try not to change that sort of
thing. In this case I think we *could*, i.e. I don't imagine it would be
a *huge* disruption if we had a good reason, e.g. the use-cases of
machine-parsing this are fairly obscure.

But the disruption seems unwarranted if it's just to hide the likes of
refs/bundle/, when we can just address those specifically.

And it's not "once", it's N times for each downstream user that'll run
into this, whereas not changing the behavior is effort among a small
group of git developers...

> Changing the rules repeatedly as new "hidden" namespaces are added is
> more likely to cause confusion multiple times.

I really don't see the worry about a maintenance burden of having a
thing in refs.c (or whatever) that's just:

	hide_from_decorate[] =3D {
		"refs/bundle/*"
                [...],
                NULL
	};

Worst case we'll create another "magic" ref, forget to add to the list,
and someone will notice and we'll add it.

Which at that point will be a one-line change, and preferrable to N
users having to chase down some new config which explains why their
local refs aren't shown anymore with decorate...
