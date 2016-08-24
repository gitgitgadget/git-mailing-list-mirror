Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E161F859
	for <e@80x24.org>; Wed, 24 Aug 2016 07:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753554AbcHXHUh (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 03:20:37 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36637 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753308AbcHXHUg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 03:20:36 -0400
Received: by mail-it0-f66.google.com with SMTP id j124so1251442ith.3
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 00:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6qldB89jkWIXAFXPokB+h1o1cSPXet6DJPZw1hsUCjc=;
        b=hUt6TrMaY+b94jQnEnztWha47SbZfWZEISlWZmooPkKfEFKGK05WgUHO9smm+EPd5w
         yCrwhvCfHy6/D94e9KRJrqnYw/59NND7ESnR3tLlLDUf9ps/KdcvPhE+bUwsnyIjkseM
         +rQ93oPrgYkA8tsk0PH6vz15YKqDEMgbMyY80jrAv32Weu59ZvFuzl+DXB2uH90MsW6s
         uao0Tf4n5Sk7XPJf2Azws+3xaaW9boXqNpS8aOGp/cebP0Nuv3SNtNfL7NL/Z6z7d5Qj
         1/CpYrkznajdOpVOm9Yq8IaGOENyHGG9E+/87KQZBRb1VAT6tNVC2TUqIa0WWALjidHC
         7HVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6qldB89jkWIXAFXPokB+h1o1cSPXet6DJPZw1hsUCjc=;
        b=fpyykihldssjoqiuqFtWrydw8+J9kaSwiptg3bcxM+ZmNkHDVLYy0zNSNONRNNlbZI
         zCD8Gf3XOELbLmdyQRb5sdKSCP76hmSC+tk3N4YTy5uZZaT94vhSh8ISsVpOQh5EmuZM
         Ngc1u7KEZX1uAQ5TtdXAZOXkaYgNB+0+MYIPXlMFO/7rmFDHAWSgM7uKMEGTdJWwg4dy
         iWtqZY/f2rhtjArgUk/RmKHt6zmPpJW5iAqMAx8qM8ICIfLIjs1OE8X4hApWkN9dhpUJ
         QgpLgSR2X9J1TNrN/YQEYib0koOaIgXIjHqDv88jqAS045l01yPnECX6feKUei52Kgb0
         dwiQ==
X-Gm-Message-State: AEkoouuOPGp508e/6PGyE4czVZ/du0/zWn9I5V/sm5E4piqxFsABtrtYzCG3Sbq4ZmRBHhAzUShI1eXCe7W0wg==
X-Received: by 10.107.36.5 with SMTP id k5mr2499880iok.104.1472023235400; Wed,
 24 Aug 2016 00:20:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.1 with HTTP; Wed, 24 Aug 2016 00:20:35 -0700 (PDT)
In-Reply-To: <131eea01901cc3c366bad2098f6abe8738922d58.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <131eea01901cc3c366bad2098f6abe8738922d58.1471968378.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Aug 2016 03:20:35 -0400
X-Google-Sender-Auth: JU7eTKujh2BEayfwmXDkADHIc6o
Message-ID: <CAPig+cTP+GNubCaveO6Sf9t44VQit0EaFjXCFexq2CtCMG2=Fw@mail.gmail.com>
Subject: Re: [PATCH 05/15] sequencer: lib'ify read_and_refresh_cache()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 12:07 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> To be truly useful, the sequencer should never die() but always return
> an error.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -638,18 +638,21 @@ static int prepare_revs(struct replay_opts *opts)
> -static void read_and_refresh_cache(struct replay_opts *opts)
> +static int read_and_refresh_cache(struct replay_opts *opts)
>  {
>         static struct lock_file index_lock;
>         int index_fd = hold_locked_index(&index_lock, 0);
>         if (read_index_preload(&the_index, NULL) < 0)
> -               die(_("git %s: failed to read the index"), action_name(opts));
> +               return error(_("git %s: failed to read the index"),
> +                       action_name(opts));
>         refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
>         if (the_index.cache_changed && index_fd >= 0) {
>                 if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
> -                       die(_("git %s: failed to refresh the index"), action_name(opts));
> +                       return error(_("git %s: failed to refresh the index"),
> +                               action_name(opts));

Do these two error returns need to rollback the lockfile?

>         }
>         rollback_lock_file(&index_lock);
> +       return 0;
>  }
