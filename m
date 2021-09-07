Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0BCC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE68460F01
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbhIGKhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhIGKhL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:37:11 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28E9C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:36:04 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g21so13241399edw.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6foFMzgH+p60rynZgzjfy+CWaYP0kmqZ9I6LuS9aXGA=;
        b=T0PMffLo0STEFjL5iJEAk3a454ml8KmIXkunhIFvbvLGDvtiQK1KoSzEtIVSceUKb4
         Rormfrqzr6SO96jdi3x/JWqZoVluYW39bog5JIaEAaLHiheSHXZ1NsRbto0zGyLSaCOj
         CQUkz3V2NKASd49OXyJgoIAc+Yz85gE0RbmBhlaUsA9sC5OBe4iy3niMe3OHwDIjqzW6
         g9fxpj4nQnL9wXbPDv93eDFtxRHo7NRp5+R2utMrVwpXsLNov1hvAtIY+3KriUVrrdgN
         AV3dcyw/drmYkbct3/AhEGb0g7wRPhCCIYE6fvc0EmgnHEciJePvYehMUJkw+3w6lK7L
         OmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6foFMzgH+p60rynZgzjfy+CWaYP0kmqZ9I6LuS9aXGA=;
        b=a4Wc8DT86kdl41tbVUOd8zrZKdD2RGxXOnTcgp2SMBCk1sD8lLQNxRH40VR4c3Mu6J
         00yuzmoSVv+q5ofAlOukhVaSaPlPz+6eXGLk56ejU/dDnpSJFfDjVIpulT1X6ekG33fz
         WIGR9oqITDri2D4vui4dRtRirxQnbzIURpAQ+TieEnvkqUKRMaPgtUj4w58WCczV6o7s
         Mdl7/XrJAjFxmbsHJFom2/iwFkQFIwuvNbcRtUYaHSRTiIYDfNmtB9k1oh0f9Bf8cM2X
         0nSQgcbjMPDDDnNa0qr6BxV2OyiBgaVGib1qb+o/4QD5tFiTL3NYLmSMMhCJrevIG8nq
         Dx/w==
X-Gm-Message-State: AOAM533ovunq63BkT4ED8dzkBfapvaL+7BFH+Eqoa4H6o/h+PRQxm30R
        za9qus1FOYMrrs8iH9KV9HY=
X-Google-Smtp-Source: ABdhPJyjgUP7kF5fyrEyYViDHNmdR2W9PBpoBWlVUdet8eXYslvptxiwNCO7Si2XKkNMXl8fXzARAg==
X-Received: by 2002:a50:ab42:: with SMTP id t2mr18080803edc.113.1631010962984;
        Tue, 07 Sep 2021 03:36:02 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p23sm6551461edw.94.2021.09.07.03.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:36:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v2 1/7] git-sh-setup: remove unused git_pager() function
Date:   Tue, 07 Sep 2021 12:22:58 +0200
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
        <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
        <patch-v2-1.7-8eb1dfbff5d-20210906T070201Z-avarab@gmail.com>
        <55293c43-811b-b030-9512-7525f5ebfd12@gmail.com>
        <87czplnxn3.fsf@evledraar.gmail.com>
        <8912317f-7eb0-edae-29e3-2e05099bc696@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <8912317f-7eb0-edae-29e3-2e05099bc696@gmail.com>
Message-ID: <87eea0n04u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Phillip Wood wrote:

> On 06/09/2021 23:27, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Sep 06 2021, Phillip Wood wrote:
>>=20
>>> Hi =C3=86var
>>>
>>> On 06/09/2021 08:05, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> Remove the git_pager() function last referenced by non-test code in
>>>> 49eb8d39c78 (Remove contrib/examples/*, 2018-03-25).
>>>> We can also remove the test for this added in 995bc22d7f8 (pager:
>>>> move
>>>> pager-specific setup into the build, 2016-08-04), the test that
>>>> actually matters is the one added in e54c1f2d253 (pager: set LV=3D-c
>>>> alongside LESS=3DFRSX, 2014-01-06) just above the removed test.
>>>> I.e. we don't care if the "LESS" and "LV" variables are set by
>>>> git-sh-setup anymore, no built-in uses them, we do care that pager.c
>>>> sets them, which we still test for.
>>>
>>> git_pager() might not be documented but I think it is useful for
>>> script authors and I wouldn't be surprised if someone out there is
>>> using it. The same goes for peel_committish(). It does not seem like a
>>> huge maintenance burden to keep and maybe document these two
>>> functions.
>> The git_pager() and peel_committish() seem to thoroughly be in the
>> same
>> camp as the now-removed git-parse-remote.sh (see a89a2fbfccd
>> (parse-remote: remove this now-unused library, 2020-11-14)) and say its
>> get_remote_merge_branch(). I.e. we carried it for a while, but the
>> function was never publicly documented.
>> I think rather than document these it makes sense to just kick that
>> maintenance burden over to whoever decided they'd rely on undocumented
>> shellscript functions git was shipping.
>> In these cases they can rather easily use the documented GIT_PAGER
>> environment variable directly,=20
>
> No, they need to know to call 'git var GIT_PAGER' rather than using
> the environment variable directly to pick up core.pager[...]

Sorry, I should have said "...directly via git var GIT_PAGER". I also
see that we could improve some of the doc cross-referencing here,
i.e. "git help git") doesn't make this explicit or point to "git var",
but we cover this in "git help var" itself.

> [...]should be checking whether stdout is a tty. That is why this function
> existed and we didn't just check the value of GIT_PAGER in our scripts

For a hypothetical out-of-tree user is this really something anyone
strictly needs? It's just an optimization. If you don't do it you'll
just use your pager to pipe output to a non-tty.

>> and their own invocation of "git rev-parse" for peel_committish().
>
> The reason the function exists is that you cannot just call 'git
> rev-parse $OID^{commit}' if $OID starts with :/

Sure, but is the answer to that & the pager case above that we need to
support an always-undocumented function that someone could only have
found via source spelunking, as opposed to them maintaining that case,
or submitting a patch to "git rev-parse" to make their use-case easier?

> I'm not sure what the maintenance burden of keeping these functions is
> that makes it worth removing them

I was hoping that we could head towards just entirely removing
git-sh-setup in the near-ish future, but per the evolution of this
series it seems that we've got out-of-tree users for its *documented*
functions, so we can't simply do that.

I would like to be able to rip out the shellscript support for i18n
sooner than later, I think a way to get there would be to only emit
strings in the C locale from these remaining git-sh-setup functions, and
eventually move that script to live in contrib/ or something (and be
able to install it). I.e. make it a backwards-compatability-only
interface.

So yes, the maintenance burden of any two functions being removed here
is trivial and we could just keep them around.

I'm pursuing this because I'd really like to get clarity on where
exactly we're drawing the line with this git-sh-setup interface, since
we can anticipate a near-future where our own remaining user won't use
it anymore (or the 1-2 things they do can be moved to
git-filter-branch.sh or whatever).

The burden of that *is* non-trivial. I.e. us having to project gettext
to shellscript land, which in turn is something that's kept me from
improving git's i18n interface, i.e. provide some light alternative to
it that won't require libintl, as long as I've got to support that sort
of thing in shellscript land...

Do you have out-of-tree uses of git_pager(), or do we know about anyone
who does? I understand the argument that we've documented certain things
in git-sh-setup for years, but needing to support what's amounted to an
undocumented internal implementation detail seems like it's going too
far.
