Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAADCC33CB6
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 10:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20942082F
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 10:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dO1Pdks6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgAQKDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:03:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:46279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgAQKDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 05:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579255384;
        bh=0ylNcpXhtVr5XmN5PuU8F7KjlqyssB+4kpGT1Z8+OLY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dO1Pdks6ey3k/TowMDC7+4EF8R3LY7C5Rwu9exMlr1xHxqqUol8tOkcOxEBJHcOVA
         /xGm4AX4SnPOGFqWp9ZwPOhXhTo9m1rTVWVqi6HIBtA08zJmqPKC6k08zz2rhQPYLP
         IC7dhDBmnziZdm/z8hFAjbtRgut6niICTJwFxstw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlXA-1jKKhq142Y-00jn5a; Fri, 17
 Jan 2020 11:03:04 +0100
Date:   Fri, 17 Jan 2020 11:03:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] built-in add -i: do not try to `patch`/`diff` an
 empty list of files
In-Reply-To: <xmqqzhenf3t0.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001171101150.46@tvgsbejvaqbjf.bet>
References: <pull.528.git.1579163587.gitgitgadget@gmail.com> <353c748838d341bb325149234657c27215a9fab3.1579163587.git.gitgitgadget@gmail.com> <xmqqzhenf3t0.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5QIdUQc7qRtaiZw1J/VFAIldwsq/cVVnKc5vcGxAI4Dnqtt5PgY
 zCtoadzV8jx+suJ4vbafoE0NpLbIZ+b6FVRXKWXlGIV5Wjd8FGXmqX8ABu1wfd8u6fnQ747
 PVKqkPv7Y/gmLln06pBZD6Q6A3pOVzh7BLkCk1fUpa9Ebu2tBeI73toGnPyfM+thCjgvs4i
 6TvBnq3dO62mCyZThd6GA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4bEzImJXsbs=:3yUX1/RlT+Uviz+A6B9YsD
 j4qUi1kiL9P01sZ4KE1l/W/4eUgcqPtVGv9xjnUJGvNwG2n5aEhFZOGDZCONRmF66Ouf0yqdc
 ZkfZSrsC0XbvKhgewId04xMWpCG9CjtFiVnc/0hKUTrU3UyVrrs9RGatuLsnazMalcE5OwX3J
 w6yVzMhYsV+TD/jaGeK6ievfH7uxexNgPyDLUju3v20ApsvnxqpjvDBeaWkt9wdpAfLSM5Awh
 QyAul3kUDYF8ReIQeicsJf0m4+iCefxUqZVKblx50xVoFh7BHU8dteMCWJVSzrlrlBCq5F2y0
 S4CYuQzohTM9VmIF8A2Xy3kVZ36QV6Qv6XTTKHG6jDe+RKLNzCg5Inj2EoFXEkafS4qZQbfKN
 UN1dqi56GeOZJ+dLZIGkFIa5pS8O20pC/0mSELw/g7eycSfDXK0d7ktQlaWpV4dnxKxM2CHSq
 iL7sBdi3w32ax06gnT7Igp09zH9+EcXgQ4dWrR4qqdZXRhcRNzO/qPFMLXrpNNsezmxZAw4Md
 DPuCWzNORO3SO0BS7VpqcSIOUufP/jIs/MWBMobdbcQiRGV+KnNmwALNSL5ayWnUHTgdgMpUW
 Tbs9cTSnf3QUDFV438MuclM7RUQdKBeBZ9nRRpvk5n0EBhLerC7ZSXL6Rm4mD+lpz60mrqMAb
 ojAVznxDkylnUGlD9uzKtOB8DzwLAn32nclnYchhlghcQyZX8xjM9jj+Yrg2b9TDv9IKVagj/
 uwnbf+ukOdQ9quALl/SLGAQZ7VXcmq/aVBLnQtkqAQM6Xx0bxgqx/RougMgfW5Yl8+pA5hlkw
 KvVQqEl1Zn70WfAGwr90K7mS0VWKChYg42aYYxso49jHfAhV9WUgO0/zqqqiQwABUduzUCA9I
 +//5hVpMie7kQoCGRr+Qyzua9QvO3MOr4nBXgbcmCpk7xlwbz00cWvQD2CZK+ywhz+pZLHD7T
 Hlja36UyrvBGZqyDsbzIZ9m933jzBSJ2oFgVsy9LLsz34KlaRxCxvbESrnedwQITllJqbhsXs
 2PK20gPETOJ38OSbkFuAOC0OEY2TOYPUVFdjvaRjjoR+rPXGl2NLVoS+o8twYpW/nkxmlS3X6
 gqRBxvuTDTNhK3WNsAwTGZIOaS098xttwKGnXyIfMSFov9zrCmjk7IkMSXi7MIv2Ejlta36Jz
 9SNM4/pOnA8FfYVZveeCAqTXPQ5br6fh3wL/GdyeTI241G3E1wUk3I+iSUg2EBZVpxI/ipTMI
 dZSvSRl+bmwmVNwV0dgalpL/FsUW96CiS3Ci/blS4g9X/OnOfwBAvDpaTKuE=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 16 Jan 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When the user does not select any files to `patch` or `diff`, there is
> > no need to call `run_add_p()` on them.
> >
> > Even worse: we _have_ to avoid calling `parse_pathspec()` with an empt=
y
> > list because that would trigger this error:
> >
> > 	BUG: pathspec.c:557: PATHSPEC_PREFER_CWD requires arguments
> >
> > So let's avoid doing any work on a list of files that is empty anyway.
> >
> > This fixes https://github.com/git-for-windows/git/issues/2466.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  add-interactive.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Makes sense.  No tests?

Do we really need tests here? ;-)

Honestly, I would deem the likelihood of this to get broken again very
low, and the effort for writing a regression test relatively high...

If you insist, I will add some, of course, but not today.

Ciao,
Dscho

>
> >
> > diff --git a/add-interactive.c b/add-interactive.c
> > index f395d54c08..14d4688c26 100644
> > --- a/add-interactive.c
> > +++ b/add-interactive.c
> > @@ -915,7 +915,7 @@ static int run_patch(struct add_i_state *s, const =
struct pathspec *ps,
> >
> >  	opts->prompt =3D N_("Patch update");
> >  	count =3D list_and_choose(s, files, opts);
> > -	if (count >=3D 0) {
> > +	if (count > 0) {
> >  		struct argv_array args =3D ARGV_ARRAY_INIT;
> >
> >  		argv_array_pushl(&args, "git", "add--interactive", "--patch",
> > @@ -953,7 +953,7 @@ static int run_diff(struct add_i_state *s, const s=
truct pathspec *ps,
> >  	opts->flags =3D IMMEDIATE;
> >  	count =3D list_and_choose(s, files, opts);
> >  	opts->flags =3D 0;
> > -	if (count >=3D 0) {
> > +	if (count > 0) {
> >  		struct argv_array args =3D ARGV_ARRAY_INIT;
> >
> >  		argv_array_pushl(&args, "git", "diff", "-p", "--cached",
>
