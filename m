Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9950AC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiCAT0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiCAT0s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:26:48 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEDD140CC
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:26:01 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p15so33531458ejc.7
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 11:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FS+ephoBroEedofWBNnRg0DI48qbXZrHkfZ6ieUyrrE=;
        b=aufXbLrZP2iMzKxDrptIQn+LoZ+yTFKwJz800KgYbaUDxCiM9k1o4fh1JB7qMfZ1pM
         0gU31EAICfWsfFL+7sP6abLSufMqs1lYpcgwSmHRsBiMnNfDJ/tYr6o9CBRKS/trUmWC
         tnoQcoZL6ovsbAG8V4TvQO7U6K9Fex7ZAbfmn5wJ4b7h41LeNfIPVW5GTh6LlSjza9q3
         UThkT6o26+XVRo/h+UhvP1LBrDG6kDznJXeXEwqsimjUwzB07/DBxa9H91gkF1ADZne0
         SmYuqDZpbidQ9224RJt8nKMfNpSS1oABJAYJJ1cOtXIA730fMVYXB+tJwKxwHYRS24yX
         GUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FS+ephoBroEedofWBNnRg0DI48qbXZrHkfZ6ieUyrrE=;
        b=LRNzme7Mfaed6TZyRVFiZzqM/5w4IxE7atF4UtKv0degkyXpsWhvrUCDs2g/GGBKsc
         AF+aT0dCzYUIa19EOHu53+9EgXBjKNyGr4Fq8JDd1240GDuG9+qhr0xi6qpr8vljAeXd
         N+8wJd6Y4nzBa/VqJUQydqRKYxobFZSq93NQThyLuYjpowuuSkiI0qHEHtgKnIoOuJlP
         c5X8rnAfpPDSwC4yh6aL2v86kB8qkZiBTfIan6dM0xhqucYKpPupkzCuUK+sARD6eeOZ
         AJ7r2gaxTh2uS+dBZeFLfnSn2Z3V1N4alsS/crDNeQrKV1n5ZNNoJ+qnNHVhKCmbZs/r
         W9sA==
X-Gm-Message-State: AOAM532o+DcIb5/GbHlJx8GN9vZblPpF2SWr6K7/Qy94Ut2ISwvPerJv
        3gEkvWgGNDuOasbhazK1zuYeJYVocNSoeWYyByXi2A==
X-Google-Smtp-Source: ABdhPJwzW/7yGOLPaJimGP5XOsFCDJ+y3nlnV8kJLeq4EZN17tRWXiZkLvabW0B0YCnVC0VRB0WcX07ZCcP/3Ahrdxc=
X-Received: by 2002:a17:907:7613:b0:6d0:ee20:8a37 with SMTP id
 jx19-20020a170907761300b006d0ee208a37mr19800870ejc.316.1646162759854; Tue, 01
 Mar 2022 11:25:59 -0800 (PST)
MIME-Version: 1.0
References: <xmqqee3q73e1.fsf@gitster.g> <CAPMMpojgTcp7qGmpK0vm8_WTOaSJ6r=NBa3sEO0EC7XRBF_dXg@mail.gmail.com>
 <220228.8635k35chr.gmgdl@evledraar.gmail.com> <CAPMMpohJsZahwzhstoqxPZz=UbJ_7+vrUQZbk0DOrGFJ4Xq-nw@mail.gmail.com>
 <xmqqfso1r1hp.fsf@gitster.g>
In-Reply-To: <xmqqfso1r1hp.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 1 Mar 2022 20:25:49 +0100
Message-ID: <CAPMMpoiexaYigvko1cD=qZAbdrso06Ck+T=j4Ai68qSaKkXVrA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2022, #07; Fri, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hmm, does this work, or still too long?

   The performance of the "untracked cache" feature is improved when
   "status.showUntrackedFiles" is configured to "all", unless
   "--untracked-files=3Dnormal" is also specified, in which case it is
   degraded. This change targets -uall users, who can now configure
   to benefit from untracked cache.

Side-note: your reaction wrt agreement on "thought not to matter"
makes me think maybe making this behavior fully optional, dependent on
a *new* config value, would be better? I've assumed adding more config
would be frowned upon, but maybe the reduction in risk to a specific
possibly-existing usage pattern makes it worthwhile?

I'm thinking a config value like "status.optimizeUntrackedCacheFor"
with values "normal" and "auto", where the current effective default
is "normal", and users who need "-uall" to work can set "auto" (for
the behavior as I proposed/implemented it so far). Would the increase
in complexity be warranted by the reduction in risk and corresponding
reduction in need for explanation? The resulting topic summary could
be:

   New option to support/optimize untracked cache for
   "status.showUntrackedFiles=3Dall".

On Tue, Mar 1, 2022 at 7:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tao Klerks <tao@klerks.biz> writes:
>
> > On Mon, Feb 28, 2022 at 2:47 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >>
> >>
> >> Perhaps something like this:
> >>
> >>     The performance of the "untracked cache" feature has been improved=
 in
> >>     common cases where "--untracked-files=3D<mode>" and
> >>     "status.showUntrackedFiles" were combined. This change benefits Wi=
ndows
> >>     users using it in conjuction with the "fsmonitor feature in partic=
ular.
> >>
> >> Perhaps adding:
> >>
> >>     There's an obscure case where the performance is now worse, but it=
's
> >>     thought not to matter.
> >>
> >
> > I really like it, thx! I would change "combined" to "aligned", and litt=
le else:
> >
> >    The performance of the "untracked cache" feature has been improved i=
n
> >    common cases where "--untracked-files=3D<mode>" and
> >    "status.showUntrackedFiles" were aligned. This change benefits Windo=
ws
> >    users using it in conjunction with the "fsmonitor" feature in partic=
ular.
> >    There's an obscure case where the performance is now worse, but it's
> >    thought not to matter.
>
> Overly long for a topic summary, with value judgements that I'd
> prefer to omit.  What (you think) is "common" does not help us make
> a stronger case.  I've never said I agree "it's thought not to
> matter" at all.  Just stick to the known facts.
>
