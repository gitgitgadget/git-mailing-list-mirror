Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16318E10
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677485; cv=none; b=e08KZhYjZnVRfEp7E7EE7wKTE6dfqHPcIWA9ge6TrqdaFZqimN6xPrcBWXjAiSLzfD0YQfauemGzOU3OavTf6NjfEUMf/yBcxiiTEHiAQq/RufdvqDc/KneKLpegOLH2MO853SCppOHIASID+hd/28jSqC0+/rs1bUu7zX0wXXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677485; c=relaxed/simple;
	bh=pWpPD2RRGdOMWLZiU+kZ6ZDLOBzeVFTP16opNeT9e44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=edyKGp64cd/OlNW8kJzM5c/t3G5yWjGRDMpxj7PG3Y1IPIzJZfNCLRim/RfMC4ETKo13WyBmWwotW+iZSxieKvGj3pr+2BfWAWZAVZ4fL3ISG4I7h6OHirfxs6gzzs2HhaJgJTYCiG8XkRYLzo/6RZTsGAn6OwXCuy7316Rb7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kxFJ6YKv; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kxFJ6YKv"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DAA731F6C2;
	Fri, 23 Feb 2024 03:38:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pWpPD2RRGdOMWLZiU+kZ6ZDLOBzeVFTP16opNe
	T9e44=; b=kxFJ6YKv3EeUADopuax0qCbwfH2RJccVdbwkrnPWtUxTbVl6dJAvvv
	IA3i/52i0IeBi0UrK+Nt9Xrq4fViYn24cAZmU918jD3mcuu4pBE6SpnyRzbYMHbA
	4dEvynAoJMRst1RfntXoErxn49zxK0QNAV75RE8smh6wd3Ougapc8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D32F31F6C1;
	Fri, 23 Feb 2024 03:38:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 097031F6BE;
	Fri, 23 Feb 2024 03:37:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Leslie Cheng via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Wong <e@80x24.org>,  Leslie Cheng
 <leslie.cheng5@gmail.com>,  Leslie Cheng <leslie@lc.fyi>
Subject: Re: [PATCH v2] Add unix domain socket support to HTTP transport
In-Reply-To: <pull.1681.v2.git.git.1708653536115.gitgitgadget@gmail.com>
	(Leslie Cheng via GitGitGadget's message of "Fri, 23 Feb 2024 01:58:55
	+0000")
References: <pull.1681.git.git.1708506863243.gitgitgadget@gmail.com>
	<pull.1681.v2.git.git.1708653536115.gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 00:37:58 -0800
Message-ID: <xmqqzfvrzic9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D9D946F4-D226-11EE-BEDD-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Leslie Cheng via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v2] Add unix domain socket support to HTTP transport

Perhaps

	Subject: [PATCH] http: enable proxying via unix-domain socket

to follow the usual "<area>: <description>" format?

> From: Leslie Cheng <leslie.cheng5@gmail.com>
>
> This changeset introduces an `http.unixSocket` option so that users can

"This changeset introduces" -> "Introduce".  There may be other
gotchas that might use help from Documentation/SubmittingPatches,
but I didn't read too carefully.

Besides, it is a single patch, not a set of changes ;-).

`http.unixSocket` is a configuration variable.  It may be confusing
to use the word "option".  Speaking of options, shouldn't there be a
command line option that overrides the configured value?

We should honor the usual http.<url>.VARIABLE convention where
http.<url>.VARIABLE that is destination-specific overrides a more
generic http.VARIABLE configuration variable.

> proxy their git over HTTP remotes to a unix domain socket. In terms of
> why, since UDS are local and git already has a local protocol: some
> corporate environments use a UDS to proxy requests to internal resources
> (ie. source control), so this change would support those use-cases. This

"ie." -> "i.e.,"?

> proxy can occasionally be necessary to attach MFA tokens or client
> certificates for CLI tools.
>
> The implementation leverages `--unix-socket` option [0] via the
> `CURLOPT_UNIX_SOCKET_PATH` flag available with libcurl [1].

There is a feature in libcURL library, that is enabled by setting
the CURLOPT_UNIX_SOCKET_PATH option via the curl_easy_setopt() call,
and their command line utility.  You do the same to implement this
feature.  But when you are not adding "--unix-socket" option to any
of our commands, mention of that option name makes it more confusing
than necessary.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system work in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.

How about following that convention, perhaps like:

    In some corporate environments, the proxy server listens to a
    local unix domain socket for requests, instead of listening to a
    network port.  Even though we have http.proxy (and more
    destination specific http.<url>.proxy) configuration variables
    to specify the network address/port of a proxy, that would not
    help if your proxy does not listen to the network.

    Introduce an `http.unixSocket` (and `http.<url>.unixSocket`)
    configuration variables that specify the path to a unix domain
    socket for such a proxy.  Recent versions of libcURL library
    added CURLOPT_UNIX_SOCKET_PATH to support "curl --unix-socket
    <path>"---use the same mechanism to implement it.

> `GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH` and `NO_UNIX_SOCKETS` were kept
> separate so that we can spit out better error messages for users if git
> was compiled with `NO_UNIX_SOCKETS`.

