Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9889E20248
	for <e@80x24.org>; Mon, 25 Mar 2019 11:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfCYLIu (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 07:08:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51049 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfCYLIu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 07:08:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so8484106wmi.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 04:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pqy5QOP2QFqu1dKrWEDgLuynQWI4Rn0jjIIhZpCGE84=;
        b=fsN0f81dbKq0CEm71OfSizl2TPZ9lfc7ZFzGdrvqpKBZFF4k9szSA+6axttW5GZZGe
         EzpUGAmnJGLVz9vI5XkYArbcdy1kPz5kyepUtBsyEljsxk3GcbV9sN0oegTkR27T0Tjh
         Dxl4ZeP/YqCPwxALuwfLUkySu8I+JUonONoeHoQJkjCL4w2Nw0mJYL6SnRO199rhoS5G
         eRaYRs8tVqV1tMw0HyekPZO6vxSw7+ZTZxZ8GQOb9yqRoLh3wv6hB4p6qAGWAO5gVshC
         3fXHYcDOO2Mf00aEQ+6HIEribOS/t0WvivtbMaSk4M1ctZ/dFfNPqW4JQVQBBr+vtTJp
         VgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=pqy5QOP2QFqu1dKrWEDgLuynQWI4Rn0jjIIhZpCGE84=;
        b=CtpylJgaqE61Xl7t9qpFaB/uYEkZqw4af9cB/D8fEqo06sTRWRSvMbyGCkEBO/mr12
         koKhNiP/aDiUSNvyMzFbXKE3AhJDoOV1enqpLJ/I+r8yqZc5QrfLiP+fxx/sFZrFhVp4
         6t5xojdUnHuOy2idE67EVjk7i+QHylSCbuB4TuF1R3a2zF+YRZ71UP+YyGzlSx5ejSpY
         HYo4mJ6DmXpEz9Tut1RkSX8Hoseok5MOJRDizL/6EtvBYgjvhqv/B0f+p1X4sK87AnJu
         8ExqhRUcDLdh3IQpd5Tmw4pIm9v9QRhcIF86MdOzPAe8QpIogdhI+E//rSLsB+k887gF
         RLSA==
X-Gm-Message-State: APjAAAXtZ/vgcRRTrztm+q4B3WpSMDrdH4qYzZubXGvTtoTEHpkZg7i/
        rF9Q3K2Ucn7c9iEGtEwvOPM=
X-Google-Smtp-Source: APXvYqyGzcJT30DpjXKqGYmDt4rZLHza5hzCCmVhvn9JCmbmf4EVpQ4u88sXbcPb6QyfxZRDTFTSug==
X-Received: by 2002:a1c:cc0a:: with SMTP id h10mr4789955wmb.20.1553512128598;
        Mon, 25 Mar 2019 04:08:48 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id o127sm17770111wmo.20.2019.03.25.04.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 04:08:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Luke Mewburn <luke@mewburn.net>
Subject: Re: [PATCH 2/5] progress: return early when in the background
References: <20190325103844.26749-1-szeder.dev@gmail.com> <20190325103844.26749-3-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190325103844.26749-3-szeder.dev@gmail.com>
Date:   Mon, 25 Mar 2019 12:08:47 +0100
Message-ID: <8736nbcitc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 25 2019, SZEDER G=C3=A1bor wrote:

> When a git process runs in the background, it doesn't display
> progress, only the final "done" line [1].  The condition to check that
> are a bit too deep in the display() function, and thus it calculates
> the progress percentage even when no progress will be displayed
> anyway.
>
> Restructure the display() function to return early when we are in the
> background, which prevents the unnecessary progress percentae
> calculation, and make the function look a bit better by losing one
> level of indentation.
>
> [1] 85cb8906f0 (progress: no progress in background, 2015-04-13)

CC-ing the author of that patch.

> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  progress.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/progress.c b/progress.c
> index 02a20e7d58..b57c0dae16 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -86,28 +86,30 @@ static void display(struct progress *progress, uint64=
_t n, const char *done)
>  		return;
>
>  	progress->last_value =3D n;
> +
> +	if (!is_foreground_fd(fileno(stderr)) && !done) {
> +		progress_update =3D 0;
> +		return;
> +	}
> +
>  	tp =3D (progress->throughput) ? progress->throughput->display.buf : "";
>  	eol =3D done ? done : "   \r";
>  	if (progress->total) {
>  		unsigned percent =3D n * 100 / progress->total;
>  		if (percent !=3D progress->last_percent || progress_update) {
>  			progress->last_percent =3D percent;
> -			if (is_foreground_fd(fileno(stderr)) || done) {
> -				fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
> -					progress->title, percent,
> -					(uintmax_t)n, (uintmax_t)progress->total,
> -					tp, eol);
> -				fflush(stderr);
> -			}
> +			fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
> +				progress->title, percent,
> +				(uintmax_t)n, (uintmax_t)progress->total,
> +				tp, eol);
> +			fflush(stderr);
>  			progress_update =3D 0;
>  			return;
>  		}
>  	} else if (progress_update) {
> -		if (is_foreground_fd(fileno(stderr)) || done) {
> -			fprintf(stderr, "%s: %"PRIuMAX"%s%s",
> -				progress->title, (uintmax_t)n, tp, eol);
> -			fflush(stderr);
> -		}
> +		fprintf(stderr, "%s: %"PRIuMAX"%s%s",
> +			progress->title, (uintmax_t)n, tp, eol);
> +		fflush(stderr);
>  		progress_update =3D 0;
>  		return;
>  	}

This patch looks good, just notes for potential follow-up:

 * Is the "is_foreground_fd(fileno(stderr))" case worth moving into
   start_progress_delay() & setting a variable? It's a few C lib calls &
   potential syscall (getpid(...)).

 * Is that "|| done" part in the "progress_update" case something that
   needs to happen? I.e. can we entirely skip the "setup signal handler"
   part in start_progress_delay() if we detect that we're not in the
   foreground, and then rely on the stop_progress() call to print the
   "done"?

   Although we set "progress_update =3D 1" in stop_progress_msg(), so it's
   not *just* the signal handler but also us "faking" it, and we'd still
   need to stash away "progress->last_value =3D n" in display() in that
   backgrounding case.

   So maybe it's as simple as it's going to get.
