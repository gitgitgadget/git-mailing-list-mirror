Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9F0C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 00:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242776AbhLHAU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 19:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbhLHAU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 19:20:27 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631B5C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 16:16:56 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id e12-20020aa7980c000000b0049fa3fc29d0so565137pfl.10
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 16:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=NIVXXRzSZfk4URMf3J8uL8VXNM2nTp+YWT8VnUm2TIw=;
        b=Ff1wK+3cIubjzKPPtY5tT8/PMjhNdfS9Srq4AWfhc02t2LNUe9vvUbjQkIXZGX3N+v
         ROALQGkuseZeyz7e9T6YCW3EOPIorwu8JKcaWbkeUhWz/DpKG5zt8qS6Z/0lwRiwmfqK
         lXFb5VorUzTIN3rl+0D1I//l0A9IEVLYYOSzd0F35evpzmwQ11I6ZwgjHd7+ah96sphB
         9OLUUe2QpHTmA5A5WgsO6DfsCo2hWQ0q79Dg/ntEQ8uJVdXk5jH7gd70isI2GwYd5rDI
         rmm0R0Nv5DwivotQELd8y0sTs4MXqXaStRuKdimVXvOr/Al213PdVr0MB4Btj4fV9u23
         J70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=NIVXXRzSZfk4URMf3J8uL8VXNM2nTp+YWT8VnUm2TIw=;
        b=yroTWrqvmAPnVmGDR0g5VwFteBsqMgYRMeTfEdtE4KLtFvf0bmH3qzGiLY5n2/lP3+
         sKOuSHxBogLSMlFREEVKx5W+EvzpZt1sxm5I50mNovSKeGIFSoIgIHoGIO5gf4chcu4X
         azI0tDu0yiuOC7zTfhZ3loy2BT/kWjRtbIHAarJI+uJ0rG+4SM/1nTE4YJfun+l6XBRV
         um4EdZdP9CaQ1itwhLnLjj/4jM+qGjnoEdtXOhmiaw1vJnz/WA/Yf9r/5E0/oufBkSIM
         2yHY9Or6D01QbYlLYJhXVRY4Xb8ZnpPBAupcblb+48apYOA5V3v8P8KPhimYTEK5OfKk
         +BMg==
X-Gm-Message-State: AOAM531QbUZERt8lAy/Vm3Zw/AfdGLp9wf7aNabiBHBFuhl12lqnuuxp
        02sBycXagVSgDD5mTF9M3slMOoqzS7Pk9Q==
X-Google-Smtp-Source: ABdhPJxqqfKRloAUrJ2AcMJmVUVQEnKnc7tRZMr+ALtHORsQ6C+Ys1TWNCHtKMkwFCWwEwRg7/gLiWYJpu6grQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:4b08:: with SMTP id
 y8mr8454786pga.404.1638922615903; Tue, 07 Dec 2021 16:16:55 -0800 (PST)
Date:   Tue, 07 Dec 2021 16:16:52 -0800
In-Reply-To: <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
Message-Id: <kl6lmtlcar2j.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com> <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for tracking
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, emilyshaffer@google.com, avarab@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> @@ -75,8 +80,17 @@ int install_branch_config(int flag, const char *local,=
 const char *origin, const
> =20
>  	strbuf_reset(&key);
>  	strbuf_addf(&key, "branch.%s.merge", local);
> -	if (git_config_set_gently(key.buf, remote) < 0)
> +	/*
> +	 * We want to overwrite any existing config with all the branches in
> +	 * "remotes". Override any existing config with the first branch, but i=
f
> +	 * more than one is provided, use CONFIG_REGEX_NONE to preserve what
> +	 * we've written so far.
> +	 */
> +	if (git_config_set_gently(key.buf, remotes->items[0].string) < 0)
>  		goto out_err;
> +	for (i =3D 1; i < remotes->nr; i++)
> +		if (git_config_set_multivar_gently(key.buf, remotes->items[i].string, =
CONFIG_REGEX_NONE, 0) < 0)
> +			goto out_err;

I think that instead of overriding all config with the first value and
then appending every value after that, it'll be more obvious to readers
if we first unset all of the config, then write every value (then the
comment wouldn't have to justify why we make two calls and iteration
starts at 1).

I believe that unsetting all values for a key is supported by
git_config_set_multivar_gently() with value =3D=3D NULL, i.e.

  /*
   * unset with value =3D NULL, not sure how this interacts with
   * CONFIG_REGEX_NONE
   */
  if (git_config_set_multivar_gently(key.buf, NULL,
    CONFIG_REGEX_NONE, 0))
    goto out_err;

  for_each_string_list_item(item, remotes) {
    git_config_set_multivar_gently(key.buf, item, CONFIG_REGEX_NONE, 0);
  }

> @@ -121,11 +168,18 @@ int install_branch_config(int flag, const char *loc=
al, const char *origin, const
>  	advise(_(tracking_advice),
>  	       origin ? origin : "",
>  	       origin ? "/" : "",
> -	       shortname ? shortname : remote);
> +	       remotes->items[0].string);
> =20
>  	return -1;
>  }

When there is more than one item in remotes->items, this advice is
_technically_ incorrect because --set-upstream-to only takes a single
upstream branch. I think that supporting multiple upstreams in
--set-upstream-to is a fairly niche use case and is out of scope of this
series, so let's not pursue that option.

Another option would be to replace the mention of --set-upstream-to with
"git config add", but that's unfriendly to the >90% of the user
population that doesn't want multiple merge entries.

If we leave the advice as-is, even though it is misleading, a user who
is sophisticated enough to set up multiple merge entries should also
know that --set-upstream-to won't solve their problems, and would
probably be able to fix their problems by mucking around with
.git/config or git config.

So I think it is ok to not change the advice and to only mention the
first merge item. However, it might be worth marking this as NEEDSWORK
so that subsequent readers of this file understand that this advice is
overly-simplistic and might be worth fixing.

> =20
> +int install_branch_config(int flag, const char *local, const char *origi=
n, const char *remote) {
> +	struct string_list remotes =3D STRING_LIST_INIT_DUP;
> +	string_list_append(&remotes, remote);
> +	return install_branch_config_multiple_remotes(flag, local, origin, &rem=
otes);
> +	string_list_clear(&remotes, 0);
> +}

string_list_clear() is being called after `return`.

=C3=86var and Junio have commented on i18n, but I'm unfamiliar with that, s=
o
I won't comment on that :)
