Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EACE1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 22:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeBUWZN (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 17:25:13 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:38203 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeBUWZL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 17:25:11 -0500
Received: by mail-yw0-f195.google.com with SMTP id b70so1052379ywh.5
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 14:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+7BjI6SAEOyVwwSh/P8aXGfolauskEzNfsXt7QJSYJQ=;
        b=puEQu6dUHfYhOT6G5GVFEWYw8vrrSOVplnBqhjqzTHfK9qixt3CI74LGL/O0cG/0Yg
         +3nNJItZ7NYnTZtj+EKvmA5VIYsg0AhLcinILlcpm/zMejvdVf80Q01IcPhGC62PCWN5
         /g4Ut6znGXmB5HCOG2Rz2Wix10fG6Waw+lh+m2vOeREJGgqQLOTE4u0BWNdV+nsvcl3+
         VFcCu53UUG1vngS7yRjZoh9JEmcifUYBZ8qE3cYglf3hCxPbO4nUPJ9t02+Z+6eWXipu
         lTu6pdggIgBieS1jpgx27dHRuEmF82aKFEEHp+OdC/s8EdficxUO/HWqUhYwYgU6qIZU
         mFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+7BjI6SAEOyVwwSh/P8aXGfolauskEzNfsXt7QJSYJQ=;
        b=XWIaRcrUoIjsUyKircssBhuTNeJ8gJi4wnVYu9nvEgQt06OvM2yWuKaKf9Hd4wUBnc
         uwkSl1vqN9qDIvSVIf4a85fnEeayC6hta1ASxYuR/rV+3AU/kRYi51N2nnoi2g7CcAAM
         YvaG4weGfvCFTZ1TSXlUVE4gT1s6x7W5iC3JVxDir48MEl1E9t8xUJvuTKLuzL1h01ZW
         Hs2XHp84CnZSGTayBxAE5EUeKCxMTsqtbnBtcpep6BYUnX+SFDVBBFTul5FN07KOaAXT
         RHKecuMCs00d2PTe8UnJgNnplgE8/zzsTzz4XOrDq//dvsH4oZ7YEphI874RYCvrhFUy
         ErfA==
X-Gm-Message-State: APf1xPDla2ad0fZGlpe5nLvZl9r7pWlzijkZJfAfaPuBly4rCkYcD9Rg
        S84na0nbrMW+dVwrHgVro4aButLYetHoddsJa9uXug==
X-Google-Smtp-Source: AH8x227HbNP4guOOSvrNbk/Dk3ghSIwRtjNHfA75NlodTp7uHLwIGeziZZsl8v+gYSV+SRdbRqyeTBlG69zXUcSv8uw=
X-Received: by 10.129.182.2 with SMTP id u2mr3376577ywh.345.1519251910045;
 Wed, 21 Feb 2018 14:25:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 21 Feb 2018 14:25:09
 -0800 (PST)
In-Reply-To: <1519066406-81663-13-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com> <1519066406-81663-13-git-send-email-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Feb 2018 14:25:09 -0800
Message-ID: <CAGZ79kZbdvehOQMZj3NkkSt5RoArtv0ixb8pHvFDrHTrWmVuDg@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] commit-graph: read only from specific pack-indexes
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 10:53 AM, Derrick Stolee <stolee@gmail.com> wrote:
>
> Teach git-commit-graph to inspect the objects only in a certain list
> of pack-indexes within the given pack directory. This allows updating
> the commit graph iteratively, since we add all commits stored in a
> previous commit graph.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt | 11 +++++++++++
>  builtin/commit-graph.c             | 32 +++++++++++++++++++++++++++++---
>  commit-graph.c                     | 26 ++++++++++++++++++++++++--
>  commit-graph.h                     |  4 +++-
>  packfile.c                         |  4 ++--
>  packfile.h                         |  2 ++
>  t/t5318-commit-graph.sh            | 16 ++++++++++++++++
>  7 files changed, 87 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index b9b4031..93d50d1 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -42,6 +42,10 @@ With the `--delete-expired` option, delete the graph files in the pack
>  directory that are not referred to by the graph-latest file. To avoid race
>  conditions, do not delete the file previously referred to by the
>  graph-latest file if it is updated by the `--set-latest` option.
> ++
> +With the `--stdin-packs` option, generate the new commit graph by
> +walking objects only in the specified packfiles and any commits in
> +the existing graph-head.

