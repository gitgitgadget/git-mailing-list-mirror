Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD661F453
	for <e@80x24.org>; Tue, 16 Oct 2018 15:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeJPX2H (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 19:28:07 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34646 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJPX2H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 19:28:07 -0400
Received: by mail-io1-f66.google.com with SMTP id w2-v6so16827474ioc.1
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXHEwnejCJ4Nixg1lFPRAD6+7ttfuf8eMN9keIb6IUU=;
        b=I6kbFOLTCtB0vXYTs0WFENxWSRMk8wLK9OE3ripqlQAhf9JORAP7nsY+Rr4OvgaxC6
         mkxpto5ayfQdGmbhpVE94qJiSG9D801HkULkATG4c/4wvcm8nmfPPgKSfZSYSzEeahMU
         Gbqgslwf11e1m1CWz4SI2Eo5x+N06IigDk/wXLM9Mhb17gsi/tx215p4hqPddbjy+2Ii
         GRj1QN4MMLZ8dOeHB2ibMlTW+IBheAGxqMTnZjRFk9hhfaDY+YPBRoi7vUnVVIN6yTpR
         dZJW7HfiE4XIx86gKGUuTXDMwgmQ/OqArH5hCy7KZGMaYhA1UqQeOHXePhGi+z91wcW4
         Rarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXHEwnejCJ4Nixg1lFPRAD6+7ttfuf8eMN9keIb6IUU=;
        b=lP1QvDKzscKCh4pLTvejjG6ZFBFsOAmqDlj72sDJv+eixwnnlL2MMcmhm6soNf0k4/
         6LWX1GwU5ZTSLA21Q1JwaechSaxbiTN7trcRw7JO25JAZXZ0yXXwscz27k1ebV1R/DTj
         X7qXavsI7I7JRw/uHEw7XW4c+myfPHCcuW38f3tKta4kCE2+YD1Rf34uLayWDTRaU8R4
         SwrYxYW5hK8Jm26kOes7fnKjpihRcAqj5fefjRCeednJoDQaV/WjemORmVgJZnUaP6tf
         hi5cRxoFsJGWhuaW3VuzKeCnLnyq/2LhaYXSSzyce6rH5lKdBW1UnKgFMc0+CWAfoaKX
         Me8A==
X-Gm-Message-State: ABuFfogc6zuYtnKSqloBRJnb3Z2he6gWq6TeODPhDPYJh9/p2DPrsrvG
        kYlAy6rhnbhoLfDuriZtlTtiwuIfApSp0AgZyKI=
X-Google-Smtp-Source: ACcGV626raokD+IeRksdJy8oL1Oh/43ZpJMsvF8c9ACldSb4UnWIuOVdyvAjsgkzyWWm+T8IBqgpuDFHnRgN/KGwaQI=
X-Received: by 2002:a6b:8b97:: with SMTP id n145-v6mr12735328iod.282.1539704226553;
 Tue, 16 Oct 2018 08:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net> <20181015021900.1030041-13-sandals@crustytoothpaste.net>
In-Reply-To: <20181015021900.1030041-13-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 16 Oct 2018 17:36:40 +0200
Message-ID: <CACsJy8B3cK7VUfRYBa+Tqnke6gJ6FT9u+AsffAcGJQhQ5wcjvQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] hash: add an SHA-256 implementation using OpenSSL
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 4:22 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> We already have OpenSSL routines available for SHA-1, so add routines
> for SHA-256 as well.

Since we have "hash-speed" tool now, it would be great to keep some
numbers of these hash implementations in the commit message (and maybe
sha1 as well just for comparison).

>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Makefile | 7 +++++++
>  hash.h   | 2 ++
>  2 files changed, 9 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 3d91555a81..3164e2aeee 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -183,6 +183,8 @@ all::
>  #
>  # Define GCRYPT_SHA256 to use the SHA-256 routines in libgcrypt.
>  #
> +# Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
> +#
>  # Define NEEDS_CRYPTO_WITH_SSL if you need -lcrypto when using -lssl (Darwin).
>  #
>  # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
> @@ -1638,6 +1640,10 @@ endif
>  endif
>  endif
>
> +ifdef OPENSSL_SHA256
> +       EXTLIBS += $(LIB_4_CRYPTO)
> +       BASIC_CFLAGS += -DSHA256_OPENSSL
> +else
>  ifdef GCRYPT_SHA256
>         BASIC_CFLAGS += -DSHA256_GCRYPT
>         EXTLIBS += -lgcrypt
> @@ -1645,6 +1651,7 @@ else
>         LIB_OBJS += sha256/block/sha256.o
>         BASIC_CFLAGS += -DSHA256_BLK
>  endif
> +endif
>
>  ifdef SHA1_MAX_BLOCK_SIZE
>         LIB_OBJS += compat/sha1-chunked.o
> diff --git a/hash.h b/hash.h
> index 9df562f2f6..9df06d56b4 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -17,6 +17,8 @@
>
>  #if defined(SHA256_GCRYPT)
>  #include "sha256/gcrypt.h"
> +#elif defined(SHA256_OPENSSL)
> +#include <openssl/sha.h>
>  #else
>  #include "sha256/block/sha256.h"
>  #endif



-- 
Duy
