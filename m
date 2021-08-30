Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF31DC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 09:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B43B60184
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 09:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhH3J2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 05:28:47 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:30324 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235073AbhH3J2q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 05:28:46 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mKda3-0007QC-AI; Mon, 30 Aug 2021 10:27:51 +0100
Subject: Re: Git re-creates newly added directory when it is pushed
To:     Junio C Hamano <gitster@pobox.com>, Yuri <yuri@rawbw.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <c0557284-8f82-76cc-8c47-0b1bc9f2ce5a@rawbw.com>
 <CABPp-BFwvDY6-6pQ2MSPzAGafONjTEMNUkLwuRuQCJ_wx2ns2w@mail.gmail.com>
 <xmqqv93n7q1v.fsf@gitster.g> <da2bfcc8-09b2-c909-a316-343ab3108a58@rawbw.com>
 <xmqqk0k37p1t.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <677bef35-4d27-748a-1508-2e65707317ee@iee.email>
Date:   Mon, 30 Aug 2021 10:27:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0k37p1t.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/08/2021 01:29, Junio C Hamano wrote:
> Yuri <yuri@rawbw.com> writes:
>
>> On 8/29/21 5:07 PM, Junio C Hamano wrote:
>>> This is one of the reasons why "rebase" (especially "rebase -i") may
>>> want to insist starting at the top-level of the working tree, like
>>> "git bisect" does.  Because running the command from a subdirectory
>>> works most of the time until it doesn't, people tend to complain why
>>> they should go up to the top-level before they can run the command.
>>>
>>> And this is why---it causes end-user confusion.
>>
>> But there's no confusion here - git doesn't have to delete the
>> directory and recreate it, but it does it anyway.
>>
>> So this is just a bug that git disturbs users more than it should.
> No, this is an example that users usually can be unaware of the
> reason why it is a bad idea to start from subdirectories.
>
> As Elijah explained, if a multi-step rebase had to stop and ask help
> from the user to resolve conflict _before_ the step that creates the
> user's current directory, it would leave the user in a confusing
> situation where the user thinks is in a directory but that directory
> does not yet exist in the filesystem.
Does this end up being a documentation issue?

e.g. Users should start at top-level because..
or Note, if the current directory is removed at some step during the
rebase then..

Often folk do read the documentation as a lest resort..
-- 
Philip
