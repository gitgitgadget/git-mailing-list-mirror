Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE9CC2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8FB2063A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 22:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HlQ90Oyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDGWhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:37:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:56131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDGWhb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 18:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586299045;
        bh=XNWEm9e5zMXfnLXjK5CFyLjT3S3mcSYTt86c7KDJQBw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HlQ90OyukCTkf7ezph58z/UJbrAnghP+lsCZRcylp7L6RnwFVlRWnqbkT1zcspPu+
         mavPMrj4DwtvpSexncsY3U0gC2n/WW4SCvlvTAzNOyFp93lnbMebAW6GmXpxWba2cc
         zmft8iGDiZGR7eChuVUtzXuav3ZH/8GRNWapC16A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.75]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mplc7-1iwZqa1PDx-00qCwV; Wed, 08 Apr 2020 00:37:25 +0200
Date:   Wed, 8 Apr 2020 00:37:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Gevers <elbrus@debian.org>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH] sequencer: honor GIT_REFLOG_ACTION
In-Reply-To: <CABPp-BFXT1QkTLUFSAju2TwzVdSRjKSyLQYp2KaoW2+S2U8KJw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2004080037080.46@tvgsbejvaqbjf.bet>
References: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com> <b187cb5f-a6c8-2908-e3fd-e1210e6970e0@gmail.com> <CABPp-BE_mimSRg5wf0Yzn2s-dX=64ZS1jGszqwHzr3aju0bj=A@mail.gmail.com> <09397e37-a22b-5159-b760-bae238ae3ed6@gmail.com>
 <nycvar.QRO.7.76.6.2004071649190.46@tvgsbejvaqbjf.bet> <CABPp-BFXT1QkTLUFSAju2TwzVdSRjKSyLQYp2KaoW2+S2U8KJw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WxzBKVuyKvG6umPUM8F5nbTjQh5O4JvLwsKrbhsw0LDgdCx9lO2
 ZDtDhGIJ6kpwH1A4ULsfk9Wk/XtiMwTkV4o5AC0/6MvvHf6CvcoqZVpVwMcMzN8425GfQDv
 rS0qEOycCuEg61BFFubx+Svqji1S4YNzmVKSVEn38yRoDuu4R8SD48KfstPExhxY8Iw6+R9
 imX9UoK2Js9EudeI1Iylw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dM7CfKUTMG4=:EtWCxHfTjvihQaL54VWEN0
 HPi4gtobpCqrtmq4gOmyqjPVGwhUtD+GzUV9kzEQEl0nGwLzIBWrjwwcz3hWwVB43OIpeJ7LO
 jCNfhsDKWwTjLrp3SGk36/G4MU7jHh5OaQDxoJU2hjwtu2x/XP5neJEAA8SJJCDwGUP1fV5QY
 B3vjxtSZnPdlmnduNU0SPLurHaXnczluJevvgQGy+dueWnvuxy8E/R/tZp7DzUrzrEy8eLoqo
 lFJTkoZEMuTUcJ11o9ObAO4oflsm1TTRz+qwGnlN3AHgFXklOsCg65Kab+jyEyr+zmuKV4fdl
 YsOc9crbT8X2ySqx1gjCJCrJQ3DnDTe8+xWZoBGQDu8V3EBQCM6ZSedCddfCUlvk/bnyHCHdH
 uXUc53aeisrNDRw+6rNve1ElENjJy7Mnue7CavraFXZbB1s/wiSh8lXnaP0TZmAm5qx6d9ofG
 sFg2QIT33TeI75lrV2T3IzDwiajh+K3gcT9E3bxsuJkHu4DkDZFWfwukk4js8LIo5eDUMvOFI
 B7FATvJg6YKpEICTxhxtt6B7F/l7DqoRXbc6EEfGJZ4f+MSfW5wcgKzmuuMk6ItVY7l2Y+Z0j
 K15y0b8wtgNb2/0oWQFxOOA0zPeOsKK2YgNjFgzMuENQaFsIbznSQQES87b54twccH5KSFgCl
 9FYMznNx3teuYz8oWQAm9/X2N6oyQcdR/3K1HoJWcvhX43grFphZ9n0E9Wm16jhPaDoUfxj6q
 1tG3th86PXwi6BRpc+IDD9q+6Dii+tSNgGfh/0QZNR4tGwFj0ZbaxdIDFyABXpVzMqCBrkrhn
 6P7aeI1WcT8+oMEoQQnjA5qJ7w/GVGKPa4Z3FeicC7hoHVpL4Fap4JRVkDTe7eoekCRsV/9sr
 R7jgkyhswjyxSP2Ni7HFwUmqKZtC8DiEZtJWWg+yvNLO3GtWebIDrpXvDPAMFDUAbKWPG5poa
 RjxU9hJreQOljWZdki7Vhee7C4c+UAHG72I2bGRaD2McqyKGFXcK33PJRqJLmIn64jSe0Nmpv
 L/ZGaUzDd0+hAWIY2dWjfhLpcigu0dreAIJ/cHvN9Pgf3sknrMX+6lNiTOCx1CNLcEWaxQP2m
 FOWmGE6j6xfQgbad9kjowPyKuiaLjg9+j6UaQ1FerLehPEim5cHuGPFtPgcRUn7BOrC6DWLtD
 A/AqRxg1SmsOUgGnB9U0yvY8TSPNmMc/cPcdvEKk0IyEnM6cxbgE9FyeFRn4Y82e+lJhQ2b1/
 Sig4DZJWdFp1tw3Q+vDqHwzXanJ1IA8pcRIHgow==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 7 Apr 2020, Elijah Newren wrote:

