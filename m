Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9549D1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 04:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbeGFEIA (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 00:08:00 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45087 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbeGFEH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 00:07:59 -0400
Received: by mail-yw0-f196.google.com with SMTP id 139-v6so3728842ywg.12
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 21:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/SwGXay6EKLzZgwpJoWr9GYKsfqJkqBGCWUOQNEvgQ=;
        b=XW4+nvnwvFSaODKRRsCDEEBLorv3Uy6e7WqrlyvWicFmby6xyarPy6XTMmEsgfC2ou
         NdotGm89DJ5RxJmaIDunjraX97C6puWjTnr6FvEqdSs51UCcEvCLW81wfSS9MuQLoV37
         LhIK8rVIQMJX/zEjHMl18K2ZtpkvPi4Vlx/U0T0RS6k1gXOmB/H9eKkCj7WEpOIJbM/y
         U1TAR4mui+et+zfQ2n8HxFDt25jMQ7B77WFccpvCbZg6liBXIFbiVrGRdjIAdLcbZGmD
         XVEGYj0RPWp74OqbTZ06rfvGjHhS3SO5c43GHndfiN2TwqHrKngP6rQ4tENESeb1WuMu
         rvrg==
X-Gm-Message-State: APt69E2PWZoDF6zCQHvyiIEndU8gJlzGk9Q1Ut8vupiu7100ne1MJFRx
        pHpXsD/F83j9bjMlPWcAYs14XlYGptUWDOS3H4A=
X-Google-Smtp-Source: AAOMgpdFOWDMmPrMrisCEbdaJimLi6BdC6EQ4Qdo4KoQRQ7E7LLh6P22/bADkb3sM2KX1SbovXhGkkhx278Buf2q8Iw=
X-Received: by 2002:a0d:c105:: with SMTP id c5-v6mr4122443ywd.131.1530850078768;
 Thu, 05 Jul 2018 21:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180625143434.89044-1-dstolee@microsoft.com> <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-5-dstolee@microsoft.com>
In-Reply-To: <20180706005321.124643-5-dstolee@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Jul 2018 00:07:47 -0400
Message-ID: <CAPig+cSfdbprGHajYZZWT20fW6_+_YN2SAtM86QswaApPHkqPQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/24] multi-pack-index: add 'write' verb
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
> In anticipation of writing multi-pack-indexes, add a
> 'git multi-pack-index write' subcommand and send the options to a
> write_midx_file() method.

Since the 'write' command is a no-op at this point, perhaps say so in
the commit message. Something like:

    ... add a skeleton 'git multi-pack-index write' subcommand,
    which will be fleshed-out by a later commit.

The bit about sending options to write_midx_file() is superfluous;
it's a mere implementation detail which is clearly seen by reading the
patch.

> Also create a basic test file that tests
> the 'write' subcommand.

Maybe: s/file/script

And, as above, perhaps mention that this is a _skeleton_ test script
so as to avoid confusing readers into thinking that something
significant is happening at this stage.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> +* Write a MIDX file for the packfiles in an alternate.

In an alternate what?

> +-----------------------------------------------
> +$ git multi-pack-index --object-dir <alt> write
> +-----------------------------------------------
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> @@ -2,9 +2,10 @@
>  static char const * const builtin_multi_pack_index_usage[] = {
> -       N_("git multi-pack-index [--object-dir <dir>]"),
> +       N_("git multi-pack-index [--object-dir <dir>] [write]"),

Is there going to be some default behavior when no verb is provided?
The below implementation seems to suggest that the verb is required,
so this probably ought to be typeset as:

    git multi-pack-index [--object-dir=<dir>] write

Later, when you add more (mutually exclusive) verbs, change the typesetting to:

    git multi-pack-index [--object-dir=<dir>] (write|...|...)

Alternately, just use:

    git multi-pack-index [--object-dir=<dir>] <verb>

> @@ -34,5 +35,12 @@ int cmd_multi_pack_index(int argc, const char **argv,
> +       if (argc == 0)
> +               usage_with_options(builtin_multi_pack_index_usage,
> +                                  builtin_multi_pack_index_options);
> +
> +       if (!strcmp(argv[0], "write"))
> +               return write_midx_file(opts.object_dir);
> +
>         return 0;

This should be throwing an error when an unrecognized verb is provided.

It also should be throwing an error when 'write' is given too many
arguments (which, at this point, appears to be 0).
