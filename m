Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5162C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE61604AC
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbhIGMdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:33:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:54925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343816AbhIGMdw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631017960;
        bh=+Q3HApPSHH9NzI9QZtQVr9l2HkL+r8BzDgoyvJXIFtQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=J/kN1b9+0SDaMcrNYGINFMmQnuB8w0Ppzguoc4/rJ0Fr2oGq0oDuNIXTPccM3qUus
         AdUYvZ3gK8Zovu7HlOyWhwAGD9sL5J8xbkREhJJo7MmBqBnrkbZBmJeDvsf2xQMVib
         qQLTHcrekSD+uLrooDtKsoSzdbE0ojI2XgOXFZkM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQEx-1mhoSu3lfb-00oYS9; Tue, 07
 Sep 2021 14:32:39 +0200
Date:   Tue, 7 Sep 2021 14:32:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
In-Reply-To: <d93a750a-9faf-c91a-c9f7-e968c7ed40f5@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109071430320.55@tvgsbejvaqbjf.bet>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com> <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com> <d93a750a-9faf-c91a-c9f7-e968c7ed40f5@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mW0s783J8dvDBmzm1UQwcrAWiJiH0921gKPdaFUGrxC05C26A9i
 rKTNxUJkd4PGknacRWDWn5SUPGGhx/lH2D6XjyAeSWKDbdS7fjhbuueQO+sNzgCadW5Wvc/
 4pcO5nMKFMyWuhLB5xSKJxtzEKdPMOKMScw8uywCEGkMaTqPSgGTmreTNVZq597mSoLIGJq
 oNe2em53LhagLp8gtWt4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OU1whKJ69+w=:nKwQZzDI1UGL+q4Zigpk1V
 8FIVvw28bUzqYQGUYX6DfZMuVe2PIqNoBN+6x/TGbJAENP5EOlaCtBLUvqUhd0zQVDLFg70q2
 CVExtWORnRLRdb4u8/U2UZlemgko6hRe+LS7X2LfgIeHhIMurz6sMeZFbKTk59Kg0aH2DGAPP
 tBIVf6HqtKSxWehhK8qQNYiPKeUphlVcfu8rA0cZi1YgmuOP8NG96fpK+EEhP8nZ4Y2Q7BhYb
 iYTtBOOPLI0QsEYXZRC3BTyoDkmGuULMxlrdeCIaKb8NXSnNBZFQ9oWnvN7qZHQ8yFosQ70gx
 8pntaNQY070XB71WxCFrmWTqcJ8qu2IjsFQZpbxXsdFeV1GldAlOr+VwUKc0pPIFoGsbNVbzU
 ocj7DVsnoHU73fwXZ1OyB8fwlpOkGHtEGPT2HQ3VZFu9nNl3O9xjnn7Zs2dYw0pdq6ZmxprQn
 qFI7EsqhPRwk9vswgZMg3+46XtZ8rwU2gKZMhPoCuNuKTyxRxdEWE9EsvYtcFMyQ7RMbkdg3Y
 4ER27I2v0H0RtZ69wb1X38jHuFJbgll2NWaJu3oDjSPefP6IzFGPfOU0nfd/9Vor879eCBrTu
 tOW4R8K+J/enT74vDv4QER5s8ciGMdCebdAoAuUfH70e4YJ8Fw7IIlNw+0SMcDCWlnoosoXQb
 0wHMZ/0I5CT+6m6PZn4zQucE6I3088eiHnYGAMEyHEyOLk0oiJvGObjxgv6GMNeGVrmiai4Rg
 0u9UOWct2zsCpPBeLOlLXI1k+GNqpprwavISUPd4vnqPAEDFsNSCCyNG2Sm0Cb7BBkNKyY0WD
 kijlEbWDPnkEYB+rANT4IiO2nsb+Nis/Ok8+37xxO+h8WS8TfDA2ITZuK7NZqOcKJ6Xv/lLy5
 KikWZ8q5ymjf2dxh2iq4qkr1ouHuiv5/fxnON2Hxp6xj2DS17WDQG0uaR67aXl83OJZ2qsqj8
 tKPa8v+tTTICllfgs1FIRbo2RZ10FulGseJkBVfGHaVwQ8ToTUlfCplsklzQPjE3c6fkMsfGd
 qfmR1Q2KFaeCybHxSILdqgWgZcGGF9HS8XzKSEXSfATV/XNPRdR44rLmHUs6UlcJaYnp5IoPm
 jOx3bGHfKpqdjLzBh1DYev1SEj/ZX5RYxgwFyRjeA6q11Pdb5IgPUEYXA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 6 Sep 2021, Phillip Wood wrote:

> Hi dscho
>
> On 01/09/2021 12:57, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This option was deprecated in favor of `--rebase-merges` some time ago=
,
> > and now we retire it.
>
> This all looks good to me. I did see the comment below in builtin/rebase=
.c
> that could be tweaked if you reroll, but it is a very minor issue.
>
> /* -i followed by -p is still explicitly interactive, but -p alone is no=
t */
> static int parse_opt_interactive(const struct option *opt, const char *a=
rg,
>                                  int unset)

Right, without `-p` this comment does not make sense anymore. But once I
replace the `-p` by `-r`, it _does_ make sense: `git rebase -r` is not
interactive, but `git rebase -ir` _is_.

> I do wonder if we need these option parsing functions now but that is a
> question for another day.

As the function parses the `-i`/`--interactive` option, which is not going
anywhere, we still need it.

Thanks,
Dscho
