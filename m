Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F6141F731
	for <e@80x24.org>; Wed,  7 Aug 2019 13:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbfHGNvv (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 09:51:51 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39814 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbfHGNvu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 09:51:50 -0400
Received: by mail-yb1-f195.google.com with SMTP id s142so2347967ybc.6
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 06:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LY8sz5pHQRAVcoNTd5Ioja7nkQmWGnmmnad/F06VfG8=;
        b=c8ngHJR68lADNGteoDDJVCbxtybp8KjcTp2up8HUAh5OiTdeZd+LS5jsfgz2wpoRBc
         r1or3kQqpE3jdMCbEKKzaTDs4MS6LBShjZE7kbftMaAxn6EUSWoVbM73kzE4arCF9pGX
         kvs+55qUD6CmZNEt6/04C/ooQ78S1NNBxHYthZrJOPNJHrPGdRzssCobthVF/sz+x8aV
         RPn3TUu4BuHLZUmjk0L0LN101H3FlnhOChtRPje0LuV/sJi7AHDaS8Km7ib24sScXcUf
         sQrScX2r54t9aZNKgU2B1Kn+Qhn5necnJYBi04mb8VmZSkNCZFyEsIe9xRDpyzkVpAg6
         32qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LY8sz5pHQRAVcoNTd5Ioja7nkQmWGnmmnad/F06VfG8=;
        b=ZNxN7Z+mljI1QcuTFS5bgAqWkzx0QOzijdYwauBKlWrGVGwa4o2P6dKiE8PE/mWjgV
         PXcwl8ZmAjvx4/t6sw+t4tuimio3M4dQgkmGhwfnI9LtaGDArE/nlKCJnHLpCTp0ZP8z
         d8m0iUDwlSxulRiejbmc8SlpQS+B0DL5eqzGpf4t2SUdSaGhIbEjKIaznm76lGiZpidl
         HXH8zDZILl5MKlzV4d9AS4UHZpIUWcKrbP2PRNenmVQN4tB7gNeinTjvMAulx9kXsaqf
         Xvl6bvkbY/il8V2BpkG2b83DZXk4A+o+P2+cF1grmLI+bTYacAmu6X9Uy2VyLZYnqPAg
         o48A==
X-Gm-Message-State: APjAAAW3TnwBPvQK2jg4hn4Kqji3MdCK+uEyNeHlBMYzwCS9RqDlopr8
        oCQ4VIU/JBioS3PuWfUULb4=
X-Google-Smtp-Source: APXvYqzkas4pxMPhtNRSWjelpgMylBybVmpaplcdg1WT0JJD4e2LRbgkfeptVR/lEA2c+4KdohNIww==
X-Received: by 2002:a25:add0:: with SMTP id d16mr1410789ybe.502.1565185909842;
        Wed, 07 Aug 2019 06:51:49 -0700 (PDT)
Received: from [192.168.1.12] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id k67sm18462470ywb.68.2019.08.07.06.51.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 06:51:49 -0700 (PDT)
Subject: Re: [PATCH] sha1-file: release strbuf after use
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <fa6ccb9f-11cd-7eec-fdbb-2de6a0bfcecf@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0d3c8de2-52e6-0e79-b2a0-056302847d43@gmail.com>
Date:   Wed, 7 Aug 2019 09:51:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <fa6ccb9f-11cd-7eec-fdbb-2de6a0bfcecf@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/7/2019 7:15 AM, René Scharfe wrote:
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Patch generated with --function-context for easier review.

Thanks again. LGTM.

-Stolee
