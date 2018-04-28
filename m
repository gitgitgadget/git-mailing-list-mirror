Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D831F428
	for <e@80x24.org>; Sat, 28 Apr 2018 17:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758632AbeD1R2u (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 13:28:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53454 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757745AbeD1R2t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 13:28:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id 66so7101414wmd.3
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=699tKtdDdPirtYcmQs1YB4vfEDq6afmB5vdVNghZ79c=;
        b=fm2y9K7u74RCy5+jllYRH5WK/H1SIabwFsXttKYJ7tI/3bbspfdHzkEVT7ictsnlyT
         9/bX2CT3zeeEqAJiACV5Ll66e4rISwMBJ/d4Tp0YzhiMxlptWR6gH+wLZPhbnlynFz+p
         XbISXZ9IUqbYLDE44ulkIXwwbbTyMbBm6/4a4V5+CsMspaG9TV7YXBppVPD7T8gsO8NR
         9KKqlDVN53iQj9ulXeFf4Lccog6v7kZjgVgP7vfH9t4RvFGLN7sRNyvu0m24nM8lc5it
         ovfxNfEn5lBkxarvSadhi4+kJQLtljDQRBVychdHu9OVwdvP/upUDQlGNpBJgyWSKxF6
         Ss5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=699tKtdDdPirtYcmQs1YB4vfEDq6afmB5vdVNghZ79c=;
        b=bCSsID93FmRiG2I5/VvcHRf2exiR0sduc5TEvSXxt7LWdsbLNVKVjSU8P0vtEVvaAo
         DJhCEJIdrMk1Tb6N6lQyrm4qT4q5ERdPqL9/WFdn5jq3VQfU5Eg8pcGjuA1fCzRLkalF
         MqiR8SwpFc1dBaoJCBg0vGDqHYDpdrS8exmp1ml0G3gbNxOytlyC8ou0KojE/ee830Se
         H655vjRbgzotOkb+dYKhi3T7jVoGCOHRd+Q8ekaEvA0aAJalkApURF9mf0YeCVNqoGB2
         piD+7MBNKSQk4GT7f5vh1Pc9EjJXOTQOg7PSUHi30SiUqi6EIE5oQ3VJm5eMbJB/P83q
         I8Xw==
X-Gm-Message-State: ALQs6tC2f0WAkw68V8kSXu+pTTH5c9LJMzVjdzs7xPCaSOs6Any6x4kw
        E8T5w7sEyqlJdwcuD2dxJLY=
X-Google-Smtp-Source: AB8JxZoDz/Tc5jsCExo5rvXI6AZH6NA4W15fjOWbIe9I8q9z8Zz0Sg+dCtuwXmLKT6Dqx40aVa5SuQ==
X-Received: by 10.28.145.134 with SMTP id t128mr4317439wmd.41.1524936527640;
        Sat, 28 Apr 2018 10:28:47 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abps22.neoplus.adsl.tpnet.pl. [83.8.60.22])
        by smtp.gmail.com with ESMTPSA id q16-v6sm4488587wrn.81.2018.04.28.10.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Apr 2018 10:28:46 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "peff\@peff.net" <peff@peff.net>,
        "avarab\@gmail.com" <avarab@gmail.com>
Subject: Re: [PATCH v4 00/10] Compute and consume generation numbers
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <527a8d47-15d4-78a1-4320-97ddc27bce48@gmail.com>
Date:   Sat, 28 Apr 2018 19:28:44 +0200
In-Reply-To: <527a8d47-15d4-78a1-4320-97ddc27bce48@gmail.com> (Derrick
        Stolee's message of "Wed, 25 Apr 2018 10:40:05 -0400")
Message-ID: <86in8bjl4j.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> As promised, here is the diff from v3.

What is this strange string "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0" in=
 place of tabs in the interdiff?
"=C2=A0" here is Unicode Character 'NO-BREAK SPACE' (U+00A0).

Though it doesn't matter for viewing, my newsreader (Gnus from GNU
Emacs) thinks that it is worth notifying about when replying.

Also, it looks like at least in one place the diff got line-wrapped.

