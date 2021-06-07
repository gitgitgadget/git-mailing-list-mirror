Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE3CC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 09:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A9F611AB
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 09:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhFGJ04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 05:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhFGJ0z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 05:26:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6D0C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 02:24:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ho18so14541356ejc.8
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 02:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OWwrLwf5lCPG3swZzOK1BYJwp2jkojJw/qD58FYSdfA=;
        b=gF8nsNdLjnbWH7MYez2aKzt863MmHMQwxDLirQc+QMqEMkMNyIJtFUxF+scGwciatm
         8Kiy1E0VMV4Z1imMphHw1iyhJgcXaNGS3ZSXlety9l31uKTmfIJi+hiVfVTXrJTFBJt/
         JpICFnAnkhGae7uG5UoP+bNPj2wjNoLsWTXimLur1BPDcL+/GOliDPtG0TO8E2QINGsq
         HE4qx1BVPhkhvG083log7FKdoswuYE9P9WUiFpGuueDsU7O/4UxL6GKg8Qij/ZGE5uq/
         AhF0IQ9xRfq7XeO9XlT2yMOjNWx6q9039rUALnD+jz6TzDwu2ua2vWHEG+iUxW6VAojH
         Pm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OWwrLwf5lCPG3swZzOK1BYJwp2jkojJw/qD58FYSdfA=;
        b=X1W47Xd2O/BCsWZWdBqNo1TlcH1YT9aMzS3yQvn0nlLlOrqIkncw6V2nrgSDQ7OFPS
         PPq0eCc/E8YmIhi4MhrSup8FjP6j4lFuoLvMpjOf5jUg3z4z9UZ2PZzmClPRrp9F08kD
         sPx0COiAZr95J4gs02UifzjrJAqDSQt9h9RwTxC7OjGS5hDvmELxsGmCDdk8ltZFYtlv
         lJPQN/FzLAgECtE2bAB5eoBuCEfCF3ruMtgy1hzJJg6m9OtOYSpemzoZ2uv3qjP+g5XP
         Us4G4APi2OR0qieQxzpJptvVsDzjnvO1ouLO6XQRyrilInGqQFLqkTSYeYAzGRDWKnXq
         OUyQ==
X-Gm-Message-State: AOAM530ubq8EWcnPKTCrwhh5DoyD9dZIOIhqJuc09CGT5fDY9metG22L
        WwEzlWzlbxlxoqyLx28FXPzpdTmyTi6fl2+FNGY=
X-Google-Smtp-Source: ABdhPJygyBHlJCcPuHLmiWTlhtqlGu+ygiqbudzDY4E+8myQOtnqRZObxn1E2iuX0kyTZFmLBYYNc0spf+MLnzM2tH8=
X-Received: by 2002:a17:906:3598:: with SMTP id o24mr17146316ejb.551.1623057888366;
 Mon, 07 Jun 2021 02:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210605113913.29005-1-raykar.ath@gmail.com> <20210605113913.29005-3-raykar.ath@gmail.com>
In-Reply-To: <20210605113913.29005-3-raykar.ath@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 7 Jun 2021 11:24:37 +0200
Message-ID: <CAP8UFD2kwSB60kF_cjs4JYSYeXzvjAtz0OuFOfTqEU7F+ijR-w@mail.gmail.com>
Subject: Re: [GSoC] [PATCH 2/2] submodule--helper: introduce add-config subcommand
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 5, 2021 at 1:42 PM Atharva Raykar <raykar.ath@gmail.com> wrote:
>
> Add a new "add-config" subcommand to `git submodule--helper` with the
> goal of converting part of the shell code in git-submodule.sh related to
> `git submodule add` into C code. This new subcommand sets the
> configuration variables of a newly added submodule, by registering the
> url in local git config, as well as the submodule name and path in the
> .gitmodules file. It also sets 'submodule.<name>.active' to "true" if
> the submodule path has not already been covered by any pathspec
> specified in 'submodule.active'.
>
> This is meant to be a faithful conversion from shell to C, with only one
> minor change: A warning is emitted if no value is specified in
> 'submodule.active', ie, the config looks like: "[submodule] active\n".

Maybe explaining a bit how this warning is useful could help reviewers
here. Especially what could happen if no value is specified in
'submodule.active'?

> The structure of the conditional to check if we need to set the 'active'
> toggle looks different from the shell version -- but behaves the same.
> The change was made to decrease code duplication. A comment has been
> added to explain that only one value of 'submodule.active' is obtained
> to check if we need to call is_submodule_active() at all.
>
> This is part of a series of changes that will result in all of
> 'submodule add' being converted to C.

[...]


> +       /*
> +        * NEEDSWORK: In a multi-working-tree world this needs to be
> +        * set in the per-worktree config.
> +        */
> +       pathspec_key_exists = !git_config_get_string("submodule.active",
> +                                                    &submod_pathspec);
> +       if (pathspec_key_exists && !submod_pathspec)
> +               warning(_("The submodule.active configuration exists, but "
> +                         "no pathspec was specified. Setting the value of "
> +                         "submodule.%s.active to 'true'."), add_data->sm_name);

It's not very clear that we will actually set
'submodule.<name>.active' to true below as it depends on the result of
calling is_submodule_active(), and anyway is_submodule_active() will
check again if "submodule.active" is set, which is wasteful.

Maybe we could set a variable, called for example "activate" here,
with something like:

       if (pathspec_key_exists && !submod_pathspec) {
               warning(...);
               activate = 1;
      }

and below use a check like:

       if (!pathspec_key_exists || activate ||
           !is_submodule_active(the_repository, add_data->sm_path)) {
...

> +       /*
> +        * If submodule.active does not exist, we will activate this
> +        * module unconditionally.
> +        *
> +        * Otherwise, we ask is_submodule_active(), which iterates
> +        * through all the values of 'submodule.active' to determine
> +        * if this module is already active.
> +        */
> +       if (!pathspec_key_exists ||
> +           !is_submodule_active(the_repository, add_data->sm_path)) {
> +               key = xstrfmt("submodule.%s.active", add_data->sm_name);
> +               git_config_set_gently(key, "true");
> +               free(key);
> +       }
> +}

The rest looks good to me! Thanks!
