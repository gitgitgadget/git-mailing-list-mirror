Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65BB41F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 06:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbcJDGwV (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 02:52:21 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33665 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbcJDGwU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 02:52:20 -0400
Received: by mail-yb0-f196.google.com with SMTP id e2so4163500ybi.0
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 23:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zibmR1pjQXcgl7WEWIulTBtY+8gJu6zQ3FnZQupdLS0=;
        b=PzlPA31PhOCMxy9sMfgeg/3R/ga72pLW0q/rLUBmJSUBEKO+0MoRaoRYkNXImv49Nw
         B/hIfX72ARY4VW81/MrjIuhWQQyOVmCX9qezkWAzhoaPbznp+lw/ad0PgeHGxB6ZF9qh
         DdOk2E5bEGcUWZctlUZqCWIXDhqNSUeSDwkmk4PHZcWAmipdjisA3JqS6ruaJRTA9eHn
         /CI4Pb9MekqlRdcKxiL7i6EWh3Eo7QD95qCHvqTsSo6Y+xFtj+bx43+HIIM9ZibMFXlK
         Xe3fUyUriJKdUYT6HCgnnJiuHMxykNQsh18fgNx0Nr0/yAj37+WCsiC1+8Te/6SUsNNk
         3H4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zibmR1pjQXcgl7WEWIulTBtY+8gJu6zQ3FnZQupdLS0=;
        b=HfC/L20TFGmgwvfE27/oM1iXI49EwHQs7ulvcBMoMhHaBbQQ6j3QlAosx2eS6yLC12
         7J38s9uNeMmqhTzmfn6KSMA9nhD9Af8JvsDhjVLlZFchELJ9sI0C8doSSgST3dJpQTGQ
         lWj/tZe/qflrXeW2OrWzqtIx/ybcqT+08kiyt1yYFOUQzpVuM8vU0hGOr8NYPFrV66E7
         UiRY7mAXQbRS1i0KwCNfAwbs4M6N1S8YdWKZ5Z1knbIyo2NhPY4rAWxTlGpVA5abIAEh
         YlLbmRWyKltVBfwVUfUK/Bzr5CkXWa0e8x04ZOx4eZ9mXSP+b0d9zk+DSQfmyu+dQ8OR
         cFbQ==
X-Gm-Message-State: AA6/9RnRCdy4e+NsabwcPleLxIeLAoJJLFidcDWYOPzvkID2pm6APzsUIfgAZKJ39XJU2C2FCxfDmdDk+amOLg==
X-Received: by 10.37.174.1 with SMTP id a1mr1508541ybj.6.1475563939852; Mon,
 03 Oct 2016 23:52:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 23:51:59 -0700 (PDT)
In-Reply-To: <20161003203626.styj2vwcmgwnpx4v@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203626.styj2vwcmgwnpx4v@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 23:51:59 -0700
Message-ID: <CA+P7+xqhuYmp-H=b-SrNdZjN5urWGHPuNkWbeVgCBF1UuhQZKQ@mail.gmail.com>
Subject: Re: [PATCH 18/18] alternates: use fspathcmp to detect duplicates
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:36 PM, Jeff King <peff@peff.net> wrote:
> On a case-insensitive filesystem, we should realize that
> "a/objects" and "A/objects" are the same path. We already
> use fspathcmp() to check against the main object directory,
> but until recently we couldn't use it for comparing against
> other alternates (because their paths were not
> NUL-terminated strings). But now we can, so let's do so.
>

Yep, makes sense.

> Note that we also need to adjust count-objects to load the
> config, so that it can see the setting of core.ignorecase
> (this is required by the test, but is also a general bugfix
> for users of count-objects).

Also makes sense.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/count-objects.c   |  2 ++
>  sha1_file.c               |  2 +-
>  t/t5613-info-alternate.sh | 17 +++++++++++++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/count-objects.c b/builtin/count-objects.c
> index a700409..a04b4f2 100644
> --- a/builtin/count-objects.c
> +++ b/builtin/count-objects.c
> @@ -97,6 +97,8 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
>                 OPT_END(),
>         };
>
> +       git_config(git_default_config, NULL);
> +
>         argc = parse_options(argc, argv, prefix, opts, count_objects_usage, 0);
>         /* we do not take arguments other than flags for now */
>         if (argc)
> diff --git a/sha1_file.c b/sha1_file.c
> index b514167..b05ec9c 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -260,7 +260,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
>          * thing twice, or object directory itself.
>          */
>         for (alt = alt_odb_list; alt; alt = alt->next) {
> -               if (!strcmp(path->buf, alt->path))
> +               if (!fspathcmp(path->buf, alt->path))
>                         return 0;
>         }
>         if (!fspathcmp(path->buf, normalized_objdir))
> diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
> index 76525a0..926fe14 100755
> --- a/t/t5613-info-alternate.sh
> +++ b/t/t5613-info-alternate.sh
> @@ -116,4 +116,21 @@ test_expect_success 'relative duplicates are eliminated' '
>         test_cmp expect actual.alternates
>  '
>
> +test_expect_success CASE_INSENSITIVE_FS 'dup finding can be case-insensitive' '
> +       git init --bare insensitive.git &&
> +       # the previous entry for "A" will have used uppercase
> +       cat >insensitive.git/objects/info/alternates <<-\EOF &&
> +       ../../C/.git/objects
> +       ../../a/.git/objects
> +       EOF
> +       cat >expect <<-EOF &&
> +       alternate: $(pwd)/C/.git/objects
> +       alternate: $(pwd)/B/.git/objects
> +       alternate: $(pwd)/A/.git/objects
> +       EOF
> +       git -C insensitive.git count-objects -v >actual &&
> +       grep ^alternate: actual >actual.alternates &&
> +       test_cmp expect actual.alternates
> +'
> +
>  test_done
> --
> 2.10.0.618.g82cc264
