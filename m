Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8629CC7EE24
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 15:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjFEPvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 11:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbjFEPuv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 11:50:51 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7E41A7
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 08:50:37 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-565eaf83853so54763017b3.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685980237; x=1688572237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TS61atI0XLMLxr+mbgle9dFqLF9uBTE7xVWATSTYJnY=;
        b=UjdYkTQ0jiGu9jD3qwYsNROLkfThXczbSt1stpgq9EWZe2qIaNPPCys7BuEyi39uMS
         slO+Zuig/44mnBv5MK+wRKe8xV4onNafnTevKhUkQiPntmWo2hZ0nhnLvdMCpEHd0DmP
         Maz2QYIO+puiPz8vnqW3iEHe3ENkS9ve9ewwsgdHCu340J7eHPql+G3SEX7BuQV2xDgD
         wze+dDUCWgHmKlsFe9kUZiVjH2AMI4GNFP+Ubo7mRJUOHFxI/MZS+q48bEZTqxQekcA1
         LBorYldKqnDFg/BduXAkHk5sW+VWnQ+bVS2G/zgQMmvhy3wV0cVu4+fanTH3v6ikMfK5
         6EQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685980237; x=1688572237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TS61atI0XLMLxr+mbgle9dFqLF9uBTE7xVWATSTYJnY=;
        b=Gzy8fRPRZJ21vMhkw25MHDn/qY8d9PHQDXkypBeeGoQlVX3ArBIOWd0hCkleQDvmMx
         2m1fQ6NVY4Hf50fRLLQwtpJF3hjq37+Xk6vRJhYlwTE7teqIdltJjvYvfD6fKMURsnUR
         luYZC7vpMFgfmq2xiXpoi+Fi8qGbx1LHVrm4XGWYQS1s/mbciqr3WSG3q9TI2TyednvW
         Fiu4FKszHGOawqH6QZknxtpBpg/rX59aCLvP0S6mt+kOLiVxIJXNemQrOOsx7VZFYSZW
         mpnBwpQM+Ta68UiEdFkWk5CJFsBD3fI/HGKVZ/h+psvZApzvcS1tZuGJb/QIGg/cqYv9
         UssQ==
X-Gm-Message-State: AC+VfDwJ+Jt2XZpf4xy0gdabz9vIuI30T9OFKGYG22rbEcBXokAvZ86n
        rDVyDz3o1KOJqNMIP/z3FGpn
X-Google-Smtp-Source: ACHHUZ4Xy7TGz06E6EM+Xi+Xl9n0bllVOLK5ifDiPIK7aXt9KpnvPzE2RUg9F1iv10O+qW4uyqi/cA==
X-Received: by 2002:a81:6d89:0:b0:565:798b:949e with SMTP id i131-20020a816d89000000b00565798b949emr10441333ywc.20.1685980236784;
        Mon, 05 Jun 2023 08:50:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6cc2:3d2c:f002:d37d? ([2600:1700:e72:80a0:6cc2:3d2c:f002:d37d])
        by smtp.gmail.com with ESMTPSA id v1-20020a0dd301000000b00559d9989490sm3437677ywd.41.2023.06.05.08.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 08:50:36 -0700 (PDT)
Message-ID: <221ddd01-c058-dd87-9f3f-25146770f606@github.com>
Date:   Mon, 5 Jun 2023 11:50:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] Fix memory leak in get_reachable_subset
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, Mike Hommey <mh@glandium.org>
References: <20230603002819.1122129-1-mh@glandium.org>
 <xmqqedmt7167.fsf@gitster.g> <21d3f105-ed32-e397-a1fe-53344894bd44@web.de>
 <xmqq7csj6dok.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq7csj6dok.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/2023 12:42 AM, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Stolee reviewed it already when the patch was sent the first time, here:
>> https://lore.kernel.org/git/20230421234409.1925489-1-mh@glandium.org/T/#u
> 
> OK.  Thanks.

Thanks for finding this link. I saw this patch and immediately thought,
"I made this mistake a _second_ time?"

The patch continues to look good to me.

Thanks,
-Stolee
