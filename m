Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03046C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D90E1610CD
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhETASb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 20:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhETASb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 20:18:31 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF03DC061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 17:17:09 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id b25so14857049oic.0
        for <git@vger.kernel.org>; Wed, 19 May 2021 17:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGtMTD7SuXXt85tJwdp4LNLY1+SKkaleXHF2xu6G5NU=;
        b=QxgiuCV+0yJoQoOI2uxKwSGy2bs81VCJvwomqFsqH0Xttp4UnqRkvEzMEyX/8qlMo7
         x9eshhDU6x927DzjUe1qh3rfrJ2jJnn+aUZ6Euujr14cxEz+i6H+mTgV279EJs7tnPn/
         5CA5gtiY+Qu2YyMXgJmUKGojldo+BpU7T+pV6mEs9Hu2Taz2TlJgiEHZ8RAypliINast
         9iubiApPGhKKKwAtEKoVdUm0ZKNiEeXexq0/jspBCvnBTea/niZedfBf4gCOAWThAIDd
         /dBMzxYUfGr4d9HzfsN+bmuiykFcl08i20sd/cHbuoKuIUHfwlTURNG1jsj48m4JC6KT
         wZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGtMTD7SuXXt85tJwdp4LNLY1+SKkaleXHF2xu6G5NU=;
        b=PSCEI1A7EG/yU1GtU7WWmkjoG5NSsd8tLDHOSAdj+4QPhJKQWEMriJyh4Dqnhc/djq
         pITfM3WqhKO3w/r0G7CwmnCo1FbbRUSmhWKyOM/P59Se9p81TuUzuEb+ykKZ+X+dRjUv
         LN7VlBWzPln6zGnojx0cIMN3axSfQBNmlywD2daAXyfb6HUN6JSIb7XnIhoPfQnVzBgV
         gggajCxaE1N1okZrSnKFaCTcGy8CONy1DWHrct2pXNHsmsxlxpXIgnYpDArYCd9TuFw6
         hP3App8ZFDi2R7bqXj46rScJM7H041RAv6E4SGCj+AS19tJvSZnnMfFhsS/junBrcomK
         AGoQ==
X-Gm-Message-State: AOAM533XvTaL/B562ct4BuMsRV6BS4y7FC3pgH2dv9KZcZbAMdRRRw+B
        xEzY3ZTGFLqgvXJJNYVrDz7V2fiowNFXwb7TGxzAi4QRKZE=
X-Google-Smtp-Source: ABdhPJyMRaRzLNrmgrPzhnCsKUtWc9ULL0322iGBEYPt+Kd9djymXTfEFxHLB5wel3CijiWPUbLtlapHw9p7AZHhB4Y=
X-Received: by 2002:aca:3e05:: with SMTP id l5mr1459506oia.39.1621469829133;
 Wed, 19 May 2021 17:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621451532.git.ps@pks.im> <a5ca94e3f4df2abb38880385310e5cb02d7b5daa.1621451532.git.ps@pks.im>
In-Reply-To: <a5ca94e3f4df2abb38880385310e5cb02d7b5daa.1621451532.git.ps@pks.im>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 19 May 2021 17:16:58 -0700
Message-ID: <CABPp-BGXH1oSVn9jS-CC2P0snUzgo5CN=nPbXtWrOm0Ugjz1Hg@mail.gmail.com>
Subject: Re: [PATCH 3/8] tmp-objdir: expose function to retrieve path
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 1:22 PM Patrick Steinhardt <ps@pks.im> wrote:
>
> It's currently impossible to tell the path of a temporary object
> directory for outside users of `struct tmp_objdir`. We'll soon need that
> information though so that we can reuse information from the quarantine
> environment in git-receive-pack(1).
>
> Provide a new function `tmp_objdir_path()` which returns the path of a
> temporary object directory to prepare for this.

Oh, sweet, someone else wants this too.  I have a local patch
introducing the same function, which I needed for --remerge-diff.  I
hadn't submitted the patch yet, and if yours is accepted then I won't
need to.  :-)

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  tmp-objdir.c | 7 +++++++
>  tmp-objdir.h | 5 +++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/tmp-objdir.c b/tmp-objdir.c
> index b8d880e362..6056917c63 100644
> --- a/tmp-objdir.c
> +++ b/tmp-objdir.c
> @@ -288,6 +288,13 @@ const char **tmp_objdir_env(const struct tmp_objdir *t)
>         return t->env.v;
>  }
>
> +const char *tmp_objdir_path(const struct tmp_objdir *t)
> +{
> +       if (!t)
> +               return NULL;
> +       return t->path.buf;
> +}
> +
>  void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
>  {
>         add_to_alternates_memory(t->path.buf);
> diff --git a/tmp-objdir.h b/tmp-objdir.h
> index b1e45b4c75..da3ccb98bc 100644
> --- a/tmp-objdir.h
> +++ b/tmp-objdir.h
> @@ -51,4 +51,9 @@ int tmp_objdir_destroy(struct tmp_objdir *);
>   */
>  void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
>
> +/*
> + * Return the path of the temporary object directory.
> + */
> +const char *tmp_objdir_path(const struct tmp_objdir *t);
> +
>  #endif /* TMP_OBJDIR_H */
> --
> 2.31.1

Looks good to me.
