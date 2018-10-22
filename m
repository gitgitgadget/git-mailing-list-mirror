Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE0B1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 21:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbeJWFfB (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 01:35:01 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35418 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbeJWFfB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 01:35:01 -0400
Received: by mail-qk1-f193.google.com with SMTP id v68-v6so26341203qka.2
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 14:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mddiQTg1XLHDB/5C7gPd5TJh9xdNa6egezY5AexHDFw=;
        b=Fk4Kmzk7LEs4vK3045Ogw5ZL3L++uQNNFjV8dMgC5rVzJt3z2lW1hsgNF/ISR2rKvH
         vgEypH3dFOWfifRd5YL0LDBz9JSNFDAA5L605kdNuI3tgF2dnvWRVwVpIHakwCISCocf
         5+a78tbVrNcc8Mg1xURzpeyMLb1AoFm8+dZNDH/ZoSbhdPl+i/NpD+5b9LmB3+cJR+dq
         DtVD3Ldhb+vYYXoVgkUgZi43GlI1FeXBqp6LZAqbXkski2dz65PMPS7MSYV6TOIDeRRf
         pnbWTorEJJA79XxmLBpf5arr16CyCazSr5NdX1wr0IPxghcYePVx+vybzvWUGz+WYa0+
         RRcg==
X-Gm-Message-State: ABuFfogITLA38l9Kwz96B0r2AVqvwpFY6O2nThPzl4ag5FdTj8CRJUzE
        yp+zdt2lkOSY7miPr5aqlR/isnmTcG3fbVW3A5w=
X-Google-Smtp-Source: ACcGV60StXIIw5J2i7Ny3cd0sJWkHaZfPGqjwyOlpIWWQOTOlOyWjP4mBnRn/JtD7h1S93jjxHFEOsafQWzypXwAI8c=
X-Received: by 2002:a37:9f90:: with SMTP id i138-v6mr43734023qke.152.1540242889395;
 Mon, 22 Oct 2018 14:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181022204546.20354-1-asheiduk@gmail.com> <20181022204546.20354-2-asheiduk@gmail.com>
In-Reply-To: <20181022204546.20354-2-asheiduk@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 22 Oct 2018 17:14:39 -0400
Message-ID: <CAPig+cTfrwMiYKcOZdiS-yTMCgYo1sfHLFCnX=hxaVyWNqUr8Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] doc: clarify boundaries of 'git worktree list --porcelain'
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 4:46 PM Andreas Heiduk <asheiduk@gmail.com> wrote:
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -270,8 +270,8 @@ Porcelain Format
>  The porcelain format has a line per attribute.  Attributes are listed with a
>  label and value separated by a single space.  Boolean attributes (like 'bare'
>  and 'detached') are listed as a label only, and are only present if and only
> -if the value is true.  An empty line indicates the end of a worktree.  For
> -example:
> +if the value is true.  The first attribute of a worktree is always `worktree`,
> +an empty line indicates the end of the record.  For example:

When I suggested the --porcelain option for "git worktree list" and
provided an example of its proposed output, the idea all along was
that the "worktree" line itself would indicate start-of-stanza. A
blank line between records is superfluous and unnecessary.
Unfortunately, by the time the implementation was posted with blank
line as stanza separator, I was not around to contest it, and it ended
up in a release, after which point it was too late to change it.

So, the tl;dr is that this documentation update agrees with the
original intention as I envisioned it (although I wouldn't be sad to
see the mention of "blank line" dropped altogether, but that's perhaps
a separate battle).
