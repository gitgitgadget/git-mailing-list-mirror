Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EC2ECAAD1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 14:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiH3OWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiH3OWO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 10:22:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14E7B2878
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661869324;
        bh=iM3nEE9SmampLgCEg0tbARmSLFK8QzN4qCgNuf7xuo8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KdJuRI6JE9sPOSgxGRb5ArRKL0sjed3HN3rn/5iNLUIs8Szid9U7sxXpBDK7brdH+
         gVXKmZ5q9DXDq3AtQgULPpKSRyBUCV9yqEQAcTg3/8dn5+LSdPAmaflbc3tynvzuam
         ENHT66HQIVg6xw2ZP8FvQoJjGfJDm5R4nCjdZICU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysRk-1pNs6w17BK-00vum4; Tue, 30
 Aug 2022 16:22:04 +0200
Date:   Tue, 30 Aug 2022 16:22:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 0/5] built-in add -p: support diff-so-fancy better
In-Reply-To: <xmqq5yibnd3q.fsf@gitster.g>
Message-ID: <p1r4p079-p699-6053-14p5-4r4spr5s6059@tzk.qr>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com> <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com> <xmqq5yibnd3q.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3/IcaFNeq2FqfqSLH5/TAME535TZmrjH/PwuDDkiwWUvPn/Idgj
 xxB3/P5TbWl9+38tFIC2tvufy8G5jk9MNd068FIsBBTGs0ZLeNkuVgutFtJTd5ofY532/In
 Mqa7T0xeZze1Tmp03l8euh1jx0vI6QnB/s0b4L6TP2A0d+D8+1lsqoe8KsYuvlWmNw3IIxS
 L9WtZO8XMnOnp1SgvOxzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sbe1FlQJvRU=:ilQgpM+20jOvO2C8qo1tLv
 i9LgaUZRTijyzO+tQiFoYjP48vQTLQJ0HbHK8I9Hbvq3Bt6TmYB68kP2MwlMjntK9KnAVDXow
 zy3I88GBY9d4S6g8slCo8v5T3qm7O+enROLrkMBZCAzRFLUcTnyYWh0Y2/09L4fCpbi0JzJtv
 fP1iOfbAJhufDqfH3ug3E2Nud1vE+eDEsPCwnwY3YUgnOd4XaiN1feHRLQQAiMsTjME4Fpbpd
 d1hDx/l6Lj5mKRecxYqnal/Ga3H2PGBcoQZsxPp5kUnlINX9QpyZAgBL7UZt65GdsqpxgXz9E
 ePGyw31/RqDDh+HYm6weOFBYKebKkeSVo7j94J7hLa+VTD5gvHjmRGrbav6hnXE035Tjo5Y4o
 SesZvZGn1F/7y8nMwwgEdEQyQRgQ0e5CsAVR8IQWyS6uM5CN5PHWTrARBnHNubjdtwaHWf+EM
 bliTH2tvpHHvu9Y7Gs+fCwO4TPjNAK74c1pycxI9xtpqpqUo8krHqWNRAzMxFawpxPNZ7tLOg
 gTMJJafgW2fVvDmkPAtzKVVP1+35xZz9c4kURkEbbNhN/PXnPrJRzFPYlsn1nGKBbXba8T6kn
 1hy/pXHSmCzAfxAbJonRW9CXSykLB7K0rv5wUSVo4W0yQEdJ43IAJM0epnvMewjfeMk9baGl/
 prAaXC1RJsj+S8mzessSP6aaA2Yn+3NzLgCV7i+XTOTJK88Wg8nUp0dbWtPu7fm3CL4dpJE7A
 e3aTGbcWH/+A0e+n2SlWyxdzMLO6U72Rk+0VV+na4Av4irnKB2vY3cteiM4n6kHpyZd2XXCdW
 SHGzRBKGOVHJjUaieZLzX2W7s8OqQvvbvU+73atEs+rYAzt8rLiJ56TbyAgLF2WvE1POQcDCB
 Rb6pCxzwPMBM2CYO7WcevvNeKBXIW5ZAidnZk7RB5m73/mzt/m6cbaO90AiJgCffB5b5DbOcb
 9A3/3/gV2R9VqcpRrWg91QJsWiaQwH4qWUAAdDmn6ovToDnHTIkwvP9SO4FRbG6LCCsuj7naY
 qyY3Auf10nEqApKCmIu7KJ5EBmQ1w6lrEEn0OE3uHEKxu02ePQudMml/2IPF4BrgOkRdI/EXU
 y1MGxULEXHd/UPEkT4Xe0f2TeEoo/RmD03wYrHNAfy2YrtjqPLOP87EuA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 29 Aug 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> >  * That logic was now corrected to see whether that space is really ne=
eded.
> >  * To verify that the logic does what we need it to do, the added regr=
ession
> >    test now specifically tests for that (single) extra space that we w=
ant to
> >    be inserted.
>
>
> >  * Rebased to the current tip of the main branch to avoid a merge conf=
lict
> >    with 716c1f649e3 (pipe_command(): mark stdin descriptor as non-bloc=
king,
> >    2022-08-17).
>
> I'd prefer you (or any other contributor) not to pick a more recent
> base only to work around a merge conflict, [...]

Noted. I just wanted to be nice.

> We promoted the built-in one as the primary implementation in
> 2.37.0; I think we want to keep this fix mergeable down to the
> 2.37.x maintenance track (either by me, or by distro LTS folks who
> are motivated enough).
>
> This time, as you can guess by my above description on the exact way
> how conflict happens, I've rebased the series back for 2.37.x and
> will resolve the conflict myself (and make sure the result matches
> the application of these patches directly on top of 'master').
>
> It appears that this round is good to go down to 'next' soonish, but
> let's see what others find.

Sounds good.

Thanks,
Dscho
