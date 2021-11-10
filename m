Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B135C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 15:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA38361205
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 15:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhKJPCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 10:02:47 -0500
Received: from mout.gmx.net ([212.227.17.21]:49047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231731AbhKJPCq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 10:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636556390;
        bh=URnjfdsuluoestkIb2ZN8rpnj0LGn7+6Xa2tL/iHV8o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aZffVlUXTq2EmR5uhxngyCVvtIGgS7ha85MzpeXea9nwHAfYNgJiaKRSK4k5vdaYS
         zephiT+sndlC1v1z8MiTQB8HeO08BpLUkuPAiuUtNn4vIlRPxurgWnMT7fL9o+iReR
         tKeMStdbj3xsfAAnLTfP5WqbddU73Up2f989/Nns=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.212.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKYx-1n0Pij0fi3-00Lmnk; Wed, 10
 Nov 2021 15:59:50 +0100
Date:   Wed, 10 Nov 2021 15:59:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Paul Smith <paul@mad-scientist.net>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 3/3] Makefile: replace most hardcoded object lists
 with $(wildcard)
In-Reply-To: <211110.86h7cki0uo.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111101547120.21127@tvgsbejvaqbjf.bet>
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com> <patch-v2-3.3-cd62d8f92d1-20211101T191231Z-avarab@gmail.com> <24482f96-7d87-1570-a171-95ec182f6091@gmail.com>
 <211106.86tugpfikn.gmgdl@evledraar.gmail.com> <40dbf962-2ccd-b4d6-7110-31317eb35e34@gmail.com> <xmqqtugl102l.fsf@gitster.g> <nycvar.QRO.7.76.6.2111101332130.21127@tvgsbejvaqbjf.bet> <211110.86h7cki0uo.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-578956016-1636555831=:21127"
Content-ID: <nycvar.QRO.7.76.6.2111101550410.21127@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:Q2RIEpjCVUBNBCOqftNZxnmsxbhKW9UFmmylWnIt8XDs/u9qNTM
 GXjNRHyuMBtVAIqG6Px72fPNmBb/DlGKt9/o3apAAXCmgDan1le64Hsc1sijPlk8LK7R41q
 KqWZgPvb1OZcH01gngYKeTQgPVevaJbVMqukOh3ZwH/rx9TufaNryFpLbPuFRZeGzPKF7zY
 t71Iln5QsvN5r2w9tSjyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ib99SUrrSeg=:6jCA+n7G/TzeweOQb8FdFg
 8t1WJtbx0kj4acSvMQVZ75xwEvaW8KWNon8gJxtzR+uiNx0wBs62/FyDT51d2dEtK8OsA1wI9
 PnJK3ng0yQKbufqTcwhfD7V5qxkNXf+l7aIrf430mEiV50cjxXSDcnN9FAIMkxFD8NdXGmeHn
 VoHerOVYQC6iQASh9i/YkpdGkfmtgR0b4iaIizTpnREw18ETPHjLSNiLmnopkiVUnVcqJRh0M
 AQzpileyVD5lVG1Hc/7n9bwzSPGosx1FVtrcRPgECe+MEmRWVS5nQ1Xt7VG/hFFPW6/3DrBS6
 TWS8t5fEWD5WjPjDRVWOhHqrLvCZEfeZfnJ1tA54nTw9qZMlu5wFtoMvtBO5uX1kh9OAF7t6J
 700wrQ+YEHG2JxvfYOXQhDyz+ydnlz76nbr2fcugUNbLFkXlt3s6T6CSq1umoJxlJ3H/Jr9Uf
 izSCiMO6DcZDf4Ho+vWbTc3Os3UvloYzXBZRdpA/043DLAP1BfBkCeBFwUFADB8VZhyrMzN0Q
 0puMK2JVLwFxIbUKHevTXa2NmhqdxUFTITyMFYb4uGDk2Ksjv+r/V2cGXbECiLg1OBVJqIFpr
 45dMbaYrAmDg4ujNOFK4VEOznVsgjp8u1ZD8whxZg3RYQ4/+RQuAvpW4HDP6kGqYS9y9JnIpu
 Tk3q4ZjmWvoPwG9Y9Zl4YFBkUD9C3bm5hFRJyT4mDgsmqzWGqy438eDgyzxUSenjVw5fDbW6f
 0fOamcVq/ZXZhGEQD4J+lrZ8yE3KojBzRz+sgEOqXTAHZlJ2ajNhgd1luQHJEAHcmsAEoPLP9
 J2GkKs0xUFWt8IbE3wvk9Pj7wQ8U0lioQWhHACQZxb832uDb6G6ldVVKXYL1Jm79lmRvgTBUr
 mVzR330CMhkLDORROPJekYXw2RmzryavI11PK58fjkZCSE1NSednxQNCMkIoSkqz67/zLqMF5
 tVGsTFd2ZBW7OaZNDxcOlVSeZIdsvhs2HLeYHAVZAidFFXsVmJ87l0Wks+y0oiSD0spQYcZ3K
 CPvD7ohAt6aTW1Anav7OEwFoBC/E4MrY7dBK1sfmH2Lx1sK8HTkLCohMNLLcLCD4wByM5sa65
 dMxGLGwb9X+TNk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-578956016-1636555831=:21127
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2111101550411.21127@tvgsbejvaqbjf.bet>

Hi =C3=86var,

On Wed, 10 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> If we're not OK with $(wildcard) as a pattern that would mean changing
> all of these to hardcoded (in some cases quite big) lists somewhere:
>
>     [...]

No, it would only mean changing these instances if we have a concrete
need. I fail to see a concrete need.

That does not mean that we should make the situation even worse by
converting currently hard-coded lists to wildcards. There is, once again,
no concrete need for that, and there is the good reason Junio brought up
against such a churn: it is too sloppy.

> [...] I think we should remove that LIB_H thing entirely.

I think we should take a break from refactoring code where it is unclear
what purpose the refactoring serves.

> > And to be honest, even `LIB_H` and `FIND_SOURCE_FILE` would quite
> > potentially better be hard-coded (with a CI check to ensure that
> > they're up to date).
>
> That would be a bug, just because I don't build on Windows doesn't mean
> that I wouldn't like "make TAGS coccicheck" to find compat/win32/ at
> all.

Talking about `coccicheck` in the context of the discussion whether we
should make sweeping changes in our Makefiles, all while we're supposedly
in the -rc phase, strikes me as a distant tangent of a distant tangent.

Ciao,
Johannes

--8323328-578956016-1636555831=:21127--
