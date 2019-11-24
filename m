Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351EAC432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 21:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006EA20748
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 21:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DJ23htdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKXVaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 16:30:03 -0500
Received: from mout.gmx.net ([212.227.17.21]:51929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfKXVaC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 16:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574630991;
        bh=dc7SxvB8rpW80rbXjYM/fgM4mTr7NRj2ZW76xxlcwyw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DJ23htdrZO4ubn1rKp+7yH7ejeD3O1imbBrHoxBQ/Rg+pV+EDwccCwXfjAGXtLq0d
         RgoZXdclOe4WIrFkdPlxB09jsrTkpmf7bbfQkXWhsW/C3HocYoQpwHLtD6z89NxlzM
         BZCBGspBHvhPHcxlj1TCjnxAv3hasZRxBUGbG2lo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72sJ-1iTCYj2f2F-008ZsB; Sun, 24
 Nov 2019 22:29:51 +0100
Date:   Sun, 24 Nov 2019 22:29:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] git-svn: drop support for `--preserve-merges`
In-Reply-To: <20191123220850.GA29423@dcvr>
Message-ID: <nycvar.QRO.7.76.6.1911242224400.31080@tvgsbejvaqbjf.bet>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com> <b7ba83969da8fd2db4e6074d5044938c05b992fd.1574542243.git.gitgitgadget@gmail.com> <20191123220850.GA29423@dcvr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:D9ZaeDhdArZZ+YdcfpqD/5mRPrwgDfDUbWotLQ+s3GVYLYIjNqG
 V8gg1tg7rA8u/EExKdIpkvyDt39yDoZzmz38JHhpsibwHUVXE6f5sqegOjqW7x2pTkotd42
 LSNp0oAv+Rbd/FzAQzpFLLS7oHNaYcOK6MoUthyi7/FlKmY21RqKM2fq5WGgYDltTgXUdGg
 E8tuGWHjBcYeZRSbk4NxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fe+hjejrVUY=:KsHWINzjQimk5HnHpiIYo7
 gjL0FHlb4IJCsWs9VLi95Y9os1jbohy90PG1pGvnhJhW3p9LE2L21/riNu41Ha+H1a5MD0v9T
 fuPn1sDhoMcmk6tB+I4WXrigoxNG1Q0sUVHBR78Kj5GAoOcxydrilUrPPeoGcIS4KewIqIMwc
 wY/V7HDBGaJbri3Gx4KoGDGgOfIZeHzkikX0/oftqfULBoJEsjxpO1OzO68IkoQd4B1bg/KVq
 OBYYc9U6bBtviwkN08+Y2aEGPiTVasjYvtkmPVDD6NSV2rB9y97SlV69pglKb8KrKn/rTleAx
 AfnCGqETv4rL2ipqv9u06xqFRtUAYhUBb4dvEb1fSSPa9qqCMhm33RlpBTgTTkZk8oeQzQK4p
 KiB1oXZDPedFPUZDvAzOYlRbgH3UIbNlJDlV5iiaWyMesSo3iE60SEARdwVNsUqW5PdWylVaj
 pDQ5LK21kJcAxM+enFtVzf4W5YtM9yQ2g3tJog065C9atddl+r6J1hFRQFHQJoPU6pY4YXp3H
 GKVKxn3BBGWCpVlUvAqR34HpPxzE5U6ECmm9vqBBUu48fZD4taQR9qxLHqSsFMbRrTv3aAq6p
 GP+3rNa4XWHbjkypkVBHtDbK/ky5Xoxt53ybLJcjn9rAUxJCeJ1ZesloaQ3xCSvROPJTv77dU
 6Czc9b8RFw9XTHOx4iCLD//d57Hon5eVAmhKPkpVynDBTsEa/Ek74DdXlVuhOa02lr/Lu7f47
 UonNRV7W9fqCBaWOxaQp33A6BR35h+/WsJCtzm44XgKdTkrOzABc/9HpoYRQP+d8fTMnOOUjq
 Z+phX0sF5eCGx6cVJWcxlfGF7e6QHsx10yZNMiVDlzI2lh/s7EKJE06C0U2WOaAli+sQkwH+z
 l9NdUKShZFDhovMoDswHl1O7ggfsoF9q9OUAn+z8Z8oelx27yJrmHxAv5eaYq0MSf++tMbavm
 yfnd0ke6fj6+I3k8fuz/XpwvvgPSK7vvfVZyAxj8TFXXsg9aabHD0ENhtqEMMp6OZPOUbq8l4
 PQQfDsmsFHDRcN8pH0JEWE/JiTaB0irNRff9Yg8/yAdgfjDyX94GBMJHXNzn3GYNI5lbnzDIM
 X7vOjc49T2THjTNsLSx479cpt/c/mPI3UbtG4acrgGfq9bJBnoRtQbNPqPxuzVSEmv78tvdQX
 wp7s856gdqx45befKU7b3LXuSZ7kuqKCZtnNkhdEQ+shSBq5mUXz10/k7KFr+5XPvDjfbHY+s
 m5zX+zFu28eUdWMMn4J8EiGylpJclByoUmh1aiByFbC6f7Nmi6mYbXjm3o4U=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sat, 23 Nov 2019, Eric Wong wrote:

> Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> > We already passed the `--rebase-merges` option to `git rebase` instead=
,
> > now we make this move permanent.
>
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 4aa208ff5f..f1fa1bc7f7 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -271,7 +271,6 @@ sub _req_svn {
> >  			  'fetch-all|all' =3D> \$_fetch_all,
> >  			  'dry-run|n' =3D> \$_dry_run,
> >  			  'rebase-merges|p' =3D> \$_rebase_merges,
> > -			  'preserve-merges|p' =3D> \$_rebase_merges,
> >  			  %fc_opts } ],
> >  	'commit-diff' =3D> [ \&cmd_commit_diff,
> >  	                   'Commit a diff between two trees',
>
> Nack, it breaks existing usages.   Why the urgency with removal?

Which urgency? The cover letter spells it out quite clearly that this is
not even intended for v2.25.0, which is still over 2 months out.

The reason I submitted this patch series now is so that we can avoid
inadvertent new users of the `--preserve-merges` backend.

> I don't know a whole lot about this rebase feature in
> particular, but deprecation periods should be measured in years
> or even decades because of LTS distros.  Not months, especially
> for things which have been around for a long while.

The LTS distros will not even pick up this patch. So that's a red herring.

But yes, you're right, v2.25.0 will probably be the first version to even
have the `--rebase-merges` option in `git svn`, and therefore v2.26.0
would be awfully early a time to drop `--preserve-merges` in `git svn`.
Question is whether we want to split this patch series, or just rather
wait with merging it to `master` until a year from now, or something like
that?

Ciao,
Dscho
