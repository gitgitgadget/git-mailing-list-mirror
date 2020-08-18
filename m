Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02F6C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 12:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2FC6204EA
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 12:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZpwmypSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgHRMJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:09:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:35589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgHRMI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 08:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597752530;
        bh=y8deths0nRqtoEv9kHMtbzzMvowSjo70Fz6ZL5sd8+g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZpwmypSuzzGVTYLnW1jtLqQj4BrNr+ABVirUXC/l7hFS/NMQUYh2dEfqDrcB5chNt
         I1+KrUOyS0JVPec1VCwze3vuQQXTXMNBf3mjuLP3HCbCd3M9d3XptnNIvMRYUynkZF
         BI1L1MRRS68+CxfsH19M71m6+I081mdm7P9PkL/c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.213.201]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6qM-1kXClq2uK4-00lYYa; Tue, 18
 Aug 2020 14:08:50 +0200
Date:   Tue, 18 Aug 2020 08:17:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] msvc: copy the correct `.pdb` files in the Makefile
 target `install`
In-Reply-To: <20200817213750.GA1854930@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2008180817290.56@tvgsbejvaqbjf.bet>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com> <120d2bb3e461717e5248bb4c97feab86d4e45c9d.1597655273.git.gitgitgadget@gmail.com> <20200817092431.GA1259595@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2008170750090.56@tvgsbejvaqbjf.bet>
 <20200817213750.GA1854930@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:C3+c8f8e2Xtlrw8dQuL8z09+6G8sx2+m08NnI+mkNCpjCewuJet
 1/EuiBB13C/oXWxAinC/RiswxvHQXXuN41n970Trh4ytLUhLz2pkDo3aXsIbPehZ3Akz5K/
 PhZG9h6jjaiXlLpDiSRyajxYotwWCEBpD0ZHTxTt/5ZrT8CiingF8lIHDYmgq4KHV7R2fPh
 xMoC6seD69/hxjarRWpLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7r86PuSVjSs=:+iDZsieW4g1gAmU+3Jrrgd
 UHW2k9idrzpG5p4n6Rc77Y+7RsAAQCuFuZRbUu+ubgY2itH0/WCXC532xBK78l2eWTCU4uHl3
 6LKLDwBOnyXzjK6RnBtCA7n8cwE1pfPhayihBsBZzO+A9rQThcjbTQqGkPg7ODqjP5WIg8u0n
 ZVxc89cWddR8XIFSbUE707u+6Vkv/ptCVBkr3eV7Rd3b8fDrBydk/Fu7bJO0z+JT5bgGSOBa+
 ac0mUKlD1CPePWXwocTrGlL6bA74Mho8fO308FeDBXTjioa4TgoikqAMH+H39jsK8I5o1hoPU
 DkDr1wdmtzHh7pKjGDBCI3zeoEsl8B1nGU5XzNPvJZrilgc5Z/IBjij/maSgMS1EThpzOQ86Q
 S64JfVPC9OiL+BtjfvSk3QB2HpVAUL+ho0gO19axJxcBgus1UTn50RmvcHLLGV7bstKOGalZ9
 qgB2ry7YIBL859n3EW3aDmiywyOwBshCa3EM/5vIpQg49jltF3nXcaOZZY0oYkp5vJoACiBHE
 xzepKjldj9L6J/fuiN+GpHzhXd0knIM0ejaFdq3fzRg2eHr94jjXd0PtlQzLGHHbJCp9pLJ/x
 ieJu4EeSW/Hr1Csk+zprk0qy93J6pb/vN6tI8/7fs54N7LN/m52eBHlEzivTjbrGxbaX3fnrY
 OV4lZX9ujDKncM+YwRYdhYQQYX/L4I6f3amszphtCBhT/vfgzHiHg92Jy36UtOnwA52w7dbD2
 VA7TdpYU7mtjs48GGC+SGkv+V1Gjsab/8OiRCEc7C0gM6cK3k6289QV/QzxRoHIbBLlR1HuY5
 hH1QaUfAoT2huygRcaUbRmp/8nxbHh6vcYQsnnEUkuUaPIRAAvhxmCLovel1NSmyEsedGFyh/
 26pprBT12iygT3hI2uuPUcOe9Tl9BN2wQPVx7JP1mv4uohogvpmqMFMiEBET2Gq46tFRDTNiW
 q3ihRZo0lJG4K7j5GRtVYuak4+5Wf5D/I2SiDu6xg8rlfRkaHVsDc2VDJD7K2VxhshCwetZy3
 scoH+g6mUnz7u65ntPnrIDNXfERKttFpfdymLcBvcOSYA91QNLEjx6/dKqNqK7ESz9RuNlLcl
 mQzjmOPfI/odlB46DOp+qrJO+4s+WLii91LH/Wg4XWT9Ep0j92U9pz/sg6MeP0Cs0e6stOnk2
 EV1iNvSboA4m4G/2fzZaffJJArSp0JEaaWIKimCIKKXFaInxkH7qamQRREhac0+61MUXo00bN
 IOeGC+gDWEUQPPGocP+D0Q9ULZkQcEwV2UsgMvw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 17 Aug 2020, Jeff King wrote:

> On Mon, Aug 17, 2020 at 07:51:17AM +0200, Johannes Schindelin wrote:
>
> > > The rest of the series looks like a good direction to me, but is out=
side
> > > the scope of my series. I'd be happy to pick this first patch up for=
 a
> > > re-roll of mine (which would require tweaking the rest of the patche=
s on
> > > top to stop removing things from the .pdb list). Or we could just le=
ave
> > > this as a separate topic and deal with the merge conflict (which wou=
ld
> > > obviously resolve in favor of yours).
> >
> > Please feel totally free to cherry-pick my 1/3 as your 1/5 (but please=
 do
> > fix up the author email address, if you don't mind).
> >
> > I have no problem with my patch series depending on yours, to make mer=
ging
> > easier.
>
> It doesn't look like that series otherwise needs a re-roll, so if it's
> OK with you, let's just have yours come on top (or independent, as the
> conflict is pretty easy).

Sounds good to me!

Ciao,
Dscho
