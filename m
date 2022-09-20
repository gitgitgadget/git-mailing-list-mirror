Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE91C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 21:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiITVYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 17:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiITVYG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 17:24:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8FD7287A
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 14:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663709041;
        bh=WsCFGhtAuOpfLPR831vysLY7yomYJqVK3p8aum2yJK4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DP5srdiALTt+NsQxYW0ZaehzbkeYjPAgA3lvPr53dE4p35ZKF98obiUeG/cb6HMKH
         9pg4y1stc/h3jsm23/NJ5MCCnSS7FbHlfPL3Tnn4ktatcTCh0r2hDnbZkOdB1V16y+
         oHhlCXjT9RZR/5XFFoyB/F8+QoqlgrdVk6jnwwDM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.115.55] ([89.1.213.188]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Daq-1ocxdw40kK-006ejz; Tue, 20
 Sep 2022 23:24:01 +0200
Date:   Tue, 20 Sep 2022 23:24:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Taylor Blau <me@ttaylorr.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [BUG] seemingly-rare segfault in merge-tree
In-Reply-To: <YyopmKNZU4WL2wrV@nand.local>
Message-ID: <nqp61q74-1oqs-9n1s-q7s9-r8741n3r735p@tzk.qr>
References: <YyopQD+LvPucnz3w@nand.local> <YyopmKNZU4WL2wrV@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eGgf0FGZqHGKMThtEGnck7rKHS4Vn5KYlb0q3LmyjfudXnm7Hrn
 dstLEQXp9lW+bN2oxGXLK3Dt+1FJDm02/NL2J7tim18M3fXUm++CPZ9lMuNxYEKFo5v8IR9
 5x7kdPOhZM2/TCt8JL4o7cMzeQFS2Unw3HD9eH7ZmITD1KwfVf+c5Sy/oA6oQL0lhux7UnQ
 giiAV1crdpekvrpNkgJww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ubd7eIvf3zE=:PVBNol455+Y1IZB2vHpjBc
 BQRMlT5oQMSzFdxVaZdc2QTh+UAN/0Ir1veFM9QaQJgvE5ZaTzMfD/yE3AkGYDkmAZg5ZHncL
 wy49nygW75aokSJviMRh6aRxe+PnC7oXPdnFv+uulA8Iav5UjwT2SOBzZJQeDFSMZcbIy+xFn
 g4QMiOycfE9eTJEp+UUD7GigLdoQ7uoIGXtgnQKRmYBxmDlPPAI6ZiCPI+O1+3pWRObkamJSs
 UFMbycLmwhnurcU5HsysFPp/vX8M7/ya5eqh2Qfr65TVOM60VcBK+r574RArxWBlAlGWNm9aX
 zWU0P2rnmmuAOcCM4oIl6+ye5ZWAvYHKL+2jgjBzYmllYGpClAPmuYO4R/qcZDYFUh0Scv3JS
 L35xXk7eOTerXYmccir31OjnFlroPPngO6xOiEa7Ot+8qkNoBpYfPeolIWpySGDXfjIie7ZAr
 IFtC/VStEhQYDvirvr+sGw+pPqij4FKvXx357YmI1GON9pGkx19KoZhkcQItKxJOsVgjEvVyy
 har73XVkFK4MhIT+vehWC3vjH2i2IImG3BVUUgzKxYe2MuQL78DbDwi5ouRpdvzGcYDY5moRs
 9+yFFDYkGBoH7JmnWxI23sybx9U7/ZIAn/8BrRIItLelll6/wnPJI9FzBXpcNL+6KMzmyJY4I
 Y9XM5oFm9khekdeng4/gqL/eyAuFNJ0qteXhNt4qtWvNgzii7zUHhaf6k3jA/2vrHDIGyVpuV
 hoj41mfEgW92t4BAG6zCj40lMMwE8GGi7iInOuWqKEfUxpxilUKJGMxbBjrY/E4xsZofznxtG
 FM36T69fkytcb1uaxCqZ7RjWXm85tMhQ6m1dCaV0tiHPrVodvgEU+ENlAnP8x/dAb7dKZ/tfM
 u1gMzs618m3K+OYVA3q6drgJCrYCVvfQElSYqZq7GV79QvbHHAjRrtd73RbYc/uios4FNUdWH
 Q98kBLf1GnxFbucUEvKt+aqj1nuDhXHkobXK0MpnbVNAnxBk4OznGzc1bijMTWGU1iZNDy+ih
 Zj4KbiB/nAheaorWr5ul/3EBfIQcVlkauZh6bKR0/olgKXu7cy48yo49ZOhwZPpAWwGCTsSfU
 JvrLPD9w0xyWh1SUpke+qEoHh1qOv/c8y4OFpzCnRvpCWMis9pLIDBAHbiE1lGX5Zc8w4PXxJ
 dGOTNkowvaj5qXHNuok3iIxvTy
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Tue, 20 Sep 2022, Taylor Blau wrote:

> On Tue, Sep 20, 2022 at 04:57:36PM -0400, Taylor Blau wrote:
> >   #1  0x000056234188aba3 in real_merge (prefix=3D0x0, branch2=3D<optim=
ized out>,
> >       branch1=3D<optimized out>, o=3D0x7ffd3fc4cd60) at builtin/merge-=
tree.c:528
> >   528	builtin/merge-tree.c: No such file or directory.
>
> I should mention, of course, that this line is custom to GitHub's fork,
> and so doesn't match with the latest on `master`. Here's a link to the
> relevant call that matches up:
>
>   https://github.com/git/git/blob/dda7228a83e2e9ff584bf6adbf55910565b41e=
14/builtin/merge-tree.c#L449

I am afraid that there is way more custom code from GitHub's internal fork
involved in this report than meets the eye. The `result.tree` that is most
likely the cause of the segmentation fault does not actually stem from
`merge_incore_recursive()` as the linked source code might suggest.

Instead, it stems from the `merge_incore_nonrecursive()` call in the
custom code that allows to specify a merge base manually (rather than let
`git merge-tree` perform a full recursive merge). Custom code, I need to
add, that is nowhere to be seen in upstream Git.

I did hint at this custom code during the Git Contributor Summit, and
there seemed to be enough interest that I had appended an item to my
ever-growing todo list to upstream this.

Ciao,
Dscho
