Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11D2B1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 15:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeJBWYN (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 18:24:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34628 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeJBWYN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 18:24:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so189253pfi.1
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rZrLH79DnoyQ5TlIZ0TG1BGJXoIUb8PnJIxPS3DNKIE=;
        b=cH8Z9MRI/5AedSBNVJyylgfUmpI3PzbMjt7KuRoOb64S30FDA1Rd5S8lSzYs/PWW8x
         XnrZ8doIOHGkZCjzLi4gaWI+r0jPKBQLYlot39I8zwb0rY6GSbhQbbjqmBBlKb54DkG3
         zjhkxvdFYXAba520/3Se9+7k+cBZIRHhXbSOVBxFWnbdyfPJmAJzs9Mi7xMQiK7XI0IO
         kL2aUOj2/vFSousfV49R8xswcQp4VMDwJip+LEJcJUtnvG/YmYd4YptCAkshKuvDbuSC
         4sjMK4TQL+IbOPokZwns6GRVv2eD2xBMzc6l2rjkXF3J38+ArIu4pw0WyNLmhgubgUy/
         zjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rZrLH79DnoyQ5TlIZ0TG1BGJXoIUb8PnJIxPS3DNKIE=;
        b=RYb+8KfKYUVH7Z72hi3lOFokodz+mV1Zml38VjaL3XjPrSuoDzHg4lGQc9p4CS9Tlg
         TyHQOeW8KQXgudqP3Mz99TsnxjZzFR8eSlAVtU4YoQ7aW4AbLWxgEJ0npC4UYP5wguZD
         OqCKOu5T3AFOBbqKrZilqjyTbqxLFm+VgtErWQd9/jUf02ubZ1jeWRnAdhZLt1CO/Tu1
         Qkcp9AvJgrmmf5pV7HXT5P9eRIn4t5OQtptqgUIo27n4JKcMuUALNB7HHx5PWfUajY6S
         xzJWguali5OrqBz5K6SXpsHb+ILXrZsemlK+m07UGK4yLwYzwMybJl/aGwmGy0hKtSSN
         O84Q==
X-Gm-Message-State: ABuFfogHAZswP4mVFJgtdim8wlw6PIEKyz2v++Cj2b9ryoJTcLvGy8Tw
        q1M8vcNNXPhn0/dFv545M7WY5cadNyZeAUSNtoA=
X-Google-Smtp-Source: ACcGV619ioc30UeaR4/j9foH+PGPEPb981ZX+bYVZEtbvCeb0ybVaXFMnG8l3eh9WkfUMBelVaEp4C2FNg6EP5bnRSo=
X-Received: by 2002:a62:2646:: with SMTP id m67-v6mr17031202pfm.254.1538494813775;
 Tue, 02 Oct 2018 08:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.42.git.gitgitgadget@gmail.com> <6906c25415eddf79cc3f71f905a77b140f2f66f0.1538492321.git.gitgitgadget@gmail.com>
In-Reply-To: <6906c25415eddf79cc3f71f905a77b140f2f66f0.1538492321.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 2 Oct 2018 17:40:01 +0200
Message-ID: <CAN0heSomOen+mWg1CuPGUCJFgmDQUjGLtAdxpWLwrStRU4Me8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit-graph: clean up leaked memory during write
To:     gitgitgadget@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Oct 2018 at 17:01, Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/commit-graph.c b/commit-graph.c
> index 2a24eb8b5a..7226bd6b58 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -698,6 +698,8 @@ void write_commit_graph_reachable(const char *obj_dir=
, int append,
>         string_list_init(&list, 1);
>         for_each_ref(add_ref_to_list, &list);
>         write_commit_graph(obj_dir, NULL, &list, append, report_progress)=
;
> +
> +       string_list_clear(&list, 0);
>  }

Nit: The blank line adds some asymmetry, IMVHO.

>  void write_commit_graph(const char *obj_dir,
> @@ -846,9 +848,11 @@ void write_commit_graph(const char *obj_dir,
>         compute_generation_numbers(&commits, report_progress);
>
>         graph_name =3D get_commit_graph_filename(obj_dir);
> -       if (safe_create_leading_directories(graph_name))
> +       if (safe_create_leading_directories(graph_name)) {
> +               UNLEAK(graph_name);
>                 die_errno(_("unable to create leading directories of %s")=
,
>                           graph_name);
> +       }

Do you really need this hunk? In my testing with LeakSanitizer and
valgrind, I don't need this hunk to be leak-free. Generally speaking, it
seems impossible to UNLEAK when dying, since we don't know what we have
allocated higher up in the call-stack.

Without this hunk, this patch can have my

Reviewed-by: Martin =C3=85gren <martin.agren@gmail.com>

as I've verified the leaks before and after. With this hunk, I am
puzzled and feel uneasy, both about having to UNLEAK before dying and
about having to UNLEAK outside of builtin/.

> +       free(graph_name);
> +       free(commits.list);
>         free(oids.list);
>         oids.alloc =3D 0;
>         oids.nr =3D 0;

Both `commits` and `oids` are on the stack here, so cleaning up one more
than the other is a bit asymmetrical. Also, if we try to zero the counts
-- which seems unnecessary to me, but which is not new with this patch --
we should perhaps use `FREE_AND_NULL` too. But personally, I would just
use `free` and leave `nr` and `alloc` at whatever values they happen to
have.

Martin
