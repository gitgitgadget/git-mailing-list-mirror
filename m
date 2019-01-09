Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F92F1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 12:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfAIMQB (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 07:16:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36568 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbfAIMQB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 07:16:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so7954326wmc.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 04:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=J0gS5G5vTpsT2Rn1XNV7AQ2DmDH+PWvUjwKPAzu49VM=;
        b=drA5q6W7U01dvrOnwDpjm4hRk4mh4Z/heyUJKvxhYNYGLXZzY+qmHMsSzr4smyFdWS
         hkQwmrPCrA8gly/DkUn4WN3K3HptiyxdCMOfVKFmoVSXhXwV4+WtcuO1HkoGqUUkBPbv
         3a6ZPciQsn80ucb8pP1zsii6e+L7PKhlvGdOI6FbWEM82khwmcHZ5WEEZWSvnwFQSSFF
         7LcItQMgl4yLJJ9oQJ5NDcsLtVeuswShFabtrRZYSUYDIwhn74D5F1lFpP1d9cvvdvOA
         6h+Nuq6FVxZMhuUYVF15vfWhC9lXp8OrmfC2yxtyF4EkYzTQ9fMKq0lpZYOFdUPmPwm9
         +xBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=J0gS5G5vTpsT2Rn1XNV7AQ2DmDH+PWvUjwKPAzu49VM=;
        b=SY+x3KU5YmSbcK6vXYT8enboFXBe3IQo9XDVktOEkZBRqkd/QicOCzRV0spcCyIZin
         7t6XvubXUXNZkYzriybjwc/GXMOX4d+uwDXmiL+icU59VghzBb2avQ38FLAKiP5Mr69S
         ragVBPCZ2OTwpd9aXkfqxXM+5afGs+HR2BAZeVRPwovz8+6GGfm9V7RRafUnrVIarn2x
         HxRm091PSSAT49ZVoHlqIdoa2gu6y5F0LLsJuKoFUAOUHGGMBQK13HcmYvhBwfuqw5Jm
         RudPFBF5aLrU2qFeFMmT0HXgXpV130ZLPIULZn5FkKIrAwx4YxVV2yM37zEe+yII+Y49
         Ak5A==
X-Gm-Message-State: AJcUukcJaKXbaZjn4c8Gtnr6jSqMBlP6HSKAafosJW83TN0D7j8Ikl71
        PusBiYfdvvVWJndBuOrep3Y=
X-Google-Smtp-Source: ALg8bN5mqfCcycXnuQ6uYtXtBltyG68STLcvQnq6WIsWvOyUFZSfyAwKSFvGm3PuWv8K6TclYSJjkA==
X-Received: by 2002:a1c:180a:: with SMTP id 10mr5449001wmy.92.1547036159196;
        Wed, 09 Jan 2019 04:15:59 -0800 (PST)
Received: from szeder.dev (x4db906b6.dyn.telefonica.de. [77.185.6.182])
        by smtp.gmail.com with ESMTPSA id m193sm13747031wmb.26.2019.01.09.04.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 04:15:58 -0800 (PST)
Date:   Wed, 9 Jan 2019 13:15:55 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
Subject: Re: [PATCH v3 1/5] http: support file handles for HTTP_KEEP_ERROR
Message-ID: <20190109121555.GE4673@szeder.dev>
References: <20181229194447.157763-1-masayasuzuki@google.com>
 <20190108024741.62176-1-masayasuzuki@google.com>
 <20190108024741.62176-2-masayasuzuki@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108024741.62176-2-masayasuzuki@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 07, 2019 at 06:47:37PM -0800, Masaya Suzuki wrote:
> HTTP_KEEP_ERROR makes it easy to debug HTTP transport errors. In order
> to make HTTP_KEEP_ERROR enabled for all requests, file handles need to
> be supported.
> 
> Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
> ---
>  http.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/http.c b/http.c
> index 0b6807cef9..06450da96e 100644
> --- a/http.c
> +++ b/http.c
> @@ -1991,16 +1991,19 @@ static int http_request_reauth(const char *url,
>  	/*
>  	 * If we are using KEEP_ERROR, the previous request may have
>  	 * put cruft into our output stream; we should clear it out before
> -	 * making our next request. We only know how to do this for
> -	 * the strbuf case, but that is enough to satisfy current callers.
> +	 * making our next request.
>  	 */
>  	if (options && options->keep_error) {
>  		switch (target) {
>  		case HTTP_REQUEST_STRBUF:
>  			strbuf_reset(result);
>  			break;
> +		case HTTP_REQUEST_FILE:
> +			fflush(result);
> +			ftruncate(fileno(result), 0);

Some GCC versions complain about the above line:

  http.c: In function ‘http_request_reauth’:
  http.c:1961:3: error: ignoring return value of ‘ftruncate’, declared with attribute warn_unused_result [-Werror=unused-result]
     ftruncate(fileno(result), 0);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
      CC shell.o
      CC remote-testsvn.o
      CC vcs-svn/line_buffer.o
  cc1: all warnings being treated as errors
  make: *** [http.o] Error 1
  make: *** Waiting for unfinished jobs....

> +			break;
>  		default:
> -			BUG("HTTP_KEEP_ERROR is only supported with strbufs");
> +			BUG("Unknown http_request target");
>  		}
>  	}
>  
> -- 
> 2.20.1.97.g81188d93c3-goog
> 
