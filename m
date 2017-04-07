Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE85020966
	for <e@80x24.org>; Fri,  7 Apr 2017 11:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755467AbdDGLUl (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 07:20:41 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34919 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752971AbdDGLUj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 07:20:39 -0400
Received: by mail-oi0-f54.google.com with SMTP id f193so82134765oib.2
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 04:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=km0Mwcr6V/R4qClfXD4G7ntLX3pNKkjyC41K72+EyqY=;
        b=P2I9jeZTGb1hCmAZ2+zyTjG31xlHXCCQvHriwdl2p50iOI2AgiN6tFM2VraWuHqyLj
         gFz1524eraU1Ny8zR1lTL9usfluFvYUKDqbi4vfBrOAIYo68tp2xvJgZZ4sm0yreYRav
         fllVp7AtdyKONyi4B6PIgqUBy/8Uovci//2nd6RHb2w5Csx7EOoD1eX0PRnZDjjlNIjK
         v4D0E66C4FcoaTAVTqaH+HOdezqRMTZnf/XpWlr9DQLIdPydYumUPtX5FOTylNDwfBVV
         O8nKJbqUXookBZfhWZyU0657lQZB4ckuKv/pI/2j51ajdJ61rRHr8YUKjVgpHUZetIek
         7+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=km0Mwcr6V/R4qClfXD4G7ntLX3pNKkjyC41K72+EyqY=;
        b=ETGCljV1FRZdVys5TY9aimFmvTeNju9G5ay+U47ygQEu7S7e+bvXAAtMUakhZ5E4m0
         HVxaOEDImWt8Bf+NJHEYYQ0C66R/SSbZy1yoje3tcIfXQNLeVXBkx3nI0VQr3jCAk8DO
         VCdamuTNoCBY+SN89guW3MTUFcPFxzK98jduANbwW1yQ/vl3fpDf0mtNipFxeMNQXyq1
         tI8RFlXxYVcNgOBr2dSOfFQKLMgNkbl0mgVh/x/sTQZLL/jHnueSW0OSeVZSRLndtoqH
         jFtT8PPhkK5A8ETY5ARy3wOm1in7lEHbL7KdKNt28xFDwkMqMF7pLF3DyKpv70v9p+vM
         xmPQ==
X-Gm-Message-State: AFeK/H3BSrf+zFNZJUdvPu2pA8iJQSiuw9qKffwzdCiFXsi7hlfLax1iBJLBeISYN+rnFnEPi01uc5iwwabrSw==
X-Received: by 10.157.14.69 with SMTP id n5mr8119928otd.271.1491564038156;
 Fri, 07 Apr 2017 04:20:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Fri, 7 Apr 2017 04:20:07 -0700 (PDT)
In-Reply-To: <22abd274bfdada94b3654a811ee209822640765f.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu> <22abd274bfdada94b3654a811ee209822640765f.1490966385.git.mhagger@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 7 Apr 2017 18:20:07 +0700
Message-ID: <CACsJy8CZwPN06Q4OFmbjh8iCigZbrTUGU20hmxNCDRiAbB+KVA@mail.gmail.com>
Subject: Re: [PATCH v2 04/20] refs_verify_refname_available(): implement once
 for all backends
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 9:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> It turns out that we can now implement
> `refs_verify_refname_available()` based on the other virtual
> functions, so there is no need for it to be defined at the backend
> level. Instead, define it once in `refs.c` and remove the
> `files_backend` definition.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c               | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  refs.h               |  2 +-
>  refs/files-backend.c | 39 +++++-------------------

Much appreciated. This will make future backends simpler to implement as well.

> +       iter = refs_ref_iterator_begin(refs, dirname.buf, 0,
> +                                      DO_FOR_EACH_INCLUDE_BROKEN);
> +       while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
> +               if (skip &&
> +                   string_list_has_string(skip, iter->refname))
> +                       continue;
> +
> +               strbuf_addf(err, "'%s' exists; cannot create '%s'",
> +                           iter->refname, refname);
> +               ok = ref_iterator_abort(iter);

Saving the return code in "ok" seems redundant because you don't use
it. Or did you want to check that ok == ITER_DONE or die() too?

> +               goto cleanup;
> +       }
> +
> +       if (ok != ITER_DONE)
> +               die("BUG: error while iterating over references");
> +
> +       extra_refname = find_descendant_ref(dirname.buf, extras, skip);
> +       if (extra_refname)
> +               strbuf_addf(err, "cannot process '%s' and '%s' at the same time",
> +                           refname, extra_refname);
> +       else
> +               ret = 0;
> +
> +cleanup:
> +       strbuf_release(&referent);
> +       strbuf_release(&dirname);
> +       return ret;
>  }
-- 
Duy
