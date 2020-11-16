Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C37BC5519F
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 14:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1FC520731
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 14:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgKPOaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 09:30:46 -0500
Received: from siwi.pair.com ([209.68.5.199]:60491 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbgKPOap (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 09:30:45 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B4A483F5FBE;
        Mon, 16 Nov 2020 09:30:44 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8C6363F5FB1;
        Mon, 16 Nov 2020 09:30:44 -0500 (EST)
Subject: Re: [PATCH] rm: honor sparse checkout patterns
To:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
 <CABPp-BGkkNwdjLB4HSygvU43OZRiuhDyt7RjrDGodWrfNgkBXQ@mail.gmail.com>
 <70ae5b1d-b1d2-1b3f-11cf-8e5ceafe6048@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <be43763e-6931-3e84-8e5a-0ac839cc0566@jeffhostetler.com>
Date:   Mon, 16 Nov 2020 09:30:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <70ae5b1d-b1d2-1b3f-11cf-8e5ceafe6048@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/13/20 8:47 AM, Derrick Stolee wrote:
> On 11/12/2020 6:54 PM, Elijah Newren wrote:
>> Hi,
>>
>> On Thu, Nov 12, 2020 at 1:02 PM Matheus Tavares
>> <matheus.bernardino@usp.br> wrote:
>>>
>>> Make git-rm honor the 'sparse.restrictCmds' setting, by restricting its
>>> operation to the paths that match both the command line pathspecs and
>>> the repository's sparsity patterns. This better matches the expectations
>>> of users with sparse-checkout definitions, while still allowing them
>>> to optionally enable the old behavior with 'sparse.restrictCmds=false'
>>> or the global '--no-restrict-to-sparse-paths' option.
>>
>> (For Stolee:) Did this arise when a user specified a directory to
>> delete, and a (possibly small) part of that directory was in the
>> sparse checkout while other portions of it were outside?
> 
> The user who suggested this used a command like 'git rm */*.csprojx' to
> remove all paths with that file extension, but then realized that they
> were deleting all of those files from the entire repo, not just the
> current sparse-checkout.

Aren't the wildcards expanded by the shell before the command
line is given to Git?  So the Git command should only receive
command line args that actually match existing files, right??

Jeff
