Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939C7CCA48B
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 14:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiGYOlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 10:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiGYOlC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 10:41:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC690634A
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 07:41:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sz17so20982877ejc.9
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 07:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oiqaItkpvzn8FaC9RNiuoCVbDmpGJcg24EGAKN0tUno=;
        b=QICjOcSXUOIezjzYnadqIF+IfnuulYdFhTfEisqYwoI7mkzcZOCSAvNVp/r6OAs2Cn
         arxzy6Ncm9Y/z0UTPCO92wb5R6XLKaV9UXOcH2xzLi02itRP1ykTk38iH1C99nNmERYa
         pyue+4Rn+Re5ucWeIS/9ipXze/qULxBOwmMUwFyDX7wgsczO4QKBBbZedo1OUrMkIKIt
         LbsopP166lX95PuUMZPxLcVurYhsYCOrefDG77H75dfQ+MgPyD/RHdHFRdwDzn3civnR
         HZDAZdOOgG+5OMEtZIG8oAlhMdERjl80CSfdoPmaHfqHngaVQFCOkqah09LNMlR2rDTR
         MB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oiqaItkpvzn8FaC9RNiuoCVbDmpGJcg24EGAKN0tUno=;
        b=40YDcB0IsTXXGQKkpnAzE0Mmb7eJ6ZBpeyeL3SwRajrf5XXNJh0Rb6JyG9Z9yYW6cJ
         GA8VjiCqhAY6BMEVKG6eiv1oToRpJ67fOKicSG0iRG91CoFP/WXOQl9cFKt8A2vFTYpF
         Sby/LAL6bAMxJ5JvEuM3aR4JiS+k3EGMm7Tm+oDYdkEkhhGuRV/IQIa8o2nIiYjq6t6A
         cwa+rihUon3w3qvez0cprFsBK9CtLccgk6PG3o8gJLa+vwcDBa9Dnn2BKQ1d6sHHKaOJ
         3l4dmAW8MYugt2YVRVJSmjQbmjOEtcuD4TiPbHD8fis+Tu0lboEcy+evGS3Ibp8CUREp
         SRWg==
X-Gm-Message-State: AJIora+kkmJrJqHR5D7q1h8gl9EURU6LgNpiiHnLPGIh8SaB6jmBakG4
        Xs0OsTnjciWk9nZaz4My/psOKJQiS/Q=
X-Google-Smtp-Source: AGRyM1vJrZnJArx/n9wbB3/ItzpdynE4dgYkOd5yYDvkIB4OA2W1tieC924UuTEri8jP4tZ1dREMQQ==
X-Received: by 2002:a17:906:5d04:b0:722:f46c:b891 with SMTP id g4-20020a1709065d0400b00722f46cb891mr10608583ejt.4.1658760059177;
        Mon, 25 Jul 2022 07:40:59 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o4-20020aa7c7c4000000b0043a5bcf80a2sm7109972eds.60.2022.07.25.07.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 07:40:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oFzGT-005kOf-RI;
        Mon, 25 Jul 2022 16:40:57 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/20] t0040-parse-options: test parse_options() with
 various 'parse_opt_flags'
Date:   Mon, 25 Jul 2022 16:38:48 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220725123857.2773963-5-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220725123857.2773963-5-szeder.dev@gmail.com>
Message-ID: <220725.86edy9p85i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 25 2022, SZEDER G=C3=A1bor wrote:

