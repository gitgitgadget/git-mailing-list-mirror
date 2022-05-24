Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67635C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 17:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbiEXRlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 13:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240061AbiEXRlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 13:41:16 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAB8AE42
        for <git@vger.kernel.org>; Tue, 24 May 2022 10:41:15 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id s23so19032859iog.13
        for <git@vger.kernel.org>; Tue, 24 May 2022 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kz0AT/EzElZu3m47qBL9aYvF3Nu55bpGo5kAd7InzGQ=;
        b=Z4XAe6Nb+qZOYbVnTr1n9VIzJKSO5L4caN+6ADcVSOke175nAuEmpHfKEuS/6HgLUF
         fW35w2x9xzUTDlXDHMrSLkhFTXXb4SncDe00j1VzWAnwUhAUb63znAWsd8Yxw7PGTqB4
         zF1N9m4xCTOrwqm6L+2PkPNM6WwFTjTtgwnnyhiJg1ebWiQ59meJ3C6r5KwcDCBvuAGD
         REnMKxCXrMM9INFaA+CsxhvuY3s7Sh0EwdCgzusDiBPw3IB45veiwrerai3wPgygEg1x
         y1pvSu5W1skYGQTF/tOAXV+7qhLwRTOGYcEw72IcrrMi/zpNFJGpe0uxcUY1MsTQ+Mgq
         txWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kz0AT/EzElZu3m47qBL9aYvF3Nu55bpGo5kAd7InzGQ=;
        b=EzxBHWzm6Jj45TeOSr/zlg83LbZORalA+BU13YAWBp4xHUFQuUAbbKwwj8RYQsBgj+
         j37tIPObDZa7IGgS5j+FNBmCCxqkfeOPKLXYzZAHAjenKZOeaXKx0BWsO42yXbbH1C4A
         yFhfBJc8rwQ2bAyoPlG0HSx1DKrVr8A1iNCsxAF8uAU5OdfV7seZc1YRPWIMrNvbCVjM
         RO+dTW3GZYgRAzlZ+al6p6EDBTIKrBjVOHOftU05D6wKw81kSGRm3onmQNdlkKENqRrP
         pXgBJ8y953ExAXk8Nt9T+3bYQwvcqYJCsE9DjWt/q7nlvOarGc5x+xsdoXHhHOsS0LP9
         Yl0g==
X-Gm-Message-State: AOAM533E0pdWKK1dxRHfYbbwFzPpha+uX6OyEcKhZQkrb5BEaSGYP7JO
        lbFCEkZGWzsJPqMp9S1uC4w+
X-Google-Smtp-Source: ABdhPJxzdtACpMsoDb2emVoxYdOd35utsLDhuK4cixM8Vul4yfhiUMy61CjQcw6CIG4Y9B85vZLYtQ==
X-Received: by 2002:a05:6602:3344:b0:660:d2cf:4aa4 with SMTP id c4-20020a056602334400b00660d2cf4aa4mr7314894ioz.190.1653414074778;
        Tue, 24 May 2022 10:41:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9dd7:2c4b:2dbd:828e? ([2600:1700:e72:80a0:9dd7:2c4b:2dbd:828e])
        by smtp.gmail.com with ESMTPSA id r8-20020a924408000000b002d19bb6082fsm2250701ila.43.2022.05.24.10.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 10:41:14 -0700 (PDT)
Message-ID: <dafc8178-d213-ffd0-9e2a-32ac88307b39@github.com>
Date:   Tue, 24 May 2022 13:41:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] setup: don't die if realpath(3) fails on getcwd(3)
Content-Language: en-US
To:     Kevin Locke <kevin@kevinlocke.name>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <7c064f43ed426c9e3b54e1ae5313d6b9332a47cb.1653141169.git.kevin@kevinlocke.name>
 <68c66aef7ca4dba53faec9e6d2f3b70fe58ac33e.1653403877.git.kevin@kevinlocke.name>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <68c66aef7ca4dba53faec9e6d2f3b70fe58ac33e.1653403877.git.kevin@kevinlocke.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/24/2022 10:51 AM, Kevin Locke wrote:> -	/* Normalize the directory */
> -	strbuf_realpath(&tmp, tmp_original_cwd, 1);
> -	free((char*)tmp_original_cwd);
> -	tmp_original_cwd = NULL;
> -	startup_info->original_cwd = strbuf_detach(&tmp, NULL);
> +	/* Try to normalize the directory. */
> +	if (strbuf_realpath(&tmp, tmp_original_cwd, 0)) {
> +		free((char*)tmp_original_cwd);
> +		tmp_original_cwd = NULL;
> +		startup_info->original_cwd = strbuf_detach(&tmp, NULL);
> +	} else {
> +		trace2_data_string("setup", the_repository,
> +				   "realpath-path", tmp_original_cwd);
> +		trace2_data_string("setup", the_repository,
> +				   "realpath-failure", strerror(errno));
> +		tmp_original_cwd = NULL;

I didn't catch this in v2, but should this line instead be

		startup_info->original_cwd = NULL;

? Especially based on this comment:

> Changes since v1:
>  * Set startup_info->original_cwd = NULL when strbuf_realpath() fails,
>    rather than setting it to the un-normalized path.

Thanks,
-Stolee
