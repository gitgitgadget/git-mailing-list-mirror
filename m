Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89E5720248
	for <e@80x24.org>; Mon, 15 Apr 2019 21:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfDOVOd (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 17:14:33 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52142 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfDOVOd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 17:14:33 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44jh8Q6pDFz1rBnb;
        Mon, 15 Apr 2019 23:14:30 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44jh8Q6Pqhz1r2HW;
        Mon, 15 Apr 2019 23:14:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 83VZz8Nqs6qO; Mon, 15 Apr 2019 23:14:27 +0200 (CEST)
X-Auth-Info: BAL9M0OJn4ahxjVhm0N15XNDXbTgqZ5VWvTLANJShvtiMN46THW55dS7WxrWWHpW
Received: from igel.home (ppp-46-244-175-87.dynamic.mnet-online.de [46.244.175.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 15 Apr 2019 23:14:27 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 9957F2C0D7B; Mon, 15 Apr 2019 23:14:26 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     =?utf-8?Q?'SZEDER_G=C3=A1bor'?= <szeder.dev@gmail.com>,
        =?utf-8?Q?'?= =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?= 
        <avarab@gmail.com>, <git@vger.kernel.org>
Subject: Re: [BUG] GIT_SSH_COMMAND is not being decomposed
References: <000d01d4f237$5cf2dc10$16d89430$@nexbridge.com>
        <874l71fxmg.fsf@evledraar.gmail.com>
        <20190413214736.GD15936@szeder.dev>
        <004d01d4f3c0$3ff358d0$bfda0a70$@nexbridge.com>
X-Yow:  I'm having an EMOTIONAL OUTBURST!!  But, uh, WHY is there a WAFFLE
 in my PAJAMA POCKET??
Date:   Mon, 15 Apr 2019 23:14:26 +0200
In-Reply-To: <004d01d4f3c0$3ff358d0$bfda0a70$@nexbridge.com> (Randall
        S. Becker's message of "Mon, 15 Apr 2019 15:20:07 -0400")
Message-ID: <87ef63ezt9.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 15 2019, "Randall S. Becker" <rsbecker@nexbridge.com> wrote:

> on virtually any platform at my disposal (Windows, Ubuntu, MacOS, the
> older NonStop variant), and have that work with no problem. Somewhere
> after get_ssh_command(), the command is being interpreted it its parts
> either as a shell or something else (still trying to find that).

See run-command.c:prepare_shell_cmd, if the command contains shell meta
characters it is passed to sh -c without further quoting.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
