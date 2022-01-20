Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6413EC433FE
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 23:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378149AbiATXQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 18:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244059AbiATXQg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 18:16:36 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FAFC061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 15:16:36 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p17-20020a170903249100b0014af06caa65so1198708plw.6
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 15:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J8/wssmlTqzxODwBvchmcx+cQCAqWD0ChstZGY7gans=;
        b=DYLKJGDhjrlFpaV1Nx3C1J5LCD0RuKvGqvbXFEVd724wYkfGumF8gOgNMgRp5IEoVt
         cN8iqjYibMaO0hbWMzlvqoxjXHgfXalp0lzqbcG9drmSlAQD8YuH30CLmjBGYMzvZ+cr
         s2LwIO+rCrslVPnkg05L3Nm7G17+XoRX2Eetcrj0/yaMkncoGDkPY77enizLvhiqkkBc
         DRW9J09XtX9j2VSlR52kmHheuoToDl46PJpL8yvGcbBv95fbrGByUDoi6UW9Nnb2ca8w
         VkHpe5rhYIviT+QbiRrnbU76jGicXNtSVudoWr+y2QgGrRliEAQzkLqaqw8BkQhTuM4M
         2jmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J8/wssmlTqzxODwBvchmcx+cQCAqWD0ChstZGY7gans=;
        b=1K1EMs88PJKhFzf0VH1nnn0kJe/c9bXwoqgauc3AhFzg/0zC4ATE49BOosc36TwxGT
         TaR2VCksBvQR/gru6gFToZVFuQptkJkVdAW9VzVqTJGfSG4IP4sccxGxHx/YJzIwlby7
         Imfum1h/ZfSQhnw4mJnWXMMx4nyHuUJO+yuwK+zrFfiMl91zWdbbw5okh+V/kXab4PDM
         FPq/8e8vIRwKsGdPZmnJ5PiavuCK7wIgvQ2tnYG2jJPFPBL3RUwHNaKwGNTgf75YcLkK
         Y5uSs+yPAKUhDksHYjwnIXyjogxOHNhoFD6f03SwEkwTERGJxiuZd1ywGVH2CBJFEhgy
         1hPQ==
X-Gm-Message-State: AOAM533Fo7LFZa1OyUyuoye1L2ScWtCAmOFbkpc2f6thjh+buO8nMuR5
        Lorxx4t4PFzfa6cOUblcdzmy/GcHeOL5cA==
X-Google-Smtp-Source: ABdhPJwndXpd+ZIJBQmrodN9f1sEG15cKEy/U6KHYvdSx6tHDJDVs9ZUs0jv9KHcHuOrvqlgIazULVOcyCe/eg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:e008:: with SMTP id
 e8mr839126pgh.506.1642720595641; Thu, 20 Jan 2022 15:16:35 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:16:33 -0800
In-Reply-To: <xmqqy23af1ka.fsf@gitster.g>
Message-Id: <kl6lbl06xajy.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220119000056.58503-1-chooglen@google.com> <20220120174942.94231-1-chooglen@google.com>
 <20220120174942.94231-4-chooglen@google.com> <xmqqy23af1ka.fsf@gitster.g>
Subject: Re: [PATCH v7 3/3] fetch --negotiate-only: do not update submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
>> index 710f33e2aa..1b9023d3f0 100755
>> --- a/t/t5702-protocol-v2.sh
>> +++ b/t/t5702-protocol-v2.sh
>> @@ -628,6 +628,18 @@ test_expect_success 'usage: --negotiate-only without --negotiation-tip' '
>>  	test_cmp err.expect err.actual
>>  '
>>  
>> +test_expect_success 'usage: --negotiate-only with --recurse-submodules' '
>> +	cat >err.expect <<-\EOF &&
>> +	fatal: --negotiate-only and --recurse-submodules cannot be used together
>
> This also needs to be updated to match.  I've fixed up locally.

Ah, my mistake. Thanks for the catch :)
