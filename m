Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD67C433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 00:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B4A61076
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 00:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhIRAwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 20:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhIRAwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 20:52:25 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5C1C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 17:51:02 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id v16so12164736ilg.3
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 17:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v5MztG2L6xVwvQfM/kTam9WUpHX4MLGPrTIaFGFZ170=;
        b=WtkjM6EV2ENVO+UCtFOYb6HcDyQhwH+Z9kr4sJz3MmwlPU1sbpdR7T1QcLVTTVCif8
         ne2AkrWGkQwNz+MSzX5kmH/RCkqFvnHsgHPM8723mbUyBq8dXt1LfDVJMUjtnhBW3j8s
         UlKhfYIEJSlJSQ7ylXeFutrIDKitNqRvAa+A1tk/ywy1uB9Y1X+e9HaTMYgBcbTqS1b+
         Mcp5y8tphKFF+AkrjEMopJeBsIv864WOJrNrSRnH4/5EW3V/xTudBQ32NVYFXgT4DkEH
         ZU2KDVLShy/4Dn+hEvu4w1cTM4vK7YyddUHZdrVVHotsvqDi+MLOh5vj3vKkAwyDJvEC
         M+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v5MztG2L6xVwvQfM/kTam9WUpHX4MLGPrTIaFGFZ170=;
        b=FXaNCypS9f6xnbLjt8YJyXgnO3WoXYO5b/1pnaa0rFVoKctXksLWMdIa6lg2+TV1MA
         UnKjQ9Kgj10tXIVpn0XzIxbA9xtG+zW+Rwx1PQi01imoT55669aaaxF5Kq3cSZIgqXsK
         wtMQzkPbsUdZ8b+53KjEUQFa2/w7KhxGi3/sIWhpI/x4J6Lgm/qf8jLhBnydbk2r1Wt3
         sTq8ZlYWO5mo6Wsjm3OMX1o6Y24yIpFpg7jrFFUEpdHb7/4TMDQ73oJl2je5Pf/MSUNe
         ID73O1JUls9y+j6KHwhWAFwf4X27Eii6wngJOLcBLo2+T9umPO+SSVtGP/XJvHeiww/Q
         YJfg==
X-Gm-Message-State: AOAM532UiC00lpw2DmTqAIpTWHpXxmFTCJF5HynUCDriRHP6RshaFdLb
        AO5KXvHQVgFe3N+PoNiEiLLEHxUQZWFtvLA9
X-Google-Smtp-Source: ABdhPJy2tBVgWifq6DM08pRuMS/Vp94xzaJ1Gn63XPtaxPq4j662aaRShkcJglKnu2Hm+vfkG7T93A==
X-Received: by 2002:a92:b703:: with SMTP id k3mr9828765ili.95.1631926261622;
        Fri, 17 Sep 2021 17:51:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i8sm2564645ioi.29.2021.09.17.17.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 17:51:01 -0700 (PDT)
Date:   Fri, 17 Sep 2021 20:51:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: What's cooking in git.git (Sep 2021, #05; Fri, 17)
Message-ID: <YUU39FVrAwwZbVqu@nand.local>
References: <xmqqlf3ug3q7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlf3ug3q7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 04:52:00PM -0700, Junio C Hamano wrote:
> * tb/repack-write-midx (2021-09-16) 8 commits
> [...]
>  Will merge to 'next'?

I think this and the below topic are both ready to go, although...

> * tb/midx-write-propagate-namehash (2021-09-14) 7 commits
> [...]
>  Will merge to 'next'?

...this one has received more attention than the other. And Peff said
that v3 of this series looked good to him [1].

So I think tb/midx-write-propagate-namehash would be ready to go. I
certainly stand by tb/repack-write-midx, but I would like a few others
to review it before merging it down.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/YUUS4Mrh85KPucmi@coredump.intra.peff.net/
