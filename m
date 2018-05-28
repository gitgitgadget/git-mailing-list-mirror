Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E93E1F42D
	for <e@80x24.org>; Mon, 28 May 2018 21:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934401AbeE1Vvr (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 17:51:47 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38485 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933771AbeE1Vvq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 17:51:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id 94-v6so22214033wrf.5
        for <git@vger.kernel.org>; Mon, 28 May 2018 14:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=j3YvntmVpTWvT9rSK2S2XZ3VSoQQ+Y3X8TDuOqwRgDs=;
        b=A77BHnoU8/TJg2Cfb+LqAAqqnZo9HTI3Jgmole0x12Lcgf6bNmj1xql5sMeEwzKb9M
         WeWG4v9UU6mDy/rB7mMIqgZMM8G3ftS0lR5MVAdG0qVvuybNLY2Wu8rKreSpEfcKIz6L
         EQbXEpiB1e7eCeGXwj3O/utd5YZinLkhvxr33R3glvBegsPdKFv0O8M7jQppllM1WFKD
         6Ta8AUFOAh4BPIYWh3PaC7agcM8lldmS6eTa7oQzk/BKdpAtAxD37hDuS3o4y79xI/ND
         Q4OUSC6WdNfg8fgcjpjU2xdUqOP5+55ooT4ONW2odTmW6RtjmaR6cXckf5UX9Jwzd4Qj
         y7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=j3YvntmVpTWvT9rSK2S2XZ3VSoQQ+Y3X8TDuOqwRgDs=;
        b=DPTBz6cFGc+v6iFRFBKVAwJCME/hLWfZ5fsJcyhbHTcLGIHSnqKCvdNCoN+tEwYvli
         ObJGUCWwdMl/2uEiEXhj8Leej7wli1c9CRn98s89IAkkUK6G5IBxJK2bzl3h1agg/TNt
         avun/O/IqprkFhpO4MnIQXdlJRo6hj255FoWlL19y/Jdi7uXtyLRXB3PirtpUXRtS/AT
         6JXyuGevQ0zslYO1eAFjY6nnuwZvbeobikv3IxyCVUsZpW4xuRlPgT0WD+6to+xftigY
         6pgjpbH41V6gGaWsePXXBO7KwI6TMgBKYNihv1mc6mFoy+OM6LEMEu8T5GWDEnA3MQta
         VPBQ==
X-Gm-Message-State: ALKqPwftlIJIQzRuVFvNCeNmyCzU1mh+VVfvk+8gXUy2chq6gnPjkrbQ
        Io0zf+QeTuJH2a3AqiRGn+M=
X-Google-Smtp-Source: AB8JxZr6GYgC/nopMk7XxMwApTXbReAdkkiy+m20ymOQrOdtoOs/GjLQ8Rr7HKtb459VKPjUclS6tA==
X-Received: by 2002:adf:e8c3:: with SMTP id k3-v6mr10225376wrn.182.1527544304842;
        Mon, 28 May 2018 14:51:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n11-v6sm27188966wrh.10.2018.05.28.14.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 14:51:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tiago Botelho <tiagonbotelho@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, haraldnordgren@gmail.com,
        tiagonbotelho@hotmail.com
Subject: Re: [RFC PATCH v4] Implement --first-parent for git rev-list --bisect
References: <20180528092017.19022-1-tiagonbotelho@hotmail.com>
        <xmqqpo1fj1qv.fsf@gitster-ct.c.googlers.com>
        <CAADF+x2q6HwW3BaLt76ZVikyu8Rz0Ykbf7iD=dBORigaONmtDA@mail.gmail.com>
Date:   Tue, 29 May 2018 06:51:43 +0900
In-Reply-To: <CAADF+x2q6HwW3BaLt76ZVikyu8Rz0Ykbf7iD=dBORigaONmtDA@mail.gmail.com>
        (Tiago Botelho's message of "Mon, 28 May 2018 17:49:47 +0100")
Message-ID: <xmqq4lirih3k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tiago Botelho <tiagonbotelho@gmail.com> writes:

>> Running this test number of times gives me spurious errors.  Is the
>> order of these output lines unstable?  How do we "sort" these
>> bisect-all results?  If we are not sorting and the output depends on
>> happenstance, then probably we would need to compare the expected
>> and actual output after sorting.  Or if the output depends on
>> something under our control (e.g. they are related to topology and
>> relative commit timestamp), we probably should try to control that
>> "something" tighter so that we can rely on the order of the lines in
>> the "expect" file.
>
> The reason why the tests were failing was because the above "old" tests
> did not make use of test_commit which in turn would make the sha of each
> commit be different and as a result give unexpected outputs at times.
> If I move them to the top of that file the tests will pass every time,
> would that
> be ok?

That means if somebody else needs to add other tests before the
location you are planning to move your tests, your tests would
suddenly start failing, no?  That does not sound like a particularly
robust solution to me.
