Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F46C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 17:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjELR0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 13:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjELR0n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 13:26:43 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F574205
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:26:42 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-643a18db9efso5403025b3a.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683912401; x=1686504401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUPGVw3nVAjzYjF0aKcKR6NcqjA+uND0Z26/0Bn4StM=;
        b=ql6YdB1Rwy8+Og89rL7AkmHw+Hi2D5rIrp0tqSuW9F+Gi7RIr87y7sE7oG0dM5Hzr6
         RDhy9ehC7tQsbYM83R33Q4pHuwVquhks3Iir4kVndSaQxs9fxVwxrjW7V34ZXYT67mc4
         aK/kt3s96t3ZYHLO8mROY1xZTA3M4RDAHBCaL5EcssRRuY04U1d6pNegoxwb25w3hlzg
         6rTkk/br/nPNMmKcUoBZ5La1HDnd5gMk1b6OxDJ3X6wbDdu6bOJ8jA6X3s61SfdIHXY1
         o+sLeqKUVJZJYMYORgpeOPFzPbKG0KfY2ZgdIhdQvmB1chC+bDHCl57NybIxrZ60++WO
         Qm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683912401; x=1686504401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUPGVw3nVAjzYjF0aKcKR6NcqjA+uND0Z26/0Bn4StM=;
        b=KsYcr2a1Osj6tbzdJJmuA4vDhlYajIWrK83DQyyXvXrJ/jafMCO+9zwy532j/rYiUS
         QSV0Iu/4K/NSuIFpVEWyKS+ZX2Cc5lkcLgEZAhHJPYLDJFxVa6id95T+xG8+iEkr7QmU
         0lFzj9sQxDq9JoVHvp4lBPMM5thE/YWkOcfG5AR6g55LN9jJT4p1MnBgN+iHE9l9Jthi
         bQduvEwuGdKWrwIlq7ufF8ujnkxM8CA7OiknBFSeRZ66lcD5Af0fubAuLPpYL7N3wbw5
         ckDHhCPwTnigUgFnPSPG5omqJRfqiLBWK1rY8Ap32JaxqKsZx7LXS7TUgF73YfEpSBwD
         r+tQ==
X-Gm-Message-State: AC+VfDwwtJX48+Jpjyl5tlHx9Svlbfrv4SjFxfEyO3MNG0kCvS8Ykkkf
        4R7eRuG327tbcOP8GxnQvBM9miIJRQw74A==
X-Google-Smtp-Source: ACHHUZ4FpllsdIf7k9LPa3gooVIMEevb63dmLozB9nSa/AA27Mlx+rUpSeJ7TY74NX+2gsBUbw2slvnYEmMIDw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:cec1:b0:1a9:3c2d:65ec with SMTP
 id d1-20020a170902cec100b001a93c2d65ecmr8430086plg.13.1683912401413; Fri, 12
 May 2023 10:26:41 -0700 (PDT)
Date:   Fri, 12 May 2023 10:26:31 -0700
In-Reply-To: <CABPp-BFT_aAmMcD7HKVuaZR3kkGND1mBF3R8OvisHimYWiX48g@mail.gmail.com>
Mime-Version: 1.0
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
 <12a251f77f679123d01892109694f8ee19b96252.1683431151.git.gitgitgadget@gmail.com>
 <kl6lsfc2zjje.fsf@chooglen-macbookpro.roam.corp.google.com> <CABPp-BFT_aAmMcD7HKVuaZR3kkGND1mBF3R8OvisHimYWiX48g@mail.gmail.com>
Message-ID: <kl6la5y9zcjc.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 01/24] init-db: remove unnecessary global variable &
 document existing bug
From:   Glen Choo <chooglen@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the response. I realized where my misunderstanding was.

Once again reordering slightly..

Elijah Newren <newren@gmail.com> writes:

>> Where I struggling with is how to make this behave badly. The lines
>> above seem to be defensive in nature - we never use
>> is_bare_repository_cfg past this point, but we want to guard against
>> unintentional behavior in the future.
>
> Not quite true; there is another call to is_bare_repository() in the
> same function about 60 lines later, which does pay attention to
> is_bare_repository_cfg.

Ah thanks. I didn't realize that the "is_bare_repository_cfg" that holds
the value of the CLI option is actually the global variable that also
stores cached value of "core.bare" (I thought it was a local variable).

This may not be in scope for your series, but if we want to preserve the
CLI option like we say we do...

>> Now, we're in the midst of the re-init. Expanding the context a little,
>> we see:
>>
>>         git_config(git_default_config, NULL);
>>
>>         /*
>>          * We must make sure command-line options continue to override any
>>          * values we might have just re-read from the config.
>>          */
>>         is_bare_repository_cfg = init_is_bare_repository || !work_tree;
>>
>> So now we've read the new config of the re-inited repo, which might have
>> "core.bare" set to a value other than what "git init-db [--bare]"
>> started with
>
> Correct.
>
>> so we want to _intentionally_ ignore it.
>
> That's what the code does, but not what it should do.  If neither
> `--bare` nor `--no-bare` is given on the command line, we ought to pay
> attention to the config setting.
>
> The fact that we do ignore the config regardless of command line flags
> is the bug that this patch documents.

wouldn't be a lot easier to parse the option into a local variable
instead of reusing the config one? Then we always have the original CLI
value available to us and can restore it back to
"is_bare_repository_cfg" if we really wanted to.

I'm not sure if this means we can/should drop the "|| !work_tree" in the
hunk above. It would nice if we could, I find it very confusing.

> So, both before and after what we are computing simplifies to
>    <something> && !work_tree || !work_tree
> which further simplifies, regardless of whether <something> is true or
> false, down to
>    !work_tree
>
> So whether we are using a cached value of is_bare_repository_cfg or a
> current value of is_bare_repository_cfg is irrelevant.  In fact, from
> the analysis above, we can simplify this line to just
>    is_bare_repository_cfg = !work_tree;
> completely ignoring both is_bare_repository_cfg and
> is_bare_repository(), and it won't change the behavior.  I just did
> it; it passes all tests.

Hm.. that doesn't sound intended, and fixing this is probably isn't in
scope for this series either.

>> If I'm right (which I'm not sure about), we might need to keep
>> init_is_bare_repository around _somewhere_. Not a global, but maybe
>> as a param.
>
> This makes sense, despite the other bugs present.  I'll make this
> change, as well as split this patch into two as Calvin suggested, and
> update the description to correct my errors and explain the bug
> better.

Yeah, I think this might be the smallest obviously correct thing. We can
clean up all of the other bits outside of a big refactor series.
