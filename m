Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEF5C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 00:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjDUAuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 20:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjDUAuM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 20:50:12 -0400
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Apr 2023 17:50:10 PDT
Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE07268A
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 17:50:10 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.102])
        by smtp with ESMTPA
        id pevZpcsUfymjlpevaptedf; Fri, 21 Apr 2023 01:47:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1682038027; bh=6bmIIHNojxpRjpvA5fwS/JN/MynHwE0NnOrQ5sQTE0s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=izbmWNsrhbn+Iwle7wA9k1BPmOc0cFxcck13udhlVap5gdFcK0UJ59QFJCMU9UlIa
         PIdOqND9kNfU0ESPQTpLWJuTpIUsXr7x4gtHL8UIDp+rohGsE5U5/3Y+YuVriBdnjT
         blomWrWr0egPcWJJrWt2/sahPqv1GLnr/MryfO5krYAj1QR+GNG3HZ1i0Zxa89nasV
         AmyvYYHc7BV4gr68UWJSgHTKIV36P8nEuLNOqfi8QZT7Nx/yn0Oxwzd+h9JYnTp2hP
         /CQbgXR1BPgUpny5U2OIWZ7zPv098Hz/hodw7mnQLjEmUTZO1DCHX12uqngDilqsc7
         FxHUPb5gKwzRA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Y9vrDzSN c=1 sm=1 tr=0 ts=6441dd0b
 a=O4HnXJxpn4bBnFCb4s/IkQ==:117 a=O4HnXJxpn4bBnFCb4s/IkQ==:17
 a=IkcTkHD0fZMA:10 a=367I6d3oAAAA:8 a=NEAV23lmAAAA:8 a=-uMXzpRvgrTe9uJ9uOIA:9
 a=QEXdDO2ut3YA:10 a=4G2GI1IyKxSpVa9G_Bf7:22
X-AUTH: ramsayjones@:2500
Message-ID: <1c365381-4858-1534-18ba-aa6f5c5056c2@ramsayjones.plus.com>
Date:   Fri, 21 Apr 2023 01:47:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] http: document sslcert and sslkey types and extend to
 proxy
To:     Ricky Davidson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     "Junio C Hamano [ ]" <gitster@pobox.com>,
        Ricky Davidson <Ricky.Davidson@hii-tsd.com>
References: <pull.1520.v2.git.1682014322604.gitgitgadget@gmail.com>
 <pull.1520.v3.git.1682021501245.gitgitgadget@gmail.com>
Content-Language: en-GB
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <pull.1520.v3.git.1682021501245.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDIky489RW4spdZNVaugOB720W9j4lAjBLBNfHavDdXa6jSULi0HNnrsS99g3HBeverJniFIxOY58b+CErzgLGkK83WurhMUL1Z3Dts0dIoduXoyOQAa
 4iRsloWnKA78q1YaJQ+1ImPXs7vtzlV2ym95bPukWb/lrs3GxzrHdqdVJTxG8OXyPqs3G+u+adBv3nUZ7JxOJBVq6lBQDyH0j/Y=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 20/04/2023 21:11, Ricky Davidson via GitGitGadget wrote:
> From: Ricky Davidson <Ricky.Davidson@hii-tsd.com>
> 
> 0a01d41ee4 (http: add support for different sslcert and sslkey
> types., 2023-03-20) added http.sslCertType and http.sslKeyType, but:
> 
> 1. it does not document the feature.
> 2. it does not apply to SSL proxy equivalents.
> 
> Documents http.sslCertType and http.sslKeyType. Implements
> http.proxySSLCertType. Does the same for http.sslKeyType and
> http.proxySSLKeyType equivalents and related environment
> variables.
> 
> Signed-off-by: Ricky Davidson <Ricky.Davidson@hii-tsd.com>
> ---
>     [PATCH] http: document sslcert and sslkey types and extend to proxy
>     
>     0a01d41ee4 (http: add support for different sslcert and sslkey types.,
>     2023-03-20) added http.sslCertType and http.sslKeyType, but:
>     
>      1. it does not document the feature.
>      2. it does not apply to SSL proxy equivalents.
>     
>     Documents http.sslCertType and http.sslKeyType. Implements
>     http.proxySSLCertType. Does the same for http.sslKeyType and
>     http.proxySSLKeyType equivalents and related environment variables.
>     
>     Signed-off-by: Ricky Davidson Ricky.Davidson@hii-tsd.com
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1520%2FRicky-Davidson-hii-tsd%2Fmaster-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1520/Ricky-Davidson-hii-tsd/master-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1520
> 
> Range-diff vs v2:
> 
>  1:  78b96f60ec8 ! 1:  020c03104f4 http: document sslcert and sslkey types and extend to proxy
>      @@ Metadata
>        ## Commit message ##
>           http: document sslcert and sslkey types and extend to proxy
>       
>      -    0a01d41 added http.sslCertType and http.sslKeyType, but:
>      +    0a01d41ee4 (http: add support for different sslcert and sslkey
>      +    types., 2023-03-20) added http.sslCertType and http.sslKeyType, but:
>       
>      -    1. does not document the feature.
>      -    2. does not apply to SSL proxy equivalents.
>      +    1. it does not document the feature.
>      +    2. it does not apply to SSL proxy equivalents.
>       
>           Documents http.sslCertType and http.sslKeyType. Implements
>      -    http.proxySSLCertType. Same for http.sslKeyType and
>      +    http.proxySSLCertType. Does the same for http.sslKeyType and
>           http.proxySSLKeyType equivalents and related environment
>           variables.
>       
> 
> 
>  Documentation/config/http.txt | 24 ++++++++++++++++++++++++
>  http.c                        | 12 ++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
> index afeeccfbfa7..53386b90185 100644
> --- a/Documentation/config/http.txt
> +++ b/Documentation/config/http.txt
> @@ -34,11 +34,23 @@ http.proxySSLCert::
>  	with an HTTPS proxy. Can be overridden by the `GIT_PROXY_SSL_CERT` environment
>  	variable.
>  
> +http.proxySSLCertType::
> +	Format of the client certificate used to authenticate with an HTTPS proxy.
> +	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
> +	a crypto engine. Can be overridden by the `GIT_PROXY_SSL_CERT_TYPE` environment
> +	variable.
> +
>  http.proxySSLKey::
>  	The pathname of a file that stores a private key to use to authenticate with
>  	an HTTPS proxy. Can be overridden by the `GIT_PROXY_SSL_KEY` environment
>  	variable.
>  
> +http.proxySSLKeyType::
> +	Format of the client private key used to authenticate with an HTTPS proxy.
> +	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
> +	a crypto engine. Can be overridden by the `GIT_PROXY_SSL_KEY_TYPE` environment
> +	variable.
> +
>  http.proxySSLCertPasswordProtected::
>  	Enable Git's password prompt for the proxy SSL certificate.  Otherwise OpenSSL
>  	will prompt the user, possibly many times, if the certificate or private key
> @@ -161,11 +173,23 @@ http.sslCert::
>  	over HTTPS. Can be overridden by the `GIT_SSL_CERT` environment
>  	variable.
>  
> +http.sslCertType::
> +	Format of the SSL certificate used to authenticate over HTTPS.
> +	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
> +	a crypto engine. Can be overridden by the `GIT_SSL_CERT_TYPE` environment
> +	variable.
> +
>  http.sslKey::
>  	File containing the SSL private key when fetching or pushing
>  	over HTTPS. Can be overridden by the `GIT_SSL_KEY` environment
>  	variable.
>  
> +http.sslKeyType::
> +	Format of the SSL private key used to authenticate over HTTPS.
> +	Supported formats are `PEM` and `ENG`. The format `ENG` enables loading from
> +	a crypto engine. Can be overridden by the `GIT_SSL_CERT_TYPE` environment

