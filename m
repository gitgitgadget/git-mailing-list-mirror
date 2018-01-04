Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDBBB1F406
	for <e@80x24.org>; Thu,  4 Jan 2018 00:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeADARO (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 19:17:14 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:43723 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbeADARN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 19:17:13 -0500
Received: by mail-qt0-f179.google.com with SMTP id w10so85169qtb.10
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 16:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N7qkU1E3F3QNGTd+pblHcVW2Rhz0ib3L4oZZmd2euKM=;
        b=jGFPcNseQq3JpsCRyOMzIQWhrRZnFHbPNSpmratQR6wsQzbrsW4ZoIMIUXKgWNgLvI
         k+tfX7Mbc82mEes5ZcG/1RC0Pn3WMAHut8IiNEFf1Y4R7thqFXPc1Bawm6KFPbISkIF4
         yRNOQ3+LB0eYPOVNFBOeFFAvL4tYrv14JQJxsNl8XaQqtZ82Tefoq20HWTagndJyBHQ7
         RljUFH/Xdq6XdjbL+RZd1rFvxM/15xN/Q1FSMUgx7IK81P7NHmdtBkjEQZU+1HU5HDYl
         LI7UZtEb8qYDSaTbnX6oTxqdfmOkrzUmcHkJTMRS6EZbAwf935ID9iqHsJr0i/VODyp+
         T/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N7qkU1E3F3QNGTd+pblHcVW2Rhz0ib3L4oZZmd2euKM=;
        b=ivtYsOgIcsbNzTl+zjySgOxwUHY6KUMVIPJg6VABbOGkFMAxfBcBhtxJapTeeYVqEi
         3vZ2ObYpx49dT9KnDOVRrrpNDKHwgRFVIFFbHhzmFE7xrFEhOko79OV3yrLlN978E4ZL
         GTyJorflftQuxgzFHgVqjU051xluTkjV9O0q/nIjvWuLJXWd5xUlhca7b2OauNAScTpi
         ONzN/ZIIjJl52uWj0dRLEjMRrpRgi6LisdwAgRIN2r879AAgDzRNE2+h0Flg/DcXj68B
         FB4tiTX+vII5oM+ktzvKb4UGdo+ewRBVBc2HS7d0dNkwCddoxa+P/QVFklox5NJTNdRb
         ckUg==
X-Gm-Message-State: AKGB3mJ8BXYwiI1SMcFwCIH6rl14tsriqvktqHAhlCp6h+nkyO2qScOA
        sbaept2B82DVdc4NyvoyDFqjSW/kWQO5eCZ9ynmRyqk8208=
X-Google-Smtp-Source: ACJfBotdt/a7MhM6QlR4pPydyQ9UXjjy9X1zGXgKUzJBU0d1iFyMm57/BZuXwN7MRg6eqaZ/o9ASXIAgGCHuHuuy1OM=
X-Received: by 10.237.61.181 with SMTP id i50mr4388373qtf.29.1515025032469;
 Wed, 03 Jan 2018 16:17:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 3 Jan 2018 16:17:11 -0800 (PST)
In-Reply-To: <20180103001828.205012-13-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180103001828.205012-13-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 Jan 2018 16:17:11 -0800
Message-ID: <CAGZ79kaQMBaA+gxqjY0xBNZiy2PdafoXjB+kowM9pj9heLwRPA@mail.gmail.com>
Subject: Re: [PATCH 12/26] ls-refs: introduce ls-refs server command
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 2, 2018 at 4:18 PM, Brandon Williams <bmwill@google.com> wrote:
> Introduce the ls-refs server command.  In protocol v2, the ls-refs
> command is used to request the ref advertisement from the server.  Since
> it is a command which can be requested (as opposed to mandatory in v1),
> a client can sent a number of parameters in its request to limit the ref
> advertisement based on provided ref-patterns.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/technical/protocol-v2.txt | 26 +++++++++
>  Makefile                                |  1 +
>  ls-refs.c                               | 97 +++++++++++++++++++++++++++++++++
>  ls-refs.h                               |  9 +++

Maybe consider putting any served command into a sub directory?

For example the code in builtin/ has laxer rules w.r.t. die()ing
as it is a user facing command, whereas some devs want to see
code at the root of the repo to not die() at all as the eventual goal
is to have a library there.
All this code is on the remote side, which also has different traits than
the code at the root of the git.git repo; non-localisation comes to mind,
but there might be other aspects as well (security?).


>  serve.c                                 |  2 +
>  5 files changed, 135 insertions(+)
>  create mode 100644 ls-refs.c
>  create mode 100644 ls-refs.h
>
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index b87ba3816..5f4d0e719 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -89,3 +89,29 @@ terminate the connection.
>  Commands are the core actions that a client wants to perform (fetch, push,
>  etc).  Each command will be provided with a list capabilities and
>  arguments as requested by a client.
> +
> + Ls-refs

So is it ls-refs or Ls-refs or is any capitalization valid?

> +---------
> +
> +Ls-refs is the command used to request a reference advertisement in v2.
> +Unlike the current reference advertisement, ls-refs takes in parameters
> +which can be used to limit the refs sent from the server.
> +
> +Ls-ref takes in the following parameters wraped in packet-lines:
> +
> +  symrefs: In addition to the object pointed by it, show the underlying
> +          ref pointed by it when showing a symbolic ref.
> +  peel: Show peeled tags.
> +  ref-pattern <pattern>: When specified, only references matching the
> +                        given patterns are displayed.

What kind of pattern matching is allowed here?
strictly prefix only, or globbing, regexes?
Is there a given grammar to follow? Maybe a link to the git
glossary is or somewhere else might be fine.

Seeing that we do wildmatch() down there (as opposed to regexes),
I wonder if it provides an entry for a denial of service attack, by crafting
a pattern that is very expensive for the server to compute but cheap to
ask for from a client. (c.f. 94da9193a6 (grep: add support for PCRE v2,
2017-06-01, but that is regexes!)

> +The output of ls-refs is as follows:
> +
> +    output = *ref
> +            flush-pkt
> +    ref = PKT-LINE((tip | peeled) LF)
> +    tip = obj-id SP refname (SP symref-target)
> +    peeled = obj-id SP refname "^{}"
> +
> +    symref = PKT-LINE("symref" SP symbolic-ref SP resolved-ref LF)
> +    shallow = PKT-LINE("shallow" SP obj-id LF)
> diff --git a/Makefile b/Makefile
> index 5f3b5fe8b..152a73bec 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -820,6 +820,7 @@ LIB_OBJS += list-objects-filter-options.o
>  LIB_OBJS += ll-merge.o
>  LIB_OBJS += lockfile.o
>  LIB_OBJS += log-tree.o
> +LIB_OBJS += ls-refs.o
>  LIB_OBJS += mailinfo.o
>  LIB_OBJS += mailmap.o
>  LIB_OBJS += match-trees.o
> diff --git a/ls-refs.c b/ls-refs.c
> new file mode 100644
> index 000000000..ac4904a40
> --- /dev/null
> +++ b/ls-refs.c
> @@ -0,0 +1,97 @@
> +#include "cache.h"
> +#include "repository.h"
> +#include "refs.h"
> +#include "remote.h"
> +#include "argv-array.h"
> +#include "ls-refs.h"
> +#include "pkt-line.h"
> +
> +struct ls_refs_data {
> +       unsigned peel;
> +       unsigned symrefs;
> +       struct argv_array patterns;
> +};
> +
> +/*
> + * Check if one of the patterns matches the tail part of the ref.
> + * If no patterns were provided, all refs match.
> + */
> +static int ref_match(const struct argv_array *patterns, const char *refname)
> +{
> +       char *pathbuf;
> +       int i;
> +
> +       if (!patterns->argc)
> +               return 1; /* no restriction */
> +
> +       pathbuf = xstrfmt("/%s", refname);
> +       for (i = 0; i < patterns->argc; i++) {
> +               if (!wildmatch(patterns->argv[i], pathbuf, 0)) {
> +                       free(pathbuf);
> +                       return 1;
> +               }
> +       }
> +       free(pathbuf);
> +       return 0;
> +}
> +
> +static int send_ref(const char *refname, const struct object_id *oid,
> +                   int flag, void *cb_data)
> +{
> +       struct ls_refs_data *data = cb_data;
> +       const char *refname_nons = strip_namespace(refname);
> +       struct strbuf refline = STRBUF_INIT;
> +
> +       if (!ref_match(&data->patterns, refname))
> +               return 0;
> +
> +       strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
> +       if (data->symrefs && flag & REF_ISSYMREF) {
> +               struct object_id unused;
> +               const char *symref_target = resolve_ref_unsafe(refname, 0,
> +                                                              &unused,
> +                                                              &flag);
> +
> +               if (!symref_target)
> +                       die("'%s' is a symref but it is not?", refname);
> +
> +               strbuf_addf(&refline, " %s", symref_target);
> +       }
> +
> +       strbuf_addch(&refline, '\n');
> +
> +       packet_write(1, refline.buf, refline.len);
> +       if (data->peel) {
> +               struct object_id peeled;
> +               if (!peel_ref(refname, &peeled))
> +                       packet_write_fmt(1, "%s %s^{}\n", oid_to_hex(&peeled),
> +                                        refname_nons);
> +       }
> +
> +       strbuf_release(&refline);
> +       return 0;
> +}
> +
> +int ls_refs(struct repository *r, struct argv_array *keys, struct argv_array *args)
> +{
> +       int i;
> +       struct ls_refs_data data = { 0, 0, ARGV_ARRAY_INIT };
> +
> +       for (i = 0; i < args->argc; i++) {
> +               const char *arg = args->argv[i];
> +               const char *out;
> +
> +               if (!strcmp("peel", arg))
> +                       data.peel = 1;
> +               else if (!strcmp("symrefs", arg))
> +                       data.symrefs = 1;
> +               else if (skip_prefix(arg, "ref-pattern ", &out))
> +                       argv_array_pushf(&data.patterns, "*/%s", out);
> +       }
> +
> +       head_ref_namespaced(send_ref, &data);
> +       for_each_namespaced_ref(send_ref, &data);
> +       packet_flush(1);
> +       argv_array_clear(&data.patterns);
> +       return 0;
> +}
> diff --git a/ls-refs.h b/ls-refs.h
> new file mode 100644
> index 000000000..9e4c57bfe
> --- /dev/null
> +++ b/ls-refs.h
> @@ -0,0 +1,9 @@
> +#ifndef LS_REFS_H
> +#define LS_REFS_H
> +
> +struct repository;
> +struct argv_array;
> +extern int ls_refs(struct repository *r, struct argv_array *keys,
> +                  struct argv_array *args);
> +
> +#endif /* LS_REFS_H */
> diff --git a/serve.c b/serve.c
> index da8127775..88d548410 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -4,6 +4,7 @@
>  #include "pkt-line.h"
>  #include "version.h"
>  #include "argv-array.h"
> +#include "ls-refs.h"
>  #include "serve.h"
>
>  static int always_advertise(struct repository *r,
> @@ -44,6 +45,7 @@ struct protocol_capability {
>  static struct protocol_capability capabilities[] = {
>         { "agent", agent_advertise, NULL },
>         { "stateless-rpc", always_advertise, NULL },
> +       { "ls-refs", always_advertise, ls_refs },
>  };
>
>  static void advertise_capabilities(void)
> --
> 2.15.1.620.gb9897f4670-goog
>
