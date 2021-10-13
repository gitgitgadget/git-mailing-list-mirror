Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9875C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B396109E
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhJMNai (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhJMNai (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:30:38 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3248AC061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:28:35 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id n64so3842251oih.2
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LttuO1nhvCTk9UY19XWle4EUzVuHYOzQBjTd+W6jbIc=;
        b=lyrXNH1oeKJ41hjLbhSJ+QlrwcFFjsaX3lBTaySamyueHtSaV0lc9v960Djz/G6t2g
         e+vhE2plLrLcYOZXxlAc9JDKD0eiWpao8ep+RAqaorOTNHics5rARs/jv9TF1zohJjN1
         YPqWM/cFzimNmz1yQP2ed1tfOU28QTDK2VOfSO/tKKBoTN4mBVKN91zxwvvuIB1DqlKG
         AVek4nUTn9PFYvbXQye/KAkiOI6kubXzqVn5X7X1bps9x/H/ADxvIxeFp3MVfKDit1mB
         0bCpC5P91Wm0rnYzqBew5PbDg/opLBj31Zkp8TsTrqIIjriLYwv9Dg0skKMWNWps54Th
         1qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LttuO1nhvCTk9UY19XWle4EUzVuHYOzQBjTd+W6jbIc=;
        b=Z0vUJLRNhEtyPRJPBzoI1X1w3FLq4i3bjCHYHITYd3VZbWRl+D4geNbqMlW1Zd9oe4
         H9dqpnJrDzhKS+1bGyAWe2TmgPodJJ2NenncZxUunhk2KQohwgEXNJ1buvPknqkgxst+
         FMiwSFhVRtIULDh6h00Q72+O8sg+2nPHKa7z3HFkzBL1RabyCPib7dRU+jVOFZ08TgMK
         qGeNGpzt9iebjNxE/yxm2MdwY068nkNFMFKMd1mOBNX2osDXUCAZTRA86Hfl6mcVHmWd
         EzbEvbLmwOhGiEDDiFwbTH+xuTFRRjnkmyFuiwYUvSaZEe+v1vzIZBsO1OigI8HrRs/L
         7xNQ==
X-Gm-Message-State: AOAM532e5TAwWAd899U9krNY+SXf4ok6as7i/0jSxF1uEzZhvCHeDOUy
        fkZIJUS2EMRPZTk0G7e6VI0=
X-Google-Smtp-Source: ABdhPJwdZGO8sq6M/Eh1izBI6U58YP35xR2qZkyyGRxJR6IPrQqiPznFNWXgFBH8Z3hPESo9AvCTRw==
X-Received: by 2002:aca:4b84:: with SMTP id y126mr8136809oia.127.1634131714450;
        Wed, 13 Oct 2021 06:28:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4c86:317:426a:54d0? ([2600:1700:e72:80a0:4c86:317:426a:54d0])
        by smtp.gmail.com with ESMTPSA id c9sm2366344otn.77.2021.10.13.06.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 06:28:33 -0700 (PDT)
Message-ID: <9203050e-7636-6dba-c3a3-0e5b3ca23e29@gmail.com>
Date:   Wed, 13 Oct 2021 09:28:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/4] midx.c: lookup MIDX by object directory during expire
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, dstolee@microsoft.com,
        jeffhost@microsoft.com, peff@peff.net
References: <cover.1633729502.git.me@ttaylorr.com>
 <84e95aacbdfb092082d0ca467892552982134774.1633729502.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <84e95aacbdfb092082d0ca467892552982134774.1633729502.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2021 5:46 PM, Taylor Blau wrote:
> Before a new MIDX can be written, expire_midx_packs() first loads the
> existing MIDX, figures out which packs can be expired, and then writes a
> new MIDX based on that information.
> 
> In order to load the existing MIDX, it uses load_multi_pack_index(),
> which mmaps the multi-pack-index file, but does not store the resulting
> `struct multi_pack_index *` in the object store.
> 
> write_midx_internal() also needs to open the existing MIDX, and it does
> so by iterating the results of get_multi_pack_index(), so that it reuses
> the same pointer held by the object store. But before it can move the
> new MIDX into place, it close_object_store() to munmap() the
> multi-pack-index file to accommodate platforms like Windows which don't
> allow overwriting files which are memory mapped.
> 
> That's where things get weird. Since expire_midx_packs has its own
> *separate* memory mapped copy of the MIDX, the MIDX file is still memory
> mapped! Interestingly, this doesn't seem to cause a problem in our
> tests. (I believe that this has much more to do with my own lack of
> familiarity with Windows than it does a lack of coverage in our tests).

You are fixing a bug in two ways:

1. This change ensures we use the 'struct multi_pack_index' that exists
   in the object store, ensuring it is closed before committing the lockfile.

2. Without this change, the change in patch 4 would cause the 'expire' tests
   to start failing on Windows, because the commands would die().

If our tests also verified that the .git/objects/pack/multi-pack-index.lock
file was missing at the end of the command, then we would have caught this
bug on Windows. I don't think that's a reasonable test, but instead we(I)
should have used the API correctly from the start.

The tests _do_ verify that the expired packs are deleted, but the new MIDX
probably refers to the old packs still. Since those packs are not actually
used (the necessary condition for expiring them), later Git commands do not
attempt to load them and hence do not fail. That is, until we try to expire
again and likely get warnings about missing pack-files.

Thanks,
-Stolee
