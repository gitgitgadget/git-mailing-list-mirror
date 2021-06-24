Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17C5C49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 18:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E496613B3
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 18:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhFXSlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 14:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhFXSlu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 14:41:50 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00901C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 11:39:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o33-20020a05600c5121b02901e360c98c08so5151548wms.5
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H2gjNHoMdyERUX+ZNKO+a9oYjhFpcJrx36Gh82SjsM8=;
        b=hKHYE3Yqgdtg2C/5kTQfcRm2xatUmKU8gkp28rU3ZGqOtAd2iWEsu8VN9dB6+mKeb5
         iqMDsaIRgoy/4IIo2jcGa8A//Enxi4Z5osPA5ssQh5tEh7p45ndmj4dFnUlgw0cLG16i
         zPWcc0kyRJd+Lq0rIonD1YiZuRWrTaVFXva4Zgzj+e4OprwtrQDLPQ49Dbpy6uIYGX5d
         cNMzlvLYdWszma6oz+ICLdKBHV3uhy5E97/fgJr7iRKGxX+/6exnRWiSEdUh6ZNttrOs
         IawW5ul20W4R7zeDVrXKO1ovPKc46iowdkFXconmjGAbMrTqAH/icEYLoIkNX+yDihJ1
         QMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=H2gjNHoMdyERUX+ZNKO+a9oYjhFpcJrx36Gh82SjsM8=;
        b=JgbkE/ri25vFIxkYon0M6eesvQpdLTh/uXzdKCmPhiRxXso/rp6kzEvy8PG7fV+1TV
         WrXoLWGkh44F8r+nWJZlFBcZofgZLaB7DCnJ/vJHW+NhptfIGyO2AY7Pr4D2W1QbmTfq
         z6gdo2ki9nW6pCCrLHoXqUKEq5YiGjIrVLyGV//fmbYCF9B8U712bpo4WMMVbj3lYIDt
         0mSVriUDT2YI9UE/W/sqg0z5q/NZNnXpx4zjOr3pX6Uw7ISNw2xiBXuqChKPO8DC3Ini
         i/wPP6MsCVP6zo7swc9V/UbMcVhmEWOl0CxZnnYWSkk09vgnZNMY8J4ARQBawjJnSBk/
         ow6g==
X-Gm-Message-State: AOAM530+bAx0szduXOTMGrRTT+JVHU2IZuPxcW3CqgTcBeaRKPL9WFI+
        VPieUrEFOFJkFF/sPAsTftogwXzXI2U=
X-Google-Smtp-Source: ABdhPJxeMAn4/But3eRA43W1UpdlHPzucok6wRM48WfJP4jrylVsr7UHmJSA4ZOVWH8+RRBGiXpf2w==
X-Received: by 2002:a05:600c:3ba6:: with SMTP id n38mr4834864wms.9.1624559967574;
        Thu, 24 Jun 2021 11:39:27 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id z6sm3684784wrh.65.2021.06.24.11.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 11:39:27 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Nonexistent changes appear rebasing but only with
 rebase.backend=apply
To:     Marco Giuliano <marco.giuliano@tesisquare.com>,
        felipe.contreras@gmail.com
Cc:     git@vger.kernel.org
References: <CANLwWg4hG=iv9qjOmGHSJ7z7Y+vvvP+x0o3DfR5bH5A-C6_7aQ@mail.gmail.com>
 <9a83ef22-2291-1364-b0a8-1eb8257972a2@gmail.com>
 <CANLwWg5Lcf7PYtZ49U-KZ_3UYVb9FJ-g1B+eFYoO2D1t5UArmw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6b604658-8f7e-ae5d-7161-c48aed7ccbd0@gmail.com>
Date:   Thu, 24 Jun 2021 19:39:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CANLwWg5Lcf7PYtZ49U-KZ_3UYVb9FJ-g1B+eFYoO2D1t5UArmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marco

On 24/06/2021 17:23, Marco Giuliano wrote:
> Thanks Felipe and Philip for your answers.
> 
> Let's proceed in order:
> @Felipe: I tried rebasing with --no-fork-point but the problem remains the same
> 
> @Philip:
> I'm a basic git user, so bear with me if I say silly things...
> I tried to search for rebased-patches in .git folder when rebase
> stopped waiting for
> conflict resolution, but I didn't find any file named like that.
> There's a folder named rebase-apply though did you mean that ?

