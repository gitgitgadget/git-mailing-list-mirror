Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 935DC1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 19:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeBTTFj (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 14:05:39 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44277 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeBTTFi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 14:05:38 -0500
Received: by mail-pf0-f196.google.com with SMTP id 17so3824772pfw.11
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 11:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/xLge1i/aBGffOQvU9kVzIXTDX+EwxBn3s+4KNJ7Xtg=;
        b=PcbidtZnm/oozH5bbvDQgAhnhMm1YnHC582tnwCt6+uvC30etNREAQspXv+7mBxBtW
         yKEdHzBkoCs/ASLppig7UJ4gPrGflnoyP3qaB4jQICVTKsCoExxKFeg8TjITRZoermLo
         9HBjYnTY9Gt7e1s3KYrd0XrwII/wYIZMc8R2s97j0P/RY6hbbO+C5Mj9s6e14CStcUX/
         VaeYmneaZbTb87ymscBCekzx/WJkA2RWHAqJS10sug38MZBnJyKBBMA/6LBjToD71+OE
         LKzN/r0ujCMfi2GbRyi1ujUtQDZUfK693yoafe9Ny0uB4MH8oWg2arvW5g2i0tsljxux
         Q7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/xLge1i/aBGffOQvU9kVzIXTDX+EwxBn3s+4KNJ7Xtg=;
        b=KUDkaZP8Jp3+iVRQR97iQhZYvTIvBFZhjhS2I3W76dvfuHOO3nsXKQWtV8uNwwl9bI
         l95seqJg0nKcoDykQ4yCNJc7WbJeIgkE39O4lLe9lbzUg7kbpvTS6S7PK8cc7VkGMWxY
         B2AVNYxuzuFfLTtHV4zCtzKXNpXTVcX9tzjONhVJSc31qg2EY0msUZ1BT4drEF4CfDnx
         jxhw+0dWPSQdUZGpdPIXUWa6ZyToSIJtXdNiaXEQ0rUKbayMcdXEGr/9WpaIo1nMCUeP
         lJal7eOb/X2P8ZnuV633VMoJUX7o3HXhcCmrUWKlqB1r4xdnbW0QdbhbjWxA0GepWWwu
         3ccQ==
X-Gm-Message-State: APf1xPDLTbeRnBjyPAKLMZ6ljFde80iMJPPpgyqDmVSLi9Yom4zieYce
        qDF2pC+AmH42fMP67jTFfCmFAg==
X-Google-Smtp-Source: AH8x224swWu7KMl9EWDxn+KG1RmGOkrvDIKo7M0BQXQriyNzHIMa+hb0N9zlP5jKua5NgJTqEK2nCA==
X-Received: by 10.98.80.89 with SMTP id e86mr632666pfb.46.1519153537871;
        Tue, 20 Feb 2018 11:05:37 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id e125sm10385391pgc.76.2018.02.20.11.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 11:05:37 -0800 (PST)
Date:   Tue, 20 Feb 2018 11:05:35 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jon Simons <jon@jonsimons.org>
Subject: Re: [PATCH 2/2] remote-curl: unquote incoming push-options
Message-ID: <20180220190535.GB201604@google.com>
References: <20180219194709.GA837@sigill.intra.peff.net>
 <20180219195014.GB988@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219195014.GB988@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/19, Jeff King wrote:
> The transport-helper protocol c-style quotes the value of
> any options passed to the helper via the "option <key> <value>"
> directive. However, remote-curl doesn't actually unquote the
> push-option values, meaning that we will send the quoted
> version to the other side (whereas git-over-ssh would send
> the raw value).
> 
> The pack-protocol.txt documentation defines the push-options
> as a series of VCHARs, which excludes most characters that
> would need quoting. But:
> 
>   1. You can still see the bug with a valid push-option that
>      starts with a double-quote (since that triggers
>      quoting).
> 
>   2. We do currently handle any non-NUL characters correctly
>      in git-over-ssh. So even though the spec does not say
>      that we need to handle most quoted characters, it's
>      nice if our behavior is consistent between protocols.
> 
> There are two new tests: the "direct" one shows that this
> already works in the non-http case, and the http one covers
> this bugfix.

This seems like a fairly obvious fix.  If the value is quoted, unquote
it and send the unquoted value as a push-option, otherwise just send the
already unquoted value as a push-option.

Thanks for finding and fixing this :)

> 
> Reported-by: Jon Simons <jon@jonsimons.org>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  remote-curl.c           | 11 ++++++++++-
>  t/t5545-push-options.sh | 18 ++++++++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/remote-curl.c b/remote-curl.c
> index 6ec5352435..f5b3d22e26 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -13,6 +13,7 @@
>  #include "credential.h"
>  #include "sha1-array.h"
>  #include "send-pack.h"
> +#include "quote.h"
>  
>  static struct remote *remote;
>  /* always ends with a trailing slash */
> @@ -145,7 +146,15 @@ static int set_option(const char *name, const char *value)
>  			return -1;
>  		return 0;
>  	} else if (!strcmp(name, "push-option")) {
> -		string_list_append(&options.push_options, value);
> +		if (*value != '"')
> +			string_list_append(&options.push_options, value);
> +		else {
> +			struct strbuf unquoted = STRBUF_INIT;
> +			if (unquote_c_style(&unquoted, value, NULL) < 0)
> +				die("invalid quoting in push-option value");
> +			string_list_append_nodup(&options.push_options,
> +						 strbuf_detach(&unquoted, NULL));
> +		}
>  		return 0;
>  
>  #if LIBCURL_VERSION_NUM >= 0x070a08
> diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
> index c64dee2127..b47a95871c 100755
> --- a/t/t5545-push-options.sh
> +++ b/t/t5545-push-options.sh
> @@ -217,6 +217,15 @@ test_expect_success 'invalid push option in config' '
>  	test_refs master HEAD@{1}
>  '
>  
> +test_expect_success 'push options keep quoted characters intact (direct)' '
> +	mk_repo_pair &&
> +	git -C upstream config receive.advertisePushOptions true &&
> +	test_commit -C workbench one &&
> +	git -C workbench push --push-option="\"embedded quotes\"" up master &&
> +	echo "\"embedded quotes\"" >expect &&
> +	test_cmp expect upstream/.git/hooks/pre-receive.push_options
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
>  
> @@ -260,6 +269,15 @@ test_expect_success 'push options work properly across http' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'push options keep quoted characters intact (http)' '
> +	mk_http_pair true &&
> +
> +	test_commit -C test_http_clone one &&
> +	git -C test_http_clone push --push-option="\"embedded quotes\"" origin master &&
> +	echo "\"embedded quotes\"" >expect &&
> +	test_cmp expect "$HTTPD_DOCUMENT_ROOT_PATH"/upstream.git/hooks/pre-receive.push_options
> +'
> +
>  stop_httpd
>  
>  test_done
> -- 
> 2.16.2.552.gea2a3cf654

-- 
Brandon Williams
