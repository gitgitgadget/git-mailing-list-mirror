Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAACC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 857C1610FC
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 20:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhDHUVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 16:21:09 -0400
Received: from siwi.pair.com ([209.68.5.199]:31789 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231451AbhDHUVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 16:21:09 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CC1C43F40B7;
        Thu,  8 Apr 2021 16:20:56 -0400 (EDT)
Received: from HCIPROD2.AZHCI.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A45B33F4098;
        Thu,  8 Apr 2021 16:20:56 -0400 (EDT)
Subject: Re: [PATCH v8 37/37] docs: unify githooks and git-hook manpages
To:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-38-emilyshaffer@google.com>
 <xmqq5z0y2540.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7b651fbf-7f54-21b3-3775-d18c20f85a1a@jeffhostetler.com>
Date:   Thu, 8 Apr 2021 16:20:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq5z0y2540.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/6/21 10:36 PM, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
>> By showing the list of all hooks in 'git help hook' for users to refer
>> to, 'git help hook' becomes a one-stop shop for hook authorship. Since
>> some may still have muscle memory for 'git help githooks', though,
>> reference the 'git hook' commands and otherwise don't remove content.
>>
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>> ---
>>   Documentation/git-hook.txt     |  11 +
>>   Documentation/githooks.txt     | 716 +--------------------------------
>>   Documentation/native-hooks.txt | 708 ++++++++++++++++++++++++++++++++
>>   3 files changed, 724 insertions(+), 711 deletions(-)
>>   create mode 100644 Documentation/native-hooks.txt
> 
> While this would be a very good move when this were the only topic
> juggling the hook related documentation, in the real world, it
> creates rather nasty "ouch, the original hooks document was updated,
> and we need to carry these changes over to the new native-hooks
> file" conflicts with multiple commits on different topics.
> 
> $ git log --oneline --no-merges es/config-hooks..seen Documentation/githooks.txt
> 2d4e48b8ee fsmonitor--daemon: man page and documentation
> 23c781f173 githooks.txt: clarify documentation on reference-transaction hook
> 5f308a89d8 githooks.txt: replace mentions of SHA-1 specific properties
> 7efc378205 doc: fix some typos
> 
> $ git log --oneline --no-merges ^master es/config-hooks..seen Documentation/githooks.txt
> 2d4e48b8ee fsmonitor--daemon: man page and documentation
> 
> As three of the four changes are already in master, it probably is a
> good idea to rebase this topic (and redo this step) to update the
> native-hooks.txt
> 
> I am not sure offhand how ready fsmonitor--daemon stuff is, but if
> it takes longer to stabilize than this topic, it might make sense to
> hold off the changes to githooks.txt in that topic, until this topic
> stabilizes enough to hit at least 'next', preferrably 'master', and
> then base that topic (or at least the documentation part of it) on
> the final shape of the native-hooks.txt.
> 
> Or better ideas?
> 
> Thanks.
> 

I expect the fsmonitor stuff to take a while.  It is rather large
and complicated.  My changes in the Documentation are rather minor.
And I wouldn't want to be the sole reason to hold up Emily's changes.

If it would be helpful, you can add a "revert" commit on top of my
branch for my documentation commit -or- just drop it completely from
my series.  Then I can re-adjust/rebase my doc changes before
I send a V2.

Jeff
