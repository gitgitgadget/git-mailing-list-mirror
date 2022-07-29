Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F23C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 20:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbiG2UaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 16:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiG2UaV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 16:30:21 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E65D101E3
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 13:30:20 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id pv18-20020a17090b3c9200b001f2460e8ce1so2985528pjb.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 13:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=ZcVVhHuCWBcJjx0YMoMtc8yVp7ZRV47UImLGsx9oN28=;
        b=kJyDikOTnZIbgemGnd1vJui/V47XpGcFu/aLXI51DKJIqN/4yesTRI3vVms1D3UwJD
         naLS8VBm2UO/DZ67gg2gvwHxNIy640dxNwbZuJf5XUv5cV70K9yCK/S20OG0XyJ1hbJE
         bZZOM1xOx3pRIK9RoNWPmeeaYppZFGpBkzD38mcw3ZgzVq9xTh2/g5t2TwiadGAbDASl
         +NEozYrHfIwd7BB1J7QQPQHhQsn1gTGMGJcCziOim6cyCImy/TyYallj5oZ+iFCst1lo
         wpbH7XdLNDTyeClargVXc2kxuNrlwE+SOsTUvd3uNbRHJFzowTGjdvK9rIA7qw3ixWx3
         ieiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=ZcVVhHuCWBcJjx0YMoMtc8yVp7ZRV47UImLGsx9oN28=;
        b=7dGurR8mXBiyLo6y32w//m/4VNmCkObV18gART8VbgTnMvHq/e10YyFqNSYVlKTsSL
         fwPqf9ytvsZhZx72CN2i3ltJm2m/+/lI14EU+6W3zIAOTETcy4H+3kQdgRx3mkvIOTct
         zD8BtO2kT+vrsaJEVpz1lFOnF+XBfbBEiiKoH1L6dDRLERIfmb1BXcC+pLoujmbL72QM
         1F1bgwf64EuK9L/JW38v99sBuxxQmmzgyQ3IS1UZjeHvXbISkFqsSm2Uc1rdt1hIJ0XK
         WjcHDpS3nu/5rsndYWFKLF8DqS8TW8vrYoWKBaYTFGQKnbyg1+nFXNlW/N/V26f0jwC2
         1Mlw==
X-Gm-Message-State: AJIora9Hl7ih+xgkCCPIQLNPnSPZAFnD7lNjAS0t2UZaJ569S+TQ4t01
        4UIct56Igmkg0UX7SHUJMkYVeeeqr3xibQ==
X-Google-Smtp-Source: AGRyM1uNFSqs6eyzuXolqVqSRwiWaM5c8LbJz1Qq8uVvTqzzmCvtJUsbFbwYlu/zekQ8RKlKokosO5H0qh2uUg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:26f1:b0:52b:d0aa:4178 with SMTP
 id p49-20020a056a0026f100b0052bd0aa4178mr5453434pfw.86.1659126619750; Fri, 29
 Jul 2022 13:30:19 -0700 (PDT)
Date:   Fri, 29 Jul 2022 13:30:11 -0700
In-Reply-To: <patch-01.20-84b05bda016-20220728T161116Z-avarab@gmail.com>
Message-Id: <kl6l1qu3slv0.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <patch-01.20-84b05bda016-20220728T161116Z-avarab@gmail.com>
Subject: Re: [PATCH 01/20] submodule tests: test usage behavior
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

As a smoke test, this makes sense.

>
> For "--" this follows up on 68cabbfda36 (submodule: document default
> behavior, 2019-02-15) and tests that when "status" isn't supplied we
> don't support the "--" delimiter. There's no intrinsically good reason
> not to support that. We behave this way due to edge cases in
> git-submodule.sh's implementation, but as with "-h" let's assert our
> current long-standing behavior for now.

By this, do you mean that git-submodule.sh inserts "--" when it invokes
"git submodule--helper"? That also seems ok.

>
> For "--recursive" the exclusion of it from the top-level appears to
> have been an omission in 15fc56a8536 (git submodule foreach: Add
> --recursive to recurse into nested submodules, 2009-08-19), there
> doesn't seem to be a reason not to support it alongside "--quiet" and
> "--cached", but let's likewise assert our existing behavior for now.

I'm not sure about this one. "--recursive" isn't a top level option, and
15fc56a8536 doesn't seem to suggest that it was meant to be one (but I
did realize that git-submodule.txt documents all of the options to all
subcommands, which is very confusing.)

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
> 2.37.1.1167.g38fda70d8c4
