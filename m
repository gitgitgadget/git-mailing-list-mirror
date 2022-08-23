Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BE0C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 22:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiHWWm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 18:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiHWWm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 18:42:56 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5277386FFA
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 15:42:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-334ab1f0247so260108757b3.7
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 15:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=ukfxqA8N7bQGHocePXNB0MJJXacf5+pU5Q5vupGtU9A=;
        b=IvztkIoXJS57PWZ47dhWSca8TKvYE4iG0Tg57rSVKduY7FiPRQ7zO+PJB9uNXNgXKy
         hCA14gmlTNBz1holB/YqWYLoyrB1DQSAyNvaoiHzPnQ3C5vpk+N3OgNHEOQ5+y8hyxGq
         FULLfao+9Wrs39xAZtEiUuy/Z8j8gxBvMnFAaaO2BbeOzsap1kOKDxca2B8oTuRRNYxp
         bCc5hDDtW4kw7jEP/vf7yA/sh3qUUyB1ij6vRWDvg0Jv0l6famfANIqhQWE822J3Rg5q
         6NGbKjL8JeG+jOfDwBsFMBdyT7Mqdmdy0FtG855usSnhzWUVXf0TGABIRQMExhMIFwLV
         5X0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=ukfxqA8N7bQGHocePXNB0MJJXacf5+pU5Q5vupGtU9A=;
        b=e4K6GRc2c8oahazfkB/BJhSzql/y+IjB32ZlaUo7Z2uEoDgSWKvOt7XSJHiFkWIwmk
         Vjia4iomH94oph1lzWtS5MuelD9ScLdA6OMAWl4PH5mEwUYYBO/0ESDcUJFNLWXGIRhd
         JmAR4RtXtktP71yBg/PyXFznEkZ0J+5nhNW0cwemTuIZuQ3MqQZbOmyHHBiXESqEJyF2
         bemvw4fQBMKROcYwVPsOalIyGMCYMomuVt10kuPC8b9UUa5QreQ0vadmGNXeZuPAYiUz
         ayqyLrwKIwQ4srmpLUvLvGfkkVJwhzwSXFKIuMIGUDtb71EqcIxTOAfG4d2vasiZpxeN
         9Cag==
X-Gm-Message-State: ACgBeo1IDoRbptWq4+mLQpXnROtzbZBzlqpvIPEPC13qkSV8krswW1cg
        WO9jbJA7L+AUvhCe0XiXNWKsgU9N4qDwQg==
X-Google-Smtp-Source: AA6agR6ZSFN/0EvAAEc37BEUjSSlomvW/OQKJoa9RrKBF2WGEjk0Ym2lSeL+b/uNET3KoG0ub4oJIBEMp2UmmQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:7992:0:b0:336:8015:4889 with SMTP id
 u140-20020a817992000000b0033680154889mr28872163ywc.80.1661294574594; Tue, 23
 Aug 2022 15:42:54 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:42:38 -0700
In-Reply-To: <patch-v3-01.32-77586985ab3-20220821T130231Z-avarab@gmail.com>
Message-Id: <kl6lmtbu4m5d.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
 <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <patch-v3-01.32-77586985ab3-20220821T130231Z-avarab@gmail.com>
Subject: Re: [PATCH v3 01/32] submodule tests: test usage behavior
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Test what exit code and output we emit on "git submodule -h", how we
> handle "--" when no subcommand is specified, and how the top-level
> "--recursive" option is handled.
>
> For "-h" this doesn't make sense, but let's test for it so that any
> subsequent eventual behavior change will become clear.
>
> For "--" this follows up on 68cabbfda36 (submodule: document default
> behavior, 2019-02-15) and tests that "status" doesn't support
> the "--" delimiter. There's no intrinsically good reason not to
> support that. We behave this way due to edge cases in
> git-submodule.sh's implementation, but as with "-h" let's assert our
> current long-standing behavior for now.
>
> For "--recursive" the exclusion of it from the top-level appears to
> have been an omission in 15fc56a8536 (git submodule foreach: Add
> --recursive to recurse into nested submodules, 2009-08-19), there
> doesn't seem to be a reason not to support it alongside "--quiet" and
> "--cached", but let's likewise assert our existing behavior for now.
>
> I.e. as long as "status" is optional it would make sense to support
> all of its options when it's omitted, but we only do that with
> "--quiet" and "--cached", and curiously omit "--recursive".

Ah! Okay, this finally makes sense to me now. The usage strings in
Documentation/git-submodule.txt and git-submodule.sh document both
"--quiet" and "--cached", but that's bogus because we should either:

- pretend that "git submodule" doesn't default to "status", so we
  should omit "--cached", or
- be clearer that "git submodule" _does_ default to "status", so we
  should include "--recursive"

Now that we've acknowledged the existence of top-level "--recursive", we
should probably amend the usage strings. To be honest, I think a less
confusing, more consistent direction would be to just drop this "default
to status" behavior but I doubt we can do that any time soon..

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t7400-submodule-basic.sh | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index e7cec2e457a..b858871a953 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -14,6 +14,32 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> =20
>  . ./test-lib.sh
> =20
> +test_expect_success 'submodule usage: -h' '
> +	git submodule -h >out 2>err &&
> +	grep "^usage: git submodule" out &&
> +	test_must_be_empty err
> +'
> +
> +test_expect_success 'submodule usage: --recursive' '
> +	test_expect_code 1 git submodule --recursive >out 2>err &&
> +	grep "^usage: git submodule" err &&
> +	test_must_be_empty out
> +'
> +
> +test_expect_success 'submodule usage: status --' '
> +	test_expect_code 1 git submodule -- &&
> +	test_expect_code 1 git submodule --end-of-options
> +'
> +
> +for opt in '--quiet' '--cached'
> +do
> +	test_expect_success "submodule usage: status $opt" '
> +		git submodule $opt &&
> +		git submodule status $opt &&
> +		git submodule $opt status
> +	'
> +done
> +
>  test_expect_success 'submodule deinit works on empty repository' '
>  	git submodule deinit --all
>  '
> --=20
> 2.37.2.1279.g64dec4e13cf
