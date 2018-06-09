Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8AC31F403
	for <e@80x24.org>; Sat,  9 Jun 2018 17:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932141AbeFIRsR (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 13:48:17 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36314 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753342AbeFIRsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 13:48:16 -0400
Received: by mail-oi0-f66.google.com with SMTP id 14-v6so14589690oie.3
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 10:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OxW4HP/iKJp53TnZGWhuP0584tC4iHMuvF4AMKtiI/k=;
        b=lZlyY0ahsj+MRDVElDKvE5lJ5Eqg/oY8whw6ud/PGT+tEFc4loJshtvhNBUvRAnUrD
         j+l27hX44xc10pGf3oeC+qLPww7KurHKxbAr/t0z1OWx5VNsg8cIaPRYHFda1tIS9b4T
         3mnHs6uBxFHtMtvDn548U5mdpEIUcLFwz+JezXi8F4H3c3ADL1ZewaWfGojb8zsInK5p
         Wxigb5vzs7FGQh4/B4qsBlNSnGTnHm83WwW0BOZNv9oWep5A2mGk/TNcHjfNIUe/sdKY
         Xn9pzJoIurM3efVCfrkMPmjaFpUpDgNOBX6nVwycfWx3U+m5nwNgxZGM/V2tIZThHViE
         Ir4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OxW4HP/iKJp53TnZGWhuP0584tC4iHMuvF4AMKtiI/k=;
        b=GPM3nQml1INbZAxiHgy+NlNTvkxZzx3CSmDcX5UA+bl+lGf24Aa5kP1BtekF3jkRxg
         Rer2eHVxZREtiTBg1jESN3MeqsMjhbx0QaryldnKtK5Lm0vE/3MadUvUMkzD/4IqG4eG
         n6v2kwcIO0PmhUIiECNusyHyV3xAgWJBIHKXaRxVkAvpPy87rYFQRhzpmnuRwlYWiQYI
         5OSSIEKj+jXvmzOKDux7yPvIpYRabieU0WNBJjixZfoRnVyaTIjr0l5XSoYi+mO/KQPa
         CAr01CyQCJZub7I5LiCg0uuXOSyfYr+yFkSPwlh/SjBPr848DvtaZEytnf/vWlQ1G1di
         v9zw==
X-Gm-Message-State: APt69E0gaeCicawI45TWNhXx+Vap8DLdKeSxiocj449SZJhT+VAXfFAc
        Kv7hE/gq3s0GHgOvvKRZs/MYy1CTPfuLipbdS5A=
X-Google-Smtp-Source: ADUXVKI9NnKOWlPw9nvLDqo6CRLta8B2uimUotboQaqeuzbeWKzVqWnVAcXFdlYjxTDhRjaexnqDANopPKOrITDD+nw=
X-Received: by 2002:aca:f02:: with SMTP id 2-v6mr5780204oip.216.1528566496064;
 Sat, 09 Jun 2018 10:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-17-dstolee@microsoft.com>
In-Reply-To: <20180607140338.32440-17-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Jun 2018 19:47:50 +0200
Message-ID: <CACsJy8BD+hiA61gUb-EjoUnx2E9WtCrSBAtHDZuEVFp3M+jOWw@mail.gmail.com>
Subject: Re: [PATCH 16/23] midx: prepare midxed_git struct
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 7:02 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  midx.c         | 22 ++++++++++++++++++++++
>  midx.h         |  2 ++
>  object-store.h |  7 +++++++
>  packfile.c     |  6 +++++-
>  4 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/midx.c b/midx.c
> index a49300bf75..5e9290ca8f 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -175,6 +175,28 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>         exit(1);
>  }
>
> +int prepare_midxed_git_one(struct repository *r, const char *object_dir)
> +{
> +       struct midxed_git *m = r->objects->midxed_git;
> +       struct midxed_git *m_search;
> +
> +       if (!core_midx)
> +               return 0;
> +
> +       for (m_search = m; m_search; m_search = m_search->next)
> +               if (!strcmp(object_dir, m_search->object_dir))
> +                       return 1;
> +
> +       r->objects->midxed_git = load_midxed_git(object_dir);
> +
> +       if (r->objects->midxed_git) {
> +               r->objects->midxed_git->next = m;
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
>  static size_t write_midx_header(struct hashfile *f,
>                                 unsigned char num_chunks,
>                                 uint32_t num_packs)
> diff --git a/midx.h b/midx.h
> index a1d18ed991..793203fc4a 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -5,8 +5,10 @@
>  #include "cache.h"
>  #include "object-store.h"
>  #include "packfile.h"
> +#include "repository.h"
>
>  struct midxed_git *load_midxed_git(const char *object_dir);
> +int prepare_midxed_git_one(struct repository *r, const char *object_dir);
>
>  int write_midx_file(const char *object_dir);
>
> diff --git a/object-store.h b/object-store.h
> index 9b671f1b0a..7908d46e34 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -130,6 +130,13 @@ struct raw_object_store {
>          */
>         struct oidmap *replace_map;
>
> +       /*
> +        * private data
> +        *
> +        * should only be accessed directly by packfile.c and midx.c
> +        */
> +       struct midxed_git *midxed_git;
> +
>         /*
>          * private data
>          *
> diff --git a/packfile.c b/packfile.c
> index 1a714fbde9..b91ca9b9f5 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -15,6 +15,7 @@
>  #include "tree-walk.h"
>  #include "tree.h"
>  #include "object-store.h"
> +#include "midx.h"
>
>  char *odb_pack_name(struct strbuf *buf,
>                     const unsigned char *sha1,
> @@ -893,10 +894,13 @@ static void prepare_packed_git(struct repository *r)
>
>         if (r->objects->packed_git_initialized)
>                 return;
> +       prepare_midxed_git_one(r, r->objects->objectdir);
>         prepare_packed_git_one(r, r->objects->objectdir, 1);
>         prepare_alt_odb(r);
> -       for (alt = r->objects->alt_odb_list; alt; alt = alt->next)
> +       for (alt = r->objects->alt_odb_list; alt; alt = alt->next) {
> +               prepare_midxed_git_one(r, alt->path);
>                 prepare_packed_git_one(r, alt->path, 0);
> +       }

Ah, so the object path and the linked list in midxed_git is for
alternates. Makes sense. Would have saved me the trouble if you only
introduced those fields now, when they are actually used (and become
self explanatory)

>         rearrange_packed_git(r);
>         prepare_packed_git_mru(r);
>         r->objects->packed_git_initialized = 1;
> --
> 2.18.0.rc1
>
-- 
Duy
