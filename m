Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 181461F461
	for <e@80x24.org>; Thu, 20 Jun 2019 19:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfFTTZR (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 15:25:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56063 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfFTTZR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 15:25:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD6956BAED;
        Thu, 20 Jun 2019 15:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NOWFNUKpD43o
        TQYbEdMhJU+1TI8=; b=AtIXq6/pipQ13vDzQI3LE4ZqmQUMLvyIODqcXUFUFd2R
        ukSbHVVGo9i4Pq7PgnlHhOlmFq4jcJDkz+PIXKnTAQSoRV24eerf/UBSrI9AKhbv
        mfGLjYaeCXUgLak5RG+roxLMl+z8rUKfboA44RLoiDk8RfaDCAtUuhGJWRUgg44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cFuRF1
        J6y0FJZgxvmL5yXEMaHR8mH6Z4hXZxDT6OSQCabelUB5nnbkmbT2BB08iDWBiuhZ
        bOAqu8MPkqth02TF+y4JZAWQ8JBLn7E1d/msHn5eU+3+lnKu/oQiQavWGUdkptVl
        OCnrvGlzXzDfUM7FenPcAhePJ9Zt36QdQQ0zc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4C556BAEC;
        Thu, 20 Jun 2019 15:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D88A96BAE8;
        Thu, 20 Jun 2019 15:25:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] env--helper: new undocumented builtin wrapping git_env_*()
References: <87imt18a2r.fsf@evledraar.gmail.com>
        <20190619233046.27503-2-avarab@gmail.com>
Date:   Thu, 20 Jun 2019 12:25:06 -0700
In-Reply-To: <20190619233046.27503-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 20 Jun 2019 01:30:41 +0200")
Message-ID: <xmqqa7ecnjot.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1DAEA114-9391-11E9-A976-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +	struct option opts[] =3D {
> +		OPT_CMDMODE(0, "mode-bool", &cmdmode,
> +			    N_("invoke git_env_bool(...)"), ENV_HELPER_BOOL),
> +		OPT_CMDMODE(0, "mode-ulong", &cmdmode,
> +			    N_("invoke git_env_ulong(...)"), ENV_HELPER_ULONG),

It may be a fairly useless nitpick, but is there a reason why we
should not just reuse "--type=3D<bool|int|...>" that is understood by
"git config"?  In the longer term, it might make sense to expose
this subcommand as "git env" that sits next to "git config", and at
that point we would regret if we miss the opportunity for obvious
parallel between the two.

> +		OPT_STRING(0, "variable", &env_variable, N_("name"),
> +			   N_("which environment variable to ask git_env_*(...) about")),
> +		OPT_STRING(0, "default", &env_default, N_("value"),
> +			   N_("what default value does git_env_*(...) fall back on?")),
> +		OPT_BOOL(0, "exit-code", &exit_code,
> +			 N_("exit code determined by truth of the git_env_*() function")),
> +		OPT_BOOL(0, "quiet", &quiet,
> +			 N_("don't print the git_env_*() return value")),
> +		OPT_END(),
> +	};
> +
> +	if (parse_options(argc, argv, prefix, opts, env__helper_usage, 0))
> +		usage_with_options(env__helper_usage, opts);
> +	if (!env_variable || !env_default ||
> +	    !*env_variable || !*env_default)
> +		usage_with_options(env__helper_usage, opts);

The default must be supplied?  That makes it smell like it should
not be a command line "option", as it is not optional at all.  Off
the top of my head without the benefit of insight you gained by
working on the remainder of the series (read: this is merely my knee
jerk reaction, and it is very probable that there is sound rationale
why your design is not like what I'll outline), I would imagine an
interface that look more like:

 $ git env --type=3Dbool --default=3Dyes GIT_TEST_FOO=20

    Says "true"/"false" on the standard output and exits with
    success status if $GIT_TEST_FOO is set to the usual
    truth/falsehood values, and gives "true" on the exits with
    success status if $GIT_TEST_FOO is unset.

 $ git env --type=3Dbool GIT_TEST_FOO

    The same as above when $GIT_TEST_FOO is set; exits with failure
    when GIT_TEST_FOO is not exported.

 $ git env --type=3Dbool [--default=3Dyes] --exit-code GIT_TEST_FOO

    Similar to the above two, but the standard output is silent, and
    true/false/failure are given via the exit status (perhaps 0, 1
    and 125 or something like that).

> +	switch (cmdmode) {
> +	case ENV_HELPER_BOOL:
> +		tmp_int =3D strtol(env_default, (char **)&env_default, 10);
> +		if (*env_default) {
> +			error(_("option `--default' expects a numerical value with `--mode-=
bool`"));

No kidding.  "--mode-bool" does not like "--default=3Dfalse"?

