Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64202C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 13:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0966121E
	for <git@archiver.kernel.org>; Thu, 13 May 2021 13:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbhEMNNI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhEMNNH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 09:13:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BB6C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 06:11:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h127so21690894pfe.9
        for <git@vger.kernel.org>; Thu, 13 May 2021 06:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3byovkeg/JCgizr7zQ1rLB6JbTvyF4MI9pkCb4CRhCA=;
        b=e7cQh+4cpvEvLx+FD8iNsajIKaw78wzwHvCY5Uq8cAjPnS4TyYl2SESHhlNJ46y4Sq
         TwlAGL5IRViqr80my5Hsgk9geRu9wosJY8t3lcSKwO7w3XGcahZyQKmYjiVAZBKT0zWS
         EcPTioxjmck4qh+YO7Y0w/gjtKI38KHL3E4gKopplzJbUSbORZPpGFFt+E5kMQrfQ3jj
         rsTyAV7gXvlqEFYBDHzQNNLEXv6CK2BQ5xdASDzJ5+1rYAJOkL1OAlNpsUq7QR/rgOTk
         pHHwYzy9g/g4iU/DiX4bvc4WMJSEO1fH9Pb3NTXAWe4sTMGe6f8a3Bu1mS8JsVg5Ssvh
         7EWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3byovkeg/JCgizr7zQ1rLB6JbTvyF4MI9pkCb4CRhCA=;
        b=eLVSITSpl4GjY8DF7xW0nu/SZfzjP3gv8lzjrpjsT6YbQrJmu/Vo1kyUw8iMaqh4v0
         /yu0fDIF39CXdXeW/0sO9QYJ0HvvM6P3zWGJFsmwqYAyekEcuIdD4f9Nttqv+gClNrnw
         vrhR2ZKVTxaxEq1cK/8pb+CnyLctPLq4vk9oL0iOHXTHbNjgG08eKXKxnHIprr8X+bHc
         +QTFp394MTh7hmZ0dV6wCO919KBKNdDs3A2ck2Lr5QEVqa0dGI//sKUT8seHDzqPP86z
         BuznFuLdERWqDLmzQRLLjs9kyvQ5hswiyTPxRD2fPef6SccwQR1xH6/ZytNVdcZMBxRA
         JWYg==
X-Gm-Message-State: AOAM5325OSMtKMV7S/PzNgxHnm4DJhoHRA63ISKKCLa9ZyStNaNygw/k
        xZNF9XUkX08b3csqgp1b37E4L09HdyM5W+q0RqE=
X-Google-Smtp-Source: ABdhPJzwcD6CuwSLj4zLor0O3HoxcffiR0SC+iroYHWkqGTQw2/7Bz1dl/RS90W6IAQ2sNZeZeg3bMC1FVKAUsiHXuk=
X-Received: by 2002:a17:90a:9312:: with SMTP id p18mr4976415pjo.171.1620911517736;
 Thu, 13 May 2021 06:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <609b2828309fc_678ff2082@natae.notmuch> <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <20210512021138.63598-2-sandals@crustytoothpaste.net>
In-Reply-To: <20210512021138.63598-2-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 13 May 2021 15:11:45 +0200
Message-ID: <CAN0heSoQDv_fA+g7SVYDhp7Cv3nx1sYXDOWJ9cC2EiZ42Wv6VQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: remove GNU_ROFF option
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 May 2021 at 04:11, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Additionally, this functionality was implemented in 2010.  Since nobody
> is shipping security support for an operating system that old anymore,
> we can just safely assume that the user has upgraded their system in the
> past decade and remove the GNU_ROFF option and its corresponding
> stylesheet altogether.
> ---
>  Documentation/Makefile               |  8 --------
>  Documentation/manpage-quote-apos.xsl | 16 ----------------
>  2 files changed, 24 deletions(-)

Thanks for dropping this cruft. There's a blurb about GNU_ROFF in the
top-level Makefile as well. We should lose it here.

Martin
