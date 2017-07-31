Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E5A11F991
	for <e@80x24.org>; Mon, 31 Jul 2017 23:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbdGaXln (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 19:41:43 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35303 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbdGaXln (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 19:41:43 -0400
Received: by mail-lf0-f47.google.com with SMTP id t128so304706lff.2
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 16:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IwtISYqK0TXALWgO7wMpREeQG6TRK/lK0ZP7qRLWR6I=;
        b=uUlGwzHNmtje9GCKar9LH/UMbLl4anjSO/KoypE+z7VClHtmh4ztacSakYxMPkfCmL
         OixAQVnR0umfK+cD+iy/QlRzHDZNyBG0CyztNDwNucjsnvLV3fSy33u/LXBnlFztUAq1
         Yle+WIbcpgwz9HoXtfIBRFcq+l4Pdh8MjD1wVcW0orPR96lAprKjyANQj/P5evjDVPVX
         GWxC0fEs2lw5iTVNa0TX2o5B588hpiMnumn+4Er19YR7zBw4EwILXYUq2l4M/VEb3dAr
         GyclSr9uY8lmNcB4tvceq0yg8ly+8bF/g0uf1dnsgE0OgeGEXoww7U3NLiAjo+w0e4jh
         5/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IwtISYqK0TXALWgO7wMpREeQG6TRK/lK0ZP7qRLWR6I=;
        b=sM+Vgd9jV4BInX7KbO2kWL6Hsoc/1tqFTk/CC1zLl/yAnylkUUTVRGsgjMi4LD7h8Q
         Tr+Yo/Nfc3rGFRXC3yG/8A7z22WT4T4r/s2lZPWoT+uzv8cqFnJEMG7TTMz9MI0GH0qt
         2mIdbfTsWOGnnHlMvIK3yl6pYx9CxER7fMbosdRoBlfANcq+0qyj6pjwvdKfeJXs4L2I
         BFUfA3pUBy0YSnYcjmqrPbd8HWnr8Xn9W3YRp4G1DT/ohmBy1wfh6mJz5j4SSO/fIt0f
         4ybpV9iopagDjnFhIGfNxMJIi7aMZAQQCnbunKXC21Q1Ma9jCx+JK2704zBYzq3kyvGX
         JqUQ==
X-Gm-Message-State: AIVw1128+AmK4q4gwnSN5x9H28m+nSo/6zY0VXJ9mOK40bU3jQFNoiJW
        ybVrCiO+a8dNQP4edZ2CO2qQ/oiBknP+
X-Received: by 10.25.228.206 with SMTP id x75mr5035602lfi.94.1501544501254;
 Mon, 31 Jul 2017 16:41:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Mon, 31 Jul 2017 16:41:40 -0700 (PDT)
In-Reply-To: <20170718190527.78049-8-bmwill@google.com>
References: <20170714222826.81148-1-bmwill@google.com> <20170718190527.78049-1-bmwill@google.com>
 <20170718190527.78049-8-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 31 Jul 2017 16:41:40 -0700
Message-ID: <CAGZ79kYWd5WdwkC74+AdRt0anTUtngD7jt=aJv7iLCLf-TAfbA@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] submodule: check for unstaged .gitmodules
 outside of config parsing
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 18, 2017 at 12:05 PM, Brandon Williams <bmwill@google.com> wrote:
> Teach 'is_staging_gitmodules_ok()' to be able to determine in the
> '.gitmodules' file has unstaged changes based on the passed in index
> instead of relying on a global varible which is set during the

variable

> submodule-config parsing.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/mv.c |  2 +-
>  builtin/rm.c |  2 +-
>  submodule.c  | 32 +++++++++++++++++---------------
>  submodule.h  |  2 +-
>  4 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index dcf6736b5..94fbaaa5d 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -81,7 +81,7 @@ static void prepare_move_submodule(const char *src, int first,
>         struct strbuf submodule_dotgit = STRBUF_INIT;
>         if (!S_ISGITLINK(active_cache[first]->ce_mode))
>                 die(_("Directory %s is in index and no submodule?"), src);
> -       if (!is_staging_gitmodules_ok())
> +       if (!is_staging_gitmodules_ok(&the_index))
>                 die(_("Please stage your changes to .gitmodules or stash them to proceed"));
>         strbuf_addf(&submodule_dotgit, "%s/.git", src);
>         *submodule_gitfile = read_gitfile(submodule_dotgit.buf);
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 52826d137..4057e73fa 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -286,7 +286,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>                 list.entry[list.nr].name = xstrdup(ce->name);
>                 list.entry[list.nr].is_submodule = S_ISGITLINK(ce->ce_mode);
>                 if (list.entry[list.nr++].is_submodule &&
> -                   !is_staging_gitmodules_ok())
> +                   !is_staging_gitmodules_ok(&the_index))
>                         die (_("Please stage your changes to .gitmodules or stash them to proceed"));
>         }
>
> diff --git a/submodule.c b/submodule.c
> index b1965290f..46ec04d7c 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -37,18 +37,25 @@ static struct oid_array ref_tips_after_fetch;
>  static int gitmodules_is_unmerged;
>
>  /*
> - * This flag is set if the .gitmodules file had unstaged modifications on
> - * startup. This must be checked before allowing modifications to the
> - * .gitmodules file with the intention to stage them later, because when
> - * continuing we would stage the modifications the user didn't stage herself
> - * too. That might change in a future version when we learn to stage the
> - * changes we do ourselves without staging any previous modifications.
> + * Check if the .gitmodules file has unstaged modifications.  This must be
> + * checked before allowing modifications to the .gitmodules file with the
> + * intention to stage them later, because when continuing we would stage the
> + * modifications the user didn't stage herself too. That might change in a
> + * future version when we learn to stage the changes we do ourselves without
> + * staging any previous modifications.
>   */
> -static int gitmodules_is_modified;
> -
> -int is_staging_gitmodules_ok(void)
> +int is_staging_gitmodules_ok(const struct index_state *istate)
>  {
> -       return !gitmodules_is_modified;
> +       int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
> +
> +       if ((pos >= 0) && (pos < istate->cache_nr)) {

Why do we need the second check (pos < istate->cache_nr) ?

I would have assumed the first one suffices,
it might read better if turned around:


    if (pos < 0)
        return 1;

    return (lstat(GITMODULES_FILE, &st) == 0 &&
        ce_match_stat(istate->cache[pos], &st, 0) & DATA_CHANGED);
  }

> @@ -231,11 +238,6 @@ void gitmodules_config(void)
>                                     !memcmp(ce->name, ".gitmodules", 11))
>                                         gitmodules_is_unmerged = 1;
>                         }
> -               } else if (pos < active_nr) {
> -                       struct stat st;
> -                       if (lstat(".gitmodules", &st) == 0 &&
> -                           ce_match_stat(active_cache[pos], &st, 0) & DATA_CHANGED)
> -                               gitmodules_is_modified = 1;
>                 }

So this is where the check "pos < active_nr" is coming from,
introduced in 5fee995244 (submodule.c: add .gitmodules staging
helper functions, 2013-07-30) as well as d4e98b581b (Submodules:
Don't parse .gitmodules when it contains, merge conflicts, 2011-05-14).

If I am reading the docs for cache_name_pos correctly, we would
not need to check for the index exceeding active_cache,
but checking for the index not being out of bounds seems
to be wide spread.
