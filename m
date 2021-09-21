Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6778C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 21:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F91E60FE8
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 21:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhIUV1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 17:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhIUV10 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 17:27:26 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA2DC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 14:25:57 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r75so533302iod.7
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 14:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C+1dd5GiwwhShURTAGHwlYC0Hzx18Prmhj2ggFIkTp0=;
        b=6dqdzz7b+ek0marXG/W26uKUM8EuxwNGkTjBB3py7ueoRyGvXYzOfSSyAUBHauXXta
         H5DNTJd78F99XgQkvdZtssWCUgfQLcW0KmFsPBejfDLYbBgpqqGpYyu2s5KE7qHttIu3
         ePbBQsKgDaEFbz81AtzspReoK91jor/2yaBuIfbB0XCrsagQqQgQxi8maoD6iLmpqTzv
         dY8Zeol4UyYdYefiU2z0ucc5mhYCb73euUJih7dkoSYOWLMffDvbRETc3qaTK79LxNVS
         ImeLFdQgHGqW4WmKvfwI3K3e45BBs9EDA9bXNeIB+AgbGLJas3jmE7WEvxiqXNSs1faO
         VR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C+1dd5GiwwhShURTAGHwlYC0Hzx18Prmhj2ggFIkTp0=;
        b=loJH0Hgf8pL4cZcC7tUVXcQrcFgxW/6MxtHc/TABB6DgLjs9EpZpbonhYsvcpMMMo6
         ozP92vfaS3E/RkAt4lU5y8BMH/znRtdxr7IuPeIY3lIBRQwLG6uwFRhCFPbZR+kba4mY
         H8O4I92/6w2/KwOXNIik6wPUey51N3uRGgC2TUhxTEhCnSxCVt7K/1GFkNADNagWxOcS
         bnh60XgDcS+FyTBqzV8toSkVs51WQcvJrotgSxfj5veKqbqbIR+IX4cNYzD5Y0hHn4g3
         XigYHeI0eCkpJGxNLy+cF1D6aSfUIHu0op2hserQRbcuyQpmluogr0Qkhm35nu0thzuV
         VniA==
X-Gm-Message-State: AOAM531PrWuS38cllZutL5NOOtNMPT+2OaSxBguPCYSbJuZgjia0iuJG
        QBKRxhW5mAhmap22zkNMIDi5Dg==
X-Google-Smtp-Source: ABdhPJyuafvRCg3HJGxTqAVrfiDTucFjdJWz3I1MGpp9uoAeNfiupRdIG1Gv8ele+Q4TIkK43c+lRg==
X-Received: by 2002:a5e:d711:: with SMTP id v17mr1751831iom.93.1632259556631;
        Tue, 21 Sep 2021 14:25:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o5sm42418ilk.88.2021.09.21.14.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:25:56 -0700 (PDT)
Date:   Tue, 21 Sep 2021 17:25:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <ttaylorr@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: Git in Outreachy?
Message-ID: <YUpN4zrZmyxoTb4l@nand.local>
References: <YTGLLQCvlnT17jo8@nand.local>
 <YUYPgF6tRQ5ERYWL@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUYPgF6tRQ5ERYWL@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 18, 2021 at 12:10:40PM -0400, Taylor Blau wrote:
> On Thu, Sep 02, 2021 at 10:40:45PM -0400, Taylor Blau wrote:
> > Are we interested in participating in the December 2021 round of
> > Outreachy? September 3rd (tomorrow at 4pm UTC) is the initial community
> > application deadline.
>
> The project deadline of September 23rd is fast approaching, and we do
> not have any proposed projects or signed-up mentors.

It looks like the deadline was extended to September 29th at 4pm UTC. So
we have a little less than an extra week. The below link is still the
right place to submit proposals:

    https://www.outreachy.org/communities/cfp/git/

Thanks,
Taylor
