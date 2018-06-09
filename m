Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA8A11F403
	for <e@80x24.org>; Sat,  9 Jun 2018 18:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbeFISDr (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 14:03:47 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43891 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753263AbeFISDq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 14:03:46 -0400
Received: by mail-ot0-f193.google.com with SMTP id i19-v6so19354317otk.10
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jF1+Kf5R/nGSM8tuSYd3AZcC8eTlLvkxtJsdlyEL7Qo=;
        b=a4lR5QBed+rTAO3C1XcCr3pgnWsbcRdRM+8zt9CCEq5HK1yC8LQ+KzO3AYnMKbZFmD
         gY/be3C6qZ8s2bPDnmzJnzW+wp8iSjAF6aAYB9GHYZA+FROlI5vHJay1AZcF/Tb+VsIG
         GMk4rmODY2wMYZsUOt6Q/G/Cwsgmer4PMuVfM4OQ1wskOdOF0ObRLXqnn+3ZxOd1D1XS
         19cAcPqHcSofQoxUh9CcfsTWgo6s2s2Oag9JafGdh8G3YJcsmrmELphclkhCScfYKDeM
         tayCA7mjZYbm71Qr6zH4I7WAdb3s/lziTYTGZzkUEQQe6tzb+KT4b5/Po616GxNExYPv
         YFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jF1+Kf5R/nGSM8tuSYd3AZcC8eTlLvkxtJsdlyEL7Qo=;
        b=A3BtvTTvPxUQRiKqguJm3yw1NB6BwsrfD4cGaRrpfpVB8aRiaf6DwQicEtlAacXOeP
         HmBrCgz/nUOYILmvhkPqyvxxrGnLzW1BTLEA0eSCXV+qFl3ejjEJ6cw/RLVzLEXbalT4
         zuWEA0g559k1STGMuBo4QpoNRhR+NW+07Q5eFlPUE3gMGqsY0emTCi5brEimYTSOU5vs
         kb5UgKuG/zx65XJOecMWVZdRDusaFPsm4JASSLOhbXk193tcoxcRkHYKndnnpCR/PjrY
         fWi4+I7VHDTcXZdCefbNEjJ75TPTqCD8g2N70eAn7ewr9o/Om9rw6g5C4Q0O285sDA/K
         jEUQ==
X-Gm-Message-State: APt69E3cA5IgUVYs3/LNYP0mHpYEvL3HZUH7aGy8+OrNoYg+OQPGDDcY
        Sd8KwUX14aIrmMJ7ueLySnY2SezmBO8t/cbXZBM=
X-Google-Smtp-Source: ADUXVKJj3WSkNRuMXZ/GeWlv/ctTdWm6CIYGZKYEH3kV0XEGnuzh6aiX2ysFJh5Q1ZBwXvR8BKfQkUGD/MI9hhZRsbg=
X-Received: by 2002:a9d:2989:: with SMTP id n9-v6mr6813241otb.152.1528567425790;
 Sat, 09 Jun 2018 11:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-21-dstolee@microsoft.com>
In-Reply-To: <20180607140338.32440-21-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Jun 2018 20:03:19 +0200
Message-ID: <CACsJy8AtkVwGw0+tgpv2AzNZMHGTOfkjHUN-37owaRWuQ_2wKw@mail.gmail.com>
Subject: Re: [PATCH 20/23] midx: use midx in approximate_object_count
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

On Thu, Jun 7, 2018 at 4:06 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  packfile.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/packfile.c b/packfile.c
> index 638e113972..059b2aa097 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -819,11 +819,14 @@ unsigned long approximate_object_count(void)
>  {
>         if (!the_repository->objects->approximate_object_count_valid) {
>                 unsigned long count;
> +               struct midxed_git *m;
>                 struct packed_git *p;
>
>                 prepare_packed_git(the_repository);
>                 count = 0;
> -               for (p = the_repository->objects->packed_git; p; p = p->next) {
> +               for (m = get_midxed_git(the_repository); m; m = m->next)
> +                       count += m->num_objects;
> +               for (p = get_packed_git(the_repository); p; p = p->next) {

Please don't change this line, it's not related to this patch. Same
concern applies, if we have already counted objects in midx we should
ignore packs that belong to it or we double count.

>                         if (open_pack_index(p))
>                                 continue;
>                         count += p->num_objects;
> --
> 2.18.0.rc1
>


-- 
Duy
