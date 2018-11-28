Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A0F81F609
	for <e@80x24.org>; Wed, 28 Nov 2018 15:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeK2CdF (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 21:33:05 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46269 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbeK2CdE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 21:33:04 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so14641825ios.13
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 07:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yBRg+k/nlOaP8IUTtYeZuJS9IzlHtTj0a+J2gZl3Trc=;
        b=gglPjiTC5QTdeyr8CnV1ln2rBq4X7i4ZRqtKMmr/HlruXjI6qje1e1Mcc1PpV/zSZi
         ILMkj9a76MfeK3N8SgvkKP7nTNOajb0iEzC+QZDt7ucMmZXh5Chp9RUf1+1jpp1DCOuv
         AuKtricaiMWFGgshyPC83294cUHshsvXKswAyGAu+s4GIncfttpT+xVg9KytQNTk0fXT
         Ci4rJPrsH0Be2Ynft3I6Ua7i8X8L9yIYo/V5hidUlcXOLQlhCNFjp5PYusv+HJYlHbbv
         wenuU3k0L6nerBaetg4DzoGBkj5uefM/qmq8f389gGOHDRcuZog0/FXr8rYBmNb6RYkS
         /zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yBRg+k/nlOaP8IUTtYeZuJS9IzlHtTj0a+J2gZl3Trc=;
        b=GshVL4PGPsg3fqSWwMvv/1Uv7z4Do312gXEu+ldhEVDpvR47Mubuz0mwpU0ng5cbI8
         di1DT3JBxo2/Dz+gchkKbsWxi7Rt+I4EFkLXFaeIqWYB5r7XNlZQQogQsse8RK/JiIa1
         J1lHnbZMcY2akrlshdhFmrIDO/LCuwOPYKhuS05PuVvgkG8ItFjkW1AoT9yzT1kMOQ5j
         q7XQkjoM2oTSxtUuK/nisdbXnj7bA+gpZ3DHuj03BfVL6aHi7d6EeEuGGs4wjRSP6RLg
         srEoemHmdJZpQzfKdM8B18IHMdAddwZa5pOszouI+dWThkeiacc5eJ9VqTer1m1xJVy4
         WIsA==
X-Gm-Message-State: AA+aEWYvarolg43+W+0k9re468ccJtBUWvy2gKsIJQKhCc2ShRTD7oYp
        D4OYRIDB93jFMwEsbCrX8sSd4jEq0olp22ATeSw=
X-Google-Smtp-Source: AFSGD/UuaGH/sI4JV2aXvYEmI0WdGYRpmL+8k/q+5mSjVnlmMXb4uuy+yH7Q2DIV3pSe7BwG+n5lkehnHhR2napwXf8=
X-Received: by 2002:a6b:6f18:: with SMTP id k24mr24526807ioc.236.1543419061830;
 Wed, 28 Nov 2018 07:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-7-pclouds@gmail.com> <xmqqftvlspqn.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftvlspqn.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Nov 2018 16:30:34 +0100
Message-ID: <CACsJy8Bzs=FYKrR6h1cqVH32eEt2t8rUMtE2yFNvt+W55u=sDA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] checkout: split into switch-branch and checkout-files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 7:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > The good old "git checkout" command is still here and will be until
> > all (or most of users) are sick of it.
>
> Two comments on the goal (the implementation looked reasonable
> assuming the reader agrees with the gaol).
>
> At least to me, the verb "switch" needs two things to switch
> between, i.e. "switch A and B", unless it is "switch to X".
> Either "switch-to-branch" or simply "switch-to", perhaps?
>
> As I already hinted in my response to Stefan (?) about
> checkout-from-tree vs checkout-from-index, a command with multiple
> modes of operation is not confusing to people with the right mental
> model, and I suspect that having two separate commands for "checking
> out a branch" and "checking out paths" that is done by this step
> would help users to form the right mental model.

Since the other one is already "checkout-files", maybe this one could
just be "checkout-branch".

> So I tend to think
> these two are "training wheels", and suspect that once they got it,
> nobody will become "sick of" the single "checkout" command that can
> be used to do either.  It's just the matter of being aware what can
> be done (which requires the right mental model) and how to tell Git
> what the user wants it do (two separate commands, operating mode
> option, or just the implied command line syntax---once the user
> knows what s/he is doing, these do not make that much a difference).

I would hope this becomes better defaults and being used 90% of time.
Even though I know "git checkout" quite well, it still bites me from
time to time. Having the right mental model is one thing. Having to
think a bit every time to write "git checkout" with the right syntax,
and whether you need "--" (that ambiguation problem can still bite you
from time to time), is frankly something I'd rather avoid.
--=20
Duy
