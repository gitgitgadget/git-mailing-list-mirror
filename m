Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD13C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764E92068E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PbywQ3Ib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbgHYLdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:33:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:43629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHYLdp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 07:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598355214;
        bh=gobEks5bXoc4/xo+1mX4lIMI2dfSh8mRN+VuDH1gbHw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PbywQ3IbI6h54ol4fqs5vIgyXBBsqB9pgbNslpQAHdfYOyofQWKNXdraMscPDOkkC
         RHghQldI9/4G2p9MVQsvgvEYqcoloCNSfTt4EU2QrUJS2+YgEVJGGtvJB8vSK0IjCn
         es0FO/Kf68ZT/2oUOhPy6Ce/qvltD8jjV4Jh9PhI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([213.196.212.184]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU9j-1kondt0ra7-00ebSX; Tue, 25
 Aug 2020 13:33:34 +0200
Date:   Tue, 25 Aug 2020 10:20:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Optionally skip linking/copying the built-ins
In-Reply-To: <xmqqmu2j50kk.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2008251014380.56@tvgsbejvaqbjf.bet>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com> <pull.411.v2.git.1598283480.gitgitgadget@gmail.com> <166bd0d8fb699132569aff855de59c7607581adf.1598283480.git.gitgitgadget@gmail.com> <xmqqmu2j50kk.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7fPrvqM9b8gci/0EmwjBMJyGpbtOTdJFJBLLj39QLkr2Cst3bCV
 dP16OCc1rF6ZaaxhfpL9+7BEqntpfGIeD9w8P802jdlebwjt2Miox5O3darhFitL34Sm129
 refdoFQQ4Pqkbc8EYFlLFbmfFM1tGX4hJsTvOld/VmG0dBIcow+aRbeq1eBOOkSpvY9YF/c
 6KCsFzDHAVw8rAu6wP69w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SYYSwDvnJB0=:qDhmieYB4DjaPahzwbx6AT
 xAwpdkdOWSyKSEzpZKqgRW0HsJK+TIUD+AXeyCr4bJG0cKOEoL3pNvTxh7fk22mmKY2RdbybB
 sPuL1eWpU0tUXR1tjcknCfymdoSHAm7U4KxufDfLpiJRPZNuA2twJ4jwVMTaCrIj8Mjsb14O0
 6kEE7rkglTLAT1PT6MgfwniwyhDUrCXD8flYp9Mt3p9zx4WD5I17OsTvAicoRiuA1qGC5vrPv
 rtNnqG/gp2v8sZA7QKIdXxdkq/0Rilwbr+YNCxolvOyadbsc7BjWlJjZnYexdbfO2CjYPaqlj
 HakCgBtLq7/GSzqBGVEASJ5GSvFYVcf/hAzcYeNdRwWjaEJQqhzwHU6IFm7WBQ+boNfNkEWES
 cGmijDp1lcZi/ZTck5vC5TC3LM8HacJ0w5I5/1CMpvhVjsOtpWjLnOARFBVVsHh1fxyQ+tYI8
 VXNlW1j5RWXtchsVF/umCjobu53P8TylCjQ0KYN3u+SHAKvAi8fevG/DihW+b+rHu1R7TDr0x
 XkA0GeJNLW07a9zxUhAo86ZYSJCJUkUBPgE1yLzlpdeHkYTeBpKF1Ufmj6xnF//wJvq3plIk5
 Q/ZPekvzhQyn5630crDHx9ShkyI7/llVxForeTHo7CiqZ2YRoGtg9rmJ5ZqH/YT+6/wPCKKM6
 BWj4w5z+5FS5UiOAa5A98DPP+IHqMCtO07XiHMeqQv/n6obX1lsS4Rpo8G4zdms1FXr67Sn+K
 FK39T26CzdZKjy4YQOq0TxnsKTlq7psg/1k2mvdFY1DiwtA+KXz77+wkr5JoPzLEaBrDlXXb4
 ETJlNeJQ7q+aH16plHfBqoOKS+I9Dp1U7vkohpTeZTmeXJUoOxNP4cWz0J4z/oOyGZq2dBaXB
 SCYQu/BGGMPtIkyWPykXawn+4YdfCtXkq7fbnDFS0QwWn9ut0Rf7cp42/+o8Dx2Oem67fHAxA
 HDC6HsmQb5VVtKHQowtVTmlbyJofmcWIabVBbkbHw8M4hh5NeRERLxfBR4bEwDAkbhKXjcHEF
 i5MIGF/Hv1pu6+9yyMEqGilm6xcbS2YOe66bGx9Rnq2FsOPpMFlI6/fNCibrCXS6ZfoPRieeg
 /ac5M/k1r/KcsfytsIDU+18oyA683UF2W3esmSO/KXgzFT4DJ2+z5TslqRHh714d3OR97U91C
 WZMpQIaaXXa3VAYSdNW14PG3se812t0hOIFzwC06l4TQ5pbweTLuuiR9QfliZnsbCnQRozjTE
 TR9Pre97B/VSY1pU8LabcfNo8Nvw80iXnmBNSfg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 24 Aug 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > While Git still supports the dashed form (by hard-linking the `git`
> > executable to the dashed name in `libexec/git-core/`), in practice, it
> > is probably almost irrelevant.
>
> It is irrelevant when you have to say "probably" without facts, and
> this paragraph is not necessary to justify this option.  I'd omit it.

I would like to gently request to keep the sentence in, as it will provide
me with the context when I stumble across this commit the next time.

> We do care about keeping people's scripts working (even if they were
> written before Windows folks started using Git---those people who
> started using Git before that still exist ;-).

That, however, I totally understand, and I think you're right, I should
add this sentence (in one form or another).

> > In fact, some platforms (such as Windows) only started gaining
> > meaningful Git support _after_ the dashed form was deprecated, and
> > therefore one would expect that all this hard-linking is unnecessary o=
n
> > those platforms.
> >
> > In addition to that, some programs that are regularly used to assess
> > disk usage fail to realize that those are hard-links, and heavily
> > overcount disk usage. Most notably, this was the case with Windows
> > Explorer up until the last couple of Windows 10 versions.
>
> However, the above two paragraphs I would suggest to keep, as they
> do matter---it is a good justification to have this configurable.
> Windows folks won't be able to copy and use POSIX shell scripts
> written by folks before the Windows port of Git was started to
> become widely used anyway.

Excellent!

Ciao,
Dscho
