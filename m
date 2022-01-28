Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAC9C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 10:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245062AbiA1KOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 05:14:08 -0500
Received: from mout.gmx.net ([212.227.17.21]:42651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241773AbiA1KOG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 05:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643364840;
        bh=C/5JQA4U7sw8wdQOkUr4xUDhCIgo/aDtPEy/zV7p9x8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CUjmW05vjnwbQ38mY6kTRAj1AZDFHsiuhu/zl+gtiz5c/NzBeOzte6j1i+wefLH0U
         wmUewzGlcI7CYMQFhl4ajAmaSuqBqg33PeXvkpz0sHSm4qv2BhT3XBhlmAEb8Wda7J
         qY2KK49bz5vCgSGkezJBSrMio7YoLhEz71u6tVJs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1nC2p82xDR-0084qK; Fri, 28
 Jan 2022 11:13:59 +0100
Date:   Fri, 28 Jan 2022 11:13:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] fetch --prune: exit with error if pruning fails
In-Reply-To: <xmqqmtjh0x5f.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2201281110050.347@tvgsbejvaqbjf.bet>
References: <20220127153714.1190894-1-t.gummerer@gmail.com> <xmqqmtjh0x5f.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3xpXVeJpyDv8XVu9YLa3Otf8poR4VhYDPKYXxfy2Cg0gSC0/AMe
 jJNOseBKf17cegIMNoZiDyCjbOo3kBvh3Hgyj8kcFoaAQbNWdWipqcmiMua5P63hxiCsLn/
 htlKfGjDqugam7qOZtizYC8JVjE7Yv/jD5DslLhLv6gzdVmUQURyto7L1ebANCRsR5LJSWd
 7Fkaxhzs8SL1KrU7Z6oYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C6S8l19RHqI=:XWJDw8RLXwXoUDMovmj+C8
 ikXvDVUEoBXsdGsBohUsNUGeLInniArFB89p4Fmc/zhXMVDdUGH03JiuKk2BJzJCYHMvGl2mu
 3WuG0P56igTOYX2aYrVZHKsQaujLP2gn75e379iZA0Ey0LXUzjcC8NldKA1Cg/8MnpkbORx+A
 6Qwo3lsgQLyc+4fLrwDO2OZ86qXYnPgjXvp52hXH1jR8WSyp+PDFwPOL7qj04B3YkuYsR57mX
 zjL8l8VKj3LkXjcCpD4Ij9Qq/fQoTEh0oL1N1VOCnlvp54eMMQxd6R6TYalKH76okqpUgi8hA
 Nx7YTmHmKIbzWo4pLuzsYqjxhlRDdaphFiMCnb107NCAbOfMK7+3v9YAJ+p2Afak1Fod1YpMz
 LqqeEqhuR4nPo8LFEE/yPqrJP70FwEd4c16uP9oKW6XcpMD2ytwwDnq7bUMJJfXIP4GASA1J5
 L53xT25lwC2KpfKC3ydK43rEshwAahye007Pe8/SFIRv9DA1TDu3KzXQKIIPwRCtelqyWaCBC
 26OXmFBXahZKeNXTbF0HXyjaXcX/hD+BznS/b/2hbbn1dTHIqK0d0sfxyO4Lh/ShXUHB8a8kU
 dKmWeB9KBmYONd2OxpIENYi/kD/8Lvgo2uEmgjodi70uj9Ul46lxcqFn7JCiDrVDr6NvOtfh3
 du/BAq+RQ18kVIXtz5/WyYNHo4zC5JeZM7xpCfhHQ2DUuobfkb3h8wqfoOZ5/tbRJljREJQ3u
 GHqMvhbzKERuBY+0o0Sl35KJ1jIu46EjuG+hnl+IKrSm5QgOxhR57bpmV+YvisSSoyO21/WFJ
 871CExJd3KLJR2/oLi/MMc3qvBR+K7y9OAf08tsKI1TwpvGwJwjNBlU8hXdjy0ZOLfbtA3fvw
 OKyal63rTAAF2l0h0H0h6KRaTgRiAJ08Cxf340hVDFf46rLFe55TdVLNHUQ+0R/hri0kG5ggQ
 Gssnto9poXPscK/EHmaJD4KIqGEtfI3z3DmFTJ2dRalMMNsvIlSJyjcWgYMWWqpC/Y0x7I1NO
 cH/D3jfNMC2BR1I5YFbKA1tiMzT2et1F2Ws5zfD1YxmXLx5seRNqzbQVq3IiOfTJT3O/EEoT8
 KDalYiSTbA56Lk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 27 Jan 2022, Junio C Hamano wrote:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > +		if (retcode) {
> > +			free_refs(ref_map);
> > +			goto cleanup;
> >  		}
>
> This part is iffy.  We tried to prune refs, we may have removed some
> of the refs missing from the other side but we may still have some
> other refs that are missing from the other side due to the failure
> we noticed.
>
> Is it sensible to abort the fetching?  I am undecided, but without
> further input, my gut reaction is that it is safe and may even be
> better to treat this as a soft error and try to go closer to where
> the user wanted to go as much as possible by continuing to fetch
> from the other side, given that we have already paid for the cost of
> discovering the refs from the other side.

I am not so sure. When pruning failed, there may very well be directories
or files in the way of fetching the refs as desired. And it might be even
worse if pruning failed _without_ the fetch failing afterwards: the user
specifically asked for stale refs to be cleaned up, the command succeeded,
but did not do what the user asked for.

Maybe Thomas has an even stronger argument in favor of erroring out. In
any case, I don't think that `--prune` should be a "best effort, otherwise
just shrug" option. If we wanted that, we could introduce
`--prune-best-effort` or some such...

Ciao,
Dscho
