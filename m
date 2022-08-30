Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBC5ECAAD1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 14:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiH3OOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiH3OOv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 10:14:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35015F619A
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661868878;
        bh=ghTLqQ8rYNBZ4FiVHwwV6Mm08ckrYmeUn3y6S46DG5A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CxT7ULHCJB1flDHmU9zr1/ayfxv5a9afN7bNayI2xZEy95eeUfNXISqUrlFmMbhCo
         6sSoks70OyhIM3P+PDGac2SlFp+B4UhJFI/ElL6nVu2dkedtiJ8NPAuX78Ylmc+Rdp
         JB4l9NzW8eA01YYhTwn0U++YCvO+cHLG7bcSPLWc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOKi-1pGB7I0hLC-00usAT; Tue, 30
 Aug 2022 16:14:38 +0200
Date:   Tue, 30 Aug 2022 16:14:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 3/4] add -p: handle `diff-so-fancy`'s hunk headers
 better
In-Reply-To: <xmqqilmbotl0.fsf@gitster.g>
Message-ID: <p11s25nn-15qr-o2q1-5700-1q581sr9331n@tzk.qr>
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com> <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com> <9dac9f74d2e19899b3e6c1d28e83878ded4469d6.1661376112.git.gitgitgadget@gmail.com> <xmqq5yibqxs0.fsf@gitster.g> <0q0psp09-8993-96r6-3r90-q4s368p98510@tzk.qr>
 <xmqqilmbotl0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qKFTLP0ihhKmSUTih5gTDo0MCCkxW4mg5pbgMEbRvIIkmK/U0U3
 sSLGNoNGu1TC3ty3GmRTP3fNx9poWjyqhflaMouF2hhkgU8wQoMs4Cx6b/riE+4YbPf96xr
 9eATCe2PYiwYvSG8l47D+P3iFrkXVe8+esxSdt/mYEdRC1f3Vt0sHZDpIdaNtOF0lk6mt6N
 f8AEHHxj5wsCp7Uz7PbGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e0px8SLlUOI=:UxrtOWOYhY2vyabjNsuTnh
 k8ig5F+y0CpWBgazAvxXtwai326y2I7UodnMUSmHordIauwSEke+x5XKAwcyiavIYYr7LXmf7
 Pxcrv2hREKWilUecnvikBg7EIHPbeIguQh2WQE7ehoLU+n0Sf1t2syS/ClfLfY1TVqI3SNXFT
 eLzJsDTmfCO/x6HMTqKzZGqrWgvxhyzwh4YsujTNLi20jDifskB8CvVdCdmWKC4yp1uzq5BVh
 U/KBD/Ai4e95hWMmhb4qPfACZWIG1hikthbiJpV0lyuBrqQUsy/JuUC3gNw74dkfcamMezK3M
 8P7XWjI8rejGOIG4U1lJchyBRTVBmKC00dr6nY9ftEh4X74USqDx1idFpm/dOpkxxRts1FlW8
 GjKVlsx8t0ArSJmrRdgqVFE4yiQ6u5cxoYWqzzbQ8IqRMXGoNBj6bPTlJXgoC57YDCUIRqfJZ
 6hd6YsLyiTn6AS0POaKiJXa4C5AN0+ah7hPXa5wAmtf1Xzp0ckP5MefcQgp5qOrLft4laLIce
 46NXX0Y/JjRoTIhekKoGoB8tat/gbtv3PelXIL1FS2Tre1SlTdiRL+r75gQEJTrSmHxqkYW72
 oTKPDRbYJ7hnEC0FO5FvGqkwektBO1FASEjrABbyHqgNE5lKm3axUe2jDaEtjqXio1mOJ8eVN
 QDjotIZl7uulJGw4AG7xzmJQBB3oK/C7uvnyiMH04Tc4uyqh5vCA3IkeRAFxwS8BN6CfvpdfK
 Xg/SFSva+9b/cfGTqVOUpDExUA+1FG3lW5olJ/PjpwROBj6tosbKcXUSqAS75wZ/7FW60Vvwu
 LGE/BnEABnmuqHpGwFXpzWQom2d0mGF+05syQqqAHPUKQh8jlVudPvFwqFi6fb29vk8xcHaby
 UsW5s2D8h6cfW/9LW1VlOhIvYf63HCkZlTpZ19xKOooEQtlfk8Qm6UFVB4oSade/5Gei90lAR
 NfSk1SFomAHglgqF+LolDDkmgJqcVBKpXGoVTKbYOLgZJQNagjJveY2NSW8CWRuK1qNRRwQMR
 YNTtTOew1Q59fJ5qRspw45Vjo1qbKFEr/aOoJmRbPdzEpBu0JC3ZMU3mCPY0EJ1U4g1g5Al3E
 Pswl7fmmuXdZlJvtzFJRFcXw4BwfRDMpDU4H683JB6hTOdqvuctGD9ZAw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 29 Aug 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Here is why: in the _regular_ case, i.e. when we have a colored hunk
> > header like `@@ -936 +936 @@ wow()`, we manage to parse the line range=
,
> > and then record the offset of the extra part that starts afterwards.
> >
> > This extra part is non-empty, therefore we add an extra space.
> >
> > But that part already starts with a space, so now we end up with two
> > spaces.
>
> In other words, this breaks because the original code depended on
> having the extra whitespace before the "funcname" part.

Yes.

> Stepping back a bit, if the final goal for the UI generation out of
> this string is to append the material with a whitespace before it
> for better visual separation, then the original should probably have
> (at least conceptually) lstrip'ed the leading whitespaces from the
> string it found after " @@" and then appended the result to where it
> is showing, with its own single whitespace as a prefix.

Yes, with one twist: ANSI escape sequences can make lstrip'ing non-trivial
(granted, the line range parser totally ignores the fact that `@@<RESET> `
is a totally legitimate end of a colored line range).

> It would have prevented this bug from happening by future-proofing, and
> made the final output nicer, as any excess whitespaces between the " @@"
> and "funcname" would have been turned into a single SP.
>
> The "prepend one iff it does not already begin with a whitespace" is
> a (at least mentally to the developer) less expensive approach that
> is fine, too.

Yes, it is definitely less expensive.

Ciao,
Dscho
