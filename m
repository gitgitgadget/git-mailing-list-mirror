Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D662C433DF
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 20:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B46206F5
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 20:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Jq8/kAlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgGNUWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:22:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:57753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgGNUWm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 16:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594758146;
        bh=tfqZuip5bBwzoU66YdMNKt4Ac/AP8/OUkNexeMHVm+A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Jq8/kAlRl+gdxOQ0jTrt1LRA1pKfCysAIOWHAbelr6zo0fn1ItTYXIbWv3cX3C1J1
         mZmDhX6kOHLxUWWwcByXDafKKDvTecowzvfzaQ8hLxsyX5hWg934c6igFyrLr8w9TH
         i9s2UryFEdsehTU85QWhRhqBBcfFtTSMXAvaCueM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.94.224] ([89.1.215.93]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQIv-1kgcNR2Tx9-00oaqZ; Tue, 14
 Jul 2020 22:22:26 +0200
Date:   Tue, 14 Jul 2020 22:22:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, newren@gmail.com, delphij@google.com,
        peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/2] setup: tweak upgrade policy to grandfather
 worktreeconfig
In-Reply-To: <1b26d9710a7ffaca0bad1f4e1c1729f501ed1559.1594690017.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007142221370.52@tvgsbejvaqbjf.bet>
References: <pull.674.git.1594668051847.gitgitgadget@gmail.com> <pull.674.v2.git.1594690017.gitgitgadget@gmail.com> <1b26d9710a7ffaca0bad1f4e1c1729f501ed1559.1594690017.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5QBh+Vzen9I96c7xwfQzQQk97CCCu/EGNCknXDm0Kv9W3X6ALhu
 XV5/jKGzw/2mflEiylJ7+NwKV17WpD1e9C9bXd8e5ZmFRDzXgEczwgscFOwZdFAl0G75iqL
 FcEPaQobFXZK0geJCryM4VnUr6YnwtmAorWgpj/kPXGXcMsTiIpo/1We6edaYDozYb2ovvx
 a65GieLMlmoIcGdB4Ws0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mvqB3YMR+c0=:D77Z01UbQMCAA2+Fu0UvVa
 XBWBkVGlkWgJWwm3eOqlXaP4ca3E+plYReC7kDZs+wZ6dVPUWM+w+y/y9XsGxPiQzjGO3OKBv
 Z2RBns6GFd714xGCknoS11uRMisuxRnaxm81H0NaFbgOPRJb+ZQkraa0H606YV5JWqOxIcKBS
 YQoSpmOihQCWRejreIxeHgXTFOIECg5uOpU33Sv4k0C4qhEN06sPOo9FwoQ1ndZI4sZTe6hZq
 dU7MYJq3WsxPDcq+ebP41cF6873MvZMgfNxUoBP00CYYkl0o88dfg1UBBCK4pmBR7DA55pHc0
 6pUaZU/BIYuZyldetjWb42/h8Lm4wNKqKNOaXwreX1OiqYD9fVBbWqkQqSecWRZBUY3AZ6dKG
 KvWjQUeifLP2BOAImjMEi96WJFsWXCK7eMNksDkNxTzPkY238MwEvI2YIiFRfUErAK1B723jw
 MHHhBIi8RbAfYDe5FUvScKcjY1KQVWBEaDYmJX2GffXQ/Gkot4GWKb1PKRXLXbX0UqvndUskd
 HUU+oIaJOzpXtvZThmrl6spyetd/6nd2i4AgOkJy0V6t1z02OB90ET/D7gnlEUjzZGsmdh9II
 3HOgKgO2xtviA3q52RHveW0gnzEkLAtbcaiNuc4//4JRqIxu/qP6odg3AnoxPSXYm4U6sIDkX
 HqB2wQr2R9f7M/Cf9H5E/04psNmqSD9H2f0IEyz8Gw/AnLakiptnHgDaXTlp+mqeAheWiqLhh
 zLHDOe8eq5MfGEzHXdcPQA7rTFRQOAyskpjoVjZihPFRvVWb56OSKLdPT+78oGqA6DiAKFm7F
 9pd4JayBtcs7o7tG6WyRPfm2UgKGvlA+3QloaLZIczAxhmzrbaUWHYSD7kM4TgEUCXKpM0BhV
 /jMXK12ODJsVf0dxpy4yeGzhHg46LjdloSNas3Nle3zeTKxEzL+e5n+65eSwaj0+WvaPQYZZz
 53A1Y69aULS2IOZbiRL63S546vkW53REpS99iSyNUotoyshPYSPbWt1MzypvROygtBPXr71vA
 A8jbOJIkm9butk3yaQ8Ypvr3KhAyH1qCZG5henoTAKPR6WUv+G6MKYT7GpUSp9TbXyVkdaGzB
 kDcxZe0R+TOcS/5bc+IaKRNodjb5QLrcmcCG/GrVUvf7A/qCAH6ejqnp03a3pbD20usRdEJ1J
 jFBkBivEZ0NSp2mCzrttB4pwUP10mib/M+W48AAF4VAy/i9swGNLMNhI0yElPSRJ5bEKoPsuP
 NGvT5ae8jNYbjqfScNPAcYMLbeo/2AZ3nCKCyww==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Tue, 14 Jul 2020, Derrick Stolee via GitGitGadget wrote:

