Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D68C433EF
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 21:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624AD60EB4
	for <git@archiver.kernel.org>; Sun, 10 Oct 2021 21:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhJJVoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Oct 2021 17:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhJJVoM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Oct 2021 17:44:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F34BC061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 14:42:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d3so32142749edp.3
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 14:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QSC3/yLaLsivqsLpU55+78LPU6+mWAJYK5DbiJ4ukAg=;
        b=dkvFOt3+fWKSR5sE2p4swLBNQV2kFzVB9rF9B4NyuCeJsMZ5CwYK4bsIMu8Hh3fVeQ
         3uiahgthfV9dz0YKczI56qyZFayQ+R4KQxc8JuIJ2dael1pCHlgYVqPqad4v1gW7h+4s
         yAkJwdcNZO0RVSlEkVts5pTt7RSXNHW0Fps6YtPg6fQE8OKv5kjGB43GVbjT4gzrx3EL
         wKwv/asJkuTBv+PLgEJhylZ6jiDDUsQ0iHc6QymezK2fpup+wdlrZHnx4QHY4mF+eIp2
         bW/waDEEN95Hdco3n4tswFcFJQ8qiElIJmlR2AoGXKbqOo+Eq+OHnGr7Qde98OZDrdIh
         iZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QSC3/yLaLsivqsLpU55+78LPU6+mWAJYK5DbiJ4ukAg=;
        b=fqeYfFP9n1Tlc3q/QrVyemW9Qk1A2sT0+0nh1aNjCvxnzMFR8epBj43LvFAerkd3Ow
         HPD6fF+4dfGKdqOFcVCAydNvuZOj7OlDdQ9Ig0oFJAaS6+PjhbghZdI3wqN7FvRfzTH4
         Zvb/ShdduTyOnhDDch0TTeCAHYQMjRuKzAnd0yRXr/yN+MniKwxLlMY4wGw15cR8cDr3
         yn3YoFtTvoVwG/6T/v9xMsPywgGxspS7dePkbCnfCqpX517nVIDfNJ70Qqc1z/KYVc0k
         gsUzQM7vuMiBAE0JIhsf+M1c6dRDVFdH6V1eSjltonUouT7ZNFw6OXq9maImN4o8kiha
         37sg==
X-Gm-Message-State: AOAM533JKOyhSF5djzAMOCg6xNIghOUCx63204Z+Qt1jQAds/Uesb2ou
        BOTvxTuZTrKPzw4DTmNLJdM=
X-Google-Smtp-Source: ABdhPJyFQVXMbwLTxBYDNEPZUT7+iyY+rbZhv48Yet/CdJ+kTu/v1530ariSsdGoAZFmZqHd0SnB3Q==
X-Received: by 2002:a17:906:d541:: with SMTP id cr1mr22514351ejc.81.1633902131128;
        Sun, 10 Oct 2021 14:42:11 -0700 (PDT)
Received: from szeder.dev (94-21-58-27.pool.digikabel.hu. [94.21.58.27])
        by smtp.gmail.com with ESMTPSA id j3sm2524168ejy.65.2021.10.10.14.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 14:42:10 -0700 (PDT)
Date:   Sun, 10 Oct 2021 23:42:09 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: check CURLE_SSL_PINNEDPUBKEYNOTMATCH when emitting
 errors
Message-ID: <20211010214209.GE571180@szeder.dev>
References: <patch-1.1-6e65734cbce-20210924T100532Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-6e65734cbce-20210924T100532Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 12:08:20PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Change the error shown when a http.pinnedPubKey doesn't match to point
> the http.pinnedPubKey variable 

I'm not sure what this means.  Between the repeated
'http.pinnedPubKey' config variable name and the "doesn't match to
point the ..." part I can't decipher it.

