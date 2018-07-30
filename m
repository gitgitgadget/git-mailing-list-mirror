Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA6F01F597
	for <e@80x24.org>; Mon, 30 Jul 2018 17:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbeG3T1E (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 15:27:04 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:52522 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbeG3T1D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 15:27:03 -0400
Received: by mail-wm0-f45.google.com with SMTP id o11-v6so283266wmh.2
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 10:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=rDbMAEztlh9cEq+32fQZttuHAujO9qF/j4/WXDbqMuA=;
        b=Er04Xq53gJqU+ILscS6U9WFlujYwub6g6Gkb9AkfhT1bY91hg7Pt4nbl5EQlVXkqqX
         fJYoHz5asrnw4BWwGezCO4BBjMFJbCh8Wvzu7UDzCJ9GpoTwqR1ANjthjmLW9AikFZHQ
         oUscWQ3UhcrAaSjSPkQ9I7i+X2/NPgMbPbbTXtQRY+YQHAGdQiP6tuKV6FRsAh/sgF2n
         IWHnhiPTE7ekfEpWEAy3J5W0rqMTHYy/Oxbbsp9o9OJlp7KqwJkVak7e8nPzq+m89Cpv
         PWWc3ml8eGHSr5nl0amZkctSc8obqhdANbOfHEb3yKV5PoFMkuI8kiCPejXnq9tiqfb/
         Ze6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=rDbMAEztlh9cEq+32fQZttuHAujO9qF/j4/WXDbqMuA=;
        b=mBoc/KkpYPccRYDjSvtvDF2n2vRrB15ORWKbwDwLlVWwTKQakKOe4nW1RM6VDXRFA2
         kYGYn+o9HKq+5qM+0V+tcEWQFEWYKJh0v5NiJvv0v+yp25cml0KQYD8wMk83cTftjF+V
         5vYwK41HJHfwIOS5J27hSZeDNZheZkwD7Lc06JbeALIVm5kq9n/PMjMW6lPgHxNNrkHc
         Eotu7gZ7wrhQcnhXBADmaWkyzwTLjY2/hIoNmDW3lx/fiQu3Nw3j/JC2+Zcgm47y1e4C
         LY0ek3oJU8yj0bLYLvjLn5dI2OyamzieURHuwr1Biqz0tkr3Bze07S4IoWaLxtPnqk0j
         6rbg==
X-Gm-Message-State: AOUpUlFqElIeb4n+WeFRTVlJprvfHYgA9KtIRlUD+4mmYGH4EXSKTJj1
        hEh19SIss7nNCVafTunYQYYjHb77
X-Google-Smtp-Source: AAOMgpcSBme7GeZytl9/1zb+2I8eX+YB/lahrhQNCpYD4hwVj1iYTDp/PIqS1RcJc6c5VHxWr0dupg==
X-Received: by 2002:a1c:10d4:: with SMTP id 203-v6mr174760wmq.158.1532973056507;
        Mon, 30 Jul 2018 10:50:56 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b22-v6sm149823wme.48.2018.07.30.10.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:50:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 07/11] rerere: only return whether a path has conflicts or not
References: <20180605215219.28783-1-t.gummerer@gmail.com>
        <20180714214443.7184-1-t.gummerer@gmail.com>
        <20180714214443.7184-8-t.gummerer@gmail.com>
Date:   Mon, 30 Jul 2018 10:50:55 -0700
Message-ID: <xmqq4lgghatc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> We currently return the exact number of conflict hunks a certain path
> has from the 'handle_paths' function.  However all of its callers only
> care whether there are conflicts or not or if there is an error.
> Return only that information, and document that only that information
> is returned.  This will simplify the code in the subsequent steps.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  rerere.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)

I do recall writing this code without knowing if the actual number
of conflicts would be useful by callers, but it is apparent that it
wasn't.  I won't mind losing that bit of info at all.  Besides, we
won't risk mistaking a file with 2 billion conflicts with a file
whose conflicts cannot be parsed ;-).

The patch looks good.  Thanks.
