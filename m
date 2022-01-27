Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B55C433FE
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 18:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiA0Spa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 13:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiA0Sp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 13:45:28 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84763C06173B
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 10:45:28 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id p6-20020a170902780600b0014c1f146295so1912772pll.5
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 10:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=6hbYlyJCZ6uZKK3cIst/AbpkPkHdjjGPRvhUh+u14Ks=;
        b=H6z2BftimnudlPdnn4rZrSRe/vHZWJEtfyTgSasfcP6OUgo6mpjZsVdnRCT2kCU+tn
         Lum7agbnasrtp5cuKb6wwvdZLfz08puEQMRZ6tz6hZRNwQhIPA2jbLUuYSWCOxAhwXoU
         /dj4bHdIW/FLzXlfMjtXqKm3ftHQZzKASSEr+rL6EieRLQYv+/DSCsE5wYk64b/f0l5J
         4mxdQ2zHH2TDJcmmXTsxMsIf/GhlanieFXv6SRteIvZreUUTMbsKR1XGG4b83qKlA5X9
         6Qu4Njc5L2yMLbcrcni8oP1B8wKx5MfrlLK1camc6QTZ4PbcExc5RH8J1gcPTm1631SS
         aNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=6hbYlyJCZ6uZKK3cIst/AbpkPkHdjjGPRvhUh+u14Ks=;
        b=IHMhiXSiZKxSHY+ByfZm3VSvZnz3KeUek9ciwNsNP5ts7MIILMFq0JvE7c5nSjDvxb
         zDWaXOCwxS6QXxC1CcIt9h0UYWdTUbYeBvsmPvD3LXi50OZOpBmHdjgcEaeN0mPVIzgO
         7tx1IS8213wAJScV3TtjJR7z1dSlM/7NGTvB5X3O6ze3AG7zHZBzqHy6TXTaiiYbd19J
         fWwH5QPWtXZ+vPgBMphoegXpI5aACAAchac+hlQYqacLUBqr3YePUK/XodQFvunX+iDC
         R4Db0Qc4yKz9ePNuCScugIURC9hyBqOd6h+p7y39FCW2/Wnkj7ctWhpUkF3kkCnJDi2/
         zRuQ==
X-Gm-Message-State: AOAM5310K92NCw5682DJ4KiV93tKm/a8QslFsK5meSe61fiYrNIpPJmO
        hfBHpkBncCsbz+VoQ40Pd3HVDZGCqFK6zA==
X-Google-Smtp-Source: ABdhPJxa7Bv3eCr1UOf4mmL18RktofobuojwmDpEa2hRZj1gB6grrJB0Y8k1JioCHk6UbkNq1CKmSM+yHqJoMQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:7c42:: with SMTP id
 x63mr4089202pfc.31.1643309127958; Thu, 27 Jan 2022 10:45:27 -0800 (PST)
Date:   Thu, 27 Jan 2022 10:45:24 -0800
In-Reply-To: <patch-v4-1.7-1a0b1323cd7-20220127T143552Z-avarab@gmail.com>
Message-Id: <kl6ltudpyq4b.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211013051805.45662-1-raykar.ath@gmail.com> <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
 <patch-v4-1.7-1a0b1323cd7-20220127T143552Z-avarab@gmail.com>
Subject: Re: [PATCH v4 1/7] submodule--helper: get remote names from any repository
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

This wasn't introduced by you (it was introduced in v1 [1]), but I think
it's worth pointing out.

> Let's instead introduce a function called `repo_get_default_remote()`
> which takes any repository object and retrieves the remote accordingly.
>
> `get_default_remote()` is then defined as a call to
> `repo_get_default_remote()` with 'the_repository' passed to it.

We say this, suggesting that repo_get_default_remote()'s signature is
just get_default_remote()'s plus a "struct repository *" (like most
repo_*). But..

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c5d3fc3817f..965260edb22 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -29,11 +29,10 @@
>  typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
>  				  void *cb_data);
> =20
> -static char *get_default_remote(void)
> +static char *repo_get_default_remote(struct repository *repo, const char=
 *refname)
>  {
>  	char *dest =3D NULL, *ret;
>  	struct strbuf sb =3D STRBUF_INIT;
> -	const char *refname =3D resolve_ref_unsafe("HEAD", 0, NULL, NULL);
> =20
>  	if (!refname)
>  		die(_("No such ref: %s"), "HEAD");
> @@ -46,7 +45,7 @@ static char *get_default_remote(void)
>  		die(_("Expecting a full ref name, got %s"), refname);
> =20
>  	strbuf_addf(&sb, "branch.%s.remote", refname);
> -	if (git_config_get_string(sb.buf, &dest))
> +	if (repo_config_get_string(repo, sb.buf, &dest))
>  		ret =3D xstrdup("origin");
>  	else
>  		ret =3D dest;
> @@ -55,6 +54,25 @@ static char *get_default_remote(void)
>  	return ret;
>  }
> =20
> +static char *get_default_remote_submodule(const char *module_path)
> +{
> +	const char *refname;
> +	struct repository subrepo;
> +	int ignore_errno;
> +
> +	refname =3D refs_resolve_ref_unsafe(get_submodule_ref_store(module_path=
),
> +					  "HEAD", 0, NULL, NULL,
> +					  &ignore_errno);
> +	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
> +	return repo_get_default_remote(&subrepo, refname);
> +}
> +
> +static char *get_default_remote(void)
> +{
> +	const char *refname =3D resolve_ref_unsafe("HEAD", 0, NULL, NULL);
> +	return repo_get_default_remote(the_repository, refname);
> +}
> +

repo_get_default_remote() actually take yet another argument - refname.

It looks to me that repo_get_default_remote() shouldn't take the
refname argument at all and that we should be using
refs_resolve_ref_unsafe() instead, like:

  +static char *repo_get_default_remote(struct repository *repo)
    {
    char *dest =3D NULL, *ret;
    struct strbuf sb =3D STRBUF_INIT;
  -	const char *refname =3D resolve_ref_unsafe("HEAD", 0, NULL, NULL);
  +	const char *refname =3D refs_resolve_ref_unsafe(
  +   get_main_ref_store(repo), "HEAD", 0, NULL, NULL /*, errno? */);

this makes the rest of the code a lot cleaner..

  +static char *get_default_remote_submodule(const char *module_path)
  +{
  +	struct repository subrepo;
  +
  +	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
  +	return repo_get_default_remote(&subrepo);
  +}
  +
  +static char *get_default_remote(void)
  +{
  +  return repo_get_default_remote(the_repository);
  +}

And because it's quite idiomatic to initialize the subrepo struct in
order to can call repo_* functions, we could even drop
get_default_remote_submodule() altogether.

As for why this wasn't the original approach, the only reason I can
think of is that we didn't realize get_main_ref_store(subrepo) was an
option.

[1] https://lore.kernel.org/git/20210907115932.36068-3-raykar.ath@gmail.com=
/

