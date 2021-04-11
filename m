Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6065BC433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 11:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2513C611AD
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 11:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbhDKLgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 07:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKLgv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 07:36:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A44C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 04:36:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a7so15625702eju.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 04:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=RivWIWaaB951+oemZjZhlX6386KUW9rPbI0W8SxHZ1w=;
        b=AaUcqjP8HEPaxRKvPs5dmHVI23oS431sVJpJ6D6vN7yaPk5Uj/F3tIt8QykbSLuRoV
         8LJW5CJFJl2T47vBuaN2viB9G1JZDdYTldm8fiKtDkUg0Ig1Os/A9gvd4PeXQQfjPQzb
         s92n8q9lxW2I+jBBOgIr1OkKCtSXtYWq5lac1cYE/wplVj4r6SFUqL7iBarGBYpCFnq6
         zq/YirNHZfpgkWLSL1I8X0LHatGL8IHOohP8vPj4e99MTki0F6hPac2iFSTbLBK2si6K
         Xsxqb8u7XKPvgrStWp9VL7wOTYU/B1TFKqlBrUcV6S2lEwCb4d85MEOvOj9pwaYrqRWJ
         ZKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=RivWIWaaB951+oemZjZhlX6386KUW9rPbI0W8SxHZ1w=;
        b=C8Fj1k993wIvd6gIAcMGr4GI4zXaTKhshRBS5NRI8u3cBgesPYn3hxQj/HoNS6KO3p
         WciVldWHtOZq4kZhW6QklU0qouLdPJftAmGm/mbgKZ8Nj46S1mtTDGzFihloTbhbxqAM
         N3Qy33ZVnTPpWfo9vOXTARDCnak8IeD3wyDFGLGcBK8QzCbyxHhUS1fgrxQQenGYQbpI
         1TQOru2Q1HzgnBvty/0jai2on6McBXiXmzWYi32aO/dfHnEjwX44p3DbT6DpyTIHRuAw
         FF7J9HTHFt3n1dicojUuMPaGv2OFAMd0jD/ub/QttxZ3ZlJ1ySC/G7Zo//CyVk4S2bJc
         B/fQ==
X-Gm-Message-State: AOAM533NGWu24VjkfYu1Jrzl9jM4czPXK+syx2CDScbWirXqAzYIMEHb
        QbrKuvlb2P9pblH8kbpqnYk=
X-Google-Smtp-Source: ABdhPJw8UCCKafqfV+e0KJFjJuYP4q1cmNBEl6h7YYTlD9/ppZs7pT0T2ylhBmid02kj1m097QAxyA==
X-Received: by 2002:a17:906:4f15:: with SMTP id t21mr12632554eju.338.1618140994314;
        Sun, 11 Apr 2021 04:36:34 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id a9sm4551158eds.33.2021.04.11.04.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 04:36:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 08/15] cache: compare the entire buffer for struct
 object_id
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-9-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210410152140.3525040-9-sandals@crustytoothpaste.net>
Date:   Sun, 11 Apr 2021 13:36:33 +0200
Message-ID: <87pmz1f3y6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 10 2021, brian m. carlson wrote:

> Currently, when we compare two object IDs, we have to take a branch to
> determine what the hash size is supposed to be.  The compiler can
> optimize well for a single length, but has trouble when there are two
> possible lengths.

This would benefit from some performance/perf numbers. When this code
was first changed like this in 183a638b7da (hashcmp: assert constant
hash size, 2018-08-23) we had:

      Test     v2.18.0             v2.19.0-rc0               HEAD
      ------------------------------------------------------------------------------
      0001.2:  34.24(33.81+0.43)   34.83(34.42+0.40) +1.7%   33.90(33.47+0.42) -1.0%

Then it was later modified in 0dab7129ab1 (cache: make hashcmp and
hasheq work with larger hashes, 2018-11-14).

> @@ -205,7 +205,7 @@ static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>  
>  static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
>  {
> -	return hashcmp(oid1->hash, oid2->hash);
> +	return memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
>  }

hashcmp is now:

        if (the_hash_algo->rawsz == GIT_MAX_RAWSZ)
                return memcmp(sha1, sha2, GIT_MAX_RAWSZ);
        return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);

Wouldn't it make more sense to amend it to just be a memcmp
wrapper/macro if we're going to not make this conditional on the hash
algorithm, or are there other callsites where we still want the old way
of doing it?

>  
>  static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
> @@ -221,7 +221,7 @@ static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
>  
>  static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)
>  {
> -	return hasheq(oid1->hash, oid2->hash);
> +	return !memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
>  }

Ditto hasheq v.s. !memcmp:

        if (the_hash_algo->rawsz == GIT_MAX_RAWSZ)
                return !memcmp(sha1, sha2, GIT_MAX_RAWSZ);
        return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
