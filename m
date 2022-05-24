Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE13C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 11:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiEXLEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 07:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiEXLED (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 07:04:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F15C8FD57
        for <git@vger.kernel.org>; Tue, 24 May 2022 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653390225;
        bh=zfvq4ksLCMNEWvTNwSjYWIDrTDIok78YCNSJMqiKc9A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DL6dEI33jvK/HXeT2bhueddxKfFGZNgZByz4EyzVaKGNIQh2O3yYlnL8/npC6hbVa
         dkZ6y4UmnluhCw4Ou64DS6k/PuC8zrI5YTROyFaGZEjcLWG3Ki4G2koDHnSxy7Hxrg
         wbEm0Zbc3Tn56wpAsRwJgwZ5UoLCnLOnKTEXNENk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N17YY-1nitP12fow-012ZHi; Tue, 24
 May 2022 13:03:45 +0200
Date:   Tue, 24 May 2022 13:03:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
In-Reply-To: <xmqqa6b7lrw6.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205241258510.352@tvgsbejvaqbjf.bet>
References: <cover.1651859773.git.git@grubix.eu> <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu> <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g> <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet> <xmqqr14jluu4.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet> <xmqqa6b7lrw6.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:a1er1sZBnHfMZnDrMTFnAbm/fsaXTSSC4pgm6y0epy0Uuz3h+Jk
 oexO7iyCxILnSGWgXzBR9FX4Ewjgx6qyXksSETXM+W0eNcgfONUsULiTUtdxA23AOBqQzO1
 3TgOA5Pmmf5h+/zq2i32VBAHab7npNTYfOnj7aSdIsaT7PHyuxWGDQ5sTyKS6lcNKfL6vMi
 gOQ/cSwzt1XgPGaBLAEYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MfacSrXpMbI=:pPqlCSrFNMb74CwpWD5pwK
 U2ZFXaOnnwcxjMDMq7hvxrWdEvKY+tOlVa8K1yi1suH4z5ZGHoXlz9WaKaK/7OaM6+xXXNlcz
 Xq72gBMwOickWxUAXS2Obo5B0I2QmryZx17t8JKTdfmvholZq7LhUp6pZEN87nErthhXLuxfR
 3882vDvWK1PVziq8kcCPtTe7rLvQhttQxuQSIwsFGUOdZn0eoIQ9/2T6blvXvcndbZIDar0/G
 GtY93xiIu3658NrOVUgcQMYC2fu/HeqEjdNzn53NA9xn6LASIAQrGPTq3oQToLqfC2XYiiOCz
 sca39ZLOjTh33l+KPr9g6utIbRKuioPgoaCr8pCi73TFFsvqE8lXqe66E0leqQ6XkNL9w74lH
 mGJqu4RBkVxGN7GNl9mxwzdgy1UHNwyaP8KAkLVEhYLOc2eV/k4VXUb+VanrvivvL8vok/hm2
 p2OONakyIHEnuBzPHNhu8Wa6lafmm8bOIoq2YNupjmiIt7b0Bzk8gGFTbqWmMO5swP9I9IgCK
 TxSXEOBfafVo/dxEOY6kYxpB1+Oo7DAidPl3QGr2Q1p5chJ30Y1XC7QNTUf6nlNglw6ExnOGd
 k7jGEE/WRzt4DOR/umgGctnQqKxaVlRpyCgvDLMgAHq20uzJ7IJcGW+xmWARwPFoq8oMnxB6i
 abYsCkyh8M/0zgLMzMb3qye9FMZZ+VP/ME3555XoDVkxBAr5rG70PbAJlK2domPESuMVAqHwz
 aS/oVKXdX7BO0bMEIwO5fdSIhRqAgzWx0IFgyIED3YXpgvjym+ijf3s09T34EHwwzjXJ7JQOt
 0y1Q1gg6ZgBObiQJuiEpa0I9xsOZVCw5wxwFhZPsgEQ/I1B9O2jw8iM/sUWyezMSYth5JRq9t
 tJzQGwZtpOorG8isI575ljClsB6nBf/26JksAIYQMoViBG3LrXls/6NhzLcCMpmjrKYmW0rgB
 cA7aqAYHzufIuwZq6Z3TuZY65lbQiSYuc0NBr+ufkw7fydwcTqI7456pQw0KD1tl6HrxQECpm
 GfwFqahBr8xCemaIu1zZKlOHs/PMNVHD6Lmms1i3vVg0y0yYMGuh5iS0XCB3Xxjm5HJWZLot3
 87zDzRcHF9/kR8C9jy9FGaezMh+4RjrZIIEQahr1r4SFxnPt0I7ta0LuQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 23 May 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I suggested to replace the `finished` variable with an attribute (or
> > "field" or "member variable") of the slot, and to respect it when
> > looking for an unused slot, i.e. not only look for a slot whose
> > `in_use` is 0 but also require `reserved_for_use` to be 0. In essence,
> > the `run_active_slot()` function owns the slot, even if it is not
> > marked as `in_use`. That should address the same concern as baa7b67d
> > but without using a pointer to a local variable.
>
> Not really.  An outer run_active_slot() and an inner
> run_active_slot() have a pointer to the same slot object.

How is that possible? One of the first things that function does is to
assign `slot->finished =3D &finished`, and then run that `while (!finished=
)`
loop.

How would the outer `run_active_slot()` ever get signaled via `finished`
when the inner `run_active_slot()` would overwrite `slot->finished`? I am
puzzled why we do not see infinite loops in such outer calls all the time,
then.

Ciao,
Dscho
