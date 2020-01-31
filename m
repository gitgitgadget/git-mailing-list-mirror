Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D55C33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 06:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABC520705
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 06:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1nJ9x71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgAaGwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 01:52:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41764 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgAaGwO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 01:52:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id t14so2336078plr.8
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 22:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvzushbbK8pdygl48FbBlZB9bAyHKjIXrSGujZpARN4=;
        b=J1nJ9x71spekYcQ7+W1RDuuG3C4ulps35ab27uGUooKNbdA9LZJ/XMbWIl91KFpj9w
         HKbPfwPeVXJWJRr5ikwAPoeAJS+RyBC3eeEc9Vsh2a1/v3xd3QnOWQZenCr+JQ0OpkaU
         2d9EsjeHH8EOgLuL2lYFXv6uixGeh/jAvpVCmMnin7Vz2tk5WwLVFaDTpk+9ubtjl0+2
         pVFokj0BslnGNOwzqnHzbNhJYWL7DkLiGBmoxBpC09/AdpfDzDkBUn4ZFYk+WleCQdlD
         m/7kGUZp/rxoJPfU2ks95ES48nmDKakkgatnC/bw0djoO9PJO+8kXNpX+u5tMh0o0fEs
         lfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvzushbbK8pdygl48FbBlZB9bAyHKjIXrSGujZpARN4=;
        b=Tx//D3Zxv2XdHE8r6BW165xkrkoDl1QcLsHFR7ym18Pj7QvhxSR7GxUrmrZi79mqmG
         sS76osNnMevHin2CCHgPX4wquz9zs29w+TLTlTihplIjYrg3OlJ+AY6/osUliDsA8o6p
         EgjxY8kcmnjLYWxKChsDyCw/8m4YyqdltFiqVoI7P5KXCcCF/KLlAmRoG5/aGCOCgJ+I
         CMV30KK7HgEh5h06LNC0RRQZLp3nkahqrFknY9635BluxhmcOYVPmcIxmHzrA95Rjn3f
         oWg/u4K4jS5wTXe4ca5rO3njoP0PFQflNhqrGe5EefNQ4jqplbW+xoJhFvXSStVdUAXq
         4jsA==
X-Gm-Message-State: APjAAAU4TIaRrc0XYsJXMkvQjM1dQpBOVsgP0h/kiJnJMmb9sFTN/RHy
        ZHyzSk03PuYiZGEP9kmauONETQvFPz3SVSP5kUaFh1ba
X-Google-Smtp-Source: APXvYqw0WX0dLnO9oK3lMqRQhr8Q6I7eRrg4nYX2C/4c3a6rCFNe3zfRvHnqBZwiRGibZIAcgJ0EEwU7lzOsCAfbr+o=
X-Received: by 2002:a17:90a:2545:: with SMTP id j63mr10912846pje.128.1580453533971;
 Thu, 30 Jan 2020 22:52:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580424766.git.me@ttaylorr.com> <890e0e7136204f5ca47f0703f32b4adb99ad8d7e.1580424766.git.me@ttaylorr.com>
In-Reply-To: <890e0e7136204f5ca47f0703f32b4adb99ad8d7e.1580424766.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 31 Jan 2020 07:52:02 +0100
Message-ID: <CAN0heSrrrWjBKnzjMfzEkTMVTge2AfVdwsp6D5Mx==5S8-ZLJQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] commit-graph.h: store object directory in 'struct commit_graph'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 31 Jan 2020 at 00:03, Taylor Blau <me@ttaylorr.com> wrote:
> Instead of getting rid of the 'struct object_directory *', store that
> insead of a 'char *odb' in 'struct commit_graph'. Once the 'struct

s/insead/instead/

>         if (open_ok)
>                 graph = load_commit_graph_one_fd_st(fd, &st);
> -        else
> -               graph = read_commit_graph_one(the_repository, opts.obj_dir);
> +       else {
> +               struct object_directory *odb;
> +               if ((odb = find_odb(the_repository, opts.obj_dir)))
> +                       graph = read_commit_graph_one(the_repository, odb);
> +       }

I'm a tiny bit allergic to this assignment-within-if. It's wrapped by
another pair of parentheses, which both compilers and humans know to
interpret as "trust me, this is not a mistake", but I still find this
easier to read:

  odb = find_odb(...);
  if (odb)
          ....

> --- a/builtin/commit.c
> +++ b/builtin/commit.c

> +#include "object-store.h"

This is the only change in this file, which looks a bit odd. I haven't
actually applied your patches, to be honest, but is this inclusion
really needed?

> --- a/commit-graph.c
> +++ b/commit-graph.c

> +struct object_directory *find_odb(struct repository *r, const char *obj_dir)

This doesn't look commit-graph related -- could/should it go somewhere
else?

> +{
> +       struct object_directory *odb;
> +       char *obj_dir_real = real_pathdup(obj_dir, 1);
> +       int cmp = -1;
> +
> +       prepare_alt_odb(r);
> +       for (odb = r->objects->odb; odb; odb = odb->next) {
> +               cmp = strcmp(obj_dir_real, real_path(odb->path));
> +               if (!cmp)
> +                       break;
> +       }

At this point, either odb is NULL or cmp is zero. Those are the only two
ways out of the loop.

> +       free(obj_dir_real);
> +
> +       if (cmp)
> +               odb = NULL;

Meaning that this doesn't do much? If the most recent comparison failed,
it's because we didn't find anything, so odb will be NULL.

> +       return odb;
> +}

I think you could drop `cmp` and that final check, and write the loop
body as "if (!strcmp(...)) break". You could also have an empty loop
body, but I wouldn't go there -- I'd find that less readable. (Maybe
that's just me.)

Martin
