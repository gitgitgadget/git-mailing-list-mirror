Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8884EC433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D54D221FE
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbhANUpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:45:36 -0500
Received: from mail.pdinc.us ([67.90.184.27]:48922 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbhANUpg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 15:45:36 -0500
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id 10EKinmk022001
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 14 Jan 2021 15:44:49 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us 10EKinmk022001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1610657089; bh=WXN1e2Kk6heDJW//ojMhJC/u1WdgDS/bjTb5gw5tLv0=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=gvMie1T7WMYna4lFb+cKl6AyX8LWJxv+W/FhB7nikRs/qYTUjORxMLJ7aOciTYUrO
         Pa3Vvru5Pr3HHnOMpNCI7o8DVNPMBjqCWy6509j//2MV5zLz6ifJkja07TQexsEm3g
         JVWVQgsyYnNRLNcBSMDQwkfsi7WzNzPGRLbBMT1MID3TRboAFo8MtXex1dsVGDMEIo
         xZQ8739tMfhDZID3RQuTJD+auazPyEtMOCB4kEKdAlFybMY9z2vPl/M6bRBXRjbMiq
         luVWXU9ygbRYttP0No2wHuTCd5pQNWm4luMkgluwNVh5zRuaIJgSKx0oQ2Qi6Gb448
         gY/JYNzdJmH+Q==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "Kyle Marek" <kmarek@pdinc.us>
Cc:     "'Philippe Blain'" <levraiphilippeblain@gmail.com>,
        <git@vger.kernel.org>
References: <191201d6eaa3$4b585fa0$e2091ee0$@pdinc.us> <abc900c1-16cc-4ad4-4be3-c405924215cd@gmail.com>
In-Reply-To: <abc900c1-16cc-4ad4-4be3-c405924215cd@gmail.com>
Subject: RE: add a blank line when a commit has no parent in log output?
Date:   Thu, 14 Jan 2021 15:44:59 -0500
Organization: PD Inc
Message-ID: <196101d6eab6$20714550$6153cff0$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQLyoqkxuguiuq+K1VGd5vltUHBL9QIgpRLqp98fmwA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle:

Need you to whip up a patch (back port it to current Cygwin git too), =
see below. It will help with cleaning up Cresaptown branches. Or if you =
think Watson can do it, give it to him.

> -----Original Message-----
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> Sent: Thursday, January 14, 2021 2:29 PM
> To: git@vger.kernel.org; Jason Pyeron <jpyeron@pdinc.us>
> Subject: Re: add a blank line when a commit has no parent in log =
output?
>=20
> Hi Jason,
>=20
> Le 2021-01-14 =C3=A0 13:30, Jason Pyeron a =C3=A9crit :
> > Take this git log --format=3D"%C(auto) %h% ad%d% s%C(green)% aE" =
--graph --date=3Dshort
> >
> > | | | *  5505e019c2 2014-07-09 initial xxxxxx@xxxx
> > | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) =
Added defau
> > | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from =
f7daf088)
> >
> > One might assume 5505e019c2 and 3e658f4085 are related. But git =
cat-file -p 5505e019c2
> > tree 546c6b71f01e7fd086c8adb832518240b71a9075
> > author sam swindell <xxxxxx@xxxx> 1404878701 -0400
> > committer sam swindell <xxxxxx@xxxx> 1404878701 -0400
> >
> > initial
> >
> >
> > Is there a way to have it look like:
> >
> > | | | *  5505e019c2 2014-07-09 initial xxxxxx@xxxx
> > | | |
> > | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) =
Added defau
> > | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from =
f7daf088)
> >
> > Or
> >
> > | | | #  5505e019c2 2014-07-09 initial xxxxxx@xxxx
> > | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) =
Added defau
> > | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from =
f7daf088)
> >
>=20
> If you remove '--graph', then you can add '--show-linear-break' [1]. =
Unfortunately
> these two options do not work together. I think your suggestion to =
have the '*'
> be changed to '#' for root commit is a great idea.

Patch description

When --graph is used

--show-linear-break converts the * to a #

--show-linear-break=3Dx converts the * to a x

>=20
> In the mean time, I use this trick:
>=20
>      git log --date=3Dshort --format=3D'%C(auto) %h% [%<(2,trunc)%p] =
ad%d% s%C(green)% aE'
>=20
> This adds the abbreviated parent hashes (%p) but truncated to 2 =
characters ([2], [3]). So
> the brackets will be empty for root commits.
>=20
> Cheers,
>=20
> Philippe.
>=20
>=20
> [1] =
https://git-scm.com/docs/git-log#Documentation/git-log.txt---show-linear-=
breakltbarriergt
> [2] https://git-scm.com/docs/git-log#Documentation/git-log.txt-empem
> [3] =
https://git-scm.com/docs/git-log#Documentation/git-log.txt-emltltNgttrunc=
ltruncmtruncem