> Thanks,
> -Stolee
>
> -- >8 --
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 7e1da6c6ea..b819756946 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1148,6 +1148,7 @@ int cmd_merge(int argc, const char **argv, const
> char *prefix)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 branch =3D branch_to_free =3D =
resolve_refdup("HEAD", 0, &head_oid,
> NULL);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (branch)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 skip_prefix(branch, "refs/heads/", &branch);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init_diff_ui_defaults();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git_config(git_merge_config, N=
ULL);
>
> @@ -1156,7 +1157,6 @@ int cmd_merge(int argc, const char **argv, const
> char *prefix)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 head_commit =3D lookup_commit_or_die(&head_oid, "HEAD");
>
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (branch_mergeoptions)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 parse_branch_merge_options(branch_mergeoptions);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 argc =3D parse_options(argc, a=
rgv, prefix, builtin_merge_options,

Whitespace fixes, all right.

> diff --git a/commit-graph.c b/commit-graph.c
> index 21e853c21a..aebd242def 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -257,7 +257,7 @@ static int fill_commit_in_graph(struct commit
> *item, struct commit_graph *g, uin
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t *parent_data_ptr;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t date_low, date_high;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct commit_list **pptr;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned char *commit_data =
=3D g->chunk_commit_data +
> GRAPH_DATA_WIDTH * pos;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned char *commit_data =
=3D g->chunk_commit_data +
> (g->hash_len + 16) * pos;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item->object.parsed =3D 1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item->graph_pos =3D pos;

This was accidental change in v3 (unrelated to the changes in commit it
were in).  Though I wonder if the symbolic constant route is not better
- though as separate standalone commit.

> @@ -304,7 +304,7 @@ static int find_commit_in_graph(struct commit
> *item, struct commit_graph *g, uin
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *pos =3D item->graph_pos;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return bsearch_graph(commit_graph,
> &(item->object.oid), pos);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return bsearch_graph(g, &(item->object.oid), pos);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
>

Fixup for a commit, that was sent in separate fixup email in v3.  All
right.

Though I wonder if it wouldn't be better to call global variable
'the_commit_graph' to avoid such errors in the future...

> @@ -312,10 +312,10 @@ int parse_commit_in_graph(struct commit *item)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t pos;
>
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (item->object.parsed)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!core_commit_graph)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (item->object.parsed)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return 1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prepare_commit_graph();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (commit_graph && find_commi=
t_in_graph(item, commit_graph, &pos))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return fill_commit_in_graph(item, commit_graph, pos);

Fixed accidental flip-flopping about return value when
item->object.parsed.  I'd have to take a look at actual commits to say
whether I think it is all right or not.

> @@ -454,9 +454,8 @@ static void write_graph_chunk_data(struct hashfile
> *f, int hash_len,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packedDa=
te[0] =3D 0;
>
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if ((*list)->generation !=3D GENERATION_NUMBER_INFINITY) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if ((*list)->generation !=3D GENERATION_NUMBER_INFINITY)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packedDa=
te[0] |=3D htonl((*list)->generation << 2);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 }
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 packedDate[1] =3D htonl((*list)->date);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 hashwrite(f, packedDate, 8);

Coding style change, to be more in line with CodingGuidelines, namely
that we usually do not use block for single-command in conditionals.

All right.

> diff --git a/commit.c b/commit.c
> index 9ef6f699bd..e2e16ea1a7 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -653,7 +653,7 @@ int compare_commits_by_gen_then_commit_date(const
> void *a_, const void *b_, void
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (a->generation > b->ge=
neration)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -1;
>
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* use date as a heuristic when gen=
erataions are equal */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* use date as a heuristic when gen=
erations are equal */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (a->date < b->date)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (a->date > b->date)

Fixed typo in comment.  All right.

> @@ -1078,7 +1078,7 @@ int in_merge_bases_many(struct commit *commit,
> int nr_reference, struct commit *
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (commit->generation > min_g=
eneration)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return ret;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bases =3D paint_down_to_common=
(commit, nr_reference, reference,
> commit->generation);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (commit->object.flags & PAR=
ENT2)

Unifying way of returning result (to one that was used before this
commit in this fragment of the git code).  Looks all right, from what I
remember.

> diff --git a/ref-filter.c b/ref-filter.c
> index e2fea6d635..fb35067fc9 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -16,6 +16,7 @@
> =C2=A0#include "trailer.h"
> =C2=A0#include "wt-status.h"
> =C2=A0#include "commit-slab.h"
> +#include "commit-graph.h"
>
> =C2=A0static struct ref_msg {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *gone;
> @@ -1629,7 +1630,7 @@ static enum contains_result
> contains_tag_algo(struct commit *candidate,
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (p =3D want; p; p =3D p->n=
ext) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct commit *c =3D p->item;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 parse_commit_or_die(c);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 load_commit_graph_info(c);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (c->generation < cutoff)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cutoff =
=3D c->generation;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }

Avoiding performance penalty when not using commit-graph feature (or
when it is turned off).  Looks good on first glance.

> @@ -1582,7 +1583,7 @@ static int in_commit_list(const struct
> commit_list *want, struct commit *c)
> =C2=A0}
>
> =C2=A0/*
> - * Test whether the candidate or one of its parents is contained in
> the list.
> + * Test whether the candidate is contained in the list.
> =C2=A0 * Do not recurse to find out, though, but return -1 if inconclusiv=
e.
> =C2=A0 */
> =C2=A0static enum contains_result contains_test(struct commit *candidate,

Bringing comment in line with the function it is about.  Good.

Best,
--=20
Jakub Nar=C4=99bski
