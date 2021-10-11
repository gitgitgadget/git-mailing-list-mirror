Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2DEC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56ED760E8B
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhJKUuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbhJKUub (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:50:31 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1552C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:48:30 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id z7-20020a63c047000000b0026b13e40309so7462060pgi.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WfsA0o0SLaMyw498IOG5cQsAhdAk4qhpG/hIgIgB2Hs=;
        b=sj443sMepbLu6iMOHN1WqMz90mLGKrHci4apeZgp89nAy4h08fJNjZozscSmDGOrrq
         pSl/EclKVNrU4BIpCbrO2WbcEcndo8Kb7nmizujWtO9NYKNrRXaK6nw1a4DLKRvEtMKz
         zjaZYEyWWSj+KKdFJ/nFQEfeqhUZE+cwsYgbWzUX6ZMvMDbz52RbrqF90/t+BLhDKfUI
         lMs6Brc4LgQjK0ZplDV2JXOQmzYpHn84lpCwmN4hbu79VbBviKwIn0OtF5XCnnZ2m+Ah
         WFvHcwFDfkTSDV5CMPIw+dJ1KKSo4/a1tlzsTMI/gzNj4LBMRH2hMeCJEG1z/Rb5wuYR
         XwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WfsA0o0SLaMyw498IOG5cQsAhdAk4qhpG/hIgIgB2Hs=;
        b=G/kJEEcVYpaEaDBQ62Ezr4UNgtIDyw065ewWVtitMHkk71hTCvSfXakbtYJxlN9fZK
         oPhccvtNER2Ctl1BAkvFR5n9lFnOBj73b0xInxnvZ9L6/OMzm5feN4uIAtte9UPo5AOc
         gYP/X+I6J2wHOcN8BytZ8/I/pUhsQunRloBLTB4qHh6B1qb4pcOjsap5xn7RB6BUliRb
         /1Cg5ktYz/4R5XcRvnxTTI0vVeGM93dK+m96Qiaa5LhbnugYnrx9OPAMSHbTe1JP+b3h
         hifh/RUB7JyOvSDun0fcFBOsiw6hAuM0BkaaBgmXCSJdzfYramX2hu6VEyJRsqtOEHav
         1iWQ==
X-Gm-Message-State: AOAM530qZa1h7T0m0/Y1txBa1skCLsh9VNvpLJdlVW+dXRxvhzbK/8kF
        RfuBtDjMj5Y2/C1ygshggaF7v1Z+tSJ4hw==
X-Google-Smtp-Source: ABdhPJz/JL+s0LoQjxwXzLgldllMRugulVaZMhr0jfRZpbeTUQXQ3QQOIHxBNML3R0O/rehaUcHe2hbXUVe+5w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:40c:: with SMTP id
 12mr19961172pge.406.1633985310366; Mon, 11 Oct 2021 13:48:30 -0700 (PDT)
Date:   Mon, 11 Oct 2021 13:48:28 -0700
In-Reply-To: <xmqqzgrfb9z6.fsf@gitster.g>
Message-Id: <kl6lczob2spv.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20210917225459.68086-1-chooglen@google.com> <20211005001931.13932-1-chooglen@google.com>
 <xmqqfstafyox.fsf@gitster.g> <kl6lfst72v1e.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqzgrfb9z6.fsf@gitster.g>
Subject: Re: [PATCH v3 0/3] Use default values from settings instead of config
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Using the set of GIT_TEST_FOO... settings I cited in the
> Reference#1, in the message you are responding to, will let you
> reproduce the issue locally on glinux boxes.

Ah, I didn't notice that ci/run-build-and-tests.sh uses different
settings for different environments. With those settings, I can
reproduce the failure on my OS X machine.

Thanks so much!
