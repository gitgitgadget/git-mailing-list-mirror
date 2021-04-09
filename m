Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A192FC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6826161105
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhDINxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 09:53:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:41837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231599AbhDINxn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 09:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617976406;
        bh=WBklgfnBGng5zb+N+jXS6MhHOrKWziHvuqhb5FCZH6Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FUyHmCugyFXPBUq9FjtKoczS4RXM+rQ+fQJ75Ho8Y3j6945+oDaUN76uepke/smxM
         tLpUcIVt8S4TRGEEusdYwoLBTOzxgNg2S1ifjm9d0hVXMhopkJG5/6qLOIpw+8+4u6
         hW5ZeZV5GaVBVQB2oIEwm58lieoPCs7eCD072Yfo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.233.45] ([213.196.212.198]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4Jqb-1lV8gm3MW1-000Oss; Fri, 09
 Apr 2021 15:53:25 +0200
Date:   Fri, 9 Apr 2021 15:53:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: unifying sequencer's options persisting, was Re: [PATCH v2]
 sequencer: fix edit handling for cherry-pick and revert messages
In-Reply-To: <CAP8UFD1WsjB_shHnRUcH3rnQjwh0yodrETq6zh39vnZnHQpVyw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2104091548500.54@tvgsbejvaqbjf.bet>
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com> <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet> <CABPp-BGwAtpsQJ8U5N1q21PMkideptY2MB2PNgbPqvya+XuyHg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2103311533340.52@tvgsbejvaqbjf.bet> <3b117e65-bf9f-af13-b093-28bbbd6f9bb3@gmail.com> <xmqqa6qg4d0i.fsf@gitster.g> <CABPp-BEzayZkEZ36CFNBGz9X3jv0MNUnWa2EhzKKmWcb83yRmw@mail.gmail.com> <xmqq7dlk2ug9.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2104080438080.54@tvgsbejvaqbjf.bet> <CAP8UFD1WsjB_shHnRUcH3rnQjwh0yodrETq6zh39vnZnHQpVyw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cyr8PFWxc9NeBEBt4wiNmMtI9OuubSdM1SZ6sa29k2G1q+u6Lfl
 n/xDFqxNTH7c3VUQXfnuDgHDe4mKoDn2E1uGamE1bd5ypPzSxZX1WMAWtz//9U+ahwlepj2
 nJTbcbaYA2qoeFBRzIWhbddCKdDwmSe9b4IAkJ5TVP1mjsq9woRCqCitzNjaqo2NJJik9DF
 VoNgBKb38291qgvHdcKdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iTyOogHk7ME=:OySLjXJtDalc5YG9qLMnvc
 +kZ0ChkPOwpeWtWzGJ0N8gilRWqeAHF2dB9UISt/ymytpDa9wQncxOGq9s2GivoeBN1o2cRGA
 NNVYi/hYAkO4uTomwrExTRChWVw63+CIXnYUxmCj8VjfvMBFVmvSi3NFuVR/C1rsaaKqVoS+u
 ihn/QA03j9xD8EC8tixIoYcWiF8aKVhSqUqhYfWrQxAr5SBhh5xDcs7KUDPbF/jcuIaVu8wNH
 HhHuKxhtYO2IOakzJZdUgF5DRYc4Hdg83UCcVFO9aSJ/5VHAZfFCX0m9rCw70E6iPsSSxARnK
 fkCcE3CfuFk6SXgicTXrokOJfjIFbQ3Ul7pTrUNNwAATvbGfJh9oaXOQQV+So6qqiSZOQrxN3
 KZj5aKDI80Eb4XC8oezrj9kXm9jLo1jttW26x+bg1DLaKbUqLBV8ksHvDGo0ZhLrBYKIUZhgO
 JwTHfXjBs17Zdt6pBAPdYHZBTYWlJ53LBr48LrO55+x0774wGmnsdAfHreCBhCf43qmHvQpj/
 rJRb2qD4iB4vWCzyuSa847o09S5ZWvULhpjsAuKTXncqbWqKs31asdADNztBYwAsbo7LhO9Pb
 RDnD/muF8lUlRmYIYS4zrZvAarHwTOCYRIMFVQvrIXTdNoXSwaUqmJAOs0DacoWSp31fKkCJx
 mS1gzyLONIsQTekuBvGwpf8it6wTLzmC/UrxmDug3BrllEvge9JrbwuJsQq/cIyYhk+5B+m0J
 kpgccOxaD3ABz+0wMjov7IMMTOZUKQgmgd2HQW9647LFb624OK7J/0lkAMj+GqzjkTjRTVSfD
 KABM0DWd9m8Q2gXgriMNV3BMw+9AwQYA5DHbU9bq+R5TDZjcjejsvCGvY64Lyb5IKTgWXS023
 xeNkL/X9JFxsooKLnVA50tJ2XnHrQx1Vx5GXvsA3Y9klajAaCNB4vNTfhHzYuxYi77oLaLn4H
 80BZ1Zd6s4Z5H4yr6FNV5wp95x2Z7Bi7H0E5YZ+70DPeoCrO0KL2MgpJgIf2EhwVW/rznFrES
 wZvaTpLuC2WPSrpGQ+a1cTe4USt3JUaVjZTnIiFfBWPHutxq9AedVJ91Yw8IQBqvp187Ge6Pi
 FE3fM+TS5V+GwfZs1XhMyUtojlwwZGFaFm2WV/cJUuc6/Ve8eIhXah4qzqvN91w6/n1272DEw
 5JUAFKXwAyRIKbduG4rSiffZJfyRTAr1k09yMc3IHWzmYrFUxLjyM0VsYQgHCraj5ZvmV1Jy2
 IkkP4pBsvaGPtE5Nt
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Thu, 8 Apr 2021, Christian Couder wrote:

> On Thu, Apr 8, 2021 at 2:22 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Fri, 2 Apr 2021, Junio C Hamano wrote:
> >
> > > Elijah Newren <newren@gmail.com> writes:
> > >
> > > > Even if others now disagree with the above, I know I can get a hug=
e
> > > > speedup by changing sequencer to stop per-commit wasteful work (st=
op
> > > > forking processes like "git commit", don't write control structure=
s if
> > > > the rebase hasn't ended or hit a conflict, don't update the workin=
g
> > > > copy or index or reflog).
>
> It would be interesting to know which of these updates (working copy,
> index or reflog) is the most costly. Of course the best would be to
> compare the costs when updates are done at each step vs only at the
> end.

I would bet that the worktree updates are the most costly thing.

Note: there is also the step where new objects are written to the object
database, but that is a step that we can _not_ skip.

> If the split index could also become the default one day, I guess we
> could be doing pretty well even when some hooks are installed.

Hmm. My opinion about the split index does not match yours.

I'd much rather see us tackle the challenge of allowing truly incremental
index updates. That "split index" feature feels like a bandaid that tries
to do sort of an incremental update, and fails at it because it is not
truly incremental. Granted, that would look much more like a real database
and is much, much harder than what the split index code does (think
e.g. locking).

Ciao,
Dscho
