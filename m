Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A86C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873B560F11
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbhJMNrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhJMNrp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:47:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB49C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:45:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v17so8549402wrv.9
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Azz3N8Ufv1PONx5Oxp9CpTpyjVgeHa0fOo1vopPbM94=;
        b=kft1FJbWiu0fd41Dx1d5chCU8tJtRXWgy1kC9XCDwfbSQpTzY7FQ9DQNvxBVWfvbnR
         9a+UiQm48cyLvcOHaFrhKiYj0XaqIlqXaOb3TR3OtS/LBNxlAQUieEAhEXKdFjy9zYcM
         26ZVDhyOQ7XHd+WbespJmvfR8vkmgBeH+6HTprjafxI3Q+Lyg1wyXxMeEKAgOh12XQ6D
         73d4slGxyjFbof3/nYrHBGm6FC+xBWF1I20qzb4SGh0yoLkPqlrXuNrZjFQH3tvRlLm1
         9iBpwJRmb1FlE0JrRPPw4GvyXzw2VFSsWXK32dLv+ElvqywMJmQ9q3wcXuht53u+DA/y
         clVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Azz3N8Ufv1PONx5Oxp9CpTpyjVgeHa0fOo1vopPbM94=;
        b=0IaAVWU56kxowQ3uUF4apgi6NBTU+QQ8y5FqzmP4dUNY4lPWldUbPT1xa+JxxrKsxm
         yADV6+RGQ4Hpgu11wJ5vodKMENRW2KsSzV6f5KyksruFtL+WEoaGIW5YcSgqfOxPhWgc
         D4sonKHJx/eNXR1YzoG0x6ROIT9ZbSssiQTQHdvI5A9198PuIrrJIWAfmLQNswkSlbjh
         HJ8Zs9cdPcd2lLPcUXcuQ4Vkov57v/Ohf5UyV9UQKSO6JpHNr+DnrZTlMS9y/FGy7ynk
         AOXrYAdtY30ZmHtoFVSfEOx4Eq/a90b7FdEoAd4lN+arzm4pVl9xKyMVrFxAvLOnsWTI
         48WA==
X-Gm-Message-State: AOAM530loaJS0MZXZM1DobO1qVqgQ7rt+qpy21/FygbEQe7Km7E5gpsu
        nrGmGcv+ZMn76A62eCP0l1pN1Y+37KM6rA==
X-Google-Smtp-Source: ABdhPJyxSr0ED9UuAmTVRy7nywd3YpoCW4fa/RGCezMgrHq+Vb5lrb27o9BBO0U84er0JlAyvDwVgg==
X-Received: by 2002:a5d:6d05:: with SMTP id e5mr24439157wrq.300.1634132740595;
        Wed, 13 Oct 2021 06:45:40 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u5sm5210234wmm.39.2021.10.13.06.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:45:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #03; Mon, 11)
Date:   Wed, 13 Oct 2021 15:43:43 +0200
References: <xmqqv9239k15.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqv9239k15.fsf@gitster.g>
Message-ID: <87y26xghrw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 11 2021, Junio C Hamano wrote:


> * ab/mark-leak-free-tests-more (2021-10-07) 8 commits
>  - merge: add missing strbuf_release()
>  - ls-files: add missing string_list_clear()
>  - ls-files: fix a trivial dir_clear() leak
>  - tests: fix test-oid-array leak, test in SANITIZE=leak
>  - tests: fix a memory leak in test-oidtree.c
>  - tests: fix a memory leak in test-parse-options.c
>  - tests: fix a memory leak in test-prio-queue.c
>  - Merge branch 'ab/sanitize-leak-ci' into ab/mark-leak-free-tests-more
>
>  Bunch of tests are marked as "passing leak check".
>
>  Will merge to 'next'?

I think it's ready for that. I just replied to what I read as a very
mild objection/nit just now in
https://lore.kernel.org/git/8735p5hwg6.fsf@evledraar.gmail.com/; and
noted that I'd like to just keep the series as-is.

But if you insist I'll re-roll it, just let me know.
