Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAC231F453
	for <e@80x24.org>; Tue, 16 Oct 2018 15:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJPXgP (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 19:36:15 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40517 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeJPXgP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 19:36:15 -0400
Received: by mail-it1-f196.google.com with SMTP id i191-v6so32732569iti.5
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LloxV6Pl25RaQAwAZJfRDY2DYEZLYr9u86PdMYql+R4=;
        b=NacwHp4j/1Cgq2S2ZMeZaaAEsSrUmJ1w6XTkWHY1GODiKI7Xx3Xe+VOF6aB7ETQUZB
         hfli+WkxhsS6K/mqpT0hqLfpJ80714yYRpZ3fklsE2wuzvZ0kFnollJzH0LGwIWbP98t
         Wed4hGf0SR4QdvPpsWLYpBIQUKs7yeXH4COQWpd7xO2ImJ1HsAoc5+r2Cd6Gd48Fby+t
         G3fZhAHMiLRDzM4Ho0P+hcdyqZNet4Homgd1xAyloSNHZ8Gck169wdtAZXdm0ogSc44b
         DiTR2OtCsrohECxi6dF4AhIWsJdC5iSYXSkzB22gusTn3WTmf6Gie8lL1mzTgsC2vACW
         OYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LloxV6Pl25RaQAwAZJfRDY2DYEZLYr9u86PdMYql+R4=;
        b=hm/hFtbRZZsDEN9HDklTHCYCwHgwtufPTjVk7zaE2CV46BQlkgm6omnpr5Dc6o46Ky
         nMSUG6R0D7AgpzjaXGsldXtdOfypbWYC6+bCXgd7un7JIE5Cw4xds852zFeIodijmzD6
         WafSdLUmcQ1WWX/5UZFhFnYh31NI+0xnieAEFExBh7FwaWroQhL1TeoiP8M1MCUGdyB9
         K754Fnre8GYDPO6s8ZlFNnOVy/m6frO8Xr0eoTWtAZweAKNuZkvkhhe1XVe2N3x+QuJS
         8whQKwmP5MF7uZxVQ1xRqf4YZKWn8wAdKnSk3xKD647ZCT8fvyv/llZqmg8bnK4Aa8BZ
         bxYg==
X-Gm-Message-State: ABuFfojlVdH7zGy9AZk7wRSXRWVwAi/cWw80enr1PLXwgqrADWobRILJ
        lrUKoZMuN/Gj6zaRSMXtT+rAPiXe7swYES23VAo=
X-Google-Smtp-Source: ACcGV60ypkl8032m1mmAa0zQMITJ+ly7lBhsG+3kSvn7NakbRKo6A3sst4bIVjqpVushFTAAweHaVh/swDYQSJTLIKM=
X-Received: by 2002:a24:cd02:: with SMTP id l2-v6mr16387593itg.70.1539704713615;
 Tue, 16 Oct 2018 08:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net> <20181015021900.1030041-5-sandals@crustytoothpaste.net>
In-Reply-To: <20181015021900.1030041-5-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 16 Oct 2018 17:44:47 +0200
Message-ID: <CACsJy8Cyep229CH8OfcVRqxC4soRiiCDhE_FMPhiEzVf-Z9v+Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] cache: make hashcmp and hasheq work with larger hashes
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 4:21 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> diff --git a/cache.h b/cache.h
> index a13d14ce0a..0b88c3a344 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1024,16 +1024,12 @@ extern const struct object_id null_oid;
>  static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>  {
>         /*
> -        * This is a temporary optimization hack. By asserting the size here,
> -        * we let the compiler know that it's always going to be 20, which lets
> -        * it turn this fixed-size memcmp into a few inline instructions.
> -        *
> -        * This will need to be extended or ripped out when we learn about
> -        * hashes of different sizes.
> +        * Teach the compiler that there are only two possibilities of hash size
> +        * here, so that it can optimize for this case as much as possible.
>          */
> -       if (the_hash_algo->rawsz != 20)
> -               BUG("hash size not yet supported by hashcmp");
> -       return memcmp(sha1, sha2, the_hash_algo->rawsz);
> +       if (the_hash_algo->rawsz == GIT_MAX_RAWSZ)

It's tangent. But performance is probably another good reason to
detach the_hash_algo from the_repository so we have one less
dereference to do. (the other good reason is these hash operations
should work in "no-repo" commands as well, where the_repository does
not really make sense).

> +               return memcmp(sha1, sha2, GIT_MAX_RAWSZ);
> +       return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
>  }
>
>  static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
> @@ -1043,7 +1039,13 @@ static inline int oidcmp(const struct object_id *oid1, const struct object_id *o
>
>  static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
>  {
> -       return !hashcmp(sha1, sha2);
> +       /*
> +        * We write this here instead of deferring to hashcmp so that the
> +        * compiler can properly inline it and avoid calling memcmp.
> +        */
> +       if (the_hash_algo->rawsz == GIT_MAX_RAWSZ)
> +               return !memcmp(sha1, sha2, GIT_MAX_RAWSZ);
> +       return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
>  }
>
>  static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)



-- 
Duy
