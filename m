Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F38341F404
	for <e@80x24.org>; Tue, 11 Sep 2018 17:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeIKW32 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 18:29:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55536 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeIKW32 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 18:29:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so1855209wmc.5
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=oe8F9lUdHjlHUEZwL6jm2mVO5hX9JDyEn/OlWdcmjn8=;
        b=iZODeUF93adIsSaLGaTPTJyA+2U1c3nnWNz7voFFsZss1itNN22n5+rakKGsiBbKBz
         ZQS6zimIgqiztFsEKHI93PbC0ptN6a41aHmCtPbVQbKrrjJlNOrldJRgj6n7uP39ullZ
         Lb5FPeoW7B15TGDvYOyuqnS3CccefUL+I4s2vULziYI+1qLWCZDAYt+tw2RFWIXBUWxJ
         fh1RjVrAKGqvgaUKJ3bjDh9CkVoJYBCDOpxswmZvil0IqpGnndP2E810lfac6uR5cKn6
         XhtDzNf9iKWP/larhokXyLxR7N+wVQCndb1R7a4EFOfDUVTkgE9j3YvJSY8DGA5WFMpU
         TH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=oe8F9lUdHjlHUEZwL6jm2mVO5hX9JDyEn/OlWdcmjn8=;
        b=Trc9RibpR6XK39w/o3RH8jSoDbYw5g26BovrgCVxJR4yWUYb6vaaj/HK2SM8QlP28B
         XOEmrArtTl5SeKk9h2y8zy0G42rqyvXohnBpOp/d8OQje/mrLmjobgP+LuDCTwFE414T
         tV3CVXCoPCm/EUSlythdnEREQ8Jny8qYokb1URGJef0C6TH6xp5qJ7wGaGPbouWqq+b6
         75vvLoe5JakslJi574YdI143odGKmF9UOI+EhBR5BaLsX6MsMsHZWJ7fMwoVAdck/0ZR
         Knmb5FF+D+stscb+LzZaY/lVBe8LNeQWbSxDcjHFDwhosAT2pNnjziqX5J+kcKMIlApq
         rgVQ==
X-Gm-Message-State: APzg51DbFOhfQb5iQFPg0D6IWkP/d62HZvKAtDOP+rBrGmZ95keoOYcF
        BpcYI+5KYzo4rsRu83XdpkE=
X-Google-Smtp-Source: ANB0VdakmijEYqNQFkXIIaAbBZWz++3afrTgXwtMFvmutjEyGCj2kH9/hXKgvorogIdZS+4AZSiV3A==
X-Received: by 2002:a1c:b686:: with SMTP id g128-v6mr1839988wmf.83.1536686946281;
        Tue, 11 Sep 2018 10:29:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g2-v6sm2179593wme.20.2018.09.11.10.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 10:29:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t5551-http-fetch-smart.sh: sort cookies before comparing
References: <20180907232205.31328-1-tmz@pobox.com>
Date:   Tue, 11 Sep 2018 10:29:04 -0700
In-Reply-To: <20180907232205.31328-1-tmz@pobox.com> (Todd Zullinger's message
        of "Fri, 7 Sep 2018 19:22:05 -0400")
Message-ID: <xmqqsh2gosdb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> With curl-7.61.1 cookies are sorted by creation-time¹.  Sort the output
> used in the 'cookies stored in http.cookiefile when http.savecookies
> set' test before comparing it to the expected cookies.
>
> ¹ https://github.com/curl/curl/commit/e2ef8d6fa ("cookies: support
>   creation-time attribute for cookies", 2018-08-28)
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> [Resending with the list in Cc; sorry for spamming you,
> Junio, Jeff, and Gábor.]
> ...
> 7ae89caac6c721f16555e981eaeed64abc165c5d	refs/heads/master
> 263207bb5fbfbefbdf1c9c3fa4ae5d9663323217	refs/namespaces/ns/refs/heads/master
> ++ tail -3 cookies.txt
> ++ test_cmp expect_cookies.txt cookies_tail.txt
> ++ diff -u expect_cookies.txt cookies_tail.txt
> --- expect_cookies.txt	2018-09-07 07:29:05.231532462 +0000
> +++ cookies_tail.txt	2018-09-07 07:29:05.306532366 +0000

Have you tried to apply this e-mail yourself before spamming the
list ;-)?

A good way to add supporting material that may be confusing to the
patch text itself is to indent them by one place with SP.

I'll manage anyway; thanks for a patch.

> @@ -1,3 +1,3 @@
>
> -127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
>  127.0.0.1	FALSE	/smart_cookies/repo.git/info/	FALSE	0	name	value
> +127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
> error: last command exited with $?=1
> not ok 22 - cookies stored in http.cookiefile when http.savecookies set
>
>  t/t5551-http-fetch-smart.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 771f36f9ff..538656bfef 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -215,7 +215,7 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
>  	git config http.cookiefile cookies.txt &&
>  	git config http.savecookies true &&
>  	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
> -	tail -3 cookies.txt >cookies_tail.txt &&
> +	tail -3 cookies.txt | sort >cookies_tail.txt &&
>  	test_cmp expect_cookies.txt cookies_tail.txt
>  '
