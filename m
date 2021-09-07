Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6E4C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 08:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E081061102
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 08:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhIGIT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 04:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242407AbhIGITV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 04:19:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BF6C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 01:18:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mj9-20020a17090b368900b001965618d019so1024437pjb.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 01:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bn+SX1a24h9WvgqxZ80KqQYVPVraAp/VElqyCAIM8xc=;
        b=Afnx3GNRCNw9o319o5oMsL5oGfh+16GOLQdpyWsbLNHaZ/g2ziouFUSmRbBM5oddT6
         crXYy7fqv+bEDtnxnjJ7y1KdyMfwbjFK5VOsbyixLaNHFh63/nv4OIy3gko9LVXQBOK2
         5HwNDI4oqjLWKAN8vW/r813HJ8vxuDy8XChaPbVAnrzCNYrBNAGwqBSb1KW6XjO+aHm3
         Jj3ZO/EM6iNb+1pUtvsc8v20W1krALtMVStDCGMgNDIzWXFY97VcyeDc2DhXX/TEG5Jm
         qC8dT6DeGM4d6zM9KKXY2RS+BSTLV4awTD8i78qjsLeslGRXaz5lPtDksZUcl8V+0tBf
         SBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bn+SX1a24h9WvgqxZ80KqQYVPVraAp/VElqyCAIM8xc=;
        b=A8ACT/DPIUXt50+WgGboqBPkg+G8kR+RXXwkxi39s0CbXblpQt8wi9jXNdSTn5Jpad
         kOEVbG4X5gctE8FAvuke7YGUHxa/uMrocnBRqzrhBbWXHkcLncsnKt6aFWxjWGiu36Ir
         ZR5iTsnS4HmVQgpgZoqnMNnbyIsxNomKshjmMLdXxMyVvkmGIgmxVB4US61Th5QKbLYh
         IoYfs53FOBOIxyZGRPNDeNtv/N7kd2bsGpf62IhvDvWa//WYTl95keolgsEyuqdffAAl
         CHk9JS6VqHSW8s6ncRsKitfVMiNYaufr4nZFwWVjzIXiqHYmdngV60LNhKMj4y4zgDaE
         V/mQ==
X-Gm-Message-State: AOAM532YNAtoQINs8slOA9QcOvJ3vthGkYqedVdFaOIjbNVRe2fxaDTz
        MuojBPFDnWPEQidCrQP+Wz0uNVkDzz6TGg==
X-Google-Smtp-Source: ABdhPJylsS6hZUnQD/ULvLHHgm472QxEx3gpKG7bHFr+SkGe/isc59ej9iZH9xvLTbJUkReMpKRn4A==
X-Received: by 2002:a17:902:7ecf:b0:138:fe47:3068 with SMTP id p15-20020a1709027ecf00b00138fe473068mr13898948plb.21.1631002694782;
        Tue, 07 Sep 2021 01:18:14 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-58.three.co.id. [116.206.28.58])
        by smtp.gmail.com with ESMTPSA id c24sm12467994pgj.63.2021.09.07.01.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 01:18:14 -0700 (PDT)
Subject: Re: [PATCH 2/3] Die if filter is attempted without a worktree
To:     Calum McConnell <calumlikesapplepie@gmail.com>, git@vger.kernel.org
References: <20210906181002.625647-1-calumlikesapplepie@gmail.com>
 <20210906181002.625647-2-calumlikesapplepie@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <a20bd60e-7445-131c-e9f3-548bc8dcf1f4@gmail.com>
Date:   Tue, 7 Sep 2021 15:18:08 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210906181002.625647-2-calumlikesapplepie@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/09/21 01.10, Calum McConnell wrote:
> +	/* The results of a nonexistent worktree could be... weird.  Lets avoid*/
> +	if(dict[1].value == NULL){
> +		BUG("There is no worktree for this worktree substitution");
> +	}
> +

Why don't simply print that error message without BUG() (aka using 
die(_("message"))? It can be l10n-ed if you using the approach.

-- 
An old man doll... just what I always wanted! - Clara
