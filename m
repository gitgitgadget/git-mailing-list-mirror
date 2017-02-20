Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAAA3201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 20:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbdBTUbq (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 15:31:46 -0500
Received: from 5.itsy.de ([188.40.84.14]:41005 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751240AbdBTUbp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 15:31:45 -0500
Received: from [192.168.0.19] (84-75-134-174.dclient.hispeed.ch [84.75.134.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id 5E26D64565;
        Mon, 20 Feb 2017 21:31:42 +0100 (CET)
Subject: Re: url.<base>.insteadOf vs. submodules
To:     Jeff King <peff@peff.net>
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
 <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Toolforger <toolforger@durchholz.org>
Message-ID: <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org>
Date:   Mon, 20 Feb 2017 21:31:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20.02.2017 10:01, Jeff King wrote:
> On Sun, Feb 19, 2017 at 10:12:28PM +0100, Toolforger wrote:
>
>> I am trying to make url.<base>.insteadOf work on the URLs inside
>> .gitmodules, but it won't work (applying it to the repo itself works fine,
>> to the config setting seems to be fine).
>
> The submodule operations happen in their own processes, and do not look
> at the config of the parent repo.

Ah, then we have a docbug.
git help config has this to say:

url.<base>.insteadOf
     Any URL that starts with this value will be rewritten to start,
     instead, with <base>.

The "Any" here is wrong, it would be "any except submodule" (possibly 
other exceptions).

 > Are you setting the config in
> .git/config of the super-project?

Exactly.
My thinking was that since the submodule URLs are specified in the super 
project's .gitmodules, that setting should apply.

> I don't know if there plans to make that work,

It would certainly help me out, though I guess it's going to be too late 
for my current project :-)

 > but one workaround is to set the config in ~/.gitconfig.

No can do - that's under version control.
My personal setup does not belong there I think ;-)

I am currently trying to write a shell script that
- does git submodule init
- pulls submodule configuration out of git config -l
- configures each submodule with insteadOf
It fits with my workflow because setting up the repositories is going to 
be done via script anyway.
I'm neither a shell nor a git expert, so any advice still appreciated.

Regards,
Jo
