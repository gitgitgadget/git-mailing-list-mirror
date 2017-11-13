Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35BA61F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 18:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754356AbdKMSnw (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 13:43:52 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:43368 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754352AbdKMSnu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 13:43:50 -0500
Received: by mail-qk0-f172.google.com with SMTP id 78so21001729qkz.0
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N8UAHSBmZDPhxPjXXYAsbIx3mA0zjzO5pm1M1GlBWYw=;
        b=bJL5r7KljDYtszr8nX7+H8RWBO4fuzuhcQPZDKsRtpJ2d8ZNUrQDyLwflaKRGZwm7X
         yF+J6hZgy45lhvY9DvqBygcfFFUeydSJWhDuSBzVLfmmBSViOMqkietWGfSpLVoJ8Tbg
         /nX52ZyBCtWsj7Pa0Uf8XMYrP7wJ7/W0qa2/IO0NNTt6D9mx6spYHmlRktZvUvlSLepf
         i6xjv/Ze97+OdfkqCOkhAwhvNG9kpcQr9CkotP3qKcl3nB+NlmkFLGMbyqqJZ3ZR+I3t
         9I8eV6LeetYvVDtyIdfCCD2k46EiGWkppLuyHTJS9tdp5uKwSVQTu4aTR++PexFxirdO
         BfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N8UAHSBmZDPhxPjXXYAsbIx3mA0zjzO5pm1M1GlBWYw=;
        b=EdLBcDwacJoPEKuQb/CSrFx5tkcgCtpSmBJRW3XoDADqp+c+mcRWXBWD5z81sIjidF
         fSdRp5C4kIx+A47XL1ZYAsbz7WxaF4g3uUjkI3EXttwaj/cyRUjrt1tBsgXGiO2NhENn
         eESaJhbDpsfv1q+5RJtYhRWMgOwz/83mVkHsFGLm3KQWH6EhXFuo9zlGXGsQyoND65oh
         uxVZOcWAB4Jz8oXhiJZdWi8LD2/e2vC6GcNa6YsRLmPGsS/LmL69PxTjd3PYDxxHPDcR
         AvTf8SYfGvOtZZoHlHby7raeRBcp+OdqEkEimg1jt58IbXPrr2A0JJvzAbWZVa2Pd3EU
         2MDw==
X-Gm-Message-State: AJaThX4ufVVsezzLmNyzwGrKyoWSUmV1vts/PoZ0D79bZEECCjyUTj3L
        KYUSb7tTkSBuHqeljgooMuUM3O7YvDBcz+BJLxCM1Ls+
X-Google-Smtp-Source: AGs4zMb/SJBFrKg0nog13gBY78KVxtJQNIJHF+1IzE6TFkIBwd4Qjuac6Nu5C76UIRD4u9kCuKgcnrE7aE91u6I6pRA=
X-Received: by 10.55.26.168 with SMTP id l40mr14892748qkh.352.1510598629856;
 Mon, 13 Nov 2017 10:43:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 10:43:49 -0800 (PST)
In-Reply-To: <20171112212854.791179-5-sandals@crustytoothpaste.net>
References: <20171112212854.791179-1-sandals@crustytoothpaste.net> <20171112212854.791179-5-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 10:43:49 -0800
Message-ID: <CAGZ79kaoZX_ek32+vB-j0tSp=tLRYn4vkx2WSSjMQ3CPNty6wg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] Switch empty tree and blob lookups to use hash abstraction
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 1:28 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Switch the uses of empty_tree_oid and empty_blob_oid to use the
> current_hash abstraction that represents the current hash algorithm in
> use.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

Thanks for writing this series,
all four patches look good to me.

Thanks,
Stefan
