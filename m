Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBD7C4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 18:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbiK2SBJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 13:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiK2SBG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 13:01:06 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449566B3A4
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 10:01:02 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id g26so9967462iob.11
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 10:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hawZA5Qq1M4SOo4hIaj9R1SJHcw03YGXguH2W9ucC4M=;
        b=L+UcIMgoRGsWjQViusT557O7oinaxIW4ZJmxkyz7mapc2og8bafXylhLbNvn38c1QN
         v565JRMVXwhWLhTUluB+SKnKrstjeATeqktDcy7T8SgjJNHb+4UigX0bRSk6MKQ8G9+u
         ROMcZcasCFUmBHMcytG7Em5lS3+b6fkjsEDXFMLCs6Oh1+UVbMmp2r4QQ9b+vF0Rv3zj
         loWv9Hdf5/q7N6+KfKKYzqqA7XI47orOiVLmvzMM/uiaipIAX5XnldVa3yy96I3cat8R
         3T5mMm0IsplgqWnyogzV/L5xOkJjXB+7lplZRNFjdwlZjEonKC/0i/DK+xsY1GkVUVxm
         VKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hawZA5Qq1M4SOo4hIaj9R1SJHcw03YGXguH2W9ucC4M=;
        b=lIVkQ8zvTRVyuyQeOSvXiTReEzHdLU160iW3U0ExX2l8I4inP/Nu+EmalGnfmsplDW
         rG20Kw0X+O5CgQJwg8+tnyTSvVFnde8y2Z03bPDi+4s7MPQpv95j1kqFLDOM7HY7Q1Ua
         yh3fSTMpO95RHsGsJA3ZLwBRXc+ZyARskHzHKVoKBX4JWYlqOq2UlkjtWmOQqhdaOl4Q
         JETFLKTL5J05wiRIP2IS3fcrO9+fiYpoxhAH9zuhgsVdLEJgMpnU7g/bTQU+K2IGxnRf
         59l8IJb6KaCcCZJZR6YFwVCr163R4Lc2e9NpoVa7cuWAU1KueFvXWo+p77QEHS/XkUWJ
         U39A==
X-Gm-Message-State: ANoB5pnfwgJQD9f9+sBCPzAo3cxeqbNDpQk3sjkqbYxMNMXrHl11zowz
        VyPCjMF9AqaIriRNg8t4m+UsKNfDJP2x0A==
X-Google-Smtp-Source: AA0mqf7A+kfCkbPs+HTVlRF3jiyIkEngRQLORBBFmBJszkamnvysbtYpYEWT+pWalOHPZMqIiVPz3w==
X-Received: by 2002:a02:6d13:0:b0:374:ff83:34b8 with SMTP id m19-20020a026d13000000b00374ff8334b8mr18641086jac.60.1669744861521;
        Tue, 29 Nov 2022 10:01:01 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t18-20020a056e02011200b003030afb5c3csm2464607ilm.31.2022.11.29.10.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 10:01:00 -0800 (PST)
Date:   Tue, 29 Nov 2022 13:00:59 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     gitster@pobox.com, git-packagers@googlegroups.com,
        git@vger.kernel.org, lwn@lwn.net
Subject: Re: What's cooking in git.git (Nov 2022, #07; Tue, 29)
Message-ID: <Y4ZI21F0yYxMk3O3@nand.local>
References: <xmqqr0xum8tn.fsf@gitster.g>
 <20221129130841.82302-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221129130841.82302-1-tenglong.tl@alibaba-inc.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2022 at 09:08:41PM +0800, Teng Long wrote:
>
> > * tl/pack-bitmap-absolute-paths (2022-11-29) 4 commits
> >  - pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found
> >  - pack-bitmap.c: break out of the bitmap loop early if not tracing
> >   (merged to 'next' on 2022-11-14 at 34eb0ea05a)
>
> Will the two commits which merged to 'next' on 2022-11-14 at 34eb0ea05a
> be taken into 2.39.0-rc0 (or v2.39.0 is frozen already)?

It is rather late in the release cycle to include new patches. I
wouldn't be sad to see them in, either, since they are pretty low risk
in my opinion.

But I think a safe assumption to make is that they *won't* be in 2.39.0,
and that you should resubmit all four as a new series once 'next' is
rewound.

Thanks,
Taylor
