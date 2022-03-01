Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51C4C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 08:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiCAIJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 03:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiCAIJP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 03:09:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D762F5C855
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 00:08:32 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a8so29788906ejc.8
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 00:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3Qkr2t1QFc4vp6qCuNqPnIBe/E04qbjlP+3sntAdWsM=;
        b=RF7gZG/RG2l/KdJvg364bUOTbXftb6/9D9jGW7anm93jNZuAtlAHez4KovTuttH5Bh
         gMbINDX7Zw0nWRCn3dIh3EmVu0mGVtQKyVSmE7w7wfqsl43Tjoh5EOVj2SRtXvy2dG3x
         heT13c3IE5bqPUN8ZFh9OK3eJQlJAGq79uXnt8p7ELOUGMw81LwLfzA1px2cy7CjeoOK
         w8AwlcqxZ0QIo+FtFxMhrSuoi1QVr68bGamRB+RM5qPNP3cKwfS3Rcu/LjKDq2NzN0dp
         WCyQs5/4bguhr7/8apHrQ7v9PNhH54mDlXs2Vek/lrXdKtl6S2L1zIXLkMs6gs1+b+Fs
         M6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3Qkr2t1QFc4vp6qCuNqPnIBe/E04qbjlP+3sntAdWsM=;
        b=BcAsPxx2LX5XwWldOh2FKIqscf8DMi4mWAD3ZnAKAPvDBkRm4Hb+tVEZRg8E0ICfAK
         JHso09oeBhZPEUBpecxMKMAg7OIdq7FosT7ha1Z+VhnprSRL79wUY270kIebHXeIOgf/
         ipMGOpWlrSDDhD3kz0eqIatE1F2FwYasZoLazq2ZtTH0DGXGzjIrOaDopdNsTyDSWGYj
         YCYwEkUhdECiYxd+lZOCE7gcweP+juxJMom/oJsRqf+iYs4nWw+nnRuzTb6VtFgEseQ1
         Cxj/+HEShDXsHhXFT94kcD/9ZqQaGu6Mo/3lDsjk7i62aOyEvVZrO2xpvPNdJeIh72T/
         SooQ==
X-Gm-Message-State: AOAM531/HXcTJSGn9/8dafJkI5HLxSOh25iOtdoJhc3pftu/VeR3LMTD
        aOP35ogQQfR8fb5sq90bhiKMvhGYIog=
X-Google-Smtp-Source: ABdhPJxMTeRukgL/1kBXZlXiPT4QMRx05MSGh5o3WySIEJjc13ZMRWD1ku95YpTQ0kmecV69TVgyUQ==
X-Received: by 2002:a17:906:fad5:b0:6ce:e056:5918 with SMTP id lu21-20020a170906fad500b006cee0565918mr18299085ejb.562.1646122111323;
        Tue, 01 Mar 2022 00:08:31 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id la3-20020a170906ad8300b006d0562a1011sm5076072ejb.21.2022.03.01.00.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 00:08:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOxYc-001wuF-FG;
        Tue, 01 Mar 2022 09:08:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 12/13] submodule update: add tests for --filter
Date:   Tue, 01 Mar 2022 09:07:34 +0100
References: <20220301000816.56177-1-chooglen@google.com>
 <20220301044132.39474-1-chooglen@google.com>
 <20220301044132.39474-13-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220301044132.39474-13-chooglen@google.com>
Message-ID: <220301.86bkyq14e9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Glen Choo wrote:

> Test the "--filter" option to make sure we don't break anything while
> refactoring "git submodule update".
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  t/t7406-submodule-update.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 7764c1c3cb..6cc60ff5e5 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -1071,4 +1071,17 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
>  	)
>  '
>  
> +test_expect_success 'submodule update --filter requires --init' '
> +	test_must_fail git -C super submodule update --filter blob:none 2>err &&

Should be "test_expect_code 129" (presumably, or is it 128). In any case
other similar "usage" test check for that:

> +	grep "usage:" err

We could retain this then, but FWIW if it's 129 other tests consider it
redundant.
