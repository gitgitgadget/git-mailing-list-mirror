Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90181F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 06:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeCYGkq (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 02:40:46 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:40218 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeCYGkp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 02:40:45 -0400
Received: by mail-qt0-f179.google.com with SMTP id g5so5494811qth.7
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 23:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=K5uAe3k+FSI6NdJ+o8/QpGMRrpsBIEKfladfi9JaFX4=;
        b=dOtR6WxCVdvlUMn38Xpe5kNMhjkHgpQYTJ+ynBIs5A+NVMxMfhQQkB3pOwkutczjVx
         hvx1LVTlVBAuhAjWlGZiRHgfvGYXg0CxERE9aWzKC3w6XaqSQUwR7BuC6vUThrrUfkGq
         BVSyOXTEgx16qO0Hu9WLlxhS4CyrBpdgDMQsaKEIJv8lUwXYRkX50cV9ZkUKFAr7VDoK
         SY8t3PDD2YGL9w5QjcmMwK+pXk1P0hC0XZrusfW4lYQ6kgc5MWP0wN6YZtFGZ7Nm+hx9
         71vU/EAZNamyQZvLmDEPFc9eQlt779g0rCat+HQc0GAwSSinf1ORFhZ46DR10fnvctLM
         bM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=K5uAe3k+FSI6NdJ+o8/QpGMRrpsBIEKfladfi9JaFX4=;
        b=meQetVRsrdmkvnukEtYilxD2phc2tRlk2kXNEuCG6pkMr3k53ya3XIW1ouQgIBxipY
         SoHb2E1fqV6PMqRBqdJz+AegMcALdQ/pKkteSxNRXjbJr/zaHxlwvLmhhSEb+uwQijJT
         AQIg5G/V+cekKAGQAjwPxXr5UWKkU8uwjGWLQVdch1L4wDWorRqrUzZ4TdGuiXniUaOr
         k1sHl2DkDOdopBFCO4g8PKE1s/XtkFIgvzFamZgi0TqRtj7GXFWV55wl339g6Q9o1/Qy
         5iNSMuvop58HzQevMfY4JsisqiDdaQr0qOUFySU3zgiFD/iyE1poHZOxsPPSQBmbnNZr
         ClBA==
X-Gm-Message-State: AElRT7GXoEnCZ5DIKLvxcntTfD/Yh8o2NDfJo1G8qAhlDO2YYDi7SbXy
        ixbMk2kzPVTgnwtOu+gHf7G/iCC2vBifPQcNoTi6wQ==
X-Google-Smtp-Source: AG47ELth2GXvQ8N3pgmJYGPhHZNoLR8BJ3eJsF0u1odcqym5CY5hUPN76/UyDHFXO3VzX9KZlGamCY+E1X79FUfhwJk=
X-Received: by 10.200.42.37 with SMTP id k34mr35024416qtk.101.1521960044342;
 Sat, 24 Mar 2018 23:40:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 24 Mar 2018 23:40:43 -0700 (PDT)
In-Reply-To: <20180324173707.17699-2-joel@teichroeb.net>
References: <20180324173707.17699-1-joel@teichroeb.net> <20180324173707.17699-2-joel@teichroeb.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Mar 2018 02:40:43 -0400
X-Google-Sender-Auth: HS8Yo4Q4cAQErUmUx9lV407ZfU4
Message-ID: <CAPig+cSkQLSvOroB0bLLLBAXy9UBDN+s=i97COtNDpO0FbLJkg@mail.gmail.com>
Subject: Re: [PATCH 1/4] stash: convert apply to builtin
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 1:37 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> @@ -0,0 +1,339 @@
> +static int get_stash_info(struct stash_info *info, const char *commit)
> +{
> +       struct strbuf w_commit_rev = STRBUF_INIT;
> +       struct strbuf b_commit_rev = STRBUF_INIT;
> +       struct strbuf w_tree_rev = STRBUF_INIT;
> +       struct strbuf b_tree_rev = STRBUF_INIT;
> +       struct strbuf i_tree_rev = STRBUF_INIT;
> +       struct strbuf u_tree_rev = STRBUF_INIT;
> +       struct strbuf commit_buf = STRBUF_INIT;
> +       struct strbuf symbolic = STRBUF_INIT;
> +       struct strbuf out = STRBUF_INIT;

'commit_buf' is being leaked. All the others seem to be covered (even
in the case of early 'return').

> +       if (commit == NULL) {
> +               strbuf_addf(&commit_buf, "%s@{0}", ref_stash);
> +               revision = commit_buf.buf;
> +       } else if (strspn(commit, "0123456789") == strlen(commit)) {
> +               strbuf_addf(&commit_buf, "%s@{%s}", ref_stash, commit);
> +               revision = commit_buf.buf;
> +       }
> +static int do_apply_stash(const char *prefix, struct stash_info *info, int index)
> +{
> +       if (index) {
> +               if (!oidcmp(&info->b_tree, &info->i_tree) || !oidcmp(&c_tree, &info->i_tree)) {
> +                       has_index = 0;
> +               } else {
> +                       struct child_process cp = CHILD_PROCESS_INIT;
> +                       struct strbuf out = STRBUF_INIT;
> +                       struct argv_array args = ARGV_ARRAY_INIT;
> +                       cp.git_cmd = 1;
> +                       argv_array_pushl(&cp.args, "diff-tree", "--binary", NULL);
> +                       argv_array_pushf(&cp.args, "%s^2^..%s^2", sha1_to_hex(info->w_commit.hash), sha1_to_hex(info->w_commit.hash));
> +                       if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0))
> +                               return -1;

Leaking 'out'?

> +
> +                       child_process_init(&cp);
> +                       cp.git_cmd = 1;
> +                       argv_array_pushl(&cp.args, "apply", "--cached", NULL);
> +                       if (pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0))
> +                               return -1;

Leaking 'out'.

> +
> +                       strbuf_release(&out);
> +                       discard_cache();
> +                       read_cache();
> +                       if (write_cache_as_tree(index_tree.hash, 0, NULL))
> +                               return -1;
> +
> +                       argv_array_push(&args, "reset");
> +                       cmd_reset(args.argc, args.argv, prefix);
> +               }
> +       }
> +       if (has_index) {
> +               if (reset_tree(index_tree, 0, 0))
> +                       return -1;
> +       } else {
> +               struct child_process cp = CHILD_PROCESS_INIT;
> +               struct strbuf out = STRBUF_INIT;
> +               cp.git_cmd = 1;
> +               argv_array_pushl(&cp.args, "diff-index", "--cached", "--name-only", "--diff-filter=A", NULL);
> +               argv_array_push(&cp.args, sha1_to_hex(c_tree.hash));
> +               ret = pipe_command(&cp, NULL, 0, &out, 0, NULL, 0);
> +               if (ret)
> +                       return -1;
> +
> +               if (reset_tree(c_tree, 0, 1))
> +                       return -1;

Leaking 'out' at these two 'return's?

> +               child_process_init(&cp);
> +               cp.git_cmd = 1;
> +               argv_array_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
> +               ret = pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0);
> +               if (ret)
> +                       return -1;

And here.

> +
> +               strbuf_release(&out);
> +               discard_cache();
> +       }
> +
> +       if (!quiet) {
> +               struct argv_array args = ARGV_ARRAY_INIT;
> +               argv_array_push(&args, "status");
> +               cmd_status(args.argc, args.argv, prefix);
> +       }
> +
> +       return 0;
> +}
> +
> +static int apply_stash(int argc, const char **argv, const char *prefix)
> +{
> +       const char *commit = NULL;
> +       int index = 0;
> +       struct stash_info info;
> +       struct option options[] = {
> +               OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> +               OPT_BOOL(0, "index", &index,
> +                       N_("attempt to ininstate the index")),

"ininstate"??

> +               OPT_END()
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, options,
> +                       git_stash_helper_apply_usage, 0);
> +
> +       if (argc == 1) {
> +               commit = argv[0];
> +       }
> +
> +       if (get_stash_info(&info, commit))
> +               return -1;
> +
> +
> +       return do_apply_stash(prefix, &info, index);
> +}
