Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9891C433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 19:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiGTTVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 15:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGTTVr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 15:21:47 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80263AE65
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 12:21:46 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id g24so11399633qtu.2
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 12:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IaJdCpr9p+auUkhSVgZfH36IbUdgYlRYl9laJQ7hmo4=;
        b=NGWzfu5L91I2wvEMx/p0oaY/j0wf40fo+1pKldS+vYzTMqCpbQi2ebxgSPtYe//nDY
         u8akUQFI8j38ctKiY+/UAFuVmgejhrQhcnMRyZ4NNdRSctCvCso+dkd5ftVpWPK5cQTl
         g85D12kIhIj1Uuk66z+DlKQIfkRdDI9djEXs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IaJdCpr9p+auUkhSVgZfH36IbUdgYlRYl9laJQ7hmo4=;
        b=ZaJ88kR9KxlydVl67B8srthXniOWD+j4b+wcZAp175eMwjLHW/ODvUK91WPa1qbtUb
         Z8PdBWpFccdh4fj7ZxOFQiWWtaWyavcU+mLXOUxNaVXfhsv/Kd/ClRqWK82M7f4RVoZF
         medbU+akXvAwzlcTWb30s4hum4jR3LD9dJqfSCGam0pGlVT7R1aReMRJA3f+U7wPEB4u
         I4Eg+PXzxEwPxCzPQINCHgkZVHt4cAjkceYUo8rqbjVwgMph86Pzs+bdscCbWrKhzk4E
         0AZbBY0ZtTdNuStaGDPcIfdscncCdUYJ9wYYWqCUlGyHS8l34kYS3I0eQ8rDSr1mTAQc
         F8vw==
X-Gm-Message-State: AJIora/ymoN68uVnl/1B+efa+VlfkkQDz/v6Z0VQUfbVEzIlvMQq8k7a
        dUKxjvNHPZu563HFDDRFG3Y6BFJLanoT9Q==
X-Google-Smtp-Source: AGRyM1vfZEq0TFluAQBFQrFVed38qemoF4LtgeMWaq6SD95DmKHFPcgONigi4vNSvxjEyOsG5TEmcQ==
X-Received: by 2002:a05:622a:106:b0:31f:79a:8468 with SMTP id u6-20020a05622a010600b0031f079a8468mr3438338qtw.58.1658344905986;
        Wed, 20 Jul 2022 12:21:45 -0700 (PDT)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id i10-20020a05622a08ca00b0031e9fa40c2esm3070qte.27.2022.07.20.12.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:21:45 -0700 (PDT)
Date:   Wed, 20 Jul 2022 15:21:44 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Glen Choo <chooglen@google.com>
Cc:     Stephen Finucane <stephen@that.guru>, git@vger.kernel.org
Subject: Re: Feature request: provide a persistent IDs on a commit
Message-ID: <20220720192144.mxdemgcdjxb2klgl@nitro.local>
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <20220718173511.rje43peodwdprsid@meerkat.local>
 <kl6lo7xmt8qw.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6lo7xmt8qw.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 18, 2022 at 02:24:07PM -0700, Glen Choo wrote:
> > I just started working on this for b4, with the notable difference that the
> > change-id trailer is used in the cover letter instead of in individual
> > commits, which moves the concept of "change" from a single commit to a series
> > of commits. IMO, it's much more useful in that scope, because as series are
> > reviewed and iterated, individual patches can get squashed, split up or
> > otherwise transformed.
> 
> My 2 cents, since I used to use Gerrit a lot :)
> 
> I find persistent per-commit ids really useful, even when patches get
> moved around. E.g. Gerrit can show and diff previous versions of the
> patch, which makes it really easy to tell how the patch has evolved
> over time.

The kernel community has repeatedly rejected per-patch Change-id trailers
because they carry no meaningful information outside of the gerrit system on
which they were created. Seeing a Change-Id trailer in a commit tells you
nothing about the history of that commit unless you know the gerrit system on
which this patch was reviewed (and have access to it, which is not a given).
This is not as opaque as it used to be now that Gerrit provided ability to
clone the underlying notedb, but this still fails on commits that were
contributed to an upstream that doesn't use Gerrit.

The current recommended strategy for the kernel is to put any historical
information (including any links to archival sites, etc) into the merge
commit and only keep chain-of-custody and code-review trailers in actual
code commits. For this reason, I opted to use change-ids in the cover letter
only.

-Konstantin
