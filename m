Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C97231F597
	for <e@80x24.org>; Sat,  4 Aug 2018 17:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeHDTQY (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 15:16:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38415 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeHDTQY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 15:16:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14-v6so8328909wro.5
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MG+PkpHTTxwSweaOT7mSTCR8FakGF+K8RXdUNln7rL4=;
        b=eD4kTmezedt//9/ah48qSUBpqSztqKtK/PhYfynbarOvXGHu2UObWYw7bA1Y3qJWUL
         J4VD/4rjvVoMXt8A0jAXsVeSk8Rw7RGnOx/ZbVD/7TCUT7BFMif+7Uen8rQTQJvWezaU
         lqsrdHXzqwwJhSa0xnaTsUSjIL43/lg/WbnDEXqziKz4KTxSCQplf2y5AXbv3UepYhJw
         msb4to3JmAJKSjADONcuY6Lr2L5uEODiYUqilYz0FOf/YhrnWJYejB+z9yA8xp6CZ722
         pQAtY7GWeYvSiCw9jhOz5H8vdmNqXDvQjOwC7qdwpl0as/eQtutZf0EWeD4bdtgkUGUK
         zA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MG+PkpHTTxwSweaOT7mSTCR8FakGF+K8RXdUNln7rL4=;
        b=ZuhlgVwcqxY8RYQw26VD5ABIBixHdLuKixkhMJvSIdkLhgjHWZwNFnheLgnXoa1uFn
         9amq206eMMgACNJgWnM/QzRElj3cDcJ9kKkByMGtcuCn8RyxDaEqqW83VEfXIyFoglPl
         LcZGWH57HX4PMC7uuMTk+K3reBMc03zNpQE5cahO3UQh8WfVZ083Em2i7HvqlVtyEBuC
         ju5CFYArKqXzZJGCnyLE8Il4aenAiL6xnPd1fA7SxLHHoOOQdOpkhzvrfemMEc25lWaV
         1UJ0gm1iNGSiO81brcAvwWHxxXaW67RZD/4cGvGhMmFQcMBPL6o/ZsalRDZ46P1qLwzw
         vfCg==
X-Gm-Message-State: AOUpUlEyUHXtOm1vxw+aAalkGRKGyWyuHjv3RMU0c0q3qK67aAqk5DFd
        AtBMmukK+17UWjtq1M6awOA=
X-Google-Smtp-Source: AAOMgpdxAboB/0pzjYjiOYMBVWMqJKG+DUcIdbii59rIjEsNQQCUV/8qGc3sZPkAPhdx34avpsD9SA==
X-Received: by 2002:a5d:6550:: with SMTP id z16-v6mr5356830wrv.194.1533402903701;
        Sat, 04 Aug 2018 10:15:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q3-v6sm1734263wmf.21.2018.08.04.10.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 10:15:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 7/7] diff/am: enhance diff format to use */~ for moved lines
References: <20180804015317.182683-1-sbeller@google.com>
        <20180804015317.182683-8-sbeller@google.com>
Date:   Sat, 04 Aug 2018 10:15:02 -0700
In-Reply-To: <20180804015317.182683-8-sbeller@google.com> (Stefan Beller's
        message of "Fri, 3 Aug 2018 18:53:17 -0700")
Message-ID: <xmqqtvoarr3d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Try it out via
>     ./git-format-patch --mark-moved 15ef69314d^..15ef69314d
> to see if you like it.
>
> This separates the coloring decision from the detection of moved lines.
> When giving --mark-moved, move detection is still performed and the output
> markers are adjusted to */~ for new and old code.
>
> git-apply and git-am will also accept these patches by rewriting those
> signs back to +/-.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

This does not have anything to do with the range-diff topic, but
would stand on its own merit.  

I have a mixed feeling about this.

If you need to convince "GNU patch" maintainers to accept these two
signs, then probably it is not worth the battle of incompatiblity.
If it is truly a worthy innovation, they would follow suit, which is
how they learned to take our renaming diffs without us prodding
them.  I just do not get the gut feeling that it would happen for
this particular thing, and I am not convinced myself enough to sell
this to "patch" maintainers and expect to be taken seriously.

When reviewing anything complex that would be helped by moved code
highlighting, I do not think a normal person would choose to review
such a change only inside MUA.  I certainly won't.  I'd rather apply
the patch and view it within a larger context than the piece of
e-mail that was originally sent offers, with better tools like -W
and --color-moved applied locally.  So in that sense, I do not think
I'd appreciate lines that begin with '~'/'*' as different kind of
'-'/'+', as helpful hints; at least until my eyes get used to them,
they would only appear as distraction.

In other words, I have this nagging suspicion that people who
suggested to you that this would help in e-mail workflow are
misguided and they do not understand e-mail workflow in the first
place, but perhaps it is just me.

Thanks.
