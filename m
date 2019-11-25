Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA6CC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C62207FD
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XctFjCjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfKYOqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:46:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:48489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbfKYOqP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 09:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574693169;
        bh=I0JajNd5H+PYkiGmCed9/gbAhJ2HGCu/PLOGXGJ5HgY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XctFjCjoESbmScjN5nLFw8kRWVozIzRMeNj0M0vVUyheuGLpHnsMSvMvrZgTGzd7Y
         5PY58TqVFEhm18VdSbCcSU2EVCo6w/f4K0174eoycLRo3cDT4bQ2bwebvfdXOfKa5G
         x8AJIJjBIsEE3tTyNA5RoCvb+IxC1khO65Q/eZNw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmKX-1iF6DJ3bS5-00KB8m; Mon, 25
 Nov 2019 15:46:08 +0100
Date:   Mon, 25 Nov 2019 15:45:53 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: [PATCH 0/1] add--interactive: skip index refresh in reset patch
 mode
In-Reply-To: <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet>
References: <pull.475.git.1574539001.gitgitgadget@gmail.com> <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:q8eCgcPP/qCYOeLpikVAIBBbyXa4hF8rNAIFRn2dXyNUEOh0FEF
 jSz7AB6YSKBLTak0dv0Qj0pv8aok5vF8j4N4ucH8/DrrmY0hkJS2+qJaJx6xTomyaVsSE3e
 qEocu4UPKiwNS9+6HYOnXgAHNu0bfZI95QCQDiRhi2BVsZF0F1Qtv1VBb4eNxd+zgst4efZ
 zzbGAAUuMacw7savbWveA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hot3fMOBTPQ=:pnyFkH9lrLA9iyHEO4zArr
 TnQumF3Gr9L71VtTEY9rXfiDRAhxHklNSR8TzjAbP6rtvX+UA0wTzRw0MsmQ1B/TtPAoR1EMP
 S7TVtcA9vM6hUwRcFjujqIQe/NsoLZ99E7Trr/K0oBsQMukuc8B8oQlwZT4SqnfbEmXc7zWs2
 coIaiGmlufg1wocSt3KphOcm0BP8T0rBcweKQU8orYbfwvf24usF/F51AYOd+cFJLOQTH3FYD
 9rqwel9WiDC+C3WmRY7cDEAq2pGW8odKUYCno4y2gSFqmOcJr1wFeKDFWfQBKSMjlXiDAjUY1
 QQA5krIASGd96O5P8czPVMB8BPXVIFGpxIu0NN2Xx5NHNuVFiSvoLVl0Mn0N2bBD2buKej+IF
 QJnL0MU+u+k1Lq0uE1sleKZmsIQXsIo2jfsjUt9G0emwq82B+v+KoambCTDnvNnIPa6+OctBD
 /QSrz8xQ3H/9Ks5t6f52zvMYjwCH89TzLzyu6rUZ3aIkOWe44xoXMeCUw7z+LQrsdT+Z/GUK/
 fU68ZHnNh4B55h3Qq5GXRQiBXgqmJHAY4/ighcITGUXz+pNFz82jaygjMdtPN2y3/17hRcWZt
 r5fk/JyySOmqe+RVSI7C01CpyIcfuRcJNJ9NGk/vmn++o8beSDYO4j/JSVDwRu4bQ53P6o4kC
 Ye3CoXw29RSQWcSnffP2a2p/G2fzXnUnWbT8iInEujjNUuFi5xo1QDShsLcCO1f6JelLCHI33
 2A2e18nLVCnm4rObVnh4hKod9rvbyNy5d5x9OCjw5faqxKMoqg1uv0tbUZ7ZDglW3j/CNPryD
 pZi/OqHATci7/YoTsxinCbj0sGXBYFBo6ofXT5BGA6DnYqid16GQpCkHMSHgZLLaOEeqYwnwo
 t3Ds9KwOnG/LA3kZVJ0yyebSVSMw90U/M+MH9O8pMVOfjlM864jJIszuW+cQDk13YTvIgwWOC
 oKhgiqh4BK9koSTs3TeXLgF1z9l+R9yv8avEYUVrh5HDfE6+aKYHPFJZLXstXXBL1lgGORBmu
 FcA6a4eSIpKfBXQYxsK5SzuTdmC9SPgfDjm2mRb/pYC2XQVPLK/AbxG/GbvP/2qWRf5bpL0Sg
 ssc/cbDt9hEccEpq/AvYODVdbYKc9lGUc4qiz+yDoYmk/xbxW4zG/m9I9Ss/gnJU5NjSOc4iD
 u2q2m2FQCFseKVVwogh9TrRK6L4h9BWERlvM15UUZVI0qIs5E/rj7NJSN/XpIhc05ZAj05ohQ
 r9RBr0yQ8mSXYAtC/R860lSIrReMaSlf4fPlW28tZCasHjKLEYPJNrOeXOQs=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 25 Nov 2019, Johannes Schindelin wrote:

> On Sun, 24 Nov 2019, Junio C Hamano wrote:
>
> > "Nika Layzell via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > The refresh command is called from git-add--interactive to ensure th=
at git's
> > > view of the worktree is up-to-date. This is necessary for most comma=
nds
> > > which use git-add--interactive, as they are interacting with the wor=
ktree,
> > > however it's not necessary for git-reset, which exclusively operates=
 on the
> > > index. This patch skips the refresh call when performing a git-reset=
 -p,
> > > which can improve performance on large repositories which have out-o=
f-date,
> > > or no, caches of the current worktree state.
> > >
> > > I chose to use the existing FILTER property of the flavour to make t=
his
> > > decision. A separate REFRESH property could be added instead.
> >
> > Hmph, I wonder why this was sent my way.  How does GGG determine
> > whom to send patches to?  I, like other reviewers, prefer not to see
> > earlier rounds of patches sent directly to me unless they are about
> > areas that I am mostly responsible for (other patches I'll see them
> > and review them on the copies sent to the mailing list anyway).

Oops, I forgot to address this. The reason why this is sent your way is
that you are the Git maintainer, and as such, GitGitGadget sends _all_ Git
patches your way (except the Git GUI ones).

The reason for this is that this is the suggested way, as per
https://git-scm.com/docs/SubmittingPatches#patch-flow:

> 5. The list forms consensus that the last round of your patch is good. S=
end
>    it to the maintainer and cc the list.

Ciao,
Dscho

> > CC'ing Dscho who has stakes in keeping the scripted "add -i" frozen,
> > while he is rewriting it in C.
>
> Thanks for pinging me!
>
> As it were, I was aware of this effort, and I am quite happy about it (a=
nd
> of course I will adjust my patch series accordingly).
>
> Thank you,
> Dscho
>
> >
> > Thanks.
> >
> > >
> > > Nika Layzell (1):
> > >   add--interactive: skip index refresh in reset patch mode
> > >
> > >  git-add--interactive.perl | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > >
> > > base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
> > > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-47=
5%2Fmystor%2Findex-only-refresh-v1
> > > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-475/m=
ystor/index-only-refresh-v1
> > > Pull-Request: https://github.com/gitgitgadget/git/pull/475
> >
>
