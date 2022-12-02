Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D707CC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 01:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiLBBsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 20:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiLBBsE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 20:48:04 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1664C89AC3
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 17:48:04 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g10so3332347plo.11
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 17:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTH5HQwdEJPgvIT0fpBXRh0z3Mpk8r2nHmip060XAjY=;
        b=ogR9UbUt53Xl+Fu54kh02FzmsMh6j4dO3KRAMQI/0JoSQEgqZZ5i/pTvBlUK5Tt05h
         UU86oz6VAlFkh+jteUCD4fmDylfzCLDuJGnlFhwjZHUttlrZZ8kTKG5Ai8DLPRhbkYGT
         kgvk4QPDxKcgpx2fwPuHD18ksiYi/PSUJLYHhdSwyspOsnov3C6uy3V+G51tkjPJvHTs
         Iwh7W0/AdMqwkviqTeOugFxoAHyG9jJ0RD4e407tb8Pz0/lwikyM4Ne+bYul4zhRVc2Z
         14kC5jQzazZAUCZ2jV3y33JTNZgfTrUck+28uMQVeyQC8WO6Me6MWuZR/VPh7ZsYJg+3
         C7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UTH5HQwdEJPgvIT0fpBXRh0z3Mpk8r2nHmip060XAjY=;
        b=nkho5Gp/a9wN+ZrNFC12gWNs3YFu66bXM4dy1s20GcRhJRJLr3gphV+mzU0UZTB+hY
         4GeFo5YuxWUzSCIVFg19U16VlGFypIFXNM+30OLuOhbFJGF56pChVtLCQaHzqDLCw0ZQ
         uast/l+13ipeYiCx5bu2sfbvnT3Ur8gtfCL4KTxac3kpFxE0wlDHo0OWRHin5VDnE3Fx
         qGh/QevK7hIlKCxDVWO2f8kNeRQzw7cRC9VTo/1nkUXsbq+pC1V8aJ1yCH8Z5C9S9wf7
         BBshLK5mLK23ooRyQe/AjKGEPTw9+TkXOCjDqT7BfqTOgQtHVxdQZdBiFdWo5U+h2xhf
         dcZQ==
X-Gm-Message-State: ANoB5pmGHuzqxPZjVrmr4975eehMitzxgJP8sd2/nf5haS+E1HCXyxme
        OJ9+a3Sli/KGV88Z4QDdF9Y=
X-Google-Smtp-Source: AA0mqf6EpCaFSIk2NXKidVwSPdSnpNbNLb9pBJtmW0ddQLqwe7KTsWu3zB7/4c4JUMUIjWEdyuayDQ==
X-Received: by 2002:a17:902:ea06:b0:186:abaf:8fe with SMTP id s6-20020a170902ea0600b00186abaf08femr63569813plg.95.1669945683515;
        Thu, 01 Dec 2022 17:48:03 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q21-20020aa79835000000b00575b6f8b84esm3877674pfl.26.2022.12.01.17.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 17:48:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 1/8] log tests: don't use "exit 1" outside a sub-shell
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
        <patch-v2-1.8-7c9f8d2830f-20221202T000227Z-avarab@gmail.com>
        <CAPig+cQK8BRU0u0g+jAkyJaqSamYBynJ6s00_6H2beb6gXaRDA@mail.gmail.com>
Date:   Fri, 02 Dec 2022 10:48:02 +0900
In-Reply-To: <CAPig+cQK8BRU0u0g+jAkyJaqSamYBynJ6s00_6H2beb6gXaRDA@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 1 Dec 2022 20:02:14 -0500")
Message-ID: <xmqqwn7apodp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>>                 git show -s --pretty=oneline "$r" >raw &&
>> -               cat raw | lf_to_nul || exit 1
>> +               cat raw | lf_to_nul || return 1
>>         done >expect &&
>
> Using `return 1` here is "obviously correct" since this code is not
> inside a subshell. Furthermore, the exit code of the for-loop itself
> is not being lost down a pipe, so `return 1` is indeed an appropriate
> way to signal failure. Good.

"return 1" is obvious and safe correction.  I have to wonder if
test_expect_success can be taught to be smarter to intercept "exit"
so we do not have to bo so careful, but that would be a much more
involved change to the lower-level of test framework.

