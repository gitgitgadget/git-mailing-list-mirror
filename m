Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC97CC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 02:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792F664E4E
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 02:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbhBJCqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 21:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbhBJCoS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 21:44:18 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7C4C061574
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 18:43:37 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id s77so362714qke.4
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 18:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TTT1dd7a5k/2eTb4DtT8ex8i/oLuV/h3eiqsvixQSxw=;
        b=kPc/lk2937tAbqD4NeXCtiTEDpFZy0grn5KgfpYMgnH2qqBf/ooL1deP/5twbUFBXf
         Mu1Q7prG3FvX7BjCGF67ZjwVuhNJjvp65H4MMi/3SAANZjWTjpyDM4TPzs91bRGUXsP9
         x6r1FLyhT0Jf5ClLifIaJTCq9ygd5TZqBl7jGrSCPHIYtDd4VBAHQiKzbTa73XDuVYaA
         s15QXLTPfmLT/h871tSLfdvQn6Xgrg/hjYHkdnyJGPc+Y/FgCr0p1NCbdcveblHtGFiz
         y+6R1oOeA5hBzOzEesPbB/woVUjJ9WXEKCakWY64UibeyBF+sTFW/lx5Yshnc/CM4yHT
         eIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TTT1dd7a5k/2eTb4DtT8ex8i/oLuV/h3eiqsvixQSxw=;
        b=Ee876kulTFh7T9qzRqjRvm2DS0xYGvN1I6v3gVF6KOHiLjzSYS7eGDK7YdWasfK1LX
         UOHvjWrGVpdJ532p/YpkeQW0aYwwEr6gdmXJrGKKe5rkyuXlEAriCC/cTSLA1ueo9G0j
         9YZy31kPO/iMPXEkEvSOX/7ZC+mzvzDF/xRWhYPgaPOBgP60BJmgrSoooO3IzN4CMMLK
         vXTy7K97fJiSelMljJJU44qzbfdDBcHwfDkVoZecBV4KVxkcAP6Efnh7lliRhxEYZqr6
         379iVlY0EQBqvXIhMsq/2XIuF50Wmi7QJJQSm/I43Wy+gswYX81y+Kj4MXSicPMVrnZd
         lUrw==
X-Gm-Message-State: AOAM532jOvii4hNQ+PkYbHW/y3jpAli8r5/f5dUMj+euFj5WHHLStdQY
        0eQ9GwTl8Ct+6/uHI6pg9EmLYR/HuzxcBdky
X-Google-Smtp-Source: ABdhPJwylCudYVHi7arp69jloRTKJF6M/xS/kIMf1Kngre4b9UAZjwRaqHFlp/FAFFo+Xmjjukvjjw==
X-Received: by 2002:a37:94f:: with SMTP id 76mr1403640qkj.495.1612925017182;
        Tue, 09 Feb 2021 18:43:37 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2c3d:3179:bfad:c65])
        by smtp.gmail.com with ESMTPSA id u126sm526570qkc.107.2021.02.09.18.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 18:43:36 -0800 (PST)
Date:   Tue, 9 Feb 2021 21:43:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] grep: error out if --untracked is used with --cached
Message-ID: <YCNIVm3uz25Akl1q@nand.local>
References: <YCGxos2vB6mgHOTA@nand.local>
 <20210208232159.100543-1-matheus.bernardino@usp.br>
 <CABPp-BFouwiACwwS5mDdgBRF=YK--=NfqZ9r=qkFouEvyJfnGQ@mail.gmail.com>
 <xmqqtuql0yfp.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuql0yfp.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 09, 2021 at 12:38:02PM -0800, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
>
> > ...  Even then, I'd be tempted to say that
> > --untracked is only used in combination with a search of the working
> > tree.
>
> I tend to agree.  Something like
>
>   $ git grep -ne POISON maint master next seen -- t/test-lib.sh
>
> would be a useful thing, but I do not see how --untracked would
> usefully interact with any of these "tracked" contents, be the
> search from the index or tree.

I agree with both you and Elijah. I don't mind banning the pair as
unimplemented and "won't possibly work correctly together", since it
leaves open the possibility that we might find time to make them
compatible, at which point we could revert this patch.

But what Matheus provided looks good to me.


Thanks,
Taylor
