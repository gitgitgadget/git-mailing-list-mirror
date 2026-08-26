Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC34483B4
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769504; cv=none; b=NjvBix8pwhnUrxpmJCbWXEAv4C5v7NoMvXaHD0OEi4YsNONTjb/beHP5zQde1yHSmcAyCZnil8yJlv9rnEYlYGW0k13KkMztbSgMS2rErl1ViOVzLAaJ4KGs9xa7ArydG1bJUsGUntB3dSsph0DWr7imN2WBwH1TqEiVfUpVpzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769504; c=relaxed/simple;
	bh=E8TAdNcxL4N8EyfokNHTPJ3hmUBXSapNT5whRqonXqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RJF9paS5yQ5hnJlT/BUgWzrqJyCi+vSfj2w5N75bpIfvo9wJ1SnUXz8HBQDZU5mfu8vgTs2wX4Cf3Xx50kgIKFlUfLNcioLSw7sO9atK6fxgdUSKl9sKp7CRY9sWgC+iCU9oUITCjSEwizsXuGqYxfDjTycUgz6QlEj2pZWyqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G0GYl1Qk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=amagmmDh; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G0GYl1Qk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="amagmmDh"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D3A3E1D000DD;
	Wed, 26 Aug 2026 14:38:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 26 Aug 2026 14:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787769484; x=1787855884; bh=ErsPMdn4eK
	gZqXHGOiKg9mY+YetOqCpZ7JNrDj9nf8o=; b=G0GYl1QkNTQR9t+hRnj4DQQe6R
	DMkcBb6tlLndj8XKfxANfMuNeIw0qVtz6iczDPZEzn2c+pEpc6p8MLIFzi/zUN3T
	G4nVmuWaz5ElzQsph7DeJdBCNN0ELoZdAF9Ps9W0A428jizmhlMT72lQ79utm6HU
	0Z28EH/lGpPnhyXCB9I9Ks+F+u/1ARdsMFfla7vdSHvavXmlSM9x/aYWC+cBuqwh
	UphTgaumMa7WNQXbQLkbuxkJEDAIs2Ih68wRDAu8bjatrbkwYO48Mqo3uJZ4xZmf
	1qvKJMGMxtok9Cje4b4GDeH0tUG39i0pYCsNhDDQ1x+bSBzR7t8Bn4Efv1wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787769484; x=1787855884; bh=ErsPMdn4eKgZqXHGOiKg9mY+YetOqCpZ7JN
	rDj9nf8o=; b=amagmmDh5edxhJAnFYhG8YC/iX4cwZUfWuk1KpCdcX0i3k+9TbB
	A4cdHOgN6tgSgbbgrmMXMfXevy+BlyXOV1iCjQQzJvVMqKH/c0DGskE2hchzGRSV
	kYku1gCIgcYubV3oX99GQy69VU20vO0vPf//eYB9Ph/ss79lYOkrrcajsUIQYOIR
	YpW7CqP/SeOGMsSYmeOn19R6TRGMK68v8Eq87IgsQWxJvWhreUreYFHS/Ne52Wr/
	K7WH32wRuMMp+/BeVmq/8RgEkP85hzVky6UhBVt2iMYB+49gfR5SV5xnmIb7UhTH
	DqFDf1eLNbwFh5pThsXCxsyFweu/f5ylq8A==
X-ME-Sender: <xms:jDKPakVk8yFvonFu-SndA4jLSG1qiYV2FfVBYLNAk7uSjDZn2Vmf6w>
    <xme:jDKPaqLsAZmYwOlsSCYMYY9l6mRyL_Rgf7LelxuNg_V5FyKtoN7D32v3FuK4bSAQf
    hbHjVCwjII1Ne_I4PsR673RO0Z9NxaTgD5BaqWf7VdYeinGV3DS>
