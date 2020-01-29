Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CB4C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 23:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB2120702
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 23:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDRL2R4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgA2XDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:03:47 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:33404 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgA2XDr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 18:03:47 -0500
Received: by mail-vs1-f66.google.com with SMTP id n27so964224vsa.0
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 15:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1zrKGTxplRcj9NRo4nfdwGOrIcr9Ra/ROH/VIOPaoE=;
        b=PDRL2R4vRAJqxVeKdORPpAp+bj84kVFNE9wppVqMeAPUhZosZuGD3xznEo3/BjTeov
         hY5cynVSjwRfXNBIi/uZVoY+nkOouMdtseP+Q//jmmvcH4P3tfXQMw7QY2rqrTrzLrT+
         bHWuJCR0Q5BGHBAZXGXOcg4GslealHLir4jcvO7pYcczc+ukDnKMfIofX26sEd7HPVN2
         Uxv0vL43t14FD95Fnh9T961eu4i0/h9wgpO+UEC0hibSQZjGmCRp+6Ow7yEDPxvlTfV2
         8ItDZt6M1oerCzotgPcJH6hks8XJ23MEdq59/7XiizNsJazPGBySawIpSCvlijwGJwOe
         i37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1zrKGTxplRcj9NRo4nfdwGOrIcr9Ra/ROH/VIOPaoE=;
        b=SQlK+++Fdb9mup3OysZ+lsSfTqjVTAFoLl9X94016flH/i3ghB0Djqv4jrWIxMK/0C
         FnyPnw2hDNQYThsGEeAM7Al34nBvCHKSuzF8BdCIXGdwpmdHzBOp6evze8YNCGjKT2tQ
         T0gmNf4S9m6jeyq82R7uAcR674+Kk8RA0NC9Q/Y37MYnUqSXRWjkdSYhIjPyN4zMj3x6
         zyMIOIZ8i3H4EpPj8cgUIeiXClkd4+f5NmwLtZmW5JDgHxgwexWoJvemYdQG/zSDy2nI
         GUUpm3cZ9zAlV6B+ZzM6vS+AeH5rqzYZ09QiKcW3peb0P/C50sEsZC+cqQSYVoQFVPku
         aVHw==
X-Gm-Message-State: APjAAAVqFDYcFO8Fy+R3cnkWXbji7k0Mu3F5wni/LnIx4dd5qhcE3q4M
        W9atcLlP+auX8MQRL+hp9rIuN9tAOdemoaCvmPo=
X-Google-Smtp-Source: APXvYqzKeLpQnJtqbiFIX05otZllZfLxpw0D4lEz1BYCE/KKYH7+4OcK5beouhxSZ6CKTH013pLD4P3YJ7RNNlvXOyw=
X-Received: by 2002:a67:7943:: with SMTP id u64mr1393595vsc.91.1580339026585;
 Wed, 29 Jan 2020 15:03:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.478.v5.git.1579912764.gitgitgadget@gmail.com>
 <pull.478.v6.git.1580268865.gitgitgadget@gmail.com> <fc141e86896edb4241e84cc300e191889a3fa4ea.1580268865.git.gitgitgadget@gmail.com>
 <8ede2f21-46a8-b95f-6425-c0ee54abdad6@googlemail.com>
In-Reply-To: <8ede2f21-46a8-b95f-6425-c0ee54abdad6@googlemail.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Wed, 29 Jan 2020 18:03:34 -0500
Message-ID: <CAOjrSZtx+Qr4HsaptaxseTa_8oCwRyVE+Jf95_z51fGmXBjsTQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] config: add '--show-scope' to print the scope of a
 config value
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> for clarity, I think this patch should be split up further.
>
> For example:
>
>   - moving an enum and adding a new entry should be avoided

As far as adding a new entry, that could probably be done in a separate patch.
The submodule scoping is correct (mostly so config options that come from
submodule blobs have a sane value to set the new scope field of
git_config_source), but moving it is unavoidable as I'd either have to move
config_scope or git_config_source for this patch to work, and moving
git_config_source seemed like a ton more work

>   - does the changes to '/config.c' fix something?

Another thing, that in hindsight could probably be split out. The other changes
do fix the fact that previously recursive calls to do_git_config_sequence()
would blow awway the current_parsing_scope information for higher level callers.
This is not super common, but does occur when --show-scope is used with the
--blob option.

>   - exposing config_scope_name should have been done before PATCH 4/6 already

If that's better/more convenient, I don't have a problem breaking that
out and moving
it there.


-- 
Matthew Rogers
