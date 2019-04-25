Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0952E1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 19:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfDYTki (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 15:40:38 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:19514 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYTki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 15:40:38 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44qnbR5Sknz5tlF;
        Thu, 25 Apr 2019 21:40:35 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 03B5641E6;
        Thu, 25 Apr 2019 21:40:34 +0200 (CEST)
Subject: Re: [PATCH 1/5] run-command: add preliminary support for multiple
 hooks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424004948.728326-2-sandals@crustytoothpaste.net>
 <xmqqo94w2l3k.fsf@gitster-ct.c.googlers.com>
 <8f79d251-58d9-f63b-7171-7f1fbd11c6f9@kdbg.org>
 <xmqqo94uzyxa.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2a511c3c-ef8d-07c5-80e2-398780ee6ed4@kdbg.org>
Date:   Thu, 25 Apr 2019 21:40:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqo94uzyxa.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.04.19 um 02:55 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Furthermore, basing a decision on whether a file is executable won't
>> work on Windows as intended. So, it is better to aim for an existence check.
> 
> That is a good point.
> 
> So it may be OK for "do we have a single hook script for this hook
> name?" to say "no" when the path exists but not executable on
> POSIXPERM systems, but it is better to say "yes" for consistency
> across platforms (I think that is one of the reasons why we use
> .sample suffix these days).

All correct.

> And for the same reason, for the purpose of deciding "because we do
> not have a single hook script, let's peek into .d directory
> ourselves", mere presence of the file with that name, regardless of
> the executable bit, should signal that we should not handle the .d
> directory.
> 
> IOW, you think access(X_OK) should be more like access(F_OK)?

Yes, that's my conclusion.

-- Hannes
