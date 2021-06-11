Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66C1C4743D
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 06:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBA561184
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 06:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFKGZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 02:25:33 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:12789 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhFKGZc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 02:25:32 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4G1W4f6k4mz5tl9;
        Fri, 11 Jun 2021 08:23:30 +0200 (CEST)
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net> <xmqqh7i5ci3t.fsf@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
Date:   Fri, 11 Jun 2021 08:23:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7i5ci3t.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.06.21 um 03:20 schrieb Junio C Hamano:
> Yes, it does not help that the given sample involves conflicts in
> the inner merge, which is unfortunately almost unreadable.  For less
> confusing merges, diff3 style is often a lifesaver necessary for
> avoiding mismerges by showing what the common ancestor looked like,
> so that the reader/merger/integrator can tell what each side wanted
> to do to the conflicted section.
> 
> Rejecting diff3 style output because of the way a conflicted part in
> the inner merge appears as a common ancestor version may be throwing
> the baby out with the bathwater.  A different way to say it is that
> until we improve the way the conflicted inner merge is shown, diff3
> style is not something we can recommend to new users as a default, I
> would think.

I understand that diff3 is very useful for an integrator like you who
does a lot of merges of code that was not written by yourself.

But I would estimate that most conflicts (in absolute number among all
developers using Git) arise during rebase operations and cherry-picking,
i.e., while one is working on their own code. In such sitations, the
simpler conflict markup is sufficient, because one knows the background
and reason of the conflicts. And then the ability to compact conflicts
is a life-saver. Therefore, I argue that simple conflict style should
remain the default even if the presentation of inner conflicts under
diff3 style is improved.

-- Hannes
