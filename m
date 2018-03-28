Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D2DD1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 00:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeC1ALC (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 20:11:02 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45771 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbeC1ALB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 20:11:01 -0400
Received: by mail-wr0-f196.google.com with SMTP id u11so540360wri.12
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 17:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Vijlvqm44Jt2zzwkKHob7Z7wSyumE22909U0IGcL4hM=;
        b=TGajs5P+AVjAiyKq93ICtS/HOn/EwXXulhmDx5xJ6gbivbnr6cSzHztZBuUg/c/76S
         8YCHVhmwq91f+WCYlEySU/yUp6NereEvl9wJ76dFa0TJQWpNceYl4+b625SXOCPeOy9C
         garA7v+JZWEfqubpmJDGUT4W/8jkCxH5fawQsasPunXaLWCbXAD2VM4jAcJhi45q9Icp
         1PgvqzENmQmPXq9OxteSYTjCoT2HVU04ecXFXQg865DguLlRByi/hHuLrt/0Y0srvif6
         mScuOfjmZlIzs+eaGQB9n+BhWA7whKynxgIaoUms2VvODHsbgEyVG1eq4i7EHMg9AXPZ
         qVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Vijlvqm44Jt2zzwkKHob7Z7wSyumE22909U0IGcL4hM=;
        b=Q9de2fUs0Sa5T6tXcWAtuWqPrWbopzqVdDScU2uxitTtlXXbpsZhY4cETx8WEIp+Kg
         ZFqxnIFscZqujM9rQQXR7S6Wc+7X1vDEUY+EVHmoSQJLnMEyBfvsYXyvX+CfvdjuL0IX
         JKNocUb8sbRL5HhWB5v2uRjPh/BnW2w/IT0T1d7eIVHkcz1ZqBjuQKUInSGl0qRVU784
         ju0jP6q3CcC+VCo+uKs6+WUuOhYtz5Acczffw6BtveqB6OszgX/Rr5NMjxePCbRusWxP
         1Yer+Nkm6Ag/FKhDh0ORXhZfAJcwSsmysYyu3iRSapwFe/ZA4oTS8z4cevH7ZFn4VVJN
         nYjw==
X-Gm-Message-State: AElRT7ECZy21KNpYYCWShP8ke18eYYBGouCVs3BCLmT+00ORqSFyjiLe
        dR83pPTxpN3q8jQICmhw5tdrdQ9G
X-Google-Smtp-Source: AIpwx48/1WjbCJSXhrw3NBRtOVgoAGmpcAXnILVviczMXQ068+R1PJ4CC4A7s0QhkAHk6QC/UWZhtA==
X-Received: by 10.223.158.208 with SMTP id b16mr978077wrf.274.1522195859969;
        Tue, 27 Mar 2018 17:10:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u143sm4011611wmd.46.2018.03.27.17.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 17:10:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] test_must_be_empty: simplify file existence check
References: <20180326124847.GA21993@sigill.intra.peff.net>
        <20180326131124.13003-1-szeder.dev@gmail.com>
Date:   Tue, 27 Mar 2018 17:10:58 -0700
In-Reply-To: <20180326131124.13003-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 26 Mar 2018 15:11:24 +0200")
Message-ID: <xmqqd0zp9i0d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Commit 11395a3b4b (test_must_be_empty: make sure the file exists, not
> just empty, 2018-02-27) basically duplicated the 'test_path_is_file'
> helper function in 'test_must_be_empty'.
>
> Just call 'test_path_is_file' to avoid this code duplication.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>
> The only change is to refer to the right commit in the log message.
>
>  t/test-lib-functions.sh | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index d2eaf5ab67..36ad8accdd 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -718,11 +718,8 @@ verbose () {
>  # otherwise.
>  
>  test_must_be_empty () {
> -	if ! test -f "$1"
> -	then
> -		echo "'$1' is missing"
> -		return 1
> -	elif test -s "$1"
> +	test_path_is_file "$1" &&
> +	if test -s "$1"
>  	then
>  		echo "'$1' is not empty, it contains:"
>  		cat "$1"

"Just call it" is fine as an idea but

	A &&
	if B
	then
		...
	fi

is somewhat questionable.  Shouldn't we make it

	if A && B
	then
		...
	fi

instead?  That way, if we ever need to add an else clause, the logic
flow would be more obvious, no?

