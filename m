Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3472CC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 22:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiLBWBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 17:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiLBWBw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 17:01:52 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77976F8889
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 14:01:49 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y16so9872679wrm.2
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 14:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQRdVnzO2Mzc1h3vmiz61QvQd6DCR0pMb1nQWxgmFpU=;
        b=dcU8cvWNqqKDFMIhLUcZxk19O6J0WwrWTkpEinEVU6BJWFMkEiO3F5HDD2uABzLiE4
         lnajilaH+l7bEU2OkRGAInfI17jnUSuq7S6wqwTbrHAOUKRsy3eYPmUEpK5T3nsIu/T8
         j7WTo7DULm69EirzTQyA7fmucMxvXaMV7C4R/C3N57u7z6fTPH6NHR6wJEuU26L44AIh
         V6J+CnJo49tJcMzzYcjyzRY17De0lyDdOl9cm4UT1u3UT4FzTPdaHK64+xY9jhyWqmUP
         unfp42XZEDkbpwK4PhzKOJ6cKFeTVa4ksQrU8BBnz+O71RX7QqgdZl/4UOeysTsK6dN3
         IX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQRdVnzO2Mzc1h3vmiz61QvQd6DCR0pMb1nQWxgmFpU=;
        b=yJU/TuNJzsU+3gRMcFSiu5o+w9s6ehYEYvin2oSeOh4zrTG1B8Qboy33R3y/39kr0M
         awgiU4MwKlpMQPefPi7t7hgKldNSLzWP+U1Jua+89ZzTsQUwOQ4X5l350/uQtAM4ElXd
         NhESLfcpiZcAmafnWh8CG02iCAEPA+D1F4f1dVAGYEYdk6/UTWfRqaX6g3+zGD4nmly3
         iRYBN7AfZQJ5rd8Y4MPhN/qpRPFtuhjZ8VAGbcdja21J99hfsIj2RG9X5A5vn1bi9JCx
         53rHgqVskDqd8LeKiwXLhMmvlXpc/vg2PLn4X32vyV9csf1daBVBC5DcDIc8cxYLW2rg
         I7kQ==
X-Gm-Message-State: ANoB5pn1wNAisQ82BWO/q+xb6GFm/5p5YdRTTty+0Ky0wm76CLSdxM3W
        +578at9mwkBTkUwKWBzz946WfgqFJoY=
X-Google-Smtp-Source: AA0mqf62/wqDlUPQbFnptKbWGilr1Z96awv4gD2OlSoT1LuIYzD7r67bF8z+ft17QPEtRQ6BEUhKnw==
X-Received: by 2002:adf:e54a:0:b0:242:1b67:7a73 with SMTP id z10-20020adfe54a000000b002421b677a73mr15460419wrm.333.1670018507869;
        Fri, 02 Dec 2022 14:01:47 -0800 (PST)
Received: from [192.168.2.52] (203.red-88-14-63.dynamicip.rima-tde.net. [88.14.63.203])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d5649000000b0022cdeba3f83sm7804103wrw.84.2022.12.02.14.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 14:01:47 -0800 (PST)
Subject: Re: What's cooking in git.git (Dec 2022, #01; Thu, 1)
To:     Victoria Dye <vdye@github.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <xmqqr0xjs46r.fsf@gitster.g>
 <c489ad32-1308-06c9-0c92-6e39d1f82a4b@gmail.com>
 <e0c876db-a230-dfa4-f4e1-5296ffe62c37@github.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <a0237e20-a9fc-0265-c0ab-a9d5373a3547@gmail.com>
Date:   Fri, 2 Dec 2022 23:01:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e0c876db-a230-dfa4-f4e1-5296ffe62c37@github.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/12/22 21:11, Victoria Dye wrote:> Rubén Justo wrote:
>> On 01-dic-2022 21:23:40, Junio C Hamano wrote:
>>> * rj/branch-copy-and-rename (2022-11-17) 2 commits
>>>  - branch: clear target branch configuration before copying or renaming
>>>  - branch: force-copy a branch to itself via @{-1} is a no-op
>>>
>>>  Fix a pair of bugs in 'git branch'.
>>>  
>>>  Waiting for review discussion to settle.
>>>  source: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
>>>
>> 
>> We can drop the first commit (branch: clear target branch configuration
>> before copying or renaming) as it needs a better approach.  But we can
>> keep the other (branch: force-copy a branch to itself via @{-1} is a
>> no-op), there were no complaints about it, I think.
> 
> Agreed. I think "branch: clear target branch configuration before copying or
> renaming" is probably worth revisiting at some point, but "branch:
> force-copy a branch to itself via @{-1} is a no-op" looks fine to be as-is.
> 
> Thanks!

Thank you.

> 
>> 
>> Un saludo.
>> Rubén.
> 
> P.S. I think there may be something strange about your email editor. For
> some reason, every line is padded out with spaces to 200 characters. Not a
> big deal, but your replies might render with unexpected line spacing in some
> email clients.
> 

Sorry. I edited in another box and copied directly from the window.
Thanks for notifying.
