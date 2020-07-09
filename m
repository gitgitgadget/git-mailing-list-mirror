Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DABC433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 17:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02092078B
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 17:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="UvquvQ9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgGIRjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgGIRjb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 13:39:31 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C702C08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 10:39:31 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g2so1662108lfb.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 10:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DmTW0dzuDf4JgluTvQ3vDzaEVoV8yQ5arU9lK7vCb50=;
        b=UvquvQ9IuXxDpCIkkxGvhpN14aBUj9OzxKt6vAt6mrgBDED+l5NBPLgDI68nCuX2wn
         zjzrxP/4uRtLsFzfm3OYcAU0eY0VZ2p9lldLeALDyon5fo6FINiDLoUP7bCnP4z/tKeC
         REblpxaQ0fhwQW469d/j4Cd+pMz5yA2V8tkeV4Tbaj3bgoGilAylXZHngobyZOFkOa4I
         nmSmEijG749dGpRUd4N8isGuqzlGL2eHs5+cXUdhHqWgeBpQuNsH+h5nKeUmOxkGKR0k
         0033NWXNO1pBs2Wdu4bdtbfmXdsPt5FdcivyZoCRNs5g0zeMLUpex8ZXLqYljwOicAUE
         mU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmTW0dzuDf4JgluTvQ3vDzaEVoV8yQ5arU9lK7vCb50=;
        b=rGwwJ4r+TceXpk+iJ+AZOgFMTVgiAePx41Oq3vFKwJL2cc+qvFeaXxX+MDdcgGbLTF
         5dqKiomtO+UknJrDDbnsxgB/H/48wV8UHk34gM1r5QCenyZCiJsWygUiG5nOtUnsd3WD
         zCxGlcBhZu2hwmV97vZiFNNStHxRJsX7+vqeqGyogvBSgyVwsNtaX86f7B/1RwGRP11i
         i8GF4kfQMw7EVIZm6hMj/9ImM0BXYfh5jl+XgOQSfIbV7T5MJw8kopr7bmH1vmnpzz3s
         cFpN0Lo7FppyDakuHmOJPdP2IRvsVkbqLHPUa57vRMGeJ+m1DUTV0ScOV5fmT5AlLG8+
         9QbA==
X-Gm-Message-State: AOAM532EjAsai7THQoLICfGLx2brcqXoULHmboEN2u5cXCEtqTNw/bvr
        c1Ma1gMFfr27LRcUNmhdczHewR+K3FhgzdnTyFcauUs7jeo=
X-Google-Smtp-Source: ABdhPJwqUuvXUG08Kq7bB+5DbQF5dw/bOITd4mpZWwZYIuYKdAabWmVvbjJNskwxw1rYmETx9xZU6wSjD5dtPrS2m0o=
X-Received: by 2002:a19:c50a:: with SMTP id w10mr40706906lfe.48.1594316369568;
 Thu, 09 Jul 2020 10:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <fbde5e1c9042ea06b448bc759cea9d45e300961f.1594260597.git.matheus.bernardino@usp.br>
 <xmqqd054y5t1.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqd054y5t1.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 9 Jul 2020 14:39:18 -0300
Message-ID: <CAHd-oW7sz5nGUGZDDguz3fdeRLa+8iWRdC+vyCB2jWvFMh3aXg@mail.gmail.com>
Subject: Re: [PATCH] entry: check for fstat() errors after checkout
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 9, 2020 at 2:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> The returned value from fstat_output() is suppsed to be "have we
> done fstat() so that we do not need to do a lstat()?"  Don't you
> instead want to extend it to "0 means we didn't, 1 means we did
> successfully, and -1 means we did and failed"?  At least, the way
> _this_ function is modified by this patch is in line with that.

Makes sense, thanks for spotting this issue.

> Which means that we'd need to update the caller(s) to match, to
> avoid risking this change to be just half a change, very similarly
> to how the change in 11179eb311 was just half a change.
>
> Perhaps like this?
>
>  entry.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/entry.c b/entry.c
> index 53380bb614..f48507ca42 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -108,14 +108,21 @@ static int open_output_fd(char *path, const struct cache_entry *ce, int to_tempf
>         }
>  }
>
> +/*
> + * We have an open fd to a file that we may use lstat() on later.
> + * When able, try doing a fstat(fd) instead and tell the caller it
> + * does not have to do an extra lstat()
> + *
> + * Return 1 if we successfully ran fstat() and *st is valid.
> + * Return 0 if we did not do fstat() and the caller should do lstat().
> + * Return -1 if we got failure from fstat()---the caller can skip lstat().
> + */
>  static int fstat_output(int fd, const struct checkout *state, struct stat *st)
>  {
>         /* use fstat() only when path == ce->name */
>         if (fstat_is_reliable() &&
> -           state->refresh_cache && !state->base_dir_len) {
> -               fstat(fd, st);
> -               return 1;
> -       }
> +           state->refresh_cache && !state->base_dir_len)
> +               return (fstat(fd, st) < 0) ? -1 : 1;
>         return 0;
>  }
>
> @@ -369,10 +376,10 @@ static int write_entry(struct cache_entry *ce,
>  finish:
>         if (state->refresh_cache) {
>                 assert(state->istate);
> -               if (!fstat_done)
> -                       if (lstat(ce->name, &st) < 0)
> -                               return error_errno("unable to stat just-written file %s",
> -                                                  ce->name);
> +               if (fstat_done < 0 ||
> +                   (!fstat_done && lstat(ce->name, &st) < 0))
> +                       return error_errno("unable to stat just-written file %s",
> +                                          ce->name);

If fstat() failed or we couldn't fstat() but lstat() failed, we return
an error. Nice! Thanks for the correction.
