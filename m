Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B2BF1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 13:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939759AbdAINGF (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 08:06:05 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:49570 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939648AbdAINFs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 08:05:48 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3txwPj6Fhgz3hpdf;
        Mon,  9 Jan 2017 14:05:45 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3txwPj5WbNzvkJg;
        Mon,  9 Jan 2017 14:05:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id q9UQ5cMBK_IZ; Mon,  9 Jan 2017 14:05:44 +0100 (CET)
X-Auth-Info: Jh27hUvTIiGyw+tIq3GvmpxmETKGzw3Eys8ymTzeS9tIozm2LKkJxABI+MORBtZ7
Received: from igel.home (ppp-88-217-26-143.dynamic.mnet-online.de [88.217.26.143])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  9 Jan 2017 14:05:44 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 1D44B2C34A2; Mon,  9 Jan 2017 14:05:44 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "A. Wilcox" <awilfox@adelielinux.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Test failures when Git is built with libpcre and grep is built without it
References: <58688C9F.4000605@adelielinux.org>
        <20170102065351.7ymrm77asjbghgdg@sigill.intra.peff.net>
        <58736B2A.40003@adelielinux.org>
X-Yow:  Well, I'm on the right planet---everyone looks like me!!!
Date:   Mon, 09 Jan 2017 14:05:44 +0100
In-Reply-To: <58736B2A.40003@adelielinux.org> (A. Wilcox's message of "Mon, 9
        Jan 2017 04:51:22 -0600")
Message-ID: <871swcjsd3.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jan 09 2017, "A. Wilcox" <awilfox@adelielinux.org> wrote:

> Interestingly enough, you seem to be right.  The failure is very
> bizarre and has nothing to do with system /bin/grep:
>
> test_must_fail: command succeeded: git grep -G -F -P -E a\x{2b}b\x{2a}c ab
> not ok 142 - grep -G -F -P -E pattern
> #
> #               >empty &&
> #               test_must_fail git grep -G -F -P -E "a\x{2b}b\x{2a}c"
> ab >actual &&
> #               test_cmp empty actual
> #
>
> However:
>
> elaine trash directory.t7810-grep # git grep -G -F -P -E
> a\x{2b}b\x{2a}c ab >actual

You need to quote the regexp argument, see the line starting with
"test_must_fail" above.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
