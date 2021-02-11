Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E6C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E32E664E2E
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBKCeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 21:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhBKCeS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 21:34:18 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6B3C06174A
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 18:33:38 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id f3so776058oiw.13
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 18:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9GDO+2KwuYYTY/lB1dRNKz6nq9hcR70aGuINhxBdPRM=;
        b=LKgny5e1kycw708lpc8HNcnci1SEiM7r6GBQRhS4j1zcdnvnO570px2tgcXQRfk4kH
         AEo22uzApa+NC0/RWJhieKLYf78mY/QMQ+GsgGXsw7kYyy4p7SgtRzxqvQRGiyt5wJx8
         hXAoRTMs+8I61LHm7EVlWcBGoYTi/FLx30OMtgT5iE9cgtyJfXE0UPashjVCJo3Bufmu
         HwSPNrK43QrMbVOnAQ5tgXVFmH6UIwxNzR4YoW9cYlf0nb3CUlszuSWxvUmRP/fUCH9p
         cgbQyGF7RHDvCx6PBQT5S9f7nUaiNEPfVAaV30oiFfxzWnwtkTGU9LpOnpTDi6Dohmwq
         7V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9GDO+2KwuYYTY/lB1dRNKz6nq9hcR70aGuINhxBdPRM=;
        b=IbAJkJzx0OI5UtEv0/+hsZ4VJr+e1GHiOXmyMNjpoUfl192Laq1gVSOxpgxaJxbWk+
         mvM3z3DUUgfWY2+bzIR/EYhxuqfoYmjK1Ry1MXlDh1iZxF1lHdpLFfg7Vqn04eHPGoac
         qjlAkZQAFzcn+SJsDmmj/NJFPgwzLD3jVBX3mFmt9mJDQYVt8wYMg2TPAeUQ0NI7PV7w
         IOMDh5jp2HoMm9X5Uhimm4Ow+DUJGCcY0yft4qd8ewG31vQdfSn7VvEEUVGaq82X8VcG
         7zAl2n1PMokbSWVoqnfPIFMf4THKGXGzDfcIgk58G09FLfiZVU4iAYPHxYA730YpdGzB
         46dA==
X-Gm-Message-State: AOAM532vEpOQ+wbZ1XzmlfyB2V2ndmLAEtxiX/VTfuWn2IaXFrgw7T9h
        1+Y0r/+r50PBUlxItSSbFTM=
X-Google-Smtp-Source: ABdhPJwMuLInZbVEOpEGDUIZ3VfxiwloJ16FJZuO5CKAGhxZX5kxRBKhoRy3a0kLuK+CdXr22cB0CA==
X-Received: by 2002:a05:6808:6d2:: with SMTP id m18mr1456652oih.32.1613010818006;
        Wed, 10 Feb 2021 18:33:38 -0800 (PST)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:5030:63f6:1d3e:64d9])
        by smtp.gmail.com with ESMTPSA id z10sm873759oid.51.2021.02.10.18.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 18:33:37 -0800 (PST)
Subject: Re: [PATCH 4/9] midx: keep track of the checksum
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
References: <cover.1612998106.git.me@ttaylorr.com>
 <b4b842fa1e8c711af30cc93b6f1100661791416c.1612998106.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d03263c7-56d3-575c-4ab7-56a617daf34a@gmail.com>
Date:   Wed, 10 Feb 2021 21:33:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <b4b842fa1e8c711af30cc93b6f1100661791416c.1612998106.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/10/21 6:02 PM, Taylor Blau wrote:
> +	unsigned char midx_hash[GIT_MAX_RAWSZ];

I was initially thinking we should use something like
'struct object_id' here, but the hash we are storing
doesn't correspond to an object, which would be
confusing. I suppose this is the most correct thing
to do.

> -	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
> +	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);

And this is of course correct. The issue will be what
happens to 'midx_hash' in the later changes. Will
keep reading.

Thanks,
-Stolee
