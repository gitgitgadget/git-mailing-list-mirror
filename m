Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AEFEB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 13:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjGUNNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjGUNNO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 09:13:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9EF10CE
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 06:13:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so16179275e9.3
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689945190; x=1690549990;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nGEkiyEQssx7gQm/YNZRFERROElZMDG3SOggsO7SghM=;
        b=Koqk/DZmmMO2MDZ0Mz0+Afj3AKIYZbndO6X5mzUJSi6Ka9Zxk1x5cjTh4A8LNLlrxZ
         s1mQSrRoTEKYUpjHlaWJOFxeqBL/FqlADf5GfNTBZAi4ZKGD+HDb1ZAZl8FoZb5rWETa
         yKVZnAXn1CVVfGUiOr+76MVJz1lF1knEEjL0qh/p1bj6VTIyxX08MLvniasG2RXy9LnP
         0+GEuYhOlAWwFQGZQnlQH+Ccz9Xu6NKrmziLMlgYxJg2LZgIDPIHnQIVQAEV63sFDCr/
         b+4oLW+t4uKuWslvbSEOwrqD4ngL9A0ksNg+ivGTSRb7IAlVSTqo4g9wz9Urnpe9TeXP
         CrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689945190; x=1690549990;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGEkiyEQssx7gQm/YNZRFERROElZMDG3SOggsO7SghM=;
        b=lZM6bJwMXPTBKhpnJalHvpTnXgnaF0a+1E4jaUA9pRLAyGGosCdsQfu9X/KHsmvSOI
         ZIcYUG2DOVdYQiIJLkCyj/5Dh1GzcK7tYqcX2NPdh/MDHTIEjqwpc/CXA2eiYJZuyWqy
         dkns0bCG/mFWPGmO8aPga2weqqEHxakx27EQd3QhUba7kiTXPxX6WVBwBHN33seTjuuP
         ogUlMWiVMKGTdKjnlbgHhlCMR1yLrwW9y9Jnjt3x9hfqi6fOPrSSlh7mMLu1VnF1cr7W
         979Tt6+lMVs+DWmz2qpPOHsxmPoQ1Wn0F3Ri9x3m0Uxa+wnoLhR6ZusMIqJlfjl+UqYi
         RJ9g==
X-Gm-Message-State: ABy/qLZiLrpFK1kiJpMwvR3jIGAaGde1IVeSdq0CSpRGtfsj7jHbKmX2
        81N3gTgaT+lo5gK0BcsQJ/0=
X-Google-Smtp-Source: APBJJlG0TqSImX5F//sVuikCprTj29BLqJYTRkF206v9FtKa9KxlcfIoQc19V8cWtRni4+JSPehL2g==
X-Received: by 2002:a1c:770b:0:b0:3f9:b30f:a013 with SMTP id t11-20020a1c770b000000b003f9b30fa013mr1399771wmi.6.1689945190407;
        Fri, 21 Jul 2023 06:13:10 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id t10-20020a1c770a000000b003faef96ee78sm6192126wmi.33.2023.07.21.06.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 06:13:10 -0700 (PDT)
Message-ID: <8e38a723-9fda-2d76-c767-7b76cb428a73@gmail.com>
Date:   Fri, 21 Jul 2023 14:13:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/1] sequencer: finish parsing the todo list despite an
 invalid first line
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        alban.gruin@gmail.com, gitster@pobox.com,
        phillip.wood@dunelm.org.uk
References: <20230721055841.28146-1-alexhenrie24@gmail.com>
 <20230721060848.35641-1-alexhenrie24@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230721060848.35641-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/07/2023 07:07, Alex Henrie wrote:
> Changes from v3:
> - Rebase onto HEAD~4 instead of --root (which was the original motivation
>    for sending a new patch and I forgot to include that change; I probably
>    shouldn't be doing Git development late at night...)

Please don't feel that you have to re-roll straight away when someone 
reviews your patch - it's fine to wait a while if you're busy. Also if 
you disagree with some of the reviewer's comments it can be helpful to 
wait for them to respond before sending a new version in order to try 
and reach a consensus about the best way forward.

Best Wishes

Phillip

> Alex Henrie (1):
>    sequencer: finish parsing the todo list despite an invalid first line
> 
>   sequencer.c                   |  2 +-
>   t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 
> Range-diff against v3:
> 1:  b1af2df3f5 ! 1:  f6fcdcd9a9 sequencer: finish parsing the todo list despite an invalid first line
>      @@ t/t3404-rebase-interactive.sh: test_expect_success 'static check of bad command'
>       +	rebase_setup_and_clean fixup-first &&
>       +	(
>       +		set_fake_editor &&
>      -+		test_must_fail env FAKE_LINES="fixup 1 2 3 4 5" \
>      -+			       git rebase -i --root 2>actual &&
>      ++		test_must_fail env FAKE_LINES="fixup 1 2 3 4" \
>      ++			       git rebase -i HEAD~4 2>actual &&
>       +		grep "cannot .fixup. without a previous commit" actual &&
>       +		grep "You can fix this with .git rebase --edit-todo.." actual &&
>       +		grep -v "^#" .git/rebase-merge/git-rebase-todo >orig &&

