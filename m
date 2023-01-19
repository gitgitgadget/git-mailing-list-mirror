Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469F1C677F1
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 01:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjASBD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 20:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjASBDX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 20:03:23 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC858611FF
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 17:03:22 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id m7-20020a170902db0700b00194bd3c810aso421169plx.23
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 17:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUX+boeV3AAUNNTc7aOIKiLEHi8bWnaqOwc1D7fvztM=;
        b=Q3Xa4DHnVEFcFOZo24BMFK3wTV34OCKbs+obsKW3/OkWXey0o8fnAsdTWWdkYlngEA
         4YVGRVgff4YcRhVpxu8X+cgnGa+cZgAkMZ1sHpXjXo5U6hkWhjv1SfH4viU2AaSKMlR5
         HEJZ60Q2XeN0349TH5b/hv/KA9ESXE8LUT5GvAePktfcaORL8dP12APAJSpUD/a/xw6R
         6sz9B3ocLawbiMJJVHGuytpRSgm8aCVi46uLHdi4thHdaX8C5BEEUhT7EGOss4dMnkw0
         jpdVpwu3TMBVPspJ/G+welFMstWGwMRPZSmyBkIbHzx5OEuRhG4FUEqMssTdymzqO14G
         DqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fUX+boeV3AAUNNTc7aOIKiLEHi8bWnaqOwc1D7fvztM=;
        b=hNc9jW7du47lNo1EMzRdMBaruM7eXsNGKL6LYlrQxdewFrVJxd3Y7XvFTQUzIOFr0f
         gOlXc8ZxeOj5mGyvmCRCjOH9m6Jpgk9EqmHukBO9ZVWrBpapOsaYswhHldxp/0RK5MT3
         sPf95L+DxdP+hUVHzMYMgUplUH4OfQcsZWeXJss/ygDTVuvVqz/p6eF7NnnOdTINKgjU
         Rjj3PWsS7FLAV/SdpIY3OrJK1Fzy+0VtZOz60nwKOyPnFb4K/LY3u4HmY+NYVl0kj0dU
         Svi7R3OMUq+9lBaCXp16A8WVC96WTxV5YkSlKZ6fF4L5hxYK91LQ9tyvVg1/mPzBaE13
         Ol7w==
X-Gm-Message-State: AFqh2kqEm+TGcV9on6JIauoCFz4jiqGNKYq2OmLlGll/9oDt5vntXz0b
        K8GdACvvXCSN3LgCnqpYYYijZtM56lMVGA==
X-Google-Smtp-Source: AMrXdXtEcjwzKJTiKfLV2s+sk4ycNxxBmgX/ap3P5Le0R6kp3ntWtMsMxCRPAQaA2hT0Q7aLg18mXHGzN0wcbQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:4c81:b0:583:39ca:82f2 with SMTP
 id eb1-20020a056a004c8100b0058339ca82f2mr783203pfb.10.1674090202379; Wed, 18
 Jan 2023 17:03:22 -0800 (PST)
Date:   Wed, 18 Jan 2023 17:03:20 -0800
In-Reply-To: <patch-v3-8.9-b45189b4624-20221125T093159Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
 <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com> <patch-v3-8.9-b45189b4624-20221125T093159Z-avarab@gmail.com>
Message-ID: <kl6l7cxjnxnr.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 8/9] config API: add "string" version of
 *_value_multi(), fix segfaults
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

> Fix numerous and mostly long-standing segfaults in consumers of
> the *_config_*value_multi() API. As discussed in the preceding commit
> an empty key in the config syntax yields a "NULL" string, which these
> users would give to strcmp() (or similar), resulting in segfaults.
>
> As this change shows, most users users of the *_config_*value_multi()
> API didn't really want such an an unsafe and low-level API, let's give
> them something with the safety of git_config_get_string() instead.

I think the low-level API argument makes sense. All of the other
*_get_*() functions perform some kind of validation, e.g.
config_parse_*() for non-string types and config_error_nonbool() for
strings. In effect, *_get_value_multi() was returning raw output from
the config parser without any concern for the caller.

> This fix is similar to what the *_string() functions and others
> acquired in[1] and [2]. Namely introducing and using a safer
> "*_get_string_multi()" variant of the low-level "_*value_multi()"
> function.

This suggests to me that we should really get rid of
*_get_value_multi(), since nobody outside of config.c should need it. I
don't think we'd ever end up in a situation where the caller wants the
raw strings from the config parser (unless we had a config
key which accepted values of different types? but that sounds like a
terrible mistake).

> There are now three remaining files using the low-level API:
>
> - Two cases in "builtin/submodule--helper.c", where it's used safely
>   to see if any config exists.
> - One in "builtin/for-each-repo.c", which we'll convert in a
>   subsequent commit.
> - The "t/helper/test-config.c" code added in [3].

As you noted, the only remaining non-test caller of the low-level API is
builtin/submodule--helper.c, which maybe we could safely convert anyway
and get rid of the API altogether. I'm okay with that being a leftover
bit, but maybe that's worth noting in the CL.

> The callback pattern being used here will make it easy to introduce
> e.g. a "multi" variant which coerces its values to "bool", "int",
> "path" etc.

I like that this is quite easily extensible, e.g.

> diff --git a/config.c b/config.c
> index 0b07045ed8c..9bd43189c02 100644
> --- a/config.c
> +++ b/config.c
> @@ -2437,6 +2437,25 @@ int git_configset_get_value_multi(struct config_se=
t *cs, const char *key,
>  	return 0;
>  }
> =20
> +static int check_multi_string(struct string_list_item *item, void *util)
> +{
> +	return item->string ? 0 : config_error_nonbool(util);
> +}
> +
> +int git_configset_get_string_multi(struct config_set *cs, const char *ke=
y,
> +				   const struct string_list **dest)
> +{
> +	int ret;
> +
> +	if ((ret =3D git_configset_get_value_multi(cs, key, dest)))
> +		return ret;
> +	if ((ret =3D for_each_string_list((struct string_list *)*dest,
> +					check_multi_string, (void *)key)))
> +		return ret;
> +
> +	return 0;
> +}

we could just use config_parse_<typename>() if we want to add, e.g.
*_get_bool_multi().

And as a reasonableness check, config_error_nonbool() is what we use to
validate the *_get_string() functions, so it makes sense to reuse it for
the string list version.
