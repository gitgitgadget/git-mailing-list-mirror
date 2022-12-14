Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AC8C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 20:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLNUQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 15:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiLNUPY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 15:15:24 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7AC2F677
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 12:06:00 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z144so4034324iof.3
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 12:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TIrpWEPqqLfv+9W0lXzxOZ4fKkZW+0D/M9GaZSpcIXg=;
        b=HIF8c4eDEX7wnOFcsVjXW4Zii5NoPjhBTb3J4tt9/5T5EYZMy46zIELibQKtfUm4tE
         Ly/x1KgJPCKrRsIzKMV0n5UeXjGMeH0AajoTV2Qty2XvxbbkWt89GtEALyuCeEUL+PbX
         DqZt5vFhUbzKelrDdgFqrmHUWz6NMwIGNMRzzTSNLc377h62ItoopjD+6pt3DOqAIqCr
         PkKobJCC/sEmVeHQYTnBvc4vV+svYllEw0sXRarVGE9WeeMUWDbA4VfC2oguOqm6ThB1
         QT5PyTMH8W2eGeydxQsiYMWNL1vYKctNT4AzBR2QlmFpXJfQKDKYDi0EPT0MWmyJgtGx
         4Nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIrpWEPqqLfv+9W0lXzxOZ4fKkZW+0D/M9GaZSpcIXg=;
        b=q22TQYuzFbuLJw0GHpFtETK9bad69HMozTu8w8aZBgJrI4NNooNrmEbEkDesGdn8Cf
         OzRr0dnQLlss1ddU8Rk7vKDXnPYoU0NwukkawbCF9pWQA1OrOkjhT/0+m+XDIyoaPY+c
         VppNhujE0l/Q8O6fDKelsnvPuFHNqX1sEuFg96OJcgMEyw8+av4REiQ7p3PKeX4PWU6z
         Q0ivdlWQOwyfstrPS7i9QBhcLbkJ+HKDuVSFIid5qYI16xRByj7c5TnfP8Ai3NjeJfle
         vqrlCBzxa0InQt0NUzcHGk+FFetZMCxfc9d40ASogtgvBmImYXASEFxkAyxs584xAwmm
         BtFg==
X-Gm-Message-State: ANoB5pnff1lmkJNkGtkqjgkf58nXE+Ieq62+xu/zQJ/4nfX7wQABylOr
        rJ/bvt4ZuyvpIu/mmH0vr0p5QkPZXbz7TZqq
X-Google-Smtp-Source: AA0mqf4v10RG/CiiuEpDrL5w/nCX1ZTvvtc85+VLn7Ue2mvRbiQ8DGBkSkLKD/ZpDVNzPALImQOAaw==
X-Received: by 2002:a5e:8b43:0:b0:6df:5b14:61ee with SMTP id z3-20020a5e8b43000000b006df5b1461eemr12869957iom.5.1671048359813;
        Wed, 14 Dec 2022 12:05:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h21-20020a056602155500b006e302b99d00sm270623iow.20.2022.12.14.12.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 12:05:59 -0800 (PST)
Date:   Wed, 14 Dec 2022 15:05:58 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] minor ref-filter error-reporting bug-fixes
Message-ID: <Y5ospnLHWIKKXadV@nand.local>
References: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2022 at 11:18:19AM -0500, Jeff King wrote:
> This series fixes a few small inconsistencies in the error-reporting
> from ref-filter's atom parsers. Mostly I noticed this while dealing with
> unused parameters in one of the parsers, which led to noticing a few
> other small bugs. And I hope the result is a little cleaner, as it
> should reduce the number of strings needing translation.
>
>   [1/5]: ref-filter: reject arguments to %(HEAD)
>   [2/5]: ref-filter: factor out "%(foo) does not take arguments" errors
>   [3/5]: ref-filter: factor out "unrecognized %(foo) arg" errors
>   [4/5]: ref-filter: truncate atom names in error messages
>   [5/5]: ref-filter: convert email atom parser to use err_bad_arg()

I gave this series a careful read and found it all very satisfying. The
implementation is straightforward and leaves us with several much
friendlier error messages in the ref-filter's atom parsing code.

I left one comment throughout, but it was clarified when I read through
the rest of the series. So this one looks ready to pick up to my eyes.

Thanks,
Taylor
