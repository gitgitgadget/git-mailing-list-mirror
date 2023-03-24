Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C42C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 15:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjCXPFt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 11:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjCXPFr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 11:05:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79145D522
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679670338; i=johannes.schindelin@gmx.de;
        bh=dMxqESIl0OnfKq1kmofWu0+ctr9mdeg2dcFqKeEgqZk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W5z51i34nw1PuDI05h1UN+o3H3mO6yvDD8hql15UwIAYUvK5HbgIkADDPq3LWGevP
         FZtoBULUOwiSr+mDsdiQJdgPDXB8nhwtghmVqHu5cTAQI8Z9iRhrC+f5mEoy75eX88
         uqZRbL1EgL6X+s3mp+WEkl6dWzfGr2BNNud3hA3lmt7Sa74HLnJ/ITSSA9+eBcFiD7
         2U24KYC/LZcn+NN6Z54fhgLapv7I4LIBAsLNMA0aAJBhMO2Q4BlVrEr1Tvgtp5qHBd
         Getp2jZi42jtYC7X+JMeuQp6PjEnByPXJs7bYrGYdgkpVtZhzFw/eq7Noy0AD3jHYD
         apMH6fRXVkzCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9Mtg-1qZhGX3vXg-015L2W; Fri, 24
 Mar 2023 16:05:38 +0100
Date:   Fri, 24 Mar 2023 16:05:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Alex Henrie <alexhenrie24@gmail.com>
cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, sorganov@gmail.com,
        calvinwan@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
In-Reply-To: <CAMMLpeR4x0_u=JGnWQ1xvBeVBXBw7VAgLTWgvHdMFDZLrcy1pA@mail.gmail.com>
Message-ID: <8e2dc463-7a17-350a-e22e-184137153c24@gmx.de>
References: <20230225180325.796624-1-alexhenrie24@gmail.com> <20230305050709.68736-1-alexhenrie24@gmail.com> <20230305050709.68736-4-alexhenrie24@gmail.com> <kl6l7cvsi006.fsf@chooglen-macbookpro.roam.corp.google.com> <CAMMLpeRGEETraueJTTV0tJSsycNYF24YX8n6h-pMp87VcCRJtQ@mail.gmail.com>
 <kl6lzg8cvby2.fsf@chooglen-macbookpro.roam.corp.google.com> <CAMMLpeR4x0_u=JGnWQ1xvBeVBXBw7VAgLTWgvHdMFDZLrcy1pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3f8pQqH3RwNpqMfDd1az5n7wsjxy80ro8z0H+TTC5iIj9UWpvs5
 t1i7IuRblj/+H3xPgSdA0Wovw1mZ1Eu/YmNnK8UCo0RWp8xYFdlbMiljLbG8UghKLc6t2YX
 WwUIp5+9gTf9cehcp4Y+vUedNRk4K324uqSQa01WUT1KQqlTSNCu3JaL7c52f88nG5BXExH
 FTNAE2Gm7XskDTPV1aRXA==
UI-OutboundReport: notjunk:1;M01:P0:6VOejIp0dn8=;myTOG9akhW8m2MpVFDRF2824ZTd
 mt3p6vy67M3MiUbItAAKcGE73EkeICLLFL8HqTIQGLrTZy4Unh1u+EYzlb9b/qeBjZ4VeXyzc
 E9OhoNX9BOjZQn7PbO8uHEIHRoqZ9QSBjcD0LdT0Eo+ro2wc4vi02zIhKQeeyXPSYUUpSQsrY
 olmrilUs/oIaEziRNM5/nNiWG/1emp5wAN4SiPMfyMIxrkBmSvajbROToAKZ+bZWIT5s58ZY4
 pnyRpWzKWWg/IYd7zC1usP8LYP+KUJ9X/5UcDpNVndaVSemMgsYiaOT1no/XbIkfTimqtZJ/A
 qldk/ybWz9PaFfO6tPNAFsTTz/UbLfMxlbTcGjUfwLcHcH8knNgvFhBr5F47DZxrdseORf2KN
 unBEzba5KqKr09QonRG+SCfuTZXn/eTFqDilH2JXNWk+sZDmPMIjYZ5OIm8Vte7BF878WbLCD
 QH1hrbv97MupVS+JC55tBStRosHfZmva+tabMd3SDTl1rDVTIaGHj8zB2WCPwnHdoHwMQIaYY
 MNzRLImlbx1GuHP3uZ/tq6cyfJ0S7GD/pUpaaoUeFOOejwaywlVhiEaRQKVboRvoJy/B0gMVw
 eP+JodE2qf/9sCMNb1Vq1v4InkLgF/21HR4c1Ti22GqDe/0XDXlKzLYimGw7JWsZ20UzS5kao
 0Qlpslv1w5eVbQI/LmbzIl3Dlp2llbPDuk1gVNIWnEc6wKn+8vvG/gAqMizhm9tijTjSBxbNn
 p9mtYpfdSa9F5T4xmJFAq0HjKt93/mEKIS5kmNxypfUVYHqwKSHJFvE9m8DFx3CxlDn8r2KDb
 5GrST4QH4b5yMZ3gpIhUFhhMIPCF6QjtY1phxOzGalZL6/+7UGraswl4eYDRA7b8SzfpCGLlS
 eC3Q29kNRHmjfG6QxybRxpWi5qGs99D6m4Aj3QzBkOXGhj8bwmM5hvWOuJCRl7w6O08ZT0Man
 hj9chUKFYGfSdM+YhQW+E0mFGUo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Thu, 16 Mar 2023, Alex Henrie wrote:

> If we add a rebase-evil-merges mode, do you think that would be
> orthogonal to the rebase-cousins mode?

Those two concepts are very much orthogonal.

The rebase-evil-merges mode needs to change the way the `merge` command
operates, from "forget everything but the commit message of the original
merge commit" to "do try to figure out what amendments were made to the
original merge and replay them".

Whether cousins are rebased or not has everything to do with the `reset`
command, though.

Elsewhere in the thread, you mentioned a suspicion that `rebase-cousins`
should become the default. However, that would be a radical shift from the
spirit of the `git rebase [-r] <onto>` command: If `<onto>` is reachable
from `HEAD`, the idea is that an unchanged rebase script will produce the
identical commit topology. This is in line with a regular (non-`-r`)
rebase as long as there are no merge commits between `<onto>` and `HEAD`.
I am not sure that such a radical shift could ever be an easy sell.

Ciao,
Johannes