X-ME-Received: <xmr:jDKPanrjTcglmIH_92CWh0TJg2gxN5ob4WEJw7piP9FIBRzzIm6yd3XThOrDzOirdoSLZCV6-izxIAyypEg4PDG7308PUZOpfw>
X-ME-Proxy-Cause: dmFkZTF07htFMKCYSvDRIpAnYhDnLYpZttSz9xKvCnhBbUqKh1GrI00pG+jo0V4+9K5xvt
    MVglVTdGR02qg8YW9Bykuxj8kwYkyX1h6W2JIymh1E7JszVLZq4oGXhjZcSnFqwJcb9Rin
    LgvCXE0oVIHrp9ib2/9YmZ2l+T/A/NDDn1IFjEUBKiBoowx7/OUbk6eDbR4bkwEEfu8v7H
    lAS+ElIoOaR41T8g00ercWwuBloqFLDBVH9jcX2255RvoxfDm+Zyeb+4NsUtGJ7ziyIb41
    lO/vgotoLZ3JImu++o/fdmTJ7Qy+2xotNgCL3740KtGHcmYdAQ4Hbddrp/+LqKiBQFveQM
    vLrRuo3olkjUwDp0rmAjdbIuBdzKrPU6iH30B5wh7oQr9TtNs+ICiz8FAqW3C9su96xZNB
    2FkOtGeT0nrwGD9NLaFxBcjODoergdvWZeHpsrKV1iGFoTw4GZCVD8EQXSl28DNYJTcUgy
    segq2myM2fjfOuib0sIvtmXsJVB3KRKXmJdffUVsxCtUuCtWLj21Gyb9X2VtoP9XWmHlKd
    x6LypoiHkEqUVXqjBFbJLhOUTTH0vNvnyAxgbzRghI9eAw/nt2tebWTC2kR8Ij6cuZZeGH
    EUneSeNXujjy8hb2+UwaV+I2i6KRFZJqsFfgoG3BnLzriiyWCKlsb09bQ9mw
X-ME-Proxy: <xmx:jDKPapxIAO9iHQh1H9HKgM2XIIOBuAKYN45XNniYtT5ddB1Fk3YoDw>
    <xmx:jDKPajsgxAV276291IZ87lI2AZE760FumvS6tMdWj8mnFmXyMwYOiQ>
    <xmx:jDKPaq05Rdxx1mCgBZOvJ3g91oopxeokcfFDNtQ0A3lWV30WgDBQqQ>
    <xmx:jDKPajAet6k3FmDn-c1QMeXVrmpelcJITzWiVXG4l_FB72BJvpRyzA>
    <xmx:jDKPalTkqwwS1EvAsfmiGuNN-5E0rJpNZZk02SzSK2BjX3fTbhAC1lFz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 14:38:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Cc: git@vger.kernel.org,  Nils Fahldieck <nils@fahldieck.de>,  Patrick
 Steinhardt <ps@pks.im>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Delilah Ashley Wu
 <delilahwu@microsoft.com>,  Derrick Stolee <stolee@gmail.com>,  Ben Knoble
 <ben.knoble@gmail.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jade Lovelace <lists@jade.fyi>,  Glen Choo <glencbz@gmail.com>
