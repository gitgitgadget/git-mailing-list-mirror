Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 284801F462
	for <e@80x24.org>; Mon, 10 Jun 2019 14:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390716AbfFJOPs (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 10:15:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37970 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390682AbfFJOPr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 10:15:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so8613811qtl.5
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=moD+//Qz+PTiE+2FozWMVK90laVWjXFg2GwA+qpy1uk=;
        b=nR2V7Tq0WrcrffiHdQaP1lRFAm80P9PjXX8xbvVOns/kkHYtyitEAk0nkVdVo2Stj4
         bj36PhfDBFrcaRo8QxSOfZFrahjgOaV3968WMA6gVRDM9sH9zLMQdMRXAGKvXQ4Z5LXa
         zWDcARRwi6NpDfbaFGyYlvtAVUcHyvBAqF66rjpOFC5gNQQpxdsBzUZaWZlN6SyL6o0a
         PehZE/kVkKOHjUgG2VYYuhTsGr9E+/ZkzYkaE6JCUZiMM6Q09txBQuU9uMsnGhulK6Ni
         pbanSunhNYV5jqPA+LJEOP2ma4fJBa/fK3aG3TCD7KM1RD/P7mlV5HvivLh111J/Dedu
         UhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=moD+//Qz+PTiE+2FozWMVK90laVWjXFg2GwA+qpy1uk=;
        b=JbSZo2hMzTWVfEjUWw50aX8DwrSzz4TlCusgPYq7JNGhapmbsqk0Zzb4FbEsiS6qyq
         NSM5rpwRU9sNHsjuLVmqJtQRfpXw32IzCKnDqc2uCXW+nX8xiajzmzHTlkQWQZNaJHlZ
         aaK61mItBvEP1IAH0q7vPo/r0Kd7HTRXPQBYFgDY1zDrzk81MOP8+hReROtqERfsf1wQ
         0kqBvIx4n7rmC3+opss0n6FoaQ4nsksSCZCx5d0BeHbHpDBcygPy716C2WS3kkp4cXYq
         2XIovtoIAeBwrFXM9LUEmn87LK5OuwdRZeLuNSGNci/b/H11LUAB1RfgXxHKdacm3HNa
         JCzQ==
X-Gm-Message-State: APjAAAWhvGw2r/6Gd6K634IikAtVuxUbC+/OlwkrjTxTE2vAD6mT/llG
        Jf/7LubOGEnvINP0aF7adY8=
X-Google-Smtp-Source: APXvYqyzKoCAIAuU0MIf+kQhJ12p01k+O23sbFs7nwdFUBf+NCLRNyu0MNhcJZlSuv2lPb7c3f3bMw==
X-Received: by 2002:ac8:24cd:: with SMTP id t13mr22486500qtt.298.1560176146945;
        Mon, 10 Jun 2019 07:15:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:595e:cc67:d572:b4a7? ([2001:4898:a800:1010:a94:cc67:d572:b4a7])
        by smtp.gmail.com with ESMTPSA id y19sm6127959qty.43.2019.06.10.07.15.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 07:15:46 -0700 (PDT)
Subject: Re: [PATCH v6 00/11] Create 'expire' and 'repack' verbs for
 git-multi-pack-index
From:   Derrick Stolee <stolee@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        avarab@gmail.com, dstolee@microsoft.com
References: <20190424151428.170316-1-dstolee@microsoft.com>
 <20190514184754.3196-1-dstolee@microsoft.com>
Message-ID: <5fadd5ee-0993-ad94-2cda-f8dfe3795336@gmail.com>
Date:   Mon, 10 Jun 2019 10:15:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190514184754.3196-1-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/14/2019 2:47 PM, Derrick Stolee wrote:
> Updates in V6:
> 
> I rebased onto ds/midx-too-many-packs. Thanks, Junio for taking that
> change first. There were several subtle things that needed to change to
> put this change on top:
> 
> * We need a repository struct everywhere since we add pack-files to the
>   packed_git list now.
> 
> * A FREE_AND_NULL() was dropped after closing a pack because the pack
>   is still in the packed_git list after opening.
> 
> * I noticed some whitespace problems.
> 
> I also expect GMail to munge my added "From:" tags, so it will look
> like the author is "stolee@gmail.com" instead of
> "dstolee@microsoft.com". Sorry for the continued inconvenience here.

Junio: thank you for taking ds/midx-too-many-packs into v2.22.0. That
was a helpful bugfix.

However, this series was dropped from the cooking emails, and never
included this v6. Now that the release is complete, could this be
reconsidered?

Thanks,
-Stolee
