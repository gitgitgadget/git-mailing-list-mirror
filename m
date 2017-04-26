Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B35C207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 23:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbdDZXBa (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 19:01:30 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35088 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754553AbdDZXB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 19:01:28 -0400
Received: by mail-pf0-f170.google.com with SMTP id v14so7667736pfd.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 16:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pdecvDTYiSMLZGY9VAbQjl92YYG28TKQ9EfLys3fi/8=;
        b=j4VW0u6QK3Qkx3MzzQ1fJS6ITTG1+ofMtAKrVg3i4phLkWYL2enVy9qBPKL2QVPvn0
         9VwQsAh3gacg1DJJEfhbeEPYKscNacAmamvi9Ba/icPv+IUniu2cLXngcBYM8Gol23Yq
         oDPPenq+lFVT6dvx0K70j9lMx0exDK2JVzyl3VoA3BXMBxkfYm0ujZa0Ri3sEkZ9FgoV
         ahxD2GSfS/WD/PHxpp1xoUSi+pNcSbNPRbAxB0aRzs/dnXJtAkKfDiB4K2pW8QDLVb+p
         bTC4XK5XHpDqylcA6LgC8i2BaLLW2091yTCgMCIeiJjhLmI+s7sXWUr3/qpvPsxu3Fof
         l1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pdecvDTYiSMLZGY9VAbQjl92YYG28TKQ9EfLys3fi/8=;
        b=bwOHJL3+1+KYJhBerL629qzoFU8OGp6ZwuHIpH+Ft/qidR7+21aLL3eH7mEbjJbjto
         nbgJOHgySFwxgIbyF8Sf6F0BP5K3xHcyU8L//URKH2nXvmE+Gw53FZFyTFBz2EpC8Q5w
         cg0225xa8kdz+2NIJi2P0v4RSHXhvoQlJv6U5vMgVnoFSVrqSQXhd42knBF1/rrWiZa3
         CUhxKZMlFMZQYSNywB2ekXURKaMUGy0R/hMJ9UUExRzVi+E+yaLbdS61clU6SmBST5p7
         BT6GjMSFfmRBcHdJyLMUTxRovuIKAeqjpiSkePJENxc5Rx0tQjTdCwkfF4x/WTg8ayA7
         G5Xw==
X-Gm-Message-State: AN3rC/5qg6XS2EHYYnX+kzQB2NoKEeNes+hk9KQpTSH+FEBhGyHBBJ7s
        WKnaxoK7EzqX33fOCsLeQFWWDg4xMOuG2eo=
X-Received: by 10.84.241.136 with SMTP id b8mr2899100pll.107.1493247687833;
 Wed, 26 Apr 2017 16:01:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 26 Apr 2017 16:01:27 -0700 (PDT)
In-Reply-To: <20170423213453.253425-36-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net> <20170423213453.253425-36-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Apr 2017 16:01:27 -0700
Message-ID: <CAGZ79kYhaX=tXM2aymFDkfU23E8=GzjgGbwQsynt1LWdLzxQQw@mail.gmail.com>
Subject: Re: [PATCH 35/53] Convert the verify_pack callback to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 23, 2017 at 2:34 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Make the verify_pack_callback take a pointer to struct object_id.  Use a
> struct object_id to hold the pack checksum, even though it is not
> strictly an object ID.  Doing so ensures resilience against future hash
> size changes, and allows us to remove hard-coded assumptions about how
> big the buffer needs to be.
>
> Also, use a union to convert the pointer from nth_packed_object_sha1 to
> to a pointer to struct object_id.  This behavior is compatible with GCC
> and clang and explicitly sanctioned by C11.  The alternatives are to
> just perform a cast, which would run afoul of strict aliasing rules, but
> should just work, and changing the pointer into an instance of struct
> object_id and copying the value.  The latter operation could seriously
> bloat memory usage on fsck, which already uses a lot of memory on some
> repositories.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

Up to here *excluding* this one, looking good.
This one may need review by an expert specialized in weird corner cases,
which I am not, yet. ;)

Thanks,
Stefan
