Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473A1C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 01:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B286120A
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 01:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbhIKBYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 21:24:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58182 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbhIKBYE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 21:24:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D3B2C92EC;
        Fri, 10 Sep 2021 21:22:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=jDdHT/JrVE24bmZs2bLl41nI/
        1Zmxgw+S52zvC4TAgE=; b=fGvQZd0sSdQDxAMYOBe6R+HASALEsqLToi90ymNOw
        S9QoTtsobkoVZRGKQ4lvjm1Q9KmVeBKEYGwbAm+yGYnX2aWqTutdEduXsENQ9Rmq
        EGaiAGCpzZqi7FB2I4qseJs7pZ+nttzL2kxbaPXNHdzs1h47V9OP4A2Y0XwerBYw
        no=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54B52C92EB;
        Fri, 10 Sep 2021 21:22:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD4CCC92EA;
        Fri, 10 Sep 2021 21:22:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/5] help: correct usage & behavior of "git help
 --guides"
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
        <patch-v2-2.5-039639a0dd3-20210910T112545Z-avarab@gmail.com>
Date:   Fri, 10 Sep 2021 18:22:50 -0700
Message-ID: <xmqqilz7oqhh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C8703C46-129E-11EC-BFDD-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> As noted in 65f98358c0c (builtin/help.c: add --guide option,
> 2013-04-02) and a133737b809 (doc: include --guide option description
> for "git help", 2013-04-02) which introduced the --guide option it
> cannot be combined with e.g. <command>.

Missing comman ',' between 'option' and 'it'.

> Change both the usage string to reflect that, and test and assert for

I couldn't immediately tell which two things "both the usage string"
is referring to.  Presumably in the doc and "help -h" output?

> this behavior in the command itself. Now that we assert this in code
> we don't need to exhaustively describe the previous confusing behavior
> in the documentation either, instead of silently ignoring the provided
> argument we'll now error out.
>
> The comment being removed was added in 15f7d494380 (builtin/help.c:
> split "-a" processing into two, 2013-04-02). The "Ignore any remaining
> args" part of it is now no longer applicable as explained above, let's
> just remove it entirely, it's rather obvious that if we're returning
> we're done.

Three sentences strung together with two commas ',' in between at
the end of this paragraph.  "A, let's B, it's C" -> "A. Let's B,
because it's C" or something.

> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> index 568a0b606f3..cb8e3d4da9e 100644
> --- a/Documentation/git-help.txt
> +++ b/Documentation/git-help.txt
> @@ -8,8 +8,9 @@ git-help - Display help information about Git
>  SYNOPSIS
>  --------
>  [verse]
> -'git help' [-a|--all [--[no-]verbose]] [-g|--guides]
> +'git help' [-a|--all [--[no-]verbose]]
>  	   [[-i|--info] [-m|--man] [-w|--web]] [COMMAND|GUIDE]
> +'git help' [-g|--guides]

Good.

> diff --git a/builtin/help.c b/builtin/help.c
> index 44ea2798cda..51b18c291d8 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -59,8 +59,9 @@ static struct option builtin_help_options[] =3D {
>  };
> =20
>  static const char * const builtin_help_usage[] =3D {
> -	N_("git help [-a|--all] [-g|--guides] [--[no-]verbose]]\n"
> +	N_("git help [-a|--all] [--[no-]verbose]]\n"
>  	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
> +	N_("git help [-g|--guides]"),

Good.  I still think -s|--long is cluttering than helping, though.

> +	/* Options that take no further arguments */
> +	if (argc && show_guides)
> +		usage_msg_opt(_("--guides cannot be combined with other options"),
> +			      builtin_help_usage, builtin_help_options);

At this point we have called parse_options() and there is no further
funky command line parsing involved, so non-zero argc does mean we
have something --guides does not know what to do.  Good.

> @@ -582,9 +588,6 @@ int cmd_help(int argc, const char **argv, const cha=
r *prefix)
> =20
>  	if (show_all || show_guides) {
>  		printf("%s\n", _(git_more_info_string));
> -		/*
> -		* We're done. Ignore any remaining args
> -		*/
>  		return 0;
>  	}
> =20
> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index 5679e29c624..c3aa016fd30 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -34,6 +34,10 @@ test_expect_success 'basic help commands' '
>  	git help -a >/dev/null
>  '
> =20
> +test_expect_success 'invalid usage' '
> +	test_expect_code 129 git help -g git-add

;-) =20

I would have expected a bare "add" not "git-add" here, but it
is OK.  It is funny that "git help git-add" still works, but
that is a bug that is unrelated to this patch.

> +'
> +
>  test_expect_success "works for commands and guides by default" '
>  	configure_help &&
>  	git help status &&
