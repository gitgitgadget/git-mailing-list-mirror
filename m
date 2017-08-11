Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62C2E208B8
	for <e@80x24.org>; Fri, 11 Aug 2017 09:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbdHKJjF (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 05:39:05 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53409 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbdHKJjE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 05:39:04 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3xTKhQ1rKkz1qsDD;
        Fri, 11 Aug 2017 11:39:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3xTKhQ1HKDz3jgY4;
        Fri, 11 Aug 2017 11:39:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id QXyjMzjuOUS8; Fri, 11 Aug 2017 11:39:01 +0200 (CEST)
X-Auth-Info: Pt7GbXr3L0UUn8fUwPmmZ3QCQi66J3AgyOuCIcpGRfAZ2Tp7LeyaJTmInK/xiU44
Received: from igel.home (ppp-88-217-4-173.dynamic.mnet-online.de [88.217.4.173])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 11 Aug 2017 11:39:01 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id DBE932C3D10; Fri, 11 Aug 2017 11:39:00 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Davide Cavallari <davide.cavallari@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-describe --contains
References: <CANOKeme4j9fHuQoQY3MQeoNuietjez8m1wPkAO=1eSDtHG3J9w@mail.gmail.com>
X-Yow:  NOT fucking!! Also not a PACKAGE of LOOSE-LEAF PAPER!!
Date:   Fri, 11 Aug 2017 11:39:00 +0200
In-Reply-To: <CANOKeme4j9fHuQoQY3MQeoNuietjez8m1wPkAO=1eSDtHG3J9w@mail.gmail.com>
        (Davide Cavallari's message of "Fri, 11 Aug 2017 08:50:08 +0200")
Message-ID: <87shgyh2a3.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Aug 11 2017, Davide Cavallari <davide.cavallari@gmail.com> wrote:

> Please help me understand how this command works. There is one case in the
> linux kernel repository that puzzles me. Let's consider patch "drm/i915/
> execlists: Reset RING registers upon resume" [1]. This patch was committed 641
> commits after version 4.8-rc2:
>
> ~$ git describe bafb2f7d4755bf1571bd5e9a03b97f3fc4fe69ae
> v4.8-rc2-641-gbafb2f7d4755
>
> So I would expect to find it in version 4.8-rc3 and later versions.
>
> However, if I search for the tag that follows (and hence contains) that
> commit, I do not find version 4.8-rc3, nor version 4.8, nor version 4.9, but
> 4.10-rc1:
>
> ~$ git describe --contains bafb2f7d4755bf1571bd5e9a03b97f3fc4fe69ae
> v4.10-rc1~154^2~44^2~178
>
> Why? Why not v4.8-rc3? This means that the patch has been included neither in
> v4.8 nor in v4.9, but only in version 4.10-rc1, right? Why so much time was
> needed, considering it was the 621st commit on top ov v4.8-rc2?

You have to ask that the maintainers of the drm subsystem.  If you look
at commit 5481e27f6fd06b7cb902072e81d6b083db8155eb you see that the
branch containing the above commit was merged into a branch that follows
v4.9-rc2, which eventually was merged into v4.10-rc1.

> BTW, what are the numbers 154^2~44^2~178 that follow the tag name?

See git-rev-parse(1).  '~N' means to go back N parents, ^N means to pick
parent N of a merge commit.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