s/GIT_SSL_CERT_TYPE/GIT_SSL_KEY_TYPE/ ?

ATB,
Ramsay Jones

> +	variable.
> +
>  http.sslCertPasswordProtected::
>  	Enable Git's password prompt for the SSL certificate.  Otherwise
>  	OpenSSL will prompt the user, possibly many times, if the
> diff --git a/http.c b/http.c
> index d5d82c5230f..bee4ea64115 100644
> --- a/http.c
> +++ b/http.c
> @@ -74,7 +74,9 @@ static const char *curl_http_proxy;
>  static const char *http_proxy_authmethod;
>  
>  static const char *http_proxy_ssl_cert;
> +static const char *http_proxy_ssl_cert_type;
>  static const char *http_proxy_ssl_key;
> +static const char *http_proxy_ssl_key_type;
>  static const char *http_proxy_ssl_ca_info;
>  static struct credential proxy_cert_auth = CREDENTIAL_INIT;
>  static int proxy_ssl_cert_password_required;
> @@ -441,9 +443,13 @@ static int http_options(const char *var, const char *value, void *cb)
>  
>  	if (!strcmp("http.proxysslcert", var))
>  		return git_config_string(&http_proxy_ssl_cert, var, value);
> +	if (!strcmp("http.proxysslcerttype", var))
> +		return git_config_string(&http_proxy_ssl_cert_type, var, value);
>  
>  	if (!strcmp("http.proxysslkey", var))
>  		return git_config_string(&http_proxy_ssl_key, var, value);
> +	if (!strcmp("http.proxysslkeytype", var))
> +		return git_config_string(&http_proxy_ssl_key_type, var, value);
>  
>  	if (!strcmp("http.proxysslcainfo", var))
>  		return git_config_string(&http_proxy_ssl_ca_info, var, value);
> @@ -1146,9 +1152,13 @@ static CURL *get_curl_handle(void)
>  
>  			if (http_proxy_ssl_cert)
>  				curl_easy_setopt(result, CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
> +			if (http_proxy_ssl_cert_type)
> +				curl_easy_setopt(result, CURLOPT_PROXY_SSLCERTTYPE, http_proxy_ssl_cert_type);
>  
>  			if (http_proxy_ssl_key)
>  				curl_easy_setopt(result, CURLOPT_PROXY_SSLKEY, http_proxy_ssl_key);
> +			if (http_proxy_ssl_key_type)
> +				curl_easy_setopt(result, CURLOPT_PROXY_SSLKEYTYPE, http_proxy_ssl_key_type);
>  
>  			if (has_proxy_cert_password())
>  				curl_easy_setopt(result, CURLOPT_PROXY_KEYPASSWD, proxy_cert_auth.password);
> @@ -1285,7 +1295,9 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  		max_requests = DEFAULT_MAX_REQUESTS;
>  
>  	set_from_env(&http_proxy_ssl_cert, "GIT_PROXY_SSL_CERT");
> +	set_from_env(&http_proxy_ssl_cert_type, "GIT_PROXY_SSL_CERT_TYPE");
>  	set_from_env(&http_proxy_ssl_key, "GIT_PROXY_SSL_KEY");
> +	set_from_env(&http_proxy_ssl_key_type, "GIT_PROXY_SSL_KEY_TYPE");
>  	set_from_env(&http_proxy_ssl_ca_info, "GIT_PROXY_SSL_CAINFO");
>  
>  	if (getenv("GIT_PROXY_SSL_CERT_PASSWORD_PROTECTED"))
> 
> base-commit: 667fcf4e15379790f0b609d6a83d578e69f20301
