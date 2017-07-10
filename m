Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F13420357
	for <e@80x24.org>; Mon, 10 Jul 2017 20:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752388AbdGJUi3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 16:38:29 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35309 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752158AbdGJUi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 16:38:28 -0400
Received: by mail-pf0-f194.google.com with SMTP id q85so15945209pfq.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 13:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Zy7qQAOXiRRHgj2xJI1bNkdb+PtwBWF0QKSfnZowqnU=;
        b=L8bfJr2h85QhGkQlPAdihVXX/38Q1gHsBtFjHG9JrvxAbaSLf9DYL6khs6RHKuCgqS
         MJp4ENm0FfGPf4J3Angeli2hFaZhBBlgIBpYhybZT+KFz/2RaNwzY5PgpRpUFueasOIB
         HikzGJI4uW30s+SmDVJAqISfYPNaVCSY4PWQhaxkKJxOAvWyyZ3w1S3F1leWxcC5Aj1q
         l3lkVT8dH7BTK9v1RhyP1dytD6xfeBDMXFTwGnejR69N3UI0uM9MkoBwXaTnAlBxPhTL
         w6QmzjkNxo7zP3P84gb3T3QJkuhI68kfynlQsMJ/osFbV8KGeTZLB6y3pAEa1iT/yHpm
         N6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Zy7qQAOXiRRHgj2xJI1bNkdb+PtwBWF0QKSfnZowqnU=;
        b=cYVUaIrX2bxj2Y9+mbnFrZzpJFd+DxkKzvMtMbFiwrgJl8BDoGlC9m66fR9UEL+BhZ
         FE6zs7SAuplR07XBAmnbQA5/rVxxQW2xWT7YLHr6MIKYCVU4deSwNCJSfY4/40BuMdBb
         2xI6rjBeLnPM+L1NlK39AycJt0gQT09lqi6qGQciV32YAhqmFtmbqIPop1auyb3iM4KV
         9zt6RoJtL2fTk4CYy1qiObJVASqP5McBoi7IAy9wlfMl17inPuRFdrGa/OHrtVvNwvOZ
         ZyQJyepnVCrI7f9VZcuVYk+o6qfbc2v8TIi0KgqhHjI05pENGgyC4k0d4EDq61j33equ
         dU+w==
X-Gm-Message-State: AIVw112pJ/eKqqOT7bq1pMDxENn62yBEsM/UxXM+VItAom/17f5M3cPP
        qoRCe95UPbSKKA==
X-Received: by 10.98.113.71 with SMTP id m68mr29655735pfc.220.1499719107795;
        Mon, 10 Jul 2017 13:38:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id z86sm27830341pfl.40.2017.07.10.13.38.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 13:38:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
        <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
Date:   Mon, 10 Jul 2017 13:38:26 -0700
In-Reply-To: <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org> (Johannes Sixt's
        message of "Mon, 10 Jul 2017 21:57:40 +0200")
Message-ID: <xmqq4luk58ot.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> It's a pity, though, that you do not suggest something even more
> useful, such as C++14.

I cannot tell if this part is tongue-in-cheek (especially the "++"),
so I will ignore it to avoid wasting time.

>> Subject: [PATCH] strbuf: use designated initializers in STRBUF_INIT
>
>> -#define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
>> +#define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }
>
> While this may serve as a test balloon, changing STRBUF_INIT, or any
> of those _INIT macros, is actually the least interesting. The
> interesting instances are initializations for which we do *not* have a
> macro.

I am not sure what negative impact you think the macro-ness would
have to the validity of the result from this test balloon.  An old
compiler that does not understand designated initializer syntax
would fail to compile both the same way, no?

	struct strbuf buf0 = STRBUF_INIT;
	struct strbuf buf1 = { .alloc = 0, .len = 0, .buf = strbuf_slopbuf };
