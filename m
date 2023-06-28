Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E579AEB64DA
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 08:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjF1IeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 04:34:22 -0400
Received: from giraff.fripost.org ([193.234.15.44]:58568 "EHLO
        outgoing.fripost.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjF1Ib7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 04:31:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by outgoing.fripost.org (Postfix) with ESMTP id BFD522AB2402;
        Wed, 28 Jun 2023 09:16:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=x.fripost.org; h=
        content-transfer-encoding:content-type:content-type:message-id
        :user-agent:references:in-reply-to:subject:subject:from:from
        :date:date:mime-version; s=9df9cdc7e101629b5003b587945afa70; t=
        1687936571; x=1689750972; bh=SEIEqAVwmOklcrDWnoegvIbPXeCQgEGOvY4
        Snay5RmI=; b=ePXVBu3RIYN7sJ+376abTs9Kx1/YZZVjY4BbVfrPjwedTQv3OdS
        W25P7M0/9mMpBsfhCrSMvbDZYVlkfJH6EjdyN5QEmB7NqxTtNus+5q/1MSCBS+LM
        G8DXVKIk4ZWJLuy+B/Rayf6UOBH3yW05U7oVjniwBZzgDDn3z0QhOujnjQvy8XtP
        T0PJK3hHimVsD7liO/MPP62E4ib1A3jereG8rb20mgBsy1mQzSAGSqLr9kQUWwWu
        0QPlPSwzaaKy9gLFVo8tqXg6otqxP20hLdrQBsh0+/UTY/vJ7zgsBpFu/yeS0gjC
        shCswDW3uXplC/QiFvrN3chBvnb7dgR0ZMQ==
X-Virus-Scanned: Debian amavisd-new at fripost.org
Received: from outgoing.fripost.org ([127.0.0.1])
        by localhost (giraff.fripost.org [127.0.0.1]) (amavisd-new, port 10040)
        with LMTP id cSRRiPIPZGVG; Wed, 28 Jun 2023 09:16:11 +0200 (CEST)
Received: from smtp.fripost.org (unknown [172.16.0.6])
        by outgoing.fripost.org (Postfix) with ESMTP id 9C4922AB23FD;
        Wed, 28 Jun 2023 09:16:11 +0200 (CEST)
Received: from mail.fripost.org (unknown [172.16.0.4])
        by smtp.fripost.org (Postfix) with ESMTPA id 861B596129EA;
        Wed, 28 Jun 2023 09:16:11 +0200 (CEST)
MIME-Version: 1.0
Date:   Wed, 28 Jun 2023 09:16:11 +0200
From:   =?UTF-8?Q?Jens_Lidestr=C3=B6m?= <jens@lidestrom.se>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>, git@vger.kernel.org
Subject: Re: [PATCH 9/9] gitk: default select reset hard in dialog
In-Reply-To: <e74cc1b3-8459-101f-4613-17df0f5d69e3@kdbg.org>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <97857c3509fb4b45e1bc2d29588374a2631a7c2d.1687876885.git.gitgitgadget@gmail.com>
 <e74cc1b3-8459-101f-4613-17df0f5d69e3@kdbg.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <b2e0d8fa1b54d9dbc6a0831d53acb85f@lidestrom.se>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I would prefer to keep the default at "mixed" mode, set the focus on 
> the
> radio button to make it easy to switch to "hard" mode by hitting the
> Down arrow key, and then make it so that Enter triggers the OK button.

That indeed sounds better! Safer but still convenient. I'll change the 
solution to this.

I noticed that some dialogues have a key bind to close with success 
using Enter.

/Jens


On 2023-06-28 07:46, Johannes Sixt wrote:
> Am 27.06.23 um 16:41 schrieb Jens Lidestrom via GitGitGadget:
>> From: Jens Lidestrom <jens@lidestrom.se>
>> 
>> Reset hard is dangerous but also the most common reset type, and not
>> having it pre-selected in the dialog is annoying to users.
> 
> I agree that the operation of the Reset dialog is clumsy before this
> series. However, this patch together with the previous patch turns it
> into a foot gun. It becomes far too easy to destroy uncommitted work.
> 
> I would prefer to keep the default at "mixed" mode, set the focus on 
> the
> radio button to make it easy to switch to "hard" mode by hitting the
> Down arrow key, and then make it so that Enter triggers the OK button.
> 
>> It is also less dangerous in the GUI where there is a confirmation
>> dialog. Also, dangling commits remain in the GUI and can be recovered.
> 
> The problem with "hard" mode are not the commits. The real danger is
> that it blows away uncommitted changes. Besides of that, I do not
> consider this UI a confirmation dialog.
> 
> -- Hannes
> 
>> 
>> Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
>> ---
>>  gitk-git/gitk | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/gitk-git/gitk b/gitk-git/gitk
>> index 9d93053e360..5b0a0ea46be 100755
>> --- a/gitk-git/gitk
>> +++ b/gitk-git/gitk
>> @@ -9906,7 +9906,9 @@ proc resethead {reset_target_id} {
>>          [mc "Reset branch %s to %s?" $mainhead [commit_name 
>> $reset_target_id 1]]
>>      pack $w.m -side top -fill x -padx 20 -pady 20
>>      ${NS}::labelframe $w.f -text [mc "Reset type:"]
>> -    set resettype mixed
>> +    # Reset hard is dangerous but also the most common reset type, 
>> and not
>> +    # having it pre-selected in the dialog is annoying to users.
>> +    set resettype hard
>>      ${NS}::radiobutton $w.f.soft -value soft -variable resettype \
>>          -text [mc "Soft: Leave working tree and index untouched"]
>>      grid $w.f.soft -sticky w
