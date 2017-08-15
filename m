Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 242C9208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 17:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbdHORC6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:02:58 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33650 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752573AbdHORC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:02:57 -0400
Received: by mail-yw0-f171.google.com with SMTP id p68so8334712ywg.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=J7cILt67ScyZiLagf9HXvGDrpZw82oigmcAYz5qeUk0=;
        b=jaYgkDAbnu572GmVnGx/q4v6EDUH2KBB0O7+QNyyfEIaIUgruTH0QGbB3Dnwwhaa7J
         h0lohpQplNZr3cNxP5nroxGxrvase79zTq+h22nUzjLSoY1ChMSR0du9js22o4isTOx3
         Av0mdt7frVKIh9iYp+LRgQ3JG2JXcpZoZ9ab4hc2X8QiQ8PGPXvawP4xCpzQymuMmtPL
         5APUBum+l8CDb23cewKD7cz599s0aWV/EfSb2xuAGjfV7GoYT2hori7kwL2tnv4ktAQN
         4xPxqUxekArknKmCOvWwDSbUFoFjjywMm8gD0ZSpLTAuY4LupHEyEnWBwtVfAmW86viX
         ooFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=J7cILt67ScyZiLagf9HXvGDrpZw82oigmcAYz5qeUk0=;
        b=FA6rcKIkUh+TcEkHp+DBooH1aq5q0ua9VuZhHT2zEr4YnFIrPory2ea2vLkj8rEMJB
         bppfO7MBrg6Ch33gLvH5qCEUeuvgoeVMmzR0NZNsjfrWLg/4vRf8I6oS0JF88Oz6BitD
         tIrCii0xq0hYoj6T0Y4EfxfBwIbbfWFsV6JDX0mpKo2ZmfKou3cZuYFmxct+6+YBJhpR
         S07MY9g2NtlNsi0I0sycxzGac7+nGuN2m/A6IT7DWHjxJZ3fRQmWx0NpF04wW748CD/W
         oWABXeK2DBOzbP7T7b3LXrXCjWW1POq30G0f91kSRcgwF2K2uBjw/kX5/bJEZ9FLGn4R
         5s3A==
X-Gm-Message-State: AHYfb5hHbi/blYXKisFB4JnEQJ07loatpdzyEbUSKODEnv//u5lH67Ac
        gVnjOjU8y32OTp2BhOt3UVtm7WD1wqZr
X-Received: by 10.13.229.3 with SMTP id o3mr23073700ywe.137.1502816576889;
 Tue, 15 Aug 2017 10:02:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 10:02:56 -0700 (PDT)
In-Reply-To: <b5633a5425c623f3d2204325e99332b5bb511582.1502796628.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com> <b5633a5425c623f3d2204325e99332b5bb511582.1502796628.git.patryk.obara@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 10:02:56 -0700
Message-ID: <CAGZ79kaCtbuDEUJqJ+nVUW78ksLMyHZ2xhnbunUqzjkGRuYg+A@mail.gmail.com>
Subject: Re: [PATCH 3/5] commit: replace the raw buffer with strbuf in read_graft_line
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 4:49 AM, Patryk Obara <patryk.obara@gmail.com> wrote:
> This simplifies function declaration and allows for use of strbuf_rtrim
> instead of modifying buffer directly.
>
> Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
> ---
>  builtin/blame.c |  2 +-
>  commit.c        | 11 ++++++-----
>  commit.h        |  2 +-
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index bda1a78..d4472e9 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -488,7 +488,7 @@ static int read_ancestry(const char *graft_file)
>                 return -1;
>         while (!strbuf_getwholeline(&buf, fp, '\n')) {
>                 /* The format is just "Commit Parent1 Parent2 ...\n" */
> -               struct commit_graft *graft = read_graft_line(buf.buf, buf.len);
> +               struct commit_graft *graft = read_graft_line(&buf);
>                 if (graft)
>                         register_commit_graft(graft, 0);
>         }
> diff --git a/commit.c b/commit.c
> index 8b28415..499fb14 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -134,15 +134,16 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
>         return 0;
>  }
>
> -struct commit_graft *read_graft_line(char *buf, int len)
> +struct commit_graft *read_graft_line(struct strbuf *line)
>  {
>         /* The format is just "Commit Parent1 Parent2 ...\n" */
> -       int i;
> +       int i, len;
> +       char *buf = line->buf;
>         struct commit_graft *graft = NULL;
>         const int entry_size = GIT_SHA1_HEXSZ + 1;

outside the scope of this patch:
Is GIT_SHA1_HEXSZ or GIT_MAX_HEXSZ the right call here?

>
> -       while (len && isspace(buf[len-1]))
> -               buf[--len] = '\0';
> +       strbuf_rtrim(line);
> +       len = line->len;
>         if (buf[0] == '#' || buf[0] == '\0')
>                 return NULL;
>         if ((len + 1) % entry_size)
> @@ -174,7 +175,7 @@ static int read_graft_file(const char *graft_file)
>                 return -1;
>         while (!strbuf_getwholeline(&buf, fp, '\n')) {
>                 /* The format is just "Commit Parent1 Parent2 ...\n" */
> -               struct commit_graft *graft = read_graft_line(buf.buf, buf.len);
> +               struct commit_graft *graft = read_graft_line(&buf);
>                 if (!graft)
>                         continue;
>                 if (register_commit_graft(graft, 1))
> diff --git a/commit.h b/commit.h
> index 6d857f0..baecc0a 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -247,7 +247,7 @@ struct commit_graft {
>  };
>  typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
>
> -struct commit_graft *read_graft_line(char *buf, int len);
> +struct commit_graft *read_graft_line(struct strbuf *line);
>  int register_commit_graft(struct commit_graft *, int);
>  struct commit_graft *lookup_commit_graft(const struct object_id *oid);
>
> --
> 2.9.5
>
