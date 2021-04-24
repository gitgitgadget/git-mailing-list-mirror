Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E089C433B4
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 08:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C0C61360
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 08:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhDXIPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 04:15:36 -0400
Received: from mout.web.de ([212.227.17.11]:37813 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhDXIPd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 04:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1619252089;
        bh=Z7CfskLbRLu/evPaUYd0Nijn/z14QoK4aLDbS1rsLjY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=omk7pyX5MNZ0AxD/RUliGeIq8G7zChpTHai0oNIsboGKQ97+56/hAp9vvtfe4bpzC
         WKIN+Mvg8V7FBelxfxvVHfjgii0sDw5NiJ5G25YQcmZ31RvPi5OgymTIL/6nNCVlyj
         pqhGtXWOg0BxtB3FC64mPeYGZ9wbbjKha7wu0zLk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MS2D8-1m2EfS35II-00TA3Q; Sat, 24
 Apr 2021 10:14:48 +0200
Date:   Sat, 24 Apr 2021 10:14:47 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] add git-p4.fallbackEncoding config variable, to prevent
 git-p4 from crashing on non UTF-8 changeset descriptions
Message-ID: <20210424081447.uxabqbxc54k6yxrg@tb-raspi4>
References: <CAPig+cQUaJq4Bu1NDSBnsQoR2HXhQ+s+4aQHeVP82DM_BuEL8Q@mail.gmail.com>
 <20210423063632.1973-1-tzadik.vanderhoof@gmail.com>
 <CAKu1iLVwfQ7Y-bOSO1tyxyFaNWum8sKW4b00i1nJCef98_2=UQ@mail.gmail.com>
 <CAKu1iLXPi4zc-5-RtZo3UBwTQ1GqshXjLEZKT=WvtvB0aiuUJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKu1iLXPi4zc-5-RtZo3UBwTQ1GqshXjLEZKT=WvtvB0aiuUJA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:w/5eAc8VoJ1ZF09yo8AlutfpCZ9LbwcvpcRq9SDXDR0oWrNZ2cL
 nFpkjfdY5dU7EGztCeKed1Ub1R96dJD9bxB75x9itTxahIS185PgiypkD58mO+aUjQleqVK
 PWBBHFmwXmfZI7kWWmW+ee+talcrigHnvaMJyiQT6hl/8rw4llS0nkvLgpykh8QfK5GY4D6
 ue595gB7rkBFln+Z1/Dag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LcATV6wjJn0=:elIxm31ya6IjlKHiLJ6zUh
 /sdfeo5C2i1QxzrUCSVd4xLrZO+qlMksXLEmwPPtaTqSicLXXd5lvPviextEDHWZAjTrXJ09Q
 +bkI8i8aeeff3OfsVt5QcGsECFkWIX86fujkW24aYavOlu87GGF0FGeU0VWBAdKmalhEpvklL
 UvPXrz2eb0XBZgWjPjaob7ldS7M1Fla7Nu3HE4w37lNyTGX+Y3PYdUrd9hJtLNS5EwecLoVV9
 v7uKZH5BP86loQ+5wcbdX/E9Ng6y95ejM4KN3V8PqxUqEuWrfmbnNzUY48lJbX3WsYcZPpkBo
 ypzdBfL09nReRzelQ+Gb2E2AHAYzFX4Z98V2C0AWd9XKwxtoUTNk+snsJEv+QTLp8JOXmW3RW
 ArblA0tJ0tURVDJXw2M5zkdl9xrOfyK1/t4v6nTpk49IV0j6th8DZrL3PDzwGcL98QEqZypzC
 VXdFCzhp0cU42PqlM9LTALWPvPMZjLIql078PpLL1tSPA3a8AmxielErIXm/Mvr/BZbI1hEYy
 1zLYfV4GQq2uNXah0kJXcyDlJPwpqMmuDPasRDjQqo6gsozHLwH2lgELQ9L/JPEX/88teBBym
 NJ1Tqik9xBG4Rz7Dla8vezUyQKv9hoi/3uoIp6qt6NcpVxH/AggJJ0xh5Qp1jfwJ+7Gxvzq+O
 qYSWZddfsR800MELG9bRNbsdpuZ/31kQPFIb0V3VGqWszr+kcRA1D0W4G1a75WiBI4qpxgfDR
 IxOGL5PUSB19UR0N1zU3uyMP/0IHAoZWwnU8uvJpmsIz0A20Z7Ycz4a6N2HyXG6VqgyWmFnV6
 UgZTrf8I2COxQ5b+acCzok8/YA1Cmlp2jXGH5eaT8lby5Xqr+GiR21IZDq1w2kiKdDC0YpF91
 +YEMX6QQW8nMJXdOYed02t0ME6zfmSLat2Br/Zy8VDLbvZutrNhGYzf63Q/F7+9zsxNBfAlUu
 fRc55V7D/rPSiwjwepnj/EiMxl9xoyCwoQ4ammes3pS9CeDMigBlcDXGfWoOPJIfYXaVqOFG8
 zAP4szGEUccGYctVqRjtEO72BXtHnhVpkgzSsqFHJs4fylTo3Ziz8kTEQDnvnKrzh3l/77lRx
 5HRuZgWRvf/eCw6nqpES2jC1j96HIPB4QsbIT/NuuMWytBXRZFxiA2JgdUPez0Xe1DpG5stN3
 2m8gEtq6B1ZEtQQfn5BXqnftdmvV25ewFeH34xdgGYHYW3FXTaPTUomVUO//wm7Vu8gGo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Adding some of the p4 and Windows experts in cc)

