Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1555720136
	for <e@80x24.org>; Fri, 17 Feb 2017 18:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934791AbdBQSgp (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 13:36:45 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35681 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934144AbdBQSgm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 13:36:42 -0500
Received: by mail-lf0-f68.google.com with SMTP id z127so2064624lfa.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 10:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Oj99FXRIv618mjcG0N4Z6hIf/16Zvgvtmvm0fiXw6n0=;
        b=G2ZS79WGmmFvTLLvSiaS5LL4uLvHOJLB5dD0DvUDUq6gA/dnF+dmuk1RrTmaE0YyLT
         h/Es2xk/yw1pcfHB9LEMCJBwZpBQVYxXQK/4zvzm3FNk+L5AJLB5YeC1HQ4mAQgsrEWQ
         +oG68nbJgrILoCHp/+eGVqsJ8Lfj0MNHpoklhAg7DGpJ08o98lWvQDJ17nLFGG8hNsgm
         izZA8Da4MF+RS4Kak2lHa5t7pyDNGeKkKoXgK+VQZQKNXpGGxCdgO3rfNVeERTt7C1j5
         Gm9G3kg7CsxgqVGNYEynrlPulLWwdF/RhhYvojrzQTu+R41cR6+VZJhwQf4bW4k7TlIv
         A+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Oj99FXRIv618mjcG0N4Z6hIf/16Zvgvtmvm0fiXw6n0=;
        b=mRQQuOj/bMS/s3K6ksIBYh0aFopPb/kWarmsvRXe2bYhl36gdvdAgfcJqXUYz1yZLh
         GC1BVvEB0HC6FKbkDa38SlZoxN3IF9DDTMZJkU/MSgxVOZTcRpXu4wp03BuumZRjOYwk
         PCad53UdBt7Q7XPXNcykdoB72k0TVt06PBKBJ8kqQMbsXmyPZWvwkqmJPOmZF+56ex8S
         6YsOjCcWjqkvfRGU+spegUDEAcSlKh0UkhBwm99EoGzoUitz8B/lr7IuAHhAwcqQGdoX
         joFmoNDawRGybYc6SfrxL9WXlV9i7rQ6/A6pM2A2WMNuWhDYrL7AV/LfE/yO/csWVPX/
         U7NQ==
X-Gm-Message-State: AMke39nO5/D0/Q4IN4YjhJ782HpMQXfCdOamvtRuefQOHH13Gxe+FOabglRJoVjalgRUUpcncrulOVOdTGFk+Q==
X-Received: by 10.46.20.93 with SMTP id 29mr2396080lju.10.1487356600970; Fri,
 17 Feb 2017 10:36:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Fri, 17 Feb 2017 10:36:20 -0800 (PST)
In-Reply-To: <20170216003811.18273-9-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <20170216003811.18273-9-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 17 Feb 2017 10:36:20 -0800
Message-ID: <CA+P7+xqpxTt7KibOrVr2ekjLy6Hva4KJ6nCaN22j-Qpspky3aQ@mail.gmail.com>
Subject: Re: [PATCH 08/15] submodules: introduce check to see whether to touch
 a submodule
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 4:38 PM, Stefan Beller <sbeller@google.com> wrote:
> In later patches we introduce the --recurse-submodule flag for commands
> that modify the working directory, e.g. git-checkout.
>
> It is potentially expensive to check if a submodule needs an update,
> because a common theme to interact with submodules is to spawn a child
> process for each interaction.
>
> So let's introduce a function that checks if a submodule needs
> to be checked for an update before attempting the update.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 27 +++++++++++++++++++++++++++
>  submodule.h | 13 +++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/submodule.c b/submodule.c
> index 591f4a694e..2a37e03420 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -548,6 +548,33 @@ void set_config_update_recurse_submodules(int value)
>         config_update_recurse_submodules = value;
>  }
>
> +int touch_submodules_in_worktree(void)
> +{
> +       /*
> +        * Update can't be "none", "merge" or "rebase",
> +        * treat any value as OFF, except an explicit ON.
> +        */
> +       return config_update_recurse_submodules == RECURSE_SUBMODULES_ON;
> +}

Ok, so here, we're just checking whether the value is
RECURSE_SUBMODULES_ON. The comment doesn't make sense to me at all.
What is "update" and why "can't" it be those values? How is this code
treating thise values as OFF exept for an explicit ON?

At first I thought this comment was related to check in the previous
patch. I think I see the patch is "recurse submodules = true" or
"recurse submodules = checkout" as a specific strategy? Ie:
recurse-submodules=checkout" means "recurse into submodules and update
them using checkout strategy?

Ok this starts to make a bit more sense. However, it's still somewhat
confusing to me.

Maybe this should be called something like
recurse_into_submodules_in_worktree() though that is pretty verbose.

I'm not sure I have a good name really. But I wonder why we need this
in the first place. Basically, we set RECURSE_SUBMODULES_* value which
could be OFF, ON, or even future extensions of CHECKOUT, REBASE,
MERGE, etc?

But shouldn't we just return the mode, and let the later code decide
"oh. actually I don't support this mode". For now, obviously we
wouldn't set any of the new modes yet.

> +
> +int is_active_submodule_with_strategy(const struct cache_entry *ce,
> +                                     enum submodule_update_type strategy)
> +{
> +       const struct submodule *sub;
> +
> +       if (!S_ISGITLINK(ce->ce_mode))
> +               return 0;
> +
> +       if (!touch_submodules_in_worktree())
> +               return 0;
> +
> +       sub = submodule_from_path(null_sha1, ce->name);
> +       if (!sub)
> +               return 0;
> +
> +       return sub->update_strategy.type == strategy;
> +}
> +

I liked Junio's suggestion where this just returns the strategy that
it can use, or 0 if it shouldn't be updated. Then, other code just
decides: Yes, I can use this strategy or no I cannot.

Should this be tied in with the strategy used by the
recurse_submodules above? ie: when/if we support recursing using other
strategies, shouldn't we make these match here, so that if the recurse
mode is "checkout" we don't checkout a submodule that was configured
to be rebased? Or do you want to blindly apply checkout to all
submodules even if they don't have strategy?

I assume you do not, since you check here with passing a strategy
value, and then see if it matches.

this could be named something like:

get_active_submodule_strategy() and return the strategy directly. It
would then return 0 in any case where it shouldn't be updated. Later
code can then check the strategy.

>  static int has_remote(const char *refname, const struct object_id *oid,
>                       int flags, void *cb_data)
>  {
> diff --git a/submodule.h b/submodule.h
> index b4e60c08d2..46d9f0f293 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -65,6 +65,19 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
>                 const struct diff_options *opt);
>  extern void set_config_fetch_recurse_submodules(int value);
>  extern void set_config_update_recurse_submodules(int value);
> +
> +/*
> + * Traditionally Git ignored changes made for submodules.
> + * This function checks if we are interested in the given submodule
> + * for any kind of operation.

This comment seems a bit weird.

> + */
> +extern int touch_submodules_in_worktree(void);
> +/*
> + * Check if the given ce entry is a submodule with the given update
> + * strategy configured.

I like Junio's suggestion of this "getting the current configured
strategy for a submodule. When we aren't set to recurse into
submodules we (obviously) return that we have no strategy since we're
not going to update it at all.

> + */
> +extern int is_active_submodule_with_strategy(const struct cache_entry *ce,
> +                                            enum submodule_update_type strategy);
>  extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
>  extern int fetch_populated_submodules(const struct argv_array *options,
>                                const char *prefix, int command_line_option,
> --
> 2.12.0.rc1.16.ge4278d41a0.dirty
>
