Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B783CC8300F
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 11:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118A62085B
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 11:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ffimts4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgK3L1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 06:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgK3L1q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 06:27:46 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4894BC0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 03:27:00 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id y132so1319181vsy.6
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 03:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TebFaaOglbHPLF0QTjPYwY95Optwow+3zVOP+HJLWcI=;
        b=Ffimts4p9KGIQvJR+bOoBCTYdeecLmQMFfZfbhsOZKjhz6ddD8ybLR19P8gky3OtPf
         Du8eorZ0XME4cXdQRBZXKwsT5tUNbvkJ0jCyDVGL9OMmOqIm3+pelC68f4I3yyzoipNN
         9iXIZ7s1LExatrgt3qMv/M+Kk1r/DVFCLt42Xw07QLG9iPSQw/rUBgY5GQMAdEB7B4S4
         w8y5iMAXJgyeIdLIEYpl+66JXRO0cB4g/AIIyz5btEISrahACvyPJexLIEWd/5PgRcHx
         pYSj/0j7MmnfMZmyw08SoVHKvxAjKPa/G/zFmgdbDZTYPMzvGYw7eSYyk07Zjc0uhvCJ
         bzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TebFaaOglbHPLF0QTjPYwY95Optwow+3zVOP+HJLWcI=;
        b=bIeeu/FxNq/gpaw2i/wBEM9pPGErkCTUXe/4xkBNnKn3tXJb4S8h05FcE1np5FldMQ
         ewttsTYu4vsGMUusIHgldfqp+qrsWgO7MUheVDhI3YY9ReXFcYrx8Phg1BuUoTkK50m6
         +kCHgSzPgDQGMid97xMq6vWhHOj/SV2bmPWomAYkkQl6aqmp3DOh5EomtOVE3+KaB0LI
         Z85cDOVo53CyhZ7eaW+3NBduVmm0rt655RTZ5HahECEp1VrFlsdEAPIpIPwK3YzNKbnO
         KhDImWSpND2ZHUgeGgK0Pr/9iHgyrZLEvjE+yyYWkftytGJEnbJS6k79DUK05Q5oAekS
         +o/Q==
X-Gm-Message-State: AOAM532a14N2zqJdhpxlekRyCUn379axdzbC4ukXMlFQmIMEh0SJ28mQ
        oyfu0rBxFOMYzY5tL612NAlNPMmxBT1uTfw8bbFN8Q==
X-Google-Smtp-Source: ABdhPJzoSDKF691aUxwYnG638ifSfBSGe4nNb46TUNRdLsQPxAGVJKOC4cuyNgc84ZPhVyNjxs7dJZazofyq3jNqb/c=
X-Received: by 2002:a05:6102:154:: with SMTP id a20mr14267914vsr.50.1606735619266;
 Mon, 30 Nov 2020 03:26:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <91c3ac2449edc45db643b0ba6cba66ef31176600.1606419752.git.gitgitgadget@gmail.com>
 <87lfennln8.fsf@evledraar.gmail.com>
In-Reply-To: <87lfennln8.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 30 Nov 2020 12:26:47 +0100
Message-ID: <CAFQ2z_NEkJQM6xtppW9kkAyjFrBeEiXmhhiPB8A7pmssjXHhKg@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] reftable: add LICENSE
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 27, 2020 at 11:23 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Nov 26 2020, Han-Wen Nienhuys via GitGitGadget wrote:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > TODO: relicense?
>
> On the topics of TODOs, it would be nice to have an answer/some idea the
> "I am concerned..." question in about
> https://lore.kernel.org/git/873625i9tc.fsf@evledraar.gmail.com/ relevant
> to the license etc.


Long term objective is for this to live in git proper, but remains
independently compilable, so it can be used by libgit2 as well.

This is achieved by having the code only depend on functions in
strbuf.h and git-compat-util.h.

I would like to enforce the separation by having an actual standalone
compile, but the discussion over the code to do so has caused more
heat than light, so I have deferred this by reworking standalone code
to to be on file level, and only importing the non-standalone code. In
one of the other patches, you found a place where I had overlooked a
REFTABLE_STANDALONE #ifdef; I'll remove that. I'll also remove the
update.sh script.

Until the reftable code is actually merged into git, I work on the
reftable library itself at github.com/google/reftable. I've asked our
opensource team if we could switch off the CLA enforcement for this
repo, to facilitate back & forth imports of fixes.

The current version of the patchseries mainly addresses overall
feedback from the Git team at Google to split the public API along
commits too, and updates the series so it applies to master again.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
