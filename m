Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4D4CA0FF3
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 15:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjIEP74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 11:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354351AbjIEK5F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 06:57:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55BA199
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 03:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693911412; x=1694516212; i=johannes.schindelin@gmx.de;
 bh=JHopeQFE38lX2zItmMNOgunc70rnxyEun0ZIOBUro+g=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=KqWbNnAwSzBOuuH7UfNvvV3MGIitQ344fuGYu2PA8ayGCDjgjMTZGukPHBxP6UxDnsogyOe
 NAUhyLSCgOTlyG3yO6Ov4IErd8wA8SR0GqQKofc7B0n/Tkuef88y/4IjDBfMmeGVg7KbgdjvN
 445prlMkJLF2DCOZECtP4M4Bhbxl+/TTkr6YiTw31oyY9LLnB//hRtzJWs2bkVSXhUY9EyqCD
 e7XzUqy7DAhxomNQIo4CDKB26GOntNrLjDY+MYaGpSFQlFuxBBNA/U+YjOb/w+tqKx3et0MCJ
 9f/HpngOs+QUxjmGK1Fm1O9ftmCeI4m3CFsblEUFnIrjtlZe5zVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.152]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDywu-1qTcMi23oC-009zSI; Tue, 05
 Sep 2023 12:56:52 +0200
Date:   Tue, 5 Sep 2023 12:56:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] range-diff: treat notes like `log`
In-Reply-To: <8642763e-d3e7-49c4-b2ea-d5e4bebfbca5@app.fastmail.com>
Message-ID: <843bc10e-03ab-b37a-68f7-d6055dc9308c@gmx.de>
References: <cover.1686505920.git.code@khaugsbakk.name> <cover.1693584310.git.code@khaugsbakk.name> <e9a59108311369d8197b9870a8810d5283ec124f.1693584310.git.code@khaugsbakk.name> <94b9535b-8c2a-eb8f-90fb-cd0f998ec57e@gmx.de>
 <8642763e-d3e7-49c4-b2ea-d5e4bebfbca5@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jTFfeOvjiiywNpUCZr+XpXCeU7T66naGt4c+4Jo97PDE86aapWR
 SqN9ogrXn80mjydcYPccQFBgcbFT167a8pAsyz0gpGNYVSH4E8vu52dI5oHf4WjFWUDR5Xd
 wgJt1fq5vUqwVyrMrRsnMUZMW01VNqbhCAptMRc9LWKhplXfKsYu7XfquTbeCK4Io6NFwAC
 +LlKI1wA5/ERiP3koUuRA==
UI-OutboundReport: notjunk:1;M01:P0:dIbGoEBDGDI=;ZwiK9e8zYthUetUNbMa/cfEz3ti
 NgcVBAlDSGZMha1nbw7XoPaNlBZ0Zys0gQlqdm4PezXuVfbQza5EOapZ9F5VNMzN97GmIW6WU
 EThWW9KG4QbrmlrER6AvWUcANEzoJ3hz/Y+qwO/ab06RijeklWw9CmbcSGJujC44GKDSF4CWp
 hLwPeNQNusa1cQhL4CmzrIJwotNhkTqWzsIY5gzMhRjiSY3JtSVRVGBcov64i4l8cPH6g1/I1
 d1vqyKthBAWatUWyOP2mFcRG8S5BGYxT0C3b3S91r/w10J//ey4o8g8IEZR4UHPsZdGSKJXdt
 h3Lkfhyh9PPhPnZJtezPZaPCdv7dV6CWSPc6DYuEgB1/AwqjXAMMNaqow/wi9ebNEIvNx28j0
 cFskG9TiLo9zFiu1w4PJmGbYrgGlaTMtxIN+kFyVrqS1+j1vtz0r429X0x3gYr9YloVJgiDWi
 umF8Pv/mxGneg1LfQ4R5FgxegxBfHgDqzWFJ5A1GMyUJgMkAzYJ/xyCKL8CmqLklUW56+eKKC
 nXJGxOdTHHIbruBkCAkzcDQMgeqa5/aAW4en2tVAexiNlmNpDR0GniSZ1U5HjacSSppKcv/Cf
 dGIO8+vcQ6bebHLcIExHgxE00J3Rs6BMJDqNsbRiCCkx268uC+dj+O6oeTsN9ISu+Edl9VbkK
 N6jrINhglUqr+i2ojM/vIbIrqgEg4vbfZt1P16UjZusb/gOImJCXMePSAilAxSXvhLbOBJziH
 YFFGd9xQy0E7Jf7GwOrnmWlYmgoqQwInR6SQTBbcwvelV1kIgh1LEJKtfWpY3arn9a4Bx/iW0
 r0vquQD+XMnRy8/CdQgZfC/Z6u7ZiOaudAO6tOwp0lgexZLydLTiwCzXWKxFNKaxstQ7R2nQJ
 XJCcO/AAxBEaogHkQ5xESosNrlOvJcIiyGZ8L9A3yAvtfsF2tAy52wVzyv90XKdJBu1S73IJ+
 L917vg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kristoffer,

On Mon, 4 Sep 2023, Kristoffer Haugsbakk wrote:

> I would like to use your solution instead. Thank you.

Please do! You're welcome.

> Maybe you could supply a commit message for v3? v3 would then consist of
> two commits:
>
> 1. Your fix
> 2. Those two tests
>
> Or should it be handled in some other way?

Personally, I'd prefer it if you just squashed the changes into your
patch. If you want, I'd be delighted about a Helped-by (or even
Co-authored-by) footer, but taking ownership would be fine with me, too.

Ciao,
Johannes
