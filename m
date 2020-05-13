Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1205C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4948D2065C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqcJH+R0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390480AbgEMTjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732218AbgEMTjx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 15:39:53 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDD4C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:39:53 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id y10so242544uao.8
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E403TGj40EJkXN6khFrfiirjl8TXUYwwNRsGgr+S8SQ=;
        b=ZqcJH+R0qlDogUO/Js+1BLioDvJA17XFa2K7KDI2OWFf3+GARq/KC5lGh5UJ/dGU1F
         CXa/YBOuWY9rs1gkAEbgjcmMPVr5L2hOkNA1CYA7gKA7oW+jjTDqcFsIQla+TZ0dxTIZ
         ueAeM0nccyOgydlAVCa5hMydkaWvFcW/WyNaOfGMLcE1RhbrYKszIWNUfF6isEu2M8Im
         Jk3TI8j3LPuZCLJmRPoA1WCcVQTYIa1HR1YYNtHI4rtjoGzwboK1D2+7/2/G5fcj4Whj
         uNyegL0OwTFHfJBkCO3OAyNfOU00PvTLn9OjZGSsoSpKy6pEEppRuVlxxrAcM61oHgaX
         WkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E403TGj40EJkXN6khFrfiirjl8TXUYwwNRsGgr+S8SQ=;
        b=ta6a9R0XUAXp/zPeBCW4g1E1S/liu+KMZ9D3Vr8B3C2OUP4TzT5eS7W5wuD3qNx2ME
         HYBHkIflB83gPmRdDmuaujtLLT1Y/71JkcR1bF9a51J6uE7I0sutnvEyUcPlvmVtjZZW
         Qv54PO8C9jFPMn2YAwYzoxR29B/7COLGvbNHYXvPx5SIsc8S2tQ5ToqMA6pbP+rs+S0J
         oUdlH/LwzxgTcRZklIyc2RnldbmCckRiGiCEWEnlPhtcayl2TqSqnJTS+pZCihAzliPr
         T7Wo7fahcwpgLwDyzbriocK3KZR4bR4EHK9RbbNj7/q0xe5ZYuAbYpPudmcKw0a84ES6
         lr9Q==
X-Gm-Message-State: AOAM531gG7e4p8MJag6c0+5dAJNPXK/SE6+6tIsc0v5OPiqoxwiRVKmN
        XZA0TKE4Lp3iGpMVKRKLssGzGZGp9gh8+pbW53k=
X-Google-Smtp-Source: ABdhPJy8L6KXAOj5hvOxqAWsIgtpbuNdoHCA4UpEahX5BCFzyYQ9ATigmGegTEqpc6cR/v7d7wnrlYdFLu5oWOVbGrw=
X-Received: by 2002:a9f:2508:: with SMTP id 8mr1123030uaz.115.1589398792399;
 Wed, 13 May 2020 12:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-11-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-11-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 13 May 2020 21:39:41 +0200
Message-ID: <CAN0heSosiP=vCcd1QBmWNsVUuHTmRJbjGrWV9tU0=BSU1ENmDQ@mail.gmail.com>
Subject: Re: [PATCH 10/44] connect: add function to detect supported v1 hash functions
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Add a function, server_supports_hash, to see if the remote server
> supports a particular hash algorithm when speaking protocol v1.

> +int server_supports_hash(const char *desired, int *feature_supported)
> +{
> +       int offset = 0;
> +       int len, found = 0;
> +       const char *hash;
> +
> +       hash = next_server_feature_value("object-format", &len, &offset);
> +       if (feature_supported)
> +               *feature_supported = !!hash;

If we got something, anything, the server supports this feature. It just
remains to see if it supports the exact algorithm we're after.

> +       if (!hash) {
> +               hash = hash_algos[GIT_HASH_SHA1].name;
> +               len = strlen(hash);
> +       }

OK, if the server doesn't say anything, we fall back to SHA-1. If it's
the desired one, we'll return 1 accordingly below.

> +       while (hash) {
> +               if (!xstrncmpz(desired, hash, len))
> +                       found = 1;
> +
> +               if (found)
> +                       return 1;

I first thought this structure was because this loop body would learn to
do something else later in the series. But this is it. This looks like
it could just be "if (!xstrncmpz(...)) return 1;" and drop "found".



> +               hash = next_server_feature_value("object-format", &len, &offset);
> +       }
> +       return 0;
> +}

Martin
