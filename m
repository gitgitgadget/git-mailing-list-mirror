Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A940C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 10:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A45522D6F
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 10:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgLEKnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 05:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgLEKlN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 05:41:13 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9155DC0613D1
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 02:40:30 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id k4so8542695edl.0
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 02:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpivx86x63Il4TRWdS0VHO4XhK4aZPiVmPpdbEh53So=;
        b=sYSF0DhPwl9GKX/BkqCC9ks3Zpg6rjsjSi5mST5yxPE2++Ofk2rXTXbYqcS6FSrO3W
         2ApkDzt26zdF0Y0tsggCO/umMBYyLngrQ/wqWOXWpSBQM3TOvzr8cNBjVnzg1Jhm3g78
         x6pV1acNIGf6XMKMiw+7r12JsHEF9IO77gTLDt8RphDQHW3nvLrFaopyFCheX9TqSo4k
         U48kTuPnna1o0wn8Jj/pkg8B0fLyMO5isRqDh+Iim2dcxtjPL2i/ukqdQ5k25H8O7ZXk
         DCTOTPNrCS/F7PEt275vEzh8pbUmN64nXf9+XP8rKaznpjArHRyghDm/kDOMAMZebmyW
         LikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpivx86x63Il4TRWdS0VHO4XhK4aZPiVmPpdbEh53So=;
        b=CY6ihM+4W4HtYYAgU3Ua8qgKMytklxQslb48MxO8QIZSVbU1iwdtNKuFtU4ncQ2kda
         HJwTuAhUn/4qVVaN58vSsH3MzCkh80WIgS6/VJIB1I6uGkINryEbErwACGtILlCgLVxD
         2lStxYYBSri1ken5nuT4TFQObymuA88XINZnaoatQey7go/YyJ49yAU4SM0S8dzbNisF
         HTUdba0iEfn8TOq9KKhMaTxXfXOIB+HDOZ4aEpRpxhs4xmgyVY6ZNGk/m31J7L4qXatC
         Px9i/j8I3Jn3/EECKgwuAsT///zDPBh3BBWgPcnAawXn57aqr1qmjMFvV+rQ9qlbm8cA
         xujQ==
X-Gm-Message-State: AOAM533i2rcJQO0t/EsExneb3dIrivn16joJEaOy3nB9TyTLJaoNtaY7
        /tUdqkpdMVL1ocB0qS73BpjgQNI0xV90AptKA+E=
X-Google-Smtp-Source: ABdhPJw/bKzioxo3YGIrkr1xHZoNj4sxFXoYKsV+u9n9QiYJuRNXUzLAq8BcA33XDEvce3vA1Y4OWiZgIph3M/MJbCU=
X-Received: by 2002:a50:8a8e:: with SMTP id j14mr11735400edj.87.1607164829355;
 Sat, 05 Dec 2020 02:40:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br> <2726f6dc05c319e2baaf76a05d62426e0695fe65.1604521275.git.matheus.bernardino@usp.br>
In-Reply-To: <2726f6dc05c319e2baaf76a05d62426e0695fe65.1604521275.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Dec 2020 11:40:18 +0100
Message-ID: <CAP8UFD0Z-EU0=9qz8wYt4MSFqqmoDKnMxTbqgUJNVOR+qUZ3rA@mail.gmail.com>
Subject: Re: [PATCH v4 01/19] convert: make convert_attrs() and convert
 structs public
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 9:33 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Move convert_attrs() declaration from convert.c to convert.h, together
> with the conv_attrs struct and the crlf_action enum. This function and
> the data structures will be used outside convert.c in the upcoming
> parallel checkout implementation. Note that crlf_action is renamed to
> convert_crlf_action, which is more appropriate for the global namespace.

It annoys me a bit that some things are called "conv_*" and others
"convert_*". Maybe we could standardize everything, but it could be a
separate patch series.

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> [matheus.bernardino: squash and reword msg]

Not sure we want the above line, which could actually not be
completely true if you rework the patch before it gets merged.

> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>

> --- a/convert.h
> +++ b/convert.h
> @@ -63,6 +63,30 @@ struct checkout_metadata {
>         struct object_id blob;
>  };
>
> +enum convert_crlf_action {
> +       CRLF_UNDEFINED,
> +       CRLF_BINARY,
> +       CRLF_TEXT,
> +       CRLF_TEXT_INPUT,
> +       CRLF_TEXT_CRLF,
> +       CRLF_AUTO,
> +       CRLF_AUTO_INPUT,
> +       CRLF_AUTO_CRLF
> +};

Maybe we should also prepend "CONVERT_" to the values?
