Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F02CC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 07:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C2161410
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 07:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFOHLk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 03:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhFOHLj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 03:11:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABBCC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 00:09:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso1640856pjb.4
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 00:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8bxgEnpC7d0oK3C50BbMop9rF7Nz2ZZeMXCnnyC0zKw=;
        b=ehobngqgfiQzQWOKbsaDkRWmWopge/iowbvQvgRPqQbCqJazL3uCbdlwzPl4lhhNVS
         B2rt3yI9tY9TbowxlJFKSOqgSu/Rkxm9Cc5QR9IGB9PUoH+WBOjzlV53g8VMoVOxrL8R
         gFMqRySk2SBM5HPDALEC1CbpFgh0z06Yu9ND9rZP25XF9yLZjnMtbExkZpwNJCYPH/Gh
         1yJ3IZctQyex+UNRDZe9SyvvGB19zWE/cTOpML37G5gGuVJeYNnbk3pCsafm+H7d0wVO
         pbv+EQxw9r61EWntACPGCNk5NcyYiQzlZusPXjE1ZcxYCm3B7xX1g+BfpW6E0s0NrO8z
         tRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8bxgEnpC7d0oK3C50BbMop9rF7Nz2ZZeMXCnnyC0zKw=;
        b=CvsmqxwctPmVEVWokB88uzp5RUQLfHOSyhoofJevlsZIyYAayydzHv9dLiG1nsguy6
         d3MPpVBtQJDRBs9PGAnxsk+ryFf43M4N+p0cNKXsw03rUOABNkHxuarPSKs7dcl3vKmB
         OfSfDk757Hx4pJvbibBYAg1TzAebHW08t3Ce25Mg3GJ7btCN1I26LkPuEsx+vw8BkDgu
         S03OZd3CpaL3THeMWwqRfjf4euL5Vc/ZxDDKnQgPy6T/r9LUm/FND/AG15cocdZyon3n
         M8gCqbXihlFVw9yftYabt6PG+esn6BS0UxOtgNUrv3tvxNjE632ttBP5beog7X9p3B/V
         0XIA==
X-Gm-Message-State: AOAM530Yg4WKC11KDUNXwThez1ZBRPaQoQd1XTnSe/XnnDAlDvQw5fyZ
        HOH+6E7A5MNKTB5Lm/NrcWXNwxP9fOWXgwSYSqU=
X-Google-Smtp-Source: ABdhPJzWZ2KIscw8eKIygV3gTXkiAHiBnah+Be8SwNEbDCCNJmgPfiYTF/5fe8OzIZSTflqRmJ8Jfg==
X-Received: by 2002:a17:90a:474f:: with SMTP id y15mr3548795pjg.69.1623740974085;
        Tue, 15 Jun 2021 00:09:34 -0700 (PDT)
