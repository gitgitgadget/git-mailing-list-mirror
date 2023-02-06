Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB96C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 12:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjBFM4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 07:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBFM4u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 07:56:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C823614495
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 04:56:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z129-20020a256587000000b0089da1e9b65cso1948856ybb.22
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 04:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azy/v9FEcA1me5/2+c1cp/YPr0hZZFg47j860koEuyU=;
        b=cHBfSktE2KDTEZp1GIvjTh/gbGP88YYDEb34MNBwTsh1Dptx5xsyBcvrIr2LtzHCY7
         MGuezEjAeXofYNTuzUYhhZPRkKgrnhDFi5trNKDWL1qi2DC+MRNHFMTXeRPoVd4na1KE
         ddDEKPGc3pXE7utSBvF3rpoDKlmmaGXXQMy8K6AL5/M7PSXAoWqsaQGNuK5B+Q6KAxjl
         gcU7spj4a6qFcKDxnJLvx13hcKRUUEKAYuHIgfVi5o+upCtJdA2yT05SnMc03hnWLu2u
         Fd2xwGtPzLEc5EZdNDnhcq9BrvXSKx78quyt4cnA7htQLL1vPsGH9YZVnwGf5KSfhdwX
         QMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=azy/v9FEcA1me5/2+c1cp/YPr0hZZFg47j860koEuyU=;
        b=pQdVBO+EgyR63PY62sK92KtwzpPulZUxYH1Mjk0RTBZxextZSJjqxhwTOc9LzFQlAG
         b3C0CXvMQ+3bPCBvJcsq60OoeYWG+rd/NFFH99p9vggIkgafzugzIaObns3XcGDcV/yR
         4ZwBOPfIU/yP5Jpgoyvl2gpUzm2YjrJt9YyA+FW0guIJJc1YrtLlxknnrckSCGIOtjtS
         50rUaJSdsuLhN77vMVqNsjQSCHIsVWiUYmATjAs3OWkJ2q+9J0ml6gQjun3HfEnicXVu
         o1LIremGfqG1ASn+30WZAh94qtLv72MM+i814utVF2sUiXsMmu9vNXKOm1k5MNti+LE2
         Wc3g==
X-Gm-Message-State: AO0yUKVVn9BpLTm8Ll4VIx5qn2nAMigbbiWplbEm4mHESfJRqzG9px5z
        sdyDZKVMAk/850vUY59Tl/5wFZkmEA65ag==
X-Google-Smtp-Source: AK7set8ogmPIfeQ6nRIyZN+iOmwfav9FN1pBLRGMgj34YpC2FXJL+UlWg6R0jLUu0ohFiSfAg9/AXgTx6l/4Lg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a0d:f743:0:b0:510:475e:df77 with SMTP id
 h64-20020a0df743000000b00510475edf77mr1809402ywf.440.1675688208978; Mon, 06
 Feb 2023 04:56:48 -0800 (PST)
Date:   Mon, 06 Feb 2023 20:56:47 +0800
In-Reply-To: <patch-v4-6.9-17c1218e74c-20230202T131155Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
 <cover-v4-0.9-00000000000-20230202T131155Z-avarab@gmail.com> <patch-v4-6.9-17c1218e74c-20230202T131155Z-avarab@gmail.com>
Message-ID: <kl6lpmangdf4.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 6/9] for-each-repo: error on bad --config
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

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Before this, all these added tests would pass with an exit code of 0.
>
> We could preserve the comment added in 6c62f015520, but now that we're
> directly using the documented repo_config_get_value_multi() value it's
> just narrating something that should be obvious from the API use, so
> let's drop it.

[...]

> diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
> index fd0e7739e6a..224164addb3 100644
> --- a/builtin/for-each-repo.c
> +++ b/builtin/for-each-repo.c
> @@ -32,6 +32,7 @@ int cmd_for_each_repo(int argc, const char **argv, cons=
t char *prefix)
>  	static const char *config_key =3D NULL;
>  	int i, result =3D 0;
>  	const struct string_list *values;
> +	int err;
> =20
>  	const struct option options[] =3D {
>  		OPT_STRING(0, "config", &config_key, N_("config"),
> @@ -45,11 +46,11 @@ int cmd_for_each_repo(int argc, const char **argv, co=
nst char *prefix)
>  	if (!config_key)
>  		die(_("missing --config=3D<config>"));
> =20
> -	/*
> -	 * Do nothing on an empty list, which is equivalent to the case
> -	 * where the config variable does not exist at all.
> -	 */
> -	if (repo_config_get_value_multi(the_repository, config_key, &values))
> +	err =3D repo_config_get_value_multi(the_repository, config_key, &values=
);
> +	if (err < 0)
> +		usage_msg_optf(_("got bad config --config=3D%s"),
> +			       for_each_repo_usage, options, config_key);
> +	else if (err)
>  		return 0;

Compared to v3, this change was moved from the previous patch to this
one.

> diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
> index 3648d439a87..6b51e00da0e 100755
> --- a/t/t0068-for-each-repo.sh
> +++ b/t/t0068-for-each-repo.sh
> @@ -40,4 +40,10 @@ test_expect_success 'do nothing on empty config' '
>  	git for-each-repo --config=3Dbogus.config -- help --no-such-option
>  '
> =20
> +test_expect_success 'error on bad config keys' '
> +	test_expect_code 129 git for-each-repo --config=3Da &&
> +	test_expect_code 129 git for-each-repo --config=3Da.b. &&
> +	test_expect_code 129 git for-each-repo --config=3D"'\''.b"
> +'
> +
>  test_done

And this was moved from patch 1. Both make a lot of sense in this patch,
I think this version reads a bit better.
