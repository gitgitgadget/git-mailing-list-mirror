Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9D4376BCC
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768438; cv=none; b=ULDQmxhqNjMyynq0f7N+ucIZt6rAPvffuszeyqLbeV4HqEWATC/IjPjxFiMo75bB/XuA8wcVgyyS1rA9jR9e4uM4HDALcOTLnjJRqWyMjoZpLegHGZeUZ8YLCiUj1YDa+InPlUQ5jqKV7ougBWwOhekHACezPdvE/bktTLHrets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768438; c=relaxed/simple;
	bh=TxBUfIPpcxGcGcPqdwCT5+z3OPMWhgL8orwIki+1Z7o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iw6rSKqfaNztXQao1HCkgVa+mt8WO1E1dd6hgcg42AXUq3hlBsD2ReQ5I23pAioZlMpbNNwx5czVPyeOsP6Jp8bxsfFoSjKZ3sa3ls9o66cECKf8DDpnf216UP+X7zGjIlXsh6A6WNvSFjVup9m+rwjS7sTqVB/PbBZ3sPWVl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HKRyWRaf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gu20PhYF; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HKRyWRaf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gu20PhYF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 29CC97A00CC;
	Wed, 26 Aug 2026 14:20:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 26 Aug 2026 14:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787768425; x=1787854825; bh=MuC2Iq7RaN
	HrW8gEUDAmW0Q0jby6aLDrQr1PBxEhMms=; b=HKRyWRaf1OIx4OcRthp8eMy8tW
	3lvz6x68dmgSCX7kn8JU+QG0iOiXPSI2Mv/erhZUJyU5q0YYTNgKikonoSpIsv+T
	GNB2CyMHgDHERsSjsG1mksbBC0TPhq1OEinmXzQPFHYv+hFJyIyiRVWapotfdWlt
	Yu8zFvQ5ATiDqMTo6DSaySFgvz9lAdiUZa41E8/66C6FgrI8dw2QWiUR/XU8Yffc
	7Fa86hw2A9QksTjtma8T24PPz8A26kquMyWT5U69GlZFbRJDg82658k7JcBb0Jsm
	8AWF315HShBkf2amUSNJzJjykh5V3ObHZQ2dsdQ+JTdxxLvwSuN83wZ1i6iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787768425; x=1787854825; bh=MuC2Iq7RaNHrW8gEUDAmW0Q0jby6aLDrQr1
	PBxEhMms=; b=gu20PhYFSdNT5uJ3RjTd715Go1EYZf9QgIMsWbMnuHALRWxJeEQ
	HSzwgDl3NO1EpfWfqH+Qei0soD80frs+Q4aguMucapc8/etnk5cyP5xGeiAd7teM
	iC+wRCofd0O2ukpkG304F3bXsO9+zuCNt3UtdDa2LqDe72v1quiiw4vrDQXu4RqW
	qVHFk8UFtDsanGHB1OHI1rAqTWa2Y9AM2/iGLB0tWr0SPYDJlMYDm4AOXtK+admX
	vdDK9sTlqZY7Jy68g6I+XDq+c0V/uuUZrqLe0j3uTl43QAaxAVtUMBkHEcqubHvX
	O4tEFgWXviQ/y963sSutj54RSGKtA3Tq6Qg==
X-ME-Sender: <xms:aC6PajRGxqlgwvHTTAIexESoCCWbQCgI04cDNa3IA6uwILze7Ks2mQ>
    <xme:aC6Pan2d42xC2_HNfNRKSezUvRgN2l0ttjoCFgED8rV18dmI5gNHacu2jxSHaC-4V
    HqtJtI9_cLRrbCL0mr26j2TEilSUZhzVi9EU16s43cJWxHLPxiYow>
