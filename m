Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDB5120A40
	for <e@80x24.org>; Tue,  5 Dec 2017 23:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752965AbdLEXOD (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 18:14:03 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:45629 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752768AbdLEXOC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 18:14:02 -0500
Received: by mail-qt0-f170.google.com with SMTP id g10so4819679qtj.12
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 15:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mqYTPFlM9Wam47IMX2E7cXA5WMUDAlfn2btXJxW5EaE=;
        b=R1GC//E5PD1mmvZrJnC5jfEXFvag51xv5HqbTgaI6PyW7LihhmibIrB27UM17pbBr7
         leNOphu6ISeXU8+xpoc3blv+uVa+9EPQzbGLmqRWJrKZ/TJBjyTl5ZBqya9wFX05WwCl
         cKw5nJ+j4igo+eU0unyx+wwAMfJ1eKHmfpWnmJNe3aBsro4GNgZjoa7JF/vjUji1vhqB
         PlIYAxNAATPDcWomww0OMf9S7eBQJCq4KtFOIKDLjvi5C4DHqRcabJkCXiwmZ++gjZ6F
         +3feQcKQ4nR/lFkgf0G2gArTeMzo64iwKvGcz0ua4E7QGhPkpcXUEfEqdyOhCsTTx/tp
         ZPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mqYTPFlM9Wam47IMX2E7cXA5WMUDAlfn2btXJxW5EaE=;
        b=shxmMM0nd/qUCtpRCD1aegvy9rUxIiUmaFx3ccGBUKGipWcvfNxxFjJWrSq1OFPD0o
         IkbWqVFRtfVRHow7stAklUzQ9bt0wDubOoboe1EQ5x1kW5lNXnzKlzl/7ujgNn37iVUI
         B870g5Ujwi8SnWswsYFa0KhmE4P1i35CU1YaGy4qYEzMbgxIO849levKCsSbxrKOdvnk
         3NQfR8gzalacE6dMK2ZSj224/gqA3+lpxHL/l1+x3kiWdC8CLRSuctEyp1pQm4XvQXvY
         6KTPJuaFjQ70GaDoIQEoJtO6IsOuM2ywpL7sNdG8HjSpWsca5CGveUCXsnU8RKJxye7e
         269Q==
X-Gm-Message-State: AKGB3mKH1no64+bhAsFUXO8XSWlogJo2oVS0cq93F6BUd9BamNM7OmuM
        7KTkQ0izUGvlnVB9wJtxZefwA+ZrqsDcy2IjC1eUyg==
X-Google-Smtp-Source: AGs4zMYpjefiFvxi/QSwEMykIrVe/xFOYwPzaadnyvTUA3C1sjUZ2nVZYYFl4lZR879eudb83kNfc2QzYup2dSVrL98=
X-Received: by 10.200.6.130 with SMTP id f2mr3183472qth.140.1512515641331;
 Tue, 05 Dec 2017 15:14:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 5 Dec 2017 15:14:00 -0800 (PST)
In-Reply-To: <20171205221337.140548-1-bmwill@google.com>
References: <20171205194801.GA31721@megas.kitware.com> <20171205221337.140548-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 5 Dec 2017 15:14:00 -0800
Message-ID: <CAGZ79kbvkopatFZi64Hxoa=wX6CJxJw6V+9RnQqrx6gTBL-78w@mail.gmail.com>
Subject: Re: [PATCH] diff-tree: read the index so attribute checks work in
 bare repositories
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, ben.boeckel@kitware.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 5, 2017 at 2:13 PM, Brandon Williams <bmwill@google.com> wrote:
> A regression was introduced in 557a5998d (submodule: remove
> gitmodules_config, 2017-08-03) to how attribute processing was handled
> in bare repositories when running the diff-tree command.
>
> By default the attribute system will first try to read ".gitattribute"
> files from the working tree and then falls back to reading them from the
> index if there isn't a copy checked out in the worktree.  Prior to
> 557a5998d the index was read as a side effect of the call to
> 'gitmodules_config()' which ensured that the index was already populated
> before entering the attribute subsystem.
>
> Since the call to 'gitmodules_config()' was removed the index is no
> longer being read so when the attribute system tries to read from the
> in-memory index it doesn't find any ".gitattribute" entries effectively
> ignoring any configured attributes.
>
> Fix this by explicitly reading the index during the setup of diff-tree.
>
> Reported-by: Ben Boeckel <ben.boeckel@kitware.com>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>
> This patch should fix the regression.  Let me know if it doesn't solve the
> issue and I'll investigate some more.
>

Thanks for fixing this bug! The commit message is helpful
to understand how this bug could slip in!

> diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> index d66499909..cfe7d0281 100644
> --- a/builtin/diff-tree.c
> +++ b/builtin/diff-tree.c
> @@ -110,6 +110,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
>
>         git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
>         init_revisions(opt, prefix);
> +       read_cache();


Although we do have very few unchecked calls to read_cache, I'd suggest
to avoid spreading them. Most of the read_cache calls are guarded via:

    if (read_cache() < 0)
        die(_("index file corrupt"));

I wonder if this hints at a bad API, and we'd rather have read_cache
die() on errors, and the few callers that try to get out of trouble might
need to use read_cache_gently() instead.
(While this potentially large refactoring may be deferred, I'd ask for
an if at least)

Thanks,
Stefan