A general question on this series:
How do commit graph buildups deal with garbage collected commits?
(my personal workflow is heavy on rebase, which generates lots of
dangling commits, to be thrown out later)

The second half of the sentence makes it sound like once a
commit is in the graph it cannot be pulled out easily again, hence
the question on the impact of graphs on a long living repository
which is garbage collected frequently.

AFAICT you could just run
    git commit-graph write --set-latest [--delete-expired]
as that actually looks up objects from outside the existing graph files,
such that lost objects are ignored?

> +       const char **lines = NULL;
> +       int nr_lines = 0;
> +       int alloc_lines = 0;

(nit:)
I had the impression that these triplet-variables, that are used in
ALLOC_GROW are allo X, X_nr and X_allow, but I might be wrong.

> @@ -170,7 +178,25 @@ static int graph_write(int argc, const char **argv)
>
>         old_graph_name = get_graph_latest_contents(opts.obj_dir);
>
> -       graph_name = write_commit_graph(opts.obj_dir);
> +       if (opts.stdin_packs) {
> +               struct strbuf buf = STRBUF_INIT;
> +               nr_lines = 0;
> +               alloc_lines = 128;

alloc_lines has been initialized before, so why redo it here again?
Also what is the rationale for choosing 128 as a good default?
I would guess 0 is just as fine, because ALLOC_GROW makes sure
that it growth fast in the first couple entries by having an additional
offset. (no need to fine tune the starting allocation IMHO)

> +               ALLOC_ARRAY(lines, alloc_lines);
> +
> +               while (strbuf_getline(&buf, stdin) != EOF) {
> +                       ALLOC_GROW(lines, nr_lines + 1, alloc_lines);
> +                       lines[nr_lines++] = buf.buf;
> +                       strbuf_detach(&buf, NULL);

strbuf_detach returns its previous buf.buf, such that you can combine these
two lines as
    lines[nr_lines++] = strbuf_detach(&buf, NULL);


> +               }
> +
> +               pack_indexes = lines;
> +               nr_packs = nr_lines;

Technically we do not need to strbuf_release(&buf) here, because
strbuf_detach is always called, and by knowing its implementation,
it is just as good.


> @@ -579,7 +581,27 @@ char *write_commit_graph(const char *obj_dir)
>                 oids.alloc = 1024;
>         ALLOC_ARRAY(oids.list, oids.alloc);
>
> -       for_each_packed_object(if_packed_commit_add_to_list, &oids, 0);
> +       if (pack_indexes) {
> +               struct strbuf packname = STRBUF_INIT;
> +               int dirlen;
> +               strbuf_addf(&packname, "%s/pack/", obj_dir);
> +               dirlen = packname.len;
> +               for (i = 0; i < nr_packs; i++) {
> +                       struct packed_git *p;
> +                       strbuf_setlen(&packname, dirlen);
> +                       strbuf_addstr(&packname, pack_indexes[i]);
> +                       p = add_packed_git(packname.buf, packname.len, 1);
> +                       if (!p)
> +                               die("error adding pack %s", packname.buf);
> +                       if (open_pack_index(p))
> +                               die("error opening index for %s", packname.buf);
> +                       for_each_object_in_pack(p, if_packed_commit_add_to_list, &oids);
> +                       close_pack(p);
> +               }

strbuf_release(&packname);

> +       }
> +       else

(micro style nit)

    } else
