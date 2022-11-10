Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DA6C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 02:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbiKJCVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiKJCV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 21:21:27 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC73220D3
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 18:21:25 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id h206so285230iof.10
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 18:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=STJ5p11ykyJMxUaR0gaPkTIriIIYt7hrw3smULsHt2o=;
        b=wTb3eiROo0ywZ/xpNOF6KU5pLyce1Km7aHnmoJWYv1QKfmNXwf2ymdZroyVWnN96CM
         9gq4W6CLELaCwNVe8DBJd9jzsvb+bTupcjmGC6rUyWcrjUsGS40OEt6zP/TNFE08N7fn
         xc7Eq2uZHHRVgsFrnu4jZSILEjlf7YpUbe3sIHxYU0RsffKu9/nZv4yaWBaHm0Gg1w6l
         7n0uoikfql22/Qov1Xp9s4Vynj+azCKBGOkbbXSIdjrvNhVBfKhOaMw5J3KJ+OzQ1TdC
         UCQ0mIaLJtSqJp4TwhIyFoBukoQVxMpgoBohdVBooPfYJyVwP5cn5+QfqR++oPrNyOPz
         TMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STJ5p11ykyJMxUaR0gaPkTIriIIYt7hrw3smULsHt2o=;
        b=yVpMf0ODoLorFk6L/PkJcgTm/lRGQaEiWjJNLculS/rl/1kdJT1gMSAJxNxefiHsAl
         5XPawT28sNapktvQMsgQwz79ieLBwOVvYzH1h5f0fsiPPrA6aTmEo3Ix2ho5EJUvg5r4
         f8fGp6M1Hcwb10GsOv7xJ7/RHunibpBWwXwNhzea2z+Ew7KchKlMAU0eg3Vny2O9Gu9j
         Pq5WaFF9Ml6eArAPx7qmjRKUlrFQ2+ncvvC+VP29c1YXYjKQ+MokdA43O26wjm71cnS/
         ecqI8a6Pks57dxFwwFmjM8qj6PfUonUKMTch/4Ka8f1/jAA9IW+Y995LcTDtwRJnS+WC
         8heg==
X-Gm-Message-State: ACrzQf14gjh7DbiQV0ZioMEKPYpUey//CLnhaFaYzCJMghJN1xh3bmdv
        16p6eRlGJWLlSHjFk2Lc7A/ZBR92N2HDkQ==
X-Google-Smtp-Source: AMsMyM5v+DJY+H/aIc2CImsNTGBKYPAXJjeVodBfooxwc+Uo5rCzC5S3JOZ7LEv98Mg2rESSGCWzDg==
X-Received: by 2002:a05:6638:3491:b0:375:8cb:84f3 with SMTP id t17-20020a056638349100b0037508cb84f3mr2524286jal.33.1668046885037;
        Wed, 09 Nov 2022 18:21:25 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c1-20020a023f41000000b003722e5b561csm5191724jaf.52.2022.11.09.18.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:21:24 -0800 (PST)
Date:   Wed, 9 Nov 2022 21:21:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <git@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: fix cygwin build failure
Message-ID: <Y2xgI30EFZisqpRG@nand.local>
References: <0dec6e1e-207c-be13-ae95-294d9b1e8831@ramsayjones.plus.com>
 <Y2wwfQWrs+KYpWNv@nand.local>
 <221110.868rkjpty3.gmgdl@evledraar.gmail.com>
 <Y2xf7HbAdqXOmgR3@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2xf7HbAdqXOmgR3@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 09:20:28PM -0500, Taylor Blau wrote:
> Yes, 'ab/remove--super-prefix' is only in seen for now.

Oops, I clearly meant 'ab/make-bin-wrappers' here. Sorry about that.

Thanks,
Taylor
