Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C601D1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 05:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFDF6z (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 01:58:55 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:53493 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFDF6z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 01:58:55 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45J1Ss0xLtz5tlD;
        Tue,  4 Jun 2019 07:58:52 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 172E520F5;
        Tue,  4 Jun 2019 07:58:52 +0200 (CEST)
Subject: Re: [PATCH] am: add --check option
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
References: <BUKFSM2OTJUH.38N6DGWH9KX7H@homura>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c1dec466-55ca-8543-8f4e-b5daf1e0eab6@kdbg.org>
Date:   Tue, 4 Jun 2019 07:58:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BUKFSM2OTJUH.38N6DGWH9KX7H@homura>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.06.19 um 00:00 schrieb Drew DeVault:
> On Mon Jun 3, 2019 at 11:09 PM Johannes Sixt wrote:
>> I have to wonder how --check works when 'am' applies multiple patches.
>>
>> When the second patch in a patch series depends on that the first patch
>> is fully applied, what does --check do? Without the first patch applied,
>> then a naive check of the second patch will certainly fail, doesn't it?
> 
> Yeah, this was being discussed in another thread. It'll fail if the
> second patch relies on changes from the first. Open to suggestions on
> how to improve that, but I think it can be improved in a later patch.
> One solution would be to apply all of the patches and then roll back the
> head, but that would dirty the reflog and wouldn't work on a read-only
> filesystem (which it ought to, imo). We can't just say bugger this for a
> lark and ask people to use git-apply, because git-apply chokes on the
> typical email which isn't in the one specific format git-apply wants to
> see (git-am massages emails into that format before sending them to
> git-apply).
> 

You can 'git apply --cached' the patches on a temporary index. This
works as long as no merge is necessary, because that would require a
worktree.

-- Hannes
