Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 043641F404
	for <e@80x24.org>; Sun,  8 Apr 2018 13:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeDHNjO (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 09:39:14 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39695 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbeDHNjN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 09:39:13 -0400
Received: by mail-wr0-f194.google.com with SMTP id c24so5782310wrc.6
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 06:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hmBJ9L27ohMimuFZpqGtgnw8mpc4SefkLubAcZQoIQ8=;
        b=nkzb+tcIE282sMGidOn31CFWYI09e9Tg28ftYTt/oKCSZ7hHkQWCsMmP78+RMJJj0k
         aTluQlReJe5NvU42jUpsb4yNmloNepx763hg82QMFtdytDbcqapy5ULpxnRYr7w97aHp
         JjIhmWpn8llPeOXIlWJM/dum5FfR7KY+kvaahenkiBnorri6EVuLSv1ydBRXNxIF28QO
         4YdBXIH0MYcoGnKFJrREiYMB8+hqVXCt2S6S72KQ628SeAtnK6fvkBMFbisgHCB+tWNU
         kbst1ck+N477d0od11cDcLxMVraQKty/KQz1Zx7loBtMHT0mKX6o5dnVvC/k3Z84UvxK
         JuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=hmBJ9L27ohMimuFZpqGtgnw8mpc4SefkLubAcZQoIQ8=;
        b=DhcFXq/4xo6QvkX+aA3svFCEXb4vDkDWhC3Bj4XiII+XIZQJCzuOj/ChE/ma5RdABB
         AnCiVdsElumFju609PhIzb7Qq1YB4a3AHQviEQnhX0KQR9Eu2W9Kwz7qsSobczThdAjb
         id7IMvhQJIOuc9pkC3SUGPmutvOEOnVOoYf5C4zlfJ860wsFt3QSYrbmqyOdSSgEB/VJ
         edKuNk0NrwQYdUuJTFCqsCNqXGh0/daqB+lGtvbjNV/TYzXk9FwfI3KrcSRDpswt66IZ
         dVqD9aIkGVnHH3ct65Goyvr/TovqEim8KikAhbXvOF1slpmuCqjB54dSMqmTcgkn1g1d
         gzng==
X-Gm-Message-State: ALQs6tB5iS8XC0h1SvlSQ+ktURNOFy4UpovStSC4BTzMQuV5azkImtkR
        96drblZG6NdO1FYsz5w/OHo=
X-Google-Smtp-Source: AIpwx4/5vfNXiDu0GQHckdKORn8yxACmuEdTq714Ud0jHhjfH3eXoN+7Fq+GTLYCgcvTKGwZpFY4IA==
X-Received: by 2002:a19:ef08:: with SMTP id n8-v6mr7177916lfh.1.1523194752597;
        Sun, 08 Apr 2018 06:39:12 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (aga121.neoplus.adsl.tpnet.pl. [83.25.156.121])
        by smtp.gmail.com with ESMTPSA id p19-v6sm2975315lfd.86.2018.04.08.06.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 06:39:11 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v7 09/14] commit-graph: add core.commitGraph setting
References: <20180314192736.70602-1-dstolee@microsoft.com>
        <20180402203427.170177-1-dstolee@microsoft.com>
        <20180402203427.170177-10-dstolee@microsoft.com>
Date:   Sun, 08 Apr 2018 15:39:08 +0200
In-Reply-To: <20180402203427.170177-10-dstolee@microsoft.com> (Derrick
        Stolee's message of "Mon, 2 Apr 2018 16:34:22 -0400")
Message-ID: <86sh85ddhf.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The commit graph feature is controlled by the new core.commitGraph config
> setting. This defaults to 0, so the feature is opt-in.

Nice.  That's how bitmaps feature was introduced, I think.  I guess that
in the future reading would be opt-out, isn't it, same as currently for
bitmaps (pack.useBitmaps setting).

>
> The intention of core.commitGraph is that a user can always stop checking
> for or parsing commit graph files if core.commitGraph=3D0.

Shouldn't it be "false", not "0"?

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config.txt | 4 ++++
>  cache.h                  | 1 +
>  config.c                 | 5 +++++
>  environment.c            | 1 +
>  4 files changed, 11 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4e0cff87f6..e5c7013fb0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -898,6 +898,10 @@ core.notesRef::
>  This setting defaults to "refs/notes/commits", and it can be overridden =
by
>  the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
>=20=20
> +core.commitGraph::
> +	Enable git commit graph feature. Allows reading from the
> +	commit-graph file.
> +

Good.  It would be nice to have "Defaults to false." and possibly also
reference to "git-commit-graph(1)" manpage for more details, though.

>  core.sparseCheckout::
>  	Enable "sparse checkout" feature. See section "Sparse checkout" in
>  	linkgit:git-read-tree[1] for more information.
[...]

--=20
Jakub Nar=C4=99bski
