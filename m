Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38AB41F453
	for <e@80x24.org>; Wed, 24 Oct 2018 03:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeJXLtM (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 07:49:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51603 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeJXLtM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 07:49:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id 143-v6so3721950wmf.1
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 20:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=k/VUCT/KI5Tg3mSp8NuoNSDfVAbxCLhhKnDwBQS9gws=;
        b=CH8Fue9waqV4sjlmWVNtcCBMQ41bC65wbLPspqznAm1QICmKd91aw3spRH60EWld8q
         CaAG1y8P9W3+n5A12eOJWR2M6ctRQSmLbndocunS7KP4c9to1i1Erm1yG/usAPFNGsc0
         MXKYTs85nc9wuQuDpUqdtKgOK2iuNo/RBusIBSvmMIbFiamwtwQGy7P5dNlef+V7Ql9u
         jJ+zvuiVtnMz+qAAqmcFQIrGyGa8X5foj5wPXg+d6AmfE3nfUhw6bjnt+wV0lQWRfFqU
         HYkWyrFrjqNPq/FTvyn/S8++mQJy95VVRyRUsCUZSdBrwMqLPiSeaR+cR+EgSr3/MQ+M
         esNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=k/VUCT/KI5Tg3mSp8NuoNSDfVAbxCLhhKnDwBQS9gws=;
        b=rnc8zG3rmjqPL6yUolOXvTWN3g321xzBcmYQkvz/w7sHjEaeASdYV2bHYCzBtIsO/O
         7wgbnB7uP8IJom14kpzpAOb7cQJo2Xduv80Nii1yrr0wJpj7MEXZKFHEXYCZdc7JAGW6
         3vgAvYWr4ZtP0cyFxVAoxO0IBvoMNe840t9jBErdihVAEtsi5EAnWD89d1Fq8UGZzS9T
         eN0bRsssa3Lh/Iv+6lc3t5Qd4lvxQahbO1nMEHHIsiBZrp1PL3wqtl+DEd/TJLc8pcUC
         wcaYRfN7z+ze8VTRwvdITIH8bQR+fpHjG5RN22mn49K+ApfvuCg1jIwR+yGjOSGifgVW
         TShw==
X-Gm-Message-State: AGRZ1gK8Ntj0uWekQaVQm5QjnmMLQy8J2hthqdZSt+jQogEEmGak9/t1
        RZsSqg+Ptwygji9UZ25VOinym9ZLst4=
X-Google-Smtp-Source: AJdET5eITi7BAdPqNQtijsxp/u/Rkr8MqMqjKnvQ8iKcqxW2pAN9XT48yc4Sw3+UXIfAty9HG0NtzQ==
X-Received: by 2002:a1c:3307:: with SMTP id z7-v6mr443867wmz.115.1540345438937;
        Tue, 23 Oct 2018 18:43:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z185-v6sm5156562wmz.47.2018.10.23.18.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 18:43:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] compat: make sure git_mmap is not expected to write
References: <nycvar.QRO.7.76.6.1810231212190.4546@tvgsbejvaqbjf.bet>
        <20181023123519.91317-1-carenas@gmail.com>
Date:   Wed, 24 Oct 2018 10:43:57 +0900
In-Reply-To: <20181023123519.91317-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 23 Oct 2018 05:35:19 -0700")
Message-ID: <xmqqr2ggqftu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:

> in f48000fc ("Yank writing-back support from gitfakemmap.", 2005-10-08)
> support for writting back changes was removed but the specific prot
> flag that would be used was not checked for
>
> Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> Changes in v2:
>     
> * reset-author to match signature
> * cleanup commit message and add ACK

Thanks.  Looking good.


>  compat/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/mmap.c b/compat/mmap.c
> index 7f662fef7b..14d31010df 100644
> --- a/compat/mmap.c
> +++ b/compat/mmap.c
> @@ -4,7 +4,7 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
>  {
>  	size_t n = 0;
>  
> -	if (start != NULL || !(flags & MAP_PRIVATE))
> +	if (start != NULL || flags != MAP_PRIVATE || prot != PROT_READ)
>  		die("Invalid usage of mmap when built with NO_MMAP");
>  
>  	start = xmalloc(length);
