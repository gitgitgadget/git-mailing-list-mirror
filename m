Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02ACC55186
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 10:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B19E20781
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 10:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxextJFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbgDVK2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbgDVK1m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 06:27:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D9AC03C1A8
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 03:27:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g12so1721089wmh.3
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 03:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tLUitIiRXUo13fOgGPelgb2N//FhvStFWqqmW9ChsoY=;
        b=qxextJFdaE9wFhQysk8Psjl/mkp4U9mnfBM/BzW3DNH/ZEq0YD+dVjTpGiM1i5h3c0
         IbK3zk/keuLGptOcIY7ZcmmH/zwljBeNwTu2eqOFH+gjZYUvwf/3N6A3eDZ7XFFHI2XM
         9Bw/L14f2My+swlTpX4h0cpZxz20PusPaqBy/Svs7kgkzTaRy1eOFvp1qBvPlcd8cNrs
         pIQZdcGpTy1dtAUwTD+73SKSg5VI/WjuUacLY9fiM2QGMePHgSQzHT1GSWHkAszmhDG8
         YywlvyK7JFx2lJ1Ny956dz1yCcIgVAsEIigJg/GRkUxXGZ6q6Lw1QvRirLw8qntGcrQw
         xYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tLUitIiRXUo13fOgGPelgb2N//FhvStFWqqmW9ChsoY=;
        b=ly1uiPO5/5fd/oNTUo2NBqKVuWNgi8KoeInLKcDIvGiqI79NGBP8DOP/z1naJXUUFF
         sqF9Jqb+LILdSd09htZzfPA0d8+k0dhdkb5u1s6oT0gApjRRZxWr+OMAUqPFBmO2BZ7t
         Ie9n1ekCMQs3ngUg5+rqrvR5X75Fg7flD9tWrTXgY0LCTCFpYrSkvng4Yq+5Z7HMmEMV
         bQJ6X0hRjRX+Id4BQHkbwUs4ZTrVvbvkeMv/qNn78khUwDMb/9nA8xy/efNW7A5BkJTm
         WK5LIsHb7iEk+N3VxTPsnLTeYAa/iyDqpleoKEdxCLJSQjG3TOoJkxjiDkLBO5s8yu4a
         vjdA==
X-Gm-Message-State: AGi0PuYpChCIZZ+4Ky2Hw5Obf7fN89SHQWvlEtFxQaRtK/e0X6mZt4nr
        FDOpZ6PxrhQT4EY1GHnKLL4=
X-Google-Smtp-Source: APiQypJ23s9ca/qwRlmFjGkE8Moqw1t68wVMQCei4/ZunTA5gdo3CWdDSaVPr3FHjS+LFWAxGcTEkg==
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr10253674wmj.170.1587551261280;
        Wed, 22 Apr 2020 03:27:41 -0700 (PDT)
Received: from szeder.dev (92-249-246-129.pool.digikabel.hu. [92.249.246.129])
        by smtp.gmail.com with ESMTPSA id z22sm6974685wma.20.2020.04.22.03.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 03:27:40 -0700 (PDT)
Date:   Wed, 22 Apr 2020 12:27:34 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/receive-pack: use constant-time comparison for
 HMAC value
Message-ID: <20200422102734.GA3063@szeder.dev>
References: <20200409233730.680612-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409233730.680612-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 09, 2020 at 11:37:30PM +0000, brian m. carlson wrote:
> +/*
> + * Return zero if a and b are equal up to n bytes and nonzero if they are not.
> + * This operation is guaranteed to run in constant time to avoid leaking data.
> + */
> +static int constant_memequal(const char *a, const char *b, size_t n)
> +{
> +	int res = 0;
> +	for (size_t i = 0; i < n; i++)
> +		res |= a[i] ^ b[i];
> +	return res;
> +}

    CC builtin/receive-pack.o
builtin/receive-pack.c: In function ‘constant_memequal’:
builtin/receive-pack.c:509:2: error: ‘for’ loop initial declarations are only allowed in C99 mode
  for (size_t i = 0; i < n; i++)
  ^
