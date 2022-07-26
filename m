Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9504C00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 17:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiGZRoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 13:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbiGZRn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 13:43:57 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3ABBE03
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 10:43:53 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id e5so10973431qts.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hu0TmtSYpkgFFqO4iCic2z/RwzVxM5zJsUvJfRaTvyY=;
        b=v6HUMxbnndx29Pyj2HnWUasEP4K6+hn6waF9VI6r/gvHvC6aMjQx5zkg7jz1qChUSd
         fszWoUiHbL3Uo+Q8KdjDATt2JfK4QmZyWyx9VYH6EOL37OyWCPdkMMUzwQBdHI1cLeAM
         vge6VrP16pnABopJKeyxb+McqIECWDiePRLh0u3W5R5N2CCYuB+Aazzfi3S7M1k6aAuz
         +eZPrlAgYw2o1McY7e2tVh+ihwuE+lv7wV7apIrx+5/FAW1jDOu0TEXNIEcW76qA3VM6
         1MqQyUvfLt9PhHwwp3njZ8zsucH3Iyd9lX/Xj4pjkliv0Swz06q0sFAi8hfiQISJooPh
         jkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hu0TmtSYpkgFFqO4iCic2z/RwzVxM5zJsUvJfRaTvyY=;
        b=rFKFo5jvEKD4vfWzcoBhwG3acdVS6sy2cMwYhdof/ufNg9gjCjxJQg4JFnAofwBUDe
         QT2II23CZePI7M692A6TMesZK6omv2yTLcKHkpefzJFOmE2H3tXVOvjpgWsVG8kK8vM3
         Ha7iSFbFLgS0Py7nSRAnfHNv5ZfJI8Qz8zqPLuG3vsrMoI5HGVeBM4wNG+X1Ui9c1uGu
         sFPfEd5t1Ac6dautfqmsyPmtMET/T1SlxCeUaLm5tbpIFgACR0VnXsa4ztxOnsUV3R2K
         c7tb00hqHKn2uXH4zdwgDJuKxYUzZcuXf4NWFuooVI0VmCIMb8WRoC0ZdqViQOO8WnJs
         eUjA==
X-Gm-Message-State: AJIora+N/66hteXPVF87DNkQilLX8aUEYDh4PXZDt/eOJSLdnN0iEtmw
        EAS9AY+JHvcIN6voK7pBkIjHDA==
X-Google-Smtp-Source: AGRyM1tZXM5qVhh1PFB5sjz613irPcZEGexYnjFFXpnglnealBIN8ChhfZPyrBaLi1b7vmnTuc28MA==
X-Received: by 2002:ac8:5a03:0:b0:31f:38f:2a6 with SMTP id n3-20020ac85a03000000b0031f038f02a6mr15465054qta.340.1658857432180;
        Tue, 26 Jul 2022 10:43:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id fb14-20020a05622a480e00b0031f338f95c0sm5206101qtb.0.2022.07.26.10.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:43:51 -0700 (PDT)
Date:   Tue, 26 Jul 2022 13:43:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] config.c: NULL check when reading protected config
Message-ID: <YuAn171BhecC1w+O@nand.local>
References: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com>
 <YuAj+eBajf6jkJPc@nand.local>
 <kl6llesfsrgd.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6llesfsrgd.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 26, 2022 at 10:40:18AM -0700, Glen Choo wrote:
> > I wonder: should it become a BUG() to call git_configset_add_file() with
> > a NULL filename? That would have elevated the test failure outside of
> > just the ASAn builds, I'd think.
> >
> > There's certainty a risk of being too defensive, but elevating this
> > error beyond just the ASan builds indicates that this would be an
> > appropriate layer of defense IMHO.
>
> Hm, if we're going in this direction, what if we made it a BUG() to call
> fopen_or_warn() with a NULL filename? Then we wouldn't have to
> reimplement this BUG() check in all of its callers.

That may be too low-level of a place to put this check, but I don't have
a strong opinion about it either way (including whether we should have
such a BUG() *anywhere* in this series, including
git_configset_add_file()).

Thanks,
Taylor
