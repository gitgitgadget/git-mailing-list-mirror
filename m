Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D5BC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 23:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F7F60E52
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 23:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhHKX3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 19:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhHKX3b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 19:29:31 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B2FC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 16:29:06 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h11so7417583ljo.12
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 16:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nRTlP1mB1LENBj8SWvTlakbajKLsLV+eOgLoOGKQRR8=;
        b=RTOwdtwTFio7/Nd1cHYp0JjF/Gb9h5bXhZCmgaM3yPpDl/+tFcVI2ZzovOMLSaA8c7
         ULUfq8HKpCQlUA54Zfq9j8hjc4J1+GI6G9t4AuVHhknAUwpDrNGm6qufiPhtUjYizCjO
         aqsWzrgw5X92icCG0fdZTYqy8mQmYhI7nF9pdtpNhoczQcihd80O+QIGnk7lazeDTO6s
         3RGPeuUkbxskfbKCyF5lro1RhLo0/XWFd1BXXS0LAHrO3DohV9VOTdIgrfPogOmPbudr
         phTLhnUJmP/tr9J3swqL79bGNLsaBscSw1OiuNjTO/6KfG1RkvdgUrIvQakqIP8BPWpF
         /04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nRTlP1mB1LENBj8SWvTlakbajKLsLV+eOgLoOGKQRR8=;
        b=gTKIqBpTesMVcNYjh3CyhfHRB4g9VXub+BnniE8j4eFh8q8uIvYjm31NJ6LjbGPxTz
         afB0KDOzXqUWhhOYQdyYmuGtw0rDh/9k2Xstgq+7Q9BRPWG2QKod/Ya2glR0ugrxXEau
         xSvIB7vNgmpmCtGRwFp3B+3mTTaOjO9M0etJHvLqitGblD19sr91sVByRgHzpazbNBhc
         4TzTZFh+oaDcabD2sHHVwjoAPQXzO9QjAhbvbplLJq6eWuqGan+DoftGuIflyVHKok3r
         V+IJV4Hv6LHNFCVQ7TcnJtEaO7IC3s7GWUuzjJqvmKpAqqvWT98JHPXqeBWexxHaUuQE
         WJEw==
X-Gm-Message-State: AOAM532wWi9cUpZAlamLT9NTT6WOWaGc/iUziulShJlZZXM8W3vPBqWa
        MF6zxBrDHBjH4tVXckIatpO3Z7Htsj7FTgSkDAHmQw==
X-Google-Smtp-Source: ABdhPJyA9W5NsXCBJ7zzVeEn1ox9gs+5HVjqJXVqlMetMMRoeVYofTMiv1hvoSAH8METF1By8FxI1vEIVlTaJAVG8lk=
X-Received: by 2002:a2e:a5c1:: with SMTP id n1mr778974ljp.65.1628724545116;
 Wed, 11 Aug 2021 16:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <b2df2455871dc5c94ec804e9c0ce935c19da335f.1628618950.git.jonathantanmy@google.com>
In-Reply-To: <b2df2455871dc5c94ec804e9c0ce935c19da335f.1628618950.git.jonathantanmy@google.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 11 Aug 2021 20:28:54 -0300
Message-ID: <CAHd-oW4ntWB7KOKxhZU4wM-Xg9MARVN2EmpxEg-rEfc4i_SUnw@mail.gmail.com>
Subject: Re: [PATCH 6/7] grep: add repository to OID grep sources
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 3:29 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Record the repository whenever an OID grep source is created, and teach
> the worker threads to explicitly provide the repository when accessing
> objects.

This patch fixes the second NEEDSWORK comment at grep_submodule(),
right? Maybe this comment could be replaced with a mention that
add_submodule_odb_by_path() is called for testing purposes, and it
should no longer produce a real addition to the alternates list?

> diff --git a/grep.h b/grep.h
> index f4a3090f1c..c5234f9b38 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -187,6 +187,7 @@ struct grep_source {
>                 GREP_SOURCE_BUF,
>         } type;
>         void *identifier;
> +       struct repository *repo; /* if GREP_SOURCE_OID */

Hmm, the grep threads now have two `struct repository` references, one
in `struct grep_source` and one in `struct grep_opt` (see
builtin/grep.c:run()). The one from `struct grep_opt` will always be
`the_repository` (in the worker threads). I wonder if, in the long
run, we could instruct the worker threads to use the new reference
from `struct grep_source` throughout grep.c, and perhaps even remove
the one from `struct grep_opt`.

This would solve the issue I mentioned in [1], about git grep
currently ignoring the textconv attributes from submodules, and
instead applying the ones from the superproject in the submodules'
files. (Here there is an example of this bug: [2] .)

It would also allow grep to use the textconv cache from each
submodule, instead of saving/reading everything from the
superproject's textconv cache.

While this doesn't happen, though, could we perhaps add a comment
somewhere to avoid any confusion regarding the two different
repository pointers that the worker threads hold?

[1]: https://lore.kernel.org/git/CAHd-oW5iEQarYVxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com/
[2]: https://gitlab.com/-/snippets/1896951

>         char *buf;
>         unsigned long size;
> @@ -198,7 +199,8 @@ struct grep_source {
>  void grep_source_init_file(struct grep_source *gs, const char *name,
>                            const char *path);
>  void grep_source_init_oid(struct grep_source *gs, const char *name,
> -                         const char *path, const struct object_id *oid);
> +                         const char *path, const struct object_id *oid,
> +                         struct repository *repo);
>  void grep_source_init_buf(struct grep_source *gs);
>  void grep_source_clear_data(struct grep_source *gs);
>  void grep_source_clear(struct grep_source *gs);
> --
> 2.33.0.rc1.237.g0d66db33f3-goog
>
