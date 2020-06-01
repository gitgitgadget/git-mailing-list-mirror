Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872FCC433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 21:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C052074B
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 21:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eKLvHTsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgFAVDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:03:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:51515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgFAVDS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 17:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591045388;
        bh=E/bpYGHOXhaE2xPbJGSrAbCcSE/PGworalF4GCEZSNI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eKLvHTslVewwlQmfsuX9PpkYDjgLfkeJOL0tY4SQoenPffAI8+d6uBj49igQHkg+x
         G6Q3jqt5ryyOJlG/iRg828VzjTGPNf4OucEzqsrs7AhKV+KVA2EMAl7M2pAxomhrte
         KqBdLCTyyUBlctEIUhoVoDO9VE5VP80CGr0jaYZQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.16.94] ([89.1.214.6]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTiPv-1jXlvq41hV-00TzV8; Mon, 01
 Jun 2020 23:03:08 +0200
Date:   Mon, 1 Jun 2020 23:03:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood123@gmail.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] rebase -i: add --ignore-whitespace flag
In-Reply-To: <5003e918-5f24-2bf1-fbb0-1730961af8d7@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2006012300460.56@tvgsbejvaqbjf.bet>
References: <20200407141125.30872-1-phillip.wood123@gmail.com> <20200527173356.47364-1-phillip.wood123@gmail.com> <20200527173356.47364-2-phillip.wood123@gmail.com> <nycvar.QRO.7.76.6.2005290437350.56@tvgsbejvaqbjf.bet>
 <5003e918-5f24-2bf1-fbb0-1730961af8d7@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Kp1IieYMzz7TV8jmyeCg61w9JlFfAlwgNy4SIjUgXPn14A26Gcy
 ETsuLccFUpa1LLB3zrJpxLel2cKq2H0lvx8VAs4gE8oSTmHKuMmHNhpCoxBkMC9kW3U8XgO
 MKlYa6jw0zUy+ww2VNX+pPjv/r2F/p1CDI+MoLIXpxHIhAISgpbF62liAnNI15PfM10Gu6G
 CIEOBZEwHTpDGnYGPQ1QQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mg7HI6V5S4o=:Kfx8dNDPFi9bQX1nIkwiya
 UNlPgj2EsD0LWqbd0Y0aQawU5IV7zABfj67bSi4Lj2feamm08y5JNKPOPao/SZU0HDNJzg8B6
 m+cFUq5x8YZVtsdrvZU18rE8HsobBeBLoUjdXMLLSl5jcuWActHoRMFFj4RX83rN+UcquE+6O
 lvyGIawcKf0ewpCYrP17ab4G4/CLDhwFTab5QagsYmb5S5I8cpn9gt8xkCwoTKGLHcG8FFQjG
 yW6W+/ZS7KmRrFrXvm/AXhML92rbIN+aBKsCBOuGL1mtwy/2DlZ4qoZ9vLQ01UmyjabwBRyfl
 efd4hCZ9cu56XFwJiy/TB3t8CF7HcX3/B80/L4D1qQoOuQybn+XmTh4jkSZ7v2Me/AsXLL70s
 AXXJM9UoM2RvR51pG7BFpF3xFODWnZHOPRNsy0S1YO0NgA4DwSMmI/o5z99/Z6DAQtfkR8RWT
 FnT0U/yuTyeQxAV4uEbF7aWmXrRErzpr1YwK1jul1ujj47R6bSDaZKVTkd3/7HpIEX0KzA+0g
 VGAFYU0DmQLBS8eGV2pmfHeT8XcPOKoVva+6L34y5A6FFMYDzdmQs5eE4jFaF2VW58I4DEHMs
 cgunft9l7hBMR7jnf1+Y5hIhgE23twSlQUj3y5HWAdXMi0PhRhjs2hKkevZdalHdUghc+Tht1
 Kk23aIU81q2AsnHZy/4cIvDmhdeLcKFgM2V4b4rxW/e0/d1/KMrG94rlfqU2ZUPiL6DWgcUze
 ZzBrDVqcE6NOuDtZAvPAXvFScQJ4GfTi/J3nvmsvd4nAPoZLL6LIil5vgaUA3CBiKr510m726
 ofgoyJLlKc9SFra9R72uPDAaeY9l8DNwii/iIyOFphHSDaRy+wHCcbly/LdQvDW6zSF82QpGH
 1dqVQe4PbcWERfMC4q1J6IRT32JBXBXjmzozL0/gwKVFlJsi6SjX5OFo132UFQaOoOAZoyZvP
 ICO43Z5TxQf34P55PMX7DYm6mLPsGJGnCt7a9IH7vUU1A3lijj8ET//fXpoSYToJM6q5GLv5l
 m1gFNVgOVzer1WG+4iu+LQtAaAGgQT4371GjDOJmC4+YRFFkZuhGdLOWqn05B3SSHHHjxO1xA
 Bpw1mDqf5GkslxmBZeoObLbwaFx1o4GZwE/y0axdMgj869qeYTM/Esh4rxdBkhM+/WCpB+REO
 XmnFuPtXnaiKR60HbWRuhcN8ZY0O0gXQZ8WVWOJvtw9U/7nv52GGgUNA//6kcTNXMcw2VoKji
 rRdIa+Hf9HIgMxp6C
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 1 Jun 2020, Phillip Wood wrote:

