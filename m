Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C90C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 15:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjDCPt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 11:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjDCPtu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 11:49:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C9C30EB
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 08:49:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso33055776pjb.0
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 08:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680536959;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBeCe2MEqi3yGB3vkNVljihTAYUf0y+Tvxk6r2U6NzY=;
        b=o/mP5rs0CE4ITyyKRBdKPLChrfFom5ahGhqE7j/1fkAQX527VJHcR2n/sahwcv7eBz
         1PZ1hDGcsvLvvNNw1EssyvqY3PS0uP5NH9W1m5Uh4e68bgYFbRjK4c8doYEYIW3S45P5
         9baMdKos5Z0dP0rSXcAJIxpLhO3BGbR6N8kTtEjoZf/OkojEh4kbhX2+RixK31Exi7Q2
         By3N0ebTlgCH4ctea5fCNKbQF4K8UrNv1WPRSJ1z0WB61Ym4J8MNHIf/dd/D1g003jiZ
         Nbzkr4xQeNMdsFST2j3ku/n2+sRhrrFYOUOVjRQouLbHbJ2Yrwt11qt9aXN9KEb25yQg
         +UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680536959;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oBeCe2MEqi3yGB3vkNVljihTAYUf0y+Tvxk6r2U6NzY=;
        b=P8gZpowbni+akEdyd0w6gi+l3Wwq/GH6PNbOQ7l0dGWNRQGFId0aWanNuy4jL/d5cV
         tYtmJTw3qvMshlA14j+G2OjJx5ustcsK2e9vU4pl3VrWQUn17GGsD12PRUqYXbb8wSV9
         2x/X1F3iiGhM38ljRrwnwdEOSZyYQeTWfJ+hFNgz6RaVKXWyTjmfr58Wx5CGk2Xl0cWJ
         kYEUXAZCuBc6DUOK7JAZnqFoxlPesF+IlXm1zorRCkgZJ/BGQL7umhh0fjqEsy62nrAY
         P/wu0V88MV/Qa8mrrJeozshYf7Grt5prnN6rjiqv+KSFmsInfqod61HwqujHqWErRgS2
         Z2ew==
X-Gm-Message-State: AAQBX9dmveoxGlNqD+/fSDsJMOKTDMubAceQlxUdL8d98UHVOXWhQSW9
        RI/ez0U0Gp6xoNHkrp8JpQo=
X-Google-Smtp-Source: AKy350ZVebkzN2XEPq4w/dleoR0QLM0XvmDr4qddO75o3NNRZUosQp91n0Jv+DEmLY05HiXiwK+ooQ==
X-Received: by 2002:a17:902:d503:b0:1a1:b8ff:5552 with SMTP id b3-20020a170902d50300b001a1b8ff5552mr46714128plg.6.1680536959145;
        Mon, 03 Apr 2023 08:49:19 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902989000b001a279237e73sm6775630plp.152.2023.04.03.08.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 08:49:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2023, #06; Wed, 29)
References: <xmqqv8ij5g83.fsf@gitster.g>
        <CABPp-BGoPuGCZw+9wCgdYyRR4Zf4y9Kun27GrQhtMdYWpOUsYQ@mail.gmail.com>
Date:   Mon, 03 Apr 2023 08:49:18 -0700
In-Reply-To: <CABPp-BGoPuGCZw+9wCgdYyRR4Zf4y9Kun27GrQhtMdYWpOUsYQ@mail.gmail.com>
        (Elijah Newren's message of "Sat, 1 Apr 2023 12:07:58 -0700")
Message-ID: <xmqqfs9h9da9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> * ad/test-record-count-when-harness-is-in-use (2022-12-25) 1 commit
>>  - test-lib: allow storing counts with test harnesses
>>
>>  Allow summary results from tests to be written to t/test-results
>>  directory even when a test harness like 'prove' is in use.
>>
>>  Needs review.
>>  source: <20221224225200.1027806-1-adam@dinwoodie.org>
>
> Maybe mark as expecting a re-roll?  (based on Peff's review and your
> follow-up at https://lore.kernel.org/git/xmqqr0u1agq8.fsf@gitster.g/,
> plus the typo I just spotted in the commit message)?

Sounds good.  Thanks.