X-ME-Received: <xmr:aC6Pajc0ws2rc_KXcks9zxwz_kG0ELGVrCCqgTalJ2UXSvPrPulta-mZ9RtK8GdQQWxPsFKAtGTmrKiH-LeFnbChtM_87MXNEw>
X-ME-Proxy-Cause: dmFkZTFdneJG8lFnkHHxyf3zppA/jLzoyVfNhgOviyNRk8dfLxX+Vpb3gKhns70kkrRgaq
    0OSLM/dedQG6t7fZBuqrOD9X3kX3y0Wm7QMKXuMnIcxHJfIlaF5akkcMwCXC6MIdLFTLZY
    YnLGPnamPqFMtqPX2s1cFCO3H2RcXpH3NoCL7JCdp5W8hjJZbaXt6GlZsv5s6ZoowcEUNs
    poRyb/vZD/8Oal2fjUD7MB8fksQ7zoGDdGKFWiZkpU5oRdzLvWILT7zQkLyME3TbHVoQ0F
    Zr2UHdk65cYvINRs9yFgchLc+UsCp8MftJTIWPSqW/BEro56zMOKQCEa3QrX74KT0X1JCx
    Cz0x+lBhDx+npj9ujEmqxb9jgaA1EtyY7O+GcAGWjgJXzI5A7lgdG0E78N+K2h/E44Ozvn
    3oI0Ti9WRHAes5QUVBWtBZf0RB84GkWxrBmIw1x1J1w9OEHhZpJa/h48WaI+7ZFCfsu2/6
    tIqqNjXgbPY8b1N1oGor7R+LSLj8Nac5hTTB9QvLvswZkB+dQJRyDVqVsLmpaadkhRP4wY
    x/qjX6bcTMQD0wFcmL05BCzuvfd5EapVTuje/UMwcIgFb68MAI9kE3IC/ZMbqMjz9OvaOa
    94/ubgY6FAs2G/cGdBd9crZ/L1/YE/vQyuTPJ8fz1WXRoo4IkW8iIcHG1/Xg
X-ME-Proxy: <xmx:aC6PavMcUMQh_O8D0kErL77DSHY43dnYQiFfAgiFCw2yoNw2HTBZow>
    <xmx:aC6PanUO440OnW87gD7GIlR66cH5u3PJYQ7vUUOsd9O_eYT2AsJKOw>
    <xmx:aC6PanxW-PQ_vPuH-udejs-7MLpLPe98tD1f5C53l8rTVIMzEyY8rg>
    <xmx:aC6Pau_8Ojeu4ATTgSDaCzrkpampqIWMjpA59H2YyDZuDNpSU6SvBg>
    <xmx:aS6Pamd56X00T8qAhvDBSXC8xVkUCJET2Z-NJ4ipnlCe9JFWcDXXA4Rk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 14:20:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Cc: git@vger.kernel.org,  Nils Fahldieck <nils@fahldieck.de>,  Patrick
 Steinhardt <ps@pks.im>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Delilah Ashley Wu
 <delilahwu@microsoft.com>,  Derrick Stolee <stolee@gmail.com>,  Ben Knoble
 <ben.knoble@gmail.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/3] config: let sequence require a successful file
In-Reply-To: <20260823-fix-config-list-global-home-and-xdg-v2-2-b29cc63f017b@microsoft.com>
	(Delilah Ashley Wu's message of "Sun, 23 Aug 2026 20:28:27 +1000")
References: <20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
	<20260823-fix-config-list-global-home-and-xdg-v2-2-b29cc63f017b@microsoft.com>
Date: Wed, 26 Aug 2026 11:20:22 -0700
Message-ID: <xmqqy0dsg2vt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Delilah Ashley Wu <delilahwu@linux.microsoft.com> writes:

> From: Delilah Ashley Wu <delilahwu@microsoft.com>
>
> Teach `do_git_config_sequence()` to optionally report an error if no
> configuration files in the sequence were successfully processed. Gate
> this new behaviour with a flag and keep it disabled for now.
>
> Add tests to record existing behaviour and prevent regressions in the
> next patch, "config: read global scope via config_sequence", which adds
> a code path that enables the flag. When no global configuration file
> exists, `git config list` succeeds whereas `git config list --global`
> fails. The command output is irrelevant, so only check the exit code.

It is not exactly 'irrelevant' as that is how the user learns what
caused the command to fail, e.g. "fatal: unable to read config file <path>".

What you meant was that you are not interested in the exact message,
you only want to make sure it fails because of the missing file, and
you thought that it is a good way to do so to check the exit code.

> Signed-off-by: Delilah Ashley Wu <delilahwu@microsoft.com>
> ---
>  config.c          | 57 ++++++++++++++++++++++++++++++++++++++-----------------
>  t/t1300-config.sh | 12 ++++++++++++
>  2 files changed, 52 insertions(+), 17 deletions(-)
>
> diff --git a/config.c b/config.c
> index 1bdd702e7a..4c958f46bf 100644
> --- a/config.c
> +++ b/config.c
> @@ -1544,11 +1544,27 @@ int git_config_system(void)
>  	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
>  }

Perhaps "attempt" -> "try" or something more clever can be used to
make sure we won't have to type so many characters.  "try_config()"
should be decriptive enough for the purpose, for example.

File scope static helper functions do not have to be and should not
be named with so many words.  Shorter names would also help to keep
your lines under ~70 column limit.