> On 29/05/2020 03:38, Johannes Schindelin wrote:
> >
> > On Wed, 27 May 2020, Phillip Wood wrote:
> >
> >> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> >>
> >> [...]
> >> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-opt=
ions.sh
> >> new file mode 100755
> >> index 0000000000..fb5e747e86
> >> --- /dev/null
> >> +++ b/t/t3436-rebase-more-options.sh
> >> @@ -0,0 +1,86 @@
> >> +#!/bin/sh
> >> +#
> >> +# Copyright (c) 2019 Rohit Ashiwal
> >> +#
> >> +
> >> +test_description=3D'tests to ensure compatibility between am and int=
eractive backends'
> >> +
> >> +. ./test-lib.sh
> >> +
> >> +. "$TEST_DIRECTORY"/lib-rebase.sh
> >> +
> >> +# This is a special case in which both am and interactive backends
> >> +# provide the same output. It was done intentionally because
> >> +# both the backends fall short of optimal behaviour.
> >> +test_expect_success 'setup' '
> >> +	git checkout -b topic &&
> >> +	q_to_tab >file <<-\EOF &&
> >> +	line 1
> >> +	Qline 2
> >> +	line 3
> >> +	EOF
> >> +	git add file &&
> >> +	git commit -m "add file" &&
> >> +	cat >file <<-\EOF &&
> >> +	line 1
> >> +	new line 2
> >> +	line 3
> >> +	EOF
> >> +	git commit -am "update file" &&
> >> +	git tag side &&
> >> +
> >> +	git checkout --orphan master &&
> >> +	sed -e "s/^|//" >file <<-\EOF &&
> >> +	|line 1
> >> +	|        line 2
> >> +	|line 3
> >> +	EOF
> >> +	git add file &&
> >> +	git commit -m "add file" &&
> >> +	git tag main
> >> +'
> >
> > The file contents are repeated in an awfully repetitive manner. That n=
ot
> > only makes things a bit hard to read, it also makes it all too easy to
> > slip in bugs by mistake. How about something like this instead?
> >
> > 	test_commit file &&
> >
> > 	test_write_lines line1 Qline2 line3 >templ &&
> >
> > 	q_to_tab <templ >file.t &&
> > 	git commit -m tab file.t &&
> >
> > 	sed "s/Q/new /" <templ >file.t &&
> > 	git commit -m new file.t &&
> > 	git tag side &&
> >
> > 	git checkout file -- &&
> > 	sed "s/Q/        /" <templ >file.t &&
> > 	git commit -m spaces file.t
>
> I'm not totally convinced by this, I'd prefer to be able to read the
> contents rather than having to work out what sed is doing. What about
>
> test_write_lines "line 1" "	line 2" "line 3" >file &&
> add and commit
> test_write_lines "line 1" "new line 2" "line 3" >file &&
> commit and tag
> test_write_lines "line 1" "  line 2" "line 3" >file &&
> commit and tag
>
> It does not get rid of the repetition but it does dispense with having
> the work out what sed and q_to_tab are doing

Sure. Your version is still tons easier to parse for a human being.

> > 	git diff --exit-code main
> >
> >> +	test_must_fail git rebase --merge main side &&
> >> +	git rebase --abort &&
> >> +	git rebase --merge --ignore-whitespace main side &&
> >> +	test_cmp expect file
> >> +'
> >> +
> >> +test_expect_success '--ignore-whitespace is remembered when continui=
ng' '
> >> +	cat >expect <<-\EOF &&
> >> +	line 1
> >> +	new line 2
> >> +	line 3
> >> +	EOF
> >> +	(
> >> +		set_fake_editor &&
> >> +		FAKE_LINES=3D"break 1" git rebase -i --ignore-whitespace main side
> >> +	) &&
> >> +	git rebase --continue &&
> >> +	test_cmp expect file
> >
> > It is a bit funny to see these two invocations _specifically_ pulled o=
ut
> > from the subshell, that's not how we do things in other test scripts:
> > instead, we run all the Git commands _inside_ the subshell, and all th=
e
> > verifications after the subshell.
>
> The idea was to only set the variable where it is used.

I understand that, but I think that it would be better to follow the
existing pattern rather than introducing an inconsistent second one.

Thanks,
Dscho