> In 't0040-parse-options.sh' we thoroughly test the parsing of all
> types and forms of options, but in all those tests parse_options() is
> always invoked with a 0 flags parameter.
>
> Add a few tests to demonstrate how various 'enum parse_opt_flags'
> values are supposed to influence option parsing.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  t/helper/test-parse-options.c | 61 ++++++++++++++++++++++++++++++
>  t/helper/test-tool.c          |  1 +
>  t/helper/test-tool.h          |  1 +
>  t/t0040-parse-options.sh      | 70 +++++++++++++++++++++++++++++++++++
>  4 files changed, 133 insertions(+)
>
> diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
> index 48d3cf6692..32b906bd6a 100644
> --- a/t/helper/test-parse-options.c
> +++ b/t/helper/test-parse-options.c
> @@ -192,3 +192,64 @@ int cmd__parse_options(int argc, const char **argv)
>=20=20
>  	return ret;
>  }
> +
> +static int parse_options_flags__cmd(int argc, const char **argv,
> +				    enum parse_opt_flags test_flags)
> +{
> +	const char *usage[] =3D {
> +		"<...> cmd [options]",
> +		NULL
> +	};
> +	int opt =3D 0;
> +	const struct option options[] =3D {
> +		OPT_INTEGER('o', "opt", &opt, "an integer option"),
> +		OPT_END()
> +	};
> +
> +	argc =3D parse_options(argc, argv, NULL, options, usage, test_flags);
> +
> +	printf("opt: %d\n", opt);
> +	for (int i =3D 0; i < argc; i++)
> +		printf("arg %02d: %s\n", i, argv[i]);
> +
> +	return 0;
> +}
> +
> +static enum parse_opt_flags test_flags =3D 0;
> +static const struct option test_flag_options[] =3D {
> +	OPT_GROUP("flag-options:"),
> +	OPT_BIT(0, "keep-dashdash", &test_flags,
> +		"pass PARSE_OPT_KEEP_DASHDASH to parse_options()",
> +		PARSE_OPT_KEEP_DASHDASH),
> +	OPT_BIT(0, "stop-at-non-option", &test_flags,
> +		"pass PARSE_OPT_STOP_AT_NON_OPTION to parse_options()",
> +		PARSE_OPT_STOP_AT_NON_OPTION),
> +	OPT_BIT(0, "keep-argv0", &test_flags,
> +		"pass PARSE_OPT_KEEP_ARGV0 to parse_options()",
> +		PARSE_OPT_KEEP_ARGV0),
> +	OPT_BIT(0, "keep-unknown", &test_flags,
> +		"pass PARSE_OPT_KEEP_UNKNOWN to parse_options()",
> +		PARSE_OPT_KEEP_UNKNOWN),
> +	OPT_BIT(0, "no-internal-help", &test_flags,
> +		"pass PARSE_OPT_NO_INTERNAL_HELP to parse_options()",
> +		PARSE_OPT_NO_INTERNAL_HELP),
> +	OPT_END()
> +};
> +
> +int cmd__parse_options_flags(int argc, const char **argv)
> +{
> +	const char *usage[] =3D {
> +		"test-tool parse-options-flags [flag-options] cmd [options]",
> +		NULL
> +	};
> +
> +	argc =3D parse_options(argc, argv, NULL, test_flag_options, usage,
> +			     PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +	if (argc =3D=3D 0 || strcmp(argv[0], "cmd")) {
> +		error("'cmd' is mandatory");
> +		usage_with_options(usage, test_flag_options);
> +	}
> +
> +	return parse_options_flags__cmd(argc, argv, test_flags);
> +}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 318fdbab0c..6e62282b60 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -51,6 +51,7 @@ static struct test_cmd cmds[] =3D {
>  	{ "online-cpus", cmd__online_cpus },
>  	{ "pack-mtimes", cmd__pack_mtimes },
>  	{ "parse-options", cmd__parse_options },
> +	{ "parse-options-flags", cmd__parse_options_flags },
>  	{ "parse-pathspec-file", cmd__parse_pathspec_file },
>  	{ "partial-clone", cmd__partial_clone },
>  	{ "path-utils", cmd__path_utils },

I wanted to add some new parse_options() code to
t/helper/test-parse-options.c in the past, but was stymied by its
cmd_*() going through a singular parse_options().

So just creating a new callback is a neat solution.

But wouldn't it be better to just create a new
t/helper/test-parse-options-something-.c & test file? It seems this
doesn't really share anything with the current helper & tests...
