Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C53171F404
	for <e@80x24.org>; Tue, 27 Feb 2018 18:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeB0SXF (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 13:23:05 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:36114 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeB0SXD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 13:23:03 -0500
Received: by mail-yw0-f169.google.com with SMTP id g198so5216057ywb.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 10:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UTVqFFzSPFJ6buN/ox93vx5ZrME/pbX8JjjlNtiqmYY=;
        b=UAQ/HPMMPHKgym+qA/1mpOffAcUjYc1/x3/mBM65XA1gmPVBeI4NxlAZdO2iyIECY9
         QLHuPQLDUHdlAqfzH4ShznJNi6yhXA+EFKVejkFuDjStaUj8Uo5dXjgmxJjMmO1R/gjc
         Dd7mJulntfQ6BC6HHrc5L4+slvoEdw0XsqBCXp11ajyB4dSRsahbbOkHuwO8ug4SOE9G
         vkeqEWVH8+QWHfeovE0kIns1fHVRRvH2pLQgLiNVWwswB6EgNg3eyEM40AuAKU26OIoJ
         +6w/ow1cSFhKIZsXs+ddacK0BI5+dwKg53gaguapMg8JhNm7pE+H1xlTn50mQJfs2ySf
         wq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UTVqFFzSPFJ6buN/ox93vx5ZrME/pbX8JjjlNtiqmYY=;
        b=oPRPoFiYgswJyCl9GYfI4zvUDbGIQnQjTLJh96KBzKtgBHLfX8gQ1oP74G3Z75i1ow
         Kw5zMo3siVoipFsGTYmv9rolUft4STNT9GSONcWOwt4YFfdlxc4vqlBbP3Wwa2f/QLmS
         k2airJ7cRzWjG4oLKP/kBvWL2DBq8R6S0Xk6EtAr1veIKrWap+S+mkJlH3UqMzqgeTmd
         dOgT2m16vth/ulRC+o7U7wwYUUwiW6QFwwUbUPd8EKFndYEGLSWxCSc0wl9F2NzRdagI
         lqQW4P7MZ17VYZsaiiSw2LV9rrMAAvRmJu3f5xOSkmfnQY6p9jaY2Ytz1/a8xUnGSmyL
         GvXA==
X-Gm-Message-State: APf1xPCtjuoRlEbJbbgzmGT1OJPy/ngmPOsvBt8HSO2ieSZXvdCOViYE
        hujd/v9g1miiDoVPKMab5Sk0fA4K5wtQq8ChHFcWVg==
X-Google-Smtp-Source: AH8x225xvL8abuL8cWL6GrO4FJJeDzv1PD1IILBI4f+iZLKbTVKPyMxt1dUSqs9bMsBJSuMMQj4ZuTM8jX8zGALGr9M=
X-Received: by 10.13.237.70 with SMTP id w67mr10070907ywe.414.1519755782830;
 Tue, 27 Feb 2018 10:23:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 27 Feb 2018 10:23:02
 -0800 (PST)
In-Reply-To: <20180207011312.189834-20-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-20-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Feb 2018 10:23:02 -0800
Message-ID: <CAGZ79kaWu=M_EJH=wKzYn2YV70GO0iuS_T68nztp5fYtiVA9mg@mail.gmail.com>
Subject: Re: [PATCH v3 19/35] push: pass ref patterns when pushing
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 5:12 PM, Brandon Williams <bmwill@google.com> wrote:
> Construct a list of ref patterns to be passed to 'get_refs_list()' from
> the refspec to be used during the push.  This list of ref patterns will
> be used to allow the server to filter the ref advertisement when
> communicating using protocol v2.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  transport.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/transport.c b/transport.c
> index dfc603b36..6ea3905e3 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1026,11 +1026,26 @@ int transport_push(struct transport *transport,
>                 int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
>                 int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
>                 int push_ret, ret, err;
> +               struct refspec *tmp_rs;
> +               struct argv_array ref_patterns = ARGV_ARRAY_INIT;
> +               int i;
>
>                 if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
>                         return -1;
>
> -               remote_refs = transport->vtable->get_refs_list(transport, 1, NULL);
> +               tmp_rs = parse_push_refspec(refspec_nr, refspec);
> +               for (i = 0; i < refspec_nr; i++) {
> +                       if (tmp_rs[i].dst)
> +                               argv_array_push(&ref_patterns, tmp_rs[i].dst);
> +                       else if (tmp_rs[i].src && !tmp_rs[i].exact_sha1)
> +                               argv_array_push(&ref_patterns, tmp_rs[i].src);

else /* !tmp_rs[i].dst && (!tmp_rs[i].src || tmp_rs[i].exact_sha1)

I would think the case of !dst && !src cannot happen, as then there is
no refspec, but what about the !!exact_sha1 case ?

I'd think that is something like

    git push origin $(git rev-parse HEAD)

for which I'd think we'd bail out anyway?
But that would happen at a different place, here we can ignore
the exact hashes for listing refs purposes.

Can you add a comment or rather explain in the commit
message to make this less confusing?

Stefan
