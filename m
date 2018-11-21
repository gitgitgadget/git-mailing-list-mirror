Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99A481F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 12:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbeKUWtB (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 17:49:01 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:7408 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeKUWtB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 17:49:01 -0500
Received: from [192.168.2.201] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id PRP6gCYuXAGVrPRP6gjpJd; Wed, 21 Nov 2018 12:14:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542802489;
        bh=65NvQTQudaby3G8DvOdJ9S8e2IbKt+cN4yN5wkK52dg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=f3Qp3dMXu17z/ChVXJnNuVMxcuXsQmm1ShaoJLGqW4enhcQtVDPJUWnusKQBZC8ZK
         TK+iO0NJXhfthH5czIW6P8WvjEjWFBaXTJbaYe23Oys0EgKf4xE2P4MHedGXaTWPAb
         kS6vsx9AIj2GnSojb5SbqjmUDZnwP9R31nKkoFLU=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=1XWaLZrsAAAA:8 a=z_bwQMElihWXc6KdpOcA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     Stefan Xenos <sxenos@google.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
References: <20181115005546.212538-1-sxenos@google.com>
 <d77c4aa6-be5e-a6fe-1d43-6cfa28161ae1@talktalk.net>
 <CAPL8ZiukW+mkYBpk-qSmpy3o8u0-mVtcytKLHMz8wpkDd+mRKQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <6a8cc06d-fda4-88f6-b106-5d7a5f7c31bf@talktalk.net>
Date:   Wed, 21 Nov 2018 12:14:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAPL8ZiukW+mkYBpk-qSmpy3o8u0-mVtcytKLHMz8wpkDd+mRKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfE5VAEVobiqiwb2Ayy84BxPgKFYuJrcIbt9m3Bp8Ig7MkxwC5D/IocFY+/0aLIQmJfqBrFYd8C8oKzrx28BnPasOBGBO2HmABRTWKsYHHkojM+hzblPu
 hddxYsJpD3WcW1PrUa45csdDiPYNqnj1CGKIO4vjKJjM0F6MQSJ2+gk0YKADd8nr55dcKeyCjXTVx2xasnmS1zjH4aUMMgBpKx9//f3V6Cqb6OIXOHxpj0SD
 pFDu9VFo+SjDtDga8pvt2n4eGubDgbgOY6Y00mM78yOCmZ3sXs0XVeiIq7OMcM5bhwXs0Y0zrznS+sTK3P0fFcAjtliCD+kP06KI7pBdD6cxy10hnkvUeJvb
 xmpUTCSYhnMcnJtz/yARmLqnpyxj0jSuCt5SkW0ayaBYDTxJIYGU3kliNyK/t371IHIIf0n6QCiAECvolnhZdB0qxoegRw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

On 20/11/2018 20:24, Stefan Xenos wrote:
>> If a merge has been cherry-picked we cannot update it as we don't record
>> which parent was used for the pick, however it is probably not a problem
>> in practice - I think it is unusual to amend merges.
> 
> I've read and reread that sentence several times and don't fully
> understand it. Could you elaborate?

Sorry if I wasn't very clear. To cherry-pick (or revert) a merge commit
one has to specify a parent of the commit being picked with -m for
cherry-pick to use as the merge base for the three way merge that
creates the new commit. If the original merge is updated then evolve
wont know which parent to use as the merge base when evolving the
cherry-picked version of the merge as the parent is not recorded in the
meta commit.

> It sounds scary, though. With the evolve command, amending merges will
> need to be supported.

Evolving a merge should be fine, I was just referring to merges that
have been cherry-picked.


Best Wishes

Phillip

(Thanks for your reply to my other message, I'm still digesting it at
the moment, once I've done that and found the references to mercurial
using commit obsolescence information in rebase and pull I'll reply.)

> If you create a merge and then amend one of its
> parent commits, the evolve command will need to rebase the merge and
> point one or both parents to the replacement instead.
> 
>   - Stefan
> On Tue, Nov 20, 2018 at 5:03 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>>
>> On 15/11/2018 00:55, sxenos@google.com wrote:
>>> From: Stefan Xenos <sxenos@google.com>
>>>
>>> +Obsolescence across cherry-picks
>>> +--------------------------------
>>> +By default the evolve command will treat cherry-picks and squash merges as being
>>> +completely separate from the original. Further amendments to the original commit
>>> +will have no effect on the cherry-picked copy. However, this behavior may not be
>>> +desirable in all circumstances.
>>> +
>>> +The evolve command may at some point support an option to look for cases where
>>> +the source of a cherry-pick or squash merge has itself been amended, and
>>> +automatically apply that same change to the cherry-picked copy. In such cases,
>>> +it would traverse origin edges rather than ignoring them, and would treat a
>>> +commit with origin edges as being obsolete if any of its origins were obsolete.
>>
>> If a merge has been cherry-picked we cannot update it as we don't record
>> which parent was used for the pick, however it is probably not a problem
>> in practice - I think it is unusual to amend merges.
>>
>> Best Wishes
>>
>> Phillip