On Fri, Apr 23, 2021 at 12:08:17PM -0700, Tzadik Vanderhoof wrote:
> To clarify....

Good. This is good information, and the important stuff could go
into the commit message. And because the commit as such should be
self-contained (as much as possible).
Giving an overview about the problem.

>
> The new config variable I am introducing addresses an issue that only
> occurs on Windows.  This is because the behavior of the "p4" command
> differs on Windows vs Linux around Unicode in changeset descriptions.

What does Windows mean in this context ?
Is p4 a "console application" ?
In this case it may be possible to use CHCP to change to a different code =
page ?

>
> I don't have the source code for "p4", but I'm guessing it's written
> in C, and that this difference in behavior is simply a result of the
> fact that there is no defined standard of how "char *argv[]" in "main"
> should deal with non-ASCII characters being passed in from the command
> line.
>
> As a result, "git p4 clone" on Linux is not affected by this "p4"
> behavior.

Is it ?
What happens if yoy have a p4 depot that was feed from Windows in CP-1252 =
and is now
accessed from a Linux  machine ?
Doesthe Linux box face the same problems ?

> Since my tests assume the Windows behavior, they fail when
> run on Linux.  For this reason, I added code to my tests to skip them
> on Linux.

That makes sense, but what is the "Windows behavior" more in detail ?
My understanding is that when you press e.g. the key '=C4' on the keybaord=
,
it will give a different byte sequence once that '=C4' is transferred
across the wire (to the p4 server).
This is dependent on what Linux calls a locale, and all major Linux instal=
lations
use UTF-8 these days by default.
But that was not always the case, since in old days they used ISO-8851-1 o=
r something
else, usable for your contry/region.

So most Windows "console applications" are not run under UTF-8, but it
may be possible that "CHCP 65000" (or so) works - more testing needed.
>
> On a related note, I don't think there are any CI environments on
> github for git that are (a) on Windows, and (b) have Python and (c)
> have Perforce, so I don't think my tests are actually running on
> github CI.  I'm not sure how that can be addressed.

That are 3 different questions -
(a) Yes, git is compiled under Windows, both gcc and MSVC (correct me if t=
hat is wrong)
(b) Yes, we have python on the different CI. Github actions has python, I =
use it every day.
(c) There are tests run for p4, but it seems if they are only run under Li=
nux.

It would be nice if your test can pass under Linux, why are they failing ?

If I dig here:
<https://github.com/git/git/runs/2420889332?check_suite_focus=3Dtrue>

We can see that the t98 test are run, and are passing. Just to pick one:
[15:28:22] t9804-git-p4-label.sh .............................. ok     396=
9

Thanks for working on this.
It would be good to have a v5 version of the patch with some more informat=
ions,
like above, and may be :how is the p4 server configured ?
(Unicode or not ?)

