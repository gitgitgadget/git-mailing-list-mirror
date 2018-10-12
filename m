Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEDD31F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 16:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeJLXsk (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 19:48:40 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:64732 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728735AbeJLXsk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 19:48:40 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42WtGj0hknz5tld;
        Fri, 12 Oct 2018 18:15:25 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 54B2241A8;
        Fri, 12 Oct 2018 18:15:24 +0200 (CEST)
Subject: Re: [PATCH v3 4/7] revision.c: begin refactoring --topo-order logic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
 <pull.25.v3.git.gitgitgadget@gmail.com>
 <fd1a0ab7cdaa06fd99f86fec51b483238f588296.1537551564.git.gitgitgadget@gmail.com>
 <xmqqwoqnbrmw.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <fa365691-e8ae-4aa8-5c76-b5c8c925c2f8@kdbg.org>
Date:   Fri, 12 Oct 2018 18:15:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqwoqnbrmw.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.10.18 um 08:33 schrieb Junio C Hamano:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +struct topo_walk_info {};
>> +
>> +static void init_topo_walk(struct rev_info *revs)
>> +{
>> +	struct topo_walk_info *info;
>> +	revs->topo_walk_info = xmalloc(sizeof(struct topo_walk_info));
>> +	info = revs->topo_walk_info;
>> +	memset(info, 0, sizeof(struct topo_walk_info));
> 
> There is no member in the struct at this point.  Are we sure this is
> safe?  Just being curious.

sizeof cannot return 0. sizeof(struct topo_walk_info) will be 1 here.

-- Hannes
