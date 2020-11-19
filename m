Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD65BC63777
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 22:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4640920B1F
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 22:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JHClFCM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgKSWNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 17:13:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50521 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgKSWNA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 17:13:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C09C9100A8B;
        Thu, 19 Nov 2020 17:12:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ngyNuw7hBr0V
        TW2NIy+XWWB0A9w=; b=JHClFCM2vriei4nnYv2o9Gmrnpz7WIKey1m6p1qIDtE4
        J2OuDMQcC/5ph46QiFqjL3PhqNE2zds8xjjBgQGvxV0qnEoO4UHYNNo5Wnk6DE1O
        9jfnKaH8JFJDW5lgLSYeUcmkHAjIKJtVahjFxoOpHtZUFZt9NYj2dECFv6efBFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UiY5OU
        4QIBflfOnYvjBXoHGF+k3C4dk6to+jKmXs1bov6GprntJXvfipG/8LBZuI8N7XGk
        AcjsyT7eUJbGwaqZEu1YfQkROanoH3qTX74sJfW5hsYRRKE2ye24VGzQ3BgxPeP6
        ZL7wYXZw3APJa7/+BQ2nSz5GOKuWajuMKnY9c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B89EC100A8A;
        Thu, 19 Nov 2020 17:12:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AB2A2100A84;
        Thu, 19 Nov 2020 17:12:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pull: colorize the hint about setting `pull.rebase`
References: <pull.795.git.1605781349528.gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 14:12:48 -0800
In-Reply-To: <pull.795.git.1605781349528.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 19 Nov 2020 10:22:29
        +0000")
Message-ID: <xmqqsg95vvvj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5C5F4DEE-2AB4-11EB-908D-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In d18c950a69f (pull: warn if the user didn't say whether to rebase or
> to merge, 2020-03-09), a new hint was introduced to encourage users to
> make a conscious decision about whether they want their pull to merge o=
r
> to rebase by configuring the `pull.rebase` setting.
>
> This warning was clearly intended to advise users, but as pointed out i=
n
> https://lore.kernel.org/git/87ima2rdsm.fsf%40evledraar.gmail.com, it
> uses `warning()` instead of `advise()`.
>
> One consequence is that the advice is not colorized in the same manner
> as other, similar messages. So let's use `advise()` instead.

The advise() gives unconditional output like warning(), so we still
take advantage of the variable's self-squelching nature.  I am OK
with the change.

Besides coloring (which I personally find it distracting but not so
strongly to forbid others from using), advise() behaves better when
showing multi-line messages, and that would be another reason why
we want to use it over warning() here.

Will queue.  Thanks.

> Pointed-out-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     pull: colorize the hint about setting pull.rebase
>    =20
>     I see that Junio briefly wondered
>     [https://lore.kernel.org/git/xmqqeeuecngu.fsf@gitster-ct.c.googlers=
.com/]=20
>     about using an advice here, and concluded that it was not needed be=
cause
>     the warning is self-squelching (i.e. there is already a config sett=
ing
>     that will silence this warning). But that missed the fact that warn=
ings
>     are not colorized, whereas advice is.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-795%2=
Fdscho%2Fcolorize-pull.rebase-advice-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-795/dsch=
o/colorize-pull.rebase-advice-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/795
>
>  builtin/pull.c               | 24 ++++++++++++------------
>  t/t7601-merge-pull-config.sh |  7 +++++--
>  2 files changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 17aa63cd35..1034372f8b 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -345,18 +345,18 @@ static enum rebase_type config_get_rebase(void)
>  		return parse_config_rebase("pull.rebase", value, 1);
> =20
>  	if (opt_verbosity >=3D 0 && !opt_ff) {
> -		warning(_("Pulling without specifying how to reconcile divergent bra=
nches is\n"
> -			"discouraged. You can squelch this message by running one of the fo=
llowing\n"
> -			"commands sometime before your next pull:\n"
> -			"\n"
> -			"  git config pull.rebase false  # merge (the default strategy)\n"
> -			"  git config pull.rebase true   # rebase\n"
> -			"  git config pull.ff only       # fast-forward only\n"
> -			"\n"
> -			"You can replace \"git config\" with \"git config --global\" to set=
 a default\n"
> -			"preference for all repositories. You can also pass --rebase, --no-=
rebase,\n"
> -			"or --ff-only on the command line to override the configured defaul=
t per\n"
> -			"invocation.\n"));
> +		advise(_("Pulling without specifying how to reconcile divergent bran=
ches is\n"
> +			 "discouraged. You can squelch this message by running one of the f=
ollowing\n"
> +			 "commands sometime before your next pull:\n"
> +			 "\n"
> +			 "  git config pull.rebase false  # merge (the default strategy)\n"
> +			 "  git config pull.rebase true   # rebase\n"
> +			 "  git config pull.ff only       # fast-forward only\n"
> +			 "\n"
> +			 "You can replace \"git config\" with \"git config --global\" to se=
t a default\n"
> +			 "preference for all repositories. You can also pass --rebase, --no=
-rebase,\n"
> +			 "or --ff-only on the command line to override the configured defau=
lt per\n"
> +			 "invocation.\n"));
>  	}
> =20
>  	return REBASE_FALSE;
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.s=
h
> index c5c4ea5fc0..6774e9d86f 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -29,8 +29,11 @@ test_expect_success 'setup' '
> =20
>  test_expect_success 'pull.rebase not set' '
>  	git reset --hard c0 &&
> -	git pull . c1 2>err &&
> -	test_i18ngrep "Pulling without specifying how to reconcile" err
> +	git -c color.advice=3Dalways pull . c1 2>err &&
> +	test_decode_color <err >decoded &&
> +	test_i18ngrep "<YELLOW>hint: " decoded &&
> +	test_i18ngrep "Pulling without specifying how to reconcile" decoded
> +
>  '
> =20
>  test_expect_success 'pull.rebase not set and pull.ff=3Dtrue' '
>
> base-commit: faefdd61ec7c7f6f3c8c9907891465ac9a2a1475
