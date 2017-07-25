Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EECD1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 23:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbdGYXqq (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 19:46:46 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:37237 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbdGYXqp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 19:46:45 -0400
Received: by mail-pg0-f44.google.com with SMTP id y129so76305199pgy.4
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 16:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8ms07GOjefypc9Lbas/6okCLFGOkat7xmsd4sgmVyng=;
        b=PZhH69Pfd8rioGtwhUSTHrfSUNJVSA0wMS26Lr/Uy0GRC137+lpkUyK4Ba2QshEUgR
         KWXkezTCzEWBvUfN9hnPoJJe+XxFV22mCXDepMUXBbmCrobzm2tgZr/46/Qw6L8SSL7d
         QmPs3hX+zXYgIS2lsm2quiNIuZgPd6F9BThhJbqVb0puMXzY9bdKyEuRpplFnXxdeDvF
         i+x7RHhWYIHl3Af2D/Zb878zKK/8qmpqNIVrIpDCa0htUAvysYHpLTqEtMkJ4+ASmJfz
         wO3yFpbhVkuEtjIAdhv/aKTA7G3klMg9MfQOyxhKnY8nhGflokuqMRJNKwsxsM7EK/m9
         HdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8ms07GOjefypc9Lbas/6okCLFGOkat7xmsd4sgmVyng=;
        b=n1CNUmADkqBXQblXUn7EsSbRR6bINn7fi09JXhxVJ+QRhTDZSN4HnM7Ikp+9PIgGzZ
         grlRzAXhfdIeqsgAJsgCB4T3FhsjxmOcLMxQr9Br7btfq++IDQynAHnX39PqPYIYidnX
         Z3IeFYxF1JvsJ4rUuQ8VtPgoXtmbH7VUJpIQ+tMgmtrbBeJfwF/6mtCFXjjL4KJKVgZr
         KzvRwJ6W76HKTvKiGKCh0x8D36TYLP31VmJt9hgIaIxJTLsUQLDBwBBiNbhMdVapGOXv
         yE0z4yGJzgKx0lWTj75Kxt6sUKmJ3kVB3uxxAT+0WEyY6ijnFZ31lPLJO4f+Vh//ho4Z
         WWSA==
X-Gm-Message-State: AIVw110fSWBjzx8+UXjOxnwD6aCHQqvJyqvIduK/Lj8m6vZKD5UU8Vyz
        2ln+tj9TiP4FuTwbbxIbHzAu0ZUs7mWX
X-Received: by 10.84.217.16 with SMTP id o16mr22910596pli.31.1501026405190;
 Tue, 25 Jul 2017 16:46:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Tue, 25 Jul 2017 16:46:44 -0700 (PDT)
In-Reply-To: <20170725213928.125998-8-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com> <20170725213928.125998-8-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Jul 2017 16:46:44 -0700
Message-ID: <CAGZ79kZ24eT6kyLE6W8PTQwCy3gJWUaexFCOdQrQbS5tPEAmsg@mail.gmail.com>
Subject: Re: [PATCH 07/15] submodule: don't rely on overlayed config when
 setting diffopts
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2017 at 2:39 PM, Brandon Williams <bmwill@google.com> wrote:
> Don't rely on overlaying the repository's config on top of the
> submodule-config, instead query the repository's config directory for
> the ignore field.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  submodule.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index c5058a4b8..f86b82fbb 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -165,8 +165,16 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
>  {
>         const struct submodule *submodule = submodule_from_path(&null_oid, path);
>         if (submodule) {
> -               if (submodule->ignore)
> -                       handle_ignore_submodules_arg(diffopt, submodule->ignore);
> +               const char *ignore;
> +               char *key;
> +
> +               key = xstrfmt("submodule.%s.ignore", submodule->name);
> +               if (repo_config_get_string_const(the_repository, key, &ignore))
> +                       ignore = submodule->ignore;

Unlike the last patch, we have to use a direct lookup here as
the alternative is hugely painful.


> +               free(key);
> +
> +               if (ignore)
> +                       handle_ignore_submodules_arg(diffopt, ignore);
>                 else if (is_gitmodules_unmerged(&the_index))
>                         DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
>         }
> --
> 2.14.0.rc0.400.g1c36432dff-goog
>