Received: from smtpclient.apple ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id x3sm15881069pgx.8.2021.06.15.00.09.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 00:09:33 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v4 3/3] submodule--helper: introduce add-config subcommand
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <gohp6kh7i0xm08.fsf@cpm12071.fritz.box>
Date:   Tue, 15 Jun 2021 12:39:30 +0530
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E2277B26-8179-46B0-A390-AD3457A034C5@gmail.com>
References: <20210610083916.96243-1-raykar.ath@gmail.com>
 <20210614125157.99426-1-raykar.ath@gmail.com>
 <20210614125157.99426-4-raykar.ath@gmail.com>
 <gohp6kh7i0xm08.fsf@cpm12071.fritz.box>
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15-Jun-2021, at 01:21, Rafael Silva <rafaeloliveira.cs@gmail.com> =
wrote:
>=20
>=20
> Atharva Raykar <raykar.ath@gmail.com> writes:
>=20
>> ---
>> builtin/submodule--helper.c | 119 =
++++++++++++++++++++++++++++++++++++
>> git-submodule.sh            |  28 +--------
>> 2 files changed, 120 insertions(+), 27 deletions(-)
>>=20
>=20
> I do not have enough expertise to judge the entire content of this
> patch. I would like, however, to propose a slight code change for the
> sake of readability.
>=20
>> diff --git a/builtin/submodule--helper.c =
b/builtin/submodule--helper.c
>> index 6dffaeb6cb..c4b2aa6537 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -2935,6 +2935,124 @@ static int add_clone(int argc, const char =
**argv, const char *prefix)
>> 	return 0;
>> }
>>=20
>> +static void configure_added_submodule(struct add_data *add_data)
>> +{
>> +	char *key, *submod_pathspec =3D NULL;
>> +	struct child_process add_submod =3D CHILD_PROCESS_INIT;
>> +	struct child_process add_gitmodules =3D CHILD_PROCESS_INIT;
>> +	int pathspec_key_exists, activate =3D 0;
>> +
>> +	key =3D xstrfmt("submodule.%s.url", add_data->sm_name);
>> +	git_config_set_gently(key, add_data->realrepo);
>> +	free(key);
>> +
>> +	add_submod.git_cmd =3D 1;
>> +	strvec_pushl(&add_submod.args, "add",
>> +		     "--no-warn-embedded-repo", NULL);
>> +	if (add_data->force)
>> +		strvec_push(&add_submod.args, "--force");
>> +	strvec_pushl(&add_submod.args, "--", add_data->sm_path, NULL);
>> +
>> +	if (run_command(&add_submod))
>> +		die(_("Failed to add submodule '%s'"), =
add_data->sm_path);
>> +
>> +	key =3D xstrfmt("submodule.%s.path", add_data->sm_name);
>> +	config_set_in_gitmodules_file_gently(key, add_data->sm_path);
>> +	free(key);
>=20
> This above three lines of code is very similar to the two operations =
that
> follows (including the one inside the `if (add_data->branch)`
> condition. So [ ... ]
>=20
>> +	key =3D xstrfmt("submodule.%s.url", add_data->sm_name);
>> +	config_set_in_gitmodules_file_gently(key, add_data->repo);
>> +	free(key);
>> +	if (add_data->branch) {
>> +		key =3D xstrfmt("submodule.%s.branch", =
add_data->sm_path);
>> +		config_set_in_gitmodules_file_gently(key, =
add_data->branch);
>> +		free(key);
>> +	}
>> +
>=20
> [ ... ] it might be worth to write a small wrapper that will perform: =
(1)
> `xstrfmt()` on the specified config section, (2) set the configuration
> in the file and (3) free()'ing the variable inside the wrapper. Thus,
> most of these code will become one liners that is easier to read =
(given
> the function is properly named :) ).
>=20
> After abstracting the code on the wrapper, this code will become
> something like:
>=20
>=20
>    function_properly_named("submodule.%s.path", add_data->sm_name, =
add_data->sm_path);
>    function_properly_named("submodule.%s.url", add_data->sm_name, =
add_data->repo);
>    if (add_data->branch)
>         function_properly_named("submodule.%s.branch", =
add_data->sm_path, add_data->branch);
>=20
>=20
> Just as an example, here's a diff to demonstrate the argument:
>=20
> -- >8 --
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 65f79fbd53..48ea909f51 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2934,6 +2934,14 @@ static int add_clone(int argc, const char =
**argv, const char *prefix)
> 	return 0;
> }
>=20
> +void add_config_in_submodules_file(const char *keyfmt, const char =
*submodule,
> +			  const char *value)
> +{
> +	char *key =3D xstrfmt(keyfmt, submodule);
> +	config_set_in_gitmodules_file_gently(key, value);
> +	free(key);
> +}
> +
> static void configure_added_submodule(struct add_data *add_data)
> {
> 	char *key, *submod_pathspec =3D NULL;
> @@ -2955,17 +2963,10 @@ static void configure_added_submodule(struct =
add_data *add_data)
> 	if (run_command(&add_submod))
> 		die(_("Failed to add submodule '%s'"), =
add_data->sm_path);
>=20
> -	key =3D xstrfmt("submodule.%s.path", add_data->sm_name);
> -	config_set_in_gitmodules_file_gently(key, add_data->sm_path);
> -	free(key);
> -	key =3D xstrfmt("submodule.%s.url", add_data->sm_name);
> -	config_set_in_gitmodules_file_gently(key, add_data->repo);
> -	free(key);
> -	if (add_data->branch) {
> -		key =3D xstrfmt("submodule.%s.branch", =
add_data->sm_path);
> -		config_set_in_gitmodules_file_gently(key, =
add_data->branch);
> -		free(key);
> -	}
> +	add_config_in_submodules_file("submodule.%s.path", =
add_data->sm_name, add_data->sm_path);
> +	add_config_in_submodules_file("submodule.%s.url", =
add_data->sm_name, add_data->repo);
> +	if (add_data->branch)
> +		add_config_in_submodules_file("submodule.%s.branch", =
add_data->sm_path, add_data->branch);
>=20
> 	add_gitmodules.git_cmd =3D 1;
> 	strvec_pushl(&add_gitmodules.args,
>=20
> -- >8 --
>=20
> A proper name than "add_config_in_submodules_file" should be =
considered - I'm
> not very good in naming things.
>=20
> These change does (should) not change the behavior of code, even =
though
> I believe it make the code simpler to read, I do not have strong
> opinions about it. So, take this proposal as you wish.=20

I agree with you, this will make the code simpler to read. It also
made me realise one thing that I did not replicate exactly from the
shell code.

The original shell code calls 'module_config()', which does an extra
check to see if writing to '.gitmodules' is okay. I did not perform
this check, and including that in the wrapper you propose will be a
good idea.

> --=20
> Thanks
> Rafael

