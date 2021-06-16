Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD56C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 08:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE786115C
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 08:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhFPIFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 04:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhFPIFT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 04:05:19 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BFDC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 01:03:13 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id c13so1605484oib.13
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2owUZ2990lpbhuOOYTzKVQT2qTHp2jciw5aFG4BJc3I=;
        b=lW56+520TxidSJYpMF47qjwNOcH9j7gyBPByqLxfdMvttaiDsRQBRte8vnj2315JbV
         qaQZHtGs/AkcQj5UtuUu0AVv3ovKoNHSMFtdtEO+M+SB/REuUc+Nho9MevkAzcUxf97a
         Iwks4j2u9tsuWYmN47j7EB5Gw8gLEfvPzFNXgatMskdStrrTPjLb8cUZEEyrRkROqV8W
         SGZdqAu7yKWA7Z1hxIjgIsxuGZ8iGU5b25T5FEAB7XfRSHxsGIdN1sYSokQEvEMs9vPy
         nu7wyvkMXhGej0FHUePscTmeLTx6rW0MA+iByEGvQGUnMTfC7gUYk8ALvWpLgBs+PDrF
         WDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2owUZ2990lpbhuOOYTzKVQT2qTHp2jciw5aFG4BJc3I=;
        b=LqMGLzEbR3ptkP8AnzUO693qyygAXJlC5D5eO22K7eOBKuYSA9dM05ZudNzUEz8iID
         ASt6VREDc5MUPpY1yrPIxJGNkk6GHZIYxwIPLpgIummrc5/yj9QUrhOdgay+f1sfE8D1
         jMeGTXq3bqSkhGYT8CgmpinuqTC1I0nvK1W6eslcF290BhMQHpmDMSW3i8Ky4kggpU9A
         6MmnPTLUoVZecD1AK1O6GERGr2s/7EQ0KRV3vmtFzT5paNdrATEVrqZQi8aeugD8CNZ4
         iSuF6qkT1G1U5ERmfkyty7rbvzadI1tKAoMQIZ3GLfeoOeAdxq1nbPVQrJqaofTlPew/
         J+Jw==
X-Gm-Message-State: AOAM532a8OzSgG3pWJSjfRg1cG5Cw5R15NJc4HWfpfknn5RRJogOZqKX
        QGCg8HREeEIXo2kSkc69vgP027u+04EW3eh+Brc=
X-Google-Smtp-Source: ABdhPJwcXaGPMtP+UjWwEyYE60GXgswEDCkixEPrPAkDoxIOIrSaA2SouvDLTEJMnEtn8C4YygZaEV+nGCD5h1f/9RM=
X-Received: by 2002:aca:4e92:: with SMTP id c140mr6009968oib.39.1623830593385;
 Wed, 16 Jun 2021 01:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.912.git.git.1623785914202.gitgitgadget@gmail.com> <xmqqy2baqvxv.fsf@gitster.g>
In-Reply-To: <xmqqy2baqvxv.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Jun 2021 01:03:02 -0700
Message-ID: <CABPp-BFiD5eYNXsRk=f-5k4oDeCHBW7_pd8iqYYBKsrd6evC9g@mail.gmail.com>
Subject: Re: [PATCH] Add config variable besides env variable to squelch
 "do-not-use" warning.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Daniel_H=C3=B6pfl_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Daniel_H=C3=B6pfl?= <github@hoepfl.de>,
        =?UTF-8?Q?Daniel_H=C3=B6pfl?= <daniel@hoepfl.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 15, 2021 at 9:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Daniel H=C3=B6pfl via GitGitGadget"  <gitgitgadget@gmail.com> writes:
>
> > From: =3D?UTF-8?q?Daniel=3D20H=3DC3=3DB6pfl?=3D <daniel@hoepfl.de>
> >
> > In addition to the environment variable FILTER_BRANCH_SQUELCH_WARNING,
> > the git config filter-branch.squelchWarning is checked to see if the
> > usage warning should be squelched.
>
> Thanks for trying to improve the system.
>
> A configuration variable that is used to squelch warning messages
> related to migration and transition typically lives under advice.*
> hierarchy, so something ike "advice.weanOffOfFilterBranch" may be a
> more appropriate name for this new knob.
>
> Having said that.
>
> As this message with environment as an escape hatch was added as a
> way to strongly discourage users from keep using the command, I am
> fairly negative to a change that adds yet another way to make it
> easier to keep using it.
>
> Elijah, who did 9df53c5d (Recommend git-filter-repo instead of
> git-filter-branch, 2019-09-04), added to CC list for input.

Yeah, I generally would like to discourage it but...

Back when we put this strong discouragement and escape hatch in, I
wasn't aware of anything that could be done in filter-branch that was
hard to do in filter-repo.  However, since then, a user reported they
wanted to re-sign commits after a rewrite.  Since fast-import does not
(currently) provide a way to sign commits, and filter-repo is built on
top of fast-export and fast-import, this makes it rather difficult for
filter-repo to do.  (I think it still can, given all the shenanigans I
did to create filter-branch-ish as a rewrite of filter-branch on top
of filter-repo, but that comes with nearly all the same caveats as
filter-branch if used directly, and is a huge amount of code to lift
to try to use outside of filter-branch-ish.)

Since there's a valid use for filter-branch (even if rare) that isn't
readily done in filter-repo, adding the option Daniel requests makes
sense.
