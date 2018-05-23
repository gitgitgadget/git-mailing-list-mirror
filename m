Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409321F51C
	for <e@80x24.org>; Wed, 23 May 2018 01:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753538AbeEWBXa (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 21:23:30 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:40171 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753441AbeEWBX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 21:23:29 -0400
Received: by mail-wm0-f46.google.com with SMTP id j5-v6so4527239wme.5
        for <git@vger.kernel.org>; Tue, 22 May 2018 18:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lyWft9c748WwQcbDshJF33a1FsAZZgSe10A1XicOiSQ=;
        b=gsrneZRj6KlkxRyLmk7wvx+0yY0RCrmPlpUPDJOzGQJitdaiR934/DNhhHsx+uYXiD
         hARMJW4eLxvTCeFtjMmIYZXAkw/m8KCSB7Mk/ZVWPvDGrTv4+vp5X1tBMgDSjTlmQbUq
         TKz8nCFW5hoJM+mCRt/nsyFtEh9gQNl4YKVIhIc1dIvCoQ8HsqQEwM/vuAdZUCaFBHnP
         D3q08Wc2KqPtsxjO8KmSE8WnNqN7lB+eVuvN9hqlsk102eOZJM8MKh4tUSigk4DiRnmB
         LFuU1BnT4XGi48lGmI43OIjbHm9/h5eUZlmIfh6wlmw9G1yFMC9aaagVGM6MarQHe2wZ
         L03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lyWft9c748WwQcbDshJF33a1FsAZZgSe10A1XicOiSQ=;
        b=kqGsgr055y4v9Ag3HltNPTV4uX8xk23w+u4xgQoOU8DgwQRou+rhJ1OxPYanAyM5ML
         ndvSWRLrHgPc5Bq8noiId+49xn6NUiTuzCQl7qcwk9OdRxrvotsavet/XZrsRYtbAEmG
         U7kFzRY1Qi8XMNLYcD4OrAU4jVBjcrEXhxBnUSYhbO7EOmw+6mgktBo06qu7JdtghKLC
         iqLStk8rWfnnKvy62HyxrhnaFTryk18OqX/k2fW6cMkzQnWiUh2zRfOx07eeV3+GXgAq
         0m8D7w4E3nbF8fdqKBOD6bTRlzLGzaFwiUC3hRMq5Mc7y3J+h8QrdjJDRnPIn7G8XRPG
         o+Hw==
X-Gm-Message-State: ALKqPwel9F4O0k/g987u6yL0hSmqpPLpBoVf+hErb9b+gMt3LBFR5dm2
        +7nBS/nve9kTcQ6BIpcz6fY=
X-Google-Smtp-Source: AB8JxZrzJfhK9aQ1lR2plEa1TSPD1Hbs2XO5O1PQXyD5tIcpgyOUHg2lJ8karmaQxWGqME1XDBP08w==
X-Received: by 2002:a1c:6f57:: with SMTP id k84-v6mr2445050wmc.142.1527038607959;
        Tue, 22 May 2018 18:23:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x73-v6sm863108wmf.21.2018.05.22.18.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 18:23:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com
Subject: Re: [PATCH v2 1/2] remote-curl: accept all encodings supported by curl
References: <20180521234004.142548-1-bmwill@google.com>
        <20180522184204.47332-1-bmwill@google.com>
Date:   Wed, 23 May 2018 10:23:26 +0900
In-Reply-To: <20180522184204.47332-1-bmwill@google.com> (Brandon Williams's
        message of "Tue, 22 May 2018 11:42:03 -0700")
Message-ID: <xmqqwovvw4fl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index f5721b4a5..913089b14 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -26,14 +26,14 @@ setup_askpass_helper
>  cat >exp <<EOF
>  > GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
>  > Accept: */*
> -> Accept-Encoding: gzip
> +> Accept-Encoding: ENCODINGS
>  > Pragma: no-cache

Is the ordering of these headers determined by the user of cURL
library (i.e. Git), or whatever the version of cURL we happened to
link with happens to produce?

The point is whether the order is expected to be stable, or we are
better off sorting the actual log before comparing.

>  < HTTP/1.1 200 OK
>  < Pragma: no-cache
>  < Cache-Control: no-cache, max-age=0, must-revalidate
>  < Content-Type: application/x-git-upload-pack-advertisement

A similar question for this response.

>  > POST /smart/repo.git/git-upload-pack HTTP/1.1
> -> Accept-Encoding: gzip
> +> Accept-Encoding: ENCODINGS
>  > Content-Type: application/x-git-upload-pack-request
>  > Accept: application/x-git-upload-pack-result
>  > Content-Length: xxx

Ditto for this request.

> @@ -79,8 +79,13 @@ test_expect_success 'clone http repository' '
>  		/^< Date: /d
>  		/^< Content-Length: /d
>  		/^< Transfer-Encoding: /d
> -	" >act &&
> -	test_cmp exp act
> +	" >actual &&
> +	sed -e "s/^> Accept-Encoding: .*/> Accept-Encoding: ENCODINGS/" \
> +			actual >actual.smudged &&
> +	test_cmp exp actual.smudged &&
> +
> +	grep "Accept-Encoding:.*gzip" actual >actual.gzip &&
> +	test_line_count = 2 actual.gzip
>  '

Similarly, how much control do we have to ensure that the test HTTPD
server (1) supports gzip and (2) does not support encoding algos
with confusing names e.g. "funnygzipalgo" that may accidentally
match that pattern?

Thanks.  Not a new issue with this patch, but just being curious if
you or anybody thought about it as a possible issue.


