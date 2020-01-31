Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F95AC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 19:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EAA2082E
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 19:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlCR4Kee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgAaTey (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 14:34:54 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38067 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgAaTey (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 14:34:54 -0500
Received: by mail-pj1-f68.google.com with SMTP id j17so3277606pjz.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 11:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKbjjIwFYgmGtlmaViYPLmFGPim2iBPGrof9oC8KEEo=;
        b=MlCR4Kee0UsnbjuDhFqtblwx6W+K0adn8VB2I3ngrQMgU71IoaKGiOj7a+weMRdICk
         OlC6gbWAoWsgTzKYmuKt8jrgdhjCUlCoLHhc+E6d8ffGvglNmh9pMrtVbbhcV7BYer1t
         K32vKycvAdzvUeNIECgjPsy9eBWd5CnIGjcdnneWslHsfGzQKlyqUavDeATO/iSmvYW4
         erA5TAw+p4XVzc6iNnPaMLd1fV9d76lby42xO0gOTHASer8ySEExvv1TEaDPcuzyvRUP
         hEMJeGJrPLZaZ8yQp4bTxOjauGUlo6I4HkKdhuIZWNluGY2BqVgKT0F6kMeRT6HxsiEH
         0uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKbjjIwFYgmGtlmaViYPLmFGPim2iBPGrof9oC8KEEo=;
        b=U2FSSK1NUhvntIXVyMrIQmZV90mge8vtpZ2Lc0woBSEyw059defNLt+3qeWmhwOlqa
         expGcWflKcrC/Df8E2oECEgfJNPIomYjQnlAlXGK6GvDE5wIMnkjBYbq/FPX0OWqmn1q
         X0S728+geJCtHej6/WozSu7gHHBtRpZRjL5lo4URKuZbsSLjpc3RmTDYZjjsrLLXufcx
         xkNL99svWC6Jn29y93GuaPsnZ/9Q3DULnbxiZjCDgB4pvkxLMD8wCymfqsSx4nW/WyCM
         /y16WrF8f0TIxda1y1VXOtKXxfQNxn3WfW21cqC6rUFawY4vKfJLElxdI/ctvb58DRbF
         zGYQ==
X-Gm-Message-State: APjAAAXLzF3h3pcsO729sNsEynWA/FORc29ghmgd3psLwce9Td0w+RYb
        riTlvitK9P5Mh62QT9jFqtCMM3vt4FOb18oeP/s=
X-Google-Smtp-Source: APXvYqzzE9xXWxrxaVkEfjqJ6L5iYFnhaJrkw3GhRi3Ytr2ZIEeBLK+uPYAMAbJvrxWTZsZbDzNIoZ6RwMoSKbrSdvY=
X-Received: by 2002:a17:90a:d985:: with SMTP id d5mr14738650pjv.73.1580499293312;
 Fri, 31 Jan 2020 11:34:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580430057.git.me@ttaylorr.com> <8effe35bcd1dadee3a29d996f269353cf6e4982d.1580430057.git.me@ttaylorr.com>
In-Reply-To: <8effe35bcd1dadee3a29d996f269353cf6e4982d.1580430057.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 31 Jan 2020 20:34:41 +0100
Message-ID: <CAN0heSqGe0HpAj+qoYkif4pyjaW5EBNsRce9OmxMaZXTSW7C9w@mail.gmail.com>
Subject: Re: [PATCH 2/3] builtin/commit-graph.c: introduce '--input=<source>'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 31 Jan 2020 at 01:30, Taylor Blau <me@ttaylorr.com> wrote:
> The 'write' mode of the 'commit-graph' supports input from a number of
> different sources: pack indexes over stdin, commits over stdin, commits
> reachable from all references, and so on. Each of these options are
> specified with a unique option: '--stdin-packs', '--stdin-commits', etc.
>
> Similar to our replacement of 'git config [--<type>]' with 'git config
> [--type=<type>]' (c.f., fb0dc3bac1 (builtin/config.c: support
> `--type=<type>` as preferred alias for `--<type>`, 2018-04-18)), softly
> deprecate '[--<input>]' in favor of '[--input=<source>]'.
>
> This makes it more clear to implement new options that are combinations
> of other options (such as, for example, "none", a combination of the old
> "--append" and a new sentinel to specify to _not_ look in other packs,
> which we will implement in a future patch).

Makes sense.

> Unfortunately, the new enumerated type is a bitfield, even though it
> makes much more sense as '0, 1, 2, ...'. Even though *almost* all
> options are pairwise exclusive, '--stdin-{packs,commits}' *is*
> compatible with '--append'. For this reason, use a bitfield.

> -With the `--append` option, include all commits that are present in the
> -existing commit-graph file.
> +With the `--input=append` option, include all commits that are present
> +in the existing commit-graph file.

Would it be too crazy to call this `--input=existing` instead, and have
it be the same as `--append`? I find that `--append` makes a lot of
sense (it's a mode we can turn on or off), whereas "input = append"
seems more odd.

From the next commit message, we learn that a long `--input=append`
triggers `fill_oids_from_all_packs()`, which wouldn't match my expecting
from "--input=existing". So...

Does this hint that we could leave `--append` alone? We'd have lots of
different inputs to choose from using `--input`, and an `--append` mode
on top of that. That would make your inputs truly mutually exclusive and
you don't need the bitfield anymore, as you mention above.  Hmm?

Would that mean that the falling back to `fill_oids_from_all_packs()`
would follow from "is there an --input?", as opposed to from "is there
an --input except --input=append?"?

(I don't know whether these inputs really *have* to be exclusive, or if
that's more of an implementation detail. That is, even without an
"append" input, might we one day be able to handle more inputs at once?
Maybe this is not the time to worry about that.)


Martin
