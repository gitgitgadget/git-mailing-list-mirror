Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70401C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 12:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5121B6140D
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 12:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344560AbhKRMTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 07:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbhKRMTf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 07:19:35 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD41C061570
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 04:16:35 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so10555720otj.7
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 04:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=meL+BtCVU8lUnOUy0ZrYxHAHHh+hFL1BDV2sSsYLq0M=;
        b=bot2DPvG1vux9M75bbNu+sqbUJL8Mdgkp7biGtkGhBuZ0YRAPTatqz2HPYbS5iJH5U
         g61SbN+T7Q8KRNv8SVG+G/rs1dHFwSe4VEk3TXyQRCt6/jf62KP7Lh/M3wL3lxxrpBzd
         fSJZa/37aLhy/1mRu+PtA3YFZmI92QVDE0fy3ylmxKgK6ldQew5LHTedTw6TGw7pc0H0
         teNInknNe96huxPaszx7t32JH9DISP36PS+fA0deUvYHh0JOAnKxfv9xSFRPB07a+/V1
         R5uxLt8RGoTP4+ke1UJhozqyERcuosGYc/ohTLVzu/PAKz9uoSb1IBZz/WFCEsm+/WkF
         yzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=meL+BtCVU8lUnOUy0ZrYxHAHHh+hFL1BDV2sSsYLq0M=;
        b=r+u1/VKp/u/VgJsqiuBKZlvk0d+QeQW1/42QkToOeQKceByxRvueJ+ig33kHbSaB8F
         RZHJxV5OeTdAnjM/wVt84c5H6aJGDQ/CBfCVc7QbuQjLNY0vNX4Cisw8qtYKeCBY13Pn
         NR1PByi/0GLi8qTCUDtXv3ifOyz0wzMzeR9mdRHpOvYgBCxoUtis+jFSEWa86EUmitU2
         ANypAT8h+cDIMxOOlMiAt5+M+ROgm/XhFXZP1gODMoN0W6XYPu9MvIDfEwoheSY8WhG8
         ovxkmukJWR0IkBVPR2CmwCwU2ok4PvV2KtOkqtA1JP3mVN8yDpzKyPNFzeoVzRW8HVJg
         3h+Q==
X-Gm-Message-State: AOAM530h8uOEbRdUSOzXSnl2zTrQQPvNG+Pq6QcDQIe67+pOu+cEasLD
        voLWU7KPej3RyRlOWm40X0e8Buj0Pvw=
X-Google-Smtp-Source: ABdhPJyrYduL96uhdiIVu216+dZG4Mgt/eeg9aFPw3W71G+irSMwyTIrBd67hbYd5AfA1Ca9EInN1A==
X-Received: by 2002:a9d:1b41:: with SMTP id l59mr17603583otl.318.1637237794925;
        Thu, 18 Nov 2021 04:16:34 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:c9a6:d4b2:1fd5:1a81? ([2600:1700:e72:80a0:c9a6:d4b2:1fd5:1a81])
        by smtp.gmail.com with ESMTPSA id be12sm775004oib.50.2021.11.18.04.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 04:16:34 -0800 (PST)
Message-ID: <072baa38-9155-f417-12fb-4a97280daa6d@gmail.com>
Date:   Thu, 18 Nov 2021 07:16:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 1/1] midx: fix a formatting issue in
 "multi-pack-index.txt"
Content-Language: en-US
To:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com
References: <cover.1637218943.git.dyroneteng@gmail.com>
 <9b910a44f4143c94787110a688f2b17ba4eeb0fc.1637218943.git.dyroneteng@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <9b910a44f4143c94787110a688f2b17ba4eeb0fc.1637218943.git.dyroneteng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18/2021 2:11 AM, Teng Long wrote:
> There is a formatting issue  in "multi-pack-index.html", corresponding
> to the nesting bulleted list of a wrong usage in "multi-pack-index.txt"
> and this commit fix the problem.

Thank you for the detailed message!

> -- A list of packfile names.
> -- A sorted list of object IDs.
> -- A list of metadata for the ith object ID including:
> -  - A value j referring to the jth packfile.
> -  - An offset within the jth packfile for the object.
> -- If large offsets are required, we use another list of large
> +* A list of packfile names.
> +* A sorted list of object IDs.
> +* A list of metadata for the ith object ID including:
> +** A value j referring to the jth packfile.
> +** An offset within the jth packfile for the object.
> +* If large offsets are required, we use another list of large
>    offsets similar to version 2 pack-indexes.

LGTM!

Thanks,
-Stolee
