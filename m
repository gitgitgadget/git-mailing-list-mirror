Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03E3C6FD18
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 19:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDVTyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 15:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDVTym (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 15:54:42 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B71D1998
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 12:54:41 -0700 (PDT)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <admin@game-point.net>)
        id 1pqJJf-009GFj-3i; Sat, 22 Apr 2023 21:54:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=game-point.net; s=selector2; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject;
        bh=e9mD6kT+kOVl3pDMI9UBUxJ9oPuQBEswf7TgiJeSjdc=; b=YAvsL0PQ5rxL4L1+0vPKHZt1AJ
        4oSs0eoOi24zTelUhYdCRvG35MoOVf8nC7qGce94zN2YsqSr5I9BizCbVQ1YjyF5uTdH0fj39uE37
        uESytR4lmSyaIGPwdV+L8wRWhrwtMA8/wg5obW22MQuIWjFdvVeO7pS5XY1m8N70qkfrnRs4M1HiI
        FEvjlk9wFfd011bhHyVOLv+HOs2LIRKIKRFJeZOc/74eazf304r18CtT1QBCCBuG+tMeY02g+jUoT
        iZS7m4VH/MqBlWzCxvbzO4CUJ/GzL9tk/GJ4prkgKcLbM0HAudY+IRxMe4VR1dYOH+cqC/1/bah5M
        fMiyxhUg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <admin@game-point.net>)
        id 1pqJJe-0006S3-L6; Sat, 22 Apr 2023 21:54:38 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (956903)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1pqJJZ-0002Dx-BX; Sat, 22 Apr 2023 21:54:33 +0200
Subject: Re: Proposal: tell git a file has been renamed
To:     rsbecker@nexbridge.com, git@vger.kernel.org
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
 <01cd01d9754b$f12326b0$d3697410$@nexbridge.com>
 <fbe77ad2-ce65-e6a6-254e-01bf6446d582@game-point.net>
 <01ce01d97553$4361f990$ca25ecb0$@nexbridge.com>
From:   Jeremy Morton <admin@game-point.net>
Message-ID: <3ac19159-7314-c299-5112-b0f7aa2cc409@game-point.net>
Date:   Sat, 22 Apr 2023 20:54:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
In-Reply-To: <01ce01d97553$4361f990$ca25ecb0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://stackoverflow.com/a/1094392/178757

says:

git mv oldname newname

is just shorthand for:

mv oldname newname
git add newname
git rm oldname

-- 
Best regards,
Jeremy Morton (Jez)

On 22/04/2023 20:47, rsbecker@nexbridge.com wrote:
> No, history is preserved in the rename.
> 
>> -----Original Message-----
>> From: Jeremy Morton <admin@game-point.net>
>> Sent: Saturday, April 22, 2023 3:45 PM
>> To: rsbecker@nexbridge.com; git@vger.kernel.org
>> Subject: Re: Proposal: tell git a file has been renamed
>>
>> I read that git mv is basically the equivalent to deleting the old file, creating the new
>> file, and adding the changes.  Isn't it?  If so it's gonna have the same problem as I
>> have now.
>>
>> --
>> Best regards,
>> Jeremy Morton (Jez)
>>
>> On 22/04/2023 19:54, rsbecker@nexbridge.com wrote:
>>> On Saturday, April 22, 2023 2:02 PM, Jeremy Morton wrote:
>>>> Yes, I know Linus specifically doesn't store file rename info in Git.
>>>> The trouble is, every now and then, I'll come across a situation
>>>> where Git doesn't successfully detect that I've renamed a file
>>>> because I'm doing something like renaming a class at the same time.
>>>> So I'll have a file OldClassNameTests.cs and a NewClassNameTests.cs
>>>> but a bunch of lines in that file have also changed from
>>>> OldClassName.DoThing() to NewClassName.DoThing().  I can clearly see
>>>> that this is a rename, but Git sees enough changed content that it
>>>> doesn't realize it, and puts it in as a delete/add, losing the content history.
>>>>
>>>> The standard answer for this is to rename the file in one commit,
>>>> then make the changes.  That's fine if you know ahead of time you'll
>>>> want to do this.  However it's a total PITA if you have a bunch of
>>>> changes and you realize that a rename has caused this problem.  You
>>>> now have to back out your changes to the renamed file, add the rename, commit
>> it, then re-apply the changes.
>>>>
>>>> Could a command be added to git that means you tell Git that counts
>>>> as a file rename?  Git would add a marker to the staging area that
>>>> the file has been renamed, and upon commit, would first generate an
>>>> additional commit for each rename before generating the main commit,
>>>> ensuring the rename operation counts as an actual rename, and the content's
>> history is maintained.
>>>
>>> Would git mv work in your situation? You can stage changes to the original file,
>> then use git mv. Or use git mv first. The rename shows as staged in any event.
>>> --Randall
>>>
>>>
> 
> 
