Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F89C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 13:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D13B6120C
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 13:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhJUNji (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhJUNjd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 09:39:33 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2784BC0613B9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 06:37:17 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d125so992255iof.5
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=db/nVptF2/BjNpWhKOPS8mHfAZdkV0YjeDUEKX1wdVc=;
        b=Y4QCG3wPWK6Y3ybL4dpyrZtqc/r/mqxoNOruTXtwvP3sEi6I+HO8SYenyqK80RIc4+
         Cj3QqxxKsfBuFyqFjffvLtTY7J1lM8HY+0HdFsZKGF62kkxx4Mb0sfssExJ+c864SORm
         0ILn4itg9R96Ii+ZkpiWZpwInHDil2PHFmTJSD+CqXGWvVqVLYpR5EDvGepjUhg5DeRX
         RnnzS7PalTf3OB8o11m7Sv2pV9pfZbW07pXSCV8zCK8UYpZutrttboqV6RA5Q9B7gHXZ
         SZxGpZfNBzNrT60fkF5dcroA/kVj7PYGSTqOehyzaMGUrr1OSiUsskuAF5hyyL7zjGX3
         EQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=db/nVptF2/BjNpWhKOPS8mHfAZdkV0YjeDUEKX1wdVc=;
        b=Q376wLHSbezXqcvT1ZZdCAHyDz2S9KiIW51R48VPupIBoDzoC7YZwROtcsCxaaSTkn
         UScgejMbp+UdZM4fTgTJr+KyDs2ZcDqX+SHW0pH+jVmfCLxF1ZM98e4B2FDoVys9Trwm
         0ayBlkbBTh+MQLlLCEyRUoGu91Tsj26MPwWAXitMkIlwdoZcbM2RlpX2kWwJR1EPLsuY
         lvYJV3T9yN4AlrounGqjFCAqORAAmxAxHke8Cp5/Zklkb6K4HjINHH8qVSbb8WvCcHzi
         ejQ39L4l16PrsPzVdXq3LD+pZVSBFT3EqVbdH4/kU1KWlrxLAu1VpaoF3ubzc+eBBkU4
         y4lA==
X-Gm-Message-State: AOAM533kE7UHdOl9imwEoqZij/TU7m0UKbDMWnLJNwPEXYTJDk8zccMA
        7W21z/BkKd16Af1rCq3SH0c=
X-Google-Smtp-Source: ABdhPJznOoG2cCOLqq13nvaWEoBUlt7q7HY4u8Hp3nvuop0VsU2N7fThZK8uPdK7hseBrs/n3OWF/A==
X-Received: by 2002:a5e:db06:: with SMTP id q6mr4197907iop.43.1634823436586;
        Thu, 21 Oct 2021 06:37:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:144c:9bcd:5030:5cda? ([2600:1700:e72:80a0:144c:9bcd:5030:5cda])
        by smtp.gmail.com with ESMTPSA id i8sm2916046ilm.10.2021.10.21.06.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 06:37:16 -0700 (PDT)
Message-ID: <7405ae17-50ab-8efe-8ea4-5a9dea8772de@gmail.com>
Date:   Thu, 21 Oct 2021 09:37:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 00/11] midx: clean up t5319 under 'SANITIZE=leak'
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
References: <cover.1634787555.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <cover.1634787555.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/20/2021 11:39 PM, Taylor Blau wrote:
> Here is a topic that Ævar got me interested when he mentioned that t5319 is
> leaky[1].
> 
> This is the result of trying to get t5319 to pass when compiling with
> SANITIZE=leak. About 50% of the fixes are in the MIDX code, another 40% are in
> the pack-bitmap code, and the remaining 10% are sort of random.
> 
> I tried to separate these out based on their respective areas. The last 10% are
> all from leaking memory in the rev_info structure, which I punted on for now by
> just UNLEAK()-ing it. That's all done in the last patch. If we choose to take
> that last patch, then t5319 passes even under SANITIZE=leak builds. But it's a
> little gross, so I'm happy to leave it out if others would prefer.
> 
> This is based on tb/fix-midx-rename-while-mapped, with a back-merge of
> js/windows-ci-path-fix in order to appease CI. It also contains a little bit of
> overlap with a patch[2] from Ævar in another series, which he and I discovered
> independently. I cherry-picked his patch, since I haven't seen much action on
> that series lately.

In my reading, I only found one nitpick that wasn't already caught by
other reviewers. Feel free to ignore my comment as it was just something
that caused me to pause while reading, but isn't that unusual.

Thanks,
-Stolee