> +static void attempt_git_config_from_file_with_options(config_fn_t fn,
> +						      const char *filename,
> +						      void *data,
> +						      enum config_scope scope,
> +						      const struct config_options *opts,
> +						      int *success_count,
> +						      int *cumulative_ret)
> +{
> +	int ret = git_config_from_file_with_options(fn, filename, data,
> +						    scope, opts);
> +	if (!ret)
> +		(*success_count)++;
> +	*cumulative_ret += ret;
> +}
> +
>  static int do_git_config_sequence(const struct config_options *opts,
> -				  const struct repository *repo,
> -				  config_fn_t fn, void *data)
> +				  const struct repository *repo, config_fn_t fn,
> +				  void *data, int require_successful_config)
>  {
>  	int ret = 0;
> +	int success_count = 0;
>  	char *system_config = git_system_config();
>  	char *xdg_config = NULL;
>  	char *user_config = NULL;
> @@ -1574,32 +1590,35 @@ static int do_git_config_sequence(const struct config_options *opts,
>  	if (git_config_system() && system_config &&
>  	    !access_or_die(system_config, R_OK,
>  			   opts->system_gently ? ACCESS_EACCES_OK : 0))
> -		ret += git_config_from_file_with_options(fn, system_config,
> -							 data, CONFIG_SCOPE_SYSTEM,
> -							 NULL);
> +		attempt_git_config_from_file_with_options(fn, system_config, data,
> +							  CONFIG_SCOPE_SYSTEM, NULL,
> +							  &success_count, &ret);
>  

If we are allowed to use system config, system_config is defined,
and we can read the system config, we try to grab values from it,
and record the fact that we did so successfully.

>  	git_global_config_paths(&user_config, &xdg_config);

We grab paths to two files, as before.

>  	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
> -		ret += git_config_from_file_with_options(fn, xdg_config, data,
> -							 CONFIG_SCOPE_GLOBAL, NULL);
> +		attempt_git_config_from_file_with_options(fn, xdg_config,
> +							  data,
> +							  CONFIG_SCOPE_GLOBAL,
> +							  NULL, &success_count, &ret);

If xdg config is to be used (note: GIT_CONFIG_GLOBAL environment can
disable the use of it) and xdg file is available, we read and record
just like we saw is done for the system config above.

>  	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
> -		ret += git_config_from_file_with_options(fn, user_config, data,
> -							 CONFIG_SCOPE_GLOBAL, NULL);
> +		attempt_git_config_from_file_with_options(fn, user_config,
> +							  data,
> +							  CONFIG_SCOPE_GLOBAL,
> +							  NULL, &success_count, &ret);

Ditto fo user config.

>  	if (!opts->ignore_repo && repo_config &&
>  	    !access_or_die(repo_config, R_OK, 0))
> -		ret += git_config_from_file_with_options(fn, repo_config, data,
> -							 CONFIG_SCOPE_LOCAL, NULL);
> +		attempt_git_config_from_file_with_options(fn, repo_config, data,
> +							  CONFIG_SCOPE_LOCAL, NULL, &success_count, &ret);

And the local one.

>  	if (!opts->ignore_worktree && worktree_config &&
>  	    repo && repo->repository_format_worktree_config &&
> -	    !access_or_die(worktree_config, R_OK, 0)) {
> -			ret += git_config_from_file_with_options(fn, worktree_config, data,
> -								 CONFIG_SCOPE_WORKTREE,
> -								 NULL);
> -	}
> +	    !access_or_die(worktree_config, R_OK, 0))
> +		attempt_git_config_from_file_with_options(fn, worktree_config, data,
> +							  CONFIG_SCOPE_WORKTREE,
> +							  NULL, &success_count, &ret);

And the per-worktree one.

>  	if (!opts->ignore_cmdline && git_config_from_parameters(fn, data) < 0)
>  		die(_("unable to parse command-line config"));
> @@ -1609,6 +1628,10 @@ static int do_git_config_sequence(const struct config_options *opts,
>  	free(user_config);
>  	free(repo_config);
>  	free(worktree_config);
> +
> +	if (require_successful_config && !success_count && !ret)
> +		ret = -1;

If we are asked to ensure that we successfully read at least one
place and we didn't, we assign -1 to ret but we do so ONLY when we
haven't seen any other errors (i.e., existing non-zero ret is
preserved, which may not be -1).  OK.

>  	return ret;
>  }

I am not convinced 100% that we need "success_count", either, until
we see how it is used in the later steps.  But from the way the
try_config() thing is used, I find it dubious that it now returns
void.  It should just keep returning the error code as before, and
the caller should just keep accumulcating as the original code used
to.  I.e.,

		ret += try_config(fn, frotz_config, data,
				  CONFIG_SCOPE_FROTZ, NULL,
                                  &success);
