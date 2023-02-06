Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D04C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 12:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjBFMhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 07:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBFMhM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 07:37:12 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CBE20070
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 04:37:09 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id e11-20020a17090a77cb00b0022925dd66d3so8601695pjs.4
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 04:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajuNyV2KrVpxl7sUUqaMJVc5FDMxp+ujn6L0B2p3QSE=;
        b=nIuS7/aly43TYHI2IYhxSB4qgFKhlRaUa/gTx5pSxyUmfxbReep/KGiMzYmtaDVKSz
         8yOxrzjNR4BexCFWysBTlAUFRJGG7RxVzDqx/lFHwglXuFGxdXIoZWMBU4eHQyKq4wNb
         EsuiX5mh8pv7J1qm4iHdi1Zn5hwl4PwIHcX6pVRo/ZMJqM0YT/+W8yW4GWmImUWUm+Te
         FhpUfcNnuGkJz2dNAU8oK5H6Gryw4JwJzNrfJZFKekzyc6De6zY+o1qNUHfKyC9q4cjL
         aSCWaDEe+/ixML1jhU1Q5uYr0fKM4Eetb3NkJooFbYXAVz22gLtPFF6joG/4sQaRrz2E
         G+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ajuNyV2KrVpxl7sUUqaMJVc5FDMxp+ujn6L0B2p3QSE=;
        b=S6yXXm3i37nMeaeuyyAgfcedpQQ0YlMuRD5uxbwm5f1UkQRiqd76ah4qWhjIohLP6X
         WG1DwWs3f8J6+u+AIVaY/uRoF2ja7EKqXW4AIuhgGlM0zRD5jy4sq/A2CwOUmk6se2yY
         KxiwC3Yj63ryXbCf2vsDaDW2VWDVQKqvMvILRolGErntRcvs6TGLHX6lqX1xuoQfkdx+
         dqZc0UQCVD3/69J7RNxwNhySwAwVEiTrN+i1HfMmaneaEiYqb/VC2lfVvt98WFbOJEcZ
         xsaik+Pf5BV7bDcFql8AqGRWklDOG6tWLmDIJV1MCMDDFRLvlRbwfHBCfXfi37zKsR5i
         OkxQ==
X-Gm-Message-State: AO0yUKVUCXYaHgbbI8iO+dJgiHb+mmNavZsEO4hI/1lwfBcyF1v6O0Jp
        5jhDkhBenZom8Ou8aTQ/dOJUojgJ7+6t+g==
X-Google-Smtp-Source: AK7set+EItuBftIiBMRIonCd3nd56yuV5yZ9YtiAN9NXNXbZ6viSF3qsYN4w8+HrShOaTVnifaJvRIPso36ylw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a62:1e82:0:b0:59c:3da0:1629 with SMTP id
 e124-20020a621e82000000b0059c3da01629mr1269600pfe.6.1675687029286; Mon, 06
 Feb 2023 04:37:09 -0800 (PST)
Date:   Mon, 06 Feb 2023 20:37:07 +0800
In-Reply-To: <patch-v4-3.9-998b11ae4bc-20230202T131155Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
 <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com> <patch-v4-3.9-998b11ae4bc-20230202T131155Z-avarab@gmail.com>
Message-ID: <kl6lttzzgebw.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 3/9] config API: add and use a "git_config_get()"
 family of functions
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?=" <szeder.dev@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think introducing a new function to replace the *_get_value_multi()
abuses is a good way forward. Junio has already adequately commented on
your implementation, so I'll focus this review on a different approach
that this patch could have taken.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> We already have the basic "git_config_get_value()" function and its
> "repo_*" and "configset" siblings to get a given "key" and assign the
> last key found to a provided "value".
>
> But some callers don't care about that value, but just want to use the
> return value of the "get_value()" function to check whether the key
> exist (or another non-zero return value).

[...]