Looking at the source I thought they ended up just in .git but I haven't 
checked again, as you seem to have found the source of the problem below 
lets not worry about that.

> Anyway, looking at the conflict file of "fileA" directly (not behind a
> visual diff tool) I noticed that the marker line >>>>>>>> COMMIT
> DESCR: FILENAME indicates a different file name then the current
> conflicted file.
> That reminded me that those two files A & B, were actually copies
> (real copy, not symlink) of other two files inside the same repo.
> Is it somehow possible that auto-detected-renaming is involved in this
> (since the files are identical but in two different locations) ?
> Trying to give you some hints, maybe it is totally unrelated...

I meant to ask if anything had been copied or renamed but forgot. The 
merge backend detects copies and renames and handles them correctly but 
the apply backend does not so I think this is the source of the discrepancy.

Best Wishes

Phillip

> About the blob check you suggested, please be patient but I didn't
> understand exactly how to proceed.
> 
> Thanks again for your support,
> Marco
> 
> 
> 
> On Sun, Jun 20, 2021 at 8:02 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Marco
>>
>> On 18/06/2021 16:21, Marco Giuliano wrote:
>>> Hi All
>>>
>>> I'm facing a strange anomaly during rebase.
>>> I'll try to explain what happens because unfortunately I cannot share
>>> more information since it's confidential and unfortunately an
>>> anonymized export does not reproduce the issue.
>>>
>>> I have the following repository status:
>>>
>>>      * commit 2 (BRANCH X)
>>>      |
>>>      |  * commit 4 (BRANCH Y) (HEAD)
>>>      |  |
>>>      |  * commit 3
>>>      | /
>>>      |/
>>>      * commit 1
>>>      |
>>>      |
>>>    (...)
>>>
>>> What I'm trying to do is rebasing branch Y on branch X, with the command:
>>> git rebase X
>>>
>>> The anomaly is that, among other expected conflicts, also two files
>>> (fileA, fileB) appear modified in both branches, but those two files
>>> have not been modified in any of the 4 commits you see in the graph
>>> above!
>>> The anomaly appears only with the config setting rebase.backend=apply,
>>> while not with rebase.backend=merge (*).
>>>
>>> This might not be caused by rebase command itself, but rather by some
>>> previous operations which might have accidentally "broken" something
>>> and that the rebase simply makes them appear.
>>> You need to know that commit 4 is the result of several squash and
>>> reordering of multiple commits; is it possible that some of those
>>> operations have created some "leftovers" ?
>>>
>>> I know this is difficult without seeing the actual repository, but
>>> could you just give me some advice or point me to the place where I
>>> can investigate ?
>>
>> That certainly sounds quite strange. I think the patches used by the
>> apply backend are stored in .git/rebased-patches, it might be worth
>> looking at that file when the rebase stops for you to resolve the
>> conflict resolution to see if that sheds any light on which commits the
>> conflicts are coming from. Failing that does the content of the
>> conflicts provide any clues as to which commits they are coming from?
>> You could also try matching the blob id's from the index line of `diff
>> --cc` to the index lines in `git log -p` to try and find where they are
>> coming from.
>>
>> Rebase ought to just replay the commits so in theory it shouldn't matter
>> that you've been squashing and rearranging commits. What does `git log
>> -p branch-x...branch-y fileA fileB` show? (it shouldn't show anything if
>> those files are not touched by any of the commits)
>>
>> Best Wishes
>>
>> Phillip
>>
>>> (*)
>>> When the anomaly first appeared, I was using git for windows, version
>>> < 2.26.0 (unfortunately I cannot recover the exact number); I decided
>>> to upgrade git to 2.31.1 and the anomaly disappeared. Investigating
>>> the release notes, I noticed that rebase.backend default value changed
>>> from apply to rebase from version 2.26.0.
>>> I also copied the repository on linux (with git 2.31.0), and the
>>> behavior is the same.
>>>
>>> Thanks in advance for any help,
>>> Best Regards,
>>> Marco
>>>
>>
