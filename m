Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40D041F453
	for <e@80x24.org>; Fri, 21 Sep 2018 17:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390524AbeIUWzt (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 18:55:49 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:25189 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388909AbeIUWzt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 18:55:49 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42H0Nm3jbnz5tlK;
        Fri, 21 Sep 2018 19:06:00 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A0EC54158;
        Fri, 21 Sep 2018 19:05:59 +0200 (CEST)
Subject: Re: What's cooking in git.git (Sep 2018, #04; Thu, 20)
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <e87e83c2-b371-1cc3-7eef-495f03ef05ef@kdbg.org>
Date:   Fri, 21 Sep 2018 19:05:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.09.18 um 07:22 schrieb Junio C Hamano:
> The tip of 'next' hasn't been rewound yet.  The three GSoC "rewrite
> in C" topics are still unclassified in this "What's cooking" report,
> but I am hoping that we can have them in 'next' sooner rather than
> later.  I got an impression that Dscho wanted a chance for the final
> clean-up on some of them, so I am not doing anything hasty yet at
> this moment, though.

While playing around with those topics in my own build on Windows, I
noticed a small glitch in your merge commits.

When I compile 59085279e6, which is today's jch~11, I see

    CC builtin/rebase.o
builtin/rebase.c: In function 'can_fast_forward':
builtin/rebase.c:443:2: warning: implicit declaration of function 'get_merge_bases' [-Wimplicit-function-declaration]
  merge_bases = get_merge_bases(onto, head);
  ^
builtin/rebase.c:443:14: warning: assignment makes pointer from integer without a cast [enabled by default]
  merge_bases = get_merge_bases(onto, head);
              ^

I notice that you fixed it in the next merge, jch~10 aka d311e29abe,
by adding

#include "commit-reach.h"

in builtin/rebase.c; this line is obviously required one merge
commit earlier, jch~11.

-- Hannes
