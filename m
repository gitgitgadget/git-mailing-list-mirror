Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F0AE8181D
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 05:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjIZFkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 01:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjIZFkR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 01:40:17 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAB8D7
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 22:40:10 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5849bcbf26bso1245264a12.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 22:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695706810; x=1696311610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JDgFB5THQVkd93AdvJ9UN5uZVdn8XASTTsVEpFr5kq8=;
        b=OS0S1N9+vmZWm89epMTDgPg+RvxzJMQmRJrZeQszx0WLUlc+/rxKRCar16v7k0IVHm
         Of5wHqj0nxlP/a1DccYIwteyPrSdFMWs7oT+WSgA2E5CNOiGS+k3j9PNchbf0p6JMrd4
         M4xwKZ7sxa2efUJVT1cVkgb4WKXO0s8wwRON3Vgli80ZkqPTRrN7IDkpDcZqfEjfVtOw
         oSQ3Tw44/ejIFiU+m+KTJEg/fNeGY9pJgazqZT3GVUIyu0Ix/nvZnSqEgYbeX3yg8cXI
         a8gmKCRpVD2mtGux4cHfuGMvR4EWpu6VHL/exKmJXQNLYCBlFo2PxNb0v4mXAm/pybEE
         LCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695706810; x=1696311610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDgFB5THQVkd93AdvJ9UN5uZVdn8XASTTsVEpFr5kq8=;
        b=QN9ExUXmOY+4zFlxwtIuWZujn8U50tJ/73w+UXSTE1A1oFl30V7N0GowWW6hUDLAJv
         L9gCImXeDJ6ZU6r/7vpprunAmD6da62GM1wSukdghxgsJ0onWmRuy1I6WPJJebPMm7+/
         cy8ZyypU6tXm7unobj4bkEgwnvNFKsJVm7ZlV7lM0UyxqCjdvKuy9enMkyVX2ai8XIY5
         UHI+F0cbzHynraghZcj8sxc1ilUESg0CqnnDf3Fr3Hn+MT6t2Soah2MuXmkZ4hoWbxGz
         7dxkJCBJ6p+Y/tofnwSldq+j1H15Yq2zMxzKsa1uhU2ARVTHeNadGlvm8v2T8ZsoKSBy
         T9YQ==
X-Gm-Message-State: AOJu0Yz4xcs0RprJMG4xtLZlJkQqHj/HuBP/dQWaUDXsb0FQhnH89qFr
        nMKcnm5fVA5LCoaStEfwVkLf6Oo4UPo=
X-Google-Smtp-Source: AGHT+IGYxXHYSZy2T6MyZZzrsyE276enBuOgEAOmQeEs4DvdSuWRS3HqxWtpLNDoOQYovuH9Uvulk4SCT7E=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a02:a0a:b0:577:4619:a0a0 with SMTP id
 cm10-20020a056a020a0a00b005774619a0a0mr20874pgb.6.1695706810100; Mon, 25 Sep
 2023 22:40:10 -0700 (PDT)
Date:   Mon, 25 Sep 2023 22:40:08 -0700
In-Reply-To: <xmqqo7htww7k.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
 <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com> <xmqq8r8xyge6.fsf@gitster.g>
 <owlyzg1dsswr.fsf@fine.c.googlers.com> <xmqqo7htww7k.fsf@gitster.g>
Message-ID: <owlyttrhsdaf.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 0/9] Trailer readability cleanups
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Glen Choo <glencbz@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>>> I could revert and discard [4-6/6] of the previous iteration out of
>>> 'next' and have only the first three (which I thought have been
>>> adequately reviewed without remaining issues) graduate to 'master',
>>> if it makes it easier to fix this update on top, but I'd rather not
>>> to encourage people to form a habit of reverting changes out of
>>> 'next'.
>>>
>>> Thanks.
>>
>> I totally agree that reverting changes out of next is undesirable. I
>> will do a reroll on top of 'next' with only those incremental (new)
>> patches.
>
> OK, so the first 3 patches are now in 'master', and the remainder of
> the previous series have been discarded.
>
> Thanks.

Oh, that simplifies things. I will re-roll on top of 'master' as the
starting point for the other remaining patches instead of using 'next'
as I suggested earlier.
