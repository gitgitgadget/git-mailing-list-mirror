Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2956D20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 09:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeLMJdp (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 04:33:45 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42773 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbeLMJdo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 04:33:44 -0500
Received: by mail-ed1-f68.google.com with SMTP id j6so1425713edp.9
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 01:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=oAesfF8Gaw9Lkvh2/RWXBbWzpiksGETgb03ALklzYu8=;
        b=KQwHhFejZWfgROwK+mq7TLwAFUoiVqkrMqNhxkeI3xGwwWfEXpbizZRIcTEWl7IBU3
         s3R2iVz5R/y2+H2nia3rGUk5pDluyhtbFTL8mwIctOoL8ymniYJUjve2jO+J/gArL5cy
         0CrTW4I5DTEuIEJzFGcl7OXC+yqfyRCnKcR6JBBDv1t7XdSCX8Haprrg/65KncdTaBa1
         VCwXzRabxKXpy8X0bO1jXPjfD9Yufmsa3uhIZIjS7zVLCTcGnuCzFzFS8fdL9xmgE8iQ
         0mMfe2UVpI7rIPD31CaoxeEAfxTih/AUDEH2j7WOy0+kqumzCXw9CKpWiZKjmYi9sO3a
         SGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=oAesfF8Gaw9Lkvh2/RWXBbWzpiksGETgb03ALklzYu8=;
        b=Q3JuRcl0s6oVM2ZMMJrWWBSHMTHSAj/YzMngKpJdXbQ5l5+Ex+GxS3B9jz1ukCMEc7
         MRL6Kt5xKmeDIvO0Dd+Kven33BICTJPEZfee2JaUWaGf6CHJEkb/j0vN/LfWnHSNQknk
         jYRAw5FcdDeOH/7jPRH2344RyyNcUzdbGUW50vnkVZUO5A0ToM3WmA6/SNepmp/mzGsK
         vMYtGQIFokZmwUz3SxhhRbg2XbQy0udNmY7wRsfz0aDeMOopnBqCrVJW91tcedg5UoK/
         +Et6JXT2AtGE/S8k9dgTtHnH6iWVTbCXQFWEk2qxcC6Gw0uAOCIuYIjHC9mH5LPLpG+v
         1kNg==
X-Gm-Message-State: AA+aEWaGHfjNI/A7C4WH9DCwfKGmZuzOIieIoasDocIK9GdQCHIixZOv
        zuEaHr6Vsis3Pra9nnKhfIc=
X-Google-Smtp-Source: AFSGD/UNYCQYBjUrpylxSsmNcDK1U2aaT1KuPcQ6eZzgX8Jg1MkhgW9w3ljApyX3E2JpTdHbQhSCGw==
X-Received: by 2002:a17:906:d054:: with SMTP id bo20-v6mr17851246ejb.239.1544693622470;
        Thu, 13 Dec 2018 01:33:42 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id r1sm481333eds.1.2018.12.13.01.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 01:33:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/3] http: add support for selecting SSL backends at runtime
References: <pull.46.git.gitgitgadget@gmail.com> <pull.46.v2.git.gitgitgadget@gmail.com> <85bd0fb27fcf7615b3f927344fd77ea49b9f5dcb.1540493630.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <85bd0fb27fcf7615b3f927344fd77ea49b9f5dcb.1540493630.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Dec 2018 10:33:41 +0100
Message-ID: <87sgz1n53e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 25 2018, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> As of version 7.56.0, curl supports being compiled with multiple SSL
> backends.
>
> This patch adds the Git side of that feature: by setting http.sslBackend
> to "openssl" or "schannel", Git for Windows can now choose the SSL
> backend at runtime.
>
> This comes in handy on Windows because Secure Channel ("schannel") is
> the native solution, accessing the Windows Credential Store, thereby
> allowing for enterprise-wide management of certificates. For historical
> reasons, Git for Windows needs to support OpenSSL still, as it has
> previously been the only supported SSL backend in Git for Windows for
> almost a decade.
>
> The patch has been carried in Git for Windows for over a year, and is
> considered mature.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/config.txt |  5 +++++
>  http.c                   | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 154683321..7d38f0bf1 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1984,6 +1984,11 @@ http.sslCAPath::
>  	with when fetching or pushing over HTTPS. Can be overridden
>  	by the `GIT_SSL_CAPATH` environment variable.
>
> +http.sslBackend::
> +	Name of the SSL backend to use (e.g. "openssl" or "schannel").
> +	This option is ignored if cURL lacks support for choosing the SSL
> +	backend at runtime.
> +
>  http.pinnedpubkey::
>  	Public key of the https service. It may either be the filename of
>  	a PEM or DER encoded public key file or a string starting with
> diff --git a/http.c b/http.c
> index 98ff12258..7fb37a061 100644
> --- a/http.c
> +++ b/http.c
> @@ -155,6 +155,8 @@ static struct active_request_slot *active_queue_head;
>
>  static char *cached_accept_language;
>
> +static char *http_ssl_backend;
> +
>  size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>  {
>  	size_t size = eltsize * nmemb;
> @@ -302,6 +304,12 @@ static int http_options(const char *var, const char *value, void *cb)
>  		curl_ssl_try = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp("http.sslbackend", var)) {
> +		free(http_ssl_backend);
> +		http_ssl_backend = xstrdup_or_null(value);
> +		return 0;
> +	}
> +
>  	if (!strcmp("http.minsessions", var)) {
>  		min_curl_sessions = git_config_int(var, value);
>  #ifndef USE_CURL_MULTI
> @@ -995,6 +1003,33 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  	git_config(urlmatch_config_entry, &config);
>  	free(normalized_url);
>
> +#if LIBCURL_VERSION_NUM >= 0x073800
> +	if (http_ssl_backend) {
> +		const curl_ssl_backend **backends;
> +		struct strbuf buf = STRBUF_INIT;
> +		int i;
> +
> +		switch (curl_global_sslset(-1, http_ssl_backend, &backends)) {
> +		case CURLSSLSET_UNKNOWN_BACKEND:
> +			strbuf_addf(&buf, _("Unsupported SSL backend '%s'. "
> +					    "Supported SSL backends:"),
> +					    http_ssl_backend);
> +			for (i = 0; backends[i]; i++)
> +				strbuf_addf(&buf, "\n\t%s", backends[i]->name);
> +			die("%s", buf.buf);
> +		case CURLSSLSET_NO_BACKENDS:
> +			die(_("Could not set SSL backend to '%s': "
> +			      "cURL was built without SSL backends"),
> +			    http_ssl_backend);
> +		case CURLSSLSET_TOO_LATE:
> +			die(_("Could not set SSL backend to '%s': already set"),
> +			    http_ssl_backend);
> +		case CURLSSLSET_OK:
> +			break; /* Okay! */
> +		}
> +	}
> +#endif
> +
>  	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
>  		die("curl_global_init failed");

Here's someone who upgraded to 2.20 on Arch linux & started getting
"Could not set..." errors because of this change:
https://www.reddit.com/r/git/comments/a5ne5v/git_fatal_could_not_set_ssl_backend_to_openssl/

I don't know the context well enough, but is there perhaps enough info
here so we could give a better error message, e.g. "don't set xyz twice
in your config", or just emit a warning?
