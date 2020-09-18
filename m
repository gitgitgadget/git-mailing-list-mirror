Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B3EC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 15:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B99023888
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 15:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgIRPwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 11:52:37 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49993 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRPwh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 11:52:37 -0400
X-Greylist: delayed 1868 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 11:52:36 EDT
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BtJJ30F4wz1qsbT;
        Fri, 18 Sep 2020 17:52:35 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4BtJJ271sBz1qspd;
        Fri, 18 Sep 2020 17:52:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id CnHCnNDj2fHA; Fri, 18 Sep 2020 17:52:34 +0200 (CEST)
X-Auth-Info: h1hvmT3M9bymyQ9bRkB8uu5HzraeDW9XvVWm4f1cONvF1X9A6kxOENvtaUznZUi7
Received: from igel.home (ppp-46-244-177-180.dynamic.mnet-online.de [46.244.177.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 18 Sep 2020 17:52:34 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id AF61E2C28F1; Fri, 18 Sep 2020 17:52:33 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: Apply git bundle to source tree?
References: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
        <20200918140236.GA1602321@nand.local>
        <CAHpGcML=EFRngwjgaXNE53OOPoEBz+4Qi1v354gAv_vHNYS_gQ@mail.gmail.com>
        <20200918141725.GA1606445@nand.local>
        <CAHpGcMJXZ++t0UtyCRSh=cB8uzy51hJTNxaF1Zd8Z-AQs4w+QQ@mail.gmail.com>
        <871rizglfv.fsf@igel.home>
        <CAHpGcMJhp7Z6YnuTKRXadiOOUYV=tFPRE-_-rAri1iHDPk-C=A@mail.gmail.com>
X-Yow:  I just forgot my whole philosophy of life!!!
Date:   Fri, 18 Sep 2020 17:52:33 +0200
In-Reply-To: <CAHpGcMJhp7Z6YnuTKRXadiOOUYV=tFPRE-_-rAri1iHDPk-C=A@mail.gmail.com>
        ("Andreas =?utf-8?Q?Gr=C3=BCnbacher=22's?= message of "Fri, 18 Sep 2020
 17:32:45 +0200")
Message-ID: <87v9gbf5fi.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sep 18 2020, Andreas Grünbacher wrote:

> Am Fr., 18. Sept. 2020 um 17:21 Uhr schrieb Andreas Schwab
> <schwab@linux-m68k.org>:
>> On Sep 18 2020, Andreas Grünbacher wrote:
>> > Am I right in assuming that v5.8^{tree} isn't included in a
>> > v5.8..v5.9-rc1 bundle?
>>
>> From git-bundle(1):
>>
>>        As no direct connection between the repositories exists, the user must
>>        specify a basis for the bundle that is held by the destination
>>        repository: the bundle assumes that all objects in the basis are
>>        already in the destination repository.
>
> It's pretty clear that the original objects are needed when trying to
> reconnect the objects in the bundle to them. That wasn't my question,
> though.

Your question was whether v5.8^{tree} is included, and I think that
sentence gives the answer.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
