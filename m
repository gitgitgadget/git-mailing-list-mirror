Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0491C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 19:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CF06126A
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 19:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346492AbhI3TYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 15:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344294AbhI3TYl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 15:24:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AA4C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 12:22:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bd28so26062721edb.9
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 12:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nqUJlsWHzRTvS8Pdi1RdkPHUMpiM9m9rj7pIR7T6jFI=;
        b=qmmeDRKU3drMihdsvLCpR4iBny4Gwn1qSj3adhxN/0GNG3L4bSTRW6xkKbnEQQkT0Z
         Ei63hT8c3TLj/Hdzvpkh7t51RQdw8ecanCB+QFTSO4L9Cfpq1fEw7PYxkGiK9Bx7IlIJ
         NPtow+ELMTtd0c+k8378CRMIkwDwbF4WWPxt0pMiwc+s1b8LsVCR0ebGqbz+IQUzI4YZ
         mwY/j7SW8UC/pxMSXH7zE1ZzvaFqGMreU/JwS+uMfWhnnHmYZXFptI1O8N3Z8sBtntXl
         E6sn/ksnYNRhIx48ydhanm2y23rN3EEoUFGX62I8F41cYsT4+bwsV09iwOp+m18OE6cW
         0CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nqUJlsWHzRTvS8Pdi1RdkPHUMpiM9m9rj7pIR7T6jFI=;
        b=hgdb/+hipwLrySaVwniuK/l8kSEOVVcsVO3GCo+N+Ax0D/yq7HiLMYEkXk1DzXj/1B
         AibGNJePWUGLbema3B5KoO+8onRiFixv3jSaSyjnBu9pWo33pCV/3JIU6Rarkf1cz7IW
         GeLGSryTYfTqOWfNHwqcWf3UwepUwtDRxhV1R6iaPM6IM9akml2vs0S+jlNFLMwMIhud
         tGvU4bTPx8aMtw+hBYwVO9jUWCIOeWXmLHcxGstn5p+JTvIEqajTBEL1ZU03p3vwn0Gr
         443ygdFj6XL04aFufyqgBEi4lWb2Ri/4ZNXGO7OkWJKZjJTJTqGAZI+f5labmRzK75mX
         2ErQ==
X-Gm-Message-State: AOAM530lINilQDomQ5L1v1yXD0A3QRteLwYeZmbQETl8z8bGyHvxCdIP
        LliGJo7lpxm4ntzWdfGbAeE=
X-Google-Smtp-Source: ABdhPJzkNEPDUIHZTbcmWHd0vkwxC91nDxXsZforCbfmYKpcaFCBAqHFExCa1J98J5PdkwQD6ZafUA==
X-Received: by 2002:a05:6402:5191:: with SMTP id q17mr9274870edd.332.1633029776465;
        Thu, 30 Sep 2021 12:22:56 -0700 (PDT)
Received: from [10.10.18.3] ([154.13.1.133])
        by smtp.gmail.com with ESMTPSA id b2sm2010277edv.73.2021.09.30.12.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 12:22:55 -0700 (PDT)
Subject: Re: [PATCH v9 01/17] fsck tests: add test for fsck-ing an unknown
 type
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
 <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
 <patch-v9-01.17-520732612f7-20210930T133300Z-avarab@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <78bab348-ba3a-7a27-e32e-6b75f91178db@gmail.com>
Date:   Thu, 30 Sep 2021 21:22:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <patch-v9-01.17-520732612f7-20210930T133300Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/09/2021 15:37, Ævar Arnfjörð Bjarmason wrote:
> Fix a blindspot in the fsck tests by checking what we do when we
> encounter an unknown "garbage" type produced with hash-object's
> --literally option.
> 
> This behavior needs to be improved, which'll be done in subsequent
> patches, but for now let's test for the current behavior.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   t/t1450-fsck.sh | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 5071ac63a5b..969bfbbdd8f 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -865,4 +865,21 @@ test_expect_success 'detect corrupt index file in fsck' '
>   	test_i18ngrep "bad index file" errors
>   '
>   
> +test_expect_success 'fsck hard errors on an invalid object type' '
> +	git init --bare garbage-type &&
> +	(
> +		cd garbage-type &&
> +
> +		empty=$(git hash-object --stdin -w -t blob </dev/null) &&
> +		garbage=$(git hash-object --stdin -w -t garbage --literally </dev/null) &&

Patch 01/17 introduces two unused variables: "garbage" and "empty".
However, patch 16/17 introduces grep checks for "garbage_blob" and
"empty_blob". Aside from that, 't/test-lib.sh' already defines
$EMPTY_BLOB.

> +
> +		cat >err.expect <<-\EOF &&
> +		fatal: invalid object type
> +		EOF
> +		test_must_fail git fsck >out 2>err &&
> +		test_cmp err.expect err &&
> +		test_must_be_empty out
> +	)
> +'
> +
>   test_done
> 

