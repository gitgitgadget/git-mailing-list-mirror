Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1547DC433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 15:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3BEC2078A
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 15:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EgsnV9Hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHZPGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:06:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:57837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgHZPGY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 11:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598454371;
        bh=dEZVQ0tDrj2TbT0AoSzC0pwf/Z8EVdBKCTrjQcJ23DY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EgsnV9Hxs94EfVefMtd9ziwYvZgE8r65QXcrxa2r0qQWWK39dWjH5t1haLQtymJ7h
         ZzncMxVRf8Cx8zEx9ANkhVglqZqe8lgrAqbESAR99f4H0NPHPC3XwCEt2KLqG1+fD6
         0kEjUnVEfipht1wED/dRmkze8/XPtsiYc2C7/xiw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.212.143]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lYB-1kAfsu1rHP-000reF; Wed, 26
 Aug 2020 17:06:11 +0200
Date:   Wed, 26 Aug 2020 10:06:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 3/3] git: catch an attempt to run "git-foo"
In-Reply-To: <20200826011718.3186597-4-gitster@pobox.com>
Message-ID: <nycvar.QRO.7.76.6.2008261004120.56@tvgsbejvaqbjf.bet>
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com> <20200826011718.3186597-1-gitster@pobox.com> <20200826011718.3186597-4-gitster@pobox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZFGNCev+htSP37wUPyYYqWWRMDECPCxVtnP1Mv2ENidtgkj/Fpl
 6a2VUEAbWvJ5YoUSTHJWhBDnaICSJat10V48oJbMfdCFRNgn9euOY09LftWmTNjo5MIF6Vj
 Pc+vIRxRIC1rvvneSBmZ2su2bkADL9Vfpo4d6egYBATq5ZM990Hkv7jwdbHSuTEncTbhJPz
 5yHXS4SeTl5HkL3MMzbWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LaWLK5b9ReM=:TKmr31jb7wyrW3rq6CAh8R
 1/WrKY0dMR+egiVPByB1wk0Hvcr5b0xMaFpT2KZoA/lQ7IAQacabZaKEhz8Alp5ATxm9pYkJS
 2Zo7WmanxcRgnWC3oO6+pySfvYjVdNF+iBrN0BUJa5E9ALxdZa/mYKucgQmZTW+4fGD/HUMxp
 Wgg9FYRPYu6JZ1WAo6zvMB/pl+sMf57PmA52I/aWhneiUc18/B/hOKGscqv/iFwY40Qbr/GXN
 OPm7wAbcYClqmOdBHWC/DOZX/c243BEY9ca1BvjSlvyG3EP4QABeGFUGit/huMiFlyA5UlWL6
 LINDYNTwjp8bKEWeJ/xD4knS2mjoc1+UWg+w1atdjvNK1aljyOXZBi2ILcBQaCRk/PKCZINjB
 Y2yg5g3Fx6vqsepSkG5xl4cWbjDozMGrqOiJdNLLWNQbuVDHqc6OQEPJBVRfoRlhxTggtwUA+
 u5KULUoMqJh2YkAcD8ege0NpKyZXdpXHqTmaK9+yUop0gUiLACKr/MwZ5nFrUUqayk9ibJ3tN
 DXVwNOOEm/ksLPU7qu3HJreCyH9xCiRTpldQABv+/BayFQi5yxbAFhFDi+WJ1sSxtsBsOtJk4
 3vONHDTSIU8hm7iWWkLIqa6l/wLXHHJqO2Z3D/JSiBzqBdQzgvfXEeFFyFzK9t5cE/WSpciT4
 BAeJo8801fskB8EwkenmaULgHuc36X+/TA/Opz2CYC08VESz5YWqDAOgLCntcumOlLOEXPbip
 3ZvdhBNY3GXIJMlCE5UYm7QAWjKBFqr1XC0TRPwoypQnZbQkqaU1Mnr4CkZUQIHfdwMS9JDwZ
 LoegjjPkqU/Qp5cycGPUXYe1s//r3dS+f8PKn/4HDosFkwqVkIg0AZjhDRGY+MP7hZdwDGZow
 CST7GCKPCGel8Esh0AFwWhDsRC5S8aULLLKyjQmVPSz5AXKKszClwbdVLOFnMSHKjGwNWzF0U
 3YuaWxi/vKqVy7iHAqg7Zesy3BoE4TgJYUOJ/tq7fWYSoFCXOhXHpuDtr/o3IDQK6LoZTDYgh
 8U6HFAkkxL7HMrbi+HsTf8zKG9O+KJRuBAo3OT2bjGvmh4ydqhSVdoJYsJBvGC9UO83P5o3cg
 cgxq+15WJ3AKQXMFqcm2AL2O5XQw0NZwCMZw+nu5ib1FYzYCnHfYJcB77+ZiCvbaAYkOBTlNy
 gqfjszF2VBPNmwIB0ukq1PXxZpHD3PvqUoXXyDEnLjXcvnB5EOUNGSDmmy1l7AEeHxZMOAFDn
 jU7IxGue0YmdKovyI4GPzp36wBTt0wBbtmg7Geg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 25 Aug 2020, Junio C Hamano wrote:

> If we were to propose removing "git-foo" binaries from the
> filesystem for built-in commands, we should first see if there are
> users who will be affected by such a move.  When cmd_main() detects
> we were called not as "git", but as "git-foo", give an error message
> to ask the user to let us know and stop our removal plan, unless we
> are running a selected few programs that MUST be callable in the
> dashed form (e.g. "git-upload-pack").
>
> Those who are always using "git foo" form will not be affected, but
> those who trusted the promise we made to them 12 years ago that by
> prepending the output of $(git --exec-path) to the list of
> directories on their $PATH, they can safely keep writing
> "git-cat-file" will be negatively affected as all their scripts
> assuming the promise will be kept are now broken.

It might be a good idea to also instrument the existing scripts, to show
the same warning unless they were called through the `git` binary.

_If_ we were to do this ;-)

Ciao,
Dscho
