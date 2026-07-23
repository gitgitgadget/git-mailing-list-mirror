Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD7B388873
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825262; cv=none; b=lNX2/3zc2AcwHAc0bV2rnX3wBHngw84OJcodA70eGx+8cMJP/MhSuGk4nsMpi6VC2I/Et/ek+JxW0lr058Krownc7bRUi2CMDcOLQ7XqXcyhBC+6LBU5YadqwNyrvqkgciExRgozE03Ywrowqdf7lJsRCyTIVR6PNvU9ZJGWeAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825262; c=relaxed/simple;
	bh=bgdxDcwNTCvVKNISeimV2ZhSj4IjC5wpJtvrg55DpTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PVkiJl8vCIbJ/kw4otVOPnOZwEi+Z9Yti/s4XxInKCGwZRONfu3e1vVmghej/PNA/7Gbi9YTxIFi5lefCOuKGUfabsBFdEw0Q9NZcx1jjUHuHd3ZZlEbx9inIXf6SvrZWODQLF7B52Ki9p0mRipEf56yD0JDGYR/s8YR9faBFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=svIF3WBT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y4aabLrt; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="svIF3WBT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y4aabLrt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 571A31D0011E;
	Thu, 23 Jul 2026 12:47:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 23 Jul 2026 12:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784825259; x=1784911659; bh=DtbKeu3y0Y
	RTQa1rmPS+lwQkRosKKR4wUAulz3eIMfI=; b=svIF3WBTVEKsUe04zKB1s5J2Wx
	UDYtrg0ux40WCJGcO87NWksCsfjkhjpRN6ejA8rKNcAEk79w79mD0YR3c5JjHgEd
	CBbyz07Luv9UUmuA/QhQ1h+QiiBJldnxDGHk3KrOCggkmgS2cOuGDqfQZMOXIrT6
	//4yocf5crv48HEGp5xw0Kp7520J96fZWu3oaagqRqtYhksXBToLSW6OolO9onNa
	URGTnP7mo+57ELbuM/wm0OmaWYDZqeyPOzv6YVv1I67tPNr4BMa0cyV5Hs3/lrLT
	7DaZ1Cg5oXIvdvS+JE2BfZ2nE4cb7l1C3X/Okxer13RFsoZ4mfTqitQTj1ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784825259; x=1784911659; bh=DtbKeu3y0YRTQa1rmPS+lwQkRosKKR4wUAu
	lz3eIMfI=; b=Y4aabLrtbg0gH2C9uk7oGxDysb4lhH/eVowc5FfRKtVbIzyfLtL
	W90d3mZ2Ljx5Th0qY4IBkpV2I42w2f0zVsmEh0CjTH66/ZyRbZ5p9g30hTZkSNh0
	hEFhmvEDOremLlasLNuYWbloPgiilxzzYQbfMkYzhoZmkdImKeerisjuGFcxxDmq
	wBqB/PhLzD4VWL6fvhz039ogUMO12FchGrQR792HgkKZ8niRvfYM7qTvAaP8Ik4p
	HocCp+rDASfnd8+wwKIYBquUOJcAvuV2dNlM/PffohXZg5htVW1RHwXXpUZWKctb
	9Nxak/fWCJuT97luKNEQoPuHwOuyi/kw4Ow==
X-ME-Sender: <xms:q0ViatXhJoZlWcfwbpk_cqvJjMB8fZySIiK50SCw-YUO1rS4PezIfA>
    <xme:q0ViaklG_lbBUglLj74vzgmVykCIduCo2KfeyfCiBjt-GbmG3-lxDLjOTRdF0cSjU
    ShlQz_IQoQaHgKueTrB4Zm_NAVTaNFw6l4m92Xd_DyTDIyw9NfoDLs>
