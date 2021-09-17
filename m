Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25713C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 04:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09395610E5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 04:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbhIQEQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 00:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhIQEQE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 00:16:04 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738CDC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 21:14:43 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id b15so8899287ils.10
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 21:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NcPWhVxpmbbPetdA+YgyMEs4O7AUDHm5qSJRHYQ2V0Q=;
        b=ldz0g7tWz7VSALAqYCyPe3FT5wS+rjo+flwcE1ajgYH2WRrbyYXW3UpKamiP9UaJ0r
         KTamPydx9SiUMaOJI9i9iMGPzdUeejI+qg2JCGvtDR5NfU1M8tA/1VPWp+xuUkU1cLJX
         pq+AW44eZWWOV4lfo+qXQmgd0sVrEAgNpgk8fLFM76BG3o3j2Vk8edDq5VpbpmuR9U4t
         L30W8CbYDHSytfw5VlE+EO6GKiuUztUzYeyPqP7JJ57Slo42j+ariNQA1tEOewOrneI/
         /ca05czIAXnEnYIfc+k23evC8fcLwZ6e8IzoKOKTsl07kTQHrq6QtT4Jor3mQvSiw1ri
         MmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NcPWhVxpmbbPetdA+YgyMEs4O7AUDHm5qSJRHYQ2V0Q=;
        b=BcOwlTQza1Sp8SJJyrzd6m5bbdAjTtqJ/iQAaDlo2lOeifJXCyimB7UfonTIr5vFdZ
         MQAB3KoUsk6nSNWWotxfOCh9UgnjYlY26ioTuvxM2HGx/myUv1StZn7hkU3VnnfTadR3
         HcTCnpO6iis30nldv4+4z9NWrX+nz/Y1Le0BswXL63RyvUJRkA0Kcv6onKy7CtKvcf9b
         L4CrL136zvzMf2RdKzl3/5yiaL6qxmxNniqXVfvRoxp4nHmNAadxcInLMfzJSlwfWoRe
         6VH2ZmxKXLRpSK9Y/XwdVR250GIoCA2Qpntp3bVe2a9Eku1Zq8fYWA50arKPZXvWT5Qy
         QDjA==
X-Gm-Message-State: AOAM533EaLVfKUTWFQs8XfAmzLhz++/Td96bcFLofVpUl00zK3wvf20i
        E+GlJBa5eTPmY/XSyL3CpcQGmA==
X-Google-Smtp-Source: ABdhPJyHNlXKtRQchcNOqJUSIK3zkpKQxIksl6vUNjKHvVH5aGB22hURJ44QAgTUSgCk/HlVBblMSA==
X-Received: by 2002:a05:6e02:1ca9:: with SMTP id x9mr6380916ill.164.1631852082272;
        Thu, 16 Sep 2021 21:14:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l15sm2656244iow.4.2021.09.16.21.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 21:14:41 -0700 (PDT)
Date:   Fri, 17 Sep 2021 00:14:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v2 4/7] p5326: create missing 'perf-tag' tag
Message-ID: <YUQWMWiVDyDz9qRV@nand.local>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631657157.git.me@ttaylorr.com>
 <a8c6e845adf559a96e37c973fea16da8a42e7cba.1631657157.git.me@ttaylorr.com>
 <YUPHBv3d5p67NAnJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUPHBv3d5p67NAnJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 16, 2021 at 06:36:54PM -0400, Jeff King wrote:
> On Tue, Sep 14, 2021 at 06:06:09PM -0400, Taylor Blau wrote:
>
> > Some of the tests in test_full_bitmap rely on having a tag named
> > perf-tag in place. We could create it in test_full_bitmap(), but we want
> > to have it in place before the repack starts.
>
> I wondered how p5326 ever could have worked without this.
>
> [...]
>
> Knowing the history of the midx-bitmap series, I'm almost certain what
> happened is that it got rebased, and you probably _did_ see a textual
> conflict, which you resolved correctly, moving the perf-tag test into
> lib-bitmap.sh But you missed the semantic conflict that p5326 also
> needed to add in the setup step.

Sounds about right :-).

Thanks,
Taylor
