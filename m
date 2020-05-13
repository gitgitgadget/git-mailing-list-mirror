Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94142C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE2F20659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkBvogk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390522AbgEMTh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390185AbgEMTh3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 15:37:29 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16310C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:37:29 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id y10so239526uao.8
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uf2MoBnraJzNinuYdHRmD3rAZmo+cca8grY1eBCt6vQ=;
        b=nkBvogk/NwK+X1wRe4vGeHBSdmY/nVn3pkmdSEnR7o7ojmb9YzUNaxdXUkfXH5jNCx
         yIxjueO/8HjPIxGr4pgYVkRujEJV0dJlHfkFgFjmn6LlA1bgwJTKupmL39wKoRHWVj7u
         UePGUFgNNPKZpwnAw/r7Sa1jDrdfp1mx5LvD867Me3dhdtJop84uPSHGHyBmIedtnOCY
         6mnn13OGoGilHai4CgBmflV6uSZNSHbpyN3FrEkyKt5IMfTELHszLG3LdWljRGP+vWg2
         SdiyuHqJii1bl08IUMi3tNmO5Kgyiey8K7RaFA++Fp9y93c2IZI6aEs5QAcvSE3cTAP8
         0a2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uf2MoBnraJzNinuYdHRmD3rAZmo+cca8grY1eBCt6vQ=;
        b=YAWh3Bpo6affKIcgg2w+sMd2gZJFX2rSA5c5wInB14tsO3uHjqBnTRsB3cKv9htQEv
         IBFhUfe0zVItsl4F3CGWSE6vwJzJWaTdk/8/BXLzBYH6BipDs1ricRJ+bVIZGfFDqhD8
         1Xn3uR0TD6/bL3Gl5mEJuIVrI3NvacsVRIBXnMeqHGtRn1UMCzWrq09TPSQ0SGqR4XuQ
         vI411R/1ckJftGiyhualuQJX5/Er5j4JKOtClvQShpQJPCu2hLKFmv3isdjP/zy7+7TJ
         IP0qfAaN0JyrBwaYsyeFk8mlfTi3PGJNYKHFEk4HQUkWejiICaiTh8luiB/30bqVvhL6
         /iVQ==
X-Gm-Message-State: AOAM531x1JTjLvzXUHEv4q1jzKUGLBjQ4LiB4D3VDqn+o1AuQLe/hV2Y
        ZNXOy5Vk8QexI+LiH05/X/uvEMzmBGqkIUFJROR/stM3
X-Google-Smtp-Source: ABdhPJzEwa8xBd6Zp4oQP3m1B1mXOEti1x0tjwUulzrRzY3d56V2Tysxzo7DkWGhI4lwtFmaqNhG2D9ZKH5cWw5USTc=
X-Received: by 2002:a9f:21eb:: with SMTP id 98mr1145950uac.62.1589398648182;
 Wed, 13 May 2020 12:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-8-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-8-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 13 May 2020 21:37:17 +0200
Message-ID: <CAN0heSq1ULyJE6FLsNMc-V+J1ke8ZqyVF-MghK_d+0i7SSfTDA@mail.gmail.com>
Subject: Re: [PATCH 07/44] connect: add function to fetch value of a v2 server capability
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:58, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> +int server_feature_v2(const char *c, const char **v)
> +{
> +       int i;
> +
> +       for (i = 0; i < server_capabilities_v2.argc; i++) {
> +               const char *out;
> +               if (skip_prefix(server_capabilities_v2.argv[i], c, &out) &&
> +                   (*out == '=')) {
> +                       *v = out + 1;
> +                       return 1;
> +               }
> +       }
> +       return 0;
> +}
> +

This looks like it was based on `server_supports_feature()`, which
explains the "1 means yup got it, 0 means no match". The name of
`server_supports_feature()` does suggest the boolean nature of return
value. For this new function, I would perhaps have expected "0 means
success, negative means error". That said, I'm not familiar with
connect.c. Let's see how this is used...

>  int server_supports_feature(const char *c, const char *feature,
>                             int die_on_error)
>  {

Just a thought:

Maybe this existing function could learn to take a pointer (or NULL) and
assign to it if we have a '=' (possibly even requiring a '=' if this new
pointer is non-NULL). I dunno, maybe two similar functions are better
after all than having one with modes like that.


Martin
