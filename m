Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFA8C32771
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 11:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439C42080D
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 11:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgAILNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:13:15 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:55191 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbgAILNO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 06:13:14 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 2F44A3C04C0;
        Thu,  9 Jan 2020 12:13:12 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bzHX_jsfoomi; Thu,  9 Jan 2020 12:13:06 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id CA6A13C00B7;
        Thu,  9 Jan 2020 12:13:06 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 9 Jan 2020
 12:13:06 +0100
Date:   Thu, 9 Jan 2020 12:13:06 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Elijah Newren <newren@gmail.com>, <gitster@pobox.com>,
        <peff@peff.net>, <avarab@gmail.com>, <git@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: Unreliable 'git rebase --onto'
Message-ID: <20200109111306.GB1349@lxhi-065.adit-jv.com>
References: <20200108214349.GA17624@lxhi-065.adit-jv.com>
 <20200108223557.GE32750@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108223557.GE32750@szeder.dev>
X-Originating-IP: [10.72.93.66]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Szeder,

On Wed, Jan 08, 2020 at 11:35:57PM +0100, SZEDER Gábor wrote:
> This is a known issue with the 'am' backend of 'git rebase'.
> 
> The good news is that work is already well under way to change the
> default backend from 'am' to 'merge', which will solve this issue.
> From the log message of aa523de170 (rebase: change the default backend
> from "am" to "merge", 2019-12-24):
> 
>   The am-backend drops information and thus limits what we can do:
>   [...]
>     * reduction in context from only having a few lines beyond those
>       changed means that when context lines are non-unique we can apply
>       patches incorrectly.[2]
>   [...]
>   [2] https://lore.kernel.org/git/CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDocKeO+>
> 
> Alas, there is unexpected bad news: with that commit the runtime of
> your 'git rebase --onto' command goes from <1sec to over 50secs.
> Cc-ing Elijah, author of that patch...

[$.02] I would personally take the route of regaining users' trust in
'git rebase' first, with fixing the performance penalty later on.

I was quite impressed by the recent 2.24.0 performance improvements,
which tells there might be room for improvement for `git rebase` too,
once it is fixed.

-- 
Best Regards,
Eugeniu
