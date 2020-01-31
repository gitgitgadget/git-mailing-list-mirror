Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D205C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECDB20707
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRE6Kgu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgAaSwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:52:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37700 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgAaSwo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 13:52:44 -0500
Received: by mail-ot1-f65.google.com with SMTP id d3so7559808otp.4
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 10:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g3a2DzlihIpYcKqzqAjkF0uZ/auYHImt9bIk7kNLCbw=;
        b=YRE6Kgu03+kEm5V0pxpmAmIwL1dtqH08VQGixVP9xrZt2E6Eb/5L6CiKTx1g6Deai1
         kxCCAyzfwLc4iNqYDoNntPUb45ERTIdZ8uOh/a34qouQwdYvWUa8lidIW6MP0JBfjhln
         pS/cX9VROyhQpzUTSbA3Hsu1ytifDv4E0V92BcI3oethje39Axt1XQT8OUHfWdhYFyGr
         M4wA0pS6qCh9EwmZKaFX0nkP+VBm5w4wJQHzYu3839TvVq/Nt32y9fapxpRHmaUXO2AX
         1p4LxfTTCJuwZNlULac7Mom5nYIeJLhC7dAnJfSmtBcsUuSWqxW/OcPsveYye+Cfx2LQ
         lBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3a2DzlihIpYcKqzqAjkF0uZ/auYHImt9bIk7kNLCbw=;
        b=gkYyM8MC+XQ3UNOTcprfoT8xERfgiDdDe9+cuRtj6NYs+YPck4HFrz++3klLk0zin+
         WM1meWxzuoNuEoMeYdGG6nqfUyxxyXKAN69gJvqNl5oJYRWfa4rj4BWC114y8Cln4LqF
         B4oD7J1TKjNTwc8HKCuTaho63Kd38HYZEQAj95/gciR3uCjHWnoWUl7uw78KjolZ4e4X
         SKemsx3xYzQJZo72KMB7zyyZScyq6+ye1U4aD1EpdR0BW7+KJjIGiDoY2tD6itYzd5t4
         zsdqGJQoKZjs/BCJC3QdCEwe2kXbQQB6MvSwSYsXE/be1ISiYmmzwN+CqqxMEtGTI8nw
         nbyw==
X-Gm-Message-State: APjAAAVEUMcHd9rx/nAFoZQOnq2eY2q+kzJ6fFbSfOcfj6MNPmpxyfeR
        CoI9JSY0OtLTi+ATfbJ9kPbqbj27ukxo7pK1PvGvWw==
X-Google-Smtp-Source: APXvYqyTfl+VAoNKkmaOBJPgPbcz7oCfI+V+v9muq8KTm3lrc+nu3/ADe8Sw88s+Gq2hzzqkv6tpQK//Uo1EA6A4zu0=
X-Received: by 2002:a9d:7487:: with SMTP id t7mr8751976otk.267.1580496763788;
 Fri, 31 Jan 2020 10:52:43 -0800 (PST)
MIME-Version: 1.0
References: <20200130095155.GA839988@coredump.intra.peff.net>
 <20200130095338.GC840531@coredump.intra.peff.net> <CABPp-BE7E--8Yz3PAcjPQX2RCsbq0Q0gURi3RJuE64KM0eo6mA@mail.gmail.com>
 <20200131092936.GA2916051@coredump.intra.peff.net>
In-Reply-To: <20200131092936.GA2916051@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 31 Jan 2020 10:52:30 -0800
Message-ID: <CABPp-BFXwin5mR7z7Ocx9bq5LadFF4CxZR03HzZxh5f=1+F6NQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] traverse_trees(): use stack array for name entries
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 1:29 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jan 30, 2020 at 06:57:26AM -0800, Elijah Newren wrote:
>
> > > This does increase the coupling between tree-walk and unpack-trees a
> > > bit. I'd be OK just switching to ALLOC_ARRAY(), too. I doubt the
> > > performance improvement is measurable, and the cleanup free() calls are
> > > already there.
> >
> > Could we undo this cyclic dependency between tree-walk and
> > unpack-trees by defining MAX_TRAVERSE_TREES in tree-walk.h, making
> > MAX_UNPACK_TREES in unpack-trees.h be defined to MAX_TRAVERSE_TREES,
> > and remove the include of unpack-trees.h in tree-walk.c?
>
> I don't mind doing that, but I had a hard time trying to write a commit
> message. I.e., I can explain the current use of MAX_UNPACK_TREES here,
> or defining MAX_TRAVERSE_TREES as MAX_UNPACK_TREES by saying "this is an
> arbitrary limit, but it's the highest value any caller would use with
> us".
>
> But to define MAX_UNPACK_TREES in terms of MAX_TRAVERSE_TREES, I feel
> we've created a circular reasoning in the justification.

It may be circular in how it came about, but I don't see how it's
circular from first principles: unpack_trees() uses traverse_trees()
to do its work (whereas tree-walk.c shouldn't call any functions from
unpack-trees).  For simplicity and lacking any justification for huge
numbers of trees, we want to impose a small limit on both for how many
trees they can simultaneously operate on -- though we want to leave a
little wiggle room by generously setting the limit much higher than we
expect any caller to ever want.  unpack-trees certainly can't have a
higher limit than tree-walk, and we don't know of callers outside
unpack_trees that would want to traverse more trees than
unpack_trees() does, so we just set them both to the same value, 8.

> I'm not even sure whether the current value of 8 is meaningful. It comes
> from this commit:
>
>   commit ca885a4fe6444bed840295378848904106c87c85
>   Author: Junio C Hamano <gitster@pobox.com>
>   Date:   Thu Mar 13 22:07:18 2008 -0700
>
>       read-tree() and unpack_trees(): use consistent limit
>
>       read-tree -m can read up to MAX_TREES, which was arbitrarily set to 8 since
>       August 2007 (4 is needed to deal with 2 merge-base case).
>
>       However, the updated unpack_trees() code had an advertised limit of 4
>       (which it enforced).  In reality the code was prepared to take only 3
>       trees and giving 4 caused it to stomp on its stack.  Rename the MAX_TREES
>       constant to MAX_UNPACK_TREES, move it to the unpack-trees.h common header
>       file, and use it from both places to avoid future confusion.
>
> which kind of makes me wonder if we should just go back to calling it
> MAX_TREES. I guess that's too vague, though.
>
> So I dunno. It would be easy to do as you asked, but I'm not convinced
> it actually untangles anything meaningful.

As far as I can tell, before your change, we can remove the
   #include "unpack-trees.h"
from tree-walk.c; nothing uses it.  I do like snipping includes and
dependencies where they aren't necessary, and this one seems like one
that could be removed.

But, it's not a big deal; if you want to leave that for future work
for someone else (perhaps even asking me to turn my paragraph above
into a commit message that rips it out and defines one #define in
terms of the other), that's fine.
