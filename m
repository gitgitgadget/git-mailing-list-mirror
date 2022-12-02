Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F8EC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 20:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbiLBULl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 15:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiLBULU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 15:11:20 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7208F140A
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 12:11:18 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o12so5912344pjo.4
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 12:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rxhlptpfYO3EujChuPs4BU0yxntxMygMPmEH4FKDgwM=;
        b=R7I+1cCVVjEVNXWa8qVR6bYfdEiyp9wJ+zHwOpc6rus/XnrPtb+HNjfHrKLy39EDw+
         rCVUqKlkMSa6cjV1fZk5b1JpaqAfysKG0WTz9u9Zlrm7fL0//TGCnZRHTN3U0DLDu6lA
         8KNK3c0dq/somfkExDKGOFNPLAyAvqswdbUNAEmKtUyt0OYXBoNfhoE7C41CD58stSLd
         EdhpkBMYUwUQXV6cbbLcNBih+fcr185AB0hG1BA39o4Vd51y5tF88TgZlgvOsMEFHlHJ
         m9ckLBgVz5LfcR8lLlbMnPR+nDHN39TYsAnwLnj9A3Nqirp8qF0CLtCTc0zGNexk69wk
         8Pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxhlptpfYO3EujChuPs4BU0yxntxMygMPmEH4FKDgwM=;
        b=bB1MHx4PzTRz8fGIDgpPZ/7E3w/D9JjHoYkbI6/Qaxmg2UwR3uigVt0xaLsJcyuBaL
         G+HYGSg8IvkSGuaNeSKvMaRZx5Fz0OjWy9XcphuGlHFI5Cagbrf4SzPrklqc4CMm7K1k
         22iBS6Izt9OJCtOgPUd+86D6M27PLSJF9GnSEbnQRGAFoXI4cH3nqYZcGo6JDrW6lyFe
         L+4Pw7vWUZui8t62CnffDK5BSAz5678BG7v0pBhrMsWsegGF4DmQgKME9A0Xo5eCatQU
         2vC/0h8u4mtBrxbIU0KzL7A76McWCRPLAInVKoOkaFfUKINRpxryGABja2HNc45FaWJX
         CvDg==
X-Gm-Message-State: ANoB5pmIf+yjeADNfxZNQCcF6P9PwKg9hfu2wdfDHNWo8OcWvCcsuihz
        khZ0gSVSRvj/GyD2hhecLirM
X-Google-Smtp-Source: AA0mqf5wjsqXYNjAcT5w9GT/fre9PbSbATlLpV5op7QW/7Sw60mfW81tmGzIYp1jauO14yuXuA5+qg==
X-Received: by 2002:a17:90a:1d5:b0:219:55d5:f30e with SMTP id 21-20020a17090a01d500b0021955d5f30emr19159944pjd.107.1670011878337;
        Fri, 02 Dec 2022 12:11:18 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id z32-20020a17090a6d2300b002190eabb890sm6959930pjj.25.2022.12.02.12.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 12:11:18 -0800 (PST)
Message-ID: <e0c876db-a230-dfa4-f4e1-5296ffe62c37@github.com>
Date:   Fri, 2 Dec 2022 12:11:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: What's cooking in git.git (Dec 2022, #01; Thu, 1)
Content-Language: en-US
To:     =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqr0xjs46r.fsf@gitster.g>
 <c489ad32-1308-06c9-0c92-6e39d1f82a4b@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <c489ad32-1308-06c9-0c92-6e39d1f82a4b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo wrote:
> On 01-dic-2022 21:23:40, Junio C Hamano wrote:
>> * rj/branch-copy-and-rename (2022-11-17) 2 commits
>>  - branch: clear target branch configuration before copying or renaming
>>  - branch: force-copy a branch to itself via @{-1} is a no-op
>> 
>>  Fix a pair of bugs in 'git branch'.
>>  
>>  Waiting for review discussion to settle.
>>  source: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
>> 
>                                                                                                                                                                                                     
> We can drop the first commit (branch: clear target branch configuration
> before copying or renaming) as it needs a better approach.  But we can
> keep the other (branch: force-copy a branch to itself via @{-1} is a
> no-op), there were no complaints about it, I think.

Agreed. I think "branch: clear target branch configuration before copying or
renaming" is probably worth revisiting at some point, but "branch:
force-copy a branch to itself via @{-1} is a no-op" looks fine to be as-is.

Thanks!

>                                                                                                                                                                                                     
> Un saludo.
> Rubén.     

P.S. I think there may be something strange about your email editor. For
some reason, every line is padded out with spaces to 200 characters. Not a
big deal, but your replies might render with unexpected line spacing in some
email clients.

