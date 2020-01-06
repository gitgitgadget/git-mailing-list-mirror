Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0EBC33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204262072E
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgAFXe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:34:56 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:39756 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgAFXe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 18:34:56 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 47sBgf233tz1qr93;
        Tue,  7 Jan 2020 00:34:54 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 47sBgf1hl3z1rWms;
        Tue,  7 Jan 2020 00:34:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id sPQj9LzTMmvC; Tue,  7 Jan 2020 00:34:53 +0100 (CET)
X-Auth-Info: 7LoD4fpj+N+Dio1/zt+lIofCeNAG2Am38n5cYtJNgvX9o3e2ZUYzxdhj9Bq73JMC
Received: from igel.home (ppp-46-244-191-42.dynamic.mnet-online.de [46.244.191.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  7 Jan 2020 00:34:53 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 9738E2C0AE4; Tue,  7 Jan 2020 00:34:52 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jeff King <peff@peff.net>
Cc:     "Miriam R." <mirucam@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [Outreachy] Return value before or after free()?
References: <CAN7CjDDBA0ZoCG9aaQf5rg3gxqny=EjR6v6jE1mnxvUJQSF_0Q@mail.gmail.com>
        <20200106213051.GD980197@coredump.intra.peff.net>
X-Yow:  If I had a Q-TIP, I could prevent th'collapse of NEGOTIATIONS!!
Date:   Tue, 07 Jan 2020 00:34:52 +0100
In-Reply-To: <20200106213051.GD980197@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 6 Jan 2020 16:30:51 -0500")
Message-ID: <87imlo6twj.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jan 06 2020, Jeff King wrote:

> On Mon, Jan 06, 2020 at 10:15:53PM +0100, Miriam R. wrote:
>
>> in run-command.c file `exists_in_PATH()` function does this:
>> 
>> static int exists_in_PATH(const char *file)
>> {
>> char *r = locate_in_PATH(file);
>> free(r);
>> return r != NULL;
>> }
>> 
>> I wonder if it is correct to do return r != NULL; after free(r);
>
> It is technically undefined behavior according to the C standard, but I
> think it would be hard to find an implementation where it was not
> perfectly fine in practice.

Compilers get constantly better at exploiting undefined behaviour, so I
would not count on it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
