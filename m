Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9655C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE12218AC
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZSEUFmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgBFTlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:41:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44299 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBFTlk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 14:41:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id y5so3625831pfb.11
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 11:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFp3WKXDaQrUUsBREPKYVmuo8DnEYjuCYWnTkY8Ee8A=;
        b=cZSEUFmCl0hl3s9s7DrLIV/oU4kmI9ybvNpP0tuSDa+DdulgHq6tjkR8ILc0LOPGHC
         PYeFvN9RFUJsdiujp60/N3VppSoWsQkAOHwfxeBlVSxUGIBsNNHg4/sPPVpvuRpB7WSj
         hO8Ut/6EQLdWTku0hYVvfjT2L6HmYEaylIFe507Wx8ohAk+ug3msyyDfia/z1GGA33yS
         2bTxdPVeMTWASn76r93mi0RW2et3jYRy0dOVA1S5DXOdcbscYVVWHPx6wdRKhPDKuFSk
         S61q9mFbaBS3+3ZyvADpeZ4smcYm9MrkR9aWbFVxsdEFjC8nO6F0fOj9nDTRLKn4H7ta
         3V2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFp3WKXDaQrUUsBREPKYVmuo8DnEYjuCYWnTkY8Ee8A=;
        b=E/+bzhhC8+YmjxzECG25WN8B0ETryHV6TD+qyz9ixdKvZv1k/lEtyVPckZG/o5qc/y
         FELhz6z8ucsidPoeCIHd4mijHxIUGoOyA9qbrRln2lTCCUZM/BDV3ddOW52gIBkNztXj
         LyzH62oTlRjUdE6omXXgQ+tK1siAQYU8YG5dDJRpP5/FuI8QEY3ugibdwYEkp8VH9rmn
         q2k+Pdo5B2r4WXphXM+QDpmorcQbk1X3VGxIbjwTzyOaCFBFtx2O/+TMXXql5gBoLBN/
         4Eo9S92YcaWIq/ujpqGg3RcosHSGpqF0qHujwZjg678VwyhwhXtMfWa7Iv1iX6A0QrvS
         JdmA==
X-Gm-Message-State: APjAAAX3vYzSL2Pm9mJeGPqdy2bPdGA561LqboqYF7qwsLGRQMtvgI+6
        /8Cgaw1U/1HFCDHWR77/hRAx/0PfSrNz1sI1nLc=
X-Google-Smtp-Source: APXvYqxQtQP8zpfY+iKnSYqelDo0J3jvewp+B74q5vl8q+PlRraQhJtirH0n4dacZzwiN8U6VYENkgjhlg8dqMFDrfI=
X-Received: by 2002:aa7:848c:: with SMTP id u12mr5421382pfn.12.1581018099890;
 Thu, 06 Feb 2020 11:41:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580430057.git.me@ttaylorr.com> <cover.1580862307.git.me@ttaylorr.com>
 <3e19d50148c8d53b30f8f0036a2d3af9f4bb3499.1580862307.git.me@ttaylorr.com>
In-Reply-To: <3e19d50148c8d53b30f8f0036a2d3af9f4bb3499.1580862307.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 6 Feb 2020 20:41:28 +0100
Message-ID: <CAN0heSrXZd7ktBTHaYFWjhW=NcGx5gL52-unSDaC4ZoNf96HFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] builtin/commit-graph.c: support '--split[=<strategy>]'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 5 Feb 2020 at 01:28, Taylor Blau <me@ttaylorr.com> wrote:
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 28d1fee505..b7fe65ef21 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -57,11 +57,17 @@ or `--stdin-packs`.)
>  With the `--append` option, include all commits that are present in the
>  existing commit-graph file.
>  +
> -With the `--split` option, write the commit-graph as a chain of multiple
> -commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
> -not already in the commit-graph are added in a new "tip" file. This file
> -is merged with the existing file if the following merge conditions are
> -met:
> +With the `--split[=<strategy>]` option, write the commit-graph as a
> +chain of multiple commit-graph files stored in
> +`<dir>/info/commit-graphs`. Commit-graph layers are merged based on the
> +strategy and other splitting options. The new commits not already in the
> +commit-graph are added in a new "tip" file. This file is merged with the
> +existing file if the following merge conditions are met:

Please add a lone "+" here.

> +* If `--split=merge-always` is specified, then a merge is always
> +conducted, and the remaining options are ignored. Conversely, if
> +`--split=no-merge` is specified, a merge is never performed, and the
> +remaining options are ignored. A bare `--split` defers to the remaining
> +options.
>  +

Similar to this existing one here. There's some minor misrendering here
otherwise.

>  * If `--size-multiple=<X>` is not specified, let `X` equal 2. If the new
>  tip file would have `N` commits and the previous tip has `M` commits and

> -               OPT_BOOL(0, "split", &opts.split,
> -                       N_("allow writing an incremental commit-graph file")),
> +               OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
> +                       N_("allow writing an incremental commit-graph file"),
> +                       PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
> +                       write_option_parse_split),


I keep getting back to this -- sorry! So this actually forbids
"--no-split", which used to work before. Unfortunate?

I have to ask, what is the long-term plan for the two formats (split and
non-split)? As I understand it, and I might well be wrong, the non-split
format came first and the split format was a user-experience
improvement. Should we expect that `--split` becomes the default? In
which case `--no-split` would be needed. Or might the non-split format
go away entirely, leaving `--split` a no-op and `--split=<strategy>` a
pretty funky way of choosing a strategy for the one-and-only file
format?

To try to be concrete, here's a suggestion: `--format=split` and
`--split-strategy=<strategy>`.

Martin
