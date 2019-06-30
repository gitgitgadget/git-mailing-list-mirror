Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BFE31F461
	for <e@80x24.org>; Sun, 30 Jun 2019 18:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfF3S22 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 14:28:28 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:6906 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbfF3S22 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 14:28:28 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45cJsk26HPz5tlF;
        Sun, 30 Jun 2019 20:28:26 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B3CC937B;
        Sun, 30 Jun 2019 20:28:25 +0200 (CEST)
Subject: Re: [BUG] Symbolic links break "git fast-export"?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <95EF0665-9882-4707-BB6A-94182C01BE91@gmail.com>
 <CABPp-BE8um5g98jqWawsuG2dAvO6AZcR54vrRzAkJbq+L3K6Zw@mail.gmail.com>
 <20190624185835.GA11720@sigill.intra.peff.net>
 <25624E1D-55F1-466D-92E0-F06C1909F920@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5b00da7c-6836-0e61-8262-a9035126b658@kdbg.org>
Date:   Sun, 30 Jun 2019 20:28:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <25624E1D-55F1-466D-92E0-F06C1909F920@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.06.19 um 15:05 schrieb Lars Schneider:
>> On Jun 24, 2019, at 11:58 AM, Jeff King <peff@peff.net> wrote:
>> You'd have to split the renames into separate delete/adds, since they
>> can have a circular dependency. E.g. renaming "foo" to "bar" and "bar"
>> to "foo", you must remove "foo" and "bar" both, and then add them back
>> in.
> 
> @peff: Can you give me a hint how one would perform this circular
> dependency in a single commit? I try to write a test case for this.

git mv Makefile foo
git mv COPYING Makefile
git mv foo COPYING
git diff -B HEAD

-- Hannes
