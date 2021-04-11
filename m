Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD51C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 11:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02E3610A7
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 11:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhDKL5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 07:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhDKL5t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 07:57:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79BCC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 04:57:32 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w18so11737819edc.0
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=mBgwrU+Tug03wD9CeVGnsfnh8SEhPnTJhmEQui9o9f8=;
        b=mliDydrJw7RjUaj7Kw/49UifxoPkhpQUSVHyBBHj9wCCrL3bb9Ues+i8UUQxFF5U6+
         P125GmbgLgl1pdc/pLprTWX/CUfonSn84RznCUrU/esSObzQ/IbO1x4aHdggDvcRnZ1U
         6BmpcIYR40cMX+xvhiaWvpnHkbzpte6rn0b7BebQ3CIzWTErul+88Nl3CLtlvPdoundP
         40RVK7sSiKP924C7Bh1pjFL06jDx44tulxVPa6flp3wL+y3UQyfNTZ9ItaBMpVbd972N
         Cb3TQkoQrxj+SzJIXFB2roZoai10sBSB5EOq8z/m9eC3A6Vrb8FmEBqkmj1Pky7g+GuC
         dSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=mBgwrU+Tug03wD9CeVGnsfnh8SEhPnTJhmEQui9o9f8=;
        b=AQrRU6JfR8HcsjSjFLmW0SgIODWXxwVRAbdq24udMczvApFswW2kaGGO9vJKqmgcJh
         wPg463tZR7C73hTbkNkWFFRtKaLNewYkikFtijv43RkjHJFVMc8lgb5BEyz03hBy4QW6
         NViSYxw4jT0cjGUKUslGZR+S68ZAfz4Snfhzi7mKCwtFv1fpH0D01L7weXrKPbru5YR+
         yz2+VjV6gHgTsELHQLno+NwoL2Kypsev5BK/qVBlEai25QwYKF5A1puaRMa2FchDFL6X
         /Zr8MBvpkogxN0rW5pV3O6zRIkpPYkpnDENJgb/znF2eRRWW/NCfHaoM0T9hKcQ1yqRP
         zMiA==
X-Gm-Message-State: AOAM531+2RK+LMvvhAMxTiGR6ekY2nnEo4gr7Gi4EqXmZmuREZ3AX/SZ
        LZ4vJ2bdnWYq8o26W6CKnuE=
X-Google-Smtp-Source: ABdhPJwXZn1tqfiY6gj6wCMncyoa5gGuZ4wA70ZFubkcd51VeddGeNqW2hFHjtTaU0JqX0wFoC9jNA==
X-Received: by 2002:a50:eb8e:: with SMTP id y14mr20042644edr.111.1618142251587;
        Sun, 11 Apr 2021 04:57:31 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u15sm4622489edx.34.2021.04.11.04.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 04:57:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 09/15] hash: set and copy algo field in struct object_id
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-10-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210410152140.3525040-10-sandals@crustytoothpaste.net>
Date:   Sun, 11 Apr 2021 13:57:30 +0200
Message-ID: <87k0p9f2z9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 10 2021, brian m. carlson wrote:

>  const struct object_id null_oid;
>  static const struct object_id empty_tree_oid = {
> -	EMPTY_TREE_SHA1_BIN_LITERAL
> +	EMPTY_TREE_SHA1_BIN_LITERAL,
> +	GIT_HASH_SHA1,
>  };
>  static const struct object_id empty_blob_oid = {
> -	EMPTY_BLOB_SHA1_BIN_LITERAL
> +	EMPTY_BLOB_SHA1_BIN_LITERAL,
> +	GIT_HASH_SHA1,
>  };
>  static const struct object_id empty_tree_oid_sha256 = {
> -	EMPTY_TREE_SHA256_BIN_LITERAL
> +	EMPTY_TREE_SHA256_BIN_LITERAL,
> +	GIT_HASH_SHA256,
>  };
>  static const struct object_id empty_blob_oid_sha256 = {
> -	EMPTY_BLOB_SHA256_BIN_LITERAL
> +	EMPTY_BLOB_SHA256_BIN_LITERAL,
> +	GIT_HASH_SHA256,
>  };

In this and some other patches we're continuing to add new fields to
structs without using designated initializers.

Not a new problem at all, just a note that if you re-roll I for one
would very much appreciate starting by migrating over to that. It makes
for much easier reading in subsequent patches in this series, and in
future ones.
