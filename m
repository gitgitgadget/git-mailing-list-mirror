Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C473B1F461
	for <e@80x24.org>; Fri, 17 May 2019 20:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfEQUbL (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 16:31:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:44791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfEQUbL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 16:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558125055;
        bh=kqvwlipWat7VUaJnj1Yx/VzJxhl7J2VZ9T9nAh8B3pA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PGgONnLuoxIEJ9TyxYT6Ttw/uSvZbV3GJ79SLJHSaNqP7dex+RasYCVXN8WXfvsoB
         dgGZ/RimNBW8V9fV9TEGst2Ubd2Yirj3iBCWqkTmEq95niH7c/o72ssfKswWlsFrVL
         6seJhD8M61maWH3kq4ZGPIqG26xMjRXfte/5w8J4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLA45-1hRSO73Y2L-000NH9; Fri, 17
 May 2019 22:30:54 +0200
Date:   Fri, 17 May 2019 22:31:03 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/7] run-command: add preliminary support for multiple
 hooks
In-Reply-To: <91532c2d-7536-6e15-728b-bd18256b2ef3@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1905172227200.46@tvgsbejvaqbjf.bet>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net> <20190514002332.121089-2-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.1905141653130.44@tvgsbejvaqbjf.bet> <20190515224425.GK7458@genre.crustytoothpaste.net>
 <91532c2d-7536-6e15-728b-bd18256b2ef3@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hBL/BFBGn9az1cVFGPNuVTwhw5WHFk/XtEo/+QzkcgshnJKwGke
 Ut7FCm06TZUA9YSgNMyjwKP8D/8wUNjmgHYtkSk6Mu3vjsJIVo07I7tjj5JPsyqjaw0c2Up
 FW1gtDa/+HIooR6InXnagxa2BRrBANMXpoilWWkzbGt8aIFas2BlizihPoqkr0EPBQz1mNB
 WeKh32P5dP5PQ5vD0HXag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mhEf+Uy+jjo=:CxPeOEyDT/HgAUtX6HUaMy
 KCmpMRcRj2wZMwyHfIYLFpJX2LP8mukrUTJZ23h6m0Nnz3dZp21Et6SNOvnbYK2VfdOnOSfdw
 bSgBySTwsID+wQb3op0swDBvR+c8zWSDf+LXb+V5J01U8xgsvI6/FUG+5t2UpJcdJvojvgwoX
 umYqKLQP05P+8OrhZVVBD1uSsb3ck1AT0HiIWCTvVnK82om+zspHPQRZSvlR6K2hsIoWyJYoB
 qq5tt3Gd1zsyqZdrT/iA8VvoYW2o1TakPjoSYbH3i33JmT/xxHxSwu/3EwLaLlABOuf9GH6ye
 sWtpZ062RZV2kBQnuy0TDecn5CNSPGWK5J8HtQjUanMYbDLO0zUn7Wz+Rkf4emgVPxdhIheW/
 DoxZAc+fSwcxwoPy11QtvPUJCb6cAaJvM6w1Mx6VzmTv/72r9dU+619Lq+7FaGk3AF0cRHYi/
 Gk5gXj/pA7V5og7kWoqCd2HLEWkhNP3NhnDMbYtvYrWnlnn0vyx69l/BhkxYcKFyhxg/2So+x
 GC9/ataDhdEP6Ak/jfPVh8BgDAHpb1zi2ZaCSFvjKrWqZmVaLqkeGxb8ANLliU8vCfez4W1H9
 OJ7KYzqlCwHMCw3a8J+xdlpXKab4wyA0KtvJpMKHmcOjgnoCl5ChUXPtv/9oIiJIx9Nm/v/qO
 YL9PE22r99eZ/thbG7HJHg9mn26KC5ACoYgOUXBt6W6HkvGQMRVMENtH6/zBF/+1dPeaSEk4B
 P4pu5G3nnDgXGLR8L1dSy3PcXiY0uwJGABD4rUX0fwLCttehSRRPsW7f3MjwEqniFK9d+lNBi
 /Yzt+Zd235v/yEN6wdo6axiaCKD2IcgPXSOjxzTdc4IF3dWw/UpodSu1rVMoguT8V5RMwFA0O
 FnJ0YeNWhLjJnpNYc+lQUUv0ust8yWS5hPEERSyMcQKnL0XUBWegNU3XJB4DhHv4dx37wkjcO
 BAmlKU2POsqXH5+KG7ewMgBYOXtEtK1TKlfmYiKLxbXnoC9yQB90H
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 16 May 2019, Johannes Sixt wrote:

> Am 16.05.19 um 00:44 schrieb brian m. carlson:
> > On Tue, May 14, 2019 at 05:12:39PM +0200, Johannes Schindelin wrote:
> >> On Tue, 14 May 2019, brian m. carlson wrote:
> >>> +/*
> >>> + * Return 1 if a hook exists at path (which may be modified) using =
access(2)
> >>> + * with check (which should be F_OK or X_OK), 0 otherwise. If strip=
 is true,
> >>> + * additionally consider the same filename but with STRIP_EXTENSION=
 added.
> >>> + * If check is X_OK, warn if the hook exists but is not executable.
> >>> + */
> >>> +static int has_hook(struct strbuf *path, int strip, int check)
> >>> +{
> >>> +	if (access(path->buf, check) < 0) {
> >>> +		int err =3D errno;
> >>> +
> >>> +		if (strip) {
> >>> +#ifdef STRIP_EXTENSION
> >>> +			strbuf_addstr(path, STRIP_EXTENSION);
> >>> +			if (access(path->buf, check) >=3D 0)
> >>> +				return 1;
> >>> +			if (errno =3D=3D EACCES)
> >>> +				err =3D errno;
> >>> +#endif
> >>> +		}
> >>
> >> How about simply guarding the entire `if()`? It is a bit unusual to g=
uard
> >> *only* the inside block ;-)
> >
> > I can make that change.
>
> But then we'll have an unused argument in some build configurations.

That's a valid point.

Thanks,
Dscho
