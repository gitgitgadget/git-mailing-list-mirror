Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35BDA1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 20:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBKU6i (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 15:58:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40046 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfBKU6h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 15:58:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so659444wmc.5
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 12:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kj8LekdmTZOD7trB1WeWaA92ks86m50poGZCvgoRdMQ=;
        b=sMminIfCJa8vWWfWZ2JT0MgIuNOfaSgyEc7DFEj+jQR0viaEGvz76Lg0LRwJOTsDLa
         gLK8VTXsPwz0cUWHoP9aVCOr46N04zdhsejJiax6yIEtGKyoo/39ZHzIWvdD+MBQmkM+
         OZ2cv1Twc4kgIcPZVjYl1hj8sDVwGsLGc3GMs964DvELsK/owd3ByC0nBKKXywLQZzLR
         xX9csn2BsklLmKmrjBguNEpMtCdoRadTjRG/9pL7umeHUdNUIr5w7lr3GGdlT/gOV5TU
         vtqCK7no3HQnT3U2oiTi0lIzmSc4Qg7IjZqOwTh+klfjKovvHAnYhqvzpbZc6JFRxBJr
         waYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kj8LekdmTZOD7trB1WeWaA92ks86m50poGZCvgoRdMQ=;
        b=RdYGKsDGnlfO18BFcRsqNfYUqREuU9b2tt/u4vAgHCqpMIGv+pHH7rNzuviCkg+IJx
         JXefu6hwxCZ85QBHrvuKfGg5FhkcltyUqAKH5UtkCbH+f/KRv8jZkLlRiv2ql+03fLJ+
         4UZ6NmCizVIFh+BDPKxaQRb/pQ8U6T/cSQhxvjalNdQYS7864/JYl2i4kLyjEZ8sSybh
         xNroS/HdcO/+jsxO/Q/iY1tknpWFgWTWy0k0em4XMkB2rijDGff65UmthkAmJItOvOOS
         ObA57Sx/x16kWYv6lyJqYuQQNZ4ABkFpI4fc/W51qehz9QZXCACVHIjkE4m0C92ktS7U
         VU7w==
X-Gm-Message-State: AHQUAuZvBPepbKouQT3kKsP5k+EslqMOmHr23MSSphrBxBIifsAcONd0
        xiI2KSICslbccbKBKSnrHv0=
X-Google-Smtp-Source: AHgI3Iby7LjNKmk78u4hLmilrmEM21ChLZuX+VN7QhTr1/PqrvsN9SqqjpkwukkYz/azK3uqv0yUPw==
X-Received: by 2002:a7b:c315:: with SMTP id k21mr92174wmj.145.1549918715820;
        Mon, 11 Feb 2019 12:58:35 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x81sm666786wmg.17.2019.02.11.12.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 12:58:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Fix v1] config.mak.uname: add FREAD_READS_DIRECTORIES for NonStop platform
References: <20190210002016.22556-1-randall.s.becker@rogers.com>
Date:   Mon, 11 Feb 2019 12:58:34 -0800
In-Reply-To: <20190210002016.22556-1-randall.s.becker@rogers.com> (randall
        s. becker's message of "Sat, 9 Feb 2019 19:20:16 -0500")
Message-ID: <xmqqk1i6ghz9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

randall.s.becker@rogers.com writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> The NonStop platform needs this configuration item specified as
> UnfortunatelyYes so that config directory files are correctly processed.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)

Thanks.


>
> diff --git a/config.mak.uname b/config.mak.uname
> index 6bd67eb86..75ff43f1f 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -490,6 +490,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	OLD_ICONV = UnfortunatelyYes
>  	NO_REGEX = NeedsStartEnd
>  	NO_PTHREADS = UnfortunatelyYes
> +	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>  
>  	# Not detected (nor checked for) by './configure'.
>  	# We don't have SA_RESTART on NonStop, unfortunalety.
