Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428AEC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21DFB610E7
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhJMNcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbhJMNcD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:32:03 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF7FC061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:30:00 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t4so3815284oie.5
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rkHDkXy9Wgni37SEimE6FbWMukqqx5x7johrlS8UBJw=;
        b=mOnBQ+MURWhi1Y9whV3NhAqhmKBcqNCtQia6jgMopTfm7CZ1ckWReaEjWULRp5GY1l
         SzZPU1vwOCr+tfHBNUS85YoJOBDsW6HvsqE18Z603GxZRn7DdxbXQ/+7NoqonQxzkj8v
         m0oIj26Z1qqYVXwiLe/F0sG0nwCKOLPvRZf5i/oRVAaCxsqnF530Ofh+bMiv/kVCuDrK
         P3/Qrw78yG2+CzQMmN/WQnTZ7GzFWp1gF+ct5DvUXR7SJE0TZFAGkSR2N8YbFeSZQHrL
         UAGu6IGV6IAAFl/TojL27hu6L/SM3aCMj7B5XzMhCU+jD5fwgclt9jQzVPMROWmGMzGX
         hvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rkHDkXy9Wgni37SEimE6FbWMukqqx5x7johrlS8UBJw=;
        b=dEJj3HUiAhEnsNCWv55Su9FGdvhXTJvdaVKu3ARI7xGb9oAqeRfcaKo1ufgQb822qL
         z/GXP6F67FyASlm3/pLUHd/3aXaPaFZKaFoBz/lMSn3pSztiGHIzNLMJa17P4wmalDAm
         xTiqMej7b5s1KQuVK5J3mlVUnATQPH30kXLeVkDS9z086mCyN7qczRPR2VyTm/0tspLs
         7WflfwewLrw1ApYZVM5AWp15LiQkEZevWCAJJxNQ5/a9WJjzismaL11lRTKTSIHkN6Uz
         H6Wu2QRVur+Mbf9dbD34Vtmbouzx5c7sZ2o0aXTXX7Arnb3mJbgM3b09IyhFpRm6l0NW
         AiMw==
X-Gm-Message-State: AOAM532l7ntm8TS2POWLOisWM91kKZrkpx3YNwVZemLBPx7LugSrWWS3
        cNcaurYGZUojPsj6+xuf9SA=
X-Google-Smtp-Source: ABdhPJyieD6OsvY+q3Nq457NxJ096YpxlyNAj1vw3TiUdXzsgkJOWBMHxsK5TIqw3wYDoUuDd12DSw==
X-Received: by 2002:a05:6808:2287:: with SMTP id bo7mr8281960oib.74.1634131799894;
        Wed, 13 Oct 2021 06:29:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4c86:317:426a:54d0? ([2600:1700:e72:80a0:4c86:317:426a:54d0])
        by smtp.gmail.com with ESMTPSA id 38sm2963848oti.13.2021.10.13.06.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 06:29:59 -0700 (PDT)
Message-ID: <42a8d2ef-3a67-ca2c-4334-b79975d45da7@gmail.com>
Date:   Wed, 13 Oct 2021 09:29:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/4] midx: avoid potential rename-while-mapped on Windows
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, dstolee@microsoft.com,
        jeffhost@microsoft.com, peff@peff.net
References: <cover.1633729502.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <cover.1633729502.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2021 5:46 PM, Taylor Blau wrote:
> (This topic is based on tb/repack-write-midx).
> 
> While looking through some failures in t5319 when Git is compiled with
> SANITIZE=leak, I noticed a curious pattern that basically looks like:
> 
>     struct multi_pack_index *m = load_multi_pack_index(object_dir, 0);
>     /* ... */
>     write_midx_internal();
> 
> This can cause problems on platforms where a memory mapped file cannot be
> overridden via a rename, because load_multi_pack_index() builds a new MIDX from
> scratch each time it is called without adding that MIDX to the object store. But
> write_midx_internal() loads a MIDX from the object store, causing the same
> region to be mapped twice.
> 
> The details are fully spelled out in the second patch, but the gist is that
> while write_midx_internal() unmaps *its* copy of the MIDX, the caller's copy is
> still mapped in memory.
> 
> Strangely, I could not get this to produce a failure on Windows, even though I
> would have expected one. I asked around off-list, and it sounds like it's
> possible this behavior has changed, or Windows' mmap-equivalent may not lock
> files that fit within a single page.

That's a good possibility. Once everything is loaded into memory, there is no
need for a file handle.
 
> In any case, we let's side step the issue entirely by only interacting with
> MIDXs that can be found from the object store.

I think this is a good strategy, and the patch series goes above and beyond
this one failure by making it easier to get the MIDX from a specific alternate.

Thanks,
-Stolee
