Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EE4820323
	for <e@80x24.org>; Tue, 21 Mar 2017 11:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932338AbdCULrn (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 07:47:43 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33882 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbdCULrm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 07:47:42 -0400
Received: by mail-oi0-f66.google.com with SMTP id w81so6037501oig.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 04:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tCgTXoSxI027e+T8AKqSBleODHp0Oc/wkqNv9n+tm8I=;
        b=kiKHee6Me7wKFLoBc199JlJJxSYCZLjcNnPkGFz4Kg676l0uJcNJZ6ePf3cQLTCc4+
         yt1BmX74u1MCWR18RSmhZ9sdsSDdCF15M7cJJGCz5+VQOnek4aNvdaIz5xUrS7k+ABEG
         Eg0A+Vt1x5yBEIEOT5iTuek5Y3pPipByUT6HzqMbqAVSkztOttxXSTArhIZ9gXPDW82u
         8VyufNjP9VQ0m0MlEjM7qTWMmLxTP8oc43E49mmxCPDma2THmgv7fxiG2B9KcsZm+ASn
         Yl/nilNiwUrGFjOWIv+s1WyrK51LwVu/ieVySUY8BwuLzf/gix+kQUaITj2csHSsrfwm
         HOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tCgTXoSxI027e+T8AKqSBleODHp0Oc/wkqNv9n+tm8I=;
        b=l+GAnD/yiZaQcGAPfjLYGMVxU9/Ds2tEewK9bM9jNzBhM5AJSBTI4lZ12NPQgCurAD
         rrXhslktZ3OdRIqAn13TyQO1aJg9he07KutRNt+hB8KxFeSvzFKhXG3ZuxCXqVNJmia4
         BGtOyjSm9ksls9JijHC8+4HJ2Yrh9ya2HjmxxoiZnR3ZSQgzhezNmmCEOgHKfGS96gKV
         x5az3UzqPquT3gP7sqS3dNg5u44+Mh8IKr+wtow0ly1Xer/s5frqStjGIlw+oT56IA9k
         V6QWzVNm35rV/Phs3IH1/X52c1Iq164BB0BFgJoMvV5d2/J5KamtsenMu7KJRhag+Du4
         wgxw==
X-Gm-Message-State: AFeK/H2as/CM+AL/U/hFLsUwYB396VRJ8KuNvJ8cMOZGRUGeMCm3K9risK0fYFUKvSe9TlEaZgIZYCw0jCpLXw==
X-Received: by 10.202.83.20 with SMTP id h20mr18293042oib.65.1490096861288;
 Tue, 21 Mar 2017 04:47:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Tue, 21 Mar 2017 04:47:10 -0700 (PDT)
In-Reply-To: <20170317172257.4690-4-bmwill@google.com>
References: <20170314221100.24856-1-bmwill@google.com> <20170317172257.4690-1-bmwill@google.com>
 <20170317172257.4690-4-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 Mar 2017 18:47:10 +0700
Message-ID: <CACsJy8Cu8cgtJzDDM09GoJr5Ny+G+nP17GjZjXng6ZPQv9eXXg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] grep: fix bug when recursing with relative pathspec
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 12:22 AM, Brandon Williams <bmwill@google.com> wrote:
> With these two pieces of information a child process can correctly
> interpret the pathspecs provided by the user as well as being able to
> properly format its output relative to the directory the user invoked
> the original command from.

This part can stand alone as a separate patch right? It would help
focus on the pathspec thingy first.

> @@ -399,13 +405,12 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
>  }
>
>  static void compile_submodule_options(const struct grep_opt *opt,
> -                                     const struct pathspec *pathspec,
> +                                     const char **argv,
>                                       int cached, int untracked,
>                                       int opt_exclude, int use_index,
>                                       int pattern_type_arg)
>  {
>         struct grep_pat *pattern;
> -       int i;
>
>         if (recurse_submodules)
>                 argv_array_push(&submodule_options, "--recurse-submodules");

Side note. It would be awesome if you could make parse_options() (or a
new function) do the reverse process: given a 'struct option' with
valid data, spit out argv_array. Less worrying about git-grep having
new option but not passed to subgrep by accident. You can have a new
flag to tell it to ignore certain options if you don't want to pass
all.
-- 
Duy