> We could have changed git_configset_get_value_multi() to accept a
> "NULL" as a "dest" for all callers, but let's avoid changing the
> behavior of existing API users. Having an "unused" value that we throw
> away internal to config.c is cheap.

There is yet another option, which is to teach "git_config_get_value()"
(mentioned earlier) to accept NULL to mean "I just want to know if there
is a value, I don't care what it is". That's what the *_get_<type>()
functions use under the hood (i.e. the ones that return either 0 or 1 or
exit).

This amounts to implementing the "*_config_key_exists()" API you
mentioned, but I think this is better fit for the current set of
semantics. At the very least, that would be an easy 1-1 replacement for
the *_get_string[_tmp]() replacements we make here. There's also the
small benefit of saving one function implementation.

> Another name for this function could have been
> "*_config_key_exists()", as suggested in [1]. That would work for all
> of these callers, and would currently be equivalent to this function,
> as the git_configset_get_value() API normalizes all non-zero return
> values to a "1".
>
> But adding that API would set us up to lose information, as e.g. if
> git_config_parse_key() in the underlying configset_find_element()
> fails we'd like to return -1, not 1.

We were already 'losing' (or rather, not caring about) this information
with the *_get_<type>() functions. The only reason we'd care about this
is if we using git_configset_get_value_multi() or similar.

We replace two callers of git_configset_get_value_multi() in this patch,
but they didn't care about the -1 case anyway...

> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -557,7 +557,7 @@ static int module_init(int argc, const char **argv, c=
onst char *prefix)
>  	 * If there are no path args and submodule.active is set then,
>  	 * by default, only initialize 'active' modules.
>  	 */
> -	if (!argc && git_config_get_value_multi("submodule.active"))
> +	if (!argc && !git_config_get("submodule.active"))
>  		module_list_active(&list);
> =20
>  	info.prefix =3D prefix;
> @@ -2743,7 +2743,7 @@ static int module_update(int argc, const char **arg=
v, const char *prefix)
>  		 * If there are no path args and submodule.active is set then,
>  		 * by default, only initialize 'active' modules.
>  		 */
> -		if (!argc && git_config_get_value_multi("submodule.active"))
> +		if (!argc && !git_config_get("submodule.active"))
>  			module_list_active(&list);
> =20
>  		info.prefix =3D opt.prefix;

Here they are.

> diff --git a/config.h b/config.h
> index ef9eade6414..04c5e594015 100644
> --- a/config.h
> +++ b/config.h
> @@ -471,9 +471,12 @@ void git_configset_clear(struct config_set *cs);
> =20
>  /*
>   * These functions return 1 if not found, and 0 if found, leaving the fo=
und
> - * value in the 'dest' pointer.
> + * value in the 'dest' pointer (if any).
>   */
> =20
> +RESULT_MUST_BE_USED
> +int git_configset_get(struct config_set *cs, const char *key);
> +

As Junio pointed out, git_configset_get() can now return -1, so this
isn't so accurate any more. git_configset_get() is really the exception
here, since all the other functions in this section are the
git_configset_get_*() functions that use git_configset_get_value(). I'd
prefer returning only 0 or 1 for consistency.

>  /*
>   * Finds the highest-priority value for the configuration variable `key`
>   * and config set `cs`, stores the pointer to it in `value` and returns =
0.
> @@ -494,6 +497,14 @@ int git_configset_get_pathname(struct config_set *cs=
, const char *key, const cha
>  /* Functions for reading a repository's config */
>  struct repository;
>  void repo_config(struct repository *repo, config_fn_t fn, void *data);
> +
> +/**
> + * Run only the discover part of the repo_config_get_*() functions
> + * below, in addition to 1 if not found, returns negative values on
> + * error (e.g. if the key itself is invalid).
> + */
> +RESULT_MUST_BE_USED
> +int repo_config_get(struct repository *repo, const char *key);

This comment is quite a welcome addition. I've found myself losing track
of this information quite often
