Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D128447252F
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787767163; cv=none; b=tobIX9y7dz6Xs0VAOoSEikwKoMCMb6pYD71k0nZ93sCN8byPJBiFuM5Mst9HJjBLDZEiR5SHGVpdx9mq6cOv45Hn5zDZDYMB9fWdTSQWMpTNnkBzgL5ZJtMTAzHJzxRY19dX8X1+jswfZAuDeg6DYWQwJ2fIolH93/JCVv0rv/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787767163; c=relaxed/simple;
	bh=FzpQbewuF/S5ldIpLXTRrvoAOZpdtjAOV2wYZQm6jok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SdImvxMWhcm/Ipz5Q0BEdl3Rbz8tzrjs3/ZbU5HC3G/UuElkNA7iW3O7oJ10AUCeiFWiM0VFB1GjZSYEuyYJYR2UrN8UW7M+j5LGnObBmwkhZ8Cd/q3wrZc7ukT7zHeogfiuhTlJDk6n+1/Nf5d/J6y2jmGolaIdnvj96Fv8MeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lYIJD/Y2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jY6R5Nik; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lYIJD/Y2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jY6R5Nik"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A73C1D000A6;
	Wed, 26 Aug 2026 13:59:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 26 Aug 2026 13:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787767140; x=1787853540; bh=wBPMxG9FeT
	MngBAVXKjklxyRxOoSAiHLX+dZCob5Osg=; b=lYIJD/Y2yCdL7NvgyCb2DlYpBw
	fCpXw1ETVQr0BM0Vfj9RPrr45VlOtxDlJZ+RYAGvWcTYKGAQbQc+7OT8r2O+9apg
	aev9Cs0sX32nvQ3MpxB/SN23VkVFoWg8u3hloYFNpBRBIGXNaX/Rf/NxLqGedAA1
	Gfl+DAkDyGYWaaJKTmzlgucbzKMCyWzDn+YpjdpxaMTycwvk5dPM2+Qg6/l+F1g0
	T6yFCpvNUWOzA6JX8nWF+hVcJ2hfwkO3bmg9vtI+x8eh8sFJevTNSHg+p87axH3l
	7uQXMEZ4+4qkkCPFlSC9jsuKOpwdFeAoIngNg5HZnqrBanWu0aGkxHxwqYyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787767140; x=1787853540; bh=wBPMxG9FeTMngBAVXKjklxyRxOoSAiHLX+d
	ZCob5Osg=; b=jY6R5NikAGUNg1SOGemPx0Tih98MgBy/FJESGpT/8fuunlFi8Sm
	Wn4Ys2xPPOr4GHA/yfWxiWn4cs6SmiBw/6fjDBwBUh7S7RRWz+zyO7ZuNPmiuTiX
	FTcYKLdDX/1bwYsTskZnH8MZAJtWGLekcieSGknJv0sgdcRLuefdouam9ry4vN2G
	eryQqcJIBBcy5Nwwv02U4sn13ktbisK0+Cf2Jl3MSVCJuchzoGLonAbAmDl6NUtW
	3a1lSSDlMNTGZFpalkLo9IM0ZDDv2465L15YcoQinlOXScg40r4/uVTWrgMTZyjS
	GyRd+nA8m88NsTmYHbs/zd3s8XgB9JnAzWA==
X-ME-Sender: <xms:YymPar_ICr62IkUIILfJXteEOlc2wUVaBzzh9KBw9GUygnzoGmEx8g>
    <xme:YymPaqwUfH2WfKXtwnBTNQ95Wi9ZL4Ndrt6G5I-0b840hmEcsVPT7AUKIPdjHYeMo
    hyoOj9YFlhyt9P1-5vBrSz4RtdUGsye5YrnAWIkAGb1Lpt2oD_pGA>
