Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D81C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B75D64FA1
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBDV6g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:58:36 -0500
Received: from mout.gmx.net ([212.227.15.18]:58299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhBDV6f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 16:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612475818;
        bh=25vvz6JHW4cYnvYz3XK3kipk8wj6KiADHeVg2tkz/dw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SuFJWIlKT0XdhQ4KNpp/5Pm2wEUn4App9kQjplKxnl1P4wpBLLHhYhGTuz/4ENawR
         FKdttMU8dtk3dv1/lUFsCJbWClcb2+BBbahMb+k28yP5wADQIc6HnDdel6dplc2+aU
         QxVgn1oKmK7cTqiMse0x6j8PNWTJJQnzEjWJYe8E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.214.8]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqaxO-1llV5G2lOq-00mY3f; Thu, 04
 Feb 2021 22:56:58 +0100
Date:   Thu, 4 Feb 2021 22:57:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/3] range-diff/format-patch: handle commit ranges
 other than A..B
In-Reply-To: <xmqqtuqr64oa.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2102042256520.54@tvgsbejvaqbjf.bet>
References: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com> <pull.841.v4.git.1612431093.gitgitgadget@gmail.com> <448e6a64fa157990fcc973ce2fe4a9fc2ba1ab32.1612431093.git.gitgitgadget@gmail.com> <xmqqtuqr64oa.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XecLg/h7Th8TK7E3t42dOPaQ7zOICjsMMYwsn9XKjFdGCFX3CS3
 8inz0cblSXoYFrQ35dhRT+d1U3yKBc0WRgp6oOpuxoM0hie1SKGaqH6BnHmps4GBkM3Qnm4
 /fZDPzK6LvITzObWc3l8LBzWHw5sZP5fzvdhYvTGRvDGZBqdJYfR4wJiYoq41tcKY83eIIX
 W6d+kzEitRT1Ac4IXNPuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F26zOO7NDHU=:Npihm7q3kXRp9TsZy3PTFj
 zGscRawNw6DiWcknoxMoB/nyep3O/NccBH6MAvb2cjskNF9s/xVBeVjAAcHmGTYaeeFwXPAic
 8vAFF5kkHa59rtMzXk3OJZG8eLUY2UlCBioRSX9g/9DYyFAZkWNDtK8lDDpB9HYOMPe4CCQrK
 8veaSejHmGbQ28HYHldrHn2aHR9ITSXJc/CAt0Tinq5lY53668KCVnzHeFQU17K/fzcL/EF50
 oQKgj1HezZ9RC6dXAWggm2o76VEJEnZRggEIZsdKvcN4bp8epZr1abxdyGR2bIhz8qXOkkGIa
 vqMMfI2OgWIcikhvWWdSCtu27nP5vARzVJ4MS0TNUWdoIarrYsWKzKAUAwbL0o925AH1eCGiG
 MBsaUdZjon2uKRhXVHwOFBMe/arawk3+TR6dLD1+404/pJtjd0QRKro5q857IPn3Twgdcw4aZ
 oUCXETytYFkL3w2vJriyUWZgE40RQlZib/sK12RTPrzbVOE7dM4o0oF38CjduhXIu/fl919W6
 9gP/khyfZrxgbT1ocTbJZ5efB/M3c95PtrTdxFXsaSTrmsWYpIIeeG+/L4NgpZ/KM/YarKmgR
 g7a6QtJYXEDNWnSxbsTWyL2X48acOT+v5+hrZ68uNlRhOq3SL3tcx3nonwclzvbBKeaBlZgZR
 OIhaC9I9MLZCGwu4fUXbDs2Ibfm56ojLZsyNwdSlA27U7uDvFzQ493/UaUSVCmR/qkIUwmOce
 kGu6ArerEE/GDO0zUvG4bI4hv8Q8Z9IEv7XabZkAcrKpmhkW66ymW33ZHj2MiMR0kZkpA0gl+
 R9MU+DZ2tu2IEB136c6NGluukRIFIHI68G+/D20UoqMlqmRKmgS10cSpX4Ooa1Bs5u45Kd5gY
 o/U1pzXSJr7Coxr/58hCjmFE894+klytkRdzfo1A8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 4 Feb 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +test_expect_success 'A^! and A^-<n> (unmodified)' '
> > +	git range-diff --no-color topic^! unmodified^-1 >actual &&
> > +	cat >expect <<-EOF &&
> > +	1:  $(test_oid t4) =3D 1:  $(test_oid u4) s/12/B/
> > +	EOF
> > +	test_cmp expect actual
> > +'
>
> Now we actually parse the single-token range, instead of relying on
> "does it have dot-dot" heuristics, we can make sure that we reject
>
>     "HEAD^{/^string with .. in it}"
>
> as "not a range with negative and positive ends".

Sure, why not.

Ciao,
Dscho
