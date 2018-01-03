Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B18F1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 21:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeACVUX (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 16:20:23 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34569 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbeACVUW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 16:20:22 -0500
Received: by mail-qt0-f193.google.com with SMTP id 33so3799308qtv.1
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 13:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dRba7EIbNKhHp19M5t/V8XWh4VVJmgdSk0zTNZiQ+P0=;
        b=gKY6IQqtQK7IptCW7nwh8O8DsK+KIipJAfZVqTN8WQmKkXmJrLO/zl/DYUoVn/M1GV
         VkZP7FWIlh5PRnrnFPdO5vkJb0hoa79nWQoxxus4BQwF2k/IDXB5c5K9GaSfO/wUynzu
         /ljqbtJi6FC3mgF46lZ+akJQ5rInQYEBEACp6+iPPbfIiCjU4lS3Sn2YCBWBRfbF1XTI
         AnB5iI9qphoI6KNaqcaiOhR999Xv8tgj+hsGU+/pbZ8tEALMC9XUUKJMjnR5KvvJ7FOn
         Or7v/rMP1PrPdiFba9CBb3OYMPl0BFk7lqeDJvguINJA9QDGuU73oMp7NgmQ2bzMq0xf
         sujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dRba7EIbNKhHp19M5t/V8XWh4VVJmgdSk0zTNZiQ+P0=;
        b=JBgXBhK7Jw04WLSJJJYEMvC9FhhKVAGmTvqO29CA8SCiUGTETL331oM8Ke+zDJlVnH
         hVQ4J3xQy8BBNfB4SsZ4St+j/gUBZ+jMrVbfgJ3iLs1W2QViwT9A2J1UJP9F30rBGt4v
         APu65dQZ9h5Y1d93Qd3VYL6gcK9wyo7z9UXIMS4GJBi6pWgxG7F4/xJn6RYk5XmjbqkE
         e4aNmARq3lOrX9sl/EASNkEr7B05yFzJ06rsxRj0OWyUQydoWdqd+Q7QQ/heZi/Ki9r7
         MP3bk9ONaSn84/9oXhq6HUeBEsF8w8RvqaC2LKeR1M+OCpnGbgwSY7IGPwVzgd9GOcch
         YJZA==
X-Gm-Message-State: AKGB3mJMWfft5d4MkoX3O5P5o5k0zJ1r10o6ZlLGXAAQkU7MVVsgHlaY
        APSnIay1oS3pSuxnUTd+jFt52hR0GwevMpjlQYYlXA==
X-Google-Smtp-Source: ACJfBouirGwmOC0QTKefiq2pcLtMFO4Bsqru0apYK/SQl7kRv+BehnlrG47BfmUU6WKcTRXxImthgUqpAYJEKHp9mr0=
X-Received: by 10.200.36.105 with SMTP id d38mr3655793qtd.180.1515014421339;
 Wed, 03 Jan 2018 13:20:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 3 Jan 2018 13:20:20 -0800 (PST)
In-Reply-To: <20180103001828.205012-7-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180103001828.205012-7-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 Jan 2018 13:20:20 -0800
Message-ID: <CAGZ79kbLJp=FDssowayYzyyHmRK65hDXeznvPbHLx5f6i0u3_w@mail.gmail.com>
Subject: Re: [PATCH 06/26] transport: use get_refs_via_connect to get refs
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
> Remove code duplication and use the existing 'get_refs_via_connect()'
> function to retrieve a remote's heads in 'fetch_refs_via_pack()' and
> 'git_transport_push()'.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  transport.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/transport.c b/transport.c
> index fc802260f..8e8779096 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -230,12 +230,8 @@ static int fetch_refs_via_pack(struct transport *transport,
>         args.cloning = transport->cloning;
>         args.update_shallow = data->options.update_shallow;
>
> -       if (!data->got_remote_heads) {
> -               connect_setup(transport, 0);
> -               get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
> -                                NULL, &data->shallow);
> -               data->got_remote_heads = 1;
> -       }
> +       if (!data->got_remote_heads)
> +               refs_tmp = get_refs_via_connect(transport, 0);
>
>         refs = fetch_pack(&args, data->fd, data->conn,
>                           refs_tmp ? refs_tmp : transport->remote_refs,
> @@ -541,14 +537,8 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
>         struct send_pack_args args;
>         int ret;
>
> -       if (!data->got_remote_heads) {
> -               struct ref *tmp_refs;
> -               connect_setup(transport, 1);
> -
> -               get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL,
> -                                NULL, &data->shallow);
> -               data->got_remote_heads = 1;
> -       }
> +       if (!data->got_remote_heads)
> +               get_refs_via_connect(transport, 1);
>
>         memset(&args, 0, sizeof(args));
>         args.send_mirror = !!(flags & TRANSPORT_PUSH_MIRROR);
> --
> 2.15.1.620.gb9897f4670-goog
>
