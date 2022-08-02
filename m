Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2FAC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 22:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiHBWcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiHBWcX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 18:32:23 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179F92C4
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 15:32:20 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o6-20020a17090ab88600b001f30b8c11c5so76484pjr.2
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 15:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=+MfYdMsXSEm1ZuZF8ZGUpbz0MBkgQyHXHwf57vMM4CY=;
        b=YXpggREIp5cnDGNgK56h86NsFSkhKS6xUjKqRtsCSBNHa201yz3Tqe4l4EZjaEkB7q
         elgbvxqQPvMoTuIKTFl8OXXlC2oSwm1P7kMcZS/Im4TxiQLYyw40mHkLFckYAJ+kc5nF
         UONmSl+mYw2J8pexFxvvkl4/M/JDm3H5jW5ntAegBni18EgDzF0PnRax++FE6r5KNZUQ
         YSzgjGOcq9mXJu2YGGHHbSGRaOyXZZHu6Eds/gekzU4fcKKbFYLZsIqdVka9RQrco3ud
         tZn6RLl+dys99gQrRfjX8WCXCo29b+0LUd0PUi6hP4Q0KhD9scHWdETnymBFBUKzvayC
         SwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=+MfYdMsXSEm1ZuZF8ZGUpbz0MBkgQyHXHwf57vMM4CY=;
        b=YRcGGN0IEEo/GOo3ANoiktS3TvT2XsKo4TWqz7VB1E4ZIdmiTHnkv+DUdPnlwr+dJk
         TZy1XFEO3VnbkryvPSDroi4xa5S216iqXAsXlaKXb3RA4r5ME7xIts/ZaSlFSUTJwLMG
         uaOd+z9T//g3p9EUWyrcShAonSdkern+D9vSpmly2RQ/yWurVVwXopLWQcG9Hdh4K8QU
         HABBkMUE1vZiGRElLUoAcT2uqH/AugyAlo1/rfrmLtFi02MvB0qYlRBdbvBKswR/xemF
         Nthb/dlUWIC3P8lLAJ6L8j4BbGphjd7bADF5KRxg/xTKmtfPJdUs0Hz1i23iIEmZxj9z
         xd3A==
X-Gm-Message-State: ACgBeo1aQTHudzjQCHWFJ3aHamUmgEh8X21IUTBKXhp82rkCFFSJUgEk
        2MpcLa7XLa/P0r9JuU3vrzB/hOey2zD1oA==
X-Google-Smtp-Source: AGRyM1sUt/6Fbz7xZ49FxtDXu2XIUu4G+xqSL1ir/51E5iZBpkkJa2fugJ+3PNLWJjl0y2LtTODToF7OR/zmHA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:10c1:b0:52a:d621:138a with SMTP
 id d1-20020a056a0010c100b0052ad621138amr22997510pfu.67.1659479539602; Tue, 02
 Aug 2022 15:32:19 -0700 (PDT)
Date:   Tue, 02 Aug 2022 15:32:18 -0700
In-Reply-To: <patch-v2-08.28-de49f31dab0-20220802T154036Z-avarab@gmail.com>
Message-Id: <kl6lr11ytgy5.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
 <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com> <patch-v2-08.28-de49f31dab0-20220802T154036Z-avarab@gmail.com>
Subject: Re: [PATCH v2 08/28] submodule--helper: move "resolve-relative-url-test"
 to a test-tool
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

> As its name suggests the "resolve-relative-url-test" has never been
> used outside of the test suite, see 63e95beb085 (submodule: port
> resolve_relative_url from shell to C, 2016-04-15) for its original
> addition.
>
> Perhaps it would make sense to drop this code entirely, as we feel
> that we've got enough indirect test coverage, but let's leave that
> question to a possible follow-up change. For now let's keep the test
> coverage this gives us.

