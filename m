Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2221F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 03:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932097AbeGFDyV (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 23:54:21 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33379 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932075AbeGFDyU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 23:54:20 -0400
Received: by mail-yw0-f194.google.com with SMTP id c135-v6so3730670ywa.0
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 20:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T5v7I+//hscwPdU43KyvXHDFtYG2OOy6O5OPVvlRCOg=;
        b=iaDiM/LfMlwM0GMRTKkZhUyBEz6Xtd3jgKqlNjwnwvM0EnzmxXiwomS6v0iJOkXbnE
         pyRAAetfzsNQpP4ReU4RJPpUfYTY18ccaeoInYtAGZbPPFgBpj1sUqzDlahpKE4LyH6r
         fOv8gZZcFgBVbPv7wLvPOPM+fWHZyn52dNhl9IcvXb1Ii0vcPoK+4TLXO+DupdKFCbVC
         bs+bFKHNx21TWHTJmB5RDp5/fEhfnUwAtaI40+GryhPgAxGBaoQBxuhU7J4Uo7Yqqo45
         h+wFo93sxqw9TFcnNLn7hUHVRNoWoiNMuDgG2ZQxZlmN3T9Kw2NYbu9P8YawhLH2Ie5q
         sdBA==
X-Gm-Message-State: APt69E0Dd4ugZOgyxwGYkSIs8Q57BOOeNVBf26bkP63etJyWdSjUnIDO
        1ELeiXxIMcik3tKD0E/dWvBYymI6/QOsCiItK40=
X-Google-Smtp-Source: AAOMgpeoeTYxefO1kLKeNGVTM5h4nGnmIioKRYIHejh9aPOX3b0DOERTsCrDmfWpm8WIyk0oE2hCH0lRo0jqgQxIp3g=
X-Received: by 2002:a81:ae66:: with SMTP id g38-v6mr4194079ywk.74.1530849259712;
 Thu, 05 Jul 2018 20:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180625143434.89044-1-dstolee@microsoft.com> <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-4-dstolee@microsoft.com>
In-Reply-To: <20180706005321.124643-4-dstolee@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 5 Jul 2018 23:54:08 -0400
Message-ID: <CAPig+cQS-sFHtgMZdaW2tTPSLAo=pytFJ5_zhVvUU1=8Mq74ng@mail.gmail.com>
Subject: Re: [PATCH v3 03/24] multi-pack-index: add builtin
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 5, 2018 at 8:53 PM Derrick Stolee <stolee@gmail.com> wrote:
> This new 'git multi-pack-index' builtin will be the plumbing access
> for writing, reading, and checking multi-pack-index files. The
> initial implementation is a no-op.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> +++ b/Documentation/git-multi-pack-index.txt
> +SYNOPSIS
> +--------
> +'git multi-pack-index' [--object-dir <dir>]

In Git documentation, this is more typically written: [--object-dir=<dir>]

> +OPTIONS
> +-------
> +--object-dir <dir>::

Ditto: --object-dir=<dir>::

> +       Use given directory for the location of Git objects. We check
> +       `<dir>/packs/multi-pack-index` for the current MIDX file, and
> +       `<dir>/packs` for the pack-files to index.
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> @@ -0,0 +1,38 @@
> +static char const * const builtin_multi_pack_index_usage[] = {
> +       N_("git multi-pack-index [--object-dir <dir>]"),

Likewise.

> +int cmd_multi_pack_index(int argc, const char **argv,
> +                        const char *prefix)
> +{
> +       static struct option builtin_multi_pack_index_options[] = {
> +               OPT_FILENAME(0, "object-dir", &opts.object_dir,
> +                 N_("The object directory containing set of packfile and pack-index pairs")),

It's more typical not to capitalize these. Also, keep them short, if
possible, so perhaps drop "The".

> +               OPT_END(),
> +       };
> +
> +       if (argc == 2 && !strcmp(argv[1], "-h"))
> +               usage_with_options(builtin_multi_pack_index_usage,
> +                                  builtin_multi_pack_index_options);

Unless you are planning on adding a short "-h <something>" option
later in the series, then you can do away with this conditional
altogether since the below parse_options() will give you "-h" as help
for free.

> +       git_config(git_default_config, NULL);
> +
> +       argc = parse_options(argc, argv, prefix,
> +                            builtin_multi_pack_index_options,
> +                            builtin_multi_pack_index_usage, 0);