X-ME-Received: <xmr:YymPajotFXunRk4O7UOe2qUGJfPG5YHLTG15ZNfnVt91dYwJLwblvmMSXEvbX4HG06OFNsPk9oOhLZ3nGFjeenOfz_AZR9f0-g>
X-ME-Proxy-Cause: dmFkZTGeEah9arzAFV/VcI8DP4BKbPhjcVlRuyFmwlH/ffh2FjkNaEOywuO+/M9xyQjUVV
    cC9X5LYwACC7UmiA5AJtBXbh1sUP7mMXi472iorLwadHO4l9c33oWet+AsYsIz6/mj7+v7
    ul8j2x9+4fs0Am/qezLPhKZ+7FyimkQ6aqVJyhp7PtGeK+/adbx+IOL85Zt8w1iP3KzDr3
    PhCyRww6k4flclG7sdhbAS6jBA6t27aFV1FP+Y6G6VXgn0B5RTQaEwr/SNoDO7Ay0NyLPg
    9ybi+gPSJ5DWNglRXlPeX8waBm/LATfleSC8OQK8VDZ0V0eXA7xaebSipCw1UMqH4G7HkI
    Y9S3EPcn3NxfeRA3DlmxSaMZzzBz0MoSPYeOp0E7xCExekg8bNlR63yHV8i4+b+L9Gx2Rv
    3WSIiVk2yzbAue4SSeLj+4L3q4vciMPC4SmcHxIL1w4XmjEl+yDRdISuAZZPWf1mTb1vKr
    HciYMnax9+S9nC/Jqctq82HvPbqq2BTphVxEVBfhxedZj5LDN+MH62Lrvt4aKfcQZDFxWK
    JCJC5ViooBfscqIIbEM8d3gK8Cs2Yr8VjsQ7KWyGTcf2l/HwRTgI/1uw6N/F6axAhX52c/
    yepjd8cKonn5pXYBQxOM21yJyBL+qNcER58pTAu/wB/GI4GV5ZlvJfxCFMjw
X-ME-Proxy: <xmx:YymPajrVIEWFWQKFOWkif4yJ5aGUGyZjUMNTswCxVXpRu_B9rG2-lQ>
    <xmx:YymParBOxV9Ye4mkR8Q-84_qBL8XitewJ8yBlAuKMGYf50zZ3QTZXA>
    <xmx:YymPapuxZvjQO1cZ9JTOHUSCyNB_Y3UCofkoGL-aUN-B8e9Mr0DOaw>
    <xmx:YymPaiKjqbWFc5c0ul6ChKqgALnYiFZZ6VcLR9sgNV15LzuNmF1WIQ>
    <xmx:ZCmPaklsACwcfU1fbkWltnXzgMxr2RJRYIMtGY2aPc7VnQEaJYEmRZRU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 13:58:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Cc: git@vger.kernel.org,  Nils Fahldieck <nils@fahldieck.de>,  Patrick
 Steinhardt <ps@pks.im>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Delilah Ashley Wu
 <delilahwu@microsoft.com>,  Derrick Stolee <stolee@gmail.com>,  Ben Knoble
 <ben.knoble@gmail.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] path: use forward slashes in XDG config on Windows
