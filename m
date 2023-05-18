Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E880AC7EE22
	for <git@archiver.kernel.org>; Thu, 18 May 2023 10:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjERKFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 06:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjERKFA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 06:05:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F28E54
        for <git@vger.kernel.org>; Thu, 18 May 2023 03:04:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f4449fa085so11546455e9.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 03:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684404297; x=1686996297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nauw1DfQIZLBYOUnvQlAyUOQAvMYjOb01eZIHnGUOqo=;
        b=rqItTMQlDGuNXbFMYQIR03pH01jkzR1eIyf4a0wSZR+ubift90Io7hu1/j2ZHXi/d6
         Jk8aiiQsb+SGB+jNFUVo/7hQXBIayjdbVnAUgET0W/V7mk3zdaWWL144zcvktlfEb+QV
         V80EhMCUwvXx8eSUZOEUzpTgj3PU6BrYxNeK+oLebUByHoudBMzgE14yuV4Y9k+jCjA4
         CRxcX7tOG6nec0bvzW2JyJf0qRQpiwFraF90ZL/wT3w/rvONUqQdbeazGbXHIhbd6sdn
         6lqNRgkUg5MI6/BUMinwYuVqZjSUoDPCMb6H8jrE5+DncVZb3sA1p5KphKKguyng40AV
         Bq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684404297; x=1686996297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nauw1DfQIZLBYOUnvQlAyUOQAvMYjOb01eZIHnGUOqo=;
        b=AtMGCesziEnKcn3CQxsviivxLFg7bln1W7VqGtz5MclI3PMEJM7JkV2u+NplbLBWMa
         I/PKRjk84zaymtkIxH1p/vI/is432IJkkZJlbd8HGiigXuw7GJ76E8ZDjluNYdeJFksH
         g3IfZ2TElTLJMcVmnGoIGGD69g/QvLE0HIoQHYqqIeXihh3sKr2NuLz5D/ZDuzVuuZ3Y
         kcz9kVsuiHUaIZL884l2ocCr8KK/8YvwVvqVdxMkAfhnnFUPiZsUZHvltWFlEGShzu+r
         hIsuGIfrZEBwI33HQnBchGmFmP02g8eGsJUvqUA2B8lOhBM4rKqGN94M35DGd1LgqFjF
         MVOQ==
X-Gm-Message-State: AC+VfDySNIGjYX08FsVbR5igyPHd3+jTkOjT5o1qtjL8jjBt9XkrGE01
        h97Q0HHwzQYggOFJdyv+ZYB4BxeG824=
X-Google-Smtp-Source: ACHHUZ4QG5yI8QDHzFInEghlHTvqQop6wqLtsNpHUm5UJzPCZE76RDdB//uijZcPB1NbxmA8bhctxw==
X-Received: by 2002:a05:600c:248:b0:3f4:2973:b8d0 with SMTP id 8-20020a05600c024800b003f42973b8d0mr1128327wmj.2.1684404297268;
        Thu, 18 May 2023 03:04:57 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id t25-20020a1c7719000000b003f42d8dd7ffsm1509598wmi.19.2023.05.18.03.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 03:04:56 -0700 (PDT)
Message-ID: <339c7b51-43de-2d48-d9d2-a2ffeb917e8a@gmail.com>
Date:   Thu, 18 May 2023 11:04:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 1/2] Add C TAP harness
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>, Calvin Wan <calvinwan@google.com>,
        phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>
References: <20230427175007.902278-1-calvinwan@google.com>
 <20230427175007.902278-2-calvinwan@google.com>
 <afd3e80f-99d9-7472-36e7-335f86263d09@gmail.com>
 <CAFySSZCQfeGnrMPKHwsrT+UvaH_+t=nGhUPUtdVuijOmrrWejA@mail.gmail.com>
 <c902a166-98ce-afba-93f2-ea6027557176@gmail.com>
 <kl6lpm76zcg7.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <kl6lpm76zcg7.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05/2023 00:16, Glen Choo wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> It would be possible, but I'd want to see some macros for checking
>> invariants that print the source location as well as their
>> arguments. I'd be interested to hear what you think of the alternative
>> approach in the patch below.
> 
> I personally (not representing the Google folks as a whole) find the
> option of implementing our own C TAP suite quite appealing. As your
> patch shows, we can get pretty far even with a rudimentary initial
> version, and I don't see why we couldn't refine it as we go along.
> 
> I'm concerned about the overhead of relying on a third party library
> that implements something moderately complex and isn't widely used,
> It's much easier to patch and read code that we maintain ourselves, e.g.
> if we need to fix bugs/add features/understand its behavior. These risks
> are quite real, especially when it's not clear what kind of support we
> can rely on from C TAP Harness's side.

Yes I think for something like this the advantages of having our own 
implementation that implements exactly what we want and runs on all the 
platforms we support outweigh the effort of writing the implementation. 
As there is already talk of having to customize c-tap-harness it is not 
clear there is even much effort saved going that route.

Best Wishes

Phillip
