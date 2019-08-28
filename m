Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08C5D1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 15:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfH1PuK (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 11:50:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40609 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfH1PuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 11:50:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so1688209pgj.7
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQVxkppAGDuOTm+LuVwt+E1NHAnzJpJqbk0r8U5t18I=;
        b=anWTa1vs4pBerCPNNwGOErz8dDS+oCU/Nag/waVJ7NTBzTD1XdWBKiotRLr7hSNIVX
         lKrNF5acRJN/0mNxnTMutvXRUAwXj41bWpaGBPuui6VKmQe7+LYig4FXnnhQ4ZcrL5tR
         90qnPKur9ziQamjUraejCfJXtLReqhcEQ2BsG2y40FJ8hCibu9NMerpi0eh4jd/dh4Mz
         Eb/K5v3P0OJqt8hcUb6aq9Uk/GyfT3FFBzsh+UCna698oKg4omRH85H9cOJSJXwDNV2o
         LczIVybxvs+UKb1idMlU3DVvUguAQigL0sOT9aiLN5vMLvXX0hkDrsBfKai2qCP+WxfA
         qwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQVxkppAGDuOTm+LuVwt+E1NHAnzJpJqbk0r8U5t18I=;
        b=tZBEdKkI9fsFrurmFWwIUKeWahMtlD4eZoMMjx0JzIgsLeZTloqL4s+uqND8dIqsns
         wsbuBim63KDTQQ2LXgKqRGrhe+qBmEe9V7AWtAoHkWSF6dXRn+Yw4TyejQfgKWNMUC/b
         sUM4o1oTZUxEmA3wo+Kc0z+Kn8GA12/PWShF0FyH6ccB5p3bw6h2Qme5LNtTAxdHVo+G
         susqO6t8rbgahZN/SqNO90W/uUGNtVyIcGMsOKW2kWWLu2Q4w+duN/RZzoNYFVPOMKrM
         uYSh3htdaKR0KOPaAk9cN68Od6RhAs/RNyUI1jsFxZwMdGIVrqIVZSAEMx7GYXBifb5F
         //Ww==
X-Gm-Message-State: APjAAAU1HX8KMHYVRWhVBxTZCRHjDAuMIncD0gnO/jWsTl1XzZgfIg+u
        V2diER22gSjZcBpfv2j0M7qyfoRohnnv9O1a4QM=
X-Google-Smtp-Source: APXvYqzVCfKYFF1CF9T1mK0w4I7XzXNQu2KHwWLicldSbOKrZQtbGNWKcWJSVeYwFcl+hLG7ZREP4AGvhGgHuUPIRaA=
X-Received: by 2002:a17:90a:e984:: with SMTP id v4mr5101440pjy.128.1567007409017;
 Wed, 28 Aug 2019 08:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190827101408.76757-1-t.gummerer@gmail.com> <20190827101408.76757-2-t.gummerer@gmail.com>
In-Reply-To: <20190827101408.76757-2-t.gummerer@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 28 Aug 2019 17:49:56 +0200
Message-ID: <CAN0heSptSEa6tcRZ3DVZjr7L=A2n7=U9fbnfYOvW0bBJ-M3WKQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] factor out refresh_and_write_cache function
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 27 Aug 2019 at 12:14, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> Getting the lock for the index, refreshing it and then writing it is a
> pattern that happens more than once throughout the codebase.  Factor
> out the refresh_and_write_cache function from builtin/am.c to
> read-cache.c, so it can be re-used in other places in a subsequent
> commit.

> +/*
> + * Refresh the index and write it to disk.
> + *
> + * Return 1 if refreshing the cache failed, -1 if writing the cache to
> + * disk failed, 0 on success.
> + */

Thank you for documenting. :-) Should we say something about how this
doesn't explicitly print any error in case refreshing fails (that is, we
leave it to `refresh_index()`), but that we *do* explicitly print an
error if writing the index fails? That caught me off-guard as I looked
at how you convert the callers.

And do we actually want that asymmetry? Maybe we do.

Might be worth pointing out as you convert the callers how some (all?)
of them now emit different error messages from before, but that it
shouldn't matter(?) and it makes sense to unify those messages.

> +int repo_refresh_and_write_index(struct repository*, unsigned int refresh_flags, unsigned int write_flags, const struct pathspec *, char *seen, const char *header_msg);

> +int repo_refresh_and_write_index(struct  repository *repo,
> +                                unsigned int refresh_flags,
> +                                unsigned int write_flags,
> +                                const struct pathspec *pathspec,
> +                                char *seen, const char *header_msg)
> +{
> +       struct lock_file lock_file = LOCK_INIT;
> +
> +       repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
> +       if (refresh_index(repo->index, refresh_flags, pathspec, seen, header_msg))
> +               return 1;
> +       if (write_locked_index(repo->index, &lock_file, write_flags))
> +               return error(_("unable to write index file"));
> +       return 0;
> +}

If `flags` doesn't contain `COMMIT_LOCK`, the lockfile will be closed
"gently", meaning we still need to either commit it, or roll it back. Or
let the exit handler roll it back, which is what would happen here, no?
We lose our handle on the stack and there's no way for anyone to say
"ok, now I'm done, commit it please" (or "roll it back").

In short, I think calling this function without providing `COMMIT_LOCK`
would be useless at best. We should probably let this function provide
`COMMIT_LOCK | write_flags` or `COMMIT_LOCK | extra_write_flags` or
whatever. Most callers would just provide "0". Hm?

Or, we could BUG if the COMMIT_LOCK bit isn't set, but that seems like a
less good choice to me. If we're so adamant about the bit being set --
which we should be, IMHO -- we might as well set it ourselves.



Martin