X-ME-Received: <xmr:q0ViauaQnwQMBzJrcZDPiXH4GISw81giNaPq_LQMSAhjZsxYXchZdjwoB129rKFoMp95Wi8XwGFkQ8KAK21s5Jj2H1KOo6c3tA>
X-ME-Proxy-Cause: dmFkZTEfRXRiQc0d2p1YaIQaMbwtxIS5jkuMkl0KEoD7/wpnXbs+jD8jF3uRdZ4wg2YAPX
    AeLYr6IxGZcg7wURzFnawfAjTuHKcTCD/CHPXHWi8+fY4ZFeKhJqyLK8gfaqDjI8Wimj5P
    wei4gYuSw8l5/LBdJRlAJ34xirerLC+Zjaqy38DGWP3U0eERPqmh4VgL8WxctJ50MPwDcc
    wLrCnt4kD21M1vL/lCMaokRONnQoJbG4WMpBp2r29GyHRLLjsSC3Jt9eLFLof7GooYxh7P
    j/g+F8ubcyssl/fzLtIdSYBzoATZrV/YjhjpajTsFGVigLizmDPX3ucC4vkaWeM5NfSfr0
    mudSypOyFLzpsbzjUN7bpuCaE6crbApjD36ZGZFOoQ1AiM8wKTkJEsQgE/KBhr90RPuX4b
    T93+6vMCT39Rc0CJ7DGu0l5x9Ik8hzrnqScysDX4hs+uMGyvhal4r7v1xfSt9c4Z7GpKsd
    CKoVPQXbekREXx1lMaB9QViIbba4gxQsQC7dKQf9XRGyxEL2xnGJhKTe/jTocnndVW6s10
    aptpZivsscaMKxQVxpvVpaYw00I6rGG+XNG5fJDngaWiE4zrtrqvqXelYyJKTUcKrE94S1
    q/4ZooR3j6r8Wdpm2JVzC0nXZkM6C0wp8xgPD2BAA+3AOspyckQ+aFYkaeLw
X-ME-Proxy: <xmx:q0ViavNjRzXphzQQqV8i9aiXvLJrByQBLUG2jR42IFqXvP7kNaSiOg>
    <xmx:q0ViajYWd17LEvpADICpRM33WU1bd7OR7Ncfsgu5rPPEGQ9jyvz2DQ>
    <xmx:q0Viat1GB9PFrTBY2V2SYd5Isi0y4g85p1dde8G1VW-UuUIo-vykRA>
    <xmx:q0ViapfNauULmgDcoR-OVYr5MQd05bHMxp9QfNPSy33iZ5IhuCUlvA>
    <xmx:q0VianIZJBYAWZDyDSsT6_hvpYOtSYYVsP-EG8hJeTC2vJ6QSAyOjdl->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 12:47:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "GalaxySnail via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  GalaxySnail <me@glxys.nl>
