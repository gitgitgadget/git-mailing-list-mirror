Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEE4C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 21:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346749AbiEUVtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 17:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbiEUVtU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 17:49:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03F238BD0
        for <git@vger.kernel.org>; Sat, 21 May 2022 14:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653169741;
        bh=WAlY+jwJqArJNQ0PdoYJYH3vknYsxomZvkmtBFUkrBk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XJeRIxjzOcRrVraecyxjezRvjSBS3Mf9UKiE3G8erxZp1acEDWAYFcy+6kokJZtNk
         uBG2X2cpuD6qDMGP62Tg0tpDuQ4lcCu0qd3uzAZMWIDKo4cpd8Ho5CHeqVu/2qV8M+
         q7a+fiCyBQcBY6pniMWrmigdc5YmuGxbkob12Jdg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0G1d-1ngkkU2QIZ-00xGPV; Sat, 21
 May 2022 23:49:01 +0200
Date:   Sat, 21 May 2022 23:48:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>
Subject: cone mode as default for sparse-checkout?, was Re: What's cooking
 in git.git (May 2022, #01; Mon, 2)
In-Reply-To: <CABPp-BF9ftVVp7-ZZuhak456x12-H941Nj4qV7gNf71rrugGhQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2205212347060.352@tvgsbejvaqbjf.bet>
References: <xmqqilqnvacd.fsf@gitster.g> <0facc01f-ee36-333a-eb25-9c98d616700e@github.com> <xmqqy1zhmftk.fsf@gitster.g> <CABPp-BHDKRX4sW_Jjqw5j7Voas0X_xkFZgg5Jqk0TkNZOd7k1g@mail.gmail.com> <xmqqmtfwezx5.fsf@gitster.g> <CABPp-BH8VsH+Y3UxAvZM2kua8XGRE1RyenrESeYwofcq-=kjbQ@mail.gmail.com>
 <CABPp-BF9ftVVp7-ZZuhak456x12-H941Nj4qV7gNf71rrugGhQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:q9/6iWQq4Muo/OqMuRjMeVvFOZeQKdtaJ7SJsn3/yqE6njjj2m9
 0XJseXkzZ7pLfjaa1XTj7K4QTZ6hdAfuBwfDoiEiApjcbzgHC3J1kfdjmriDa+YUBWMOmRW
 z6iOy8ORAX7mItbVGH1qBuiTpZPgX1ULOCPAQQy6jMfOkbSbnf3lx7nyUAyng4rbkHahA4D
 cHTcLP2SEgG/VKVhKSRfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XogbvBdlrUk=:7wl0UDCrU81dGK2BDmRq7I
 /ZxeHBgz0s6QTuK/uMij1lwwyuqx/E/vFMjFWC76SKoMY9CFKREppLSsi83x2PE3+ON9rFdiK
 wv/O2Qr238fGG7pmQc6zMRzSMz39K4/sUnxA48nKcgDnxlOoddSJ7LS6czLO1+/M+Jvs40VlW
 sJ9xzerqyMHJaN6bZjxWjdxJ0oK79hiu74+xn1eWWTJnskdwIiDmQd2Veh4gapHsRdjLLwJC+
 A11Eov5Ld8Nz8H+d6imK68cYM/XPiYBqYhfbA84j1T8RX0ndBBE1J38p0GcGBuYyyiMeyVXur
 1C64Z2K+AFN/rO40XqpEq2AiJ9cvbrTKvQdiljAy8zi9uJcXca3YdQ/ShLjbdbLivD/adp7mw
 cTciuy92gQ15j8GJuSVT0doMKERVlNnrOXJnr8YmELLT4tiH34HsOYHMrebFo4HzVgvVNdjVq
 2om+RTW68stDKMIqpZ9pM7RJYWIoQLjbrwmFLh1Fzlnpb/HyBOdJK5+g+77ZxuN0kqJLvdqLC
 x5EgRTZRKNOEbNoUkDwwjtazHlp5j/tDvjUlqVulpcUPZYscNy9Vu0o3+0w/6wRnX+3sEvgfV
 O4Htm4UTyLgkr/ATpy1V94LTPyISbL2N13ygnO2/UnTBdczo/Swe+7Z2Gwo2p7iUvSG7Nqcpg
 zoslJyEis9jViAPWQzmpKUgYbcaAR4m0GEJ4nycvQW7wTA/ZigRjV37MM1aAx/+YSVmxn9DBh
 5iMK4AvFNfV+1jgVywfdij6Mq39uuqxSTXIxwYOYirjOoPj5HI1DhIU2F7nf/u4zxeiIxdnmW
 elec1nBo1S4wLqcgtS+GU54ATl/J46g/aZvNFSYQYCcDCMSsUNuNQwadilFa75z5YIeoz79Zn
 DxvdwLr18F4rjSgy4DCZKJPcZiIgu5y6DXcjff0Z8Rtmx5z9L47eWQxS+ioG3gwFFwlgQYUWR
 P63BxXHrZEFTbqmFhJMmtu2PDMGJuJCQyRtBg0qJuGwTA0HiYME+ffafy4w4MeuuDiYppSdZB
 OWw0/3uINwJA3rKxuVdBeRuI4TMLLT0Qah8AHivVU1H8PpNiKWlcf6qYav1U6S7un2Llu4iCu
 Jw9Vi7S5IrkyCEUr9qdu0yp1ozOFhIt5ihFzqBvj6oMBnlQwY22X6raPg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 5 May 2022, Elijah Newren wrote:

> On Thu, May 5, 2022 at 9:15 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Thu, May 5, 2022 at 8:56 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
> > >
> [...]
> > > I vaguely recall there were folks who didn't like the change of
> > > default the last time you brought this topic up.  Convincing them is
> > > not my job---it is yours.  Mine has been to help prepare the code
> > > ready for public consumption when that happens.
> >
> > That's a surprise to me; I don't remember anyone bringing that up,
> > ever.  Did I somehow miss it??  I'd be happy to talk to anyone and
> > hear their concerns if they do hold such an opinion.  Over the last
> > year or so both Stolee and Victoria have suggested such a change or
> > said they wondered why I didn't include such a change with other
> > sparse-checkout changes we were making, and I mentioned a few times I
> > thought it'd be a good future plan and finally submitted it.  To the
> > best of my memory, no one ever offered a counter opinion.
> >
> > Are you perhaps mixing this up with the case where people brought up
> > concerns with suggested tab-completion changes?  That's the only other
> > related series recently where folks brought up concerns with suggested
> > changes.
>
> So, I did a few searches through the list history for anyone that may
> have commented on cone mode as default.

FWIW even though I am a rather heavy user of non-cone mode (the structure
of Git for Windows' SDK does not lend itself to code mode, but e.g. for
the minimal SDK we use in our CI/PR build we definitely need a subset of
the otherwise too-clunky SDK), I am very much in favor of making cone-mode
the default.

Thanks,
Dscho
