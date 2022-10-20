Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6B6C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 22:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJTWOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 18:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJTWOr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 18:14:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0102EF5B
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:14:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-367c2e72a6dso7517027b3.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 15:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8nIGhTT1KU/5r7RF+ggznPoo05DF0euFdKu5pyN6z6o=;
        b=mwshAE0G4igFfwde3Zt+D0kElo7X1zmIHNn2XV1kGhGUdw3T1yhCMLbj/keuhkloCn
         iuYq4prNDeeU6lyxT3QyDM6r1v9yFC6RqKzitMobFQw0R7Gn7UshpMYQC6QrUXA3xXlE
         qbIJScNTmewm+VHQSw6375Sj8CX1GUI/4ICbRqGiYkEeOatUpfownHQCphszkB+RZAcq
         onnIYNBGawtIM+ceRICS7B6L36CZ4pqsXY/vAP39fQUqcxuTLJDHiuhCrxX5KCXtcNCz
         9ZyQN8QRODSZeAQsk0MbKkSHSCbaaoBzc6/+snvCZvxxt9kUMBgTNEIl+4I291adqF4E
         dBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8nIGhTT1KU/5r7RF+ggznPoo05DF0euFdKu5pyN6z6o=;
        b=GiZP79jXiiru2VRYjbcPMXwboFzzkMTSjxmCpNCtT25MuXQfHu2QOQ7mMSm0ePjJNU
         kQ2Kk85ENLnL4DHKdq7XpzdwLBXZkjXze8Ab17BXFsznEwOpc0mFBQ+nnuXdxHt5PGha
         E7kY/7r9MqD6IVz5AK7EUJi9z3rkk6jHgrIYhJyp+4rZpyhPvztNqZeDjnt+aKtxmBxz
         bbS4KsaVZpSqdTsf/8f3QPA5yKSfeU3SQzvtcWdJc6RZMfhJrMcKpNXChhaBXgQEtUWT
         iKdBMwq6ZNA5Ips8FiW9OjQfKjNA0H203uSF8i/Jq+kHeNVmNAwKI6VrGk9n/Ih8Proq
         yCyQ==
X-Gm-Message-State: ACrzQf1ITTtAYN+JR2gqEGkRXI/SZQH2qseVUmaqlE1gq7sbRJ2YRQBq
        wdAafaLhWEoB8l8ieiMWlmhj7ESZLUC2UQ==
X-Google-Smtp-Source: AMsMyM75gj16rGHUumM/dw9fV29O1jz+Dfsuwz9y/t5/L3lq4eM3gBzNt2efib8cEoiRMhrNVrlqdXBIIqoisw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:1453:0:b0:367:fae1:380c with SMTP id
 80-20020a811453000000b00367fae1380cmr6534666ywu.100.1666304085833; Thu, 20
 Oct 2022 15:14:45 -0700 (PDT)
Date:   Thu, 20 Oct 2022 15:14:44 -0700
In-Reply-To: <patch-06.10-25fadf3ffc1-20221017T115544Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com> <patch-06.10-25fadf3ffc1-20221017T115544Z-avarab@gmail.com>
Message-ID: <kl6lsfjixhuz.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 06/10] git-submodule.sh: don't support top-level "--cached"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Since the preceding commit all sub-commands of "git submodule" have
> been dispatched to "git submodule--helper" directly, we therefore
> don't need to emit "usage()" if we see "--cached" without the
> sub-command being "status" or "summary", we can trust that
> parse_options() will spot that and barf on it.
>
> This does change one obscure aspect of undocumented behavior, for
> "status" and "summary" we supported these undocumented forms:
>
>     git submodule --cached (status | summary)
>
> As noted in a preceding commit to git-submodule.sh which removed the
> "--branch" special-case, this comes down to emergent behavior seen in
> 5c08dbbdf1a (git-submodule: fix subcommand parser,
> 2008-01-15). I.e. we wanted to support was for subcommand-less invocation=
s like:
>
>     git submodule --cached
>
> To be synonymous with invocations that explicitly named the "status"
> sub-command:
>
>     git submodule status --cached
>
> But we did not intend to mix the two, and allow "--cached" to be an
> option to the top-level "submodule" command when the "status" or
> "summary" sub-commands were explicitly provided.
>
> Let's remove this undocumented edge case, which makes a subsequent
> removal of git-submodule.sh easier to reason about. The test case
> added here is duplicated from the existing for-loop, except for the
> different and desired handling of "git submodule --cached status".

Makes sense, I completely agree.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index ac2f95c1285..4f8f62ce981 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -43,7 +43,14 @@ do
>  		quiet=3D1
>  		;;
>  	--cached)
> -		cached=3D1
> +		if test -z "$command"
> +		then
> +			cached=3D1 &&
> +			shift &&
> +			break
> +		else
> +			usage
> +		fi
>  		;;
>  	--)
>  		break

Do we need the 'if test -z "$command"'? This is in a 'while test $# !=3D 0
&& test -z "$command"' loop, so it seems unnecessary. I've tried
removing it and it seems to work just fine.

> @@ -69,12 +76,6 @@ then
>      fi
>  fi
> =20
> -# "--cached" is accepted only by "status" and "summary"
> -if test -n "$cached" && test "$command" !=3D status && test "$command" !=
=3D summary
> -then
> -	usage
> -fi
> -
>  case "$command" in
>  absorbgitdirs)
>  	git submodule--helper "$command" --prefix "$wt_prefix" "$@"
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index b50db3f1031..d8f7d6ee29a 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -31,7 +31,7 @@ test_expect_success 'submodule usage: status --' '
>  	test_expect_code 1 git submodule --end-of-options
>  '
> =20
> -for opt in '--quiet' '--cached'
> +for opt in '--quiet'
>  do
>  	test_expect_success "submodule usage: status $opt" '
>  		git submodule $opt &&
> @@ -40,6 +40,17 @@ do
>  	'
>  done
> =20
> +for opt in '--cached'
> +do
> +	test_expect_success "submodule usage: status $opt" '
> +		git submodule $opt &&
> +		git submodule status $opt &&
> +		test_expect_code 1 git submodule $opt status >out 2>err &&
> +		grep "^usage: git submodule" err &&
> +		test_must_be_empty out
> +	'
> +done
> +

Now that there's only a single opt in each of these tests, do we still
want to keep the for loop?

>  test_expect_success 'submodule deinit works on empty repository' '
>  	git submodule deinit --all
>  '
> @@ -576,7 +587,7 @@ test_expect_success 'status should be "modified" afte=
r submodule commit' '
>  '
> =20
>  test_expect_success 'the --cached sha1 should be rev1' '
> -	git submodule --cached status >list &&
> +	git submodule status --cached >list &&
>  	grep "^+$rev1" list
>  '
> =20
> --=20
> 2.38.0.1091.gf9d18265e59
