Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D67C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 13:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5C660F91
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 13:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbhHXNg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 09:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbhHXNg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 09:36:58 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1227C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 06:36:13 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id q70so24915439ybg.11
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 06:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WH2mRgS4o5c1io6h3qSvZealccfbwJMsgKrtGfwtHg0=;
        b=f6b79GTaV8hOc94DgNRt4VhLldbdrNMEu0WoDiz3YTAIhLwcfSbLqg8dFhMR83n2k0
         vMYG/K9kf5vD49N9DWzLSgN0ajhXsn4GSMUquLaY6HNCJUitERpOOVS0AD3ELLrV2Mer
         wmdDmrWuK0nqG+NlFnQdg9m4Ih4eKJvwrvAoIJx81ln2jJr2UpOYajtED7k6tA4Aix2d
         4d5BJnWQ1atnYa2kRSqu9qoT95J5uZFN+rnHzE2yP5fwYaVYsVZniYWpX6h1+M+VRuYz
         P5H8uYbE9TT/Wy8L2rgWmfgJMCIMn8SQLXPdO5z3T+4Ueu6Vl/UfcGW+uPz3ZjVTs099
         07kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WH2mRgS4o5c1io6h3qSvZealccfbwJMsgKrtGfwtHg0=;
        b=lY0wa9Z8lRpnx9lmp8tEQHHFtDiAeXB1yYyMqF569ZVQsU5n6PjOIomXxu7y7aUqCi
         MuTO0ckWsnn1ut0WUIbH4emWVQS8kyTZG2jeqannhJDraw1G8uW6BdlFeJV3Y+F0oASH
         LR3aJiHtZiVEK88Fb/EQMVrdfk9c/D0VeLyIC1DBdyfeb6Pp02uL1nNQEoqW0tkYiQUt
         kumNvo8Pbxi9+Hb82h63agQB2VRBgMNVUTUS+J+YAlFEWYeCPveXNH0tGMXoaRHJwkB7
         eUGyxoILt0TQTL2Fdi8VzK43Fcp1OLckWNcLCojyZ+zwK2nixynhfjt5P26kjKO4pEOu
         mT4A==
X-Gm-Message-State: AOAM531aB9mc1OOxCKgvFxzifMSi8UDw04CtJYaboD9H68aRl/PARog9
        V7Ent0gI1lHe54KF9fE4a8s2NPZTxoaqCCPnuEg=
X-Google-Smtp-Source: ABdhPJwaH3r52C2GWrnkHAMnS8wVOnJqBVn9OstCXHvzMBnwjmWu62oz9btERm286G4J4FK2VNcuWFl6g39/m8TjpUM=
X-Received: by 2002:a25:444:: with SMTP id 65mr8856788ybe.520.1629812173274;
 Tue, 24 Aug 2021 06:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210822161325.22038-1-worldhello.net@gmail.com>
 <20210822161325.22038-2-worldhello.net@gmail.com> <nycvar.QRO.7.76.6.2108232232460.55@tvgsbejvaqbjf.bet>
 <xmqqsfyzq1wq.fsf@gitster.g>
In-Reply-To: <xmqqsfyzq1wq.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 24 Aug 2021 21:36:02 +0800
Message-ID: <CANYiYbHUB-1LTyqCU2eFdYB7rHYq8v-ZBtL7ZR2wERfZry8TqQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ci: new github-action for git-l10n code review
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 5:36 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> For a push event, it will scan commits one by one. If a commit does no=
t
> >> look like a l10n commit (no file in "po/" has been changed), it will
> >> immediately fail without checking for further commits. While for a
> >> pull_request event, all new introduced commits will be scanned.
> >>
> >> "git-po-helper" will generate two kinds of suggestions, errors and
> >> warnings. A l10n contributor should try to fix all the errors, and
> >> should pay attention to the warnings. All the errors and warnings will
> >> be reported in the last step of the l10n workflow as two message group=
s.
> >> For a pull_request event, will create additional comments in pull
> >> request to report the result.
> >
> > It is a good idea to automate this.
> >
> > I am a bit concerned that the `ci-config` approach, even if we use it i=
n
> > the Git project itself, is quite cumbersome to use, though. So I hope t=
hat
> > we can find an alternative solution.
> >
> > One such solution could be to make the `git-po-helper` job contingent o=
n
> > part of the repository name. For example:
> >
> >   git-po-helper:
> >     if: endsWith(github.repository, '/git-po')
> >     [...]
> >
> > would skip the job unless the target repository's name is `git-po`.
>
> Nice.
>
> Can this be made into a matter purely local to git-l10n/git-po
> repository and not git/git repository?  I am wondering if we can ee
> if the current repository is git-l10n/git-po or its fork and run it
> only if that is true.

I have read almost all the github documents on github actions, and
tried to find if I can use a local branch, such as "github-action" to
hold local github-actions, but no locky.

That is to say, the workflow file must be introduced to the master
branch of =E2=80=9Cgit-l10n/git-po=E2=80=9D. As "git-l10n/git-po" is a fork=
 of
"git/git", the new workflow should be part of "git/git", and provide a
way to disable it by default.

--
Jiang Xin
