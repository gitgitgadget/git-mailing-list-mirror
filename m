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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73215C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 11:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416DD22D6F
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 11:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgLELMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 06:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbgLELLh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 06:11:37 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE0DC061A51
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 03:10:53 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id c7so8553905edv.6
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 03:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pXOPpQ+3YEfOH1SaRa5eiEMP44haLlw9Bgjs2ngBKuI=;
        b=b6G8MuBRlHiPk0WrsLi1rep/m1L8lnDw/35dgJfc71QKhzLGkUamCqukKP0W11Bb80
         t6DBKQun3AeJxgrCYEe/T4uwzMftV/ChXqBWPh2KIW3oJFLhObwgslSiGvydf321KYLI
         ciGG4Wc9wJjSIQXDqCFYZL0Pa4N+GLDfVLcisg/ewaukR6IYj1jHR3VYDTij66JI792J
         sjsNxv2d03JbgpLN0wcuXqgrR4HApbnjpcG35jD3OB2kdafORq9pqHdWyAhImcVXP+uj
         bcT+EO6kEmLDIyIvOWcYsEwI/Qo9W+kFH+jgv+BO6biAovkEzY1EtPZcQPd0nPZ7gDm/
         28Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXOPpQ+3YEfOH1SaRa5eiEMP44haLlw9Bgjs2ngBKuI=;
        b=E7mQpPXc/1WoEdv6K5aFCMR1Gdye9eOH02LBfdvnaILFbvDpGmv+zSx2ryqoL2HucS
         6YpXFUHFG8VYK5/6gXq6/EemVoWeORg3jJN49NcLp6L5hlv5Wh//2sGBK5CkYAkz0tN7
         kZQgG5/gkVVWC9xtPwU9cyAuvGpHXG7eBKHniQAlRgmT7dfM4OT89srY8xDFkXp56i/h
         IKbxOyP5XqAoa92j+mEc1qwJqfhFBEVmlXKEVXTupunw9YgufvhGjtVkQKHkSytmrsvY
         Z4MW2m9+/Qa1QPlzmkavsPaqY5Gj9k6pPGBqhK1z7K4DcLxpyjYga1nWEDuQ3HeQqrnC
         nm4Q==
X-Gm-Message-State: AOAM530NodRptJMeq0RPg3+QA9pl/1cTZs8gc3ZnzE3+iJE8FxgStdoo
        xeQuIlQ68fbxGg2SLvZb4S5N3aIWu8PCxt6j2BY=
X-Google-Smtp-Source: ABdhPJwJO8fgcE8Wg6vGfrTh+MxXP6M43V/CxNKJ0tndmi098TsXVOr25NFEaD5b5KdmevWyibi13fDiPKCCeMyVxks=
X-Received: by 2002:a50:8163:: with SMTP id 90mr11576334edc.142.1607166652603;
 Sat, 05 Dec 2020 03:10:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br> <fc03417592c25a111fbf77f9e5b9e5468b9070ae.1604521275.git.matheus.bernardino@usp.br>
In-Reply-To: <fc03417592c25a111fbf77f9e5b9e5468b9070ae.1604521275.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Dec 2020 12:10:41 +0100
Message-ID: <CAP8UFD398EON0OpfQ0=bgJhO-0r9f1Z7LQRj+rKLp9pEwUnxHA@mail.gmail.com>
Subject: Re: [PATCH v4 02/19] convert: add [async_]convert_to_working_tree_ca()
 variants
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
> Separate the attribute gathering from the actual conversion by adding
> _ca() variants of the conversion functions. These variants receive a
> precomputed 'struct conv_attrs', not relying, thus, on a index state.

s/a/an/

> They will be used in a future patch adding parallel checkout support,
> for two reasons:
>
> - We will already load the conversion attributes in checkout_entry(),
>   before conversion, to decide whether a path is eligible for parallel
>   checkout. Therefore, it would be wasteful to load them again later,
>   for the actual conversion.
>
> - The parallel workers will be responsible for reading, converting and
>   writing blobs to the working tree. They won't have access to the main
>   process' index state, so they cannot load the attributes. Instead,
>   they will receive the preloaded ones and call the _ca() variant of
>   the conversion functions. Furthermore, the attributes machinery is
>   optimized to handle paths in sequential order, so it's better to leave
>   it for the main process, anyway.

Well explained.

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> [matheus.bernardino: squash, remove one function definition and reword]

<rant++>I'd rather have "Reworked-by: Matheus Tavares
<matheus.bernardino@usp.br>" or "Improved-by: Matheus Tavares
<matheus.bernardino@usp.br>" than lines such as the above
one.</rant++>

> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>

> @@ -1447,7 +1447,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
>         ident_to_git(dst->buf, dst->len, dst, ca.ident);
>  }
>
> -static int convert_to_working_tree_internal(const struct index_state *istate,
> +static int convert_to_working_tree_internal(const struct conv_attrs *ca,

It is still internal, but for consistency it might be better to add
"_ca" to the name of this function too, as we now pass it a "ca"
instead of an "istate".
