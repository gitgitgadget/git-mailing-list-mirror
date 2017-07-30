Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88DE12047F
	for <e@80x24.org>; Sun, 30 Jul 2017 05:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbdG3F2s (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 01:28:48 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35759 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753924AbdG3F2r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 01:28:47 -0400
Received: by mail-qk0-f194.google.com with SMTP id a77so6878911qkb.2
        for <git@vger.kernel.org>; Sat, 29 Jul 2017 22:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8v6VOQQA6XtjDsiMYkC8zISHOqAT/npRB3fzCggyN94=;
        b=ZUZosE1Jwrc2ajsSNgI4TifVrXlKFss66XMAyliinTaFEqYQR+xkXwtLrGiU7sZkd0
         JWCyA4JwvNl3AUkhp0A849MLCRvx4oG90knDxRWXopuTN9dnJO5X6IgY3fTmhAeC5P7D
         213PD3DLoHAWgnQnFqDSSrMAk5KXpoJ8bnRNPOumT9RBBLUuQXyf7aOMg7YHyLpEiP9c
         SW0qBzh7wR2rRvyvgdp/yKgQQ8fWMU2NX41gSiGWnde/lxeVY0jPYDdv5iFyge1E4fyU
         MkGGN0JxD4xcCffQiixbU+WdGYFxc6R/n15w97IxnWrqsAVGbbotG+a3bZqvBgL9B/MQ
         NlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8v6VOQQA6XtjDsiMYkC8zISHOqAT/npRB3fzCggyN94=;
        b=azi98nCii911RmOpzVYLGiBJuSelBmYbNPN0S4AsbnFNOhW80iR49il2xlHCHorrcA
         AxqMwlUfRjQI7excli9EGbuVTSsvMxRoQ7p2atOsit4XnYZBPGaCquedtcmQ3RJ36IiK
         RYSFC/dCuqW0rzR7gnu1P9xnM3BBjTWMnepodulLKQf3jFtn7hbc5CGTtGperpnj0gj1
         LpQGVMlmBPrOj00p5avCvwu7su+JFGQXn0mOR/A0xL9cINRAR/W6qvrGSXW2CdzDS9CR
         4wcgNbASpgPZBVfhmlGuEE9DJHsNwNGpa7o5Y2JZQXRfUYGtIW5dcSQEgxiHJCdQzdGC
         APxA==
X-Gm-Message-State: AIVw113sUUjMhrHZUGB0xTwiDvUouqtbgHDrLZ8j5w5JmlkNG87VwFt8
        RtETihqeuwzi7ri4llv5cNWRQRrCAQ==
X-Received: by 10.55.111.4 with SMTP id k4mr15571119qkc.287.1501392526395;
 Sat, 29 Jul 2017 22:28:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Sat, 29 Jul 2017 22:28:45 -0700 (PDT)
In-Reply-To: <20170729222401.12381-9-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com> <20170729222401.12381-1-pc44800@gmail.com>
 <20170729222401.12381-9-pc44800@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 30 Jul 2017 07:28:45 +0200
Message-ID: <CAP8UFD2XWm-m1CZoX121mhQ+WunCRTMJT5RjrZAXKBY3axcSJQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 08/13] submodule: port submodule subcommand
 'summary' from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 30, 2017 at 12:23 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:

> +static int module_summary(int argc, const char **argv, const char *prefix)
> +{
> +       struct summary_cb info = SUMMARY_CB_INIT;
> +       int cached = 0;
> +       char *diff_cmd = "diff-index";
> +       int for_status = 0;
> +       int quiet = 0;
> +       int files = 0;
> +       int summary_limits = -1;
> +       struct child_process cp_rev = CHILD_PROCESS_INIT;
> +       char *head;
> +       struct strbuf sb = STRBUF_INIT;
> +       int ret;
> +
> +       struct option module_summary_options[] = {
> +               OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
> +               OPT_BOOL(0, "cached", &cached, N_("Use the commit stored in the index instead of the submodule HEAD")),
> +               OPT_BOOL(0, "files", &files, N_("To compares the commit in the index with that in the submodule HEAD")),
> +               OPT_BOOL(0, "for-status", &for_status, N_("Skip submodules with 'all' ignore_config value")),
> +               OPT_INTEGER('n', "summary-limits", &summary_limits, N_("Limit the summary size")),
> +               OPT_END()
> +       };
> +
> +       const char *const git_submodule_helper_usage[] = {
> +               N_("git submodule--helper summary [<options>] [--] [<path>]"),
> +               NULL
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, module_summary_options,
> +                            git_submodule_helper_usage, 0);
> +
> +       if (!summary_limits)
> +               return 0;
> +
> +       cp_rev.git_cmd = 1;
> +       argv_array_pushl(&cp_rev.args, "rev-parse", "-q", "--verify",
> +                        argc ? argv[0] : "HEAD", NULL);
> +
> +       if (!capture_command(&cp_rev, &sb, 0)) {
> +               strbuf_strip_suffix(&sb, "\n");
> +               if (argc) {
> +                       argv++;
> +                       argc--;
> +               }
> +       } else if (!argc || !strcmp(argv[0], "HEAD")) {
> +               /* before the first commit: compare with an empty tree */
> +               struct stat st;
> +               struct object_id oid;
> +               if (fstat(0, &st) < 0 || index_fd(oid.hash, 0, &st, 2, prefix, 3))
> +                       die("Unable to add %s to database", oid.hash);
> +               strbuf_addstr(&sb, oid_to_hex(&oid));
> +               if (argc) {
> +                       argv++;
> +                       argc--;
> +               }
> +       } else {
> +               strbuf_addstr(&sb, "HEAD");
> +       }
> +
> +       head = strbuf_detach(&sb, NULL);

I am not sure this "head" variable is really needed.

> +       if (files) {
> +               if (cached)
> +                       die(_("The --cached option cannot be used with the --files option"));
> +               diff_cmd = "diff-files";
> +
> +               free(head);
> +
> +               head = NULL;

If "head" isn't used, "strbuf_reset(&sb)" could be used instead.
If "head" is still needed, "FREE_AND_NULL(head)" could be used.

> +       }
> +
> +       info.argc = argc;
> +       info.argv = argv;
> +       info.prefix = prefix;
> +       info.cached = !!cached;
> +       info.for_status = !!for_status;
> +       info.quiet = quiet;
> +       info.files = files;
> +       info.summary_limits = summary_limits;
> +       info.diff_cmd = diff_cmd;
> +
> +       ret = compute_summary_module_list(head, &info);
> +       if (head)
> +               free(head);

"sb.buf" could be passed to compute_summary_module_list() instead of
"head". In this case that function should check that head is not an
empty string before using it.

If "head" is not used then strbuf_release(&sb) can be used to free any
memory sb still holds.
If "head" is still used, "if (head)" can be removed before
"free(head)" as free() already checks if its argument is NULL.

> +       return ret;
> +

Spurious new line.

> +}
