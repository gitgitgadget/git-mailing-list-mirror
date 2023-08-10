Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01978C001E0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 14:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbjHJOha (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 10:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbjHJOh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 10:37:27 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8684926A2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 07:37:26 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a6f3ef3155so797291b6e.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691678246; x=1692283046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sSsg/s76m035AeWep4dmzSsoR8dhjkTWjj9PHwSJB94=;
        b=NUgDQLptAJ3wlYzTjSU666suJ4YY9X3muczqtm3us9G1qV9/xrwoZ9VFuOkyB0Foj9
         f8UfiGSOnPlB0mtxQEOlirFbkrr3HuRsTbl4aWKAGA+zoPJdl7kmiPGdfFH/XGfIwlkH
         E3/rpbjc02LwlRisCCZmuwRc2n3gEvmV+6AAESwdIvJ3G3YVThiDAzlTqxGjnZfgHxLW
         8mjTn6WpuKqsApYsl96iehsgZTK0Ki+Xn1WLQOq1I/3X1P5YAUdOnhs4WK/wz96J6Aae
         5DB5WRMzyEsBoSrkC0mq/x7omZzfyzMQciDamqmpJwMcmuBR/C096ue8BWEoTbVk0PMy
         YPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691678246; x=1692283046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSsg/s76m035AeWep4dmzSsoR8dhjkTWjj9PHwSJB94=;
        b=gf/b4EgTV1aDZnbnUvvBVwoG4x3cIwcyJVmrwXf65S3h2VQIhYy3To6GLcbxlcohB/
         bNFUbyhARtSHvKJmvj/dtWwqUNUHvt+A2UNwuHJ4A6/WXJyRjLE0Ko7Ot9+YjjAwi7fY
         8hmTJ07X0b6ia2TxFRtVv3iBSTnyEQxxNw0bgbo54f2g2+1lH+pn7p6BFnuHSujeTWmb
         HCBQYAdz6SpGvUMgEJYPbryf2MW2zYccTnLyKqH+6igdsQ5dTukIef2S05x1Y+zxSe25
         kvXTEOqy1/K+q6b5MwLDFTNnZQDyZLVt0aX4c+a/g+X8dcfiptidIXPJ8XgTz/Y95wqa
         /19Q==
X-Gm-Message-State: AOJu0YwtIv9PUGyy+UqGLnsPliAfgxqtcxAVl4mVgiWI5zCy+EJOQiO3
        UeI3lgvbaAdbmGL5J1r+cEWVJ+Gyo0Q=
X-Google-Smtp-Source: AGHT+IFGkk9s33Z1lJZt0bHqdcFsWBF0WM8EAkJ2y5SYFiB8gN5rEKT6YO6p1jsPGpm+Sg3lmHNimQ==
X-Received: by 2002:a05:6358:528b:b0:139:e766:5cbd with SMTP id g11-20020a056358528b00b00139e7665cbdmr2223765rwa.32.1691678245730;
        Thu, 10 Aug 2023 07:37:25 -0700 (PDT)
Received: from [192.168.1.116] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id t15-20020ac8738f000000b0040fdcd391d8sm527360qtp.72.2023.08.10.07.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 07:37:25 -0700 (PDT)
Message-ID: <a2830ab8-e938-56e8-4f28-074262c95ed8@gmail.com>
Date:   Thu, 10 Aug 2023 15:37:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] t/lib-rebase: improve documentation of
 set_fake_editor()
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <8ce40f48-f36f-9e81-1a3f-9d8b170c4a0f@gmail.com>
 <20230809171531.2564785-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564785-2-oswald.buddenhagen@gmx.de>
Content-Language: en-GB-large
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230809171531.2564785-2-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 09/08/2023 18:15, Oswald Buddenhagen wrote:
> Firstly, make it reflect better what actually happens. Not omitting some
> possibilities makes it easier to fully exploit them, and not
> contradicting the implementation makes it easier to grok and thus modify
> the code.

Thanks for expanding this first point, the new message looks fine to me. 
The code changes look good apart from one change in the that got missed.

> -#   "<lineno>" -- add a "pick" line with the SHA1 taken from the
> -#       specified line.
> +#   "<cmd>" -- override the command for the next line specification. Can be
> +#       "pick", "squash", "fixup[_-(c|C)]", "edit", "reword", "drop",
> +#       "merge[_-{c|C}_<rev>]", or "bad" for an invalid command.

This is still using "{}" in the merge documentation rather than "()" 
like the new fixup docs.

Thanks

Phillip
