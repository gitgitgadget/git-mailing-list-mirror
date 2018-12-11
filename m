Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD93820A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 03:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbeLKD2R (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 22:28:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40856 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbeLKD2R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 22:28:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so647759wmf.5
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 19:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BjWF5E26uFTG924MImeB8EuwPLOY+w0sVmyiUislwrM=;
        b=jJ6AAkUAgBCfGJuDcEg7Otah1Zyg3pxaaD+hx9T7hBIm7+P9jF6jJdqxpcKKT7SGh4
         cI23cPtqw6NUITfJiL52vqFefAASojk1V0DusSqD/t57K8DVaKXfdfd5qPFwKPAeXESi
         Xhlmh+PK93+a17RRi90U0nYN1JfQv0k9ebuIr3pKOlC/QJIIP2z+HX9TEr8HkkVkUOJc
         y6Ik8w13tTRYTQMQDepo586wtsxbNWRZ3qKjgmfdR4pP4dJOUt5tpubhm7jMq8oFb0Ma
         RCRvUdFL6SdH3Je1xLSpfBJVGvpCu/L9fyMsJjwws6lw1mVObfb9VoCKD6sK0NdopsR3
         b1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BjWF5E26uFTG924MImeB8EuwPLOY+w0sVmyiUislwrM=;
        b=nqmU0nDn97Lame83FwCPJ2orgHYRXrZD02GzrJH0cQX66OXEYMjgjj/FWUfU9l2QqF
         zIJh+aKSupBGZT4KNi+ko1l5iRfvmjOUsJm4LrTnI6G5JIdSqWnGr6QPgMmlineNR7Rv
         RA/CJgMV+NKiR0H2cM2TO/gQ19dOOWVOb3rSzBWEUezHMixY87k8UzHhgHXBwfrAueq+
         QXpJzHKgyejA5RXDCnZcMsQO18DMOr2xwF4+fZkTBT09ftefWk92Nm77fP9mpp4ifycL
         QlDgXxgksZ8GMbimdnKgxNzQNlWMXi4r+0ZPKLgxoeHumXU1HDpPTBLH4qSjPIkUeW2y
         LuVQ==
X-Gm-Message-State: AA+aEWbt9AUbgYiBhVxtNHY3tYbViLLJ2NMEUtAvGZP/iWS1y0NxR+zi
        RnHoanoTF2tVrhOSUMEFKzw=
X-Google-Smtp-Source: AFSGD/UjELbgHDKe7N+0eaLC5blTg8Nn5gQNsFpcIHdkf8FwbAJJoBKYMNZdMYNya9UlgBNQNNpUwg==
X-Received: by 2002:a1c:b607:: with SMTP id g7mr752121wmf.97.1544498895575;
        Mon, 10 Dec 2018 19:28:15 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a18sm17393249wrp.13.2018.12.10.19.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 19:28:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] rebase: offer to reschedule failed exec commands automatically
References: <pull.90.git.gitgitgadget@gmail.com>
        <d2c317fd-d10a-19c1-8b4f-a7311c69a52f@kdbg.org>
        <CAGZ79kY18SCaCBvkWyeVd+oeJ4EhoJK4=QxGhJ9a77iX2sR8ew@mail.gmail.com>
Date:   Tue, 11 Dec 2018 12:28:14 +0900
In-Reply-To: <CAGZ79kY18SCaCBvkWyeVd+oeJ4EhoJK4=QxGhJ9a77iX2sR8ew@mail.gmail.com>
        (Stefan Beller's message of "Mon, 10 Dec 2018 14:56:47 -0800")
Message-ID: <xmqqpnu8lp2p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I wonder if it might be better to push this mechanism
> one layer down: Instead of having a flag that changes
> the behavior of the "exec" instructions and having a
> handy '-y' short cut for the new mode, we'd rather have
> a new type of command that executes&retries a command
> ...
> By having two classes, I would anticipate fewer compatibility
> issues ('"Exec" behaves differently, and I forgot I had turned
> on the rescheduling').

It takes us back to the original proposal that started this whole
thing.

    cf. <3fb5a7ff-a63a-6fac-1456-4dbc9135d088@gmail.com>

After re-reading the thread, I still do not quite follow why it was
considered better to change the way "exec" is run with the command
line option than to implement this as a new insn [*1*], but that is
where this series fit in the larger picture, I think.


[Footnote]

*1* The original proposal called it "test" which I do not think was
    a great name.
