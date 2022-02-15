Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFD8C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 14:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239243AbiBOOyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 09:54:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbiBOOyH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 09:54:07 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0CA90FE5
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 06:53:43 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so23552405oov.3
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 06:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RW3h0V0waApFtQr4Y2E8Pc7Ksh7QcF6woObKbhJK1KM=;
        b=RP/gV9gpWNqYhyMKwiyHLcqTl3ZxgQlMIiEewPqN7fsDI7L0pJDNA8Px8BpOC+9fqk
         FKE9l58GNO3gD2jIKcPtmjfW8k2GcktHqr9dYMgOcjehREPp+sAA62slMS8mkcezKXLv
         +L1McFqLIQLzd/QP8Gpoe4A7aim3CXLBye2McnVd0KSVx/4ejNxV3SU/nj0rvT2J5Gfw
         teaZjFzxK2yUhgizMK8vl+OpB76IeN8XwreOOw+Zcob4C+2pPzNI+BQWv/6hiQDqOl2b
         3ITyYCs8QJws34IyrrTSzHLCt8AWEWvRNTGcJZDUVdpQEijynGO/PX3e8WSeCUsNxP4c
         dbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RW3h0V0waApFtQr4Y2E8Pc7Ksh7QcF6woObKbhJK1KM=;
        b=rXwHm8BCDZuoKmoisbii2Sao7wQUNRkGPbGKakLx+107srLAoCRzIBfW8ggVyrdwiR
         dg8bFr8TwbyF0z4azWoleAiSV7UyzuXK+goQssb4W+9fe+2DXhOJPBxnGoEhwQOBTY3+
         jAG+XDIIrU55qa4f5PvvylBgyTw3ES4Wj2Qj4qBd1YLBSfpmUUbisk+9kvraJFcm0ltn
         V/o1OO7CcZW1kFrnM5wee98kovf03ZXb1Kq8Od2MlD8uLvoxhtJsU36LkPvLH8dGejYK
         egVitopzXcLGEh9kkAj0FxAJ1Uvljxr/Jf9OOKUjqlTRmiPycDmpBgla62HuLNE7iDyS
         YLUA==
X-Gm-Message-State: AOAM5335P0osnFZhkuqCF4MIF2f9gPuDcNG+T0iGwzuxHeo8x+PN3prh
        5W5v31sgRMslCyM+WBVQ9sTI
X-Google-Smtp-Source: ABdhPJyhFaAMb9vCaKNTukZ921ewkgF33fTeshbSIvmz0rZv18GWl8WJV3+QJhDrbj8DFt2kYFUuHA==
X-Received: by 2002:a05:6870:772e:b0:d2:8c2a:7c75 with SMTP id dw46-20020a056870772e00b000d28c2a7c75mr1448497oab.202.1644936822497;
        Tue, 15 Feb 2022 06:53:42 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v31sm14085460ott.25.2022.02.15.06.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 06:53:42 -0800 (PST)
Message-ID: <d0e7c17b-b293-623e-b0cb-ddc6980886ca@github.com>
Date:   Tue, 15 Feb 2022 09:53:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 3/7] sparse-checkout: pay attention to prefix for {set,
 add}
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <679f869ff11b5c3e61081018f7eafa81c334f3d1.1644712798.git.gitgitgadget@gmail.com>
 <b97d569c-3b5a-a2c8-cdf5-08d74406a29e@github.com>
 <CABPp-BHXZ-XLxY0a3wCATfdq=6-EjW62RzbxKAoFPeXfJswD2w@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BHXZ-XLxY0a3wCATfdq=6-EjW62RzbxKAoFPeXfJswD2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/14/2022 10:52 PM, Elijah Newren wrote:
> On Mon, Feb 14, 2022 at 7:50 AM Derrick Stolee <derrickstolee@github.com> wrote:
>>
>> On 2/12/2022 7:39 PM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> In cone mode, non-option arguments to set & add are clearly paths, and
>>> as such, we should pay attention to prefix.
>>>
>>> In non-cone mode, it is not clear that folks intend to provide paths
>>> since the inputs are gitignore-style patterns.  Paying attention to
>>> prefix would prevent folks from doing things like
>>>    git sparse-checkout add /.gitattributes
>>>    git sparse-checkout add '/toplevel-dir/*'
>>> In fact, the former will result in
>>>    fatal: '/.gitattributes' is outside repository...
>>> while the later will result in
>>>    fatal: Invalid path '/toplevel-dir': No such file or directory
>>> despite the fact that both are valid gitignore-style patterns that would
>>> select real files if added to the sparse-checkout file.  However, these
>>> commands can be run successfully from the toplevel directory, and many
>>> gitignore-style patterns ARE paths, and bash completion seems to be
>>> suggesting directories and files, so perhaps for consistency we pay
>>> attention to the prefix?  It's not clear what is okay here, but maybe
>>> that's yet another reason to deprecate non-cone mode as we will do later
>>> in this series.
>>>
>>> For now, incorporate prefix into the positional arguments for either
>>> cone or non-cone mode.  For additional discussion of this issue, see
>>> https://lore.kernel.org/git/29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com/
>>
>> Perhaps this was covered in the issue, but for non-cone mode, it
>> matters if there is a leading slash or not in the pattern. Will
>> this change make it impossible for a user to input that distinction?
>>
>> Will there still be a difference between:
>>
>>         git sparse-checkout set --no-cone /.vs/
>>
>> and
>>
>>         git sparse-checkout set --no-cone .vs/
>>
>> ?
> 
> If you are in the toplevel directory, you can run either of these and
> they have the same meaning they traditionally had.
> 
> Before this patch, if you are in a subdirectory, the first of those
> would have specified a toplevel ".vs" directory, and the second would
> have specified a ".vs/" directory in the toplevel OR any subdirectory.
> Those choices might be what the user wanted, or both of those could be
> a nasty surprise for the user.
> 
> After this patch, if you are in a subdirectory, the first of those
> throw an error:
>     $ git sparse-checkout set --no-cone /.vs/
>     fatal: Invalid path '/.vs': No such file or directory
> (which might be an annoyance, but how would you possibly specify a
> leading slash on a path that needs to be prefixed anyway?)  The second
> will specify a SUBDIR/.vs/ from the toplevel directory (which again,
> might be what the user wanted, or might be a nasty surprise if they
> were trying to specify a pattern relative to the root).
> 
> Does this change make sense?  For some users, sure -- especially those
> with the idea that you specify paths for non-cone mode (though
> bash-completion may guide folks to presume that).  But for those who
> understand that non-cone mode is all about patterns and that we have a
> single toplevel file where everything must be recorded, it's possibly
> detrimental to them.  To me, I wonder if it seems fraught with nasty
> surprises for us to do anything other than throw an error when
> --no-cone is specified and we are in a subdirectory.  Perhaps I should
> do that instead of this change here.

I'd be in favor of this second approach of requiring the base directory.

>>> Helped-by: Junio Hamano <gitster@pobox.com>
>>> Signed-off-by: Elijah Newren <newren@gmail.com>
>>
>> This could probably use a
>>
>>   Reported-by: Lessley Dennington <lessleydennington@gmail.com>
> 
> It'd be more of a "Report-Formalized-by:" if we were to include such a
> tag.  Check the history here:
> https://lore.kernel.org/git/52d638fc-e7e7-1b0a-482b-cff7c9500b92@gmail.com/
> 
> In short: I was the original reporter; I noted the issue while
> reviewing her completion series.  The bug was not related to her
> series, but her series did prompt me to check and discover the issue.
> She didn't want the issue to get lost, and decided to make a formal
> report.

That makes sense. I wasn't caught up with that conversation.

>> These tests could use a non-cone-mode version to demonstrate the behavior
>> in that mode.
> 
> Fair enough, though I hesitated in part because I wasn't sure we even
> wanted to make that change, and I figured getting that answer might be
> useful before writing the tests.

Understandable.

Thanks,
-Stolee