Unlike NO_UNIX_SOCKETS, GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH is
entirely internal to your implementation and not surfaced to neither
the end-users or the binary packagers.  Because of that, I suspect
that any description that has to use that name probably falls on the
other side of "too much implementation details" to be useful to help
future developers..

Besides, I suspect that GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH might
not be the optimum approach.  See below.

> diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
> index 2d4e0c9b869..bf48cbd599a 100644
> --- a/Documentation/config/http.txt
> +++ b/Documentation/config/http.txt
> @@ -277,6 +277,11 @@ http.followRedirects::
>  	the base for the follow-up requests, this is generally
>  	sufficient. The default is `initial`.
>  
> +http.unixSocket::
> +	Connect through this Unix domain socket via HTTP, instead of using the
> +	network. If set, this config takes precendence over `http.proxy` and
> +	is incompatible with the proxy options (see `curl(1)`).

Talking about precedence between this and http.proxy is good thing,
but one very important piece of information is missing.  What value
does it take?

	The absolute path of a unix-domain socket to pass the HTTP
	traffic over, instead of using the network.

or something, perhaps?

> diff --git a/git-curl-compat.h b/git-curl-compat.h
> index fd96b3cdffd..f0f3bec0e17 100644
> --- a/git-curl-compat.h
> +++ b/git-curl-compat.h
> @@ -74,6 +74,13 @@
>  #define GIT_CURL_HAVE_CURLE_SSL_PINNEDPUBKEYNOTMATCH 1
>  #endif
>  
> +/**
> + * CURLOPT_UNIX_SOCKET_PATH was added in 7.40.0, released in January 2015.
> + */
> +#if LIBCURL_VERSION_NUM >= 0x074000
> +#define GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH 1
> +#endif

The "HAVE" part in GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH is a
statement of a fact.  If the version of cURL library we have is
certain value, we have it.  OK.

> diff --git a/http.c b/http.c
> index e73b136e589..8cfdcaeac82 100644
> --- a/http.c
> +++ b/http.c
> @@ -79,6 +79,9 @@ static const char *http_proxy_ssl_ca_info;
>  static struct credential proxy_cert_auth = CREDENTIAL_INIT;
>  static int proxy_ssl_cert_password_required;

It might make the code easier to follow if you did:

	#if !defined(NO_CURLOPT_UNIX_SOCKET_PATH) && !defined(NO_UNIX_SOCKETS)
	#if defined(GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH)
        #define USE_CURLOPT_UNIX_SOCKET_PATH
	#endif
	#endif
        
The points are

 (1) the users can decline to use CURLOPT_UNIX_SOCKET_PATH while
     still using unix domain socket for other purposes, and

 (2) you do not have to care if you HAVE it or not most of time;
     what matters more often is if the user told you to USE it.

Hmm?

> +#if defined(GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH) && !defined(NO_UNIX_SOCKETS)
> +static const char *curl_unix_socket_path;
> +#endif

The guard here would become "#ifdef USE_CURLOPT_UNIX_SOCKET_PATH" if
we wanted this to be conditional, but I think it is easier to make
the variable unconditionally available; see below.

> @@ -455,6 +458,20 @@ static int http_options(const char *var, const char *value,
>  		return 0;
>  	}
>  
> +	if (!strcmp("http.unixsocket", var)) {
> +#ifdef GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH
> +#ifndef NO_UNIX_SOCKETS
> +		return git_config_string(&curl_unix_socket_path, var, value);
> +#else
> +		warning(_("Unix socket support unavailable in this build of Git"));
> +		return 0;
> +#endif
> +#else
> +		warning(_("Unix socket support is not supported with cURL < 7.40.0"));
> +		return 0;
> +#endif
> +	}

In general, it is inadvisable to issue a warning in the codepath
that parses configuration variables, as the values we read may not
be necessarily used.  We could instead accept the given path into a
variable unconditionally, and complain only before it gets used,
near the call to curl_easy_setopt().

>  	if (!strcmp("http.cookiefile", var))
>  		return git_config_pathname(&curl_cookie_file, var, value);
>  	if (!strcmp("http.savecookies", var)) {
> @@ -1203,6 +1220,12 @@ static CURL *get_curl_handle(void)
>  	}
>  	init_curl_proxy_auth(result);
>  
> +#if defined(GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH) && !defined(NO_UNIX_SOCKETS)
> +	if (curl_unix_socket_path) {
> +		curl_easy_setopt(result, CURLOPT_UNIX_SOCKET_PATH, curl_unix_socket_path);
> +	}
> +#endif

Here, the guard may become more like

		if (curl_unix_socket_path) {
	#ifdef USE_CURLOPT_UNIX_SOCKET_PATH
			curl_easy_setopt(...);
	#elif defined(NO_CURLOPT_UNIX_SOCKET_PATH) || defined(NO_UNIX_SOCKETS)
			warning(_("this build disables the unix-domain-socket feature"));
	#elif
			warning(_("your cURL library is too old"));
	#endif
		}
