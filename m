Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F96C38159
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 00:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjASAuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 19:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjASAuh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 19:50:37 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7900E613C3
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 16:50:36 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id 74-20020a62184d000000b0058b9f769609so175655pfy.3
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 16:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOeDoU9Tgfl0Bgns5LoVHiAdw/QLcYLl0TbHXSOoRj4=;
        b=KhitTE+t7GjtxW3RPzWbhnv0yQSZsq3nztRjDiw4Mw3nZUUK+HywhUJJstnZIXgAKc
         90xuLxKr17Pid7dvQXo/q9FP1RoM44G15ymMYf46oMBGCOp7rgOQ/GJU02PvEmFX4As3
         yDp8gh91W6n6D5ecsjOD51D9Cp81w4AyoON6U5quiOJg9K4l723inmbVLVshTcHgdjo1
         HJTXEDapUfWo+0PoPPD0Fm3+HRQAPiZvKY9ryr8zSm5LFh1Gfbq7W9/v6sFsAbd6zqxD
         o6RKDzF4nOJL0wzVz6V4q9mKoqYp9C2uvGkY/vZO2t7QKEWDN40rZlZdTpCsIiDHNzg7
         ovQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pOeDoU9Tgfl0Bgns5LoVHiAdw/QLcYLl0TbHXSOoRj4=;
        b=Nd14K/mhMr63hj7Uf2Iq+tfGhwU4GuuwFf0bTnti8FwqOLtKgyA2uj0LNXZ7pDdKiP
         BeLvbI55mJg36qS6J+6SMFA3qEte1I5KU1BQK1Vb2bzPK4ICbA6ocTXtnUiCeOl6EbaU
         ELwwQvqhBDYYc9PFlFSpm9PVk6WRrxEZ8G5omsaMxdufmTrZIXgbnDBhmF7a/M4plM/S
         AFMkkg86LZuTzyAQcesVMy1Bd8NHmoAbtBbi3EHpRqHQk1yHCvVzJBMpE5xm+09uLHoO
         BGG20qNzwPn0RBuRZLodELi+naEved9kS4hfmRDNm4I0DOCzsc7edu89JpCQkHbiqsrs
         RRXA==
X-Gm-Message-State: AFqh2koKOSfJwl5R3f38sk4obseLQPlSkyY3dQJnuZpVkJCF7Sw3y2Ym
        5dXcSrUPWWQSVLwxuZYkho28EfjeqQZkow==
X-Google-Smtp-Source: AMrXdXtxyCug+D72CQPwNof7I2Z0QEnFZ5iCjDVgTXUSrEK174a5BPHAPVNwQTPWtt1BVIQORO3ObyEXQxXcfQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:ea85:b0:226:e9f2:464d with SMTP
 id h5-20020a17090aea8500b00226e9f2464dmr775842pjz.5.1674089435981; Wed, 18
 Jan 2023 16:50:35 -0800 (PST)
Date:   Wed, 18 Jan 2023 16:50:34 -0800
In-Reply-To: <patch-v3-5.9-e0e6ade3f38-20221125T093159Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
 <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com> <patch-v3-5.9-e0e6ade3f38-20221125T093159Z-avarab@gmail.com>
Message-ID: <kl6lcz7bny91.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 5/9] config API: have *_multi() return an "int" and
 take a "dest"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "SZEDER =?utf-8?Q?G=C3=A1bor?=" <szeder.dev@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:

> Have the "git_configset_get_value_multi()" function and its siblings
> return an "int" and populate a "**dest" parameter like every other
> git_configset_get_*()" in the API.

Indeed, this is the only function that's inconsistent. Great to see that
it's being fixed :)

> As we'll see in in subsequent commits this fixes a blind spot in the
> API where it wasn't possible to tell whether a list was empty from
> whether a config key existed. We'll take advantage of that in
> subsequent commits, but for now we're faithfully converting existing
> API callers.

Sounds good.

> Most of this is straightforward, commentary on cases that stand out:

Thanks for this btw, I found it quite helpful for navigating the patch.
>
> - As we've tested for in a preceding commit we can rely on getting the
>   config list in git_die_config(), and as we need to handle the new
>   return value let's BUG() out if we can't acquire it.

This wasn't immediately clear to me; I'll explain more in the code.

> - In "builtin/for-each-ref.c" we could preserve the comment added in

I think you meant for-each-repo.

> @@ -45,14 +46,10 @@ int cmd_for_each_repo(int argc, const char **argv, co=
nst char *prefix)
>  	if (!config_key)
>  		die(_("missing --config=3D<config>"));
> =20
> -	values =3D repo_config_get_value_multi(the_repository,
> -					     config_key);
> -
> -	/*
> -	 * Do nothing on an empty list, which is equivalent to the case
> -	 * where the config variable does not exist at all.
> -	 */
> -	if (!values)
> +	err =3D repo_config_get_value_multi(the_repository, config_key, &values=
);
> +	if (err < 0)
> +		return 0;
> +	else if (err)
>  		return 0;

This conditional could be collapsed into "if (err)", but it's like this
because the next patch distinguishes between the two cases. Not really
worth the callout in commentary, but FYI for others who might be
wondering the same thing.

