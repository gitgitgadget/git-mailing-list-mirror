Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835ADC05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 13:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjBANt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 08:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjBANtu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 08:49:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3737365EC7
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 05:49:24 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id k4so46104391eje.1
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 05:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XDs1YK1ptjrxmJ6UtjmM5uV8QP5/kvpiCO6nCQP9ZxE=;
        b=HTMKF6vo36tTb/3rXoQMw5uNAVgDz3efMMMjqtWo44A1b6uv2kujzKU2T/ekSVCHBq
         tflGk5sPKmCemXSW2rNSi37S+KfwMsNg2KK8siwvtEj8rbfUwam8TvcwJhmODAxGYcec
         xbCvlF/guyNAoyvIP4fks1jY1ojhtRyWi4JDw6AE75kra89sVtl/7I6kkIKruyO5SDGq
         nNM9au3vaynjxIcKz8KbovM+ndLX0j9p2DTOhGnC+m8ElWONCxL4PMSMbSgC9qfLe3QU
         iKq+K90aHd+GqDnrTLOvF2y3O627Vf25/SyTatpKUNxZhOHKeHCtjKA7ddbO6Vibydc1
         JaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XDs1YK1ptjrxmJ6UtjmM5uV8QP5/kvpiCO6nCQP9ZxE=;
        b=uAeJbxHyPPle4eXPR+8qAYJqeE2ny3dZhL4yUPQiQXomKlyhbZH+Gj1v6IGICGfX14
         QfaygfE+gQxR+LbGtu4eZATFb7RyLgzE/U/2EcmT1mbyXnHe27Z7YC8tQFOABoTp6rDD
         7xwmW5FXmJ0AMGYdqDwnmjnBMTSnoDTuuHSggLRpbx5mHMti46M3KKxbjMDxbtmLdeTX
         9sSxzIobqwQPTTY/u1/mVr3ywGPbSIun1dCI74CBA49igBld8BUGCVbpEiUeHw6J9gw2
         VLSihABhdG62vbkeVQbZUTNBQ2Zl8mTAGJP7sYzVIbBC/OKg6eHOhU0Z1xo2XrTt8LLx
         uGvA==
X-Gm-Message-State: AO0yUKWSwYwpPNNKKNPk/FkA+qM9YGRSPv+n4DCZLoWOmzaxhJgRMmiP
        5u3ZUBjEGnH5FxmSKIvn7jI=
X-Google-Smtp-Source: AK7set/NthSR8ZKHSGLrrZUEVRADBb4qrfolq9OIsDnTkQ3XA180hJqW/Ep40MY7oo2izuQ6nA2qfQ==
X-Received: by 2002:a17:907:2bc2:b0:878:5d77:b4eb with SMTP id gv2-20020a1709072bc200b008785d77b4ebmr2355864ejc.42.1675259362784;
        Wed, 01 Feb 2023 05:49:22 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id p23-20020a17090653d700b007ad69e9d34dsm10075875ejo.54.2023.02.01.05.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 05:49:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pNDUH-002GEq-1y;
        Wed, 01 Feb 2023 14:49:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     demerphq <demerphq@gmail.com>
Cc:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Date:   Wed, 01 Feb 2023 14:43:15 +0100
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
 <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
 <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net>
 <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
 <CANgJU+V0QRFwmTh8ZzY=28kmbUw=DvSLE24LioOXp6_ozq+RdA@mail.gmail.com>
 <20230201122152.GJ19419@kitsune.suse.cz>
 <CANgJU+VLseURimM++38WA81uFPbnoHiToOt4F4UFL9yVbQpBEw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CANgJU+VLseURimM++38WA81uFPbnoHiToOt4F4UFL9yVbQpBEw@mail.gmail.com>
Message-ID: <230201.86cz6tqyvy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 01 2023, demerphq wrote:

> On Wed, 1 Feb 2023, 20:21 Michal Such=C3=A1nek, <msuchanek@suse.de> wrote:
>>
>> On Wed, Feb 01, 2023 at 12:34:06PM +0100, demerphq wrote:
>> > Why does it have to be gzip? It is not that hard to come up with a
>
>> historical reasons?
>
> Currently git doesn't advertise that archive creation is stable
> right[1]? So I wrote that with the assumption that this new
> compression would only be used when making a new archive with a
> hypothetical new '--stable' option. So historical reasons don't come
> up. Or was there some other form of history that you meant?

We haven't advertised it, but people have come to rely on it, as the
widespread breakages reported when upgrading to v2.38.0 at the start of
this thread show.

That's unfortunate, and those people probably shouldn't have done that,
but that's water under the bridge. I think it would be irresponsible to
change the output willy-nilly at this point, especially when it seems
rather easy to find some compromise everyone will be happy with.

> I'm just trying to point out here that stable compression is doable
> and doesn't need to be as complex as specifying a stable gzip format.
> I am not even saying git should just do this, just that it /could/ if
> it decided that stability was important, and that doing so wouldn't
> involve the complexity that Avar was implying would be needed.  Simple
> compression like LZ variants are pretty straightforward to implement,
> achieve pretty good compression and can run pretty fast.
>
> Yves
> [1] if it did the issue kicking off this thread would not have
> happened as there would be a test that would have noticed the change.

I have some patches I'm about to submit to address issues in this
thread, and it does add *a* test for archive output stability.

But I'm not at all confident that it's exhaustive. I just found it by
experiment, by locating tests ouf ours where the "git archive" output at
the end is different with gzip and "git archive gzip".

But is it guaranteed to find all potential cases where repository
content might trigger different output with different gzip
implementations? I don't know, but probably not.
