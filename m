Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27661F453
	for <e@80x24.org>; Thu, 25 Oct 2018 09:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeJYRfy (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 13:35:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41624 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeJYRfy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 13:35:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id q7-v6so8437901wrr.8
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=N/DyumksOmm7NylMhGQKim/AcksVWFTmPXT3r3bDEb0=;
        b=rcH0ypNAJUhFm/uTj11SctwX4Pw40MqV8j0Hv5WEle4wgxVLL2CvAlgFUvt5NqpLU2
         s3wXjNJ0lP6ey7kzdMShHRWlTxQmBsBmqQi8sRpW2kl1QZnMOGC0D7QN2Bfa68VlTgDU
         lM39lVkPWb08rkWVKX8LOjOh0wv9Wy3UKgw7i81G75s2uLibgzNtlXfijjW7fWFkSLb9
         iuEhqqeZP/r4SpFXuYZeOrj1w0JBBW9X5xhEOkC/TKqrOLof2THuDak3vUJH3DSsT0mu
         0/JWJkHgd6cCbtXawbgIDLy1TQl3eLi0SafiAnTAv03tSsXLfDUW2fOn+7k0ubUgMqBO
         L1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=N/DyumksOmm7NylMhGQKim/AcksVWFTmPXT3r3bDEb0=;
        b=iq5aWThjnEIpkvziADvmHCNWZoNIo9646ZHp8wJ3Vh1wDo0SBA8WJtIdCUeV3Vn3rm
         TMuwy8EVPfaFieTdLHDfDpHeDV0OeWBYTs6Kp3dwY6kHtoAt/pQTjwmDwjq64Nzps4GG
         fOSvYXktlOMBIo3F7ttV2Zq8jaau+aVPVG37zyyyBm4DcFMKolZ3NSKcEZm1YKmuvniW
         6aut8utE4ktfpWpaz9GTqe14zJL5jOO8+NxlgE85Q3QTjFAGevmKuHbaecJgGd9+tT7G
         ITSXjEUpPLkbfNcCeGgI604rZxn0fZIG1KTcu1T055lrniP7Jkz8BU1D8IRJCg42KvQ/
         4f4A==
X-Gm-Message-State: AGRZ1gJyi+K2rOBXRfHdShfCeCVyGtCaGvlLFKabXHqYfxoypIspczT8
        Oj+V4rZStoF2yYA7xPwE0uU=
X-Google-Smtp-Source: AJdET5fsKnIKeU1F9XhIxvgGvZ3nMu9XkR0ivHnACL5Gi3Kry4le832fRcnQ/xySrH4ig1DNaXcq8A==
X-Received: by 2002:a5d:4086:: with SMTP id o6-v6mr990387wrp.133.1540458243280;
        Thu, 25 Oct 2018 02:04:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q77-v6sm611713wmd.33.2018.10.25.02.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 02:04:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: be more precise in parsing v2 response
References: <20181019225404.34496-1-jonathantanmy@google.com>
        <xmqqwoqav8g6.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 25 Oct 2018 18:04:01 +0900
In-Reply-To: <xmqqwoqav8g6.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 22 Oct 2018 14:47:37 +0900")
Message-ID: <xmqqpnvygzy6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> +	GIT_TRACE_PACKET="$(pwd)/log" test_must_fail git -C http_child \
>> +		-c protocol.version=2 \
>> +		fetch "$HTTPD_URL/one_time_sed/http_parent" 2> err &&
>
> Because test_must_fail is a shell function, the above is not a
> correct way to say "I want GIT_TRACE_PACKET exported only while this
> thing runs".
>
> I'll squash the following in.
>
>  t/t5702-protocol-v2.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 51009ca391..d58fbfa9e5 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -555,7 +555,7 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
>  	printf "/acknowledgments/,$ s/0000/0001/" \
>  		>"$HTTPD_ROOT_PATH/one-time-sed" &&
>  
> -	GIT_TRACE_PACKET="$(pwd)/log" test_must_fail git -C http_child \
> +	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" git -C http_child \
>  		-c protocol.version=2 \
>  		fetch "$HTTPD_URL/one_time_sed/http_parent" 2> err &&
>  	grep "fetch< acknowledgments" log &&

I know it only has been a few days, but is there any other issue
in the patch, anybody?

Otherwise, I am wondering if we can move this forwared after
squashing the above fix in.

Thanks.
