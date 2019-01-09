Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 995661F803
	for <e@80x24.org>; Wed,  9 Jan 2019 17:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfAIRVp (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 12:21:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41854 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfAIRVp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 12:21:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id a20so7941133edc.8
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 09:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DCiHvvvzFeTZnSLQTF8batMX45mMU/SgF1JfRPPv8A=;
        b=NAi+z+DkykU7c/MvCyoAH3qb1O0NTQxU+gFNtBOG7DSasDXWLw+JyX2JHj16jxQVY+
         wngOl4Sv9GQBFaz/grq1OaORSym0ruEYgjFPk056PrU6ohIikPWF3I99ZAzafKlX+6ID
         XT1oXeMEorL0qHYJo4IG2NdBd7vMv+2jRHpuBzB1f+FL/3NAR8orX/eOQzenY+n7EyZh
         0duCY3yfozTJX9dU+lK6v5+l4eD0gROkKy/YRXrvMxOj20GkhBKzRtsijAf8Pp3YeZff
         ac1+LzMot9sfjGvBmT3heYTTEqn3efO0tGuzOfsMErWijAivDbLMmaEbqQgB4KhA7i0k
         iDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DCiHvvvzFeTZnSLQTF8batMX45mMU/SgF1JfRPPv8A=;
        b=Xh8az4X5TFuo2vFILsQZLjfb8wN3D3BUDKFOZr3O88VN+KmFIa44eggh3XxeE45D+E
         ZeUF3vMzU0MxEfQiZHw6xK6zTdxZAYgwkV9PbFsGOEMOX/f5Gqg5w0PAHsUjlg/tAzCP
         Xbc5879Ez+9qXKCNEQYAu5j9O3asbchNzvpCmuzVkwHpE4tge5jejxXw08/XCqXpqzSr
         rTpZQdZYgAcn+FBrqqAGPQdAZd2GvA9T3uHVjDVrIvA+MGXn5YMdJ3zEMonaYLrSm+BF
         Mm1rwZA9Y8w6Fp9QrMII6m12HejbqDUzRWPO9RqRJo4YVAtYE5dZ0bW9w/r+TB36SE/f
         eISQ==
X-Gm-Message-State: AJcUukcZxV1O35UsZzDfmGQyjXlSTxKjyxuz32eC9qrT/x9qxpetgbux
        yKQJWkjnuMwSBHTrxDhzKALY0eBENqVzFZIk44i1RA==
X-Google-Smtp-Source: ALg8bN5bEB1bqGttvMfj4UTEyw0acgn5AQivKww8/tCHS2+on6RoS3+Kz1TFqdGqy0P7dbleL0LHe1FXw5V+ezwoyNs=
X-Received: by 2002:a17:906:dda:: with SMTP id p26-v6mr6144982eji.6.1547054503243;
 Wed, 09 Jan 2019 09:21:43 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg0NUNFjZumgC-9f=kmU3L4T+qOAgXwiDAfPaNtuFfvFg@mail.gmail.com>
In-Reply-To: <CAHk-=wg0NUNFjZumgC-9f=kmU3L4T+qOAgXwiDAfPaNtuFfvFg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Jan 2019 09:21:31 -0800
Message-ID: <CAGZ79kaOcoVSRgTR+k9ENoDz6FHh27MzpZ9D-MeFArN2vgBK0w@mail.gmail.com>
Subject: Re: Make "git log --count" work like "git rev-list"
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio Hamano C <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 5, 2019 at 2:47 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This is a ridiculous patch. And I understand entirely if nobody else
> cares, because I don't think anybody else has ever even noticed.
>
> It turns out that I still use "git rev-list" outside of some hard-core
> scripting for one silly reason: the linux-next statistics are all
> about non-merge commits, and so to do a rough comparison with
> linux-next, I do
>
>         git rev-list --count --no-merges v4.20..
>
> to get an approximate idea of how much I've merged compared to what is
> in linux-next.
>
> (See also
>
>         http://neuling.org/linux-next-size.html
>
> for the graphical view of it all, even though it looks a bit odd right
> now because of how linux-next wasn't being updated over the holidats
> and right at the 4.19 release).
>
> Anyway, I've occasionally thought to myself that I should just fix
> "git log" to learn that too, so that I wouldn't have to type out "git
> rev-list". Because "git log" does actually take the "--count"
> argument, it just doesn't honor it.
>
> This is that patch.

Sounds reasonable to me to have such functionality,
as I tend to use
  git log --oneline origin/master..origin/next --no-merges |wc -l
for such queries, which I always assume to be doing useless
work as I'd be interested in *only* the count, and not the
intermediate oneline output, but that is the best output
that wc works on.

So maybe the --count option would want to suppress
other output if given (or we'd want to have another option
for no output)?

Instead of printing, do we want to redirect to
rev->diffopt.file, or send it through the diff codes
buffer if we ever anticipate needing this output in
buffered?

A test would be nice, too.

Stefan
