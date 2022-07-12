Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F5AC433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 23:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiGLX2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 19:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbiGLX2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 19:28:16 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1733DBBD17
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 16:28:15 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id r12so3700319qvm.3
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uP1LStyjZyMlpja/PKRxuOxsMXja0r2v6vfi8Swb3bs=;
        b=EU8Ivsc8ZDG0dS5MLRhb7epA1/DHgg2NqjUBKYh205jd3Wp5auHv5XNS7arrNadx3F
         CAA5ttRtmZNwTT+5L1362jETuI3nkHh0SOxiNdZJJNtb9Fo+N4LJb0+nw1yN9ac9ru4e
         Ge2b2nLC/+PWDwQKnM0uMINmrL56G55NQL65U2o6g6g/5fhrzwbps21ezJAlusd27c96
         szeJ70pA8SZCt8W+/9fnxFKVVAyrndAnOVYC8quygpTKbKEMkw0aAC8epZb6I+QPeKj9
         yqc1TkAQVMrIrwCTpfMjAsnvmyv6D4i0aMY6AUVTfnaEG7Ayooy8CoLQ+chPGCUUkrNE
         Ds8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uP1LStyjZyMlpja/PKRxuOxsMXja0r2v6vfi8Swb3bs=;
        b=muFa+ifrDmiikkXfTXtpV9fZnRa8H2RdwuieZ2UfquBSS2Nz2pIMTgBompC91IpB4i
         CSSkGhSVSWoyZvqN8gVvUCFeQAvzSs4/uxdxqgeYHPGcDf94jBX6BZ4wjriEMio4WReU
         Tkvz/+7X09V4wh8EohDTKZZ+VBX8APcbXo/btd0rk0XUX4El3zTpqe5WhMmZqKxZ5VBr
         lY2Erxm54G1uvCM8wWObTtFGl8o5Q2/vl98j97UlbFA1xXWeTusbrHIWjtmJKpkVzHxO
         HvT2ja9lexqtVB3pnWXDxWAlhz7A8cxw5n2PiiFA18H59H7+6vUwxDPQOMrM05FUQciu
         4Fbg==
X-Gm-Message-State: AJIora89xnaDAqpv/j8WjXBVOVfnOaYm+5CuDqtd/gSmR2PQ4WSHsS/N
        tbR10mwDuIdAGnWneVEAeCOKNg==
X-Google-Smtp-Source: AGRyM1t5+aVET17DypXhzo9m1VPdYv3h7104I01kD9mPf1vBNadlzc93nAlcKCY/72meGRJ3dOg8Zw==
X-Received: by 2002:a0c:fe02:0:b0:473:1ca:51f1 with SMTP id x2-20020a0cfe02000000b0047301ca51f1mr601380qvr.5.1657668494197;
        Tue, 12 Jul 2022 16:28:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y17-20020a05620a25d100b006af20edff0csm10523003qko.58.2022.07.12.16.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 16:28:13 -0700 (PDT)
Date:   Tue, 12 Jul 2022 19:28:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: ac/bitmap-lookup-table (was: Re: What's cooking in git.git (Jul
 2022, #03; Mon, 11))
Message-ID: <Ys4DjW9JjQFx5Bhb@nand.local>
References: <xmqqo7xufee7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7xufee7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Jul 12, 2022 at 10:07:44AM -0700, Junio C Hamano wrote:
> * ac/bitmap-lookup-table (2022-07-06) 6 commits
>  - p5310-pack-bitmaps.sh: remove pack.writeReverseIndex
>  - bitmap-lookup-table: add performance tests for lookup table
>  - pack-bitmap: prepare to read lookup table extension
>  - pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
>  - pack-bitmap-write.c: write lookup table extension
>  - Documentation/technical: describe bitmap lookup table extension
>
>  The pack bitmap file gained a bitmap-lookup table to speed up
>  locating the necessary bitmap for a given commit.
>
>  Will merge to 'next'?
>  source: <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>

I think that this version is pretty close to being ready, but I haven't
had a chance to look it over carefully yet since getting back from my
time off last week.

I should have time to review this in the next day or two, if neither of
you mind waiting.

Thanks,
Taylor