In-Reply-To: <20260823-fix-config-list-global-home-and-xdg-v2-1-b29cc63f017b@microsoft.com>
	(Delilah Ashley Wu's message of "Sun, 23 Aug 2026 20:28:26 +1000")
References: <20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
	<20260823-fix-config-list-global-home-and-xdg-v2-1-b29cc63f017b@microsoft.com>
Date: Wed, 26 Aug 2026 10:58:57 -0700
Message-ID: <xmqqecfkhify.fsf@gitster.g>
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
> Git prefers forward slashes as directory separators across all
> platforms. On Windows, the backslash is the native directory separator,
> but all Windows versions supported by Git also accept the forward slash
> in all but rare circumstances. Our tests expect forward slashes. Git
> displays relative paths with forward slashes. Forward slashes are more
> convenient to use in shell scripts.
>
> For these reasons, we enforced forward slashes in `interpolate_path()`
> in 5ca6b7bb47b (config --show-origin: report paths with forward slashes,
> 2016-03-23). However, other code paths may construct paths containing
> backslashes. For example, `config --show-origin` prints the XDG config
> path with mixed slashes on Windows:
>
>     $ git config --list --show-origin
>     file:C:/Program Files/Git/etc/gitconfig         system.foo=bar
>     file:"C:\\Users\\delilah/.config/git/config"    xdg.foo=bar
>     file:C:/Users/delilah/.gitconfig                home.foo=bar
>     file:.git/config                                local.foo=bar
>
> These mixed slashes occur because the `$HOME` and `$XDG_CONFIG_HOME`
> environment variables usually contain backslashes on Windows, and
> `xdg_config_home_for()` interpolates them into templates that use
> hardcoded forward slashes.
>
> Since callers of `xdg_config_home_for()` handle mixed slashes correctly,
> it is reasonable to assume that they can handle paths with only forward
> slashes. Let's enforce forward slashes in `xdg_config_home_for()` by
> using `convert_slashes()` on Windows.
>
> Also, there are no tests for the XDG path with `--show-origin`. Add a
> test for slash conversion and a confidence check for the default path.

Is this "force forwared slashes to Windows users" a required part of
XDG/HOME global fix?  If not, please leave it out of the topic.

Even if it is a good idea to always force forward slashes to Windows
users (I have no strong opinions on the topic), and if it is very
unlikely to break existing Windows users (I do not have any clue if
that would be the case or not, as I do not do Windows), we would
want to make sure if we can get the same effect without sprinkling
"#ifdef" in the platform agnostic part of the codebase like "path.c"
file.

Where would the slash in "ret" that is passed to convert_slashes()
function come from?  If they come from environment variables like
XDG_CONFIG_HOME and HOME, that is end-user's preference and we have
no business forcing them which forms of slashes to use.  Does it
come from "subdir" or "filename" parameters?  It might be the job
for the callers to standardize slashes in the value they send in,
but as far as I can see, these do not have anything other than
hardcoded constants that use no slashes (most of them) or one
forward slash ("systemd/user").

Again, I do not see it explained why this change has to be part of
this series in the proposed log message, so...?

> Signed-off-by: Delilah Ashley Wu <delilahwu@microsoft.com>
> ---
>  path.c            | 16 ++++++++++------
>  t/t1300-config.sh | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 6 deletions(-)
>
> diff --git a/path.c b/path.c
> index c3a709a928..f17595fd1b 100644
> --- a/path.c
> +++ b/path.c
> @@ -1544,19 +1544,23 @@ int looks_like_command_line_option(const char *str)
>  
>  char *xdg_config_home_for(const char *subdir, const char *filename)
>  {
> +	char *ret;
>  	const char *home, *config_home;
>  
>  	assert(subdir);
>  	assert(filename);
>  	config_home = getenv("XDG_CONFIG_HOME");
>  	if (config_home && *config_home)
> -		return mkpathdup("%s/%s/%s", config_home, subdir, filename);
> -
> -	home = getenv("HOME");
> -	if (home)
> -		return mkpathdup("%s/.config/%s/%s", home, subdir, filename);
> +		ret = mkpathdup("%s/%s/%s", config_home, subdir, filename);
> +	else if ((home = getenv("HOME")))
> +		ret = mkpathdup("%s/.config/%s/%s", home, subdir, filename);
> +	else
> +		return NULL;
>  
> -	return NULL;
> +#ifdef GIT_WINDOWS_NATIVE
> +	convert_slashes(ret);
> +#endif
> +	return ret;
>  }
>  
>  char *xdg_config_home(const char *filename)
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index e3f8064889..329407a73d 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -2350,6 +2350,38 @@ test_expect_success '--show-origin with --default' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'set up xdg config --show-origin tests' '
> +	mkdir -p "$HOME"/.config/git &&
> +	cat >"$HOME"/.config/git/config <<-EOF
> +	[xdg]
> +		config = true
> +	EOF
> +'
> +
> +test_expect_success MINGW '--show-origin converts backslashes in xdg path to forward slashes on Windows' '
> +	backslash_home="$(echo "$HOME" | tr / \\\\)" &&
> +	echo "file:$HOME/.config/git/config	true" >expect &&
> +
> +	(
> +		sane_unset XDG_CONFIG_HOME &&
> +		HOME="$backslash_home" git config ${mode_get} --show-origin xdg.config >actual
> +	) &&
> +	test_cmp expect actual &&
> +
> +	XDG_CONFIG_HOME="$backslash_home\\.config" git config ${mode_get} --show-origin xdg.config >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--show-origin with default xdg path' '
> +	echo "file:$HOME/.config/git/config	true" >expect &&
> +	git config ${mode_get} --show-origin xdg.config >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'clean up xdg config --show-origin tests' '
> +	rm -rf "$HOME"/.config/git
> +'
> +
>  test_expect_success '--show-scope with --list' '
>  	cat >expect <<-EOF &&
>  	global	user.global=true
