Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3041D1F453
	for <e@80x24.org>; Sat, 26 Jan 2019 17:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfAZRKG (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 12:10:06 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:35692 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfAZRKF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 12:10:05 -0500
Received: by mail-qt1-f181.google.com with SMTP id v11so14133281qtc.2
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 09:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=X5mNV7cERT27FZVTqozva7vyH7MmdIu2jIBxU2os13w=;
        b=JWAaLImo6xPA35htLr2pMZQxTVZ9rjhNzbIfrPB7uW526yC7eiufJO7qN9IsBzHT6T
         ogZG2P76r7hmbm7ItoBdGVKo+b/qzu5pUSP74H7q5/+GgXpu/wR/qtN+NVduLcMkOG1w
         Ovhoy0ItpC6uIs9p7UMoQwtHe7zElz4ZfcvL158ROz3IRgxVGGmbuTeCprxT9pbUe30q
         GewnPDpDNkvywNJGKMGSSJ9LOQjSdkFiP7k4pvFG6BMxYugPqlDUcogx0ReliJUndg9f
         5yXdfKSMV/q4kLBySuYNJ/TOJ/eTi1egDbPAXAteVZkbBsaQ5oFBsvVKio/yoReHLsjB
         V4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X5mNV7cERT27FZVTqozva7vyH7MmdIu2jIBxU2os13w=;
        b=s/CCLpPITbTCUaCX822acG/xXFkqVvVTA5v7AdlUj3IKWtIXB2Kly5ryywcJtDSlwT
         zPou84fDESsFWJH6XYnX8VhjEoNzvGa5TBab4Nld/kuXc0zEj+JwUfS807GIktx/JloY
         56VT/agcZoJMWleqlkLQjC430ykDm1ld+0TsRVyk4hcW7QxQcQz+uw3T9jQoIwJ+caxS
         goSPGONdseYEGYewdADFpkd0kyFl+OUvM+t4TRTJwY7AwcXqyyUVwOx0zdh5hWWkRTGj
         84Fn5SGiX8c7QIWa/zit+h71kGJHU0PM4jRxyGEJb8CwKyG4abByejCJXl10pqMsoKVo
         9/BA==
X-Gm-Message-State: AJcUukczOzYJ1dh3yOoDr9wnJfnrgzm1s1Th/7SqhrETezDDluMgFxsK
        PyN3yX1wQPYiAnAJpNeWHPI=
X-Google-Smtp-Source: ALg8bN4maYvbjZWqS96hhEPj2MhJvWErOF4vqatUpOUr9Xw+5KPW6Ftv+nMNNCuffuBWf4J4V/1auQ==
X-Received: by 2002:a0c:ae76:: with SMTP id z51mr14920254qvc.103.1548522604823;
        Sat, 26 Jan 2019 09:10:04 -0800 (PST)
Received: from [10.0.1.23] ([98.122.160.2])
        by smtp.gmail.com with ESMTPSA id p72sm65342670qke.87.2019.01.26.09.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 09:10:04 -0800 (PST)
Subject: Re: [PATCH v4 08/10] midx: implement midx_repack()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
References: <pull.92.v3.git.gitgitgadget@gmail.com>
 <pull.92.v4.git.gitgitgadget@gmail.com>
 <ba1a1c7bbbdbd8f3b82187763df4ec21b7032fb5.1548366713.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2970aa83-40cd-e721-af4c-a27798995eab@gmail.com>
Date:   Sat, 26 Jan 2019 12:10:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <ba1a1c7bbbdbd8f3b82187763df4ec21b7032fb5.1548366713.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2019 4:52 PM, Derrick Stolee via GitGitGadget wrote:
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index acc5e65ecc..d6c1353514 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -383,7 +383,8 @@ test_expect_success 'setup expire tests' '
>   		git pack-objects --revs .git/objects/pack/pack-E <<-EOF &&
>   		refs/heads/E
>   		EOF
> -		git multi-pack-index write
> +		git multi-pack-index write &&
> +		cp -r .git/objects/pack .git/objects/pack-backup
>   	)
>   '

Josh: Thanks for catching the failure in PATCH 7. It's due to this line 
that should be part of that commit, not this one.

Thanks,

-Stolee

