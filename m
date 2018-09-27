Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 343DC1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 18:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeI1BBw (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:01:52 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:47080 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI1BBw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:01:52 -0400
Received: by mail-yb1-f193.google.com with SMTP id o8-v6so1525932ybk.13
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 11:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MCvnAP2zvT/QwGm7nQg73QliWgy6DeR6eMAWVulyX10=;
        b=dthK2yOtLZ5/l+JEFeTiq4vp1dM3imB2OkHVsCkTQnpN9RskHuBQWjvk4X4ptoXtLl
         aq5rkS17Qh1EsqRRgQvfLt/gSMt6OdoE1kWlZJpzvJK/iassWR30sgNt4PMahlWzoNT0
         76W70QmfJLr7pdYiHGK1Ty4ZrQGSkCaMrjL8cNa103NlxKDPoWBQoNVSZ5Zyn/rwrrXk
         GmEktSbHJ5YDZMHazXi1gPXPRWrDBY9WvxjjpV8Mx2fjcnOuZBy2WAPkttvH9KW55UF0
         J/k7r/+zOoR6pwIyzJfdjAceNHZyopjbp6rUzVu7LkiU07GSD/1E0994soqW1dQg3D24
         1c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCvnAP2zvT/QwGm7nQg73QliWgy6DeR6eMAWVulyX10=;
        b=jE5XKRdTvPTuAg5GKRfcsWs6VWDprep9cAuN0g1V5upGRiemWz89nJdLMWo7FSGSmn
         dx9WQ/dDPp2bo+xfK9PdZTm9ZX/q5/5RmZgn2Tg+MAExxkDqmF6WWcG89rhTuJ29Tqau
         +VTiXM3tjWj5R4AE6hQby6ni7r/mpMtcvjw4r/TCr1eHhauLBWWb1lrpIHNh03nwVDJE
         xlW3rRBDeBcC7sbwLnmE5XEOUmDtIzpUHMcpFVFeMzDf8b9LNcJQBN+geS9Br1uwGdi9
         ZCuiB1+H0BdwrFmLsqqlNPA3k43f/9BEwhdRUvpi4V41awQGe0cIhtYG39Hvo6RHZK1E
         CE0A==
X-Gm-Message-State: ABuFfoi/4GYuY30IGIx4uLlzQo7+h36WbJ9zPssYjwEf4rc1BdNWWqxB
        Fp3SH66Ahvb+KqeRg80uDYEQSClftIiBSJbyGFgkDw==
X-Google-Smtp-Source: ACcGV603yiGHp5kp7/BWD/ffnknat0RD2NgzNTGy5Rvc9CF8hR7brwO5Qar/u1D3VffdMQ4/1cIJeHNe+LZ2F/pQacw=
X-Received: by 2002:a25:7505:: with SMTP id q5-v6mr6705360ybc.191.1538073735089;
 Thu, 27 Sep 2018 11:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180912053519.31085-1-steadmon@google.com> <20180927012455.234876-1-steadmon@google.com>
 <20180927012455.234876-3-steadmon@google.com>
In-Reply-To: <20180927012455.234876-3-steadmon@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Sep 2018 11:42:03 -0700
Message-ID: <CAGZ79kZuJr35b4ui3J_sMkscQDt+tx88jFgKY9CKn5CtHnN7tA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] archive: use packet_reader for communications
To:     Josh Steadmon <steadmon@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 6:25 PM Josh Steadmon <steadmon@google.com> wrote:
>
> Using packet_reader will simplify version detection and capability
> handling, which will make implementation of protocol v2 support in
> git-archive easier.
>
> This refactoring does not change the behavior of "git archive".
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>

This patch is
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks!

> ---
>  builtin/archive.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/archive.c b/builtin/archive.c
> index e74f675390..4eb547c5b7 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -27,10 +27,11 @@ static int run_remote_archiver(int argc, const char **argv,
>                                const char *remote, const char *exec,
>                                const char *name_hint)
>  {
> -       char *buf;
>         int fd[2], i, rv;
>         struct transport *transport;
>         struct remote *_remote;
> +       struct packet_reader reader;
> +       enum packet_read_status status;
>
>         _remote = remote_get(remote);
>         if (!_remote->url[0])
> @@ -38,6 +39,8 @@ static int run_remote_archiver(int argc, const char **argv,
>         transport = transport_get(_remote, _remote->url[0]);
>         transport_connect(transport, "git-upload-archive", exec, fd);
>
> +       packet_reader_init(&reader, fd[0], NULL, 0, PACKET_READ_CHOMP_NEWLINE);
> +
>         /*
>          * Inject a fake --format field at the beginning of the
>          * arguments, with the format inferred from our output
> @@ -53,18 +56,20 @@ static int run_remote_archiver(int argc, const char **argv,
>                 packet_write_fmt(fd[1], "argument %s\n", argv[i]);
>         packet_flush(fd[1]);
>
> -       buf = packet_read_line(fd[0], NULL);
> -       if (!buf)
> +       status = packet_reader_read(&reader);
> +
> +       if (status != PACKET_READ_NORMAL || reader.pktlen <= 0)
>                 die(_("git archive: expected ACK/NAK, got a flush packet"));
> -       if (strcmp(buf, "ACK")) {
> -               if (starts_with(buf, "NACK "))
> -                       die(_("git archive: NACK %s"), buf + 5);
> -               if (starts_with(buf, "ERR "))
> -                       die(_("remote error: %s"), buf + 4);
> +       if (strcmp(reader.line, "ACK")) {
> +               if (starts_with(reader.line, "NACK "))
> +                       die(_("git archive: NACK %s"), reader.line + 5);
> +               if (starts_with(reader.line, "ERR "))
> +                       die(_("remote error: %s"), reader.line + 4);
>                 die(_("git archive: protocol error"));
>         }
>
> -       if (packet_read_line(fd[0], NULL))
> +       status = packet_reader_read(&reader);
> +       if (status == PACKET_READ_NORMAL && reader.pktlen > 0)
>                 die(_("git archive: expected a flush"));
>
>         /* Now, start reading from fd[0] and spit it out to stdout */
> --
> 2.19.0.605.g01d371f741-goog
>