Subject: Re: [PATCH] http: add a config to limit the connection time
In-Reply-To: <pull.2362.git.git.1784798733557.gitgitgadget@gmail.com>
	(GalaxySnail via GitGitGadget's message of "Thu, 23 Jul 2026 09:25:33
	+0000")
References: <pull.2362.git.git.1784798733557.gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 09:47:36 -0700
Message-ID: <xmqqqzktk5zr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"GalaxySnail via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: GalaxySnail <me@glxys.nl>
>
> By default, libcurl uses a 300 seconds timeout for the connection phase,
> which is too long for some use cases.

Can you elaborate a bit more on the use cases in which you want to
try connecting to an unreachable host yet want to give up on it very
fast?

> Add http.connecttimeoutms and GIT_HTTP_CONNECT_TIMEOUT_MS to specify
> timeout in milliseconds for the connection phase. Both of them call
> CURLOPT_CONNECTTIMEOUT_MS internally.
>
> Signed-off-by: GalaxySnail <me@glxys.nl>

Documentation/SubmittingPatches:[[real-name]] applies here.

>  Documentation/config/http.adoc  |  7 ++++
>  http.c                          | 11 ++++++
>  t/meson.build                   |  1 +
>  t/t5585-http-connect-timeout.sh | 60 +++++++++++++++++++++++++++++++++
>  4 files changed, 79 insertions(+)
>  create mode 100755 t/t5585-http-connect-timeout.sh
>
> diff --git a/Documentation/config/http.adoc b/Documentation/config/http.adoc
> index 792a71b413..a4f7afa61e 100644
> --- a/Documentation/config/http.adoc
> +++ b/Documentation/config/http.adoc
> @@ -300,6 +300,13 @@ for most push problems, but can increase memory consumption
>  significantly since the entire buffer is allocated even for small
>  pushes.
>  
> +http.connectTimeoutMS::
> +	Maximum time in milliseconds that you allow the connection phase
> +	to take. The connection phase includes DNS lookup and subsequent
> +	TCP, TLS or QUIC handshakes.
> +	Can be overridden by the `GIT_HTTP_CONNECT_TIMEOUT_MS`
> +	environment variable.

Once a knob is provided, users will want to know what value is
used when unspecified, so they can gauge what a reasonable value to
set would be.

> diff --git a/http.c b/http.c
> index caccf2108e..befe9ea8a0 100644
> --- a/http.c
> +++ b/http.c
> @@ -68,6 +68,7 @@ static char *ssl_capath;
>  static char *curl_no_proxy;
>  static char *ssl_pinnedkey;
>  static char *ssl_cainfo;
> +static long curl_connect_timeout_ms = -1;
>  static long curl_low_speed_limit = -1;
>  static long curl_low_speed_time = -1;
>  static int curl_ftp_no_epsv;
> @@ -450,6 +451,10 @@ static int http_options(const char *var, const char *value,
>  		max_requests = git_config_int(var, value, ctx->kvi);
>  		return 0;
>  	}
> +	if (!strcmp("http.connecttimeoutms", var)) {
> +		curl_connect_timeout_ms = git_config_int(var, value, ctx->kvi);
> +		return 0;
> +	}

We could set it to -1 if we wanted to, and behave as if no
configuration variable were given.  That may be reasonable, but it
should be documented.

> @@ -1215,6 +1220,10 @@ static CURL *get_curl_handle(void)
>  			curl_easy_setopt(result, CURLOPT_PROXY_CAINFO, http_proxy_ssl_ca_info);
>  	}
>  
> +	if (curl_connect_timeout_ms > 0)
> +		curl_easy_setopt(result, CURLOPT_CONNECTTIMEOUT_MS,
> +				 curl_connect_timeout_ms);

This code silently ignores setting the configuration variable to 0.
To the cURL library, however, passing a value of 0 to
CURLOPT_CONNECTTIMEOUT_MS signals that it should use the default
value (300s).

Perhaps we should tweak the above to

	if (0 <= curlopt_connecttimeout_ms)
		curl_easy_setopt(result, CURLOPT_CONNECTTIMEOUT_MS,
				 curl_connect_timeout_ms);

and then document what 0 means.

> @@ -1474,6 +1483,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  
>  	set_from_env(&user_agent, "GIT_HTTP_USER_AGENT");
>  
> +	set_long_from_env(&curl_connect_timeout_ms, "GIT_HTTP_CONNECT_TIMEOUT_MS");
> +
>  	set_long_from_env(&curl_low_speed_limit, "GIT_HTTP_LOW_SPEED_LIMIT");
>  	set_long_from_env(&curl_low_speed_time, "GIT_HTTP_LOW_SPEED_TIME");

This, along with other environment variables, is processed after
repo_config() collects configured values by triggering the
http_options() callback, so the environment overrides the configured
value, as expected.

> diff --git a/t/t5585-http-connect-timeout.sh b/t/t5585-http-connect-timeout.sh
> new file mode 100755
> index 0000000000..7363e23bfe
> --- /dev/null
> +++ b/t/t5585-http-connect-timeout.sh
> @@ -0,0 +1,60 @@
> +#!/bin/sh
> +
> +test_description='test http.connecttimeoutms and GIT_HTTP_CONNECT_TIMEOUT_MS'
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +start_httpd

What are we testing with this new script, really?

As far as I can see, nobody is sitting next to the running test
with a stopwatch to ensure that the client times out as specified.  Should
we really consume a limited shared resource, the four-digit test
number, for this instead of adding a few "not a number (should fail
to parse)" tests to existing http tests?

Thanks.
