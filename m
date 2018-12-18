Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFCE91F405
	for <e@80x24.org>; Tue, 18 Dec 2018 20:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeLRUyQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 15:54:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35474 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRUyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 15:54:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so17352746wrb.2
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 12:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRm+HDrlj3V8cz8uodlVvWcqmRHQOXSZxGt0CUkfqyY=;
        b=iVZWZPNZVsvC8Cjn5ERwsDnG9yRzQBcwdpMSeEk+6kVVuVawCkUJQed4EqwtX0m5ZD
         geuAsJtBdNzT33u2Em8kvuCZqNytI11hbHSaQYm8xL/4SUmpJQ8Ys1moG/RcxQI5TJ9u
         llXDWlwFFI2NXtlV5YZt31jU7i0SmwbauJNXu2rAJY3JItA093TrgurkUm0cGhGWoT6m
         n0DZ+GSZ25SwxWJzs2EjAegpbVFjFtMQVyF3xbHhac5h52EwUF3WDtuVINKmJ0UAYUTc
         9uYUMgu/RcZSUrFWE2XTSzu9ft1Ahf7eTO0M6LRONYX/biflEwiyro6BNP74rI883sS0
         KS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRm+HDrlj3V8cz8uodlVvWcqmRHQOXSZxGt0CUkfqyY=;
        b=YROivHzAM0/VPeC13Lu9m4nByOQ3M5w4hHTzwtlEbnjD6pzLKTjh2EOChgsxfz1IXI
         Mscl25IgsdeOtyrBY1Uf86yWihEm2n1VcXHzsKIQb+mdPdektluCWF6Z+u9wVKrvcSWn
         mWptcCvIa8mVAIPNdA3w16bGSOsWDtYRGUjG26Jde1ZTh3fqsMOj9ZPZXttfSjXn1GE2
         1InYWmZnuIK/9tM0Xs1nD5aT1MvP8to7dyfRRBWvh/O4VZBdKR3xNNRuAFZRqgDe3OtP
         vRYipjprKLM8ICGZFn5pAL82xS2Ub7xb7gDN60W6jUNrSvNomEy30MnwYF5eqwaacQHT
         U40g==
X-Gm-Message-State: AA+aEWYXFO3/ChUEN/RToYZlJoCjNjBFMj/wUy6MMT2spq6We87CAlG4
        2FE6KZyPJ9/Hn55KNnoX7yuHpdQHvnTnLyuefnM=
X-Google-Smtp-Source: AFSGD/XbVKU/k+PQXtBJqbIgDECOnAmIFaNt/pAGnx93GUiBXoGjYxmd5D3SwSYMJOGA6yAE0y1700oeBV5sEmsMvI8=
X-Received: by 2002:a5d:64c7:: with SMTP id y7mr15949611wrv.207.1545166454055;
 Tue, 18 Dec 2018 12:54:14 -0800 (PST)
MIME-Version: 1.0
References: <1544722211-13370-1-git-send-email-eedahlgren@gmail.com>
 <1544922308-740-1-git-send-email-eedahlgren@gmail.com> <20181218175418.GB31070@sigill.intra.peff.net>
In-Reply-To: <20181218175418.GB31070@sigill.intra.peff.net>
From:   Erin Dahlgren <eedahlgren@gmail.com>
Date:   Tue, 18 Dec 2018 12:54:02 -0800
Message-ID: <CAP_Smy14j4WK-mkqdKTKue=j7YoNjfaZVCBA-7S8xwNqX2rKhQ@mail.gmail.com>
Subject: Re: [PATCH v2] Simplify handling of setup_git_directory_gently()
 failure cases.
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, Dec 18, 2018 at 9:54 AM Jeff King <peff@peff.net> wrote:
>
> On Sat, Dec 15, 2018 at 05:05:08PM -0800, Erin Dahlgren wrote:
>
> > setup_git_directory_gently() expects two types of failures to
> > discover a git directory (e.g. .git/):
> > [...]
>
> When I read your subject line, I'll admit to having a funny feeling in
> the pit of my stomach. This setup code has historically been full of
> subtle corner cases, and I expected a very tricky review.
>
> However, your explanation was so well-written that it was a pleasure to
> read. :)

Thanks :)

>
> > Before this change are two misleading additional behaviors:
> >
> >   - GIT_DIR_HIT_CEILING: setup_nongit() changes to the cwd for no
> >       apparent reason. We never had the chance to change directories
> >       up to this point so chdir(current cwd) is pointless.
>
> That makes sense. I think this is a holdover from when we used to walk
> backwards via chdir(), prior to ce9b8aab5d (setup_git_directory_1():
> avoid changing global state, 2017-03-13). Back then, we needed to
> restore the state at this point, but now we don't.
>
> >   - GIT_DIR_HIT_MOUNT_POINT: strbuf_release() frees the buffer
> >       of a static struct strbuf (cwd). This is unnecessary because the
> >       struct is static so its buffer is always reachable. This is also
> >       misleading because nowhere else in the function is this buffer
> >       released.
>
> Makes sense.
>
> I do have one question, though:
>
> >       case GIT_DIR_HIT_CEILING:
> > -             prefix = setup_nongit(cwd.buf, nongit_ok);
> > -             break;
> > +             if (!nongit_ok)
> > +                     die(_("not a git repository (or any of the parent directories): %s"),
> >a +                                    DEFAULT_GIT_DIR_ENVIRONMENT);
> > +             *nongit_ok = 1;
> > +             strbuf_release(&dir);
> > +             return NULL;
>
> This case used to break out of the switch, and now returns early.
>
> So we do not execute the later code which clears GIT_PREFIX_ENVIRONMENT,
> and zeroes the fields in startup_info. Those probably don't matter in
> most cases, but I wonder if there are some obscure ones where it might.
>
> Might it make sense to make GIT_DIR_HIT_MOUNT_POINT more like
> GIT_DIR_HIT_CEILING currently is, rather than the other way around?
> I.e., something like:
>
>   case GIT_DIR_HIT_CEILING:
>         if (!nongit_ok)
>                 die(...);
>         *nongit_ok = 1;
>         prefix = NULL;
>         break;
>   case GIT_DIR_HIT_MOUNT_POINT:
>         if (!nongit_ok)
>                 die(...);
>         *nongit_ok = 1;
>         prefix = NULL;
>         break;
>
> ?

After some digging, there seems to be a documented guarantee that
"`GIT_PREFIX` is set as returned by running 'git rev-parse
--show-prefix'". See Documentation/config/alias.txt. If the
environment variable GIT_PREFIX is already set to something and we
don't clear it when prefix is NULL, then the two can be out of sync.
So that's a problem with my patch and the current handling of
GIT_DIR_HIT_MOUNT_POINT. I'm not sure how important of a guarantee it
is, but we should respect what's documented.

Side note: One of the secondary goals of my patch was to make it
really obvious that neither the GIT_DIR_HIT_CEILING nor the
GIT_DIR_HIT_MOUNT_POINT case can get us into the block protected by
(startup_info->have_repository || getenv(GIT_DIR_ENVIRONMENT)). With
your suggestion (and it's a fair one) I don't think that's feasible
without more significant refactoring. Should I just settle with a
comment that explains this?

Thanks,
Erin

>
> -Peff