> On Tue, Apr 7, 2020 at 7:50 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 2 Apr 2020, Phillip Wood wrote:
> >
> > > On 02/04/2020 18:01, Elijah Newren wrote:
> > > >
> > > > On Thu, Apr 2, 2020 at 2:25 AM Phillip Wood <phillip.wood123@gmail=
.com>
> > > > wrote:
> > > > >
> > > > > On 01/04/2020 21:31, Elijah Newren via GitGitGadget wrote:
> > > > >
> > > > > >        va_start(ap, fmt);
> > > > > >        strbuf_reset(&buf);
> > > > > > -     strbuf_addstr(&buf, action_name(opts));
> > > > > > +     strbuf_addstr(&buf, reflog_action ? reflog_action :
> > > > > > action_name(opts));
> > > > > >        if (sub_action)
> > > > > >                strbuf_addf(&buf, " (%s)", sub_action);
> > > > > >        if (fmt) {
> > > > > > @@ -3799,8 +3800,10 @@ static int pick_commits(struct reposito=
ry *r,
> > > > > >                        struct replay_opts *opts)
> > > > > >    {
> > > > > >        int res =3D 0, reschedule =3D 0;
> > > > > > +     char *prev_reflog_action;
> > > > > >
> > > > > >        setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
> > > > > > +     prev_reflog_action =3D xstrdup(getenv(GIT_REFLOG_ACTION)=
);
> > > > >
> > > > > I'm confused as to why saving the environment variable immediate=
ly after
> > > > > setting it works but the test shows it does - why doesn't this c=
lobber
> > > > > the value of GIT_REFLOG_ACTION set by the user?
> > > >
> > > > The third parameter, 0, means only set the environment variable if
> > > > it's not already set.
> > >
> > > Ah thanks, I thought I must be missing something fairly obvious but =
couldn't
> > > see what it was
> >
> > FWIW I was also about to comment on that. Maybe that warrants even a c=
ode
> > comment above the `prev_reflog_action`?
>
> Yeah, if it tripped you both up, I'll add such a comment to the code
> to help explain it.

Thank you!
Dscho