> added in aeff8a61216 (http: implement
> public key pinning, 2016-02-15), e.g.:
> 
>     git -c http.pinnedPubKey=sha256/someNonMatchingKey ls-remote https://github.com/git/git.git
>     fatal: unable to access 'https://github.com/git/git.git/' with http.pinnedPubkey configuration: SSL: public key does not match pinned public key!
> 
> Before this we'd emit the exact same thing without the " with
> http.pinnedPubkey configuration". The advantage of doing this is that
> we're going to get a translated message (everything after the ":" is
> hardcoded in English in libcurl), and we've got a reference to the
> git-specific configuration variable that's causing the error.
> 
> Unfortunately we can't test this easily, as there are no tests that
> require https:// in the test suite, and t/lib-httpd.sh doesn't know
> how to set up such tests. See [1] for the start of a discussion about
> what it would take to have divergent "t/lib-httpd/apache.conf" test
> setups. #leftoverbits
> 
> 1. https://lore.kernel.org/git/YUonS1uoZlZEt+Yd@coredump.intra.peff.net/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> I had this waiting on the now-landed ab/http-drop-old-curl-plus due to
> adding a new entry to git-curl-compat.h.
> 
>  git-curl-compat.h | 3 ++-
>  http.c            | 4 ++++
>  http.h            | 1 +
>  remote-curl.c     | 4 ++++
>  4 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/git-curl-compat.h b/git-curl-compat.h
> index a308bdb3b9b..56a83b6bbd8 100644
> --- a/git-curl-compat.h
> +++ b/git-curl-compat.h
> @@ -64,16 +64,17 @@
>  #if LIBCURL_VERSION_NUM >= 0x072200
>  #define GIT_CURL_HAVE_CURL_SSLVERSION_TLSv1_0
>  #endif
>  
>  /**
>   * CURLOPT_PINNEDPUBLICKEY was added in 7.39.0, released in November
> - * 2014.
> + * 2014. CURLE_SSL_PINNEDPUBKEYNOTMATCH was added in that same version.
>   */
>  #if LIBCURL_VERSION_NUM >= 0x072c00
>  #define GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY 1
> +#define GIT_CURL_HAVE_CURLE_SSL_PINNEDPUBKEYNOTMATCH 1
>  #endif
>  
>  /**
>   * CURL_HTTP_VERSION_2 was added in 7.43.0, released in June 2015.
>   *
>   * The CURL_HTTP_VERSION_2 alias (but not CURL_HTTP_VERSION_2_0) has
> diff --git a/http.c b/http.c
> index d7c20493d7f..b6735b51c31 100644
> --- a/http.c
> +++ b/http.c
> @@ -1486,12 +1486,16 @@ static int handle_curl_result(struct slot_results *results)
>  		 * certificate, bad password, or something else wrong
>  		 * with the certificate.  So we reject the credential to
>  		 * avoid caching or saving a bad password.
>  		 */
>  		credential_reject(&cert_auth);
>  		return HTTP_NOAUTH;
> +#ifdef GIT_CURL_HAVE_CURLE_SSL_PINNEDPUBKEYNOTMATCH
> +	} else if (results->curl_result == CURLE_SSL_PINNEDPUBKEYNOTMATCH) {
> +		return HTTP_NOMATCHPUBLICKEY;
> +#endif
>  	} else if (missing_target(results))
>  		return HTTP_MISSING_TARGET;
>  	else if (results->http_code == 401) {
>  		if (http_auth.username && http_auth.password) {
>  			credential_reject(&http_auth);
>  			return HTTP_NOAUTH;
> diff --git a/http.h b/http.h
> index 3db5a0cf320..df1590e53a4 100644
> --- a/http.h
> +++ b/http.h
> @@ -151,12 +151,13 @@ struct http_get_options {
>  #define HTTP_OK			0
>  #define HTTP_MISSING_TARGET	1
>  #define HTTP_ERROR		2
>  #define HTTP_START_FAILED	3
>  #define HTTP_REAUTH	4
>  #define HTTP_NOAUTH	5
> +#define HTTP_NOMATCHPUBLICKEY	6
>  
>  /*
>   * Requests a URL and stores the result in a strbuf.
>   *
>   * If the result pointer is NULL, a HTTP HEAD request is made instead of GET.
>   */
> diff --git a/remote-curl.c b/remote-curl.c
> index 598cff7cde6..8700dbdc0ac 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -496,12 +496,16 @@ static struct discovery *discover_refs(const char *service, int for_push)
>  		die(_("repository '%s' not found"),
>  		    transport_anonymize_url(url.buf));
>  	case HTTP_NOAUTH:
>  		show_http_message(&type, &charset, &buffer);
>  		die(_("Authentication failed for '%s'"),
>  		    transport_anonymize_url(url.buf));
> +	case HTTP_NOMATCHPUBLICKEY:
> +		show_http_message(&type, &charset, &buffer);
> +		die(_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
> +		    transport_anonymize_url(url.buf), curl_errorstr);
>  	default:
>  		show_http_message(&type, &charset, &buffer);
>  		die(_("unable to access '%s': %s"),
>  		    transport_anonymize_url(url.buf), curl_errorstr);
>  	}
>  
> -- 
> 2.33.0.1231.g24d802460a8
> 