> diff --git a/config.c b/config.c
> index c058b2c70c3..0b07045ed8c 100644
> --- a/config.c
> +++ b/config.c
> @@ -2275,23 +2275,28 @@ void read_very_early_config(config_fn_t cb, void =
*data)
>  	config_with_options(cb, data, NULL, &opts);
>  }
> =20
> -static struct config_set_element *configset_find_element(struct config_s=
et *cs, const char *key)
> +static int configset_find_element(struct config_set *cs, const char *key=
,
> +				  struct config_set_element **dest)
>  {
>  	struct config_set_element k;
>  	struct config_set_element *found_entry;
>  	char *normalized_key;
> +	int ret;
> +
>  	/*
>  	 * `key` may come from the user, so normalize it before using it
>  	 * for querying entries from the hashmap.
>  	 */
> -	if (git_config_parse_key(key, &normalized_key, NULL))
> -		return NULL;
> +	ret =3D git_config_parse_key(key, &normalized_key, NULL);
> +	if (ret < 0)
> +		return ret;
> =20
>  	hashmap_entry_init(&k.ent, strhash(normalized_key));
>  	k.key =3D normalized_key;
>  	found_entry =3D hashmap_get_entry(&cs->config_hash, &k, ent, NULL);
>  	free(normalized_key);
> -	return found_entry;
> +	*dest =3D found_entry;
> +	return 0;
>  }
> =20
>  static int configset_add_value(struct config_set *cs, const char *key, c=
onst char *value)
> @@ -2300,8 +2305,11 @@ static int configset_add_value(struct config_set *=
cs, const char *key, const cha
>  	struct string_list_item *si;
>  	struct configset_list_item *l_item;
>  	struct key_value_info *kv_info =3D xmalloc(sizeof(*kv_info));
> +	int ret;
> =20
> -	e =3D configset_find_element(cs, key);
> +	ret =3D configset_find_element(cs, key, &e);
> +	if (ret < 0)
> +		return ret;
>  	/*
>  	 * Since the keys are being fed by git_config*() callback mechanism, th=
ey
>  	 * are already normalized. So simply add them without any further mungi=
ng.
> @@ -2395,24 +2403,38 @@ int git_configset_add_file(struct config_set *cs,=
 const char *filename)
>  int git_configset_get_value(struct config_set *cs, const char *key, cons=
t char **value)
>  {
>  	const struct string_list *values =3D NULL;
> +	int ret;
> +
>  	/*
>  	 * Follows "last one wins" semantic, i.e., if there are multiple matche=
s for the
>  	 * queried key in the files of the configset, the value returned will b=
e the last
>  	 * value in the value list for that key.
>  	 */
> -	values =3D git_configset_get_value_multi(cs, key);
> +	ret =3D git_configset_get_value_multi(cs, key, &values);
> =20
> -	if (!values)
> +	if (ret < 0)
> +		return ret;
> +	else if (!values)
>  		return 1;
>  	assert(values->nr > 0);
>  	*value =3D values->items[values->nr - 1].string;
>  	return 0;
>  }
> =20
> -const struct string_list *git_configset_get_value_multi(struct config_se=
t *cs, const char *key)
> +int git_configset_get_value_multi(struct config_set *cs, const char *key=
,
> +				  const struct string_list **dest)
>  {
> -	struct config_set_element *e =3D configset_find_element(cs, key);
> -	return e ? &e->value_list : NULL;
> +	struct config_set_element *e;
> +	int ret;
> +
> +	ret =3D configset_find_element(cs, key, &e);
> +	if (ret < 0)
> +		return ret;
> +	else if (!e)
> +		return 1;
> +	*dest =3D &e->value_list;
> +
> +	return 0;
>  }

The changes here and the call sites look quite straightforward.

>  int git_config_get_string(const char *key, char **dest)
> @@ -2819,7 +2841,8 @@ void git_die_config(const char *key, const char *er=
r, ...)
>  		error_fn(err, params);
>  		va_end(params);
>  	}
> -	values =3D git_config_get_value_multi(key);
> +	if (git_config_get_value_multi(key, &values))
> +		BUG("for key '%s' we must have a value to report on", key);
>  	kv_info =3D values->items[values->nr - 1].util;
>  	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
>  }

Here is the BUG() call that wasn't immediately clear to me. What wasn't
obvious from the commentary is that this was an 'unhandled error'
before (we didn't check if the returned value was NULL). Arguably we
should have had this BUG call before, but we didn't enforce this until
we added RESULT_MUST_BE_USED.

And this should be a BUG(), and not e.g. error(), since git_die_config()
is meant to report bad config values, so git_config_get_value_multi()
should never fail if we've already managed to get a value, looks good.

> diff --git a/config.h b/config.h
> index ef9eade6414..7f6ce6f2fb5 100644
> --- a/config.h
> +++ b/config.h
> @@ -459,10 +459,18 @@ int git_configset_add_parameters(struct config_set =
*cs);
>  /**
>   * Finds and returns the value list, sorted in order of increasing prior=
ity
>   * for the configuration variable `key` and config set `cs`. When the
> - * configuration variable `key` is not found, returns NULL. The caller
> - * should not free or modify the returned pointer, as it is owned by the=
 cache.
> + * configuration variable `key` is not found, returns 1 without touching
> + * `value`.
> + *
> + * The key will be parsed for validity with git_config_parse_key(), on
> + * error a negative value will be returned.
> + *
> + * The caller should not free or modify the returned pointer, as it is
> + * owned by the cache.
>   */
> -const struct string_list *git_configset_get_value_multi(struct config_se=
t *cs, const char *key);
> +RESULT_MUST_BE_USED
> +int git_configset_get_value_multi(struct config_set *cs, const char *key=
,
> +				  const struct string_list **dest);

Updated comments look good too.
