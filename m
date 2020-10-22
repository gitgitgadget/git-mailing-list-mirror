Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89177C388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 13:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF5424178
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 13:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hfz3izMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899352AbgJVNI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 09:08:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:53581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2899342AbgJVNI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 09:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603372130;
        bh=FQsVZ2kd6hd6QxsG84/eujC+iHoesJBrsu9BrBxU/lU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hfz3izMeYRsKgfk3ep4yeEGUx9Yp/f3zxc4oiLdf27y/iuhgVj1zDlUzHeyvKsHCQ
         hgUQ0XWYRO814NTmFxO3HTdSy983PCjNYQXNrn8oL0jEaRDImJ4ailoGRJGDo6s4BY
         +L66eYHU//rDKQTUBM5vbIl1GAssPArcWnUNn5Mc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.45]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbp3-1klMAj2DkJ-00P35s; Thu, 22
 Oct 2020 15:08:50 +0200
Date:   Thu, 22 Oct 2020 15:08:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 07/10] t3200: prepare for `main` being shorter than
 `master`
In-Reply-To: <xmqqh7qn431p.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010221505320.56@tvgsbejvaqbjf.bet>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com> <e1740bb7d7d8c90db68ffff443b69894177e36f3.1603135903.git.gitgitgadget@gmail.com> <xmqqh7qn431p.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZtVldex15Su6JZm6hKzPzVeA8yU6Ry+4NA0I1YhAFWvM9ittyV6
 syuzHSXHOLgi+cUfzONDgTeZnv6l/TDvyNuJa8Cxl0MWge5bWhSy1HPjwp5mTfJjocCgUAn
 FjNsGFJfk7aymckNEJk/yyLMEB3yi1RqmDbAhkLoheckRSAXfA4SIcGLqTa0e7XCDQ9DI5Z
 lvm+gHk7OFh0+4jyKJMpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uz7utgvaUl4=:SOROISAkC9Nau6if2ud90I
 u9seFOW2EOmqpc4t/rb7Qg1OTOat6cYLGsw/CUnBoXBEkIVav0HmFcKZznbM3vap+lo4+zlqj
 FE5/8QZfFRydSkd4HvlhwPWSfVMDuytoOwrIIji9TpQPKtc2EF0Irrk/cgZdabe2x822GrzL0
 UnuqcS3a3N6M8FFROuEojbEuBnOo2C1LaqleNuF9wAGCP69SR7cUPSEt5b5p8e8Tb3aKJFdrx
 vEFhFyskD1DpLWDiTefsZm12e3W/8n8+LpevRo/3ggxvE9y+Mh443Whqb5WXRnH5okQwdYIYf
 TFzbQ4uVG4IYMpgIWEnzjHzr83wn6yqtkXq28xTunCS+HaaGJYsTMbWhjfmgNph3vtmXlPsX6
 pPcntYl0n5wvHawIvxxlLfpR34JoKa0OspkYGbycMrxJYIE5V7SLVs+K1o/45/t2/ryLXQMiS
 i+Fj1Ov4UHwjk7NnzyIdp0MQF3lznTgpbZikqxF9Vgk37chk1I1gTrPDUQZYEpyiBWYTGceWw
 tMSCKE7U2OT+Ja5gILHEfCZvq4bp7WBPCmeEWQ2yQ0XIW7i8gq5xrW1HI2JVr/RhRtng1F6/g
 ODr20w62KhVbYX7cspC7szMNp2emK/qtJVGFtlrscToyxYbtqgkeoVwpZ0k7POdDoOFu6/wAL
 GF37U4iBgq/MILMIcZEDEiO1gUb84Qz+7k7knBsf/qcVtrHzdYYWvdh9RtiRgf4gZ5V9ZsL3c
 FTW1P5Z0M9N3KXX4LRbI4j8SAZ8FumMVSstPium/RiQ9Qpa7GdvsGA4YGwk0tlfUEZhd6b4PD
 dzLk54j4xoNMf4vFS1Ui9xBhmbtuvGig65kdGx7/ip3IT99TjkK1qh7ji3DebZ4ssaOlkoX38
 Qu1vUhzq0R9XFKA4nzm8OznrGwd60npUve6jczKrM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 21 Oct 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In the test case adjusted by this patch, we want to cut just after the
> > longest shown ref name. Since `main` is shorter than `master`, we need
> > to decrease the number of characters. Since `main2` is shown, too, and
> > since that is only one character shorter than `master`, we decrement t=
he
> > length by one.
>
> Confused.  I do not see 'main2' (or 'master2' for that matter) in
> the test script.

Oops. Yes, this is a left-over from the time when I had renamed the
branches from `master2` to `main2` (and based on your advice, I had
changed those patches to rename to `topic` instead).

> If we rename 'topic' to 'topico', then we'd still show branches, the
> longest among which has 6 characters (the same as 'master'), so we
> won't have to wonder where 'main2' came from; I guess that is another
> way to solve this.

Sure, but then, that would adjust a perfectly nice name to a not-so-nice
name just to avoid changing the number of columns to cut.

If you don't mind, I would like to stay on `topic` ;-)

Ciao,
Dscho
