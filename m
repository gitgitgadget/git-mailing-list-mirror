From: Chirayu Desai <chirayudesai1@gmail.com>
Subject: Re: [PATCH/GSoC] parse-options: Add a new nousage opt
Date: Sun, 20 Mar 2016 12:22:18 +0530
Message-ID: <CAJj6+1ExK2wftTvtWEW4=RAvrYeKynSmyviqWfk1jrF-UpqmCw@mail.gmail.com>
References: <1458456405-3519-1-git-send-email-chirayudesai1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Chirayu Desai <chirayudesai1@gmail.com>
To: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 07:52:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahXDs-0008Fg-1J
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 07:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbcCTGwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 02:52:20 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:32923 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbcCTGwT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 02:52:19 -0400
Received: by mail-io0-f180.google.com with SMTP id c63so809042iof.0
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 23:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=AqzlKK6sh+M3orxHYId0XHisNxFCcXeuyIykH0qXIU0=;
        b=i6GaWiRFE09UlF9o12ws1wdAk9DeD+9hLa7tCkryt9O1KyaYv03rdrDjD7aA9Grund
         YX5y+vdmb2wMJrOLMuFtDJsWPK49MiSATUyDUgsloalMIksABMYZ3jWFVIAuSWqBQwwn
         uNbF8ykflADiO1FbgjCErfp9hT+GKbOU/sVSKlIuA50c/fkrOP1KUP3goOSJKgJgnRGy
         k8v4EYebVfPdsn12Ip/TD5q0HCAJMMhnMbO7f0xXLCsf4qzwqse4KJOQjWcvmcq4ieRd
         G+ZpLOmHaEfstE0FMY36WLipVd36ClID5YXOqnNgyR+KZ244tgnJO3kOHXSuCENZ/Ieg
         y5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=AqzlKK6sh+M3orxHYId0XHisNxFCcXeuyIykH0qXIU0=;
        b=mJ/c7ckMfELdMgIUzcSKIh6Yy7MrGiG8TWJKuuIu785yKHBtPv4zpoLDOOuWlP21Yh
         bIYdBltOOsgcE2eRDbAyxkoctNTgeOO0qp9fEUVFdYa/GitYYnJCxZEOZaduk7aeEKZD
         wnnBruL/0Hj2dxOVccquSC42XW1wYc+68BisOqIjwN248EZb4Q0uK0uM7xURJ+Pfjrfd
         fewoYyXgy8ZDa7lCd4h7B2dtZ48J6nq6Y+haTcyq21/iWhObkdz9eBnvVUuVHeSLqxz+
         bHxk4mkA7VA6GBshFdoRDTk8pvoim6alvty5T0OEQWkoFlOqqO8Mj1j1RaxYhHnKR8iG
         Ciaw==
X-Gm-Message-State: AD7BkJKGZqgp2Xee3b94JnwK2Fl/DPGDDz4p3CVsJTuywdP8Hpp7OgRAddCGDjWm5wWgllGT+gj8VOPIT2V0JA==
X-Received: by 10.107.2.148 with SMTP id 142mr19055151ioc.128.1458456738245;
 Sat, 19 Mar 2016 23:52:18 -0700 (PDT)
Received: by 10.79.31.7 with HTTP; Sat, 19 Mar 2016 23:52:18 -0700 (PDT)
In-Reply-To: <1458456405-3519-1-git-send-email-chirayudesai1@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289337>

This is being discussed in the "Re: "git tag --contains <id>" is too
chatty, if <id> is invalid" thread.
$gmane/289312

On Sun, Mar 20, 2016 at 12:16 PM, Chirayu Desai <chirayudesai1@gmail.com> wrote:
> * To show only error text on an error instead of the full usage
> * Currently used only by commands with options "--with" or "--contains",
>   such as 'tag', 'branch', 'for-each-ref'.
>
> It now prints only
>   $ git tag --contains qq
>   error: malformed object name qq
> instead of the full usage text after the error text.
>
> TODO: Add tests
> ---
>  parse-options-cb.c | 12 ++++++++----
>  parse-options.c    |  5 +++++
>  parse-options.h    |  6 ++++--
>  3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index 239898d946..ac2ea4d674 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -85,11 +85,15 @@ int parse_opt_commits(const struct option *opt, const char *arg, int unset)
>
>         if (!arg)
>                 return -1;
> -       if (get_sha1(arg, sha1))
> -               return error("malformed object name %s", arg);
> +       if (get_sha1(arg, sha1)) {
> +               error("malformed object name %s", arg);
> +               return -3;
> +       }
>         commit = lookup_commit_reference(sha1);
> -       if (!commit)
> -               return error("no such commit %s", arg);
> +       if (!commit) {
> +               error("no such commit %s", arg);
> +               return -3;
> +       }
>         commit_list_insert(commit, opt->value);
>         return 0;
>  }
> diff --git a/parse-options.c b/parse-options.c
> index 47a9192060..d136c1afd0 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -158,6 +158,9 @@ static int get_value(struct parse_opt_ctx_t *p,
>                         return (*opt->callback)(opt, NULL, 0) ? (-1) : 0;
>                 if (get_arg(p, opt, flags, &arg))
>                         return -1;
> +               if (opt->flags & PARSE_OPT_NOUSAGE) {
> +                       return (*opt->callback)(opt, arg, 0);
> +               }
>                 return (*opt->callback)(opt, arg, 0) ? (-1) : 0;
>
>         case OPTION_INTEGER:
> @@ -504,6 +507,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>                         goto show_usage_error;
>                 case -2:
>                         goto unknown;
> +               case -3:
> +                       return PARSE_OPT_DONE;
>                 }
>                 continue;
>  unknown:
> diff --git a/parse-options.h b/parse-options.h
> index ea4af92a51..628e34c5af 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -38,7 +38,8 @@ enum parse_opt_option_flags {
>         PARSE_OPT_LASTARG_DEFAULT = 16,
>         PARSE_OPT_NODASH = 32,
>         PARSE_OPT_LITERAL_ARGHELP = 64,
> -       PARSE_OPT_SHELL_EVAL = 256
> +       PARSE_OPT_SHELL_EVAL = 256,
> +       PARSE_OPT_NOUSAGE = 512
Perhaps a _ON_ERR should be appended at the end to make it clearer?
>  };
>
>  struct option;
> @@ -89,6 +90,7 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
>   *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed in brackets
>   *                             (i.e. '<argh>') in the help message.
>   *                             Useful for options with multiple parameters.
> + *   PARSE_OPT_NOUSAGE: do not print usage / help on error.
>   *
>   * `callback`::
>   *   pointer to the callback to use for OPTION_CALLBACK or
> @@ -254,7 +256,7 @@ extern int parse_opt_passthru_argv(const struct option *, const char *, int);
>         { OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), parse_opt_passthru_argv }
>  #define _OPT_CONTAINS_OR_WITH(name, variable, help, flag) \
>         { OPTION_CALLBACK, 0, name, (variable), N_("commit"), (help), \
> -         PARSE_OPT_LASTARG_DEFAULT | flag, \
> +         PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NOUSAGE | flag, \
>           parse_opt_commits, (intptr_t) "HEAD" \
>         }
>  #define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, 0)
> --
> 2.7.4
>
