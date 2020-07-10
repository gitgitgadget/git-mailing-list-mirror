Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CA3C433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 15:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2C620725
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 15:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcglN5ZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGJPJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJPJv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 11:09:51 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2193EC08C5CE
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 08:09:51 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id m8so2693798qvk.7
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nZglSzr0V6zp5yJO4C+WE2vUfK7+UcenFF29b9Hnaho=;
        b=jcglN5ZZ+fJtm7LQ/XTIJH0jM+neIwRISR7MSEsJPgiZXpS7TyFrdy7efTnihkuVLD
         gZGQRXQSOioc59sch/A3DSzlSonti5IpBktdU5GbI899MoYfe7NH1RC7SVNGv8eiIl6R
         dkIf/aN4gZI+l/tb4yEjEtTZhOc6FWMKzXaD2ZYIEe3Y5GbNro9CU1eX5N99DDvJGUan
         S6EyUelrRlRjFv/H4X/4vMDO7fzXKnQmJowLy8mD0WkeOGJeNigt7GMfSZvTPhsyrivS
         tHKPghmdV3qOTcO7oUzPgCojb14NRY9XnzYhiRCyg9inK1ZsBg4D47El41ZtJS7yci+n
         ED7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nZglSzr0V6zp5yJO4C+WE2vUfK7+UcenFF29b9Hnaho=;
        b=eoTTszaS0uE6Da1zCwi5hqrCITY8xMgjDffSyYYQiYuV5/VRGc09EMtFAvvDcT3mPs
         asIjOFukjgkAytE3iL7Q7zLFHu5TQmvq3cymxpOQ3FZBvfJXnvzVqLcMDl+VEbkwuFAu
         BOX2n6uNicMb6YYOYtO2HeF6W80MNoy7BG16RO14nFO0QFefPpQr9jmt+ZPq4PWH42OQ
         g72ub+/4VeyIs2TzEWw2bp8aTduuwCbQvF8oON82U3dfRveI9rZlORQWlcaxvMq/LsZy
         czN7fRvc9O+sFNQYsntl1F5tvaMmewt3ADkjNeeN1R+vARN90rG1eT/ZReTrxl3i98ti
         iy8g==
X-Gm-Message-State: AOAM531KqbWG+OpbjWR+mdSsWmU876PCoEnp0N0eiRMnEDvhfTubzWVs
        wypizRjQ/5LQZ0xC2YHpXxakLXcV+sk=
X-Google-Smtp-Source: ABdhPJyLikvucND9foiOUUSuszoZxYs0ekpUxPqHOfi5+XfjdC4+ZHtE23Mb/AYj1+gm8ka2knKt/Q==
X-Received: by 2002:a05:6214:a10:: with SMTP id dw16mr68033341qvb.180.1594393790305;
        Fri, 10 Jul 2020 08:09:50 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g145sm7788635qke.17.2020.07.10.08.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 08:09:49 -0700 (PDT)
Subject: Re: [PATCH 36/38] ci: run tests with SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
 <20200710024728.3100527-37-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cb17f0ce-f96c-12e9-d0dc-dbfb9a4cc9ea@gmail.com>
Date:   Fri, 10 Jul 2020 11:09:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200710024728.3100527-37-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2020 10:47 PM, brian m. carlson wrote:
> Now that we have Git supporting SHA-256, we'd like to make sure that we
> don't regress that state.  Unfortunately, it's easy to do so, so to
> help, let's run one of our CI jobs with SHA-256 as the default hash.
> This will help us detect any problems that may occur.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  ci/run-build-and-tests.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 17e25aade9..b41b527b15 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -22,6 +22,7 @@ linux-gcc)
>  	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
>  	export GIT_TEST_MULTI_PACK_INDEX=1
>  	export GIT_TEST_ADD_I_USE_BUILTIN=1
> +	export GIT_TEST_DEFAULT_HASH=sha256

I was hoping that we'd have a default hash setting available
in CI, and this delivers!

However, this place changes the mode along with a bunch of
other "optional" GIT_TEST_* variables, so the sha256 mode is
not being tested on its own.

I think that the SHA-256 support is a big enough task that
perhaps it should be part of the "matrix" in the jobs list
inside .github/workflows/main.yml. Of course, I don't
understand that system enough to contribute my own patch.
For that reason, this patch is an excellent first step!

Let's keep my thoughts on creating new parallel builds for
SHA-256 mode as a future enhancement.

Thanks,
-Stolee
