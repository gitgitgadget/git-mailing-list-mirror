Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC7E31F453
	for <e@80x24.org>; Sun, 30 Sep 2018 05:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeI3L6u (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 07:58:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40503 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbeI3L6u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 07:58:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id o2-v6so5567576wmh.5
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 22:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=x7CqX7PVrNk6bfwcTU9bKSjXrd1CmeMWWAZCRemQGVk=;
        b=UcBasm1BOQRDPxoqct0XIBip2LqhoCJqSix47yy8WfG+RYyxo7zvq9uB6+unAo7SVU
         yH7vO9Ly41gF1MifmIdupCPeDgKaMVzo1p9H6o0stZHScgEHV2gjsodIOWF9zJIv8xUG
         SqRk6pMF5N7w3gVDKo0PCoFi8qj/1VkEaWRBdw4k2qWlPgIsZthcEG5OwPgRB8OoT3R+
         WXgq7YvpSTOmu0iFTkBHubKWiJULVAF6El7nPTHJBQpiIfPRV5c31UUHAOgZ4S59ntLM
         9BVIMPrBJ18I244KcvZA50CDoRIqBW7PB1fZ9p/k2UZfUYDZO3CpE4FsEJaZzWu6ooHQ
         7q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=x7CqX7PVrNk6bfwcTU9bKSjXrd1CmeMWWAZCRemQGVk=;
        b=pIOQ/8CdqshHKgRLDq21SsejYxGSdQH235CutCOz7Vg6lwyAh54vF1HuwDxDSWEdSj
         d8+e1aDPgnSI50Y63DywLK1UslinWQe9HX2B/Ev5QyVjlqUo9MmA0PMGpueh/VMxCrEp
         mFiq3rrrilxed9941FUWu+yjiBaNHVWfsxY0ZjupTUtqx3VKqhDU4uhb3/xP73/qJfNx
         jhjhK6V5M+2k1OmT8zl0ux7Q7uTZhIUkt40CpStgBVuo9GhrXNEdoQAYWGVmAV0u4yU+
         Xkhw7EscYbn2MDFa6M3JNnb3V+96kwXq5WMq+Sw678kvoxXaWMQGiMefvnJc3D6OLsgw
         x2/A==
X-Gm-Message-State: ABuFfohbgecajzw7Y14Jm3CkcgQBo8ajetdY5j3rA+h41GQbI0aY5Opa
        sMenvA2fM6ADwveMcrgEwTs=
X-Google-Smtp-Source: ACcGV60tK8tR0p7lUJ8jYV+YIJacAq9BINUracjYpcwAYcjFVz3+WgFRvqGsVTeNo9+R+kZfhquyIw==
X-Received: by 2002:a1c:1203:: with SMTP id 3-v6mr5650053wms.21.1538285236645;
        Sat, 29 Sep 2018 22:27:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b81-v6sm218775wmh.47.2018.09.29.22.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 22:27:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
        <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com>
        <20180926184914.GC30680@sigill.intra.peff.net>
        <3677a12b-5b9b-ad2a-1e3a-7de251baa40d@rasmusvillemoes.dk>
        <20180929082108.GJ2174@sigill.intra.peff.net>
        <xmqq4le89p91.fsf@gitster-ct.c.googlers.com>
        <20180930042735.GA32120@sigill.intra.peff.net>
Date:   Sat, 29 Sep 2018 22:27:15 -0700
In-Reply-To: <20180930042735.GA32120@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 30 Sep 2018 00:27:35 -0400")
Message-ID: <xmqqy3bj7dxo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And I think this has to be stderr. We're polluting the output of the
> aliased command with our extra message, so we have two choices:
>
>   1. Pollute stderr, and risk copious stdout (or a pager) scrolling it
>      off the screen.
>
>   2. Pollute stdout, at which point our message may be confused as part
>      of the actual output of the command (and that may not even be
>      immediately noticed if it is passed through a shell pipeline or
>      into a file).
>
> Choice (2) seems like a regression to me. Choice (1) is unfortunate in
> some cases, but is no worse than today's behavior.

I think the output of "git foo -h" changing (i.e. has "aliased
to..."  message in front) is about the same degree of regression as
"git foo --help" no longer giving "aliased to..." information
anywhere, though.

>> Even the first two "better" cases share the same glitch if the "foo
>> ...
>> thing to do is to
>> 
>> 	$ git unknown-command -h >&2 | less
>> 
>> And at that point, it does not matter which between the standard
>> output and the standard error streams we write "unknown-command is
>> aliased to ...".
>
> Yeah. I think if "git foo -h" produces a bunch of output you didn't
> expect, then "git help foo" or "git foo --help" may be the next thing
> you reach for. That's not so different than running the command even
> without any aliases involved.

Hmmm.  With the "teach 'git foo -h' to output 'foo is aliased to
bar' to the standard error before running 'git bar -h'", plus "'git
foo --help' now goes straight to 'git bar --help'", "git foo --help"
no longer tells us that foo is aliased to bar.  Presumably "git help
foo" will still give "foo is bar" and stop?
