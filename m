Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE1AC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 21:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJUV55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJUV54 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 17:57:56 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8F32A935E
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 14:57:54 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p16so3465668iod.6
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 14:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TABLeno2e9HQZG7t3KMWohdeU4utIphTqqpVnYTz5kU=;
        b=AkhGGGSGEogY9F1EX/uBldDE8/Rp5mcNR15tjTSGx9m2mooTry7xI8k1fVRBdN7AGY
         oTOeavTAxxCwSvyN7qqexXrDzxDzuUMRRyub/89MJT8epdGEoxMKkfvDdr3vwp8SBBQT
         vct3QpEyGFv8ZlU8RIQ6YhKtq4WwcS4S2HCrpalDsdkGH4nX9jZ4BUkApo2Oartj2bua
         sHZvUv76Paf3qafkjG9HT0e1f3Yl48LUrCQ6NUCNn6PwCoX7rQVn2eZGUC07TrrFtpSn
         zvYHrFwuJkSEMTxqwUg/SkIeW8cKVqCjvisVZnyxOqsbjO+/sd+XGRjMq4dhV3Z0BzZC
         8DVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TABLeno2e9HQZG7t3KMWohdeU4utIphTqqpVnYTz5kU=;
        b=Zju/fMYch1mCNofx+/9fmSyFiTerqMKpEw5ZxHlZbuKmIu+Gzz/RcNfHwazf90rHKr
         /75u8OACC6p/Mo2ZWqo2t5N85blxWE6ar+qJad1CwxT/lDCWnFkQOENSePBfpmFZZjhe
         bP0nOWnv8eKbg9YHAlY130veXU2pd6yCJ6t/+dTBgcJTHMME8BDV3CX07lWxOSoQAbmA
         DhPf/pKBeFfCnWOw7J7B7rEZRi5xCmNk8pS7GnW6b0Uv1CR+olJ16uYYoLAaPQ0FVqsX
         Pr2inmu6m8/A95vE+BOGFm63sozdNVrzPKL/mxAq/Qea4u9zUgX7UnspDSSVzRYZ+AeW
         RJJw==
X-Gm-Message-State: ACrzQf1zbgXS/OlbBc/TSioPZdQupw4GOPvkwMmwuyPhRKE0SOpEvFI7
        cr9k/VJ7fCK2LYfsFMe/0TwQ+Gh9G8vH6Y2f
X-Google-Smtp-Source: AMsMyM6aL/3lj6oEkpHyRBLMBYUFp2U1OZSgG6neJ03PbvootE30incW5HI2IHQlvVis69DfMFhwxQ==
X-Received: by 2002:a05:6602:2d06:b0:6bc:e0aa:7ff2 with SMTP id c6-20020a0566022d0600b006bce0aa7ff2mr13592354iow.173.1666389473606;
        Fri, 21 Oct 2022 14:57:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g8-20020a02bb88000000b0036ee761e2f4sm100857jan.159.2022.10.21.14.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 14:57:53 -0700 (PDT)
Date:   Fri, 21 Oct 2022 17:57:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 2/6] shortlog: make trailer insertion a noop when
 appropriate
Message-ID: <Y1MV4DEa8y0I5W/8@nand.local>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
 <7decccad7ccb39eed67bab87ed665beccf5d392f.1666320509.git.me@ttaylorr.com>
 <Y1IwVIoVsl1FVklI@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1IwVIoVsl1FVklI@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 01:38:28AM -0400, Jeff King wrote:
> On Thu, Oct 20, 2022 at 11:11:32PM -0400, Taylor Blau wrote:
>
> > When there are no trailers to insert, it is natural that
> > insert_records_from_trailers() should return without having done any
> > work.
> >
> > But instead we guard this call unnecessarily by first checking whether
> > `log->groups` has the `SHORTLOG_GROUP_TRAILER` bit set.
> >
> > Prepare to match a similar pattern in the future where a function which
> > inserts records of a certain type does no work when no specifiers
> > matching that type are given.
>
> The patch looks good. And knowing what the rest of the series looks
> like, this is clearly the right thing to do. But I wonder if the
> rationale would be easier if it came at the end. Then rather than
> "prepare to match a similar pattern in the future", you can just say
> "it's weird that we check the bit for SHORTLOG_GROUP_TRAILER but nothing
> else; let's make them consistent".

Hmm. I see what you're saying, but in fact by this point in the series
there are two other spots in shortlog_add_commit() that check whether
individual bits are set (one for SHORTLOG_GROUP_AUTHOR, and another for
SHORTLOG_GROUP_COMMITTER).

So I think that the semi-awkward commit message may in fact be the least
awkward thing to do here ;-).

Thanks,
Taylor
