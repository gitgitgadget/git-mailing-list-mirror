Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A11C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 10:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350C2206D8
	for <git@archiver.kernel.org>; Sat, 16 May 2020 10:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKFQ24jT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgEPKs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 06:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbgEPKs5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 06:48:57 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8279EC061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 03:48:57 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id o26so2770500vsr.10
        for <git@vger.kernel.org>; Sat, 16 May 2020 03:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNaXgXPIlb23kpFsk5k7CV+QPIuJ5MBKLdZ6/ICjqBc=;
        b=HKFQ24jTUr80FmjPlTDfbuz8XLqQreFC3HlOWKVX2Lr4XTxqv1Be2mny4SVebHPGP/
         Ga5ZzvLAR4FwuMZKZURaded73bQIE1wgcOwOXQHf4HxClClH1CE9YGWtVNUyEw468tOA
         hktWdjx/UtahsW1CmCeltdc2K1yYSRoVKv+2RHkwrX2e0Y+stzLCki2WJ819hk8QCn+I
         1YjYZLyiq0UQn4dak+nzhfc+RKSLhqkjzBcobi+syiQNQ4JZ3kZ0klsUgbUAvFxXpjbH
         onOPDS6bVfc44+NlfL/4uGcWHE+S6L48UpBOcs+2VRAenqJGRll1Sm2cIb4XKr/1ylnb
         0mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNaXgXPIlb23kpFsk5k7CV+QPIuJ5MBKLdZ6/ICjqBc=;
        b=CZuqWPCeNkzo2Xa/0PIqMqurGONEc10271gg8w6kjMIlCLem1q9oKHNmfQLBBbN1O0
         jP/gG8Za6vgSI80eVICkYqf5g6Zf8w5Q/ck3ntT6b5dnnqlRM65I9aA4wgowORfJJfbt
         CPvWuTXMlpBuY2htU/m0fA/pp6b4GX8/6MH+sCGs64eVR96F8283Zvahcy1FowiOf9LR
         XskaxYkrmM137nTEynvnnXpJHtvyW1UQwSLYkjHehRjfcmbb58L1l1xV0zzWebvIZGeq
         DrDleKvnIak4piEI/ENU0JYCtljCuIMZrXQBNPOMTiuLisrdxOZH0TsHKoIsy3FgL1KR
         U/rw==
X-Gm-Message-State: AOAM531WkYQeJhbO1f9vM+e+sj9C+enepnKdpS03J7nTAqN8XNtmddq0
        IW1/n2m3UeUoKIyqCbHfny8PEEBVk+UjTeya3r6luQ==
X-Google-Smtp-Source: ABdhPJxLpGjQvT4lEgn7POa8p4SJaFBtMs3RX2EO0Lp54fvx5Tgn18EPmt0FGQTVUlJ9RNTDAoGKSLMzLjWYoYnkiVw=
X-Received: by 2002:a67:e096:: with SMTP id f22mr5532634vsl.54.1589626136641;
 Sat, 16 May 2020 03:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-20-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-20-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 16 May 2020 12:48:45 +0200
Message-ID: <CAN0heSquFyhHQMiiGkkLfcZVFZs1SNV7QDhTjPY38rjy7sejXg@mail.gmail.com>
Subject: Re: [PATCH 19/44] builtin/clone: initialize hash algorithm properly
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:57, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> When performing a clone, we don't know what hash algorithm the other end
> will support.  Currently, we don't support fetching data belonging to a
> different algorithm, so we must know what algorithm the remote side is
> using in order to properly initialize the repository.  We can know that
> only after fetching the refs, so if the remote side has any references,
> use that information to reinitialize the repository with the correct
> hash algorithm information.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/clone.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index cb48a291ca..f27d38bc8e 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1217,6 +1217,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>         refs = transport_get_remote_refs(transport, &ref_prefixes);
>
>         if (refs) {
> +               int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
> +
> +               /*
> +                * Now that we know what algorithm the remote side is using,
> +                * let's set ours to the same thing.
> +                */
> +               initialize_repository_version(hash_algo);

This made me go "huh". It's not really new in this series, it's just
that from `initialize_repository_version(int)` I would have expected the
argument to be the, well, repository version, not a hash algo
identifier. But it all makes sense once you realize that the function is
"please initialize the repository version based on this stuff that I
give you" where, currently, the only input is a hash algo. (I see that
Han-Wen's reftable series adds another parameter here.)

> +               repo_set_hash_algo(the_repository, hash_algo);

I first wondered whether all calls to `repo_set_hash_algo()` would want
to be preceded by `initialize_repository_version()`, which might call
for the latter being called by the former. But I guess not. Various
users of `repo_set_hash_algo()` -- not that there would be a lot of them
-- might want to do similar updating and/or sanity checks, but the exact
details would differ.


Martin
