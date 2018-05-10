Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B37B1F42D
	for <e@80x24.org>; Thu, 10 May 2018 10:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935118AbeEJKvM (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 06:51:12 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40347 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757093AbeEJKvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 06:51:11 -0400
Received: by mail-wr0-f196.google.com with SMTP id v60-v6so1544413wrc.7
        for <git@vger.kernel.org>; Thu, 10 May 2018 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=wjwF0q/c//4HRkLzHtGlSr2D9/SkHrNSOvH8o7hMmJ4=;
        b=ebGiqOqarw31bR8mBlTf30zxzKf/HqH0gtf0BstHOEuc4sto6j05kQvuh9AuJuyYhA
         FxT2tAHl6Vpbk4Yd7L5XX4t0nRWm/4oaDHOBQqbFnBM6R6s++6U7NpKioWb3aXcC0QfM
         W0Y1R5RAdbVpiKHlG1LP6lsgcz+wGWHreMh5i07ZV3LoslSP9OHqUVBi8Nvya5upHhX/
         R6kXUXBNlMjuaJNoR6H2auZCoIeXd57HkS1ZiI6SG9E5jigU+0aU8YXuVAmkN6nUOPbt
         tbYJw1nd/tpUxiA0/T0xbU9VHafPALGsthSByM3gDD5M8bPUHsOmB9o8DW7nnlahBelq
         naoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=wjwF0q/c//4HRkLzHtGlSr2D9/SkHrNSOvH8o7hMmJ4=;
        b=Rlj5fwRxCEgfKA8sfnA3ZjT0M0P1bQJYBS+eBhbJ8Z2HKstD1rlrWiWZOw61VftXep
         ifdWYKIe078U6hctxmIs8oz313JiX8k3DklJ+x1fpvFNs7AqnzVo3lTfseGb1vpyyS2D
         XfmSx7gMpsFSWn5CuMrs3ZQcL9fYsgcTnmu9j+kISoFdQ3yw8zCvzkrZLwv/TjRSMoXF
         r16cPDG8eCTFPfIf2moqa4RpxmAGEuTbgc/jgXyUlWekUAvH1mk+ZW2wbwEqnfM+qzBv
         ShTDbrlux9mWp1V9IYU6BtArkte/zUXxARms30MqECj2OUSXeBX4N9sIOchIT8hy1XyN
         RB1g==
X-Gm-Message-State: ALKqPwebAu/XqDe0g4jdNsCE6MbNXq9HGyv8ajJVcjIeignn0l/I8BxN
        BPIZdzDE23SnhuQ/GOOqOOg=
X-Google-Smtp-Source: AB8JxZqI7gk0eW+kh3tsE1b0mdcU+wuLMUkAJgSYYpSJe2XQHVsgt6Wqp1LQa89an/xOTLqkRXtBEw==
X-Received: by 2002:adf:ba4a:: with SMTP id t10-v6mr837731wrg.219.1525949469904;
        Thu, 10 May 2018 03:51:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k126-v6sm1197155wmd.45.2018.05.10.03.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 03:51:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] fast-export: avoid NULL pointer arithmetic
References: <d50a4d5d-3b99-453e-1b52-4e733453fb78@web.de>
        <99d443cd-e817-7db5-f758-bf4cf47f7c06@web.de>
Date:   Thu, 10 May 2018 19:51:08 +0900
In-Reply-To: <99d443cd-e817-7db5-f758-bf4cf47f7c06@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 10 May 2018 11:24:01 +0200")
Message-ID: <xmqqo9hniy1v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> The standard says about uintptr_t that "any valid pointer to void can
> be converted to this type, then converted back to pointer to void, and
> the result will compare equal to the original pointer".  So void * ->
> uintptr_t -> void * is a proper roundtrip, but that doesn't imply that
> casting arbitrary uintptr_t values to void * would be lossless.
>
> I don't know an architecture where this would bite us, but I wonder if
> there is a cleaner way.  Perhaps changing the type of the decoration
> member of struct decoration_entry in decorate.h to uintptr_t?

In order to ensure "void * -> uintptr_t -> void *" roundtrip holds,
the implementation would guarantee that uintptr_t is wider than
void*, so what you suggest technically makes sense.  We should be
able to store any pointer in the field.  And we should be able to
store any value of an unsigned integral type that is narrower than
uintptr_t.

But it somehow feels backwards in spirit to me, as the reason why we
use "void *" there in the decoration field is because we expect that
we'd have a pointer to some struture most of the time, and we have
to occasionally store a small integer there.  So I'd naively expect
that

	uint32_t mark = 23;
	de->decoration = (void *)mark;

would be a good way to store mark #23 in the field and

	uint32_t mark;
	mark = (typeof(mark))de->decoration;

would be a good way to read it off of the "void *" field.  Of
course, this assume that (void *) is at least as wide as 32-bit and
it also ignores the standard ;-)

This is an unrelated tangent but the mark-to-ptr() and ptr-to-mark()
implementations feel wasteful, especially when we worry about 32-bit
archs.  A naive platform implementation of

	(uint32_t *)mark - (uint32_t *)NULL;

would be ((uintptr_t)mark) / 4, i.e. the de->decoration field will
always have two LSB clear and only utilize top 30-bit to represent
the value of mark.