> This is because the logic in 14c7fa269e4 refuses to upgrae repos when
> the version is unset but extensions exist.

s/upgrae/upgrade/

The rest looks good to me.

Thank you for working on this,
Dscho

> One possible way to alert a user of this issue is to warn them when Git
> notices an extension exists, but core.repositoryFormatVersion is not a
> correct value. However,
>
>  - it requires the end-user to read, understand and execute the
>    manual upgrade
>
>  - it encourages to follow the same procedure blindly, making the
>    protection even less useful
>
> Let's instead keep failing hard without teaching how to bypass the
> repository protection, but allow upgrading even when only the
> worktreeconfig extension exists in an old repository, which is
> likely to be set by a broke version of Git that did not update the
> repository version when setting the extension.
>
> This change of behavior is made visible by testing how 'git
> sparse-checkout init' behaves to upgrade the repository format version
> even if the extension.worktreeConfig is already set. This would
> previously fail without a clear way forward.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  cache.h                            |  2 +-
>  setup.c                            | 12 ++++++++----
>  t/t1091-sparse-checkout-builtin.sh | 12 ++++++++++++
>  3 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index e5885cc9ea..8ff46857f6 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1042,8 +1042,8 @@ struct repository_format {
>  	int worktree_config;
>  	int is_bare;
>  	int hash_algo;
> -	int has_extensions;
>  	char *work_tree;
> +	int has_unallowed_extensions;
>  	struct string_list unknown_extensions;
>  };
>
> diff --git a/setup.c b/setup.c
> index eb066db6d8..65270440a9 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -455,12 +455,13 @@ static int check_repo_format(const char *var, cons=
t char *value, void *vdata)
>  	if (strcmp(var, "core.repositoryformatversion") =3D=3D 0)
>  		data->version =3D git_config_int(var, value);
>  	else if (skip_prefix(var, "extensions.", &ext)) {
> -		data->has_extensions =3D 1;
>  		/*
>  		 * record any known extensions here; otherwise,
>  		 * we fall through to recording it as unknown, and
>  		 * check_repository_format will complain
>  		 */
> +		int is_unallowed_extension =3D 1;
> +
>  		if (!strcmp(ext, "noop"))
>  			;
>  		else if (!strcmp(ext, "preciousobjects"))
> @@ -469,10 +470,13 @@ static int check_repo_format(const char *var, cons=
t char *value, void *vdata)
>  			if (!value)
>  				return config_error_nonbool(var);
>  			data->partial_clone =3D xstrdup(value);
> -		} else if (!strcmp(ext, "worktreeconfig"))
> +		} else if (!strcmp(ext, "worktreeconfig")) {
>  			data->worktree_config =3D git_config_bool(var, value);
> -		else
> +			is_unallowed_extension =3D 0;
> +		} else
>  			string_list_append(&data->unknown_extensions, ext);
> +
> +		data->has_unallowed_extensions |=3D is_unallowed_extension;
>  	}
>
>  	return read_worktree_config(var, value, vdata);
> @@ -560,7 +564,7 @@ int upgrade_repository_format(int target_version)
>  		return 0;
>
>  	if (verify_repository_format(&repo_fmt, &err) < 0 ||
> -	    (!repo_fmt.version && repo_fmt.has_extensions)) {
> +	    (!repo_fmt.version && repo_fmt.has_unallowed_extensions)) {
>  		warning("unable to upgrade repository format from %d to %d: %s",
>  			repo_fmt.version, target_version, err.buf);
>  		strbuf_release(&err);
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkou=
t-builtin.sh
> index 88cdde255c..6e339c7c8e 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -68,6 +68,18 @@ test_expect_success 'git sparse-checkout init' '
>  	check_files repo a
>  '
>
> +test_expect_success 'git sparse-checkout works if repository format is =
wrong' '
> +	test_when_finished git -C repo config core.repositoryFormatVersion 1 &=
&
> +	git -C repo config --unset core.repositoryFormatVersion &&
> +	git -C repo sparse-checkout init &&
> +	git -C repo config core.repositoryFormatVersion >actual &&
> +	echo 1 >expect &&
> +	git -C repo config core.repositoryFormatVersion 0 &&
> +	git -C repo sparse-checkout init &&
> +	git -C repo config core.repositoryFormatVersion >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'git sparse-checkout list after init' '
>  	git -C repo sparse-checkout list >actual &&
>  	cat >expect <<-\EOF &&
> --
> gitgitgadget
>
>