Agree with this and the other related messages that describe the intent
behind the test code. Thanks!

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 23 --------------------
>  t/helper/test-submodule.c   | 42 +++++++++++++++++++++++++++++++++++++
>  t/t0060-path-utils.sh       |  2 +-
>  3 files changed, 43 insertions(+), 24 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 06307886080..246457ec2e9 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -96,28 +96,6 @@ static char *resolve_relative_url(const char *rel_url,=
 const char *up_path, int
>  	return resolved_url;
>  }
> =20
> -static int resolve_relative_url_test(int argc, const char **argv, const =
char *prefix)
> -{
> -	char *remoteurl, *res;
> -	const char *up_path, *url;
> -
> -	if (argc !=3D 4)
> -		die("resolve-relative-url-test only accepts three arguments: <up_path>=
 <remoteurl> <url>");
> -
> -	up_path =3D argv[1];
> -	remoteurl =3D xstrdup(argv[2]);
> -	url =3D argv[3];
> -
> -	if (!strcmp(up_path, "(null)"))
> -		up_path =3D NULL;
> -
> -	res =3D relative_url(remoteurl, url, up_path);
> -	puts(res);
> -	free(res);
> -	free(remoteurl);
> -	return 0;
> -}
> -
>  /* the result should be freed by the caller. */
>  static char *get_submodule_displaypath(const char *path, const char *pre=
fix)
>  {
> @@ -3273,7 +3251,6 @@ static struct cmd_struct commands[] =3D {
>  	{"clone", module_clone, SUPPORT_SUPER_PREFIX},
>  	{"add", module_add, 0},
>  	{"update", module_update, SUPPORT_SUPER_PREFIX},
> -	{"resolve-relative-url-test", resolve_relative_url_test, 0},
>  	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
>  	{"init", module_init, 0},
>  	{"status", module_status, SUPPORT_SUPER_PREFIX},
> diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
> index 9f0eb440192..e0e0c53d386 100644
> --- a/t/helper/test-submodule.c
> +++ b/t/helper/test-submodule.c
> @@ -2,6 +2,7 @@
>  #include "test-tool-utils.h"
>  #include "cache.h"
>  #include "parse-options.h"
> +#include "remote.h"
>  #include "submodule-config.h"
>  #include "submodule.h"
> =20
> @@ -19,9 +20,17 @@ static const char *submodule_is_active_usage[] =3D {
>  	NULL
>  };
> =20
> +#define TEST_TOOL_RESOLVE_RELATIVE_URL_USAGE \
> +	"test-tool submodule resolve-relative-url <up_path> <remoteurl> <url>"
> +static const char *submodule_resolve_relative_url_usage[] =3D {
> +	TEST_TOOL_RESOLVE_RELATIVE_URL_USAGE,
> +	NULL,
> +};
> +
>  static const char *submodule_usage[] =3D {
>  	TEST_TOOL_CHECK_NAME_USAGE,
>  	TEST_TOOL_IS_ACTIVE_USAGE,
> +	TEST_TOOL_RESOLVE_RELATIVE_URL_USAGE,
>  	NULL
>  };
> =20
> @@ -76,9 +85,42 @@ static int cmd__submodule_is_active(int argc, const ch=
ar **argv)
>  	return !is_submodule_active(the_repository, argv[0]);
>  }
> =20
> +static int resolve_relative_url(int argc, const char **argv)
> +{
> +	char *remoteurl, *res;
> +	const char *up_path, *url;
> +
> +	up_path =3D argv[0];
> +	remoteurl =3D xstrdup(argv[1]);
> +	url =3D argv[2];
> +
> +	if (!strcmp(up_path, "(null)"))
> +		up_path =3D NULL;
> +
> +	res =3D relative_url(remoteurl, url, up_path);
> +	puts(res);
> +	free(res);
> +	free(remoteurl);
> +	return 0;
> +}
> +
> +static int cmd__submodule_resolve_relative_url(int argc, const char **ar=
gv)
> +{
> +	struct option options[] =3D {
> +		OPT_END()
> +	};
> +	argc =3D parse_options(argc, argv, "test-tools", options,
> +			     submodule_resolve_relative_url_usage, 0);
> +	if (argc !=3D 3)
> +		usage_with_options(submodule_resolve_relative_url_usage, options);
> +
> +	return resolve_relative_url(argc, argv);
> +}
> +
>  static struct test_cmd cmds[] =3D {
>  	{ "check-name", cmd__submodule_check_name },
>  	{ "is-active", cmd__submodule_is_active },
> +	{ "resolve-relative-url", cmd__submodule_resolve_relative_url},
>  };
> =20
>  int cmd__submodule(int argc, const char **argv)
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 1f2007e62b7..68e29c904a6 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -22,7 +22,7 @@ relative_path() {
> =20
>  test_submodule_relative_url() {
>  	test_expect_success "test_submodule_relative_url: $1 $2 $3 =3D> $4" "
> -		actual=3D\$(git submodule--helper resolve-relative-url-test '$1' '$2' =
'$3') &&
> +		actual=3D\$(test-tool submodule resolve-relative-url '$1' '$2' '$3') &=
&
>  		test \"\$actual\" =3D '$4'
>  	"
>  }
> --=20
> 2.37.1.1233.ge8b09efaedc
