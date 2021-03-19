Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3425FC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 14:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1062B64F65
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 14:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCSOtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 10:49:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:47931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhCSOti (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 10:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616165376;
        bh=lTN75rvGvOAAlHcxs3Hi6ofK/OaX1GTLyyA2vecOVis=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RM1LVmiv++GGsRQFL7UcbuuFRQyY0Km8ttSvB2aEBwRz5WVKIXf5UP1TRGa1COS0K
         Z5qp9cY0p39CXK7cqa/2zihaAfLySh5vxswVobPBPG8TgO8O+HZF09EA1R6XYJp5mM
         x98od0w2ScVIyXak/OuFbSDbrHoAChuKwC5WhR4o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.24.97] ([213.196.212.127]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7Jza-1lJwWy1EWi-007i4h; Fri, 19
 Mar 2021 15:49:36 +0100
Date:   Fri, 19 Mar 2021 15:49:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix memory corruption with FSMonitor-enabled
 unpack_trees()
In-Reply-To: <07a368ee-6b45-a401-32c3-c052370150f5@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103191546190.57@tvgsbejvaqbjf.bet>
References: <pull.891.git.1615995049.gitgitgadget@gmail.com> <07a368ee-6b45-a401-32c3-c052370150f5@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8OnIQP4gNVnbdfwaXM6PTPjQPD3e4SrDvlF6ZPdrn58sNTXpJWT
 XBVl3/kICo0GDWYue3/1yg3uqAclSG/Tw2B5GICgKm01zPiM5UwPegGCUIrw/7KGX8Q8UIq
 o/81rnu6eUZ7QqQznk+xOebK2XLtcH9YUBxXpyVcz7L5pPS+xzJIvrCMLi4f+JucHHPZtO1
 TIfJMMfOryx7umny/igYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7BB+9lueC90=:CWwWjdWd+enl84M3ZodR83
 y843HHYI9Fdj2B94f2sp/1jDX+W17G2kS/DFsio1SN7JtyBH0cc9WwdzjnGJn4b3xFDUcZ9CH
 8YvsX6oVYug7eHANGOg/nhW6ZXdvBv6SIYCFXXx1YbOkheoX4HrgIEznwvhevPa9RE0NpCSbo
 YSgs8o68r5usBmCZfPYU2TFbOInPY0cLCLmO/QpG3r8IegxQ2pC0tA+b0BohT3Z/mySu6Temc
 RlLl2iqXOXp9Gy4mVUwUC8FMiSV4tTzWc8qOCj54qPZO+tLWx6nV7qxrmMWiKZU6OO7S4M2+8
 vIMIToUBN+2SFZGk5GjMBdMZO51ddAIg3QPBdZqA//hqQ7rF07Nr3bjeuSdZcMO4O/9kcYZfQ
 GpKtLan6CyE+onNQ6iays/fitkLy7yr/cWobSdZb50IHnGuClc0NI511/kcjIunbqQ92Jruwy
 Sw7fIvNygmOMxEWWcG9OrSQGRIsbry4YoYVtgNcVlO2jjiWncFhtZ2qeHdcEbGHJSzGVD2tPn
 3IMcZAZfcZr0lTlBzqbpMWBPyrx01GbFEEfz7O/nhE0r7F63TjFL8wWHeA2kS7OFtUV3MSZpm
 MluWNsgwEdfaFrGqtC2dRec6SJJcy3rn5BMlWDV5ooavXf80b5FJbwL94iwRYwrNF+0uB4pQF
 4ISZS3AB/K63GGpVwce8X7HmyQpnc78fM0gvunZnUTDEZ766AuIOHgYsQWsw8nCkT7TCQtpjv
 lrGH6DtK+YchJqAzO1YH6eMKPNvrGgWfxiwuIfxfVBokAP4i1+5VjNxzG+fxJ6CmGQvNQqqPg
 Ocv59h55Ae4V5VcZ0I0r/f0s5q2OoCbwyLsl/vGJSndOnjUIFUb0XuUlATzFhFZMgGVX9Gmu+
 hwxkEjqMwFm3hPOq9y/hykjfGJxPwcmYwOQSRnK/s=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Wed, 17 Mar 2021, Derrick Stolee wrote:

> On 3/17/2021 11:30 AM, Johannes Schindelin via GitGitGadget wrote:
> > While dog-fooding Jeff Hostetler's FSMonitor patches, I ran into a rea=
lly
> > obscure segmentation fault during one of my epic Git for Windows rebas=
es.
>
> Thanks for dogfooding!

I'm completely selfish here, as I want to benefit from the speed myself,
and that's also the reason why I added this as an experimental option to
Git for Windows v2.31.0: That way, I can test it everywhere (and so can
others).

> > Turns out that this bug is quite old.
>
> A little over a year, yes, since the v2 hook was committed. It's old
> enough that these could be applied to 'maint'.

Indeed. Even better: if you look closely at the GitGitGadget PR, you will
see that I based it on `kw/fsmonitor-watchman-racefix`.

> > Johannes Schindelin (2):
> >   fsmonitor: fix memory corruption in some corner cases
> >   fsmonitor: do not forget to release the token in `discard_index()`
>
> The patches themselves are correct and describe the problem well.
> They only show up during non-trivial uses of FS Monitor and index
> updates, so I understand your hesitance to write tests that trigger
> these problems.

Right. For me, I ran into them only in one specific instance, when
rebasing Git for Windows' patch thicket onto `seen`, and then only when
merging a topic branch with a rather big diff.

Thanks,
Dscho