Subject: Re: [PATCH v2 3/3] config: read global scope via config_sequence
In-Reply-To: <20260823-fix-config-list-global-home-and-xdg-v2-3-b29cc63f017b@microsoft.com>
	(Delilah Ashley Wu's message of "Sun, 23 Aug 2026 20:28:28 +1000")
References: <20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
	<20260823-fix-config-list-global-home-and-xdg-v2-3-b29cc63f017b@microsoft.com>
Date: Wed, 26 Aug 2026 11:38:03 -0700
Message-ID: <xmqqse40g22c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Delilah Ashley Wu <delilahwu@linux.microsoft.com> writes:

>  	if (opts->use_global_config) {
> +		/*
> +		 * Since global config is sourced from more than one location,
> +		 * read it using `do_git_config_sequence()` with other scopes
> +		 * ignored. However, writing global config should point to a
> +		 * single destination, set in `opts->source.file`.
> +		 */
> +		opts->options.ignore_repo = 1;
> +		opts->options.ignore_cmdline = 1;
> +		opts->options.ignore_worktree = 1;
> +		opts->options.ignore_system = 1;

We used to use ignore_repo, ignore_worktree, and ignore_cmdline
members in the config_options, but to ignore system configuration,
we relied on git_config_system() that checks GIT_CONFIG_NOSYSTEM
environment variable, and there was no way to ignore per-user
configuration.  From that point of view, I find it sensible to make
config_options the primary way to configure which parts of the
configuration sequence is disabled.

But then we should go one step further, shouldn't we?  Either teach
git_config_system() to take config_options struct and pay attention
to .ignore_system member in it, or get rid of git_config_system()
and have the current users of that function take config_options and
pay attention to its .ignore_system member, so that we do not have
to write an ugly conditional like this one:

> -	if (git_config_system() && system_config &&
> +	if (!opts->ignore_system && git_config_system() && system_config &&


> +	if (!opts->ignore_global) {

It is a bit misleading that this conditional is always taken.  No
caller will tell this function to skip the per-user configuration.

> +		git_global_config_paths(&user_config, &xdg_config);
> +		if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
> +			attempt_git_config_from_file_with_options(fn, xdg_config,
> +								  data,
> +								  CONFIG_SCOPE_GLOBAL,
> +								  NULL, &success_count, &ret);
> +		if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
> +			attempt_git_config_from_file_with_options(fn, user_config,
> +								  data,
> +								  CONFIG_SCOPE_GLOBAL,
> +								  NULL, &success_count, &ret);
> +
> +		free(xdg_config);
> +		free(user_config);
> +	}

> @@ -1624,8 +1629,6 @@ static int do_git_config_sequence(const struct config_options *opts,
>  		die(_("unable to parse command-line config"));
>  
>  	free(system_config);
> -	free(xdg_config);
> -	free(user_config);
>  	free(repo_config);
>  	free(worktree_config);
>  
> @@ -1659,7 +1662,8 @@ int config_with_options(config_fn_t fn, void *data,
>  	 */
>  	if (config_source && config_source->use_stdin) {
>  		ret = git_config_from_stdin(fn, data, config_source->scope);
> -	} else if (config_source && config_source->file) {
> +	} else if (config_source && config_source->file &&
> +		   config_source->scope != CONFIG_SCOPE_GLOBAL) {
>  		ret = git_config_from_file_with_options(fn, config_source->file,
>  							data, config_source->scope,
>  							NULL);
> @@ -1667,7 +1671,8 @@ int config_with_options(config_fn_t fn, void *data,
>  		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
>  					       data, config_source->scope);
>  	} else {
> -		ret = do_git_config_sequence(opts, repo, fn, data, 0);
> +		ret = do_git_config_sequence(opts, repo, fn, data,
> +					     config_source && config_source->scope == CONFIG_SCOPE_GLOBAL);
>  	}

+100 column wide columns?  Please don't.

This sequence is a bit hard to read.  Instead of piggybacking on the
existing call to do the READL sequencing, add a new "else if" clause
to deal specifically with the global case to the cascade would make
the result easier to follow, I suspect.  Something like this fix-up
on top of this patch, perhaps.

 config.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git c/config.c w/config.c
index acad89102d..bf77f847c3 100644
--- c/config.c
+++ w/config.c
@@ -1663,7 +1663,9 @@ int config_with_options(config_fn_t fn, void *data,
 	if (config_source && config_source->use_stdin) {
 		ret = git_config_from_stdin(fn, data, config_source->scope);
 	} else if (config_source && config_source->file &&
-		   config_source->scope != CONFIG_SCOPE_GLOBAL) {
+		   config_source->scope == CONFIG_SCOPE_GLOBAL) {
+		ret = do_git_config_sequence(opts, repo, fn, data, 1);
+	} else if (config_source && config_source->file) {
 		ret = git_config_from_file_with_options(fn, config_source->file,
 							data, config_source->scope,
 							NULL);
@@ -1671,8 +1673,7 @@ int config_with_options(config_fn_t fn, void *data,
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
 					       data, config_source->scope);
 	} else {
-		ret = do_git_config_sequence(opts, repo, fn, data,
-					     config_source && config_source->scope == CONFIG_SCOPE_GLOBAL);
+		ret = do_git_config_sequence(opts, repo, fn, data, 0);
 	}
 
 	if (inc.remote_urls) {
