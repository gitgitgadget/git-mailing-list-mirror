Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576F9C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 23:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbiGNX0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 19:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiGNX0M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 19:26:12 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9533F3C14C
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 16:26:11 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y3so2677088qtv.5
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 16:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X80gUb1Qzwg7GYYTFmDr21oL6cB6ZNuDHFDvVyOjvQk=;
        b=Tigiki48S76dWBPnLRkpuUMHDdxjJ52XRca12Zk8uFZu+81X7dkMEFdpyPp/z2GL+x
         xcaKGs9rHnqnnq/fPIl7Ed/J0wmG0Yd31pER+Q9T1RaeNhaDVBMYQYQwlKaC/x8E3wll
         chp1+5OnascbGbcgo5rqRrcrOJ9p1ZwTxqiQIfZlg5olCDCqMNeFagzneSYyk1j7Hv6y
         vYTN7O4heIM7TY++XXpIVdkvbfGFQBjxiD++QLeNHBfn1t4JFYRXo1I9ukEWA5BA739M
         7IIC4l29VIHUEI1Ax3p4FaozzItMk1OcdtxO1AZ70ugWBc5JmCKAdVSqgdSNT6A/fWLk
         3wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X80gUb1Qzwg7GYYTFmDr21oL6cB6ZNuDHFDvVyOjvQk=;
        b=aBl20qZn1hdBGs/nFv262u+GpnbUMj2OZUt+dz3AFUJV/k9B1hxD5aURTLNb1HIQpH
         bO7J+azgxxSoSyCsg0Ojc9Abvt3JMsr3OjRk+zaHLkcB7Gn7Khvd1zWXU/8Lf4lRHYcf
         KUEtYS5tGStVZPVXVSO08T5Jg4Q1qeURXWpr/PbsB/+i5DGQKgun7U/pnvb78+jc9q8R
         9UnTa307BKhrkNB4QUbtafn9fML3oHIt0sJln/FcoHm6Wo4e+8j8Iv5G9HOfxg/ZnkI7
         zLAu9XnMBH7pl4nDylOjBhU3Pxj45VcfkB/P1QWABKYRZzw5frSQyZuJ9KiZy4pAMNJQ
         Om+g==
X-Gm-Message-State: AJIora+gzeTqhyjdY8GG4pTJ7zKwlm/A+W+g86Ix4D0zlruGAzuW4rdd
        teDr+gwN9SX9r7IWOjb6w6XFIQ==
X-Google-Smtp-Source: AGRyM1uEOnBfnZYj6UOnBfMdDq+60bwQ+QqfAK3XARDWr3zJERGSK0Xr1ufMnEh4sK4SbLPTAQUZmw==
X-Received: by 2002:a05:622a:1014:b0:319:7601:c22 with SMTP id d20-20020a05622a101400b0031976010c22mr10347287qte.509.1657841170769;
        Thu, 14 Jul 2022 16:26:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bv6-20020a05622a0a0600b0031eb5342520sm2466639qtb.15.2022.07.14.16.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 16:26:10 -0700 (PDT)
Date:   Thu, 14 Jul 2022 19:26:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v3 2/6] pack-bitmap-write.c: write lookup table extension
Message-ID: <YtCmESpC7DmNhAcm@nand.local>
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
 <5e9b985e39b0b9edee7af55dd8b0698a20062cf7.1656924376.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e9b985e39b0b9edee7af55dd8b0698a20062cf7.1656924376.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 04, 2022 at 08:46:12AM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> The bitmap lookup table extension was documented by an earlier
> change, but Git does not yet know how to write that extension.

This and the first patch both look in great shape to me. I haven't had a
chance to take a close look through the remaining four patches, but I
anticipate that they are in similarly-good shape.

I'll have some more time to finish reviewing this tomorrow morning. I
want to give it a closer inspection this round to make sure that
everything is correct (and that we're assembling the various orderings
the right way by stepping through it in a debugger, etc., etc.).

Thanks for all of your patience :-).

Thanks,
Taylor
