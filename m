From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 60/94] apply: make init_apply_state() return -1 instead
 of exit()ing
Date: Sun, 15 May 2016 23:37:57 -0400
Message-ID: <CAPig+cQ7zqhyFW5jwX5fFNKB11=hgOrOvaD-pNckxEMxmvBcjg@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-61-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 05:38:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b29M5-0005dO-76
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 05:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbcEPDh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 23:37:58 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:34375 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbcEPDh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 23:37:58 -0400
Received: by mail-ig0-f196.google.com with SMTP id kj7so5920938igb.1
        for <git@vger.kernel.org>; Sun, 15 May 2016 20:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=0PTbklaOMwS7YKfhLV1riH3ZB+nZf9HxxJBAMFZ1XZs=;
        b=oc8wn9GB7Mt4vz2SCRlj8yy+bvtIqzhkf2MWrFpX1ZuquYMQAjf6LnIqmfEIJJ/hDL
         299xfl+4zmLR1CPLTkWMxN+YYJsiU0EdvOUyfYLi4tCs+mYNZoBRjYKEvYmjuiGAvhVP
         JX+J1Vt4P1nwRwuwiYyFtAyceRv0aqTusoqNSl5IlwMBeulbWJm/cE9HBetZWL7vO9iZ
         jUPaPlT+4zqv7CyFcrU5soYT9JFdRc/7yOk+ImlqgTJzxxETcw/scZ+0NfqIvEEAXaIH
         y+BR6I+fXspqHfhOfgNM43eUWXHYiWgDvFDZrB8sx4ylKQxBNQ20CLywzkNRZD89gjtZ
         NKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=0PTbklaOMwS7YKfhLV1riH3ZB+nZf9HxxJBAMFZ1XZs=;
        b=DjeUINvZRkNQJ0QiCApKq2v6w5KT3W6GVbznix1gr5VniD4KPHWf6LvhpAd8PErBO+
         Whnchixi/kKa/7QM6CQJZTnKPak2epM1sTONBncCaMio5ohyx1v9Nq1Y89/o2SbyiNTw
         AjTLMpOso3DHC/zgZV/xN6n4wxejt9nZb6Kf+RsVClx9002skTufjW1WzpPVZoJCzyhg
         mZoiHvA5nUeMd7epWzsZmEzsfBRzj7BeIWRzV8dA9iTg8yy7tLjZ7IgOodMlM7VqPSrw
         34PXA20BPUkWwuGOsmY6bsC95sc+RBFz1tyYFhKQTy3wC/QXFEm4yUaie+rDAcdy8pba
         q/Hw==
X-Gm-Message-State: AOPr4FWLFgRW0GcAHJVZpANt2OuSI8sh+ayG4zlvRO0zF5OEbLBwf+CS6zWjflZEm3sp62+K6VGBcaHXOCqIeA==
X-Received: by 10.50.6.15 with SMTP id w15mr9546917igw.91.1463369877090; Sun,
 15 May 2016 20:37:57 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 15 May 2016 20:37:57 -0700 (PDT)
In-Reply-To: <20160511131745.2914-61-chriscool@tuxfamily.org>
X-Google-Sender-Auth: TUjcWJKqIFJtMRWnLkR8UbbUGto
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294720>

On Wed, May 11, 2016 at 9:17 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> To libify `git apply` functionality we have to signal errors to the
> caller instead of exit()ing.
>
> To do that in a compatible manner with the rest of the error handling
> in "builtin/apply.c", init_apply_state() should return -1 using
> error() instead of calling exit().

This commit message seems to be lying. It says that the -1 comes from
error(), however, init_apply_state() just returns literal -1 in all
cases.

By the way, mentioning "return -1 using error()" in all of these
commit messages (not just this one) may be overkill. The fact that
that side-effect of error() is being used in some of these cases is an
implementation detail which doesn't necessarily merit mention in the
commit message.

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/apply.c b/apply.c
> index 508ea64..1e2b802 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -55,9 +55,9 @@ int parse_ignorewhitespace_option(struct apply_state *state,
>         return error(_("unrecognized whitespace ignore option '%s'"), option);
>  }
>
> -void init_apply_state(struct apply_state *state,
> -                     const char *prefix,
> -                     struct lock_file *lock_file)
> +int init_apply_state(struct apply_state *state,
> +                    const char *prefix,
> +                    struct lock_file *lock_file)
>  {
>         memset(state, 0, sizeof(*state));
>         state->prefix = prefix;
> @@ -76,8 +76,9 @@ void init_apply_state(struct apply_state *state,
>
>         git_apply_config();
>         if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
> -               exit(1);
> +               return -1;
>         if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
> -               exit(1);
> +               return -1;
> +       return 0;
>  }
>
> diff --git a/apply.h b/apply.h
> index 0f77f4d..f3b2ae4 100644
> --- a/apply.h
> +++ b/apply.h
> @@ -117,8 +117,8 @@ extern int parse_whitespace_option(struct apply_state *state,
>  extern int parse_ignorewhitespace_option(struct apply_state *state,
>                                          const char *option);
>
> -extern void init_apply_state(struct apply_state *state,
> -                            const char *prefix,
> -                            struct lock_file *lock_file);
> +extern int init_apply_state(struct apply_state *state,
> +                           const char *prefix,
> +                           struct lock_file *lock_file);
>
>  #endif
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 805c707..b31f9eb 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -4724,7 +4724,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
>                 OPT_END()
>         };
>
> -       init_apply_state(&state, prefix, NULL);
> +       if (init_apply_state(&state, prefix, NULL))
> +               exit(1);
>
>         argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
>                         apply_usage, 0);
> --
> 2.8.2.490.g3dabe57
