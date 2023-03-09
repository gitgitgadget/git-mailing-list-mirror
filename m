Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7586C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 14:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjCIOzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 09:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjCIOzA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 09:55:00 -0500
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E94F31F9
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 06:51:58 -0800 (PST)
Received: from [192.168.42.163] (42-98-142-46.pool.kielnet.net [46.142.98.42])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 2F2C73C0939;
        Thu,  9 Mar 2023 15:45:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1678373104;
        bh=w5mkS2+b0aEKiVAK0ix1PSkS8bUl34vcEQfvLOZ8Fus=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PQIO2UBBQ3SjbZbtjW2cZfr52fklIb0K2HSfPSTGumr7hu02U10CA5lJQ/R5zdA46
         /uKSt0RUvpqwzWEAL6H9m27qaQmilk1N7LfAaueCTDw6oc7X+jLYUkqX8jRNyysH6V
         zYSpDuISo+rEbtHO+rhiZjKyHZ6vwAQ06IQLieDUo6NNx7ubEcasveQUUTqRvSuWbu
         kzd84lVLxTYc//XpSR59lye1xjn5V/CXCXhBI+rAemGeI7LbY/YtVMBIrJ4W1tcKgl
         6vqoMhegs9VEQFC7dSnyNrZTQUNiyplmjoZDaFNtPWXgLRIzFVPH6uXSQcnm1GS/QW
         ab9/QiJwyVwpg==
Message-ID: <7a79f579-651c-2fae-124e-66a10b4784a1@haller-berlin.de>
Date:   Thu, 9 Mar 2023 15:45:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: When exactly should REBASE_HEAD exist?
Content-Language: de-DE, en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <xmqqo7p4zb8d.fsf@gitster.g>
 <28b78355-e3db-d33a-c576-653740a4a1f3@haller-berlin.de>
 <xmqqa60nt4jd.fsf@gitster.g>
From:   Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <xmqqa60nt4jd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08.03.23 20:40, Junio C Hamano wrote:
> Stefan Haller <lists@haller-berlin.de> writes:
> 
>> On 07.03.23 19:07, Junio C Hamano wrote:
>> ...
>>> Stepping a bit, how does our "git status" fare here?  It shows what
>>> step in a sequence "rebase -i" the user who got control back (due to
>>> "break", "exec sh", "edit" or a conflicted "pick") is in.  Or at
>>> least it tries to.  Does it suffer from the same "great, but ..."?
>>> ...
>>
>> It fares a little better, but not much, and it doesn't look like I can
>> use its information to implement the behavior I want.
> 
> Thanks.  That is the kind of information I was trying to find.  It
> means that the current "git status" does not give our users enough
> clue as to where in their "rebase -i" session they are at, and we
> will help more users by teaching "git status" the trick you are
> designing.  Instead of peeking into how the implementation details
> like REBASE_HEAD currently happen to work, making sure underlying
> "git" knows how to present the information you want and letting it
> perform the heavy lifting would make sure the solution will stay
> supported across versions of future git.

Yes; as I said over in the other branch of this thread, I agree that it
would be great to have this in status, but I'm afraid I'm not the one to
drive the work to get it in there. I don't have the capacity to
contribute to yet another open source project.

If somebody else wanted to take this on, I'd be happy to join any design
discussions, or do early testing to see if whatever is being added works
for my use case.

-Stefan
