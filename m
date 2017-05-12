Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48EF2201A7
	for <e@80x24.org>; Fri, 12 May 2017 18:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757145AbdELSAl (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 14:00:41 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36958 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756500AbdELSAj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 14:00:39 -0400
Received: by mail-wm0-f54.google.com with SMTP id d127so22028548wmf.0
        for <git@vger.kernel.org>; Fri, 12 May 2017 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3bmtMxiYE48rs5uRMf3uAalnDlQ28k80uyRFdlFq49E=;
        b=NGrVfpt0KuUShjnF8EmijeQnpoliInKo22VsqwRRDsllgu7PT1pqsV+vDetsz9sseb
         2begZTi1CbdYchmZNlDwB56yRxgqpa6wbRzyDTZFktyWjAvXCcKtH9uAoM4f+dVoupOA
         J2H9ojcP4aNlu9ffMnLZMjZ7oiKOufRi63grxeVI0euW52TBz69popHLOIuhlooz+Fv9
         6qX9YypvzjzR1w7pRr9Jgpv60K2gXbUdYLnv5GzFSvQWHuRK47GoWfSHxORMlzAbd+r3
         Q6wCeIJVHg9jGE5hO/+OUoTETJFmp+UpYN9pb+n49QJiyLdPs2WEbrjuQinY2u+9MaRK
         SYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3bmtMxiYE48rs5uRMf3uAalnDlQ28k80uyRFdlFq49E=;
        b=mG1PO7ltjjHnumJL0dNhBHiUGPy38b+y5aesqhzjyMCJhdCV9CFb+jSUfg+DvbCBZ3
         WjcBJcRzTo5s56tC7njNPswWyNAyCuXuTmxPtdzZNmirIgNEe2/ql+6mMcW6zYL9YrPK
         RHKMqsypdDahyNTyWzkL9F0vsuP+TX4nT9u3SMsQ0Q92QK3dj2ChiTB7fGmeZIhU2d2O
         mc4X/EJz0rO/QS3IVZ39Pwu7HuJkfXeL7np4jP4fl98ziBW5UbJdxyaHuI0EQuivUYgU
         sJHWHIHH5c+gz1pBFIeKnkQDnH1lKw3v2n65R7RkAd64CEFZXiJdGPnfKUgxjx+nTbEj
         rsWw==
X-Gm-Message-State: AODbwcCU09cpA3Z+vsx9bvFMkQENLOiz7Ub5R8CcNJjzvanFbGhVUc2e
        6uZVL3yX7X6BXQpdVEwP8U2TIJpNbL/a
X-Received: by 10.28.141.140 with SMTP id p134mr3218352wmd.54.1494612037881;
 Fri, 12 May 2017 11:00:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.48.66 with HTTP; Fri, 12 May 2017 11:00:36 -0700 (PDT)
In-Reply-To: <20170512081417.w537fmd4o5rl4kja@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170511223054.25239-1-jonathantanmy@google.com> <20170511224639.GC21723@aiede.svl.corp.google.com>
 <xmqq37ca7gw0.fsf@gitster.mtv.corp.google.com> <20170512075931.umunxd72nj53snds@sigill.intra.peff.net>
 <20170512081417.w537fmd4o5rl4kja@sigill.intra.peff.net>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Fri, 12 May 2017 11:00:36 -0700
Message-ID: <CAGf8dgLcCeMYGPF1PSPy5M5zLvj2hb_EfpDBPbcNe+96c9YpRA@mail.gmail.com>
Subject: Re: [PATCH v5] fetch-pack: always allow fetching of literal SHA1s
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 1:14 AM, Jeff King <peff@peff.net> wrote:
> diff --git a/fetch-pack.c b/fetch-pack.c
> index afb8b0502..e167213c0 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -15,6 +15,7 @@
>  #include "version.h"
>  #include "prio-queue.h"
>  #include "sha1-array.h"
> +#include "oidset.h"
>
>  static int transfer_unpack_limit = -1;
>  static int fetch_unpack_limit = -1;
> @@ -592,13 +593,27 @@ static void mark_recent_complete_commits(struct fetch_pack_args *args,
>         }
>  }
>
> +static int is_literal_sha1(const struct ref *ref)
> +{
> +       struct object_id oid;
> +       const char *end;
> +       return !parse_oid_hex(ref->name, &oid, &end) &&
> +              !*end &&
> +              !oidcmp(&oid, &ref->old_oid);
> +}
> +
>  static void filter_refs(struct fetch_pack_args *args,
>                         struct ref **refs,
>                         struct ref **sought, int nr_sought)
>  {
>         struct ref *newlist = NULL;
>         struct ref **newtail = &newlist;
> +       struct ref *unmatched = NULL;
>         struct ref *ref, *next;
> +       struct oidset tip_oids = OIDSET_INIT;
> +       int send_raw_oids = (allow_unadvertised_object_request &
> +                            (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
> +       int seeking_raw_oid = 0;
>         int i;
>
>         i = 0;
> @@ -617,7 +632,8 @@ static void filter_refs(struct fetch_pack_args *args,
>                                 else if (cmp == 0) {
>                                         keep = 1; /* definitely have it */
>                                         sought[i]->match_status = REF_MATCHED;
> -                               }
> +                               } else if (is_literal_sha1(sought[i]))
> +                                       seeking_raw_oid = 1;

As far as I can tell, this seems to coincidentally work because SHA-1s
as strings compare less than any ref name (HEAD or refs/...) - if this
weren't the case, the "break" statement above might cause this line to
never be executed. I'm not sure if we want to rely on that.

>                                 i++;
>                         }
>                 }
> @@ -631,24 +647,27 @@ static void filter_refs(struct fetch_pack_args *args,
>                         ref->next = NULL;
>                         newtail = &ref->next;
>                 } else {
> -                       free(ref);
> +                       ref->next = unmatched;
> +                       unmatched = ref;
>                 }
>         }
>
> +       if (seeking_raw_oid && !send_raw_oids) {
> +               for (ref = newlist; ref; ref = ref->next)
> +                       oidset_insert(&tip_oids, &ref->old_oid);
> +               for (ref = unmatched; ref; ref = ref->next)
> +                       oidset_insert(&tip_oids, &ref->old_oid);
> +       }
> +
>         /* Append unmatched requests to the list */
>         for (i = 0; i < nr_sought; i++) {
> -               unsigned char sha1[20];
> -
>                 ref = sought[i];
>                 if (ref->match_status != REF_NOT_MATCHED)
>                         continue;
> -               if (get_sha1_hex(ref->name, sha1) ||
> -                   ref->name[40] != '\0' ||
> -                   hashcmp(sha1, ref->old_oid.hash))
> +               if (!is_literal_sha1(ref))
>                         continue;
>
> -               if ((allow_unadvertised_object_request &
> -                   (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
> +               if (send_raw_oids || oidset_contains(&tip_oids, &ref->old_oid)) {
>                         ref->match_status = REF_MATCHED;
>                         *newtail = copy_ref(ref);
>                         newtail = &(*newtail)->next;
> @@ -656,6 +675,13 @@ static void filter_refs(struct fetch_pack_args *args,
>                         ref->match_status = REF_UNADVERTISED_NOT_ALLOWED;
>                 }
>         }
> +
> +       oidset_clear(&tip_oids);
> +       for (ref = unmatched; ref; ref = next) {
> +               next = ref->next;
> +               free(ref);
> +       }
> +
>         *refs = newlist;
>  }
>
