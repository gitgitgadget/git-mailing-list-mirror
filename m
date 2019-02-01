Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 825CC1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 22:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfBAW2B (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 17:28:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38688 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfBAW2B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 17:28:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so9497635qtl.5
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 14:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6fJ6h+pNqsMZ3nAOT15oJDp269r5HFgjVednFkK5N0=;
        b=eNZ4a2oi/PEtYrjs+KWHKeoSlrxcoHZqV52Ql1b++q+x9v+3UsAyWBHBwENKhedGKs
         SjYZgx0UoQkEoY+rFlYckKbZoQGN6+75qpDDY/yLQgFctM8II3BeM16LnFaSEsUAzNYy
         anfidB6bAB7n9qyGASKLNpqFSAMufs7NwSMUbK4Eth4OD3Oatl+24cOH1t06rCqHZO20
         hi+t+G7KrIYm8GXgDv5tJ7EBd9cYHOB2bM3r8czn9gAr+KmcA+bwedIOn+8VJufBrdgd
         PkoUdSoAeYE6H9sN2Bd4wWFFbskmJPzAU9JVfGkcJPDU5XBS9b4SXZwd5Kn+wplwesPI
         xWtw==
X-Gm-Message-State: AJcUukdvpO8e+t13Mxcs7OR5xIkIPa1Lh5r/NHh6T7TWTPsB2Qa7QcGP
        00ANdGvPwZ8xX6+ED3oQvropSWvJtwrI0LUqz3g=
X-Google-Smtp-Source: ALg8bN74BXicUqfVrMieBdIezGe8mla9nZHbZ4Shc+lhVFng4/o7d6MHxOCF+yTt03nQ+bIPFqN4VanmafC/dLWTg7c=
X-Received: by 2002:ac8:27c8:: with SMTP id x8mr39823301qtx.352.1549060080007;
 Fri, 01 Feb 2019 14:28:00 -0800 (PST)
MIME-Version: 1.0
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190201220420.36216-1-nbelakovski@gmail.com> <20190201220420.36216-4-nbelakovski@gmail.com>
In-Reply-To: <20190201220420.36216-4-nbelakovski@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Feb 2019 17:27:48 -0500
Message-ID: <CAPig+cT0OY3vcjjoMUjaZ9JhJ2nKqyqbv4qL1ExiDw3h5GUw4Q@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] branch: Add an extra verbose output displaying
 worktree path for refs checked out in a linked worktree
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Rafael Ascensao <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 5:04 PM <nbelakovski@gmail.com> wrote:
> Subject: branch: Add an extra verbose output displaying worktree path for refs checked out in a linked worktree

Overlong subject. Perhaps shorten it to:

    branch: display worktree path in -v -v mode

or something, and use the longer description as the rest of the body
of the commit message.

> Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
> ---
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> @@ -167,8 +167,10 @@ This option is only applicable in non-verbose mode.
>         When in list mode,
>         show sha1 and commit subject line for each head, along with
>         relationship to upstream branch (if any). If given twice, print
> -       the name of the upstream branch, as well (see also `git remote
> -       show <remote>`).
> +       the path of the linked worktree, if applicable (not applicable
> +       for main worktree since user's path will already be in main
> +       worktree) and the name of the upstream branch, as well (see also
> +       `git remote show <remote>`).

I'm not sure I understand the "not applicable" explanation. When you
say "user's path", do you mean the current working directory? What
happens if the command is invoked from within one of the linked
worktrees (not from within the main worktree)?
