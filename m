Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F099C64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 11:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A95222203
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 11:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgLBLrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:47:55 -0500
Received: from mout.web.de ([212.227.17.12]:50925 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgLBLry (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 06:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1606909550;
        bh=pG89Fz4kf+YekG19DXgJTiZtYJQFkJJBDqvyqBAL/fA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MAG3MtqbV3N2bUdDg5OQcRTR/hr6tFW8dgF6AOvG9UbyulHsAfOpxdqO7fNwlBagC
         CIf9OsW/L65vXwXISWavb7mtJzgVLLqGd/ATVoKzuPLrTVX1y/da05CCVJRryJToAq
         sJ26EP0Hiet26MmeevnCaAPDKDKkf6IxX0y0xKjY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LjJH1-1kBd3Z2PPj-00dWo3; Wed, 02
 Dec 2020 12:45:50 +0100
Subject: Re: Bug report: orphaned pack-objects after killing upload-pack on [
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>,
        git@vger.kernel.org
References: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
 <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de>
 <20201121002921.GC353076@coredump.intra.peff.net>
 <xmqqd006s7ee.fsf@gitster.c.googlers.com>
 <X7zOKbzR9gwJHMbJ@coredump.intra.peff.net>
 <xmqqy2ipcdvj.fsf@gitster.c.googlers.com>
 <X778eIAr3uzdh0H0@coredump.intra.peff.net>
 <xmqqo8jllyhc.fsf@gitster.c.googlers.com>
 <bd2c4577-4c8c-851c-6045-ba4b306ca612@web.de>
 <X8Yz0bY1LOHpKxKA@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ff05986b-5506-3ef1-68bc-e6b46ddf8b98@web.de>
Date:   Wed, 2 Dec 2020 12:45:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X8Yz0bY1LOHpKxKA@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:icf6TQqDTQp/3Sgo5xs9xTuyr+JBrS97TJL5e8eGFMhFQy6n1ve
 9/0umZtBXnt7QULivBsauy83NDey/1ttsBN/R6I7vKbMyo3gDc/Ign+aOEqas5CDZbN2rjn
 bfML8rtTmmw2aS2oq1pZYrv77facrzerJ6aEI4+mIzH+2OgkhluYmUFjb4W+ZtGHbXLGsDh
 lGIihB46AbvS426nPr7ZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z3sJxkd7Gb8=:DvsP++qLhiX5RiGFWyhHjw
 LgAoM4aJTDHKj38MlDWnXGfVFyerKYgGZ43Ru3mSl89cMhLdVFs1iKZro+VwudHlAe6dDpoeZ
 5VGfRT0v6yBsW5Ay0JJhdBicPge/TDPaDPo8zWbkWzoXeC91dRPJJrg+n+G7d8dE28xOk5rWw
 yykEHu4tEzhb0zgrr7z/+6X4N47AktHp9NdFmnCK4r7bn6ecafvq9SLFmE9rDCfnspsybxAGs
 4boTDC9dCRm27bpgj4MS0VPVG8O9mXKtO9CZpZWWR8pz7P2CzYg016C2vlTTS/MgQbbVNuuru
 V/1FGuCaY0iIMULuNtJqZzP4pzYUKIqfELJ3blTYiXXWdsrwjjwFFm5sxOqK93SjccpDO0wJe
 NewoV4zLaqVXIhkcfmGbmW+G4FJaJO4RKspBMYGxWttWbvgSbbJ+T0rf8CnmAvXsoAkT2Uz2N
 GzKQWjUe+RVfQukxKUrksGgh5HFFU4O+HWQZX8SBWeQS6FH6Q0+81XgS/qetRkJkDsCfBfZLu
 as1dnKs+C/ncX1zApz3nBFkCExbtiURk+ibQQSGzHDfchdQ9beW4/OdEc4wPTgmoKOQEjt5Pr
 fPLGOYt6GfTep3ZUB79YY39cqdbpmQG0pM549xrvCGTUL1LQqvO0K9hKqBVOZbTwDtLaVLnjK
 zKE8cfZwENwrjhmzsA2HQooEWxdjo42VShpLzansMYFpKuq/mbNsUAYgq4cNtZgLTMc498juB
 iVxVzrSRyNPCbn0jryaKlJnbCAeiH7gUY59CHvriseK7C2f9/qb1di9bwgXnn5pCHtSrSyIqJ
 ZYqS4fRxWZQMU8QRuGEhjw2q9USAacmU4O7mDChE20ckw6N9Z2NOFRx2vZqgidz4djtTxlEB2
 HiUuNACf1d6lpFTjM1Mg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.12.20 um 13:15 schrieb Jeff King:
> On Thu, Nov 26, 2020 at 09:04:35PM +0100, Ren=C3=A9 Scharfe wrote:
>> The patch is trivial, you don't need my sign-off.  You could record Pef=
f
>> as its author, as he contributed the most to the version in seen.
>
> I didn't want this topic to be forgotten, so here it is with me as the
> author, my signoff, and an overview of the reproduction in the commit
> message.

Thank you!

Ren=C3=A9
