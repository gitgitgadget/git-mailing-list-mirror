Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5D5C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 21:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0FBE61100
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 21:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhKBVcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 17:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhKBVcG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 17:32:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDCAC061203
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 14:29:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u1so500841wru.13
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 14:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a0Db/vP0SG11o6YYkcL96ktadjGfSNY8MoxxPvwcVlg=;
        b=PeQEsxf+BHUJf+1y/9exQZIc3hDEalb4tJI5l4094Sv1oZH01MEKqY3wLYlWZUEF+I
         Co+9Ctn5vKeiPB7nSjS0S+BfEICCSIZAdzmMnbMwm1hxnOlhrDc+vIWg22OBIHD44R85
         JEaUoTpdhJhgRNZY+GXv6QPjulpPY8ePtFZKTBhHO5DwINC8IwvbssiK9L9OWnLvCfs8
         ZTl59M2ocRA1968hDx+K2yk7Zzx3vFb9FPmK891Ctpekr5BsrPOcjmdy1yAhKGfX9DMw
         NvyyxdwxZU5y69s/Qo6EgKHRMoI5zwUw3RnGW2aQQk659JqgRWMMoIvQ1dJpC27OT3/X
         ETFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a0Db/vP0SG11o6YYkcL96ktadjGfSNY8MoxxPvwcVlg=;
        b=hj0fT42NF/KJXUwKBFiCDcXIX9J+UmS3Uh5aPYJu9Ma6U2xuYSwaoWdo1tR6LopErX
         L5KZ6u+650B3p8h9JqOJ0OJzqP819xcZ5Wu7KRthsg282kDm2GKF4qfpbKWTp/SYRxjs
         bqty+Psw+ml08fhKB2QtBhKV3CQVfulAuqHKvTL1R4tK73Ov1dvxQjKpR9j7r2hIpUBI
         fsMsbLqdwsho8RNbbk3QexRaiEp2zy4sLban1mUA0F1RrwDWnawOw3IOLo4LEtPNLeTS
         nUmKZ6D0LQl5hcoRcBMhv4iZfjZtpbU5BpNY7aaarPS5Sl0/c/9GUefSix4T99DL5pUM
         nN3w==
X-Gm-Message-State: AOAM531FjykthozF5+kQX/YpFJM/VTa+UQpaNAtw4unlXI20UOIz7mWC
        1TuTlhPp2/6BT2Xv67cGKJk=
X-Google-Smtp-Source: ABdhPJy593Jsmsmg5Bc5LNBahrOyWKuz4gGbKMg7PJfVAapKdsP/hfPZsvuv8IUHJl0iwbu6RHvHjw==
X-Received: by 2002:a5d:6707:: with SMTP id o7mr35544308wru.172.1635888569637;
        Tue, 02 Nov 2021 14:29:29 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id f15sm176340wmg.30.2021.11.02.14.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 14:29:28 -0700 (PDT)
Message-ID: <349c1832-41b2-863d-254c-777e1915fea8@gmail.com>
Date:   Tue, 2 Nov 2021 21:29:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: fix rewording with
 --committer-date-is-author-date
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1123.git.git.1635883844710.gitgitgadget@gmail.com>
 <CAPig+cSWDJ-zMv4zgU4oWcqXmaaCiH+03wSzQg2O=YRHthf55A@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPig+cSWDJ-zMv4zgU4oWcqXmaaCiH+03wSzQg2O=YRHthf55A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

On 02/11/2021 21:05, Eric Sunshine wrote:
> On Tue, Nov 2, 2021 at 4:10 PM Phillip Wood via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> baf8ec8d3a (rebase -r: don't write .git/MERGE_MSG when
>> fast-forwarding, 2021-08-20) stopped reading the author script in
>> run_git_commit() when rewording a commit. This is normally safe
>> because "git commit --amend" preserves the authorship. However if the
>> user passes "--committer-date-is-author-date" then we need to read the
>> author date from the author script when rewording. Fix this regression
>> by tightening the check for when it is safe to skip reading the author
>> script.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Should this have a:
> 
>      Reported-by: Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>

Yes it should and does locally but I forgot to push the updated version.

Thanks

Phillip

> ?
> 

