Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FF8C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 16:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiLBQla (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 11:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiLBQl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 11:41:29 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473F5BEC76
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 08:41:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m14so8624461wrh.7
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 08:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7yxW/518JHF4m3EMmCZPX8c7sidwmG1d8TPCupONuZQ=;
        b=KcCsu/Ix0IFXRuRV9pHFXOR+1BlBsqO3MAntQnY/MIFHMsLlia7xMZcMHIBMTS+tDK
         W6tCfq7F000RDr06d8J/gfaHso9bJhRr7wdteAHxHaWUeL9HcNqmu1BnDE6Bdh0LAFNq
         Wiyq949BDQ+jNQhXPxQqG1T/nHOUZiUBx9nhUJzCwmfpvbTZUmMM8hpDslvTnOag9sC/
         3YBw8V/noyE2g29NXnaOGF9Yh138ZttKG+bN4BSccoecOfWD2TxzIsz/U7WSAaLvuH4j
         +RUbGMgVpVl3XE+YnNt5hyJx0PQJ8X0jeLHLS6NNOSK1iD884C4H31tVJPL0dJsn0ias
         qiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yxW/518JHF4m3EMmCZPX8c7sidwmG1d8TPCupONuZQ=;
        b=QBdieoGIFTQtNY/lGD02A3FDbbvob0EAZUzX7ojqwpjqt4/yOZmNX+2/Cr3Mrj5kPJ
         Nrt/Th7frzm1gIRleMcmqSFAyFlG18Ynf7LV2Ixfoyt4R3RBWxBcRdb6NJ1DzdhRgwVN
         tK43eseAaanFbZYaDHUvQOoGz4zNwD3B44aqvnIy0wFBMWcAe8r0ymi7ZUrsLwKS/xqS
         ujXDq86Xp0bSc56vnCagg4znnK/fZa9Yz5/YNlMx3xwauX5KODPOAIAnYOo/kfer8E2i
         XfNbBHFJ3gbo0ZGftGWwz6xAbwvWpmYr/+shdbiKlw+jD7QZtuN9/2zR8ynV/oNuKRWz
         X3mw==
X-Gm-Message-State: ANoB5pl+mL/0pqS/GB5kgsM73Bnpf9AyiyDFDykg7MFWZA8XzDmHnYsX
        35z0gHt1hNrH2g/UiWUTc38BiHpMbTY=
X-Google-Smtp-Source: AA0mqf4fHuSvWm0buX8BnSpxdqUq8hhsP13y1qlZsYeZkPucO6c/oTOK7yPa80CGgazp/B7MBavipA==
X-Received: by 2002:adf:fa12:0:b0:242:1c:7507 with SMTP id m18-20020adffa12000000b00242001c7507mr25265699wrr.42.1669999286716;
        Fri, 02 Dec 2022 08:41:26 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d6b0f000000b002421ed1d8c8sm7248482wrw.103.2022.12.02.08.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 08:41:26 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <75e00d43-3184-dcf8-4621-cdf02c9f7320@dunelm.org.uk>
Date:   Fri, 2 Dec 2022 16:41:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git cherry-pick -x: missing blank line before the "cherry picked
 from commit" line
Content-Language: en-US
To:     Vincent Lefevre <vincent@vinc17.net>, git@vger.kernel.org
References: <20221202141153.GA5599@cventin.lip.ens-lyon.fr>
In-Reply-To: <20221202141153.GA5599@cventin.lip.ens-lyon.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vincent

On 02/12/2022 14:11, Vincent Lefevre wrote:
> With git 2.38.1 under Debian, when I use "git cherry-pick -x"
> on a commit such that the last line of the log message starts
> with "note:" (case insensitively), the blank line before the
> "cherry picked from commit" line is missing.
> 
> For instance:
> 
>      New commit
>      
>      foo
>      
>      nOtE:
>      (cherry picked from commit 3ba643e2eec4bdc1cd46b478ab36ee0707d241c2)

"git cherry-pick -x" takes care not to add a blank line if there are 
trailers such as Signed-off-by: at the end of the message (if it did 
then the trailers would no longer be recognized as trailers as they 
would not be the last paragraph). In this case the "nOtE:" line looks 
like a trailer and so no blank line is added.

I can see it is annoying in this case but I'm afraid I don't have any 
ideas of how we could avoid it without breaking the case where the 
message does contain trailers.

Best Wishes

Phillip

> and
> 
>      New commit
>      
>      Note: foo.
>      (cherry picked from commit d0e85cdd32e30f78eeb968f275fc3a98899d791e)
> 
> but the following ones are OK:
> 
>      New commit
>      
>      note:
>      foo
>      
>      (cherry picked from commit a0ffae22fd3c94210170a3addcf802804f6ee5f7)
> 
> ----
> 
>      New commit
>      
>      A Note:
>      
>      (cherry picked from commit 0a89e0e7f8be3063803b0ad4381cd848ec52dd39)
> 
> ----
> 
>      New commit
>      
>      Note
>      
>      (cherry picked from commit f217bd5069c9d66a8ca54c869919ff484a18d20c)
> 
> ----
> 
> I also had reported the bug in the Debian BTS:
> 
>    https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1025155
> 
