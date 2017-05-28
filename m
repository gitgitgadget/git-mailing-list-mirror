Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 045611FD09
	for <e@80x24.org>; Sun, 28 May 2017 17:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbdE1RrL (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 13:47:11 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36103 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbdE1RrK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 13:47:10 -0400
Received: by mail-it0-f68.google.com with SMTP id i206so5526246ita.3
        for <git@vger.kernel.org>; Sun, 28 May 2017 10:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Hw64/v7XM76DGbfrkNPw1EuvXFdWY1ti4aDWRfh7LRQ=;
        b=OjriZx9gm7EIAdZBFw+ts9ECEFNOddvBunnm79yWWaKkxsmVf/AWVxiWB70YI/bc84
         KOrjic5HQnOvP6ItWRXhxTW4Y9TCVoT6+t96X6BA+Ipfk+h87MCc5yU3WW3KLPVkNBy8
         7ZvoDfiGMvq/mXPQd9D34YN+zfdznVls1LkIFp/ClaLzpCQC5TegRxQeu0587Z9Ko2wc
         VGpVurc57Wah7f/+m/qnSJSoaL4sNON3JK9QHvszsZc6yiN1T97RH/rnil53MI6oB6OJ
         noqSCUX4fle5qOb9lqaKJGai8gmYIAs23ior25SrhqfpB7hwiuQKckDMtA7SSqjhKaHm
         EoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Hw64/v7XM76DGbfrkNPw1EuvXFdWY1ti4aDWRfh7LRQ=;
        b=VRFt9rSQcZ32LKEu7H47oZQoLNfit1v/SPr9HskE9QrcrrtYcMcefe/MzpI1M8iYPy
         hBGmc66lvqJXIF2FDrYlr15N+COs31KmWL3hXUrjOlIhk5hfyq+Mpmy6HWuJi6+1T9Gd
         9p/p7EbDNo35/jQYa7BcbrVViuhlS1Vx2IFHgajpbThadHPmyS0ZKr4DqZVqJWPp5+In
         CL8sFrAjf2XeO+/rNY0TK5Ac3U8LHKoowKBPWcHNdVWWo1zZMAPVMb/1XYcx8SqpXw2F
         eDWfIwHD7wPR4Z3NnPpLRm03FDZ7F5Xyc94zERKM7HbDeG95ca9l6vxRYzTmwPiM+2om
         +XBg==
X-Gm-Message-State: AODbwcDvkwRYtksFyNqlkpzZyqEXqJm86bgEesiC4dKY3sq1BNwKjvrz
        +jirO5nKOfzcuskgigJdhkEepQoqQw==
X-Received: by 10.36.37.78 with SMTP id g75mr10857343itg.94.1495993629322;
 Sun, 28 May 2017 10:47:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sun, 28 May 2017 10:46:48 -0700 (PDT)
In-Reply-To: <20170528165642.14699-4-joel@teichroeb.net>
References: <20170528165642.14699-1-joel@teichroeb.net> <20170528165642.14699-4-joel@teichroeb.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 28 May 2017 19:46:48 +0200
Message-ID: <CACBZZX7AirkQBfF3RneMkTVugy=pDNkH71gvVS1jpc7eFYFicg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] close the index lock when not writing the new index
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>, t.gummerer@gmail.com,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 28, 2017 at 6:56 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> ---
>  builtin/add.c     | 3 ++-
>  builtin/mv.c      | 8 +++++---
>  builtin/rm.c      | 3 ++-
>  merge-recursive.c | 8 +++++---
>  4 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index 9f53f020d0..6b04eb2c71 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -461,7 +461,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>         if (active_cache_changed) {
>                 if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
>                         die(_("Unable to write new index file"));
> -       }
> +       } else
> +               rollback_lock_file(&lock_file);

From Documentation/CodingGuidelines: "When there are multiple arms to
a conditional and some of them[...]".

>
>         return exit_status;
>  }
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 61d20037ad..ccf21de17f 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -293,9 +293,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>         if (gitmodules_modified)
>                 stage_updated_gitmodules();
>
> -       if (active_cache_changed &&
> -           write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
> -               die(_("Unable to write new index file"));
> +       if (active_cache_changed) {
> +               if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
> +                       die(_("Unable to write new index file"));
> +       } else
> +               rollback_lock_file(&lock_file);
>
>         return 0;
>  }
> diff --git a/builtin/rm.c b/builtin/rm.c
> index fb79dcab18..4c7a91888b 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -389,7 +389,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>         if (active_cache_changed) {
>                 if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
>                         die(_("Unable to write new index file"));
> -       }
> +       } else
> +               rollback_lock_file(&lock_file);
>
>         return 0;
>  }
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 62decd51cc..db841c0d38 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2145,9 +2145,11 @@ int merge_recursive_generic(struct merge_options *o,
>         if (clean < 0)
>                 return clean;
>
> -       if (active_cache_changed &&
> -           write_locked_index(&the_index, lock, COMMIT_LOCK))
> -               return err(o, _("Unable to write index."));
> +       if (active_cache_changed) {
> +               if (write_locked_index(&the_index, lock, COMMIT_LOCK))
> +                       return err(o, _("Unable to write index."));
> +       } else
> +               rollback_lock_file(lock);
>
>         return clean ? 0 : 1;
>  }
> --
> 2.13.0
>
