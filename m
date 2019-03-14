Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2BE820248
	for <e@80x24.org>; Thu, 14 Mar 2019 06:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfCNGkX (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 02:40:23 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:24220 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfCNGkW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 02:40:22 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44KfGX50YQz5tlC;
        Thu, 14 Mar 2019 07:40:20 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 97A451D17;
        Thu, 14 Mar 2019 07:40:19 +0100 (CET)
Subject: Re: [PATCH 1/4] rebase -i: demonstrate obscure loose object cache bug
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.161.git.gitgitgadget@gmail.com>
 <b3fcd377652103584b6f307c6ee209980b44529f.1552472189.git.gitgitgadget@gmail.com>
 <87k1h2bvpb.fsf@evledraar.gmail.com>
 <20190313163516.GA26045@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0f7870b7-f92a-ad63-7854-300c202cb4a8@kdbg.org>
Date:   Thu, 14 Mar 2019 07:40:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313163516.GA26045@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.03.19 um 17:35 schrieb Jeff King:
> On Wed, Mar 13, 2019 at 05:11:44PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> As a further improvement, is there a good reason for why we wouldn't
>> pass something down to the oid machinery to say "we're only interested
>> in commits". I have a WIP series somewhere to generalize that more, but
>> e.g.  here locally:
> 
> We have get_oid_commit() and get_oid_committish() already. Should rebase
> just be using those? (I think we probably want "commit()", because we do
> not expect a "pick" line to have a tag, for example.

'pick' needs all the power of revision expressions. Not all too
infrequently I do insert a pick line with a rev expression argument.
Assuming that the resolved object is a commit is too strict.

-- Hannes
