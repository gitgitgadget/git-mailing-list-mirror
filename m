Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 318621F453
	for <e@80x24.org>; Fri, 21 Sep 2018 19:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391228AbeIVBNZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 21:13:25 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40669 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbeIVBNY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 21:13:24 -0400
Received: by mail-yw1-f65.google.com with SMTP id z143-v6so5621694ywa.7
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 12:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mo6l2T9oGSb4lL4ZTlNIEpmIDX8lSG9SVwUgxEasMnM=;
        b=fuBjGuoF/xbmuDZ1Wh7aSSPLqgSHk+K98bkxIREQtSxBN3UpA+uMmdPhCr5mu1E5S8
         8rp9dDVBZhq9mNqLiUIKgGqdsF6BRjkiRgKRelq4YasyuinyUDSx9E2OQ+droz85l+hG
         DM5uceR+t/d+0DESKscxjEXuy3XzFCqq6WBwUZw2yHZ9EQnarv6rlYSAFEMHl3cOa9gi
         XUTGnnwMAXvXg7vpBqG/lh5L1Cy4ar4gzTY4TNf4l/mugdC41b5Kdi5GJnDkZU4Kaq3l
         bjmq4KlhC1svt3fjZPsZhXYQHOiQ/Kq7WK+2w27UHv9GiFrFjZzpH4ukuxWU3n17mLn7
         gaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mo6l2T9oGSb4lL4ZTlNIEpmIDX8lSG9SVwUgxEasMnM=;
        b=Fr3/SGQpLkVgffEVfvZ6M8qDzDgygFZ1DwZbmPILVI5KqBIGDuSqOkh5Pr45pvK0to
         3SOK64sfgnXIS0XwvQdpSaqN5X/WNP7ZBXVuYWt9bnA7J82HzxoB3DTp6myWxuveAx/5
         bG1j6Pf/Z6QRCGHAvaGx0md3qx50Sju8NoGXQuMna9+8LiTdfKCKMyFc8f9WEIuKdCtl
         4sa4AJjLOU7h2fkSX7caxpghqACe6v2bSFLki17okc1zzha8S7gzK0heZfzOci9PQgmj
         qW9zfwJm+wnsS47w5ZvBQhok6ZFMlVJf8bEbRRwZNnNb3oHjhKsThJY33Wk19kljCNh8
         55gA==
X-Gm-Message-State: APzg51ChyO7rm8s/YGKO/LlXjmJXyW0jIvF0wOi9nj8ZWo/ozzXoHc6j
        XdQyveVda/vYN0LRpZqwZ/ak+IyNLfl+WvVtJTGg4zFJAv9RVg==
X-Google-Smtp-Source: ANB0Vdax5Rcr+kxRBXIf5dAe7VD36MQasVNdLs3bmxAYwD7bxFtzfA0paPOct3wlAegsq+FvEIPGyNdZMQH+CePPNU8=
X-Received: by 2002:a81:5855:: with SMTP id m82-v6mr20186514ywb.300.1537557787066;
 Fri, 21 Sep 2018 12:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180921185149.8670-1-marcnarc@xiplink.com>
In-Reply-To: <20180921185149.8670-1-marcnarc@xiplink.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 21 Sep 2018 12:22:55 -0700
Message-ID: <CAGZ79kabCTD9uvw+GPXxJGf8BfiqvMkhkA4Up8gC_kXjdv-o8g@mail.gmail.com>
Subject: Re: [PATCH] fetch: Ensure that fetch.recurseSubmodules overrides submodule.recurse.
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 12:00 PM Marc Branchaud <marcnarc@xiplink.com> wrote:
>
> Also document this fact.
>
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
>
> I ran into this bug when I had both fetch.recurseSubmodules=on-demand and
> submodule.recurse=true, and submodule.recurse was set *after*
> fetch.recurseSubmodules in my config.
>
> The fix ensures that fetch.recurseSubmodules always overrides
> submodule.recurse.  If neither is set then fetch still behaves as if
> fetch.recurseSubmodules=on-demand (the documented default).

At least the second paragraph is valuable information in the commit
message, so maybe add it there? I am not sure if the first paragraph is
a good part for the commit message, but maybe helps for writing a test?

> +       reference.  This option overrides the more general submodule.recurse
> +       option, for the `fetch` command.
>
>  fetch.fsckObjects::
>         If it is set to true, git-fetch-pack will check all fetched
> @@ -3465,7 +3466,8 @@ submodule.active::
>  submodule.recurse::
>         Specifies if commands recurse into submodules by default. This
>         applies to all commands that have a `--recurse-submodules` option,
> -       except `clone`.
> +       except `clone`.  Also, the `fetch` command's behaviour can be specified
> +       independently with the fetch.recurseSubmodules option.

There is also push.recurseSubmodules, which should behave similarly?

The series that introduced submodule.recurse ends with 58f4203e7db
(builtin/fetch.c: respect 'submodule.recurse' option, 2017-05-31)
(sb/submodule-blanket-recursive)
seems to have overlooked this only for fetch/push, as the other
commands (checkout, read-tree, reset, grep) do not have their
own specific setting to recurse.


> @@ -88,6 +90,7 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
>                 max_children = parse_submodule_fetchjobs(k, v);
>                 return 0;
>         } else if (!strcmp(k, "fetch.recursesubmodules")) {
> +               recurse_submodules_set_explicitly = 1;

the command line option also overried explicitely, but that
is ensured via the program flow (parse_config happens after
git_config to overlay options, which itself was pre-seeded
with fetch_config_from_gitmodules).

I briefly wondered if this overlaying approach would be better
(i.e. first do git_config with more generic option, and then
again with the more detailed option) as it would save one
global variable, but the downsides are terrible (way more
work to do, more code and such), so I think having a global
makes sense and gets the job done.

Ideally instead of a global we'd have this flag stored in
the repository struct, as eventually in the long run,
fetch_populated_submodules could happen in-process
instead of spawning fetch processes for each submodule
(and their nested submodules which may be configured
differently). But for now the global will do.

Thanks!
Stefan
