Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6331D1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 21:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeIGCbw (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 22:31:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38987 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeIGCbw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 22:31:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so12739200wmq.4
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pucbok0Ru9uyL37IJi61KNHQkW6wBBYwQ7SXpcRUQK0=;
        b=kiRzLvfAAWT8bzf6MniuUeudKfZkVnKfwtTOr6K7LNch+Sh9gO67d7XhxPW4J8R0bb
         PxW6GVP/HIiL8XKoxWQIStCRsISYjbyAhNmajax0BM7mvQciHXUtLx8gZ1011C3lwfqf
         nCS+f0a81o0yOh28gMHhQm+VAaoNJ54cHhP4s/qAasfR55/9dyrEKEKdha9pe4l/NuiY
         uA6lZz7LzprlvDwsOATSj5INYKSZcxoxgw3w/DMZBywbkMC4O7nAjGTbvcn/oq9Gqfy/
         Rrp3g4YRvUYZb7KfW8FgZdna8DAuUVEImoosirdhUW+MN7RdqyVKtxkqW1B7eb6/cb0W
         cJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pucbok0Ru9uyL37IJi61KNHQkW6wBBYwQ7SXpcRUQK0=;
        b=aKpsuWkgw9eFj8gliGpVm0ThDrs6U0t/O8jbx6vAN9UZydg03L3moq4+ZIQGFCpL0w
         DK6nq5MWAkHB1dpRGYSC/iaeP2oP82XmSaoGPEzf94eXSHY0c4CcHx6dUdjgwLQhn4uy
         sfxZQ8JeBnVjCRKTQm0kI3iaq02zih3uTUXTULyMGlR2wEvLVAxxAXmW9KiQdgQtyrFi
         94YtoWkGBA6I5qgZhGe2UnAGXeqEUvDgPB0krcIjvM7A4QJurSgjRgU7v6lTKMxRBdUl
         h7sJqdJhio7KiLfL4QgjWYVMSTaE7675mTkNibXf49/PCAZHEqb3dMDUpYrDEJj5xpqA
         TAqQ==
X-Gm-Message-State: APzg51B5wE36oO1vm3cnubYhfS0JP0x15Em5TpEciskSnYWCaSlykwsB
        5/1ATUW869SO2bdYBVwV3sU=
X-Google-Smtp-Source: ANB0VdakBkH0QP0Q8LLsMaTMs1l8PzBCMPWY8yNu0KxLsSB/rb5pjul+YadGVNEFtJmNDsb8hiw7HA==
X-Received: by 2002:a1c:c5cc:: with SMTP id v195-v6mr3422131wmf.29.1536270859244;
        Thu, 06 Sep 2018 14:54:19 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y12-v6sm3608250wrq.33.2018.09.06.14.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 14:54:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-backend: allow empty CONTENT_LENGTH
References: <20180906193516.28909-1-max@max630.net>
Date:   Thu, 06 Sep 2018 14:54:18 -0700
In-Reply-To: <20180906193516.28909-1-max@max630.net> (Max Kirillov's message
        of "Thu, 6 Sep 2018 22:35:16 +0300")
Message-ID: <xmqq1sa6z3zp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> According to RFC3875, empty environment variable is equivalent to unset,
> and for CONTENT_LENGTH it should mean zero body to read.
>
> However, as discussed in [1], unset CONTENT_LENGTH is also used for
> chunked encoding to indicate reading until EOF, so keep this behavior also
> for empty CONTENT_LENGTH.

Makes sense.

>
> Add a test for the case.
>
> [1] https://public-inbox.org/git/20160329201349.GB9527@sigill.intra.peff.net/
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> Hi.
>
> This should fix it. I'm not sure should it treat it as 0 or "-1"
> At least the tests mentioned by Jeff fails if I try to treat missing CONTENT_LENGTH as "-1"
> So keep the existing behavior as much as possible

I am not sure what you mean by the above, between 0 and -1.  The
code signals the caller of get_content_length() that req_len is -1
which is used as a sign to read through to the EOF, so it appears to
me that the code treats missing content-length (i.e. str == NULL
case) as "-1".


>  http-backend.c                         |  2 +-
>  t/t5562-http-backend-content-length.sh | 11 +++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/http-backend.c b/http-backend.c
> index e88d29f62b..a1230d7ead 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -353,7 +353,7 @@ static ssize_t get_content_length(void)
>  	ssize_t val = -1;
>  	const char *str = getenv("CONTENT_LENGTH");
>  
> -	if (str && !git_parse_ssize_t(str, &val))
> +	if (str && *str && !git_parse_ssize_t(str, &val))
>  		die("failed to parse CONTENT_LENGTH: %s", str);
>  	return val;
>  }
> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
> index 057dcb85d6..ca34c2f054 100755
> --- a/t/t5562-http-backend-content-length.sh
> +++ b/t/t5562-http-backend-content-length.sh
> @@ -152,4 +152,15 @@ test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
>  	grep "fatal:.*CONTENT_LENGTH" err
>  '
>  
> +test_expect_success 'empty CONTENT_LENGTH' '
> +	env \
> +		QUERY_STRING=/repo.git/HEAD \
> +		PATH_TRANSLATED="$PWD"/.git/HEAD \
> +		GIT_HTTP_EXPORT_ALL=TRUE \
> +		REQUEST_METHOD=GET \
> +		CONTENT_LENGTH="" \
> +		git http-backend <empty_body >act.out 2>act.err &&
> +	verify_http_result "200 OK"
> +'
> +
>  test_done
