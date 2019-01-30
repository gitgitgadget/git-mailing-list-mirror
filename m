Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 663E81F453
	for <e@80x24.org>; Wed, 30 Jan 2019 16:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfA3Qrb (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 11:47:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50437 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfA3Qrb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 11:47:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so242927wmd.0
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 08:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=dgDn8a/TWJCFn1JdhAPeX0jUiYfBpabAtNqQvb9J/zI=;
        b=GG853BnK000SmPegAtf1kzD7FDzVKLKvt6rAnBZwUlL4sv4eH7/221AnQ2Ao+HfEuc
         mDQc5SJHnEeckzp2YCewxXw1gJH7XNzgdzPU+2FhiQ28Fk7vtmnFKS6FXUvoxUYyGrgZ
         +Ni03UfEpji0+MP5D4v/At3KhlRH+S8Z0woGPAk7MyHLfUoDPqPbVlcZK3yWynGH9Vrg
         GIMvHSwshfGr7FHQdw5HB8zszL+zalC2hj9iaXgwF9ca0Gju95Wt0rzZTisjLD0VdqLN
         jF3hVBkYdV0OnjcbwrItPwQ0cTjxnwxOeaOGbc+WClJRazSUm9IB5XkIp0aouKxam9Fc
         vAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=dgDn8a/TWJCFn1JdhAPeX0jUiYfBpabAtNqQvb9J/zI=;
        b=WS7LMPo1iqDtI5x2HgPtOp4gC8ml8HnnNA4KfwbaDCzokEVtxXYYZbOedbCB/Esznn
         wkwDaMduYF2BgPXiaomoGZQmv2mZ08qwWhCkOzYKyFpBDu47YRp70lkovTpd5wOjGx0k
         HsdYtQDIo3vIVU41ND09gDY5dFqqulXLF2qJPXQpHLnkXp9KmAKUuTU+6Tw8bOjGRND0
         xJ14aQPfyECvV70IW3ZnsBLZZwKsYwpH+1hy5bKfqOViYtSv3IG93Su+K57e6lh0fQdg
         citEi0WOINDKEkIXYRN7MCe0UwlScX19aqSDVMv33OA1igZS017+s+J0fqp4xgvg3ZS8
         rqJQ==
X-Gm-Message-State: AJcUuke+xmi1Hp2LCyb7WAyszfsyCnEtHH9gUkZdPcacV+0SQar1bW5z
        UK/k2xoHl9mqMMf5kZ8F61Y=
X-Google-Smtp-Source: ALg8bN74kacQaOMFZKdVKt+wqy2orGL+/bSTp3ZbZM3TLUeJatSSS6uXpNTeeP2nUr6IqGrmud7ktw==
X-Received: by 2002:a1c:67c2:: with SMTP id b185mr24260426wmc.96.1548866848005;
        Wed, 30 Jan 2019 08:47:28 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x10sm2216656wrn.29.2019.01.30.08.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:47:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Sebastian Staudt <koraktor@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] Add tests for describe with --work-tree
References: <20190126204951.42455-1-koraktor@gmail.com>
        <CACsJy8A6hF+Sxitpt3J9EmDEXjGb2e+AeMtJDaE7Y32fg4NEKA@mail.gmail.com>
        <CA+xP2SbLwmeWpqmjCiqojra5Mwrbok7sjvUsvCsaAo6XsWBbtA@mail.gmail.com>
        <20190128100659.GA6257@ash>
Date:   Wed, 30 Jan 2019 08:47:26 -0800
Message-ID: <xmqq5zu65bz5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> My function is a modified version of check_describe().
>
> Whoa. That function is 12 years old! I think our style has evolved a
> bit since then.

;-).

> I mean chaining within a test. This is to make sure any failure
> triggers the test failure (as it should, if some command is expected
> to fail, we have other ways to catch it).
>
> I would start with something simple, not using shell function at
> all. Something like this as an example (I added run_describe() because
> that "git" command becomes too long). Have a look at the "do's and
> don'ts" in t/README too.

Thanks for guiding new contributors with an easy to understand example.

> BTW, careful about _success or _failure. You need to make sure bisect
> is not broken. If you add a test to confirm a broken case then it
> should be test_expect_failure (and the test suite will pass). Then
> when you fix it you can flip it to test_expect_success.

And if the fix is simple enough (i.e. a good rule of thumb is if the
fixes themselves without tests need to be multi-patch series, it is
not simple enough), have a single patch that has both fix and test
that expects success, instead of splitting them into two to make a
two patch series whose first step expects a failure and whose second
step fixes and flips failure to success.

