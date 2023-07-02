Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC698EB64D9
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 12:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGBMJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 08:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjGBMJK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 08:09:10 -0400
X-Greylist: delayed 1107 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Jul 2023 05:09:09 PDT
Received: from outgoing.fripost.org (giraff.fripost.org [193.234.15.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54392120
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 05:09:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by outgoing.fripost.org (Postfix) with ESMTP id EDE832ABCF11;
        Sun,  2 Jul 2023 14:09:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=x.fripost.org; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :references:from:from:content-language:subject:subject
        :user-agent:mime-version:date:date:message-id; s=
        9df9cdc7e101629b5003b587945afa70; t=1688299747; x=1690114148;
         bh=WhB3Pl1DsQIDioaqFYzPi69HEIw3yY4D6wSIG0ETFQ0=; b=n0OIBobZxBVV
        XE9T5k+C8bCbVK1GHZ4AYDEJHB86OCg3+Sam66tcBN6G2w9zqELT6trPNZf61nds
        WlQZ79By9liHR3nB2EZjRKM3/yDfTgMMqaCo1UecZD0ZYDvcERuMB4yu8EmIYZ5t
        TYGnteBl8FcnloZnqWxAavsFaFLirq5Z28sCQwF0NCiDLHVghsivQaTLqbwcV1vU
        Wy7AVGKw8DdnEBP0OO/hH4PQsNj78opx0PJ72ZB373hzY/G75w3B40OrFoIgTUSm
        SB0OXefsI09sM3NPKqWI3C4dIXgqLoGPaWTHsWoJc/ddWppN9CebSdb9QwHhMYNT
        YfS1/hXfuQ==
X-Virus-Scanned: Debian amavisd-new at fripost.org
Received: from outgoing.fripost.org ([127.0.0.1])
        by localhost (giraff.fripost.org [127.0.0.1]) (amavisd-new, port 10040)
        with LMTP id hSxb8bmOt8Rh; Sun,  2 Jul 2023 14:09:07 +0200 (CEST)
Received: from smtp.fripost.org (unknown [172.16.0.6])
        by outgoing.fripost.org (Postfix) with ESMTP id C89F52ABCF0C;
        Sun,  2 Jul 2023 14:09:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        by smtp.fripost.org (Postfix) with ESMTPSA id 99A55963BF4D;
        Sun,  2 Jul 2023 14:09:07 +0200 (CEST)
Message-ID: <0a90e79c-9850-6b46-6234-962bb8731a30@lidestrom.se>
Date:   Sun, 2 Jul 2023 14:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 9/9] gitk: default select reset hard in dialog
Content-Language: en-GB
From:   =?UTF-8?Q?Jens_Lidestr=c3=b6m?= <jens@lidestrom.se>
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>, git@vger.kernel.org
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
 <97857c3509fb4b45e1bc2d29588374a2631a7c2d.1687876885.git.gitgitgadget@gmail.com>
 <e74cc1b3-8459-101f-4613-17df0f5d69e3@kdbg.org>
 <b2e0d8fa1b54d9dbc6a0831d53acb85f@lidestrom.se>
To:     Johannes Sixt <j6t@kdbg.org>,
        Jens Lidestrom via GitGitGadget <gitgitgadget@gmail.com>
In-Reply-To: <b2e0d8fa1b54d9dbc6a0831d53acb85f@lidestrom.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I updated the implementation to use "mixed" as the default, but allow switching selected item with up and down keys, and accept with enter. It works fine! :)

/Jens

On 2023-06-28 09:16, Jens Lideström wrote:
>> I would prefer to keep the default at "mixed" mode, set the focus on the
>> radio button to make it easy to switch to "hard" mode by hitting the
>> Down arrow key, and then make it so that Enter triggers the OK button.
> 
> That indeed sounds better! Safer but still convenient. I'll change the solution
> to this.
> 
> I noticed that some dialogues have a key bind to close with success using Enter.
> 
> /Jens
> 
> 
> On 2023-06-28 07:46, Johannes Sixt wrote:
>> Am 27.06.23 um 16:41 schrieb Jens Lidestrom via GitGitGadget:
>>> From: Jens Lidestrom <jens@lidestrom.se>
>>>
>>> Reset hard is dangerous but also the most common reset type, and not
>>> having it pre-selected in the dialog is annoying to users.
>>
>> I agree that the operation of the Reset dialog is clumsy before this
>> series. However, this patch together with the previous patch turns it
>> into a foot gun. It becomes far too easy to destroy uncommitted work.
>>
>> I would prefer to keep the default at "mixed" mode, set the focus on the
>> radio button to make it easy to switch to "hard" mode by hitting the
>> Down arrow key, and then make it so that Enter triggers the OK button.
>>
>>> It is also less dangerous in the GUI where there is a confirmation
>>> dialog. Also, dangling commits remain in the GUI and can be recovered.
>>
>> The problem with "hard" mode are not the commits. The real danger is
>> that it blows away uncommitted changes. Besides of that, I do not
>> consider this UI a confirmation dialog.
>>
>> -- Hannes
>>
>>>
>>> Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
>>> ---
>>>  gitk-git/gitk | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/gitk-git/gitk b/gitk-git/gitk
>>> index 9d93053e360..5b0a0ea46be 100755
>>> --- a/gitk-git/gitk
>>> +++ b/gitk-git/gitk
>>> @@ -9906,7 +9906,9 @@ proc resethead {reset_target_id} {
>>>          [mc "Reset branch %s to %s?" $mainhead [commit_name $reset_target_id
>>> 1]]
>>>      pack $w.m -side top -fill x -padx 20 -pady 20
>>>      ${NS}::labelframe $w.f -text [mc "Reset type:"]
>>> -    set resettype mixed
>>> +    # Reset hard is dangerous but also the most common reset type, and not
>>> +    # having it pre-selected in the dialog is annoying to users.
>>> +    set resettype hard
>>>      ${NS}::radiobutton $w.f.soft -value soft -variable resettype \
>>>          -text [mc "Soft: Leave working tree and index untouched"]
>>>      grid $w.f.soft -sticky w
