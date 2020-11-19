Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D3FC388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 09:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B3DF2468D
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 09:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lr+NiPKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKSJct (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 04:32:49 -0500
Received: from mout.gmx.net ([212.227.15.18]:37201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgKSJcs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 04:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605778351;
        bh=BO3+ifCPH15+T8ZwlWO2XP+PoAiLEZLdhFBa/SHWzZA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lr+NiPKjvLo0d/VSlvrJwsSKRlhHkEgG6o5c3s2TDHAssXhpVjodF0Ii0Z3ZzRPyP
         84rY0skBtE2LRN34WKarrZS5rl0XuGV99d60EjRNxhvg4w4TP0Tem+shvzC1yWiqQi
         8Vx0MStI9h9gB9DxakUIfHy76Twi2hMHEarqOzaw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQvCv-1krYgi1qhb-00O3iY; Thu, 19
 Nov 2020 10:32:31 +0100
Date:   Thu, 19 Nov 2020 10:32:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>, git@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] tests: support testing with an arbitrary default
 branch (sort of)
In-Reply-To: <xmqqsg963bg9.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011191030170.56@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2011131519170.18437@tvgsbejvaqbjf.bet> <20201113161320.16458-1-avarab@gmail.com> <20201113191418.GA764688@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2011132229480.18437@tvgsbejvaqbjf.bet> <87h7psg6lz.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2011162118060.18437@tvgsbejvaqbjf.bet> <87ima2rdsm.fsf@evledraar.gmail.com> <xmqqsg963bg9.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1721514553-1605778353=:56"
X-Provags-ID: V03:K1:gk7/VOuRtGa7WydyZpxO3Q5TljKqAUzn11mUhrEiNSvTXgR1LvE
 ZAwdMrl9+wTZrMirLJkUOq/81MTg0hzNdW6UwMhy2MMuCanMzAFppcdjpyHdYv0HS9ZlYtP
 MDryUs2jmojlTJWtxx7QoPnrAfWr7+TYyjxt0TVqAAZOnhXyyqR0JtbTi3AHrmTyxbGw1uH
 kGtGGUP0WOMwtSrSTPPgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zqP6QITG1x4=:EUyIDOZQJBUTiSkUSvoAen
 ZG5SBLZfnyqTGNYmhy32IPUe6IMYXJW6zchv6A9sTIgMc7sL6jRSc22KCQyKrzncLbC2HQMWI
 UetLfPkoKXsY4iJAXRXYekJdq9FOdPvn0dhsCrFmBYr7WWEdbMQ7vKfn3ZXjIkSPBCzHgZp0f
 BGut3wXtw7rJf+ajM0w1A2L5zidPBc2Vq1trUYJ3wlC2N14RV4qUL1TiD2plAhpPXkiulP4Ls
 BkCgiApZXYbM09uMtINaEkuaK8LqD2Dbn/tf2KUkSSwKBXU96fcMv6P6Y9+Qjv7ggDhGw6ISk
 4huNUBNE3U2LpXpAGphzq3vY+RnkUZp+fsc504q+hxBTPUwTyBePSLZ9/5SwgcTg6HO4OBvsZ
 9SEsuF377OW+G5GzU+L3Jbpe4j+/xNI81Wo1BmeDFhq4hnPjKqG4QZjfxRC/T/TMtGkLI27j+
 JesS7YIX684n0XPZegr997rkGpLnwDG9LjLyHMMx633vqOFZ01B/c0GON4aOYJGKcjCCGewWD
 3KQ6m2J0dzsJ37Chcnep0g3QSwTiNsnqvgextyQPrkNVC0iWP9EkkjaiEI2JuCZHGuUNgtj+G
 HfZMRN41WwejZwvP1F5iCrLj2W1EazFQNI4BibheZL8mzRWZcpRnMl1AWGlWwODf6C39jlz8J
 84iBr59KxlM+ORVpaIOpweHfO6Bqi+LxzfEuolbwSLrayj2Ul+WSZsku6ARAQGqgZoE1NIedm
 NbBUaIdjxXQemR3NxOXbX9M0f5s2vbBsMUQF+NEBCwrZGJcGLvTrRSBOimyEob1y8biT1yzqK
 2bazITuobxKw09VPrqCyEJrx7MiuOBnN/lOm5ALOiYY2R8ZBEK8ehmp70lghGH8klC7uT2p+r
 YpAXi5XepnP9cM1TOk+NZQ1yfJIk8o3DwejnGzf68=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1721514553-1605778353=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio & =C3=86var,

On Wed, 18 Nov 2020, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > P.S.: Shouldn't the pull patch in d18c950a69f be using the advice
> >      facility, not warning()?
>
> I think warning() is the right thing here, as it is self squelching.
> Setting pull.rebase (even to 'false') is sufficient---there is no
> need to set advise.setpullrebase to 'false' on top.

Right. The only reason to use `advise()` would be to allow users to
squelch the warning by setting `advice.*`.

On the other hand, warnings are not colored, but advice messages are.

And now I realize that the same holds for `init.defaultBranch`: it is also
self-squelching. And it also might benefit from the coloring to make it
stand out a bit.

Thoughts?

Ciao,
Dscho

--8323328-1721514553-1605778353=:56--
