Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C791C2D0DB
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 14:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8F72071E
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 14:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="G1GXkhtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgAVOKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:10:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:35579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVOKp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 09:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579702233;
        bh=6+0d9XyyUgIZOHdAhe2zxNQxC+o4yqhXuh2wyM0HLgw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=G1GXkhtUOyrdymVMdbm9T+Flps9OPVC1RsyytnYhjUDADoGSBz8ND31K1+oexEJVb
         02mmeU2S0Iypd+Ht0gXmI3B4PnLabRVuqvqE4rKcYRCK4S86AnU6+1vCuYQ39G1lrM
         noAUALuIdOOFT+DFu+sJQhzOKPHokRJPZ2HI6X10=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCpR-1jVWLG0cOV-00bIhv; Wed, 22
 Jan 2020 15:10:33 +0100
Date:   Wed, 22 Jan 2020 15:10:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH v2 2/3] rebase -i: re-fix short SHA-1 collision
In-Reply-To: <xmqqpnfc8o39.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001221508180.46@tvgsbejvaqbjf.bet>
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>        <pull.529.v2.git.1579304283.gitgitgadget@gmail.com>        <102fa568dc09c1faa2d36903ccb7e1b285dd50b2.1579304283.git.gitgitgadget@gmail.com>        <CAPig+cT8t39UvnF2i6CDoHW4kfEGr-CRFxZKOCstCTU0YzrCgQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.2001202103221.46@tvgsbejvaqbjf.bet>        <CAPig+cR2T26nJ1G5n82r_Xi8Y84k211n6bhBxG4Ku27vaW1pWA@mail.gmail.com> <xmqqpnfc8o39.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:G2Y+i5r4gTHkHS7IunzZfcTFDwdPDL0A+kd50+ydwwDI/H1SMoG
 3pXLq4axoGGWrY5V7RBxXEUqhGJatMxxHOIWcBNBXdyTjwr0rOum5Qb4mBQiSeRfWX/ZPg7
 IMOQ2VLL5PfqLps+z4Qt+snvWJKCLKs50pypYpBey5VgXMXgskh72k5usleVSodrCohDAV0
 4E/6EgQM31VN2zAJabdzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BYY+td4i4lg=:YMddv893sXETtZ2cYZ5nHH
 DhDPFBSCp4JFcyIS0xrRmM+34zaC5i8wxydAVGaJcFk3Q8ipecWQK24UXcGgq9E3QEQpjmqyX
 UZtp5+dL2VVA8hE6y90gnU82XLHuZD1zBfFfRbrBX+enftwb7wZ6auKKd7nNatb6O6jgo/04B
 Qa5Aq/OVGFe1n83SAgLZLrxqQ/QpsXkX98NGcgHd1tnhsOgfpgIc47p5toD2jXj5c5AF5U/++
 PknI54nxZtWnC0ftCdZM8RJUtp5SelYv3MWrjkclHdDFX4OmTQZDaQWELlzehcJOgDMJ7rPk/
 GwNVNrw6WqEIVMkQAk2Ahm34Ra9safeKsGotbWN14sqx/M5BAvQknCyQjFm0YGf3i7OsOPeLn
 Nclnw1iJykyLSSgffq7nG/6hbVgFP6cZzZZXeETdzK+lPf8q0+aDg6hpZfr9BqP1x5nXccHmK
 3V9W4/6r8PSgiz+49OAbjWicgGCork3ayh0KaIAaBkM2M2PwL3bl9I0w/vQnv+t5PHAPOfEeU
 eGMwe7cr7/U+5GfQoS+Gv6Sz36NtizmrZBKUNRYED8DTRrzDPeKG26YGEjz+K1f3GKd6ckPDA
 VTeav6181OXoHt3A3H6AJS1ZaOntEydaT9xPYt7eqthbzxziUwCwR6RmXKi+SXtJ2hxLbBLZZ
 yybsvO+Ro518hNLpbPkHDxrC4DHf+TMvCJSC6L5VQo+m5lJXi+AngwOnQ+hBPB/VO+pfNi++4
 GFZh+5U9KsJKqj0HvYWNLpnea1hRg6YFrUUpA8la4pJAh9VMPYi+GVi5j4GU4cvF2HBkJZ3eG
 LdXiBtKWQaIXRMldodwstee6zAh1qKrmatiP+wVQviOofASprg1CPgto+YP2v8zInRG1t5fKA
 CJqQ9/4nmtwC0Xlh8RD+FbXEsB6R/nyTBX54Bk9QPzj6+HqbvMQVQ6jEjBNhNk78H8gPdyV74
 Wth3MKmXEgJKQHFdqDDqftJyC6PDEBRjJqSeALm34zULeGi71USDxEX54WILDWEUunDW6jeDt
 eUHLj53JvWrUQz1IzG27C9dW1A/GLV8Z9vWvJNOAN3ALDTlpmA2xS6jWLMsqYpflDSmwMmH+U
 /Dy70dQRgJsB9b9BnziMkR/qqw4apAmokTxHtbEKoQKim5mdqHrwFIiBWo4+INuj8Q+vzCZ8U
 qXOLLoi5iKXgmctx2Ua41FhJxp/8tVQLt1pcxpnAJRqc856vw3seicD6NNDz9HinSV+FGfsPv
 h1VZMDRyWtkYnt6jA
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 21 Jan 2020, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > On Mon, Jan 20, 2020 at 3:04 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >> On Mon, 20 Jan 2020, Eric Sunshine wrote:
> >> > On Fri, Jan 17, 2020 at 6:38 PM Johannes Schindelin via GitGitGadge=
t
> >> > <gitgitgadget@gmail.com> wrote:
> >> > > +       test $colliding_sha1 =3D "$(git rev-parse HEAD | cut -c 1=
-7)" &&
> >> >
> >> > How much do we care that this is introducing new code with git
> >> > upstream of a pipe (considering recent efforts to eradicate such
> >> > usage)? Same question regarding several other new instances introdu=
ce
> >> > by this patch.
> >>
> >> I would argue that the test case will fail if the `git` call fails. S=
o I
> >> am not overly concerned if that `git` call is upstream of a pipe.
> >
> > Unless the git command crashes _after_ it produces the correct output.=
..
>
> True.  Doesn't rev-parse have an appropriate option for this kind of
> thing that gets rid of the need for "cut" in the first place?

You mean `git rev-parse --short=3D4`? That does something _sligthly_
different: it tries to shorten the OID to 4 characters _unless that would
be ambiguous_. In our case, it _will_ be ambiguous. That's why I use
`cut`.

As to the crash in `rev-parse` _after_ printing out the OID: yes, there is
a possibility for that. But that regression test is not about `rev-parse`,
so it is actually a good thing that it would not trigger on such a bug ;-)

Ciao,
Dscho
