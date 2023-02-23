Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CDBC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 23:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBWXhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 18:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBWXhC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 18:37:02 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D605A60113
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 15:36:54 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z2so15052124plf.12
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 15:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lHuzniYQbW+KsfMMFtEqrrW20NoIOvymn8NRhcCniNM=;
        b=BiZXvInzw0Yu5KhXftv7OV7O1o8R4fbv6DIZ2r6ggB9pyMjz7mWyP6G6c7cINWGMWz
         EF4CGw+cX0xEyBGybONk31bYa/LVUd5lFqvkVKu4VMpnpf4t63qtcXMGIbOS6n1zPkwK
         4MiSYGOo+RGTc8mXXyH+r6f1xf2FSzvUfE9jiQxy5HNJn4SYt6zHzbS0aKGIVwdT7wbw
         34vm807c9i/PQ0pA3dvEvKG8zwYj8h60pxNf6R+Mp3fNIpBcWq6TwJmxJoYJCn7CR//s
         PWIQVbm6BRWxVtVMotS844olMO6nsb1xnzjxYJXQPiIfDTppQQmhYrMHqpDJWx1j2MVA
         2bLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHuzniYQbW+KsfMMFtEqrrW20NoIOvymn8NRhcCniNM=;
        b=66ZtgAOQx8QbsgGD8rweoEReZBN63vQ42nUsj3bYuOV0fFYhRz/59JppHWhh1cbtUM
         Bpi2fYCzneaiV5uhWr45LDTWB99Y2tva/EcWL/a2dyzlYz+jBt2qc5SBkm1UFE6Wtmt6
         6630huK8jcFOZw/VuEkgVk8MNiJiLxJgr27wtylrMecgw4IDOpdUV4mBq4busb7FDtfP
         9B/veQ82avlyqw3Dk/s8IHhe/wIdcYfX567r+fOuyw0eEZwU1rmU4ACLvhQRNVL7g0tk
         G/G9RA7vTplNLGn0+oyciqpDlOvg4XhkF/NPnlWfveLnrp3RXR3SWCriibytLszb5BpC
         v6qw==
X-Gm-Message-State: AO0yUKXq5lNY79jv9R4Ula/7GLiIBajU9qN0QMl+bWcfuKkgzhoQINtx
        Pb3cqScISWRj29DeqNuKK04=
X-Google-Smtp-Source: AK7set+JrVFNrrMqO1LPi1SP6L3Le8fP88qlmaRm0ELrKDga1xdGRKbtk3JT4IwUoVUAfX3C1do0Ow==
X-Received: by 2002:a17:902:d482:b0:19c:356f:e98f with SMTP id c2-20020a170902d48200b0019c356fe98fmr16360717plg.60.1677195413737;
        Thu, 23 Feb 2023 15:36:53 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c10200b00189743ed3b6sm3858657pli.64.2023.02.23.15.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 15:36:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/16] t5551: drop redundant grep for Accept-Language
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
        <Y/dFWqzaCeCbmGUs@coredump.intra.peff.net>
Date:   Thu, 23 Feb 2023 15:36:53 -0800
Message-ID: <xmqqmt543qei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Commit b0c4adcdd7 (remote-curl: send Accept-Language header to server,
> 2022-07-11) added tests to make sure the header is sent via HTTP.
> However, it checks in two places:
>
>   1. In the expected trace output, we check verbatim for the header and
>      its value.
>
>   2. Afterwards, we grep for the header again in the trace file.
>
> This (2) is probably cargo-culted from the earlier grep for
> Accept-Encoding. It is needed for the encoding because we smudge the
> value of that header when doing the verbatim check; see 1a53e692af
> (remote-curl: accept all encodings supported by curl, 2018-05-22).
>
> But we don't do so for the language header, so any problem that the
> "grep" would catch in (2) would already have been caught by (1).

Makes sense.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5551-http-fetch-smart.sh | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 10b7e7cda2..29d489768e 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -103,10 +103,7 @@ test_expect_success 'clone http repository' '
>  		test_cmp exp actual.smudged &&
>  
>  		grep "Accept-Encoding:.*gzip" actual >actual.gzip &&
> -		test_line_count = 2 actual.gzip &&
> -
> -		grep "Accept-Language: ko-KR, *" actual >actual.language &&
> -		test_line_count = 2 actual.language
> +		test_line_count = 2 actual.gzip
>  	fi
>  '
