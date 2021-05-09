Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B9BC433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 15:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300EE60FEB
	for <git@archiver.kernel.org>; Sun,  9 May 2021 15:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhEIP3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 11:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhEIP3L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 11:29:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D5BC061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 08:28:08 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q15so7289167pgg.12
        for <git@vger.kernel.org>; Sun, 09 May 2021 08:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KLO9qUyUziWBlH55G012vReQEVLqLnIAzoxVaML4+NU=;
        b=TtklaARdaJDXAxtqd+4ufu5gIOViNIepMw9Qf4jBDEpBH5XkHvLTn04J+WDQkVCaIX
         EexI5iNnEqO2szluhCPBbeq6rikGzva1jXP2WslS5nvqv317oEqjiEtdlm/uqLbDjXwJ
         xdNVRxFUr4+L7CWmaMibokCTG5k7AhQEKE2953s4IWMYcj+dhDx40ANAkxCT97sR2LYV
         OoJ2cEntd+gdI0vKazYYrF80YoRunjtd1nkX6/g3plovq9TRVpWb04xA7SbYigo+sPID
         j7oFOUuDvTs1SI0vI3VB9b6dkAy3aX2gw2ac4BiIjZFHWOOjjP1YpvQCza6ZeKQFwDwI
         409A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KLO9qUyUziWBlH55G012vReQEVLqLnIAzoxVaML4+NU=;
        b=IYM7pyCapbZqkl7hVHcMj0nBP9Op8HiR+ZNjDBDDuTnudRtxBJrmHguvHI1nR7/ztD
         FiMiuVStC9C0KcD+4nJx88RrtCgbufuU0z5z7mP9b6bNkypszylJatwUVfpLah6WliZ2
         P2g1MLToKogz11qN0+y9Ji1JZHrVL2DUvlowQ6vxXceK+DgLRH9r47cTYp+B8Vz3h42T
         a20uEHsuq459u1uJ3snw66r9NaqG9mjTNgSthOXSG2MoZKfiyz2V6WfTv+qVsQas+Ak/
         mx+7WlD/lEe2geCKVV+aJukM7MmtX9W9lkmHbrrZgHvidPlM0smR+Jze8aQDwzMadUqX
         gIRA==
X-Gm-Message-State: AOAM531xLcFfOBo6jhqjQ53ss86TaYc0LwB6nj0pOCZ1KDMRJxg1wVwG
        lFmz8wW59proFkrfCnZxqVzZ2el+1algV+iDj54=
X-Google-Smtp-Source: ABdhPJwyJ2SwgBR+4hheCA8RiHGrlAurTR+gmGyycJZIWBlq+lkL3T9JPPrskn2048dZh+UBCEzu4OKF+8/JBy+OdlQ=
X-Received: by 2002:a63:4c26:: with SMTP id z38mr21283885pga.415.1620574087915;
 Sun, 09 May 2021 08:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620551314.git.martin.agren@gmail.com> <3d06c3beee0299db369f1dd859b092d529bd6846.1620551314.git.martin.agren@gmail.com>
 <CAOLTT8R2ACJtcL7esLd8AiSu22Wn2hrdVTwub-HXc-eT_U2-+w@mail.gmail.com>
In-Reply-To: <CAOLTT8R2ACJtcL7esLd8AiSu22Wn2hrdVTwub-HXc-eT_U2-+w@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 9 May 2021 17:27:55 +0200
Message-ID: <CAN0heSqi9v3dGgGFSGB7J-17MJj9jOvMwC6x7pW1bRGwra5N2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] pretty-formats.txt: add missing space
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 9 May 2021 at 16:13, ZheNing Hu <adlternative@gmail.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=
=889=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=885:10=E5=86=99=E9=81=93=EF=
=BC=9A
> >
> > The description of "%ch" is missing a space after "human style", before
> > the parenthetical remark. This description was introduced in b722d4560e
> > ("pretty: provide human date format", 2021-04-25). That commit also
> > added "%ah", which does have the space already.

> > --- a/Documentation/pretty-formats.txt
> > +++ b/Documentation/pretty-formats.txt
> > @@ -208,7 +208,7 @@ The placeholders are:
> >  '%ci':: committer date, ISO 8601-like format
> >  '%cI':: committer date, strict ISO 8601 format
> >  '%cs':: committer date, short format (`YYYY-MM-DD`)
> > -'%ch':: committer date, human style(like the `--date=3Dhuman` option o=
f
> > +'%ch':: committer date, human style (like the `--date=3Dhuman` option =
of
> >         linkgit:git-rev-list[1])

> Sorry, but in here:[1], I have fixed this space missing error.
>
> Junio, this patch have not been merged to master?
>
> [1]: https://lore.kernel.org/git/pull.939.v4.git.1620056221874.gitgitgadg=
et@gmail.com/

Ah, thanks for the pointer. It looks like this was merged to "next" in
2320ad8fb0 ("Merge branch 'zh/pretty-date-human' into next", 2021-04-30), s=
o a
few days before you sent v4.

Junio probably missed v4 entirely, or he might have responded with somethin=
g
like "v3 is already in next, so please build incrementally on top of it".

Thanks for contributing this functionality. I quite like the "human" format=
.

Martin
