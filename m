Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E6281F403
	for <e@80x24.org>; Sat,  9 Jun 2018 17:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932165AbeFIR4k (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 13:56:40 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:47073 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932146AbeFIR4k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 13:56:40 -0400
Received: by mail-ot0-f169.google.com with SMTP id q1-v6so19323423oth.13
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRAG+eKG8J/VO17aNxtV0LlI35HdK4Ct/7VFSMsazSA=;
        b=gtqXcGCYpWLmja/yZat2624v//aA2TFqvGxQQRhaekR4/dewJjUGUUGKnDw7Oo4UVK
         5FWgtuCnWANv5qIhNExs6wbD9rdv9cnnS251n+woRU1j/GfvY2PspbL/W4RPxj5yocfp
         ca6tVgHRJRLoibJEnqZludsmTr9vtAPC9q3brT3E7mx3HV+gFEuQgtj9chZc0rQjQY0l
         iMAnByZaaXs3mINpVgPgM1IjkXyR5zP8CUP8xZiacpg5IuzhKNx5ltBdci/j0mI6CF2P
         DCJcrBjvsjroefyT8+lCtTrIA3jXRVP120bqBi8Hi2h0WzX0zCOkDUQBoDAR8E7/Yaly
         nxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRAG+eKG8J/VO17aNxtV0LlI35HdK4Ct/7VFSMsazSA=;
        b=RJ6OCudfmr/5jMQ2/fIT1/Ty23Sqk6sQsKthy78FWj6wakyAyi7dKuWY/chGCnBYsv
         4aplGBsWDhSdvlVHcuA03sGPmVupu80j4pQXOaBsnoUkaH2hyrg6QCEr57cSFVfHb7Im
         lAO5oDwHQbiAIUhGaYo0mdxHGqZWN+uT9nNp12Cr/GEp8AebWKRQJwC1dcybKGTuBVS6
         12V2pgCTIhMBGieMJGC4QyluCFCWtSDtwPtODhEq8eBd5TM8EbslsDfBHX1VZdXqeVAF
         whiJB9TkqI3QHjWJUtY/wxwQH4sbN024cnd/Xcm1pOvSrSJ9s/LTKylTTQCqBRw2hslj
         tMBA==
X-Gm-Message-State: APt69E2wMQt7+wuecyqwxw2gqlRAXMAJvbtOUh4WmuUc7RsKeWbi+H39
        Sk0muXRLGBifqv1zFlGd/uNJXFzZnJHq0+tH8zk=
X-Google-Smtp-Source: ADUXVKIhkqYYKb09dj848gyLOKvsLhnkk0czhVbHZzAIUFP/tJmrVYG8Vi6kN6mL3+swiRtaDmmyVH/fiyaGD/6sSwg=
X-Received: by 2002:a9d:2989:: with SMTP id n9-v6mr6799105otb.152.1528566999458;
 Sat, 09 Jun 2018 10:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-18-dstolee@microsoft.com>
In-Reply-To: <20180607140338.32440-18-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Jun 2018 19:56:13 +0200
Message-ID: <CACsJy8CqoKWgd=ekxozaKzRjrU3NN9KUxrspk_iP+zxBVcV5pA@mail.gmail.com>
Subject: Re: [PATCH 17/23] midx: read objects from multi-pack-index
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

On Thu, Jun 7, 2018 at 6:55 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  midx.c         | 96 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  midx.h         |  2 ++
>  object-store.h |  1 +
>  packfile.c     |  8 ++++-
>  4 files changed, 104 insertions(+), 3 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 5e9290ca8f..6eca8f1b12 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -3,6 +3,7 @@
>  #include "dir.h"
>  #include "csum-file.h"
>  #include "lockfile.h"
> +#include "sha1-lookup.h"
>  #include "object-store.h"
>  #include "packfile.h"
>  #include "midx.h"
> @@ -64,7 +65,7 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>
>         m = xcalloc(1, sizeof(*m) + strlen(object_dir) + 1);
>         strcpy(m->object_dir, object_dir);
> -       m->data = midx_map;
> +       m->data = (const unsigned char*)midx_map;

Hmm? Why is this typecast only needed now? Or is it not really needed at all?

>
>         m->signature = get_be32(m->data);
>         if (m->signature != MIDX_SIGNATURE) {
> @@ -145,7 +146,9 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>
>         m->num_objects = ntohl(m->chunk_oid_fanout[255]);
>
> -       m->pack_names = xcalloc(m->num_packs, sizeof(const char *));
> +       m->packs = xcalloc(m->num_packs, sizeof(*m->packs));
> +
> +       ALLOC_ARRAY(m->pack_names, m->num_packs);

Please make this ALLOC_ARRAY change in the patch that adds
xcalloc(m->num_packs).

>         for (i = 0; i < m->num_packs; i++) {
>                 if (i) {
>                         if (ntohl(m->chunk_pack_lookup[i]) <= ntohl(m->chunk_pack_lookup[i - 1])) {
> @@ -175,6 +178,95 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>         exit(1);
>  }
>
> +static int prepare_midx_pack(struct midxed_git *m, uint32_t pack_int_id)
> +{
> +       struct strbuf pack_name = STRBUF_INIT;
> +
> +       if (pack_int_id >= m->num_packs)
> +               BUG("bad pack-int-id");
> +
> +       if (m->packs[pack_int_id])
> +               return 0;
> +
> +       strbuf_addstr(&pack_name, m->object_dir);
> +       strbuf_addstr(&pack_name, "/pack/");
> +       strbuf_addstr(&pack_name, m->pack_names[pack_int_id]);

Just use strbuf_addf()

> +
> +       m->packs[pack_int_id] = add_packed_git(pack_name.buf, pack_name.len, 1);
> +       strbuf_release(&pack_name);
> +       return !m->packs[pack_int_id];

This is a weird return value convention. Normally we go zero/negative
or non-zero/zero for success/failure.

> +}
-- 
Duy
