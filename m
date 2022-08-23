Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BB2C32789
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 18:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiHWSMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbiHWSMG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 14:12:06 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF87719AC
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 09:23:56 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t140so7758900oie.8
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 09:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3hUo+KgOwn4EfFfmfYKfP1Hjo8FB438LcsApNr38ZNg=;
        b=M1Xnc1wrwPb67ivJM4nX+cTI6BtIb2OYgZZ5+iuLUBwwTKEZsv0sDNJjPuQYACVYE6
         8J4lM3K7AikCJ42RoXacTpWCCmZWI95lKhD2MwwPZXGBPjljhR5roLcx7Di8CCgRiXzt
         Vzcf6v4Zi/ncrk6C9yhQR49smgKDELbFj1IOGQNrxLTGdWvkwE6TAUOKVojggNvO8tTK
         RhZ2y/vCkCkjhtTz33gIjxgNEpbvBMtceaoMYZgv0Idivrfj6mxLFV90nO1Chach++x2
         MMDe6NazsOzqqXA7b3K3FtDpbXUNe6VVlMGUQBRI3TbVy/uGfTtpGXAHZnMKjiiakEfb
         sJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3hUo+KgOwn4EfFfmfYKfP1Hjo8FB438LcsApNr38ZNg=;
        b=Jawq41UxQE2fUchpS0LsW+pnYeOxlpagFUffHSzggVylrYi8fradVrTvBEF6lrnyzL
         pSN3IFnHt7CIdo0vfWS/GQOI1jfVh1njCWUVrdEfSStx0EIIXCSn9LTMjC6blNo2e0RY
         4BqL2MY4ytFONDxdXhcNbu/gx7g5U+5QqDnkrVMZTGQQKoyOuAWi2I4BQf6/3IT8yOXV
         hU4kCoC1bzJ5zfVmBeSSpvitbgGVbmgLuZhiISR/afKxRpVG918DsPaAJN53aT8SVkns
         TQWG5uS6DBOkwf2E2B4xPnSFP1r26pQ9QpeWyQef+bsyvuMWCktRiDK/ub4DC9vJAtQ1
         rJoA==
X-Gm-Message-State: ACgBeo0IBRpLRGSpkEevFm3KQaaMBxxFdnU4csfSHdHbKnPUgnAKgUAa
        0C8X4gzQ8yzPDUlpfffMhFinOYSfdQn7
X-Google-Smtp-Source: AA6agR5EjMw6PiPd6scZLMIr29onMwKBy/LhVAwMcyt9qlzCd9dRpQN2EGjnx/YFAvLKMsnnqKwVNQ==
X-Received: by 2002:a05:6808:1442:b0:344:a466:83ff with SMTP id x2-20020a056808144200b00344a46683ffmr1711577oiv.204.1661271835709;
        Tue, 23 Aug 2022 09:23:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f1b9:9fd8:f860:8737? ([2600:1700:e72:80a0:f1b9:9fd8:f860:8737])
        by smtp.gmail.com with ESMTPSA id d12-20020a056830004c00b006339b36127dsm3848767otp.3.2022.08.23.09.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 09:23:55 -0700 (PDT)
Message-ID: <be9c7c72-ba24-3e1a-8428-58a2e2afa09a@github.com>
Date:   Tue, 23 Aug 2022 12:23:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/7] midx: permit changing the preferred pack when
 reusing the MIDX
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, jonathantanmy@google.com,
        kaartic.sivaraam@gmail.com
References: <cover.1660944574.git.me@ttaylorr.com>
 <cover.1661197803.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1661197803.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2022 3:50 PM, Taylor Blau wrote:
> Here is a small reroll of my series that resolves a bug that was
> reported[1] by Johannes, and investigated by him, Abhradeep, and Stolee
> in that same sub-thread.
> 
> As before: the crux of the issue is that a MIDX bitmap can enter a
> corrupt state when changing the preferred pack from its value in an
> existing MIDX in certain circumstances as described in the first and
> final patches.
> 
> This version incorporates some cosmetic changes suggested by Stolee, and
> adds a new patch on top which avoids adding objects from the MIDX that
> were represented by the (new) preferred pack, since we know we'll end up
> discarding those objects anyways. For convenience, a range-diff against
> v1 is included below.

You resolved the comments from the previous version well. I'm happy
with the changes.

I have one style nit in the new patch, but it doesn't merit a re-roll
on its own.

Thanks,
-Stolee
